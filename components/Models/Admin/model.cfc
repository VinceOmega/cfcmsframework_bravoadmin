component displayName='AdminModel' output=true hint=''{

    /**********
     * Index
     * 
     * 
     * 
     * 
     * 
     *********/


    //   **********************************************************************  
    //   *  Admin Brand Listing Page - START                               
    //   **********************************************************************  


        /**
         * @hint:
         */

        public struct function Admin_Brand_Listing_READ(){

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
                        Select count(siteSelectionID) as detailedBrandSelection, ss.*, b.*, sb.*, 
                            sb.account as theAccountNumber, sb.visibleTo as brandVisibile
                            From brands b 
                                Left Join siteSelections ss on ss.brandID = b.brandID 
                                Left Join siteBrands sb on ss.siteID = sb.siteID and ss.brandID = sb.brandID
                            Where ss.siteID = :siteID
                                Group By ss.brandID
                                Order By brandName 

                    ",
                    {

                        siteID = { value=#request.siteSelected#, cfsqltype='cf_sql_integer' }

                    },
                    {

                        datasource  = application.productsDatabase,
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

            resultStruct[ 'success' ]       = success?: false;
            resultStruct[ 'result' ]        = result?: queryNew( '' );
            resultStruct[ 'errors' ]        = errorStruct?: {};

            return resultStruct;


        }


    //   **********************************************************************  
    //   *  Admin Brand Listing Page - END                               
    //   ********************************************************************** 

}