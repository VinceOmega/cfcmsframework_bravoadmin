component displayName="LoginController" output=true hint=""{

    /*****
     * 
     * 
     * 
     * 
     * 
     * ****/


    this.metaData         = {};
    this.metaData.login   = {};

    

    //    **********************************************************************
    //    *  Login Body Containers - START
    //    * ********************************************************************

        public void function Login_Body_RETRIEVE( required struct urlData, required string htmlBlob ){

            //Structs
            this.metaData.login.body = {};

            try{

                this.metaData.login.body = {

                    'isPage': false

                };

                APPLICATION[ 'adminPanel' ][ 'components' ][ 'site' ][ 'views' ][ 'login' ].Login_Body_VIEW( urlData, htmlBlob );

            } catch( any e ){

                writeDump( e );

            }

        }


    //    **********************************************************************
    //    *  Login Body Containers - END
    //    * ********************************************************************


    //    **********************************************************************
    //    *  Signin Page - START
    //    * ********************************************************************

        //   **********************************************************************
        //   **********************************************************************

            public void function Login_Signin_RETRIEVE( required struct urlData ){

                try{

                    APPLICATION[ 'adminPanel' ][ 'components' ][ 'site' ][ 'views' ][ 'login' ].Login_Signin_VIEW( urlData );

                } catch( any e ){

                    writeDump( e );

                }

            }


        //   **********************************************************************
        //   **********************************************************************

        
            // MAIN FUNCTIONS
            
            public void function Login_Signin_PROCESS( required struct formData ){

                try{

                    //Structs
                    var resultStruct    = {};
                    var jsonStruct      = application.adminPanel.components.utility.dataStructures.DataStructure_JSONStruct_GENERATE();

                    //arrays
                    var booleanArray    = application.adminPanel.components.utility.dataStructures.DataStructure_BooleanArray_GENERATE();

                    //strings
                    var key             = '';

                    resultStruct  = APPLICATION[ 'adminPanel' ][ 'components' ][ 'site' ][ 'models' ][ 'login' ].Login_Signin_READ( formData );
                   
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
                    abort;

                    application.adminPanel.components.utility.hydras.Hydra_Basic_TASK( formData, errorStruct, booleanArray, 1, jsonStruct );

                }
                

            }


        //   **********************************************************************
        //   **********************************************************************
        

    //    **********************************************************************
    //    *  Signin Page - START
    //    * ********************************************************************


    //    **********************************************************************
    //    * Signout Page - START
    //    **********************************************************************



            public void function Login_Signout_RETRIEVE( required struct urlData ){

                    try{

                        if( session.adminPanel.user.loggedIn ){
                            APPLICATION[ 'adminPanel' ][ 'components' ][ 'site' ][ 'views' ][ 'login' ].Login_Signout_VIEW( urlData );
                        } else {
                            location( url=application.adminPanel.components.utility.strings.Strings_GeneratePageHref_TASK( 'signin' ), addtoken=false );
                        }

                    } catch( any e ){

                        writeDump( e );

                    }

            }


        //   **********************************************************************
        //   **********************************************************************

        
            // MAIN FUNCTIONS


            public void function Login_Signout_PROCESS( required struct formData, boolean debug ){

                //Structs
                var resultStruct    = {};
                var jsonStruct      = application.adminPanel.components.utility.dataStructures.DataStructure_JSONStruct_GENERATE();

                //arrays
                var booleanArray    = application.adminPanel.components.utility.dataStructures.DataStructure_BooleanArray_GENERATE();

                //strings
                var key             = '';

                try{

                    resultStruct = application.adminPanel.components.site.models.Login.Login_SignOut_READ();
                    
                    jsonStruct[ 'onFailure' ][ 'message' ] = [

                        'You failed to log out somehow, please try again later.'

                    ];

                    jsonStruct[ 'onFailure' ][ 'status' ] = [

                        'failure'

                    ];
                    
                    for( key in jsonStruct[ 'onFailure' ][ 'message' ] ){

                        arrayAppend( jsonStruct[ 'onSuccess' ][ 'message' ], 'Thank you for using our admin panel, we hope to see you again!' );
                        arrayAppend( jsonStruct[ 'onSuccess' ][ 'status' ], 'success' ); 

                    }

                    booleanArray[ 1 ][ 'locationOnSuccess' ] = application.adminPanel.components.utility.strings.Strings_GeneratePageHref_TASK( 'signin' );
                   
                    application.adminPanel.components.utility.hydras.Hydra_Basic_TASK( formData, resultStruct, booleanArray, 1, jsonStruct );

                } catch( any e ){

                    var errorStruct             = {};
                    errorStruct[ 'cfcatch' ]    = e;
                    errorStruct[ 'arguments' ]  = arguments;
                    errorStruct[ 'success' ]    = false;

                    writeDump( e ); abort;

                    application.adminPanel.components.utility.hydras.Hydra_Basic_TASK( formData, errorStruct, booleanArray, 1, jsonStruct );

             }
        
                                    
        }

        //   **********************************************************************

            // HELPER FUNCTIONS



        //   **********************************************************************
        //   **********************************************************************
        


    //    *********************************************************************
    //    * Sigout Page - END 
    //    *********************************************************************
}