component displayName="" output=true hint="" {

    //    **********************************************************************
    //    *  Servers Vars Functions - START
    //    * ********************************************************************

        /**
         * @hint: 
         */

        public array function createUserAgentDirectoryObject(){

            //Strings
            var fp 		    = "";

            //Arrays
            var uaStruct 	= [];

            try{

                if( fileExists( expandPath( "/customScriptsBravo/MyPlumbingShowroom/jsonDataStores/crawler-user-agents.json" ) ) ){

                    fp 		= fileRead( expandPath( "/customScriptsBravo/MyPlumbingShowroom/jsonDataStores/crawler-user-agents.json" ) );
                    uaStruct 	= deserializeJSON( fp );

                }

            } catch( any e ){

                writeDump( e );

            }

            return uaStruct;

        }

        /**
         * @hint: 
         */

         public query function getSolrServers(){

            //Queries
            var result = queryNew( '' );

            //Structs
            var metaData = structNew();

            try{

                result = queryExecute(
                    "
                        Select * From servers Where serverName like 'Search%'
                    ",
                    {},
                    { 
                        datasource=application.mainDatabase,
                        result='metaData'
                    }

                );

            } catch( any e ){

                writeDump( e );

            }

            return result;

         }

         /**
         * @hint: 
         */

        public boolean function updateServer(){

            //Queries
            var result      = queryNew( '' );

            //Structs
            var metaData    = structNew();

            //Booleans
            var success     = false;

            try{

                result = queryExecute(
                    "
                        Update servers Set resetVars = 0
                        Where serverName = 'CF#application.serverID#'  
                    ",
                    {


                    },
                    { 
                        datasource=application.mainDatabase,
                        result='metaData'
                    }

                );

                success = true;

            } catch( any e ){

                writeDump( e );

            }

            return success;

         }

         /**
         * @hint: get Brands
         */

        public query function getBrands(){

            //Queries
            var result = queryNew( '' );

            //Structs
            var metaData = structNew();

            try{

                result = queryExecute(
                    "
                        Select brandName, brandURL, brandCode, showPrice
                        From Brands
                        Where brandActive = 1
                            And brandReleased = 1
                        Order By brandName
                    ",
                    {},
                    { 
                        datasource=application.productsDatabase,
                        result='metaData'
                    }

                );

            } catch( any e ){

                writeDump( e );

            }

            return result;

         }

        /**
         * @hint: 
         */

        public query function getPriceToNotShow(){

            //Queries
            var result = queryNew( '' );

            //Structs
            var metaData = structNew();

            try{

                result = queryExecute(
                    "
                        Select brandCode
                        From Brands
                        Where brandActive = 1
                            And brandReleased = 1
                            And showPrice = 0
                        Order By brandCode
                    ",
                    {},
                    { 
                        datasource=application.productsDatabase,
                        result='metaData'
                    }

                );

            } catch( any e ){

                writeDump( e );

            }

            return result;

         }


        /**
         * @hint: 
         */

        public query function getSites(){

            //Queries
            var result = queryNew( '' );

            //Structs
            var metaData = structNew();

            try{

                result = queryExecute(
                    "
                      Select EntryPointCode as siteID, entryPointAbbrev as appName, activeYN as active, status,
                            concat('http://',localURL,'/') as localURL, solrCore, EntryPointName as siteName,
                            if(globalURL='',null,concat('http://',globalURL,'/')) as globalURL, hasFrenchYN   
                        From EntryPoints 
                        Order By appName      
                    ",
                    {},
                    { 
                        datasource=application.mainDatabase,
                        result='metaData'
                    }

                );

            } catch( any e ){

                writeDump( e );

            }

            return result;

         }

         /**
         * @hint: 
         */

        public query function getAdminInfo(){

            //Queries
            var result = queryNew( '' );

            //Structs
            var metaData = structNew();

            try{

                result = queryExecute(
                    "
                      Select scPassword
                        From EntryPoints 
                        Where entryPointCode = 284      
                    ",
                    {},
                    { 
                        datasource=application.mainDatabase,
                        result='metaData'
                    }

                );

            } catch( any e ){

                writeDump( e );

            }

            return result;

         }

         /**
         * @hint: 
         */

        public struct function getServerVars( required struct serverVars ){

            //Queries
            var result      = queryNew( '' );

            //Structs
            var metaData    = structNew();

            //Numerics
            var row         = 1;

            try{

                result = queryExecute(
                    "
                        Select *
                        From serverVariables
                    ",
                    {},
                    { 
                        datasource=application.mainDatabase,
                        result='metaData'
                    }

                );

                for( row; row < result.recordCount; row++ ){

                    serverVars[ result[ serverVariable ][ row ] ] = result[ serverVariable ][ row ];

                }

            } catch( any e ){

                writeDump( e );

            }

            return serverVars;

         }
    
    //    **********************************************************************
    //    *  Servers Vars Functions - END
    //    * ********************************************************************


}

