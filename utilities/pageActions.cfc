component displayName='pageActions' output=true hint="utility components for excuting unique post processing validation actions"{

    /**
     * @hint:
     */

    //*****************************************************************************
    //*    Signin Page Unique Actions - START
    //*****************************************************************************

        public void function pageActions_Signin_TASK( required struct formData, required query queryData ){

            if( queryData.recordCount ){

                variables.pageActions_Signin_TASK___updateUserLoginCount( queryData.userId );

            }
            
            application.errorPanel.components.utility.sessionManager.SessionManager_CreateUserSession_TASK( queryData );            

        }

        private void function pageActions_Signin_TASK___updateUserLoginCount( required numeric userId ){

            try{

                //Queries
                var result          = queryNew( '' );

                //Structs
                var metaData        = {};
                var resultStruct    = {};

                //Booleans
                var success         = false;

                result = queryExecute(
                    "
                        Update users 
                            Set loginCount = loginCount + 1,
                                lastLogin = :currentTime
                        Where userID = :Id

                    ",
                    {
                        currentTime = { value = Now(), cfsqltype ='cf_sql_timestamp' },
                        Id  = { value = userId, cfsqltype ="cf_sql_integer" }

                    },
                    {

                        datasource  = application.mainDatabase,
                        result      = "metaData"

                    }

                );

                success = true;

            } catch( any e ){

                var errorStruct             = structNew();
                errorStruct[ 'cfcatch' ]    = e;
                errorStruct[ 'metaData' ]   = metaData;
                errorStruct[ 'arguments' ]  = arguments;
                errorStruct[ 'success' ]    = success;

                writeDump( e );

                throw( message='Signin page actions failure', type='cfcatch' );

            }


        }

    //*****************************************************************************
    //*    Signin Page Unique Actions - END
    //*****************************************************************************

    //****************************************************************************
    //*     Dashboard Unique Actions   - START
    //****************************************************************************

        public void function pageActions_UserSites_TASK( required struct formData, required query queryData ){

            if( queryData.recordCount ){

                application.errorPanel.components.utility.sessionManager.SessionManager_SetSite_TASK( queryData.entryPointCode, queryData.entryPointName, formData.recordCount );

            } 

        }

    //****************************************************************************
    //*     Dashboard Unique Actions   - END
    //****************************************************************************

    //****************************************************************************
    //*     Signout Page Unique Actions    - START
    //****************************************************************************

        public void function pageActions_Signout_TASK( struct formData, query queryData ){

            application.errorPanel.components.utility.sessionManager.SessionManager_DestoryUserSession_TASK();

        }

    //****************************************************************************
    //*     Signout Page Unique Actions     - END
    //****************************************************************************

    //****************************************************************************
    //*     Auth Login Page Actions     - START
    //****************************************************************************

        
        public void function pageActions_Login_TASK( struct formData, query queryData ){

            //structs
            var resultStruct = {};

            if( queryData.recordCount ){

                variables.pageActions_Login_TASK___updateUserLoginCount( queryData.userId );

                resultStruct = variables.pageActions_Login_TASK___getSiteInfo( formData.entryPointCode );

            }
            
            application.errorPanel.components.utility.sessionManager.SessionManager_CreateUserSession_TASK( queryData ); 

            application.errorPanel.components.utility.sessionManager.SessionManager_SetSite_TASK( resultStruct.result.siteID, resultStruct.result.siteName, resultStruct.result.recordCount );

        }

        private void function pageActions_Login_TASK___updateUserLoginCount( required numeric userId ){

            try{

                //Queries
                var result          = queryNew( '' );

                //Structs
                var metaData        = {};
                var resultStruct    = {};

                //Booleans
                var success         = false;

                result = queryExecute(
                    "
                        Update users 
                            Set loginCount = loginCount + 1,
                                lastLogin = :currentTime
                        Where userID = :Id

                    ",
                    {
                        currentTime = { value = Now(), cfsqltype ='cf_sql_timestamp' },
                        Id  = { value = userId, cfsqltype ="cf_sql_integer" }

                    },
                    {

                        datasource  = application.mainDatabase,
                        result      = "metaData"

                    }

                );

                success = true;

            } catch( any e ){

                var errorStruct             = structNew();
                errorStruct[ 'cfcatch' ]    = e;
                errorStruct[ 'metaData' ]   = metaData;
                errorStruct[ 'arguments' ]  = arguments;
                errorStruct[ 'success' ]    = success;

                writeDump( e );

                throw( message='Login page actions failure', type='cfcatch' );

            }

        }

        private struct function pageActions_Login_TASK___getSiteInfo( required string entryPointCode ){

            try{

                //Queries
                var result          = queryNew( '' );

                //Structs
                var metaData        = {};
                var resultStruct    = {};

                //Booleans
                var success         = false;

                result = queryExecute(
                    "
                        SELECT entryPointCode as siteID, entryPointAbbrev as siteName
                            FROM entrypoints
                            WHERE entryPointCode = :entryPointCode
                    ",
                    {
                        entryPointCode = { value = entryPointCode, cfsqltype ='cf_sql_integer' }    
                    },
                    {

                        datasource  = application.mainDatabase,
                        result      = "metaData"

                    }

                );

                success = true;

            } catch( any e ){

                var errorStruct             = structNew();
                errorStruct[ 'cfcatch' ]    = e;
                errorStruct[ 'metaData' ]   = metaData;
                errorStruct[ 'arguments' ]  = arguments;
                errorStruct[ 'success' ]    = success;

                writeDump( e );

                throw( message='Login page actions failure', type='cfcatch' );

            }

            returnStruct[ 'success' ]   = success;
            resultStruct[ 'result' ]    = result;

            return resultStruct;

        }
        

    //****************************************************************************
    //*     Auth Login Page Actions     - END
    //****************************************************************************

    //****************************************************************************
    //*     Users Pages Actions         - START
    //****************************************************************************

        public void function pageActions_Create_TASK( struct formData, query queryData ){

            application.errorPanel.components.utility.image.Image_UploadUserProfile_RENDER( formData, queryData.userID );

        }

        public void function pageActions_Edit_TASK( struct formData, query queryData ){

            queryAddColumn( queryData, 'userid', 'Integer', [ formData.userID ] );

            application.errorPanel.components.utility.image.Image_UploadUserProfile_RENDER( formData, queryData.userID );

        }

        public void function pageActions_Copy_TASK( struct formData, query queryData ){

            queryAddColumn( queryData, 'userid', 'Integer', [ formData.userID ] );

            application.errorPanel.components.utility.image.Image_UploadUserProfile_RENDER( formData, queryData.userID );

        }

        public void function pageActions_Trade_Create_TASK( struct formData, query queryData ){

            application.errorPanel.components.utility.image.Image_UploadUserProfile_RENDER( formData, queryData.userID );

        }

        public void function pageActions_Trade_Edit_TASK( struct formData, query queryData ){

            queryAddColumn( queryData, 'userid', 'Integer', [ formData.userID ] );

            application.errorPanel.components.utility.image.Image_UploadUserProfile_RENDER( formData, queryData.userID );

        }

        public void function pageActions_Trade_Copy_TASK( struct formData, query queryData ){

            queryAddColumn( queryData, 'userid', 'Integer', [ formData.userID ] );

            application.errorPanel.components.utility.image.Image_UploadUserProfile_RENDER( formData, queryData.userID );

        }

        public void function pageActions_Site_Admin_Create_TASK( struct formData, query queryData ){

            application.errorPanel.components.utility.image.Image_UploadUserProfile_RENDER( formData, queryData.userID );

        }

        public void function pageActions_Site_Admin_Edit_TASK( struct formData, query queryData ){

            queryAddColumn( queryData, 'userid', 'Integer', [ formData.userID ] );

            application.errorPanel.components.utility.image.Image_UploadUserProfile_RENDER( formData, queryData.userID );

        }

        public void function pageActions_Site_Admin_Copy_TASK( struct formData, query queryData ){

            queryAddColumn( queryData, 'userid', 'Integer', [ formData.userID ] );

            application.errorPanel.components.utility.image.Image_UploadUserProfile_RENDER( formData, queryData.userID );

        }

        public void function pageActions_All_Create_TASK( struct formData, query queryData ){

            application.errorPanel.components.utility.image.Image_UploadUserProfile_RENDER( formData, queryData.userID );

        }

        public void function pageActions_All_Edit_TASK( struct formData, query queryData ){

            queryAddColumn( queryData, 'userid', 'Integer', [ formData.userID ] );

            application.errorPanel.components.utility.image.Image_UploadUserProfile_RENDER( formData, queryData.userID );

        }

        public void function pageActions_All_Copy_TASK( struct formData, query queryData ){

            queryAddColumn( queryData, 'userid', 'Integer', [ formData.userID ] );

            application.errorPanel.components.utility.image.Image_UploadUserProfile_RENDER( formData, queryData.userID );

        }

        public void function pageActions_Admin_Create_TASK( struct formData, query queryData ){

            application.errorPanel.components.utility.image.Image_UploadUserProfile_RENDER( formData, queryData.userID );

        }

        public void function pageActions_Admin_Edit_TASK( struct formData, query queryData ){

            queryAddColumn( queryData, 'userid', 'Integer', [ formData.userID ] );

            application.errorPanel.components.utility.image.Image_UploadUserProfile_RENDER( formData, queryData.userID );

        }

        public void function pageActions_Admin_Copy_TASK( struct formData, query queryData ){

            queryAddColumn( queryData, 'userid', 'Integer', [ formData.userID ] );

            application.errorPanel.components.utility.image.Image_UploadUserProfile_RENDER( formData, queryData.userID );

        }

    //****************************************************************************
    //*      Users Pages Actions        - END
    //****************************************************************************
}