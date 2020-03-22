component displayName='DashboardModel' output=true hint=""{

    /**
     * 
     * 
     */


    /*********************************************************
    /* Dashboard Dashboard Sites - START
    /*********************************************************/

    

        public struct function Dashboard_Dashboard_READ( required string query ){
                
            try{

                //Queries
                var result          = queryNew( '' );

                //Structs
                var metaData        = {};
                var resultStruct    = {};

                //Booleans
                var success         = false;


                result = queryExecute(
                    query
                    ,
                    { 

                        email = { value=session.login.email, cfsqltype='cf_sql_varchar' }

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

                writeDump( errorStruct );
                abort;

            }

            resultStruct[ 'success' ]       = success;
            resultStruct[ 'result' ]        = result;
            resultStruct[ 'errors' ]        = errorStruct?: {};

            return resultStruct;

        }


    /*********************************************************
    /* Dashboard Dashboard Sites - END
    /*********************************************************/



    /*********************************************************
    /* Dashboard User Sites - START
    /*********************************************************/

    

        public struct function Dashboard_UserSites_READ( required string query ){
            
            try{

                //Queries
                var result          = queryNew( '' );

                //Structs
                var metaData        = {};
                var resultStruct    = {};

                //Booleans
                var success         = false;


                result = queryExecute(
                    query
                    ,
                    { },
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


    /*********************************************************
    /* Dashboard User Sites - END
    /*********************************************************/

}