component displayName="LoginModel" output=true hint=""{

    /**
     * 
     * 
     * 
     */


    //**********************************************************************
    //*  Login Signin Page - START
    //**********************************************************************

        public struct function Login_Signin_READ( required struct formData ){

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
                        Select * From users 
                        Where email     = :email
                        And password    = :password
                        And
                            ( 
                                userType 		= 'admin'
                                OR userType     = 'site'
                            )

                    ",
                    {
                        
                        email       = { value = trim( formData.email ), cfsqltype="cf_sql_varchar" },
                        password    = { value = trim( formData.password ), cfsqltype="cf_sql_varchar" }

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


    //**********************************************************************
    //*  Login Signin Page  - END
    //**********************************************************************


    //**********************************************************************
    //*  Logout Signin Page - START
    //**********************************************************************

    public struct function Login_Signout_READ( ){

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
                    SELECT *
                    FROM users u
                    WHERE u.userID = :userID

                ",
                {

                    userID = { value=session.login.userID, cfsqltype='cf_sql_integer' }                    

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


//**********************************************************************
//*  Logout Signin Page  - END
//**********************************************************************

}