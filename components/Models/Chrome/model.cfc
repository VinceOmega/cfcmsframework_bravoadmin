component displayName="ChromeModel" output="true" {


/******
 * Index
 * 
 *
 * 
 * 
 * 
******/

    //   **********************************************************************  
    //   *  Chrome Models - START                               
    //   **********************************************************************  


        /**
         * @hint:
         */

        public struct function Chrome_ProductsPublished_READ(){

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
                      Select solrCount 
                            From entryPoints ep
                            Left Join establishments e on ep.entryPointCode = e.establishmentEntryPoint and establishmentKey = 0
                            Left Join establishmentDetailDealers ed on ep.entryPointCode = ed.establishmentKey
                        Where ep.entryPointCode = :siteID
                    ",
                    {

                        siteID = { value=#request.siteSelected#, cfsqltype='cf_sql_integer' }

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

        public struct function Chrome_ExchangeRate_READ(){

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
                      Select exRateUSDCAD 
                            From entryPoints ep
                            Left Join establishments e on ep.entryPointCode = e.establishmentEntryPoint and establishmentKey = 0
                            Left Join establishmentDetailDealers ed on ep.entryPointCode = ed.establishmentKey
                        Where ep.entryPointCode = :siteID

                    ",
                    {

                        siteID = { value=#request.siteSelected#, cfsqltype='cf_sql_integer' }

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


    //   **********************************************************************  
    //   * Chrome Models - END                               
    //   ********************************************************************** 

}