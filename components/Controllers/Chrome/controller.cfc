component displayName="ChromeController" output=true hint="" {


    /******
     * Index
     * 
     * PExCM - Chrome_Header_RETRIEVE
     * MbJWT - Chrome_Body_RETRIEVE
     * 
     * 
    ******/

    //    **********************************************************************
    //    *  Common Chrome Functions - START
    //    * ********************************************************************

        //PExCM
        public void function Chrome_Header_RETRIEVE( required struct urlData ){

            try{

                APPLICATION[ 'adminPanel' ][ 'components' ][ 'site' ][ 'views' ][ 'chrome' ].Chrome_Header_VIEW( urlData );

            } catch( any e ){

                writeDump( e );

            }

        }

        //MbJWT
        public void function Chrome_Body_RETRIEVE( required struct urlData, required string htmlBlob, required string route, required string page ){

            //strings
            var devActions  = '';
            var args        = '';

            //Struct
            var debugCollection                 = {};
            debugCollection[ 'SectionHeader' ]  = [];
            debugCollection[ 'SectionLinks' ]   = {};
            debugCollection[ 'SectionArgs' ]    = {};
            resultStruct                        = {};

            try{

                //Create the debug object to pass in
                for( devActions in application.devActions ){

                    arrayAppend( debugCollection.SectionHeader, devActions );

                    for( args in application.devActionsArgStruct ){

                        ( structKeyExists( debugCollection.SectionLinks, devActions ) ) ? arrayAppend( debugCollection.SectionLinks[ args ], '?' & devActions & '=' & args )  :  structInsert( debugCollection.SectionLinks, args, [ '?' & devActions & '=' & args ] );

                        ( structKeyExists( debugCollection.SectionArgs, devActions ) ) ? arrayAppend( debugCollection.SectionArgs[ args ], args )  :  structInsert( debugCollection.SectionArgs, args, [ args ] );

                    }

                }

                resultStruct[ 'productsPublished' ] =  APPLICATION[ 'adminPanel' ][ 'components' ][ 'site' ][ 'models' ][ 'chrome' ].Chrome_ProductsPublished_READ();

                resultStruct[ 'exchangeRate' ]      = APPLICATION[ 'adminPanel' ][ 'components' ][ 'site' ][ 'models' ][ 'chrome' ].Chrome_ExchangeRate_READ();

                APPLICATION[ 'adminPanel' ][ 'components' ][ 'site' ][ 'views' ][ 'chrome' ].Chrome_Body_VIEW( urlData, htmlBlob, { title: '' }, debugCollection, application.adminPanel.metaData.navigation, resultStruct, '' );
            
            } catch( any e ){

                var errorStruct  = {};

                errorStruct[ 'cfcatch' ]    = e;
                errorStruct[ 'arguments' ]  = ARGUMENTS;
                errorStruct[ 'this' ]       = this;
                errorStruct[ 'variables' ]  = variables;

                writeDump( errorStruct );

            }

        }


    //    **********************************************************************
    //    *  Common Chrome Functions - END
    //    * ********************************************************************


}