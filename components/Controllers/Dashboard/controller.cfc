component displayName="DashboardController" output="true" hint="" {

/******
 * Index
 * 
 *
 * 
 * 
 * 
******/

this.metaData           = {};
this.metaData.Dashboard = {};
this.datasource = {

    'main'      : { datasource = application.mainDatabase, metadata=this.metadata },
    'products'  : { datasource = application.productsDatabase, metadata=this.metadata },
    'zindex'    : { datasource = application.zIndexDatabase, metadata=this.metadata },
    'eclipse'   : { datasource = application.eclipseDatabase, metadata=this.metadata }

}


    // ************************************************************************
    // *   Dashboard RightSideBar - START
    // ************************************************************************

        public void function Dashboard_RightSideBarPage_RETRIEVE( required struct urlData, boolean debug ){

            try{

                application.errorPanel.components.site.views.dashboard.Dashboard_RightSideBarPage_VIEW( urlData );

            } catch( any e ){

                writeDump( e );

            }

        }

    // ************************************************************************
    // *   Dashboard RightSideBar - END 
    // ************************************************************************


    public string function Dashboard_Reports_RETRIEVE( required struct urlData ){


        try{

            //strings
            var query           = "";
            var urlDataList     = "siteID,userID,platformID";

            //numerics
            var cnt             = 1;

            //structs
            var paramStruct         = {};
            var connectionStruct    = {};
            var resultStruct        = {};

            //arrays
            var strBuffer           = [];

            //boolean
            var whereClause         = false;


            savecontent variable="query"{


                writeOutput(

                    "
                        SELECT * 
                        FROM srlighting.errorlogs 
                    
                    "

                )

            };

            strBuffer.append(query);

            for( key in urlData ){

                if( listFindNoCase( urlDataList, key ) ){

                    whereClause = ( cnt < 2 ) ? true : false;

                    ( whereClause ) ? strBuffer.append( "WHERE " ) : strBuffer.append( " AND " );
                    strBuffer.append( key );
                    strBuffer.append( " = " )
                    strBuffer.append( ":" );
                    strBuffer.append( key );

                    structInsert( paramStruct, key, { value=urlData[ key ], cfsqltype='cf_sql_numeric' } );

                    cnt++;

                }

            }

            query = arrayToList( strBuffer, '' );

            resultStruct = application.errorPanel.components.site.models.dashboard.Dashboard_Reports_READ( query, paramStruct, this.datasource.main );

            application.errorPanel.components.site.views.dashboard.Dashboard_Reports_VIEW( urlData, resultStruct.result ,false );

        } catch( any e ){

            writeDump( e );

        }


    }

}