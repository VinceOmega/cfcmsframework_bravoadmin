component displayName="AdminController" output="true" hint="This is the controller for admin setup" {

    /******
     * Index
     * 
     *
     * 
     * 
     * 
    ******/
    
    this.metaData       = {};
    this.metaData.Admin = {};

    //   **********************************************************************  
    //   *  Admin Brand Listing Page - START                               
    //   **********************************************************************  

    public void function Admin_Brand_Listing_RETRIEVE( required struct urlData, boolean debug ){

        //Structs
        var resultStruct = {};

        try{

            resultStruct = APPLICATION[ 'adminPanel' ][ 'components' ][ 'site' ][ 'models' ][ 'admin' ].Admin_Brand_Listing_READ();

            APPLICATION[ 'adminPanel' ][ 'components' ][ 'site' ][ 'views' ][ 'admin' ].Admin_Brand_Listing_VIEW( urlData, false, resultStruct[ 'result' ] );

        } catch( any e ){

            writeDump( e );

        }

    }

    //   **********************************************************************  
    //   *  Admin Brand Listing Page - END                               
    //   **********************************************************************  

}