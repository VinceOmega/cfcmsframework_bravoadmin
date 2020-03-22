component dislayName="bravoAdminApplicationFile" output=true hint=""{

    this.name                                   = 'bravoAdminPanel';
    this.appName                                = 'bravoAdminPanel'; //For backwards compatability
    this.serialization.serializeQueryAs         = 'struct';
    this.scopes                                 = [ 'application', 'server', 'session', 'cookie', 'request', 'local', 'variables', 'arguments', 'cgi', 'this', 'client' ];
    this.mobileUAStrings                        = [ 'android', 'iphone' ];
    this.VTappInstallProjectEntryPoint          = 284;
    this.applicationTimeout                     = createTimeSpan( 0, 0, 3, 0 );
    this.rootDir                                = getDirectoryFromPath( getCurrentTemplatePath( ) );
    this.javaSettings                           = {  
                                                    loadPaths = [ expandPath('.\java\vendor\jsoup.jar') ],
                                                    loadColdFusionClassPath: true
                                                        
    };

    this.mappings                               = structNew();
    
    this.mappings[ '/adminScripts' ]            = directoryExists( 'C:/web/Bravo/admin.MyPlumbingShowroom.com/' )   ? 'C:/web/Bravo/admin.MyPlumbingShowroom.com/' : this[ 'rootDir' ];
    this.mappings[ '/bootScripts' ]             = directoryExists( 'C:/web/Bravo/boot4.myplumbingshowroom.com' )    ? 'C:/web/Bravo/boot4.myplumbingshowroom.com' : this[ 'rootDir' ];
    this.mappings[ '/Bravo' ]                   = directoryExists( 'C:/web/Bravo/' )                                ? 'C:/web/Bravo/' : this[ 'rootDir' ];
    this.mappings[ '/customScriptsBravo' ]      = directoryExists( 'C:/web/CustomScripts/' )                        ? 'C:/web/CustomScripts/' : this[ 'rootDir' ];
    this.mappings[ '/mpsScripts' ]              = directoryExists( 'C:/web/CustomScripts/MyPlumbingShowroom' )      ? 'C:/web/CustomScripts/MyPlumbingShowroom' : this[ 'rootDir' ];
    this.mappings[ '/web' ]                     = directoryExists( 'C:/web/' )                                      ? 'C:/web/' : this[ 'rootDir' ];
    
    this.sessionManagement                      = true;
    this.sessionTimeout                         = CreateTimeSpan( 0, 2, 0, 0 );
    this.siteOn                                 = true;
    this.bufferOutput                           = true;
    this.directories                            = [ 'errors', 'auth, dashboard' ];
    this.routes                                 = [ 'chrome', 'login', 'auth', 'dashboard', 'admin', 'analytics', 'catalog', 'inventory', 'site', 'users', 'wishlist' ];
    this.invalidPanelRoutes                     = 'chrome,login,solr';
    this.appConfig                              = { '0': '/config/application/local.cfm', '1':'/config/application/production.cfm', '2':'/config/application/production.cfm', '3':'/config/application/production.cfm', '4':'/config/application/dev.cfm' };
    this.serverConfig                           = { '0': '/config/server/local.cfm', '1':'/config/server/production.cfm', '2':'/config/server/production.cfm', '3':'/config/server/production.cfm', '4':'/config/server/dev.cfm' };
    this.debug                                  = false;
	this.checkAppVars                           = queryNew('');
    this.configComponentsForAppVars 			= createObject( 'config.components.appVarsMethods' );
    this.configComponentsForServerVars          = createObject( 'config.components.serverVarsMethods' );
    this.configComponentsForMetaData            = createObject( 'config.components.metaDataMethods' );
    this.configComponentsForSessionVars         = {}; //placeholder for session vars


    public boolean function onApplicationStart(){
     
        //uncomment this to force the application to stop
        //applicationStop(); abort;

        if( this[ 'siteOn' ] ){

            //get serverID variable

            include "/web/serverID.cfm";

            if( this.debug ){
                writeDump( var="#serverID#", label='serverID' );
            }
    
            //check for existance, if it doesn't exists then we are probably on a dev's local maachine
			serverID = serverID?: 0;
			
			//store the ID in the application scope
			application.serverID = serverID;

            application.VTappInstallProjectEntryPoint = this.VTappInstallProjectEntryPoint;
    
            //load up the correct config
            include this.appConfig[ serverID ];
            include this.serverConfig[ serverID ];
            
            //Set app vars flag to 0 for this server
            //this.checkAppVars = variables.resetAppVarsFlag();

            //this.checkAgainstAppVarsFlagRebuild = variables.checkAgainstAppVarsFlagRebuild();

            if( this.debug ){
                writeDump( application )
            }

            //Build our components
            this.buildComponentSets();

            //invoke Jsoup
            application[ 'errorpanel' ][ 'java' ][ 'jSoup' ] = createObject( "java", "org.jsoup.Jsoup" );

            //Build the navigation struct
            application[ 'errorpanel' ][ 'metaData' ]           = {};
            application[ 'errorpanel' ][ 'metaData' ]           = variables.createNavObject( application.errorPanel.components.site.controllers );
            application[ 'errorpanel' ][ 'siteLookUpById' ]     = variables.buildSiteLookUpStruct();
            application[ 'errorpanel' ][ 'userLookUpById' ]     = variables.buildUserLookUpStruct();


            //Insert href path for pages
            variables.buildHrefForPages();


            //Create a pages.json file based on the pages struct generated by createNavObject function.
            if( !fileExists( expandPath( '/config/metaData/pages.json' ) ) ){
                fileWrite( expandPath( '/config/metaData/pages.json' ), '' );
            }
            
            fileWrite( expandPath( '/config/metaData/pages.json' ), serializeJSON( application.errorPanel.metaData.pages ) );


            //Let this be defined last
            APPLICATION.EntryPoint = '0';

            return true;

        } else {

            return false;

        }
           
    }

    public function onSessionStart(){

        SESSION[ 'languageID' ]                                 = SESSION[ 'languageID' ]?:0;
        SESSION[ 'mobileStatus' ]                               = SESSION[ 'mobileStatus' ]?:false;

        for( uaAgent in this.mobileUAStrings ){

            if( findNoCase( uaAgent, session.mobileStatus, 1 ) ){

                SESSION[ 'mobileStatus' ]                       = SESSION[ 'mobileStatus' ]?: true;

            }
            
        }

        SESSION[ 'adminPanel' ]                                 = SESSION[ 'adminPanel' ]?:{};
        SESSION[ 'adminPanel' ][ 'user' ]                       = SESSION[ 'adminPanel' ][ 'user' ]?:{};
        SESSION[ 'adminPanel' ][ 'user' ][ 'loggedIn' ]         = SESSION[ 'adminPanel' ][ 'user' ][ 'loggedIn' ]?:false;
        SESSION[ 'adminPanel' ][ 'user' ][ 'site' ]             = SESSION[ 'adminPanel' ][ 'user' ][ 'site' ]?:'';
        SESSION[ 'adminPanel' ][ 'user' ][ 'siteName' ]         = SESSION[ 'adminPanel' ][ 'user' ][ 'siteName' ]?:'';
        SESSION[ 'adminpanel' ][ 'user' ][ 'lastVisited' ]      = SESSION[ 'adminpanel' ][ 'user' ][ 'lastVisited' ]?:'';
        SESSION[ 'adminPanel' ][ 'user' ][ 'ownedSites' ]       = SESSION[ 'adminPanel' ][ 'user' ][ 'ownedSites' ]?:0;

        SESSION[ 'login' ]                                      = SESSION[ 'login' ]?:{};
        SESSION[ 'login' ][ 'loggedIn' ]                        = SESSION[ 'login' ][ 'loggedIn' ]?:false;

        SESSION[ 'growl' ]                                      = SESSION[ 'growl' ]?:{};
        SESSION[ 'growl' ][ 'message' ]                         = SESSION[ 'growl' ][ 'message' ]?:[];
        SESSION[ 'growl' ][ 'status' ]                          = SESSION[ 'growl' ][ 'status' ]?:[];

    }

    public function onSessionEnd(){

        application.errorPanel.components.utility.sessionManager.SessionManager_DestoryUserSession_TASK();
         
        location( url=application.errorPanel.components.utility.strings.Strings_GeneratePageHref_TASK( 'signin' ), addtoken=false);

    }

    //This function can be used to filter the page doing a request
    public function onRequest( currentPage ){

        try{

            variables.buildRequestScope( URL );

            variables.resetScope( URL );

            variables.cfDump( URL );

            setting showdebugoutput= ( structKeyExists( URL, 'debug' ) && isBoolean( URL[ 'debug' ] ) && URL[ 'debug' ] ) ? true : false ;

            include arguments.currentPage;


        } catch( any e ){

            writeDump( e );

        }

    }

    public function onRequestStart(){

        //If we are in dev or local envs, then we need to rebuild components everytime.

        if( application.serverID == 0 || application.serverID == 4 ){

            this.buildComponentSets();


        }

        //Changed scope var to SESSION[ 'adminPanel' ][ 'user' ]
        if( structKeyExists( SESSION, 'adminPanel' ) && structKeyExists( SESSION[ 'adminPanel' ], 'user' ) && structKeyExists( SESSION[ 'adminPanel' ][ 'user' ], 'loggedIn' ) && SESSION[ 'adminPanel' ][ 'user' ][ 'loggedIn' ] && structKeyExists( URL, 'dir' ) &&  URL[ 'dir' ] == 'adminpanel'  &&  arrayFind( this.directories, URL[ 'dir' ] ) ){

            APPLICATION[ 'inPanel' ] = true;

        } else {

            APPLICATION[ 'inPanel' ] = false;

        }




    }

    public function onRequestEnd(){

        if( application[ 'inPanel' ] ){

            if( 
                    structKeyExists( session.adminPanel.user, 'lastVisited' ) && 
                    len( session.adminPanel.user.lastVisited ) && 
                    structKeyExists( request, 'currentPage' ) && 
                    len( request.currentPage ) 
                ){
                    session.adminPanel.user.lastVisited = request.currentPage;

            } else {

                session.adminPanel.user.lastVisited = application.errorPanel.components.utility.strings.Strings_GeneratePageHref_TASK( 'dashboard' );

            }

        }

        this.yield              = '';
        this.warning            = '';
        this.securityCheck      = '';

    }

    public function onApplicationEnd( application ){

        writeDump( application );

    }

    public function onError( e ){

        writeDump( e );

    }

    public void function buildComponentSets(){

        //Check for existance, if it doesn't exists -> make it!
        application[ 'errorpanel' ][ 'components' ]?: structInsert( application[ 'errorpanel' ], 'components', structNew() );

        //load up components for pages and utilities, store them into the admin panel struct
        application[ 'errorpanel' ][ 'components' ][ 'site' ]?:     structInsert( application[ 'errorpanel' ][ 'components' ], 'site',      variables.createSiteMVCComponents() );
        application[ 'errorpanel' ][ 'components' ][ 'utility' ]?:  structInsert( application[ 'errorpanel' ][ 'components' ], 'utility',   variables.createSiteUtilityComponents() );

    }

    private struct function createSiteMVCComponents(){

        //structs
        var directoryStruct         = {};
        var returnStruct            = {};

        //strings
        var path                    = '';
        var subpath                 = '';
        var topLevelKeys            = '';
        var subLevelKeys            = '';
        var componentKeys           = '';
        var componentsPath          = '';
        var validTLKeys             = 'Controllers,Models,Views';

        //array
        var pathArray               = [];
        var subPathArray            = [];

        //boolean
        var debug                   = false;

        directoryStruct = directoryList( expandPath( './components' ) );

        for( path in directoryStruct ){

            pathArray = listToArray( path, '\' );

            if( listFind( validTLKeys, pathArray[ arrayLen( pathArray ) ] ) ){

                structInsert( returnStruct, pathArray[ arrayLen( pathArray ) ], structNew() );

                for( subpath in directoryList( path ) ){

                    subPathArray    = listToArray( subpath, '\' );
                    componentsPath  = 'components' & '.' & pathArray[ arrayLen( pathArray ) ] & '.' & subpathArray[ arrayLen( subpathArray ) ] & '.' & lCase( removeChars( pathArray[ arrayLen( pathArray ) ] , len( pathArray[ arrayLen( pathArray ) ] ) , 1 ) );
                    
                    if( debug ){
                        writeDump( componentsPath );
                    }

                    structInsert( returnStruct[ pathArray[ arrayLen( pathArray ) ] ], subpathArray[ arrayLen( subpathArray ) ], createObject( 'component', componentsPath ) );

                }

            }

        }

        if( debug ){
            writeDump( returnStruct );
        }

        return returnStruct;

    }


    private struct function createSiteUtilityComponents(){

        //structs
        var directoryStruct         = {};
        var returnStruct            = {};

        //strings
        var path                    = '';
        var topLevelKeys            = '';
        var componentKeys           = '';
        var componentsPath          = '';

        //array
        var pathArray               = [];

        //boolean               
        var debug                   = false;

        directoryStruct = directoryList( expandPath( './utilities' ) );

        for( path in directoryStruct ){

            pathArray = listToArray( path, '\' );

            componentsPath  = 'utilities' & '.' & removeChars( pathArray[ arrayLen( pathArray ) ] , len( pathArray[ arrayLen( pathArray ) ] ) -3 , 4 );

            if( debug ){
                writeDump( componentsPath );
            }

            structInsert( returnStruct, lCase( removeChars( pathArray[ arrayLen( pathArray ) ] , len( pathArray[ arrayLen( pathArray ) ] ) -3 , 4 ) ), createObject( 'component', componentsPath ) );

        }

        if( debug ){
            writeDump( returnStruct );
        }

        return returnStruct;

    }

    private struct function createNavObject( components ){

        //Structs
        var resultStruct                = {};
        resultStruct[ 'navigation' ]    = {};
        resultStruct[ 'pages' ]         = {};

        //Strings
        var key                         = '';
        var sections                    = '';

        structInsert( resultStruct, 'pages', this.configComponentsForMetaData.getPagesInMetaData( ), true );

        for( key in components ){

            if( structKeyExists( components[ key ], 'metaData' ) ){
            
                for( sections in components[ key ].metaData ){

                    for( pages in sections ){
                    
                        structInsert( resultStruct[ 'navigation' ], sections, this.configComponentsForMetaData.getRouteInMetaData( sections ) );

                    }

                       if( this.debug ){ writeDump( getMetaData( components[ key ] ) ) };

                }

            }

        }
        
        return resultStruct;

    }

    private void function buildHrefForPages(){

        for( key in application[ 'errorpanel' ][ 'metaData' ][ 'pages' ] ){

            structInsert( application[ 'errorpanel' ][ 'metaData' ][ 'pages' ][ key ], 'href', application.errorPanel.components.utility.strings.Strings_GeneratePageHref_TASK( application[ 'errorpanel' ][ 'metaData' ][ 'pages' ][ key ].alias ) );


        }

        for( sections in application[ 'errorpanel' ][ 'metaData' ][ 'navigation' ] ){

            for( key in application[ 'errorpanel' ][ 'metaData' ][ 'navigation' ][ sections ] ){

                if( this.debug ){
                    writeDump( application[ 'errorpanel' ][ 'metaData' ][ 'navigation' ][ sections ][ key ] )
                }

                if( isStruct( application[ 'errorpanel' ][ 'metaData' ][ 'navigation' ][ sections ][ key ] ) ){

                    structInsert( application[ 'errorpanel' ][ 'metaData' ][ 'navigation' ][ sections ][ key ], 'href', application.errorPanel.components.utility.strings.Strings_GeneratePageHref_TASK( application[ 'errorpanel' ][ 'metaData' ][ 'navigation' ][ sections ][ key ].alias )   );

                }

            }

        }

    }


    private void function resetScope( required struct urlData ){

        //Structs
		var app = {};

		//Strings
        var key = '';
                
        if( structKeyExists( urlData, 'reset' ) ){

            switch( urlData.reset ){

                case 'application':

                    applicationStop();

                    break;

                case 'session':

                    lock scope="Session" timeout="10" type="exclusive"{
                        structclear(session);
                    }

                    app = createObject( 'component', 'Application' );

                    app.onSessionStart();

                    session.cfid = cookie.cfid;
                    session.cftoken = cookie.cftoken;
                    session.sessionid = app.name & '_' & cookie.cfid & '_' & cookie.cftoken;

                    for( key in cookie ){

                        cookie[ key ] = { value="", expires="now" };

                    }
                               
                    break;

                case 'server':

                    lock scope="server" timeout="5" type="exclusive"{

                        include "/web/serverID.cfm";

                        //check for existance, if it doesn't exists then we are probably on a dev's local maachine
                        serverID = serverID?: 0;                        
                        
                        include this.serverConfig[ serverID ];

                    }

                    break;

            }

        }
        
    }

    private void function cfDump( required struct urlData ){

        if( structKeyExists( urlData, 'cfDumpScope' ) ){

            switch( urlData.cfDumpScope ){

                case 'all':

                    for( key in this.scopes ){

                        writeDump( var="#evaluate( key )#", label=key );

                    }

                    break;

                default:

                    writeDump( var="#evaluate( trim( urlData.cfDumpScope ) )#", label=lcase( urlData.cfDumpScope ) );

                    break;

            }

            abort;

        }

    }

    private void function buildRequestScope( required struct urlData ){

        //strings
        var key             = '';

        //numerics
        var i               = 1;

        //array     
        var urlQueryArray   = '';

        //struct
        var pseudoURLScope  = {};

        //Split the query by key:value using ampsands as delimiters.
        urlQueryArray = listToArray( cgi.query_string, '&' );

        //construct fake url scope, we are doing this because we don't have access to the htaccess translated url onRequestStart
        for( key in urlQueryArray ){

            pseudoURLScope[ reReplaceNoCase( key, '(.*)=.*', '\1' ) ] = reReplaceNoCase( key, '.*=(.*)', '\1' );

        }

        if( structKeyExists( pseudoURLScope, 'dir' ) && pseudoURLScope[ 'dir' ] == 'adminpanel' ){

            request.currentPage = '/' & pseudoURLScope.dir & '/' & pseudoURLScope.route & '/' & pseudoURLScope.page;

            for( key in urlData ){

                if( !listFind( 'dir,page,route', key ) ){
                    request.currentPage = ( i > 1 ) ? request.currentPage & '&' & key & '=' & urlData[ key ] : request.currentPage & '?' & key & '=' & urlData[ key ];
                    i++;
                }

            }

        }

        request.siteSelected = ( 

            structKeyExists( session, 'adminPanel' ) &&
            structKeyExists( session[ 'adminPanel' ], 'user' ) &&
            structKeyExists( session[ 'adminPanel' ][ 'user' ], 'site' ) &&
            len( session.adminPanel.user.site ) &&
            isNumeric( session.adminPanel.user.site ) 
            
        ) ? session.adminPanel.user.site : application.entryPoint;

        request.mobileStatus = false;
    

    }


    private struct function buildSiteLookUpStruct(){


        try{

            //numeric
            var idx = 1;

            //struct
            var siteLookupByIdStruct = {};

            for( idx; idx <= APPLICATION[ 'SiteNameAndId' ].recordCount; idx++ ){

                structInsert( siteLookupByIdStruct, APPLICATION[ 'SiteNameAndId' ][ 'EntryPointCode' ][ idx ], APPLICATION[ 'SiteNameAndId' ][ 'EntryPointName' ][ idx ] );

            }


            return siteLookupByIdStruct;


        } catch( any e ){

            writeDump( e );

        }


    }

    private struct function buildUserLookUpStruct(){


        try{

            //numeric
            var idx = 1;

            //struct
            var userLookupByIdStruct = {};

            //arrays
            var strBuffer = [];

            for( idx; idx <= APPLICATION[ 'UserNameAndId' ].recordCount; idx++ ){

                strBuffer.append( APPLICATION[ 'UserNameAndId' ][ 'fName' ][ idx ] );
                strBuffer.append( " " );
                strBuffer.append( APPLICATION[ 'UserNameAndId' ][ 'lName' ][ idx ]  )

                structInsert( userLookupByIdStruct, APPLICATION[ 'UserNameAndId' ][ 'userId' ][ idx ], arrayToList( strBuffer, "" ) );

                strBuffer = [];

            }


            return userLookupByIdStruct;


        } catch( any e ){

            writeDump( e );

        }

    }

}