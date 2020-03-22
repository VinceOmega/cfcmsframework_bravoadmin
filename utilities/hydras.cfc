component displayName='hydraComponents' output=true hint='component sets for the hydra logic structures'{

    /**
     * @name: hydraComponents
     * @hint: logic structure used for evaluating the form processes of a page or action, meant to be used with PROCESS controllers
     * 
     */

    //  **********************************************************************  
    //  *  Hydras Functions - START                                      
    //  **********************************************************************  
    
        /**
         * The basic logic structure for a hydra
         * 
         * @name: Hydra_Basic_TASK
         * @hint: The basic logic structure for a hydra
         * @formData: The data of the form used
         * @resultStruct: a struct that contains data to process
         * @booleanArray: an array of boolen values to check within the hydra, the hydra will rescusively call itself until everything is checked. Each array will contain a struct of data to tell the hydra what to do
         * @arrayPos: the position in the boolean Array, thus the depth level within the dynamic if else statement, we are currently at in the structure
         * @jsonStruct: a struct of information to pass back to the browser if the process has been called via an ajax request, otherwise we refresh the page.
         */

        //   **********************************************************************
        //   **********************************************************************

            // MAIN FUNCTIONS

                public void function Hydra_Basic_TASK( required struct formData, required struct resultStruct, required array booleanArray, required numeric arrayPos, struct jsonStruct ){

                    //invoke function for unique actions
                    var invokeFunction  = 'pageActions_' & application.errorPanel.components.utility.strings.Strings_CleanPageSlug_TASK( formData[ 'page' ], 'file' ) & '_TASK';

                    //numerics
                    var arrayPosition   = ( abs( arrayPos ) && abs( arrayPos ) <= arrayLen( booleanArray ) ) ? arrayPos : 1;

                    //structs
                    var jsonStructure   = ( !StructisEmpty( jsonStruct ) ) ? jsonStruct : {};

                    //booleans
                    var debug           = false;

                    try{

                        if( resultStruct[ booleanArray[ arrayPosition ][ 'validateBoolean' ] ] ){

                            if( arrayPosition != arrayLen( booleanArray ) ){

                                this.Hydra_Basic_TASK( formData, resultStruct, booleanArray, arrayPos++, jsonStructure );

                            }

                            // This part gets for the metaData of the component pageActions in utilities, 
                            // it searches the component to find if there is a match for the name we want to invoke
                            // if it's there, then we excute it.

                            //writeDump( invokeFunction ); abort;


                            if(     
                                    arrayLen( arrayFindAll( structFind( GetMetaData( application.errorPanel.components.utility.pageActions ), 'functions' ), function( struct ){
                                        
                                           return !abs( compare( lcase( structFind( struct, 'name' ) ), lcase( invokeFunction ) ) ) 

                                        } ) )

                                    ){

                                invoke( application.errorPanel.components.utility.pageActions, invokeFunction, { formData=formData, queryData=resultStruct.result }  );

                            }

                            if( debug ){
                                writeDump( resultStruct ) abort;
                            }


                           variables.Hydra_Basic_TASK___AjaxHandler( formData, resultStruct, booleanArray, arrayPos, booleanArray[ arrayPos ][ 'locationOnSuccess' ], jsonStructure[ 'onSuccess' ] );

                        } else {

                           variables.Hydra_Basic_TASK___AjaxHandler( formData, resultStruct, booleanArray, arrayPos, booleanArray[ arrayPos ][ 'locationOnFailure' ], jsonStructure[ 'onFailure' ] );

                        }

                    } catch( any e ){

                        var errorStruct                 = {};
                        errorStruct[ 'cfcatch' ]        = e;
                        errorStruct[ 'arguments' ]      = arguments;
                        errorStruct[ 'resultStruct' ]   = resultStruct;

                        writeDump( e );
                        abort;

                        structInsert( resultStruct, 'hydraErrors', errorStruct );

                        variables.Hydra_Basic_TASK___AjaxHandler( formData, resultStruct, booleanArray, arrayPos, booleanArray[ arrayPos ][ 'locationOnFailure' ], jsonStructure[ 'onFailure' ] );

                    }

                }


        //   **********************************************************************

            // HELPER FUNCTIONS 

                private void function Hydra_Basic_TASK___AjaxHandler( required struct formData, required struct resultStruct, required array booleanArray, required numeric arrayPos, required string location, struct jsonStruct ){


                    variables.Hydra_Shared_AjaxHandler_RENDER( formData, resultStruct, booleanArray, arrayPos, location, jsonStruct );

                }


                private void function Hydra_Shared_AjaxHandler_RENDER( required struct formData, required struct resultStruct, required array booleanArray, required numeric arrayPos, required string location, struct jsonStruct ){
                    
                    //structs
                    var growl = {};

                    //strings
                    growl[ 'message' ]          = jsonStruct[ 'message' ][ arrayPos ];
                    growl[ 'status' ]           = jsonStruct[ 'status' ][ arrayPos ];
                    jsonStruct[ 'growl' ]       = growl;
                    jsonStruct[ 'location' ]    = ( trim( lcase( location ) ) != 'noredirect' || trim( lcase( jsonStruct[ 'location' ] ) ) != 'noredirect' ) ? location : '';

                    //writeDump( arguments ) abort;

                    if( formData.ajax ){

                        writeOutput(

                            serializeJSON( jsonStruct )

                        );

                    } else {

                        if( structKeyExists( resultStruct, 'hydraErrors' ) ){

                            writeDump( resultStruct[ 'hydraErrors' ] ); //dump errors

                        }

                        location = ( location == '' ) ? '/' & formData.dir & '/' & formData.route & '/' & formData.page : location;

                        if( location != 'noredirect' ){
                            location( url=location, addtoken=false );
                        }

                    }

                }

        //   **********************************************************************
        //   **********************************************************************

    //  **********************************************************************  
    //  *  Hydras Functions - END
    //  **********************************************************************  
    

}