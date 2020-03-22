component displayName='queryContainersComponents' output=true hint='component sets for the queryContainers logic structures'{


    /**
    *
    *
    *
    *
    **/

    //  **********************************************************************  
    //  *  Query Containers Functions - START                                      
    //  **********************************************************************  


        //   **********************************************************************
        //   **********************************************************************

            // MAIN FUNCTIONS

            public struct function QueryContainers_Basic_TASK( required array queryDataObj ){

                //structs
                var result          = structNew();
                var metaData        = structNew();
                var resultStruct    = structNew();

                //string
                var key         = '';

                //numerics  
                var idx         = '';

                for( idx in queryDataObj ){

                    switch( idx.type ){

                        case 'transact':

                            idx.result = variables.QueryContainers_Basic_TASK___TransactionWrapper( idx.queries, idx.isInline, idx.GroupName, idx.dataSource, result, metaData );

                            break;

                        default:

                            idx.result = variables.QueryContainers_Basic_TASK___NormalWrapper( idx.queries, idx.isInline, idx.GroupName, idx.dataSource, result, metaData );

                            break;
                        
                    }

                    structInsert( resultStruct, idx.GroupName, idx.result );

                }

                return resultStruct;

            }

            public struct function QueryContainers_SIMPLE_TASK( required string query, required struct params, required struct connection, query queryOfQueries  ){

                try{

                    //Queries
                    var result          = queryNew( '' );
        
                    //Structs
                    var metaData        = {};
                    var resultStruct    = {};
        
                    //Booleans
                    var success         = false;
        
                    structInsert( connection, 'metaData', metaData, true );
        
                    result = queryExecute( query, params, connection );
        
                    success = true;
        
        
                } catch( any e ){
        
        
                    var errorStruct             = structNew();
                    errorStruct[ 'cfcatch' ]    = e;
                    errorStruct[ 'metaData' ]   = metaData;
                    errorStruct[ 'arguments' ]  = arguments;
                    errorStruct[ 'success' ]    = success;
        
                    writeDump( errorStruct );
                    
        
                }
        
                resultStruct[ 'success' ]       = success?:false;
                resultStruct[ 'result' ]        = result?:queryNew('');
                resultStruct[ 'errors' ]        = errorStruct?: {};
                resultStruct[ 'metaData' ]      = metaData;
        
                return resultStruct;
        

            }


        //   **********************************************************************

            // HELPER FUNCTIONS 
     
            public struct function QueryContainers_Basic_TASK___TransactionWrapper( required struct queryData, required boolean isInline, required string groupName, required string dataSource, required struct result, required struct metaData ){

                //numerics
                var idx     = 1;
                var index   = 1;

                //strings
                var value   = '';
                var key     = '';

                //arrays
                var arrays              = [];
                var parameterArrays     = [];

                //structs
                var parameterVariables  = {};
                var resultStruct        = {};

                //booleans
                var success             = false;


                transaction{

                    try{

                        for( idx in queryData ){

                            if( isInline ){

                                result[ groupName ] = queryExecute(

										variables.QueryContainers_Basic_TASK___TransactionWrapper___InlinePrintQuery( idx.group )
                                    ,
										variables.QueryContainers_Basic_TASK___TransactionWrapper___InlineSetParams( idx.params )
                                    ,
                                    {
                                        datasource=dataSource,
                                        result=metaData
                                    }
                                );

                            } else {

                                for( idx in queryData ){

                                    idx.group.each( function( value, index, array ){

										result[ groupName ][ index ] = queryNew( '' );

                                        result[ groupName ][ index ] = queryExecute(


                                                writeOutput( idx.group[ index ] )

                                            ,
                                            
                                            variables.QueryContainers_BAsic_TASK___TransactionWrapper___SingleSetParams( idx.params )
                                            ,
                                            {
                                                datasource=dataSource,
                                                result=metaData[ index ]
                                            }

                                        );

                                    });

                                }
    

                            }


                        }

                        success = true;

                        transaction action='commit';

                    } catch( any e ){

                        transaction action='rollback';

                        var errorStruct             = {};
                        errorStruct[ 'cfcatch' ]    = e;
                        errorStruct[ 'success' ]    = success;
                        errorStruct[ 'arguments' ]  = arguments;
                        errorStruct[ 'groupName' ]  = groupName;
                        errorStruct[ 'result' ]     = result;
                        errorStruct[ 'metaData' ]   = metaData;

                    }

                }


                resultStruct[ 'success' ]   = success;
                resultStruct[ 'result' ]    = result;
                resultStruct[ 'metaData' ] 	= metaData;


                return resultStruct;

            }
            
            public struct function QueryContainers_Basic_TASK___NormalWrapper( required struct queryData, required boolean isInline, required string groupName, required string dataSource, required struct result, required struct metaData ){

                //numerics
                var idx     = 1;
                var index   = 1;

                //strings
                var value   = '';
                var key     = '';

                //arrays
                var arrays              = [];
                var parameterArrays     = [];

                //structs
                var parameterVariables  = {};
                var resultStruct        = {};

                //booleans
                var success             = false;

                transaction{

                    try{

                        for( idx in queryData ){

                            if( isInline ){

                                result[ groupName ] = queryExecute(

                                        variables.QueryContainers_Basic_TASK___TransactionNormalWrapper___InlinePrintQuery( idx.group )
                                    ,
                                        variables.QueryContainers_Basic_TASK___TransactionNormalWrapper___InlineSetParams( idx.params )
                                    ,
                                    {
                                        datasource=dataSource,
                                        result=metaData
                                    }
                                );

                            } else {

                                for( idx in queryData ){

                                    idx.group.each( function( value, index, array ){

                                        result[ groupName ][ index ] = queryNew( '' );

                                        result[ groupName ][ index ] = queryExecute(


                                                writeOutput( idx.group[ index ] )

                                            ,
                                            
                                            variables.QueryContainers_BAsic_TASK___TransactionNormalWrapper___SingleSetParams( idx.params )
                                            ,
                                            {
                                                datasource=dataSource,
                                                result=metaData[ index ]
                                            }

                                        );

                                    });

                                }


                            }


                        }

                        success = true;

                        transaction action='commit';

                    } catch( any e ){

                        transaction action='rollback';

                        var errorStruct             = {};
                        errorStruct[ 'cfcatch' ]    = e;
                        errorStruct[ 'success' ]    = success;
                        errorStruct[ 'arguments' ]  = arguments;
                        errorStruct[ 'groupName' ]  = groupName;
                        errorStruct[ 'result' ]     = result;
                        errorStruct[ 'metaData' ]   = metaData;

                    }

                }

                resultStruct[ 'success' ]   = success;
                resultStruct[ 'result' ]    = result;
                resultStruct[ 'metaData' ] 	= metaData;

                return resultStruct;

			}

			private void function QueryContainers_Basic_TASK___TransactionNormalWrapper___InlinePrintQuery( required array group  ){

				
				var query = queryNew( '' );

				for( query in qroup ){

					query.each(

						function( value, index, array ){

							if( index < arrayLen( array ) ) {

								writeOutput( index & '; ' );

							} else {

								writeOutput( index );

							}

						}
					)

				}

			}

			private struct function QueryContainers_Basic_TASK___TransactionNormalWrapper___InlineSetParams( required array params ){

				//structs
				var resultStruct = {};

				for( parameterArrays in idx.params ){

					parameterArrays.each(

						function( value, index, array ){

							for( key in value ){

								if( index <= arrayLen( array ) ){

									"#value#" = value.key;

									structInsert( resultStruct, '#value#', value );

								} /* else {

									"#value#" = value.key

								} */

							}

						}

					)

				}


				return resultStruct;

			}


            private struct function QueryContainers_BAsic_TASK___TransactionNormalWrapper___SingleSetParams( required array params ){

                //structs
                var resultStruct = {};
                
                for( parameterArrays in params[ index ] ){

                    parameterArrays.each(

                        function( value, index, array ){

                            for( key in value ){

                                if( index <= arrayLen( array ) ){

                                    "#value#" = value.key;

									structInsert( resultStruct, '#value#', value );

                                } 

                            }

                        }

                    )

                }


                return resultStruct;

            }

         //   **********************************************************************
        //   **********************************************************************

    //  **********************************************************************  
    //  *  Query Containers Functions - END                                      
    //  **********************************************************************  


}
