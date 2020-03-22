component displayName="AuthModel" output=true hint=""{

    /********
     * Index
     * 
     * 
     * 
     * 
     * ******/

    // *************************************************************
    // * Auth Login Page
    // *************************************************************

        public struct function Auth_Login_READ( required struct formData ){

            try{

                //Queries
                var result              = queryNew( '' );
                var entryPointResult    = queryNew( '' );

                //Structs
                var metaData        = {};
                var resultStruct    = {};

                //Booleans
                var success         = false;


                result = queryExecute(
                    "
                        SELECT *
                            FROM    users u
                            WHERE   u.email     = :email AND
                                    u.password  = :password


                    ",
                    {

                        email = { value=formData.email, cfsqltype='cf_sql_varchar' },
                        password = { value=formData.password, cfsqltype='cf_sql_varchar' }                    
                    

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

            }

            resultStruct[ 'success' ]       = success;
            resultStruct[ 'result' ]        = result;
            resultStruct[ 'errors' ]        = errorStruct?: {};

            return resultStruct;

        }

    // *************************************************************
    // * Auth Login Page
    // *************************************************************


}