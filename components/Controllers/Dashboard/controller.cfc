component displayName="DashboardController" output="true" hint="" {

/******
 * Index
 * 
 *
 * 
 * 
 * 
******/

this.metaData           = {};
this.metaData.Dashboard = {};

    //   **********************************************************************  
    //   *  Dashboard aka At A Glance Page - START                               
    //   **********************************************************************  


        public void function Dashboard_Dashboard_RETRIEVE( required struct urlData ){


            try{

                //Queries 
                var sitesQuery                          = queryNew( '' );

                //Strings
                var query                               = '';

                //struct
                var resultStruct                        = {};
                var dataPayload                         = {};

                //Arrays
                var supporTickets[ 'supporTickets' ]    = {};


                if( !len( session.adminPanel.user.site ) || !session.adminPanel.user.ownedSites ){

                    saveContent variable='query'{

                        if( lcase( session.login.userType ) == 'admin' ){
    
                            writeOutput(
                                "
                                        SELECT DISTINCT entryPointCode, EstablishmentFullName, EstablishmentCity, EstablishmentState, EstablishmentPhone
                                        FROM entrypoints e
                                            JOIN establishments eep ON eep.establishmentEntryPoint = e.entrypointCode
                                        WHERE eep.establishmentType = 'L'
                                            AND eep.establishmentKey = 0
                                            ORDER BY e.EntryPointCode ASC;
                                "
                            );
                            
                        } else {
    
                            writeOutput(
                                "   
                                    SELECT DISTINCT e.entryPointCode, eep.EstablishmentFullName, eep.EstablishmentCity, eep.EstablishmentState, eep.EstablishmentPhone
                                        FROM entrypoints e
                                            JOIN establishments eep ON eep.establishmentEntryPoint = e.entrypointCode
                                        WHERE eep.establishmentType = 'L'
                                            AND eep.establishmentKey = 0
                                            AND e.entryPointCode IN (
                                                SELECT DISTINCT u.siteID
                                                        FROM users u
                                                        JOIN users u2 ON u.email = u2.email AND u.password = u2.password
                                                        WHERE u.email = :email
                                                        AND 
                                                            (   
                                                                u.userType = 'admin' OR
                                                                u.userType = 'Site'
                                                            )
                                                        ORDER BY u.siteID
                                            )
                                "
                            )
                        }
    
                    }

                    sitesQuery = application.adminPanel.components.site.models.dashboard.Dashboard_Dashboard_READ( query );

                } else {

                    saveContent variable='query'{

                        writeOutput(
                            "
                                SELECT *
                                FROM entrypoints
                                WHERE entrypointCode = #request.siteSelected#
                            "
                        )

                    }

                    sitesQuery = application.adminPanel.components.site.models.dashboard.Dashboard_Dashboard_READ( query );

                }

                if( structKeyExists( sitesQuery.result, 'freshDeskCompanyId' ) ){

                    //Going to move this into its own thing later
                    cfhttp( url='https://bravo.freshdesk.com/api/v2/tickets', method='GET', result='resultStruct' ){
                        cfhttpparam( name='Content-Type',   type='header',  value='Content-Type:application/json' );
                        cfhttpparam( name='Authorization',  type='header',  value='#toBase64( '5LHJSeZSxQ2OFnjs23:X' )#');
                        cfhttpparam( name='company_id',     type='url',     value="#sitesQuery.result.freshDeskCompanyId#" );
                    }

                    resultStruct                    = deserializeJSON( resultStruct[ 'fileContent' ] );
                    dataPayLoad[ 'supporTickets' ]  = resultStruct;

                }

                APPLICATION[ 'adminPanel' ][ 'components' ][ 'site' ][ 'views' ][ 'dashboard' ].Dashboard_Dashboard_VIEW( urlData, sitesQuery.result, dataPayLoad );

            } catch( any e ){

                writeDump( e );

            }

        }
        

    //   **********************************************************************  
    //   *  Dashboard aka At A Glance Page - END                                 
    //   **********************************************************************  


    //  ***********************************************************************
    //  *   Dashboard User Sites - START
    //  ***********************************************************************

        public string function Dashboard_UserSites_RETRIEVE( required struct urlData ){

            //Structs
            var resultStruct    = structNew();

            //STrings
            var queryString     = '';
            var htmlBlob        = '';

            try{

                saveContent variable='queryString'{

                    if( lcase( session.login.userType ) == 'admin' ){

                        writeOutput(
                            "
                                SELECT DISTINCT entryPointCode, EstablishmentFullName, EstablishmentCity, EstablishmentState, EstablishmentPhone
                                FROM entrypoints e
                                    JOIN establishments eep ON eep.establishmentEntryPoint = e.entrypointCode
                                WHERE eep.establishmentType = 'L'
                                    AND eep.establishmentKey = 0
                                    ORDER BY e.EntryPointCode ASC;
                            "
                        );
                        
                    } else {

                        writeOutput(
                            "   
                                SELECT DISTINCT e.entryPointCode, eep.EstablishmentFullName, eep.EstablishmentCity, eep.EstablishmentState, eep.EstablishmentPhone
                                    FROM entrypoints e
                                        JOIN establishments eep ON eep.establishmentEntryPoint = e.entrypointCode
                                    WHERE eep.establishmentType = 'L'
                                        AND eep.establishmentKey = 0
                                        AND e.entryPointCode IN (
                                            SELECT DISTINCT u.siteID
                                                    FROM users u
                                                    JOIN users u2 ON u.email = u2.email AND u.password = u2.password
                                                    WHERE u.email = #session.login.email#
                                                    AND 
                                                        (   
                                                            u.userType = 'admin' OR
                                                            u.userType = 'Site'
                                                        )
                                                    ORDER BY u.siteID
                                        )
                            "
                        )
                    }

                }

                resultStruct = application.adminPanel.components.site.models.dashboard.Dashboard_UserSites_READ( queryString );

                writeOutput(  application.adminPanel.components.site.views.dashboard.Dashboard_UserSites_VIEW( urlData, resultStruct.result, false ) );


            } catch( any e ){

                writeDump( e );

            }


        }

        public void function Dashboard_UserSites_PROCESS( required struct formData ){

            try{

                //Structs
                var resultStruct    = {};
                var jsonStruct      = application.adminPanel.components.utility.dataStructures.DataStructure_JSONStruct_GENERATE();

                //arrays
                var booleanArray    = application.adminPanel.components.utility.dataStructures.DataStructure_BooleanArray_GENERATE();

                //strings
                var key             = '';

                saveContent variable='queryString'{

                    writeOutput(
                        "
                            SELECT * 
                            FROM entrypoints
                            WHERE entryPointCode = #formData.siteID#
                            
                        "
                    );                                            

                }

                resultStruct  = APPLICATION[ 'adminPanel' ][ 'components' ][ 'site' ][ 'models' ][ 'dashboard' ].Dashboard_UserSites_READ( queryString );
               
                jsonStruct[ 'onFailure' ][ 'message' ] = [

                    'There was an issue validating your login, please try again later or contact our support team.'

                ];

                jsonStruct[ 'onFailure' ][ 'status' ] = [

                    'failure'

                ];
                
                for( key in jsonStruct[ 'onFailure' ][ 'message' ] ){

                    arrayAppend( jsonStruct[ 'onSuccess' ][ 'message' ], 'Welcome to the admin panel' );
                    arrayAppend( jsonStruct[ 'onSuccess' ][ 'status' ], 'success' ); 

                }


                booleanArray[ 1 ][ 'locationOnSuccess' ] = application.adminPanel.components.utility.strings.Strings_GeneratePageHref_TASK( 'dashboard' );

                //writeDump( local ) abort;

                application.adminPanel.components.utility.hydras.Hydra_Basic_TASK( formData, resultStruct, booleanArray, 1, jsonStruct );

            } catch( any e ){

                var errorStruct = {};
                errorStruct[ 'cfcatch' ]    = e;
                errorStruct[ 'arguments' ]  = arguments;
                errorStruct[ 'success' ]    = false;

                writeDump( e );

                application.adminPanel.components.utility.hydras.Hydra_Basic_TASK( formData, errorStruct, booleanArray, 1, jsonStruct );

            }


        }

    //  ***********************************************************************
    //  *   Dashboard User Sites  - END 
    //  ***********************************************************************


    // ************************************************************************
    // *   Dashboard RightSideBar - START
    // ************************************************************************

        public void function Dashboard_RightSideBarPage_RETRIEVE( required struct urlData, boolean debug ){

            try{

                application.adminPanel.components.site.views.dashboard.Dashboard_RightSideBarPage_VIEW( urlData );

            } catch( any e ){

                writeDump( e );

            }

        }

    // ************************************************************************
    // *   Dashboard RightSideBar - END 
    // ************************************************************************


    public string function Dashboard_Hello_World_RETRIEVE( required struct urlData ){


        try{

            application.adminPanel.components.site.views.dashboard.Dashboard_Hello_World_VIEW( urlData, false );


        } catch( any e ){

            writeDump( e );

        }


    }

}