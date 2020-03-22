component displayName="metaDataMethods" output=true hint="" {

    /**
     * 
     * 
     * 
     * 
     */

    //    **********************************************************************
    //    *  Meta Data Functions - START
    //    * ********************************************************************

        /**
         * @hint: 
         */

        public struct function getRouteInMetaData( required string route ){

            include '/config/metaData/pages.cfc';

            return metaData[ route ];

        }

        /**
         * @hint:
         */

        public struct function getPagesInMetaData( ){

            //Structs
            var resultStruct    = {};

            //Strings
            var sections        = '';
            var pages           = '';

            include '/config/metaData/pages.cfc';

            for( sections in metaData ){

                for( pages in metaData[ sections ] ){

                    if( isStruct( metaData[ sections ][ pages ] ) ){

                        structInsert( resultStruct, lcase( metaData[ sections ][ pages ][ 'slug' ] ) , metaData[ sections ][ pages ], true );

                    }

                };

            }

            return resultStruct;

        }
    
    //    **********************************************************************
    //    *  Meta Data Functions - END
    //    * ********************************************************************


}

