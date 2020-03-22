<cfscript>
    /**
    *
    * @name : 'Init'
    * @hint : 'The initialization function for the admin panel'
    * @output: true
    * 
    *
    **/

    private void function Init( required struct URL, required struct FORM ){

        //structs
        var urlData     = application[ 'errorPanel' ][ 'components' ][ 'utility' ][ 'strings' ].Strings_TrimInput_TASK( URL );
        var formData    = application[ 'errorPanel' ][ 'components' ][ 'utility' ][ 'strings' ].Strings_TrimInput_TASK( FORM );

        //strings
        var dir                 = ( structKeyExists( urlData, 'dir' ) && arrayFind( this.directories, urlData[ 'dir' ] ) )                          ? urlData[ 'dir' ]             : 'auth';
        var route               = ( structKeyExists( urlData, 'route' ) && arrayFind( this.routes, urlData[ 'route' ] ) )                           ? urlData[ 'route' ]           : 'chrome';
        var page                = ( structKeyExists( urlData, 'page' ) && urlData[ 'page' ] NEQ '' )                                                ? urlData[ 'page' ]            : '404';
        var processInvoke       = ( !structIsEmpty( formData ) && structKeyExists( formData, 'processInvoke' ) )                                    ? formData[ 'processInvoke' ]  : 'Chrome_processInvokeMissing_PROCESS';
        var ajax                = ( structKeyExists( urlData, 'ajax'  ) && isBoolean( urlData[ 'ajax' ] ) && urlData.ajax )                         ? urlData[ 'ajax' ]            :  false;
        var ajax                = ( structKeyExists( formData, 'ajax'  ) && isBoolean( formData[ 'ajax' ] ) && formData.ajax )                      ? formData[ 'ajax' ]           :  ajax;
        var chromeless          = ( structKeyExists( urlData, 'chromeless'  ) && isBoolean( urlData[ 'chromeless' ] )  && urlData.chromeless )      ? urlData[ 'chromeless' ]      :  false;
        var retrieveInvoke      = route & '_' & application.errorPanel.components.utility.strings.Strings_CleanPageSlug_TASK( page, 'file' ) & '_' & 'RETRIEVE';

        //lists
        var invalidPanelRoutes  = this.invalidPanelRoutes;

        //booleans
        var debug               = false;
        var forceInsidePanel    = false;
        var insideAdminPanel    = APPLICATION[ 'inPanel' ]?: false; //REQUEST[ 'inPanel' ]

        try{
		
		   //writeDump( local ) writeDump( urlData ) writeDump( this ) writeDump( formData );

            if( structIsEmpty( formData ) && !ajax && !chromeless ){

                if( debug ){
                    writeOutput( 'path 1' );
                }

                writeOutput(
                    variables.getView( urlData, dir, route, page, retrieveInvoke, debug, forceInsidePanel, insideAdminPanel, invalidPanelRoutes )
                );
                
            } else if( !structIsEmpty( formData ) && !ajax && !chromeless ) {

                if( debug ){
                    writeOutput( 'path 2' );
                }

                for( key in 'route,dir,page' ){

                    formData[ key ] = urlData[ key ];

                }

                writeOutput(
                    variables.processAction( formData, dir, route, page, processInvoke, debug, forceInsidePanel, insideAdminPanel, invalidPanelRoutes, ajax  )
                );

            } else if ( structIsEmpty( formData ) && !ajax && chromeless ){

                if( debug && 0){
                    writeOutput( 'path 3' );
                }

                writeOutput(
                    variables.getPartialView( urlData, dir, route, page, retrieveInvoke, debug, forceInsidePanel, insideAdminPanel, invalidPanelRoutes )
                );

            } else if( !structIsEmpty( formData ) && ajax && !chromeless ) {

                if( debug ){
                    writeOutput( 'path 4' );
                }

                for( key in 'route,dir,page' ){

                    formData[ key ] = urlData[ key ];

                }

                writeOutput(
                    variables.processAction( formData, dir, route, page, processInvoke, debug, forceInsidePanel, insideAdminPanel, invalidPanelRoutes, ajax  )
                );

            } else if( structIsEmpty( formData ) && ajax && !chromeless  ){

                if( debug ){
                    writeOutput( 'path 5' );
                }


                writeOutput(
                    variables.processAction( urlData, dir, route, page, processInvoke, debug, forceInsidePanel, insideAdminPanel, invalidPanelRoutes, ajax  )
                );

            } else {


            }

        } catch( any e ){

            writeDump( e );

        }


    }

    /**
     * @name : getView
     * @hint : This function prints the page view to the page.
     * @output: true
     * 
     * 
     * 
     * 
     */

    private void function getView( required struct urlData, required string dir, required string route, required string page, required string retrieveInvoke, required boolean debug, required boolean forceInsidePanel, required boolean insideAdminPanel, required string invalidPanelRoutes ){

        //strings
        var htmlBlob = '';

        try{

            if( debug && forceInsidePanel ){

                insideAdminPanel = true;

            } 

            if( arrayFind( this.routes, route ) && !listFind( invalidPanelRoutes, route ) ){

                //generate a htmlBlob
                saveContent variable='htmlBlob'{
                    invoke( application[ 'errorPanel' ][ 'components' ][ 'site' ][ 'controllers' ][ route ], retrieveInvoke, { urlData = urlData } );
                }

                if( insideAdminPanel ){ //admin panel

                    writeOutput( 'insideAdminPanel' ); abort;

                    //Do security rights for page here
                    if( isNumeric( request.siteSelected ) && request.siteSelected ){

                        application[ 'errorPanel' ][ 'components' ][ 'utility' ][ 'htmlElements' ].HTMLELEMENTS_startDocumentFragment_RENDER();
                        application[ 'errorPanel' ][ 'components' ][ 'site' ][ 'controllers' ][ 'chrome' ].Chrome_Header_RETRIEVE( urlData );
                        application[ 'errorPanel' ][ 'components' ][ 'site' ][ 'controllers' ][ 'chrome' ].Chrome_Body_RETRIEVE( urlData, htmlBlob, dir, route, page );
                        application[ 'errorPanel' ][ 'components' ][ 'utility' ][ 'htmlElements' ].HTMLELEMENTS_endDocumentFragment_RENDER();

                    } else {

                        if( route != 'dashboard' && page != 'dashboard' ){

                            location( url=application.errorPanel.components.utility.strings.Strings_GeneratePageHref_TASK( 'dashboard' ), addToken=false );

                        } else {

                            writeOutput( 'not inside control panel' ); abort;

                        
                            application[ 'errorPanel' ][ 'components' ][ 'utility' ][ 'htmlElements' ].HTMLELEMENTS_startDocumentFragment_RENDER();
                            application[ 'errorPanel' ][ 'components' ][ 'site' ][ 'controllers' ][ 'chrome' ].Chrome_Header_RETRIEVE( urlData );
                            application[ 'errorPanel' ][ 'components' ][ 'site' ][ 'controllers' ][ 'chrome' ].Chrome_Body_RETRIEVE( urlData, htmlBlob, dir, route, page );
                            application[ 'errorPanel' ][ 'components' ][ 'utility' ][ 'htmlElements' ].HTMLELEMENTS_endDocumentFragment_RENDER();

                        }

                    }

                } else {

                    //writeOutput( "not inside or we don''t have a panel build" ); abort;

                    application[ 'errorPanel' ][ 'components' ][ 'utility' ][ 'htmlElements' ].HTMLELEMENTS_startDocumentFragment_RENDER();
                    application[ 'errorPanel' ][ 'components' ][ 'site' ][ 'controllers' ][ 'chrome' ].Chrome_Header_RETRIEVE( urlData );
                    application[ 'errorPanel' ][ 'components' ][ 'site' ][ 'controllers' ][ 'chrome' ].Chrome_Body_RETRIEVE( urlData, htmlBlob, dir, route, page );
                    application[ 'errorPanel' ][ 'components' ][ 'utility' ][ 'htmlElements' ].HTMLELEMENTS_endDocumentFragment_RENDER();
                }

            } else {

                //for 404/500 pages

                if( insideAdminPanel ){

 

                    writeOutput( '400 inside control panel' ); abort;

                        //generate a htmlBlob
                    saveContent variable='htmlBlob'{
                        invoke( application[ 'errorPanel' ][ 'components' ][ 'site' ][ 'controllers' ][ route ], retrieveInvoke, { urlData = urlData } );
                    }


                    application[ 'errorPanel' ][ 'components' ][ 'utility' ][ 'htmlElements' ].HTMLELEMENTS_startDocumentFragment_RENDER();
                    application[ 'errorPanel' ][ 'components' ][ 'site' ][ 'controllers' ][ 'chrome' ].Chrome_Header_RETRIEVE( urlData );
                    application[ 'errorPanel' ][ 'components' ][ 'site' ][ 'controllers' ][ 'chrome' ].Chrome_Body_RETRIEVE( urlData, htmlBlob, route, page );
                    application[ 'errorPanel' ][ 'components' ][ 'utility' ][ 'htmlElements' ].HTMLELEMENTS_endDocumentFragment_RENDER();

                } else {

                    writeOutput( '400 not inside control panel' ); abort;

                    //generate a htmlBlob
                    saveContent variable='htmlBlob'{
                        invoke( application[ 'errorPanel' ][ 'components' ][ 'site' ][ 'controllers' ][ route ], retrieveInvoke, { urlData = urlData } );
                    }


                    application[ 'errorPanel' ][ 'components' ][ 'utility' ][ 'htmlElements' ].HTMLELEMENTS_startDocumentFragment_RENDER();
                    application[ 'errorPanel' ][ 'components' ][ 'site' ][ 'controllers' ][ 'chrome' ].Chrome_Header_RETRIEVE( urlData );
                    application[ 'errorPanel' ][ 'components' ][ 'site' ][ 'controllers' ][ 'chrome' ].Chrome_Body_RETRIEVE( urlData, htmlBlob, route, page );
                    application[ 'errorPanel' ][ 'components' ][ 'utility' ][ 'htmlElements' ].HTMLELEMENTS_endDocumentFragment_RENDER(); 

                }

            }

        } catch( any e ){

            writeDump( e );
            abort;

        }
        

    }

    private void function processAction( required struct formData, required string dir, required string route, required string page, required string processInvoke, required boolean debug, required boolean forceInsidePanel, required boolean insideAdminPanel, required string invalidPanelRoutes, required boolean ajax ){

        try{

            formData[ 'page' ] = reReplaceNoCase( processInvoke, '.*\_(.*)\_.*', '\1' );

            //writeDump( formData ); abort;

            if( arrayFind( this.directories, dir ) && arrayFind( this.routes, route ) ){

                if( debug && 0 ){
                    writeDump( application.errorPanel.components.site.controllers[ route ] ) writeDump( processInvoke ) writeDump( formData ) abort;
                }

                invoke( application.errorPanel.components.site.controllers[ route ], processInvoke, { formData=formData, debug=debug } );

            }

        } catch( any e ){

            writeDump( e );

        }

    }

    private void function getPartialView( required struct urlData, required string dir, required string route, required string page, required string retrieveInvoke, required boolean debug, required boolean forceInsidePanel, required boolean insideAdminPanel, required string invalidPanelRoutes ){

        //strings
        var htmlBlob = '';

        urlData[ 'title' ] = 'This is a test';

        try{

            if( debug && forceInsidePanel ){

                insideAdminPanel = true;

            } 

            if( arrayFind( this.routes, route ) && !listFind( invalidPanelRoutes, route ) ){

                //generate a htmlBlob
                saveContent variable='htmlBlob'{
                    invoke( application[ 'errorPanel' ][ 'components' ][ 'site' ][ 'controllers' ][ route ], retrieveInvoke, { urlData = urlData } );
                }

                if( insideAdminPanel ){ //admin panel


                    if( isNumeric( request.siteSelected ) && request.siteSelected ){

                       writeOutput( htmlBlob );

                    } else {

                        if( route != 'dashboard' && page != 'dashboard' ){

                            location( url=application.errorPanel.components.utility.strings.Strings_GeneratePageHref_TASK( 'dashboard' ), addToken=false );

                        } else {
                        
                            writeOutput( htmlBlob );

                        }

                    }

                } 

            } else {

                //for 404/500 pages

                if( insideAdminPanel ){

                    //generate a htmlBlob
                    saveContent variable='htmlBlob'{
                        invoke( application[ 'errorPanel' ][ 'components' ][ 'site' ][ 'controllers' ][ route ], retrieveInvoke, { urlData = urlData } );
                    }

                    writeOutput( htmlBlob );

                } else {

                    //generate a htmlBlob
                    saveContent variable='htmlBlob'{
                        invoke( application[ 'errorPanel' ][ 'components' ][ 'site' ][ 'controllers' ][ route ], retrieveInvoke, { urlData = urlData } );
                    }

                    writeOutput( htmlBlob );

                }

            }

        } catch( any e ){

            writeDump( e );

        }

    }

    VARIABLES.Init( URL, FORM );

</cfscript>