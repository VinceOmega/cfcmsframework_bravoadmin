component displayName="UsersController" output="true" hint="This is the controller for users, wishlist and special users and not site or admin" {

/******
 * Index
 * 
 *
 * 
 * 
 * 
******/

this.metaData       = {};
this.metaData.Users = {};

    //   **********************************************************************  
    //   *  User Listing Page - START                               
    //   **********************************************************************  


        public void function Users_Listing_RETRIEVE( required struct urlData ){

            //Structs
            var resultStruct = {};

            try{

                resultStruct = APPLICATION[ 'adminPanel' ][ 'components' ][ 'site' ][ 'models' ][ 'users' ].Users_Listing_READ();

                APPLICATION[ 'adminPanel' ][ 'components' ][ 'site' ][ 'views' ][ 'users' ].Users_Listing_VIEW( urlData, false, resultStruct[ 'result' ] );

            } catch( any e ){

                writeDump( e );

            }


        }


    //   **********************************************************************  
    //   *  User Listing Page - END                                 
    //   **********************************************************************  

    //   **********************************************************************  
    //   *  User Create Page - START
    //   **********************************************************************  

        public void function Users_Create_RETRIEVE( required struct urlData, boolean debug ){

            try{

                //structs
                var userStruct                      = structNew();
                var userSecurityRoleTypesStruct     = {};
                var cfsqltypeLookupStruct           = { 
                    'array'         :   'array',
                    'bigint'        :   'bigint',
                    'binaryt'       :   'binary',
                    'bit'           :   'bit',
                    'longvarbinary' :   'blob',
                    'char'          :   'varchar',
                    'clob'          :   'nclob',
                    'date'          :   'date',
                    'decimal'       :   'decimal',
                    'distinct'      :   'distinct',
                    'double'        :   'double',
                    'real'          :   'float',
                    'integer'       :   'integer',
                    'image'         :   'longvarbinary',
                    'ntext'         :   'longnvarchar',
                    'text'          :   'longvarchar',
                    'nchar'         :   'varchar',
                    'nvarchar'      :   'varchar',
                    'null'          :   'null',
                    'numeric'       :   'numeric',
                    'nvarchar'      :   'varchar',
                    'other'         :   'other',
                    'ref'           :   'refcursor',
                    'smallint'      :   'smallint',
                    'struct'        :   'struct',
                    'xml'           :   'sqlxml',
                    'int'           :   'integer',
                    'time'          :   'time',
                    'datetime'      :   'timestamp',
                    'tinyint'       :   'integer',
                    'varbinary'     :   'varbinary',
                    'varchar'       :   'varchar'
                };

                //arrays
                var fieldArray                      = [];
                var typeArray                       = [];

                //Queries
                userData                            = queryNew( '' );

                //Numerics
                var idx                             = 1;

                //Strings
                var key                             = '';

                urlData[ 'userID' ]     =  ( structKeyExists( urlData, 'userID' ) && urlData[ 'userID' ] != '' && urlData[ 'userID' ] )? urlData[ 'userID' ] : 0; 

                userStruct              = application.adminPanel.components.site.models.users.Users_Create_READ( urlData ); 
                
                listofLocations         = application.adminPanel.components.site.models.users.Users_ListOfLocations_READ();

                userSecurityRoleTypes   = application.adminPanel.components.site.models.users.Users_SecurityRoleTypes_READ();

                entryPointInfo          = application.adminPanel.components.site.models.users.Users_EntryPointInfo_READ();

                roleTypeQoQ             = '
            
                    SELECT  *
                    FROM    userSecurityRoleTypes.result
                    WHERE   type = :type
            
                ';

                fieldArray  = listToArray( valueList( userStruct.fielddata.field ) );
                typeArray   = listToArray( valueList( userStruct.fielddata.type ) );


                for( idx; idx <= arrayLen( fieldArray ); idx++ ){

                    fieldTypeStruct[ fieldArray[ idx ] ] = cfsqltypeLookupStruct[ reReplaceNoCase( typeArray[ idx ], "(.*)\([0-9]*\).*", '\1' ) ];

                }

                for( key in fieldTypeStruct ){

                    switch( key ){

                        case 'userType':

                            queryAddColumn( userData, key, fieldTypeStruct[ key ], [urlData.userType] );

                            break;

                        case 'email':

                            queryAddColumn( userData, key, fieldTypeStruct[ key ], [urlData.email] );

                            break;

                        default:

                            queryAddColumn( userData, key, fieldTypeStruct[ key ], [''] );

                            break;

                    }

                }

                for( type in listRemoveDuplicates( valueList( userSecurityRoleTypes.result.type ), ',', true ) ){

                    query = queryExecute( roleTypeQoQ, { type = { value=type, cfsqltype='cf_sql_integer' } }, { dbtype='query', result='metaData' } );

                    structInsert( userSecurityRoleTypesStruct, type, query );

                }

                savecontent variable="htmlBlob"{
                    application.adminPanel.components.site.views.users.Users_Create_VIEW( urlData, userData, listOfLocations.result, userSecurityRoleTypes.result, entryPointInfo.result, userSecurityRoleTypesStruct, false, true );
                }

                domData         = application.adminPanel.java.jSoup.parse( htmlBlob ).select( 'form' );
                fieldsets       = domData.select( "fieldset[securitylevel]" );
                securityLevel   = application.securityRoles[ trim( urlData.userType ) ];
                securityLevel   = ( structKeyExists( urlData, 'userType' ) && urlData.userType!= '' ) ? application.securityRoles[ urlData.userType ] : securityLevel;

                //writeDump( application.securityRoles[ trim( resultStruct.result.userType ) ] ) abort;

                //remove fieldsets and input fieldset that the user and or page are not allowed to have
                fieldsets.each(function( element, idx ){
                    if( element.attr('securitylevel') > securityLevel ){
                        domData.select( "fieldset[securitylevel=#element.attr('securitylevel')#]" ).remove();
                    } else {             
                        element.select( "div[securitylevel]" ).each( function( subel, subidx ){
                            //writeDump( var=this, label='this in element loop' );
                            if( subel.attr('securitylevel') > securityLevel ){
                                element.select( "div[securitylevel=#subel.attr('securitylevel')#]" ).remove();
                            }
                        } )
                    }
                    
                });
                
                domData = application.adminPanel.components.utility.security.Security_DisableElementsByUserSecurityLevels_RENDER( formData, domData, 'input,textarea,select,button' );

                writeOutput( domData.outerHtml() );

            }catch( any e ){

                writeDump( e );

            }


        }

        public void function Users_Create_PROCESS( required struct formData, boolean debug ){

            //structs
            var resultStruct    = {};
            var jsonStruct      = {};

            //Array
            var booleanArray    = [];

            //Booleans
            var arrayPos        = 1;

            //set default shape for jsonStruct and booleanArray
            jsonStruct      = application.adminPanel.components.utility.datastructures.DataStructure_JSONStruct_GENERATE();
            booleanArray    = application.adminPanel.components.utility.datastructures.DataStructure_BooleanArray_GENERATE();

            //Set values for each step the hydra method will have to validate, mainly locations and messages
            booleanArray[ 1 ][ 'locationOnSuccess' ] = application.adminPanel.components.utility.strings.Strings_GeneratePageHref_TASK( 'userListing' );
            booleanArray[ 1 ][ 'locationOnFailure' ] = 'noredirect';

            jsonStruct[ 'onSuccess' ][ 'message' ][ 1 ]  =  'You''ve successfully removed the previous user.';
            jsonStruct[ 'onSuccess' ][ 'status' ][ 1 ]   = 'success';

            jsonStruct[ 'onFailure' ][ 'message' ][ 1 ]  = 'Something has gone wrong with removing the previous user, please try again later.' ;
            jsonStruct[ 'onFailure' ][ 'status' ][ 1 ]   = 'failure';

            try{    

                formData                = variables.Users_Create_PROCESS___validateFormVariables( formData );

                formData[ 'query' ]     = variables.Users_Create_PROCESS___shapeQuery( formData );
                
                resultStruct            = application.adminPanel.components.site.models.users.Users_Create_CREATE( formData );

                application.adminPanel.components.utility.hydras.Hydra_Basic_TASK( formData, resultStruct, booleanArray, arrayPos, jsonStruct );

            } catch( any e ){

                var errorStruct = {};
                errorStruct[ 'cfcatch' ]        = e;
                errorStruct[ 'arguments' ]      = ARGUMENTS;
                errorStruct[ 'resultStruct' ]   = resultStruct;

                writeDump( errorStruct );
                abort;

            }

        }

        private struct function Users_Create_PROCESS___validateFormVariables( required struct formData, boolean debug ){

            //Lists
            var falseIfNotDefinedList   = 'passwordReset,serverSecurity,rollSecurity,siteSecurity,wlSecurity,eCommSecurity,listEmployee,listAssociate';
            var nullIfNotDefinedList    = 'employeeLocations,associateLocations';

            for( key in falseIfNotDefinedList ){

                formData[ key ] = ( structKeyExists( formData, key ) ) ? formData[ key ] : 0;

            }

            for( key in nullIfNotDefinedList ){

                formData[ key ] = ( structKeyExists( formData, key ) ) ? formData[ key ] : '';

            }


            return formData;

        }

        private string function Users_Create_PROCESS___shapeQuery( required struct formData ){

            //strings
            var queryString = '';


            //arrays
            var stringArray = [];

            stringArray[ 1 ] = "
            Insert Into srlighting.users(
                siteID, 
                email, 
                password, 
                userType,
                fName, 
                lName, 
                title, 
                company, 
                address1, 
                address2, 
                city, 
                state, 
                zip, 
                phone1, 
                phoneType1, 
                phone2, 
                phoneType2, 
                linkedIn, 
                twitter, 
                facebook,
                privateNotes, 
                publicNotes
                )    
            ";

            stringArray[ 2 ] = "
            Values(
                    :siteID,
                    :email,
                    :password,
                    :userType,
                    :fName,
                    :lName,
                    :title, 
                    :company,
                    :address1,
                    :address2,
                    :city,
                    :state,
                    :zip,
                    :phone1,
                    :phoneType1,
                    :phone2,
                    :phoneType2,
                    :linkedIn,
                    :twitter,
                    :facebook,
                    :privateNotes,
                    :publicNotes
                )
            ";

            queryString = arrayToList( stringArray , '' );
                     
            return queryString;

        }

        public void function Users_Check_PROCESS( required struct formData, boolean debug ){

            
            //structs
            var resultStruct                    = {};
            var jsonStruct                      = {};
            var resultStruct                    = {};
            var listOfLocationsStruct           = {};
            var entryPointInfo                  = {};
            var userSecurityRoleTypesStruct     = {};
            var metaData                        = {};
            var element                         = {};

            //strings
            var type                            = '';
            var query                           = '';
            var htmlBlob                        = '';
            var key                             = '';

            //Array
            var booleanArray                    = [];
            var elements                        = [];
            var domData                         = [];
            var subels                          = [];
            var fieldTypeStruct                 = {};
            var cfsqltypeLookupStruct           = { 
                'array'         :   'array',
                'bigint'        :   'bigint',
                'binaryt'       :   'binary',
                'bit'           :   'bit',
                'longvarbinary' :   'blob',
                'char'          :   'varchar',
                'clob'          :   'nclob',
                'date'          :   'date',
                'decimal'       :   'decimal',
                'distinct'      :   'distinct',
                'double'        :   'double',
                'real'          :   'float',
                'integer'       :   'integer',
                'image'         :   'longvarbinary',
                'ntext'         :   'longnvarchar',
                'text'          :   'longvarchar',
                'nchar'         :   'varchar',
                'nvarchar'      :   'varchar',
                'null'          :   'null',
                'numeric'       :   'numeric',
                'nvarchar'      :   'varchar',
                'other'         :   'other',
                'ref'           :   'refcursor',
                'smallint'      :   'smallint',
                'struct'        :   'struct',
                'xml'           :   'sqlxml',
                'int'           :   'integer',
                'time'          :   'time',
                'datetime'      :   'timestamp',
                'tinyint'       :   'integer',
                'varbinary'     :   'varbinary',
                'varchar'       :   'varchar'
            };
            
            //arrays
            var fieldsArray                     = [];
            var typeArray                       = [];
            
            //queries
            var roleTypeQoQ                     = queryNew( '' );
            var userSecurityRoleTypes           = queryNew( '' );
            var userData                        = queryNew( '' );    

            //numerics
            var idx                             = 1;
            var value                           = 1;
            var securityLevel                   = 1;
            var arrayPos                        = 1;

            //strings
            var field                           = '';
                                          
            //booleans
            local.debug                         = arguments.debug?: false;

            //set default shape for jsonStruct and booleanArray
            jsonStruct      = application.adminPanel.components.utility.datastructures.DataStructure_JSONStruct_GENERATE();
            booleanArray    = application.adminPanel.components.utility.datastructures.DataStructure_BooleanArray_GENERATE();

            //Set values for each step the hydra method will have to validate, mainly locations and messages
            booleanArray[ 1 ][ 'locationOnSuccess' ] = 'noredirect';
            booleanArray[ 1 ][ 'locationOnFailure' ] = 'noredirect';

            jsonStruct[ 'onSuccess' ][ 'message' ][ 1 ]             = 'You''ve successfully check the previous user.';
            jsonStruct[ 'onSuccess' ][ 'status' ][ 1 ]              = 'success';
            jsonStruct[ 'onSuccess' ][ 'location' ]                 = 'noredirect';

            jsonStruct[ 'onFailure' ][ 'message' ][ 1 ]             = 'Something has gone wrong with removing the previous user, please try again later.' ;
            jsonStruct[ 'onFailure' ][ 'status' ][ 1 ]              = 'failure' ;

            try{    

                resultStruct            = application.adminPanel.components.site.models.users.Users_Check_READ( formData );

                listofLocations         = application.adminPanel.components.site.models.users.Users_ListOfLocations_READ();

                userSecurityRoleTypes   = application.adminPanel.components.site.models.users.Users_SecurityRoleTypes_READ();

                entryPointInfo          = application.adminPanel.components.site.models.users.Users_EntryPointInfo_READ();

                roleTypeQoQ                 = '
            
                    SELECT  *
                    FROM    userSecurityRoleTypes.result
                    WHERE   type = :type
            
                ';

                fieldArray  = listToArray( valueList( resultStruct.fielddata.field ) );
                typeArray   = listToArray( valueList( resultStruct.fielddata.type ) );


                for( idx; idx <= arrayLen( fieldArray ); idx++ ){

                    fieldTypeStruct[ fieldArray[ idx ] ] = cfsqltypeLookupStruct[ reReplaceNoCase( typeArray[ idx ], "(.*)\([0-9]*\).*", '\1' ) ];

                }

                for( key in fieldTypeStruct ){

                    field = formData[ key ]?: '';

                    queryAddColumn( userData, key, fieldTypeStruct[ key ], [field] );

                }

                for( type in listRemoveDuplicates( valueList( userSecurityRoleTypes.result.type ), ',', true ) ){

                    query = queryExecute( roleTypeQoQ, { type = { value=type, cfsqltype='cf_sql_integer' } }, { dbtype='query', result='metaData' } );

                    structInsert( userSecurityRoleTypesStruct, type, query );

                }

                savecontent variable='htmlBlob'{

                    writeOutput( application.adminPanel.components.utility.HTMLElements.HTMLELEMENTS_UserCrudForms_RENDER( formData, userData, listOfLocations.result, userSecurityRoleTypes.result, entryPointInfo.result, userSecurityRoleTypesStruct, formData.formInvokeMethod, true ) );

                }

                
                domData         = application.adminPanel.java.jSoup.parse( htmlBlob ).select( 'form' );
                fieldsets       = domData.select( "fieldset[securitylevel]" );
                securityLevel   = application.securityroles[ formData.userType ];

                //writeDump( application.securityRoles[ trim( resultStruct.result.userType ) ] ) abort;

                //remove fieldsets and input fieldset that the user and or page are not allowed to have
                fieldsets.each(function( element, idx ){
                    if( element.attr('securitylevel') > securityLevel ){
                        domData.select( "fieldset[securitylevel=#element.attr('securitylevel')#]" ).remove();
                    } else {             
                        element.select( "div[securitylevel]" ).each( function( subel, subidx ){
                            //writeDump( var=this, label='this in element loop' );
                            if( subel.attr('securitylevel') > securityLevel ){
                                element.select( "div[securitylevel=#subel.attr('securitylevel')#]" ).remove();
                            }
                        })
                    }
                    
                });

                domData = application.adminPanel.components.utility.security.Security_DisableElementsByUserSecurityLevels_RENDER( formData, domData, 'input,textarea,select,button' );
                
                savecontent variable='htmlBlob'{

                    writeOutput( domData.outerHtml() );

                }


                if( resultStruct.result.recordCount ){

                    jsonStruct[ 'onSuccess' ][ 'js' ][ 'argsOptions' ][ 1 ] = {

                        'isJson' = true,
                        'targetId' = '##checkEmail'

                    };

                    jsonStruct[ 'onSuccess' ][ 'js' ][ 'args' ][ 1 ]        =   '{ 
                        "title":"Existing User",
                        "text":"We found this user in our database!",
                        "showCancelButton":true,
                        "cancelButtonColor":"##00aae7",
                        "confirmButtonColor":"##002d5b",
                        "cancelButtonText":"Try Again",
                        "confirmButtonText":"Edit User"
                     }';
                    jsonStruct[ 'onSuccess' ][ 'js' ][ 'callback' ][ 1 ]    =   'swal';

                } else {

                    jsonStruct[ 'onSuccess' ][ 'js' ][ 'argsOptions' ][ 1 ] = {

                        'isJson' = false
                        
                    };

                    jsonStruct[ 'onSuccess' ][ 'js' ][ 'args' ][ 1 ]        =   htmlBlob;  
                    jsonStruct[ 'onSuccess' ][ 'js' ][ 'callback' ][ 1 ]    =   'appendHTMLToRightSidebar';

                }

                jsonStruct[ 'onFailure' ][ 'js' ][ 'args' ][ 1 ]            =   "something when wrong, please try again at a later time";  
                jsonStruct[ 'onFailure' ][ 'js' ][ 'callback' ][ 1 ]        =   'swal';

                application.adminPanel.components.utility.hydras.Hydra_Basic_TASK( formData, resultStruct, booleanArray, arrayPos, jsonStruct );

            } catch( any e ){

                var errorStruct = {};
                errorStruct[ 'cfcatch' ]        = e;
                errorStruct[ 'arguments' ]      = ARGUMENTS;
                errorStruct[ 'resultStruct' ]   = resultStruct;

                writeDump( errorStruct );

            }


        }

    //   **********************************************************************  
    //   *  User Create Page - END                                 
    //   **********************************************************************  
    
    //   **********************************************************************  
    //   *  User Copy Page - START
    //   **********************************************************************  

        public void function Users_Copy_RETRIEVE( required struct urlData, boolean debug ){

            try{

                //structs
                var userStruct                      = structNew();
                var userSecurityRoleTypesStruct     = {};
                var cfsqltypeLookupStruct           = { 
                    'array'         :   'array',
                    'bigint'        :   'bigint',
                    'binaryt'       :   'binary',
                    'bit'           :   'bit',
                    'longvarbinary' :   'blob',
                    'char'          :   'varchar',
                    'clob'          :   'nclob',
                    'date'          :   'date',
                    'decimal'       :   'decimal',
                    'distinct'      :   'distinct',
                    'double'        :   'double',
                    'real'          :   'float',
                    'integer'       :   'integer',
                    'image'         :   'longvarbinary',
                    'ntext'         :   'longnvarchar',
                    'text'          :   'longvarchar',
                    'nchar'         :   'varchar',
                    'nvarchar'      :   'varchar',
                    'null'          :   'null',
                    'numeric'       :   'numeric',
                    'nvarchar'      :   'varchar',
                    'other'         :   'other',
                    'ref'           :   'refcursor',
                    'smallint'      :   'smallint',
                    'struct'        :   'struct',
                    'xml'           :   'sqlxml',
                    'int'           :   'integer',
                    'time'          :   'time',
                    'datetime'      :   'timestamp',
                    'tinyint'       :   'integer',
                    'varbinary'     :   'varbinary',
                    'varchar'       :   'varchar'
                };

                //arrays
                var fieldArray                      = [];
                var typeArray                       = [];

                //Queries
                userData                            = queryNew( '' );

                //Numerics
                var idx                             = 1;

                //Strings
                var key                             = '';

                urlData[ 'userID' ]     =  ( structKeyExists( urlData, 'userID' ) && urlData[ 'userID' ] != '' && urlData[ 'userID' ] )? urlData[ 'userID' ] : 0; 

                userStruct              = application.adminPanel.components.site.models.users.Users_Create_READ( urlData ); 
                
                listofLocations         = application.adminPanel.components.site.models.users.Users_ListOfLocations_READ();

                userSecurityRoleTypes   = application.adminPanel.components.site.models.users.Users_SecurityRoleTypes_READ();

                entryPointInfo          = application.adminPanel.components.site.models.users.Users_EntryPointInfo_READ();

                roleTypeQoQ             = '
            
                    SELECT  *
                    FROM    userSecurityRoleTypes.result
                    WHERE   type = :type
            
                ';

                fieldArray  = listToArray( valueList( userStruct.fielddata.field ) );
                typeArray   = listToArray( valueList( userStruct.fielddata.type ) );


                for( idx; idx <= arrayLen( fieldArray ); idx++ ){

                    fieldTypeStruct[ fieldArray[ idx ] ] = cfsqltypeLookupStruct[ reReplaceNoCase( typeArray[ idx ], "(.*)\([0-9]*\).*", '\1' ) ];

                }


                for( type in listRemoveDuplicates( valueList( userSecurityRoleTypes.result.type ), ',', true ) ){

                    query = queryExecute( roleTypeQoQ, { type = { value=type, cfsqltype='cf_sql_integer' } }, { dbtype='query', result='metaData' } );

                    structInsert( userSecurityRoleTypesStruct, type, query );

                }

                savecontent variable="htmlBlob"{
                    application.adminPanel.components.site.views.users.Users_Copy_VIEW( urlData, userStruct.result, listOfLocations.result, userSecurityRoleTypes.result, entryPointInfo.result, userSecurityRoleTypesStruct, false, true );
                }

                domData         = application.adminPanel.java.jSoup.parse( htmlBlob ).select( 'form' );
                fieldsets       = domData.select( "fieldset[securitylevel]" );
                securityLevel   = application.securityRoles[ trim( userStruct.result.userType ) ];
                securityLevel   = ( structKeyExists( urlData, 'userType' ) && urlData.userType!= '' ) ? application.securityRoles[ urlData.userType ] : securityLevel;

                //writeDump( application.securityRoles[ trim( resultStruct.result.userType ) ] ) abort;

                //remove fieldsets and input fieldset that the user and or page are not allowed to have
                fieldsets.each(function( element, idx ){
                    if( element.attr('securitylevel') > securityLevel ){
                        domData.select( "fieldset[securitylevel=#element.attr('securitylevel')#]" ).remove();
                    } else {             
                        element.select( "*[securitylevel]" ).each( function( subel, subidx ){
                            //writeDump( var=this, label='this in element loop' );
                            if( subel.attr('securitylevel') > securityLevel ){
                                element.select( "*[securitylevel=#subel.attr('securitylevel')#]" ).remove();
                            }
                        } )
                    }
                    
                });
                
                domData = application.adminPanel.components.utility.security.Security_DisableElementsByUserSecurityLevels_RENDER( formData, domData, 'input,textarea,select,button' );

                writeOutput( domData.outerHtml() );

            }catch( any e ){

                writeDump( e );

            }


        }

        public void function Users_Copy_PROCESS( required struct formData, boolean debug ){

            //structs
            var resultStruct    = {};
            var jsonStruct      = {};

            //Array
            var booleanArray    = [];

            //Booleans
            var arrayPos        = 1;

            //set default shape for jsonStruct and booleanArray
            jsonStruct      = application.adminPanel.components.utility.datastructures.DataStructure_JSONStruct_GENERATE();
            booleanArray    = application.adminPanel.components.utility.datastructures.DataStructure_BooleanArray_GENERATE();

            //Set values for each step the hydra method will have to validate, mainly locations and messages
            booleanArray[ 1 ][ 'locationOnSuccess' ] = application.adminPanel.components.utility.strings.Strings_GeneratePageHref_TASK( 'userListing' );
            booleanArray[ 1 ][ 'locationOnFailure' ] = 'noredirect';

            jsonStruct[ 'onSuccess' ][ 'message' ][ 1 ]  =  'You''ve successfully removed the previous user.';
            jsonStruct[ 'onSuccess' ][ 'status' ][ 1 ]   = 'success';

            jsonStruct[ 'onFailure' ][ 'message' ][ 1 ]  = 'Something has gone wrong with removing the previous user, please try again later.' ;
            jsonStruct[ 'onFailure' ][ 'status' ][ 1 ]   = 'failure';

            try{    

                formData                = variables.Users_Create_PROCESS___validateFormVariables( formData );

                formData.password       = ( formData.passwordReset ) ? formData.password : formData.origPassword;

                formData[ 'query' ]     = variables.Users_Create_PROCESS___shapeQuery( formData );

                resultStruct            = application.adminPanel.components.site.models.users.Users_Create_CREATE( formData );

                application.adminPanel.components.utility.hydras.Hydra_Basic_TASK( formData, resultStruct, booleanArray, arrayPos, jsonStruct );

            } catch( any e ){

                var errorStruct = {};
                errorStruct[ 'cfcatch' ]        = e;
                errorStruct[ 'arguments' ]      = ARGUMENTS;
                errorStruct[ 'resultStruct' ]   = resultStruct;

                writeDump( errorStruct );
                abort;

            }

        }

    //   **********************************************************************  
    //   *  User Copy Page - END
    //   **********************************************************************  

    //   **********************************************************************  
    //   *  User Edit Page - START                               
    //   **********************************************************************  

        public void function Users_Edit_RETRIEVE( required struct urlData, boolean debug ){

            //struct
            var resultStruct                    = {};
            var listOfLocationsStruct           = {};
            var entryPointInfo                  = {};
            var userSecurityRoleTypesStruct     = {};
            var metaData                        = {};
            var element                         = {};

            //arrays
            var elements                        = [];
            var domData                         = [];
            var subels                          = [];

            //queries
            var roleTypeQoQ                     = queryNew( '' );
            var userSecurityRoleTypes           = queryNew( '' );

            //numerics
            var idx                             = 1;
            var value                           = 1;
            var securityLevel                   = 1;

            //strings
            var type                    = '';
            var query                   = '';
            var htmlBlob                = '';
            var key                     = '';
         

            //booleans
            local.debug                   = arguments.debug?: false;

            try{

                resultStruct            = application.adminPanel.components.site.models.users.Users_Edit_READ( urlData );

                listofLocations         = application.adminPanel.components.site.models.users.Users_ListOfLocations_READ();

                userSecurityRoleTypes   = application.adminPanel.components.site.models.users.Users_SecurityRoleTypes_READ();

                entryPointInfo          = application.adminPanel.components.site.models.users.Users_EntryPointInfo_READ();

                roleTypeQoQ                 = '
            
                    SELECT  *
                    FROM    userSecurityRoleTypes.result
                    WHERE   type = :type
            
                ';

                for( type in listRemoveDuplicates( valueList( userSecurityRoleTypes.result.type ), ',', true ) ){

                    query = queryExecute( roleTypeQoQ, { type = { value=type, cfsqltype='cf_sql_integer' } }, { dbtype='query', result='metaData' } );

                    structInsert( userSecurityRoleTypesStruct, type, query );

                }

                savecontent variable='htmlBlob'{

                    writeOutput( application.adminPanel.components.site.views.users.Users_Edit_VIEW( urlData, resultStruct.result, listOfLocations.result, userSecurityRoleTypes.result, entryPointInfo.result, userSecurityRoleTypesStruct, local.debug ) );

                }

                
                domData         = application.adminPanel.java.jSoup.parse( htmlBlob ).select( 'form' );
                fieldsets       = domData.select( "fieldset[securitylevel]" );
                securityLevel   = application.securityRoles[ trim( resultStruct.result.userType ) ];
                securityLevel   = ( structKeyExists( urlData, 'userType' ) && urlData.userType!= '' ) ? application.securityRoles[ urlData.userType ] : securityLevel;

                //writeDump( application.securityRoles[ trim( resultStruct.result.userType ) ] ) abort;

                //remove fieldsets and input fieldset that the user and or page are not allowed to have
                fieldsets.each(function( element, idx ){
                    if( element.attr('securitylevel') > securityLevel ){
                        domData.select( "fieldset[securitylevel=#element.attr('securitylevel')#]" ).remove();
                    } else {             
                        element.select( "*[securitylevel]" ).each( function( subel, subidx ){
                            //writeDump( var=this, label='this in element loop' );
                            if( subel.attr('securitylevel') > securityLevel ){
                                element.select( "*[securitylevel=#subel.attr('securitylevel')#]" ).remove();
                            }
                        } )
                    }
                    
                });

                domData = application.adminPanel.components.utility.security.Security_DisableElementsByUserSecurityLevels_RENDER( urlData, domData, 'input,textarea,select,button' );

                writeOutput( domData.outerHtml() );

            }catch( any e ){

                var errorStruct                 = structNew();
                errorStruct[ 'cfcatch' ]        = e;
                errorStruct[ 'ARGUMENTS' ]      = arguments;
                errorStruct[ 'VARIABLES' ]      = variables;
                errorStruct[ 'resultStruct' ]   = {};
                
                writeDump( errorStruct );

            }


        }
    
        public void function Users_Edit_PROCESS( required struct formData, boolean debug ){

            //structs
            var resultStruct    = {};
            var jsonStruct      = {};

            //Array
            var booleanArray    = [];

            //Booleans
            var arrayPos        = 1;

            //set default shape for jsonStruct and booleanArray
            jsonStruct      = application.adminPanel.components.utility.datastructures.DataStructure_JSONStruct_GENERATE();
            booleanArray    = application.adminPanel.components.utility.datastructures.DataStructure_BooleanArray_GENERATE();

            //Set values for each step the hydra method will have to validate, mainly locations and messages
            booleanArray[ 1 ][ 'locationOnSuccess' ] = application.adminPanel.components.utility.strings.Strings_GeneratePageHref_TASK( 'userListing' );
            booleanArray[ 1 ][ 'locationOnFailure' ] = 'noredirect';

            jsonStruct[ 'onSuccess' ][ 'message' ][ 1 ]  = 'You''ve successfully edited the previous user.';
            jsonStruct[ 'onSuccess' ][ 'status' ][ 1 ]   = 'success';

            jsonStruct[ 'onFailure' ][ 'message' ][ 1 ]  = 'Something has gone wrong with removing the previous user, please try again later.';
            jsonStruct[ 'onFailure' ][ 'status' ][ 1 ]   = 'failure';

            try{    

                formData                = variables.Users_Edit_PROCESS___validateFormVariables( formData );

                formData.password       = ( formData.passwordReset ) ? formData.password : formData.origPassword;

                formData[ 'query' ]     = variables.Users_Edit_PROCESS___shapeQuery( formData );

                resultStruct            = application.adminPanel.components.site.models.users.Users_Edit_UPDATE( formData );

                application.adminPanel.components.utility.hydras.Hydra_Basic_TASK( formData, resultStruct, booleanArray, arrayPos, jsonStruct );

            } catch( any e ){

                var errorStruct = {};
                errorStruct[ 'cfcatch' ]        = e;
                errorStruct[ 'arguments' ]      = ARGUMENTS;
                errorStruct[ 'resultStruct' ]   = resultStruct;

                writeDump( errorStruct );

            }

        }


        private struct function Users_Edit_PROCESS___validateFormVariables( required struct formData, boolean debug ){

            //Lists
            var falseIfNotDefinedList   = 'passwordReset,active';
            var mullIfEmptyStringList   = '';
            var ifEmptyThenBoolean      = 'validated,active';

            for( key in falseIfNotDefinedList ){

                formData[ key ] = ( structKeyExists( formData, key ) ) ? formData[ key ] : 0;

            }

            for( key in mullIfEmptyStringList ){

                formData[ key ] = ( structKeyExists( formData, key ) ) ? formData[ key ] : '';

            }

            for( key in ifEmptyThenBoolean ){

                formData[ key ] = ( structKeyExists( formData, key ) && formData[ key ] != '' ) ? formData[ key ] : 0;

            }


            return formData;

        }



        private string function Users_Edit_PROCESS___shapeQuery( required struct formData ){

            /**
             * @hint: This function dynamically builds the query we need for the model
             */

            //strings
            var queryString = '';


            //arrays
            var stringArray = [];

            stringArray[ 1 ] = "
                Update users 
                    Set userType = :userType,      
            ";

            if( structKeyExists( formData, 'passwordReset' ) ){

                stringArray[ 2 ] = "
                    password = :password,
                    passwordChange = :passwordChange,
                ";

            } else {

                stringArray[ 2 ] = '';

            }

            stringArray[ 3 ] = "
                    fName           =   :fName,
                    lName           =   :lName,
                    title           =   :title,
                    company         =   :company,
                    accountNumber   =   :accountNumber,
                    validated       =   :validated,
                    passwordPrivate =   :passwordPrivate,
                    address1        =   :address1,
                    address2        =   :address2,
                    city            =   :city,
                    state           =   :state,
                    zip             =   :zip,
                    phone1          =   :phone1,
                    phoneType1      =   :phoneType1,
                    phone2          =   :phone2,
                    phoneType2      =   :phoneType2,
                    linkedIn        =   :linkedIn,
                    twitter         =   :twitter,
                    facebook        =   :facebook,
                    privateNotes    =   :privateNotes,
                    publicNotes     =   :publicNotes,
                    active          =   :active
                Where userID = :userID
                AND siteID = :siteID
            ";

                            
            queryString = arrayToList( stringArray , '' );

            return queryString;

        }


    //   **********************************************************************  
    //   *  User Edit Page - END                               
    //   ********************************************************************** 

    //   **********************************************************************  
    //   *  User Remove Page - START                               
    //   **********************************************************************
    
        public void function Users_Remove_PROCESS( required struct formData, boolean debug ){

            //structs
            var resultStruct    = {};
            var jsonStruct      = {};

            //Array
            var booleanArray    = [];

            //Numerics
            var arrayPos        = 1;

            try{  
                
                //set default shape for jsonStruct and booleanArray
                jsonStruct      = application.adminPanel.components.utility.datastructures.DataStructure_JSONStruct_GENERATE();
                booleanArray    = application.adminPanel.components.utility.datastructures.DataStructure_BooleanArray_GENERATE();

                //Set values for each step the hydra method will have to validate, mainly locations and messages
                booleanArray[ 1 ][ 'locationOnSuccess' ] = application.adminPanel.components.utility.strings.Strings_GeneratePageHref_TASK( 'userListing' );
                booleanArray[ 1 ][ 'locationOnFailure' ] = 'noredirect';

                jsonStruct[ 'onSuccess' ][ 'message' ][ 1 ]  = 'You''ve successfully removed the previous user.';
                jsonStruct[ 'onSuccess' ][ 'status' ][ 1 ]   = 'success';

                jsonStruct[ 'onFailure' ][ 'message' ][ 1 ]  = 'Something has gone wrong with removing the previous user, please try again later.';
                jsonStruct[ 'onFailure' ][ 'status' ][ 1 ]   = 'failure';

                resultStruct    = application.adminPanel.components.site.models.users.Users_Remove_DELETE( formData );

                application.adminPanel.components.utility.hydras.Hydra_Basic_TASK( formData, resultStruct, booleanArray, arrayPos, jsonStruct );

            } catch( any e ){

                var errorStruct = {};
                errorStruct[ 'cfcatch' ]        = e;
                errorStruct[ 'arguments' ]      = ARGUMENTS;
                errorStruct[ 'resultStruct' ]   = resultStruct;

                writeDump( errorStruct );

            }
            
        }


    //   **********************************************************************  
    //   *  User Remove Page - END                               
    //   ********************************************************************** 
    
    //   **********************************************************************
    //   *  Users Get Info - START
    //   **********************************************************************

        public void function Users_Get_Info_PROCESS( required struct formData, boolean debug ){

            //Struct
            resultStruct  = structNew();

            try{

                resultStruct = application.adminPanel.components.site.models.users.Users_Get_Info_READ( formData );
                formData.userID = resultStruct.result.userID;
                formData.page = 'edit';
                
                this.Users_Edit_RETRIEVE( formData );

            } catch( any e ){

                writeDump( resultStruct );
                writeDump( e );

            }

        }


    //   **********************************************************************
    //   *  Users Get Info - END
    //   **********************************************************************

    //   **********************************************************************
    //   *  Users Get Info By Email - START
    //   **********************************************************************

        public void function Users_Get_Info_By_Email_PROCESS( required struct formData, boolean debug ){

            //Struct
            resultStruct  = structNew();
            jsonStruct    = structNew();

            try{

                jsonStruct      = application.adminPanel.components.utility.datastructures.DataStructure_JSONStruct_GENERATE();
                resultStruct    = application.adminPanel.components.site.models.users.Users_Get_Info_READ( formData );

                if( resultStruct.result.recordCount ){
                    
                    jsonStruct[ 'growl' ][ 'message' ]  = 'This email is already registered to this site.';
                    jsonStruct[ 'growl' ][ 'status' ]   = 'warning';
                    jsonStruct[ 'formActions' ]         = {

                        'disabled' = true

                    };

                } else {

                    jsonStruct[ 'growl' ][ 'message' ]  = 'This email is available!';
                    jsonStruct[ 'growl' ][ 'status' ]   = 'success';
                    jsonStruct[ 'formActions' ]         = {

                        'disabled' = false

                    };

                }

                writeOutput( 
                        
                    serializeJSON( jsonStruct ) 
                
                );

            } catch( any e ){

                writeDump( resultStruct );
                writeDump( e );

            }

        }


    //   **********************************************************************
    //   *  Users Get Info By Email - END
    //   **********************************************************************

    //   **********************************************************************
    //   *  Users Export Page - START
    //   **********************************************************************

        public void function Users_Export_RETRIEVE( required struct urlData, boolean debug ){

            //structs
            var resultStruct            = {};
            var mySpreadsheet           = {};
            var workbook                = {};
            var sheet                   = {};
            var dvconstraint            = {};
            var cellRangeList           = {};
            var dataValidation          = {};
            var roleList                = {};
            var roleConstraint          = {};
            var phone1TypeList          = {};
            var phone1TypeConstraint    = {};
            var phone2TypeList          = {};
            var phone2TypeConstraint    = {};

            //strings
            var query = '';

            //lists
            var columnWidths = '';

            //numerics
            var loopCounter = 1;

            //arrays
            var stringArray = [];

            try{

                arrayAppend( stringArray,
                    "
                        SELECT userType, null as securityRole, fName, lName, title, company, email, address1, address2, city, state, zip,
                            phone1, case phoneType1 when 0 then 'Office' when 1 then 'Cell' when 2 then 'Home' when 3 then 'Other' else '' end as phoneType1, 
                            phone2, case phoneType2 when 0 then 'Office' when 1 then 'Cell' when 2 then 'Home' when 3 then 'Other' else '' end as phoneType2, 
                            linkedIn, faceBook, twitter, publicNotes, privateNotes
                        From users
                        Where siteid = :siteID
                    "
                );

                if( lcase( urlData[ 'userType' ] ) != 'any' ){

                    arrayAppend( stringArray,
                        "
                            AND userType = :userType
                        "
                    );

                }

                arrayAppend(  stringArray,
                    "
                    ORDER BY lName

                    "
                );

            
                query =  arrayToList( stringArray, '' );

                resultStruct = application.adminPanel.components.site.models.users.Users_Export_READ( query, userType );

                //New Spreadsheet
                mySpreadsheet = SpreadSheetNew("User Data");
                
                //Get Workbook object
                workbook = mySpreadsheet.getWorkBook();
                //Get sheet by name for list validation
                sheet = workbook.getSheet("User Data");
                //Create object of required class
                dvconstraint = createObject("java","org.apache.poi.hssf.usermodel.DVConstraint");
                cellRangeList = createObject("java","org.apache.poi.ss.util.CellRangeAddressList");
                dataValidation = createObject("java","org.apache.poi.hssf.usermodel.HSSFDataValidation");
                // Define cell list for security (rowStart, rowEnd, columnStart, columnEnd)
                roleList = cellRangeList.init(0, resultStruct.result.recordCount+20, 1, 1);
                roleConstraint = dvconstraint.createExplicitListConstraint(["Basic","Mid-Level","Full"]);
                dataValidation.init(roleList, roleConstraint);
                dataValidation.setSuppressDropDownArrow(false);
                sheet.addValidationData(dataValidation);
                //Define cell list for phone1 types (rowStart, rowEnd, columnStart, columnEnd)
                phone1TypeList = cellRangeList.init(0, resultStruct.result.recordCount+20, 13, 13);
                phone1TypeConstraint = dvconstraint.createExplicitListConstraint(["Office","Cell","Home","Other"]);
                dataValidation.init(phone1TypeList, phone1TypeConstraint);
                dataValidation.setSuppressDropDownArrow(false);
                sheet.addValidationData(dataValidation);
                //Define cell list for phone2 types (rowStart, rowEnd, columnStart, columnEnd)
                phone2TypeList = cellRangeList.init(0, resultStruct.result.recordCount+20, 15, 15);
                phone2TypeConstraint = dvconstraint.createExplicitListConstraint(["Office","Cell","Home","Other"]);
                dataValidation.init(phone2TypeList, phone2TypeConstraint);
                dataValidation.setSuppressDropDownArrow(false);
                sheet.addValidationData(dataValidation);

                //Add header row
                SpreadsheetAddRow(mySpreadsheet, "User_Type,Security_Role,First_Name,Last_Name,Title,Company,Email,Address1,Address2,City,State,Zip,Phone1,Phone1_Type,Phone2,Phone2_Type,LinkedIn,FaceBook,Twitter,Public_Notes,Private_Notes");
                SpreadsheetFormatRow(mySpreadsheet,{bold="True"},1);
                //Set Column Widths
                columnWidths = "15,15,30,30,25,25,50,30,30,30,15,15,20,20,20,20,30,30,30,50,50";
                loopCounter = 1;

                for( i in columnWidths ){

                    SpreadSheetSetColumnWidth( mySpreadsheet,loopCounter,i );
                    loopCounter++;

                }

                //Add the data to the spreadsheet
                application.adminPanel.components.utility.spreadsheets.spreadsheetAddRowsForceTextFormat(mySpreadsheet, resultStruct.result, [12,13,15]);
                // emove / add bold where it needs to be
                SpreadsheetFormatColumn(mySpreadsheet,{bold='false'},12);
                SpreadsheetFormatColumn(mySpreadsheet,{bold='false'},13);
                SpreadsheetFormatColumn(mySpreadsheet,{bold='false'},15);
                SpreadsheetFormatRow(mySpreadsheet,{bold='true'},1);

                application.adminPAnel.components.site.views.users.Users_Export_VIEW( urlData, mySpreadsheet );


            } catch( any e ){

                writeDump( e );

            }

        }

    //   **********************************************************************
    //   *  Users Export Page - END
    //   **********************************************************************

    //   **********************************************************************  
    //   *  User Trade Professional Listing  Page - START                               
    //   **********************************************************************  


        public void function Users_Trade_Listing_RETRIEVE( required struct urlData ){

            //Structs
            var resultStruct = {};

            try{

                resultStruct = APPLICATION[ 'adminPanel' ][ 'components' ][ 'site' ][ 'models' ][ 'users' ].Users_Trade_Listing_READ();

                APPLICATION[ 'adminPanel' ][ 'components' ][ 'site' ][ 'views' ][ 'users' ].Users_Trade_Listing_VIEW( urlData, false, resultStruct[ 'result' ] );

            } catch( any e ){

                writeDump( e );

            }


        }


    //   **********************************************************************  
    //   *  User Trade Professional Listing  Page - END                                 
    //   **********************************************************************  

    //   **********************************************************************  
    //   *  User Trade Professional Create  Page - START
    //   **********************************************************************  

        public void function Users_Trade_Create_RETRIEVE( required struct urlData, boolean debug ){

            try{

                //structs
                var userStruct                          = structNew();
                var userSecurityRoleTypesStruct         = {};
                var cfsqltypeLookupStruct               = { 
                'array'         :   'array',
                'bigint'        :   'bigint',
                'binaryt'       :   'binary',
                'bit'           :   'bit',
                'longvarbinary' :   'blob',
                'char'          :   'varchar',
                'clob'          :   'nclob',
                'date'          :   'date',
                'decimal'       :   'decimal',
                'distinct'      :   'distinct',
                'double'        :   'double',
                'real'          :   'float',
                'integer'       :   'integer',
                'image'         :   'longvarbinary',
                'ntext'         :   'longnvarchar',
                'text'          :   'longvarchar',
                'nchar'         :   'varchar',
                'nvarchar'      :   'varchar',
                'null'          :   'null',
                'numeric'       :   'numeric',
                'nvarchar'      :   'varchar',
                'other'         :   'other',
                'ref'           :   'refcursor',
                'smallint'      :   'smallint',
                'struct'        :   'struct',
                'xml'           :   'sqlxml',
                'int'           :   'integer',
                'time'          :   'time',
                'datetime'      :   'timestamp',
                'tinyint'       :   'integer',
                'varbinary'     :   'varbinary',
                'varchar'       :   'varchar'
            };

                //arrays
                var fieldArray                      = [];
                var typeArray                       = [];

                //Queries
                var listofLocationsQuery    = queryNew( '' );
                var userSecurityRoleTypes   = queryNew( '' );
                var entryPointInfo          = queryNew( '' );
                var userData                = queryNew( '' );

                //Numerics
                var idx                             = 1;

                //Strings
                var key                             = '';


                urlData[ 'userID' ]     =  ( structKeyExists( urlData, 'userID' ) && urlData[ 'userID' ] != '' && urlData[ 'userID' ] )? urlData[ 'userID' ] : 0; 

                userStruct              = application.adminPanel.components.site.models.users.Users_Create_READ( urlData ); 
                
                listofLocationsQuery    = application.adminPanel.components.site.models.users.Users_ListOfLocations_READ();

                userSecurityRoleTypes   = application.adminPanel.components.site.models.users.Users_SecurityRoleTypes_READ();

                entryPointInfo          = application.adminPanel.components.site.models.users.Users_EntryPointInfo_READ();

                roleTypeQoQ                 = '
            
                    SELECT  *
                    FROM    userSecurityRoleTypes.result
                    WHERE   type = :type
            
                ';

                fieldArray  = listToArray( valueList( userStruct.fielddata.field ) );
                typeArray   = listToArray( valueList( userStruct.fielddata.type ) );


                for( idx; idx <= arrayLen( fieldArray ); idx++ ){

                    fieldTypeStruct[ fieldArray[ idx ] ] = cfsqltypeLookupStruct[ reReplaceNoCase( typeArray[ idx ], "(.*)\([0-9]*\).*", '\1' ) ];

                }

                for( key in fieldTypeStruct ){

                    switch( key ){

                        case 'userType':

                            queryAddColumn( userData, key, fieldTypeStruct[ key ], [urlData.userType] );

                            break;

                        case 'email':

                            queryAddColumn( userData, key, fieldTypeStruct[ key ], [urlData.email] );

                            break;

                        default:

                            queryAddColumn( userData, key, fieldTypeStruct[ key ], [''] );

                            break;

                    }

                }

                for( type in listRemoveDuplicates( valueList( userSecurityRoleTypes.result.type ), ',', true ) ){

                    query = queryExecute( roleTypeQoQ, { type = { value=type, cfsqltype='cf_sql_integer' } }, { dbtype='query', result='metaData' } );

                    structInsert( userSecurityRoleTypesStruct, type, query );

                }

                savecontent variable="htmlBlob"{
                    application.adminPanel.components.site.views.users.Users_Trade_Create_VIEW( urlData, userData, listOfLocationsQuery.result, userSecurityRoleTypes.result, entryPointInfo.result, userSecurityRoleTypesStruct, false, true );
                }

                domData         = application.adminPanel.java.jSoup.parse( htmlBlob ).select( 'form' );
                fieldsets       = domData.select( "fieldset[securitylevel]" );
                securityLevel   = application.securityRoles[ trim( urlData.userType ) ];
                securityLevel   = ( structKeyExists( urlData, 'userType' ) && urlData.userType!= '' ) ? application.securityRoles[ urlData.userType ] : securityLevel;

                //writeDump( application.securityRoles[ trim( resultStruct.result.userType ) ] ) abort;

                //remove fieldsets and input fieldset that the user and or page are not allowed to have
                fieldsets.each(function( element, idx ){
                    if( element.attr('securitylevel') > securityLevel ){
                        domData.select( "fieldset[securitylevel=#element.attr('securitylevel')#]" ).remove();
                    } else {             
                        element.select( "div[securitylevel]" ).each( function( subel, subidx ){
                            //writeDump( var=this, label='this in element loop' );
                            if( subel.attr('securitylevel') > securityLevel ){
                                element.select( "div[securitylevel=#subel.attr('securitylevel')#]" ).remove();
                            }
                        } )
                    }
                    
                });
                
                domData = application.adminPanel.components.utility.security.Security_DisableElementsByUserSecurityLevels_RENDER( urlData, domData, 'input,textarea,select,button' );

                writeOutput( domData.outerHtml() );

            }catch( any e ){

                writeDump( e );

            }


        }

        public void function Users_Trade_Create_PROCESS( required struct formData, boolean debug ){

            //structs
            var resultStruct    = {};
            var jsonStruct      = {};

            //Array
            var booleanArray    = [];

            //Numeric
            var arrayPos        = 1;

            //set default shape for jsonStruct and booleanArray
            jsonStruct      = application.adminPanel.components.utility.datastructures.DataStructure_JSONStruct_GENERATE();
            booleanArray    = application.adminPanel.components.utility.datastructures.DataStructure_BooleanArray_GENERATE();

            //Set values for each step the hydra method will have to validate, mainly locations and messages
            booleanArray[ 1 ][ 'locationOnSuccess' ] = application.adminPanel.components.utility.strings.Strings_GeneratePageHref_TASK( 'tradeListing' );
            booleanArray[ 1 ][ 'locationOnFailure' ] = 'noredirect';

            jsonStruct[ 'onFailure' ][ 'message' ] = [

                'Something has gone wrong with removing the previous user, please try again later.'

            ];

            jsonStruct[ 'onFailure' ][ 'status' ] = [

                'failure'

            ];
            
            for( key in jsonStruct[ 'onFailure' ][ 'message' ] ){

                arrayAppend( jsonStruct[ 'onSuccess' ][ 'message' ], 'You''ve successfully create the previous user.' );
                arrayAppend( jsonStruct[ 'onSuccess' ][ 'status' ], 'success' ); 

            }

            try{    

                formData                = variables.Users_Trade_Create_PROCESS___validateFormVariables( formData );

                formData.password       = ( formData.passwordReset ) ? formData.password : formData.origPassword;

                formData[ 'query' ]     = variables.Users_Trade_Create_PROCESS___shapeQuery( formData );

                resultStruct            = application.adminPanel.components.site.models.users.Users_Trade_Create_CREATE( formData );

                application.adminPanel.components.utility.hydras.Hydra_Basic_TASK( formData, resultStruct, booleanArray, arrayPos, jsonStruct );

            } catch( any e ){

                var errorStruct = {};
                errorStruct[ 'cfcatch' ]        = e;
                errorStruct[ 'arguments' ]      = ARGUMENTS;
                errorStruct[ 'resultStruct' ]   = resultStruct;

                writeDump( errorStruct );

            }

        }

        private struct function Users_Trade_Create_PROCESS___validateFormVariables( required struct formData, boolean debug ){

            //Lists
            var falseIfNotDefinedList   = 'passwordReset,serverSecurity,rollSecurity,siteSecurity,wlSecurity,eCommSecurity,listEmployee,listAssociate';
            var nullIfNotDefinedList    = 'employeeLocations,associateLocations';

            for( key in falseIfNotDefinedList ){

                formData[ key ] = ( structKeyExists( formData, key ) ) ? formData[ key ] : 0;

            }

            for( key in nullIfNotDefinedList ){

                formData[ key ] = ( structKeyExists( formData, key ) ) ? formData[ key ] : '';

            }


            return formData;

        }

        private string function Users_Trade_Create_PROCESS___shapeQuery( required struct formData ){

            //strings
            var queryString = '';


            //arrays
            var stringArray = [];

            stringArray[ 1 ] = "
            Insert Into srlighting.users (
                siteID,
                email, 
                password, 
                userType, 
                pricingLevel,
                fName, 
                lName, 
                title, 
                company, 
                address1, 
                address2, 
                city, 
                state, 
                zip, 
                phone1, 
                phoneType1, 
                phone2, 
                phoneType2, 
                linkedIn, 
                twitter, 
                facebook,
                privateNotes,
                publicNotes
              )    
            ";

            stringArray[ 2 ] = "
            Values(
                    :siteID,
                    :email,
                    :password,
                    :userType,
                    :pricingLevel,
                    :fName,
                    :lName,
                    :title, 
                    :company,
                    :address1,
                    :address2,
                    :city,
                    :state,
                    :zip,
                    :phone1,
                    :phoneType1,
                    :phone2,
                    :phoneType2,
                    :linkedIn,
                    :twitter,
                    :facebook,
                    :privateNotes,
                    :publicNotes
                )
            ";

            queryString = arrayToList( stringArray , '' );
                    
            return queryString;

        }

    //   **********************************************************************  
    //   *  User Trade Professional Create  Page - END                                 
    //   **********************************************************************  


    //   **********************************************************************  
    //   *  User Trade Professional Copy Page - START
    //   **********************************************************************  

        public void function Users_Trade_Copy_RETRIEVE( required struct urlData, boolean debug ){

            try{

                //structs
                var userStruct                      = structNew();
                var userSecurityRoleTypesStruct     = {};
                var cfsqltypeLookupStruct           = { 
                    'array'         :   'array',
                    'bigint'        :   'bigint',
                    'binaryt'       :   'binary',
                    'bit'           :   'bit',
                    'longvarbinary' :   'blob',
                    'char'          :   'varchar',
                    'clob'          :   'nclob',
                    'date'          :   'date',
                    'decimal'       :   'decimal',
                    'distinct'      :   'distinct',
                    'double'        :   'double',
                    'real'          :   'float',
                    'integer'       :   'integer',
                    'image'         :   'longvarbinary',
                    'ntext'         :   'longnvarchar',
                    'text'          :   'longvarchar',
                    'nchar'         :   'varchar',
                    'nvarchar'      :   'varchar',
                    'null'          :   'null',
                    'numeric'       :   'numeric',
                    'nvarchar'      :   'varchar',
                    'other'         :   'other',
                    'ref'           :   'refcursor',
                    'smallint'      :   'smallint',
                    'struct'        :   'struct',
                    'xml'           :   'sqlxml',
                    'int'           :   'integer',
                    'time'          :   'time',
                    'datetime'      :   'timestamp',
                    'tinyint'       :   'integer',
                    'varbinary'     :   'varbinary',
                    'varchar'       :   'varchar'
                };

                //arrays
                var fieldArray                      = [];
                var typeArray                       = [];

                //Queries
                userData                            = queryNew( '' );

                //Numerics
                var idx                             = 1;

                //Strings
                var key                             = '';

                urlData[ 'userID' ]     =  ( structKeyExists( urlData, 'userID' ) && urlData[ 'userID' ] != '' && urlData[ 'userID' ] )? urlData[ 'userID' ] : 0; 

                userStruct              = application.adminPanel.components.site.models.users.Users_Create_READ( urlData ); 
                
                listofLocations         = application.adminPanel.components.site.models.users.Users_ListOfLocations_READ();

                userSecurityRoleTypes   = application.adminPanel.components.site.models.users.Users_SecurityRoleTypes_READ();

                entryPointInfo          = application.adminPanel.components.site.models.users.Users_EntryPointInfo_READ();

                roleTypeQoQ             = '
            
                    SELECT  *
                    FROM    userSecurityRoleTypes.result
                    WHERE   type = :type
            
                ';

                fieldArray  = listToArray( valueList( userStruct.fielddata.field ) );
                typeArray   = listToArray( valueList( userStruct.fielddata.type ) );


                for( idx; idx <= arrayLen( fieldArray ); idx++ ){

                    fieldTypeStruct[ fieldArray[ idx ] ] = cfsqltypeLookupStruct[ reReplaceNoCase( typeArray[ idx ], "(.*)\([0-9]*\).*", '\1' ) ];

                }

                for( type in listRemoveDuplicates( valueList( userSecurityRoleTypes.result.type ), ',', true ) ){

                    query = queryExecute( roleTypeQoQ, { type = { value=type, cfsqltype='cf_sql_integer' } }, { dbtype='query', result='metaData' } );

                    structInsert( userSecurityRoleTypesStruct, type, query );

                }

                savecontent variable="htmlBlob"{
                    application.adminPanel.components.site.views.users.Users_Trade_Copy_VIEW( urlData, userStruct.result, listOfLocations.result, userSecurityRoleTypes.result, entryPointInfo.result, userSecurityRoleTypesStruct, false, true );
                }

                domData         = application.adminPanel.java.jSoup.parse( htmlBlob ).select( 'form' );
                fieldsets       = domData.select( "fieldset[securitylevel]" );
                securityLevel   = application.securityRoles[ trim( userStruct.result.userType ) ];
                securityLevel   = ( structKeyExists( urlData, 'userType' ) && urlData.userType!= '' ) ? application.securityRoles[ urlData.userType ] : securityLevel;

                //writeDump( application.securityRoles[ trim( resultStruct.result.userType ) ] ) abort;

                //remove fieldsets and input fieldset that the user and or page are not allowed to have
                fieldsets.each(function( element, idx ){
                    if( element.attr('securitylevel') > securityLevel ){
                        domData.select( "fieldset[securitylevel=#element.attr('securitylevel')#]" ).remove();
                    } else {             
                        element.select( "div[securitylevel]" ).each( function( subel, subidx ){
                            //writeDump( var=this, label='this in element loop' );
                            if( subel.attr('securitylevel') > securityLevel ){
                                element.select( "div[securitylevel=#subel.attr('securitylevel')#]" ).remove();
                            }
                        } )
                    }
                    
                });

                domData = application.adminPanel.components.utility.security.Security_DisableElementsByUserSecurityLevels_RENDER( urlData, domData, 'input,textarea,select,button' );           

                writeOutput( domData.outerHtml() );

            }catch( any e ){

                writeDump( e );

            }


        }

        public void function Users_Trade_Copy_PROCESS( required struct formData, boolean debug ){

            //structs
            var resultStruct    = {};
            var jsonStruct      = {};

            //Array
            var booleanArray    = [];

            //booleans
            var arrayPos        = 1;

            //set default shape for jsonStruct and booleanArray
            jsonStruct      = application.adminPanel.components.utility.datastructures.DataStructure_JSONStruct_GENERATE();
            booleanArray    = application.adminPanel.components.utility.datastructures.DataStructure_BooleanArray_GENERATE();

            //Set values for each step the hydra method will have to validate, mainly locations and messages
            booleanArray[ 1 ][ 'locationOnSuccess' ] = application.adminPanel.components.utility.strings.Strings_GeneratePageHref_TASK( 'tradeListing' );
            booleanArray[ 1 ][ 'locationOnFailure' ] = 'noredirect';

            jsonStruct[ 'onSuccess' ][ 'message' ][ 1 ]  =  'You''ve successfully removed the previous user.';
            jsonStruct[ 'onSuccess' ][ 'status' ][ 1 ]   = 'success';

            jsonStruct[ 'onFailure' ][ 'message' ][ 1 ]  = 'Something has gone wrong with removing the previous user, please try again later.' ;
            jsonStruct[ 'onFailure' ][ 'status' ][ 1 ]   = 'failure';

            try{    

                formData                = variables.Users_Create_PROCESS___validateFormVariables( formData );

                formData.password       = ( formData.passwordReset ) ? formData.password : formData.origPassword;

                formData[ 'query' ]     = variables.Users_Create_PROCESS___shapeQuery( formData );

                resultStruct            = application.adminPanel.components.site.models.users.Users_Trade_Create_CREATE( formData );


                application.adminPanel.components.utility.hydras.Hydra_Basic_TASK( formData, resultStruct, booleanArray, arrayPos, jsonStruct );

            } catch( any e ){

                var errorStruct = {};
                errorStruct[ 'cfcatch' ]        = e;
                errorStruct[ 'arguments' ]      = ARGUMENTS;
                errorStruct[ 'resultStruct' ]   = resultStruct;

                writeDump( errorStruct );

            }

        }

    //   **********************************************************************  
    //   *  User Trade Professional Copy Page - END
    //   **********************************************************************  


    //   **********************************************************************  
    //   *  User Trade Professional Edit Page - START                               
    //   **********************************************************************  

        public void function Users_Trade_Edit_RETRIEVE( required struct urlData, boolean debug ){

            //struct
            var resultStruct                    = {};
            var listOfLocationsStruct           = {};
            var entryPointInfo                  = {};
            var userSecurityRoleTypesStruct     = {};
            var metaData                        = {};
            var element                         = {};

            //arrays
            var elements                        = [];
            var domData                         = [];
            var subels                          = [];

            //queries
            var roleTypeQoQ                     = queryNew( '' );
            var userSecurityRoleTypes           = queryNew( '' );

            //numerics
            var idx                             = 1;
            var value                           = 1;
            var securityLevel                   = 1;

            //strings
            var type                            = '';
            var query                           = '';
            var htmlBlob                        = '';
            var key                             = '';
        

            //booleans
            local.debug                   = arguments.debug?: false;

            try{

                resultStruct            = application.adminPanel.components.site.models.users.Users_Trade_Edit_READ( urlData );

                listofLocations         = application.adminPanel.components.site.models.users.Users_ListOfLocations_READ();

                userSecurityRoleTypes   = application.adminPanel.components.site.models.users.Users_SecurityRoleTypes_READ();

                entryPointInfo          = application.adminPanel.components.site.models.users.Users_EntryPointInfo_READ();

                roleTypeQoQ                 = '
            
                    SELECT  *
                    FROM    userSecurityRoleTypes.result
                    WHERE   type = :type
            
                ';

                for( type in listRemoveDuplicates( valueList( userSecurityRoleTypes.result.type ), ',', true ) ){

                    query = queryExecute( roleTypeQoQ, { type = { value=type, cfsqltype='cf_sql_integer' } }, { dbtype='query', result='metaData' } );

                    structInsert( userSecurityRoleTypesStruct, type, query );

                }

                savecontent variable='htmlBlob'{

                    writeOutput( application.adminPanel.components.site.views.users.Users_Trade_Edit_VIEW( urlData, resultStruct.result, listOfLocations.result, userSecurityRoleTypes.result, entryPointInfo.result, userSecurityRoleTypesStruct, local.debug ) );

                }

                
                domData         = application.adminPanel.java.jSoup.parse( htmlBlob ).select( 'form' );
                fieldsets       = domData.select( "fieldset[securitylevel]" );
                securityLevel   = application.securityRoles[ trim( resultStruct.result.userType ) ];
                securityLevel   = ( structKeyExists( urlData, 'userType' ) && urlData.userType!= '' ) ? application.securityRoles[ urlData.userType ] : securityLevel;

                //writeDump( application.securityRoles[ trim( resultStruct.result.userType ) ] ) abort;

                //remove fieldsets and input fieldset that the user and or page are not allowed to have
                fieldsets.each(function( element, idx ){
                    if( element.attr('securitylevel') > securityLevel ){
                        domData.select( "fieldset[securitylevel=#element.attr('securitylevel')#]" ).remove();
                    } else {             
                        element.select( "div[securitylevel]" ).each( function( subel, subidx ){
                            //writeDump( var=this, label='this in element loop' );
                            if( subel.attr('securitylevel') > securityLevel ){
                                element.select( "div[securitylevel=#subel.attr('securitylevel')#]" ).remove();
                            }
                        } )
                    }
                    
                });
                
                domData = application.adminPanel.components.utility.security.Security_DisableElementsByUserSecurityLevels_RENDER( urlData, domData, 'input,textarea,select,button' );           

                writeOutput( domData.outerHtml() );

            }catch( any e ){

                var errorStruct                 = structNew();
                errorStruct[ 'cfcatch' ]        = e;
                errorStruct[ 'ARGUMENTS' ]      = arguments;
                errorStruct[ 'VARIABLES' ]      = variables;
                errorStruct[ 'resultStruct' ]   = {};
                
                writeDump( errorStruct );

            }


        }

        public void function Users_Trade_Edit_PROCESS( required struct formData, boolean debug ){

            //structs
            var resultStruct    = {};
            var jsonStruct      = {};

            //Array
            var booleanArray    = [];

            //Booleans
            var arrayPos        = 1;

            //set default shape for jsonStruct and booleanArray
            jsonStruct      = application.adminPanel.components.utility.datastructures.DataStructure_JSONStruct_GENERATE();
            booleanArray    = application.adminPanel.components.utility.datastructures.DataStructure_BooleanArray_GENERATE();

            //Set values for each step the hydra method will have to validate, mainly locations and messages
            booleanArray[ 1 ][ 'locationOnSuccess' ] = application.adminPanel.components.utility.strings.Strings_GeneratePageHref_TASK( 'tradeListing' );
            booleanArray[ 1 ][ 'locationOnFailure' ] = 'noredirect';

            jsonStruct[ 'onSuccess' ][ 'message' ][ 1 ]  = 'You''ve successfully edit the previous user.';
            jsonStruct[ 'onSuccess' ][ 'status' ][ 1 ]   = 'success';

            jsonStruct[ 'onFailure' ][ 'message' ][ 1 ]  = 'Something has gone wrong with removing the previous user, please try again later.';
            jsonStruct[ 'onFailure' ][ 'status' ][ 1 ]   = 'failure';

            try{    

                formData                = variables.Users_Trade_Edit_PROCESS___validateFormVariables( formData );

                formData.password       = ( formData.passwordReset ) ? formData.password : formData.origPassword;

                formData[ 'query' ]     = variables.Users_Trade_Edit_PROCESS___shapeQuery( formData );

                resultStruct            = application.adminPanel.components.site.models.users.Users_Trade_Edit_UPDATE( formData );

                application.adminPanel.components.utility.hydras.Hydra_Basic_TASK( formData, resultStruct, booleanArray, arrayPos, jsonStruct );

            } catch( any e ){

                var errorStruct = {};
                errorStruct[ 'cfcatch' ]        = e;
                errorStruct[ 'ARGUMENTS' ]      = ARGUMENTS;
                errorStruct[ 'resultStruct' ]   = resultStruct;

                writeDump( errorStruct );
                abort;

            }

        }


        private struct function Users_Trade_Edit_PROCESS___validateFormVariables( required struct formData, boolean debug ){

            //Lists
            var falseIfNotDefinedList   = 'passwordReset,emailPreference,active';
            var mullIfEmptyStringList   = '';
            var ifEmptyThenBoolean      = 'validated,pricingLevel,phone1,phone2,active';

            for( key in falseIfNotDefinedList ){

                formData[ key ] = ( structKeyExists( formData, key ) ) ? formData[ key ] : 0;

            }

            for( key in mullIfEmptyStringList ){

                formData[ key ] = ( structKeyExists( formData, key ) ) ? formData[ key ] : '';

            }

            for( key in ifEmptyThenBoolean ){

                formData[ key ] = ( structKeyExists( formData, key ) && formData[ key ] != '' ) ? formData[ key ] : 0;

            }

            return formData;

        }


        private string function Users_Trade_Edit_PROCESS___shapeQuery( required struct formData ){

            /**
             * @hint: This function dynamically builds the query we need for the model
             */

            //strings
            var queryString = '';


            //arrays
            var stringArray = [];

            stringArray[ 1 ] = "
                Update users 
                    Set userType = :userType,      
            ";

            if( structKeyExists( formData, 'passwordReset' ) ){

                stringArray[ 2 ] = "
                    password        = :password,
                    passwordChange  = :passwordChange,
                ";

            } else {

                stringArray[ 2 ] = '';

            }

            stringArray[ 3 ] = "
                    pricingLevel    = :pricingLevel,
                    fName           = :fName,
                    lName           = :lName,
                    title           = :title,
                    company         = :company,
                    accountNumber   = :accountNumber,
                    validated       = :validated,
                    password        = :password,
                    address1        = :address1,
                    address2        = :address2,
                    city            = :city,
                    state           = :state,
                    zip             = :zip,
                    phone1          = :phone1,
                    phoneType1      = :phoneType1,
                    phone2          = :phone2,
                    phoneType2      = :phoneType2,
                    linkedIn        = :linkedIn,
                    twitter         = :twitter,
                    facebook        = :facebook,
                    privateNotes    = :privateNotes,
                    publicNotes     = :publicNotes,
                    active          = :active
                Where userID        = :userID
                AND   siteID        = :siteID
            ";

                            
            queryString = arrayToList( stringArray , '' );

            return queryString;

        }


    //   **********************************************************************  
    //   *  User Trade Professional Edit Page - END                               
    //   **********************************************************************  

    //   **********************************************************************  
    //   *  User Trade Professional Remove Page - START                               
    //   **********************************************************************


        public void function Users_Trade_Remove_PROCESS( required struct formData, boolean debug ){

            //structs
            var resultStruct    = {};
            var jsonStruct      = {};

            //Array
            var booleanArray = [];

            //Numerics
            var arrayPos        = 1;

            //set default shape for jsonStruct and booleanArray
            jsonStruct      = application.adminPanel.components.utility.datastructures.DataStructure_JSONStruct_GENERATE();
            booleanArray    = application.adminPanel.components.utility.datastructures.DataStructure_BooleanArray_GENERATE();

            //Set values for each step the hydra method will have to validate, mainly locations and messages
            booleanArray[ 1 ][ 'locationOnSuccess' ] = application.adminPanel.components.utility.strings.Strings_GeneratePageHref_TASK( 'tradeListing' );
            booleanArray[ 1 ][ 'locationOnFailure' ] = 'noredirect';

            jsonStruct[ 'onSuccess' ][ 'message' ]  = 'You''ve successfully removed the previous user.';
            jsonStruct[ 'onSuccess' ][ 'status' ]   = 'success';

            jsonStruct[ 'onFailure' ][ 'message' ]  = 'Something has gone wrong with removing the previous user, please try again later.';
            jsonStruct[ 'onFailure' ][ 'status' ]   = 'failure';

            try{    

                resultStruct    = application.adminPanel.components.site.models.users.Users_Trade_Remove_DELETE( formData );

                application.adminPanel.components.utility.hydras.Hydra_Basic_TASK( formData, resultStruct, booleanArray, arrayPos, jsonStruct );

            } catch( any e ){

                var errorStruct = {};
                errorStruct[ 'cfcatch' ]        = e;
                errorStruct[ 'arguments' ]      = ARGUMENTS;
                errorStruct[ 'resultStruct' ]   = resultStruct;

                writeDump( errorStruct );

            }
            
        }


    //   **********************************************************************  
    //   *  User Trade Professional Remove Page - END                               
    //   **********************************************************************  

    //   **********************************************************************  
    //   *  User Site Admin Listing Page - START                               
    //   **********************************************************************  


        public void function Users_Site_Admin_Listing_RETRIEVE( required struct urlData ){

            //Structs
            var resultStruct = {};

            try{

                resultStruct = APPLICATION[ 'adminPanel' ][ 'components' ][ 'site' ][ 'models' ][ 'users' ].Users_Site_Admin_Listing_READ();

                APPLICATION[ 'adminPanel' ][ 'components' ][ 'site' ][ 'views' ][ 'users' ].Users_Site_Admin_Listing_VIEW( urlData, false, resultStruct[ 'result' ] );

            } catch( any e ){

                writeDump( e );

            }


        }


    //   **********************************************************************  
    //   *  User Site Admin Listing  Page - END                                 
    //   **********************************************************************  

    //   **********************************************************************  
    //   *  User Site Admin Create Page - START
    //   **********************************************************************  

        public void function Users_Site_Admin_Create_RETRIEVE( required struct urlData, boolean debug ){

            try{

                //structs
                var userStruct                      = {};
                var userSecurityRoleTypesStruct     = {};
                var cfsqltypeLookupStruct           = { 
                    'array'         :   'array',
                    'bigint'        :   'bigint',
                    'binaryt'       :   'binary',
                    'bit'           :   'bit',
                    'longvarbinary' :   'blob',
                    'char'          :   'varchar',
                    'clob'          :   'nclob',
                    'date'          :   'date',
                    'decimal'       :   'decimal',
                    'distinct'      :   'distinct',
                    'double'        :   'double',
                    'real'          :   'float',
                    'integer'       :   'integer',
                    'image'         :   'longvarbinary',
                    'ntext'         :   'longnvarchar',
                    'text'          :   'longvarchar',
                    'nchar'         :   'varchar',
                    'nvarchar'      :   'varchar',
                    'null'          :   'null',
                    'numeric'       :   'numeric',
                    'nvarchar'      :   'varchar',
                    'other'         :   'other',
                    'ref'           :   'refcursor',
                    'smallint'      :   'smallint',
                    'struct'        :   'struct',
                    'xml'           :   'sqlxml',
                    'int'           :   'integer',
                    'time'          :   'time',
                    'datetime'      :   'timestamp',
                    'tinyint'       :   'integer',
                    'varbinary'     :   'varbinary',
                    'varchar'       :   'varchar'
                };

                //Queries
                var listofLocationsQuery            = queryNew( '' );
                var userSecurityRoleTypes           = queryNew( '' );
                var entryPointInfoQuery             = queryNew( '' );
                var userData                        = queryNew( '' );

                //arrays
                var fieldArray                      = [];
                var typeArray                       = [];

                //Numerics
                var idx                             = 1;

                //Strings
                var key                             = '';

                local.debug                         = arguments.debug?: false;

                urlData[ 'userID' ]     =  ( structKeyExists( urlData, 'userID' ) && urlData[ 'userID' ] != '' && urlData[ 'userID' ] )? urlData[ 'userID' ] : 0; 

                userStruct              = application.adminPanel.components.site.models.users.Users_Create_READ( urlData ); 
                
                listofLocationsQuery    = application.adminPanel.components.site.models.users.Users_ListOfLocations_READ();

                userSecurityRoleTypes   = application.adminPanel.components.site.models.users.Users_SecurityRoleTypes_READ();

                entryPointInfoQuery     = application.adminPanel.components.site.models.users.Users_EntryPointInfo_READ();

                roleTypeQoQ                 = '
            
                    SELECT  *
                    FROM    userSecurityRoleTypes.result
                    WHERE   type = :type
            
                ';

                fieldArray  = listToArray( valueList( userStruct.fielddata.field ) );
                typeArray   = listToArray( valueList( userStruct.fielddata.type ) );


                for( idx; idx <= arrayLen( fieldArray ); idx++ ){

                    fieldTypeStruct[ fieldArray[ idx ] ] = cfsqltypeLookupStruct[ reReplaceNoCase( typeArray[ idx ], "(.*)\([0-9]*\).*", '\1' ) ];

                }

                for( key in fieldTypeStruct ){

                    switch( key ){

                        case 'userType':

                            queryAddColumn( userData, key, fieldTypeStruct[ key ], [urlData.userType] );

                            break;

                        case 'email':

                            queryAddColumn( userData, key, fieldTypeStruct[ key ], [urlData.email] );

                            break;

                        default:

                            queryAddColumn( userData, key, fieldTypeStruct[ key ], [''] );

                            break;

                    }

                }

                for( type in listRemoveDuplicates( valueList( userSecurityRoleTypes.result.type ), ',', true ) ){

                    query = queryExecute( roleTypeQoQ, { type = { value=type, cfsqltype='cf_sql_integer' } }, { dbtype='query', result='metaData' } );

                    structInsert( userSecurityRoleTypesStruct, type, query );

                }

                savecontent variable="htmlBlob"{
                    application.adminPanel.components.site.views.users.Users_Site_Admin_Create_VIEW( urlData, userData, listOfLocationsQuery.result, userSecurityRoleTypes.result, entryPointInfoQuery.result, userSecurityRoleTypesStruct, debug, true );
                }

                domData         = application.adminPanel.java.jSoup.parse( htmlBlob ).select( 'form' );
                fieldsets       = domData.select( "fieldset[securitylevel]" );
                securityLevel   = application.securityRoles[ trim( urlData.userType ) ];
                securityLevel   = ( structKeyExists( urlData, 'userType' ) && urlData.userType!= '' ) ? application.securityRoles[ urlData.userType ] : securityLevel;

                //writeDump( application.securityRoles[ trim( resultStruct.result.userType ) ] ) abort;

                //remove fieldsets and input fieldset that the user and or page are not allowed to have
                fieldsets.each(function( element, idx ){
                    if( element.attr('securitylevel') > securityLevel ){
                        domData.select( "fieldset[securitylevel=#element.attr('securitylevel')#]" ).remove();
                    } else {             
                        element.select( "*[securitylevel]" ).each( function( subel, subidx ){
                            //writeDump( var=this, label='this in element loop' );
                            if( subel.attr('securitylevel') > securityLevel ){
                                element.select( "*[securitylevel=#subel.attr('securitylevel')#]" ).remove();
                            }
                        } )
                    }
                    
                }); 

                domData = application.adminPanel.components.utility.security.Security_DisableElementsByUserSecurityLevels_RENDER( urlData, domData, 'input,textarea,select,button' );           

                writeOutput( domData.outerHtml() );

            }catch( any e ){

                writeDump( urlData );

                writeDump( userStruct );          

                writeDump( e );

            }


        }

        public void function Users_Site_Admin_Create_PROCESS( required struct formData, boolean debug ){

            //structs
            var resultStruct    = {};
            var jsonStruct      = {};

            //Array
            var booleanArray    = [];

            //booleans
            var arrayPos        = 1;

            //set default shape for jsonStruct and booleanArray
            jsonStruct      = application.adminPanel.components.utility.datastructures.DataStructure_JSONStruct_GENERATE();
            booleanArray    = application.adminPanel.components.utility.datastructures.DataStructure_BooleanArray_GENERATE();

            //Set values for each step the hydra method will have to validate, mainly locations and messages
            booleanArray[ 1 ][ 'locationOnSuccess' ] = application.adminPanel.components.utility.strings.Strings_GeneratePageHref_TASK( 'siteListing' );
            booleanArray[ 1 ][ 'locationOnFailure' ] = 'noredirect';

            jsonStruct[ 'onSuccess' ][ 'message' ][ 1 ]  = 'You''ve successfully removed the previous user.';
            jsonStruct[ 'onSuccess' ][ 'status' ][ 1 ]   = 'success';

            jsonStruct[ 'onFailure' ][ 'message' ][ 1 ]  = 'Something has gone wrong with removing the previous user, please try again later.';
            jsonStruct[ 'onFailure' ][ 'status' ][ 1 ]   = 'failure' ;

            try{    

                formData                = variables.Users_Site_Admin_Create_PROCESS___validateFormVariables( formData );

                formData.password       = ( formData.passwordReset ) ? formData.password : formData.origPassword;

                formData[ 'query' ]     = variables.Users_Site_Admin_Create_PROCESS___shapeQuery( formData );

                resultStruct            = application.adminPanel.components.site.models.users.Users_Site_Admin_Create_CREATE( formData );

                application.adminPanel.components.utility.hydras.Hydra_Basic_TASK( formData, resultStruct, booleanArray, arrayPos, jsonStruct );

            } catch( any e ){

                var errorStruct = {};
                errorStruct[ 'cfcatch' ]        = e;
                errorStruct[ 'arguments' ]      = ARGUMENTS;
                errorStruct[ 'resultStruct' ]   = resultStruct;

                writeDump( errorStruct );

            }

        }

        private struct function Users_Site_Admin_Create_PROCESS___validateFormVariables( required struct formData, boolean debug ){

            //Lists
            var falseIfNotDefinedList   = 'passwordReset,emailPreference,serverSecurity,rollSecurity,siteSecurity,wlSecurity,eCommSecurity,listEmployee,listAssociate,listContact,active';
            var nullIfNotDefinedList    = 'employeeLocations,associateLocations,contactLocations';
            var falseIfEmptyStringList   = 'validated,mobileServiceID,active';

            for( key in falseIfNotDefinedList ){

                formData[ key ] = ( structKeyExists( formData, key ) ) ? formData[ key ] : 0;

            }

            for( key in nullIfNotDefinedList ){

                formData[ key ] = ( structKeyExists( formData, key ) ) ? formData[ key ] : '';

            }

            for( key in falseIfEmptyStringList ){

                formData[ key ] = ( structKeyExists( formData, key ) && formData[ key ] != '' ) ? formData[ key ] : 0;

            }

            return formData;

        }

        private string function Users_Site_Admin_Create_PROCESS___shapeQuery( required struct formData ){

            //strings
            var queryString = '';


            //arrays
            var stringArray = [];

            stringArray[ 1 ] = "
            Insert Into srlighting.users(
                siteID, 
                email, 
                password, 
                userType, 
                pricingLevel,
                serverSecurity, 
                rollSecurity, 
                siteSecurity, 
                wlSecurity, 
                eCommSecurity,
                listEmployee, 
                employeeLocations, 
                listAssociate, 
                associateLocations,
                listContact,
                contactLocations,
                fName, 
                lName, 
                title, 
                company, 
                address1, 
                address2, 
                city, 
                state, 
                zip, 
                phone1, 
                phoneType1, 
                phone2, 
                phoneType2, 
                linkedIn, 
                twitter, 
                facebook, 
                privateNotes, 
                publicNotes
                )    
            ";

            stringArray[ 2 ] = "
            Values(
                    :siteID,
                    :email,
                    :password,
                    :userType,
                    :pricingLevel,
                    :serverSecurity,
                    :rollSecurity,
                    :siteSecurity,
                    :wlSecurity,
                    :eCommSecurity,  
                    :listEmployee, 
                    :employeeLocations,
                    :listAssociate, 
                    :associateLocations,
                    :listContact,
                    :contactLocations,
                    :fName,
                    :lName,
                    :title, 
                    :company,
                    :address1,
                    :address2,
                    :city,
                    :state,
                    :zip,
                    :phone1,
                    :phoneType1,
                    :phone2,
                    :phoneType2,
                    :linkedIn,
                    :twitter,
                    :facebook,
                    :privateNotes,
                    :publicNotes
                )
            ";
                    
            queryString = arrayToList( stringArray , '' );

            return queryString;

        }

    //   **********************************************************************  
    //   *  User Site Admin Create Page - END                                 
    //   **********************************************************************  


    //   **********************************************************************  
    //   *  User Site Admin Copy Page - START
    //   **********************************************************************  

        public void function Users_Site_Admin_Copy_RETRIEVE( required struct urlData, boolean debug ){

            try{

                //structs
                var userStruct                      = structNew();
                var userSecurityRoleTypesStruct     = {};
                var cfsqltypeLookupStruct           = { 
                    'array'         :   'array',
                    'bigint'        :   'bigint',
                    'binaryt'       :   'binary',
                    'bit'           :   'bit',
                    'longvarbinary' :   'blob',
                    'char'          :   'varchar',
                    'clob'          :   'nclob',
                    'date'          :   'date',
                    'decimal'       :   'decimal',
                    'distinct'      :   'distinct',
                    'double'        :   'double',
                    'real'          :   'float',
                    'integer'       :   'integer',
                    'image'         :   'longvarbinary',
                    'ntext'         :   'longnvarchar',
                    'text'          :   'longvarchar',
                    'nchar'         :   'varchar',
                    'nvarchar'      :   'varchar',
                    'null'          :   'null',
                    'numeric'       :   'numeric',
                    'nvarchar'      :   'varchar',
                    'other'         :   'other',
                    'ref'           :   'refcursor',
                    'smallint'      :   'smallint',
                    'struct'        :   'struct',
                    'xml'           :   'sqlxml',
                    'int'           :   'integer',
                    'time'          :   'time',
                    'datetime'      :   'timestamp',
                    'tinyint'       :   'integer',
                    'varbinary'     :   'varbinary',
                    'varchar'       :   'varchar'
                };

                //arrays
                var fieldArray                      = [];
                var typeArray                       = [];

                //Queries
                userData                            = queryNew( '' );

                //Numerics
                var idx                             = 1;

                //Strings
                var key                             = '';

                urlData[ 'userID' ]     =  ( structKeyExists( urlData, 'userID' ) && urlData[ 'userID' ] != '' && urlData[ 'userID' ] )? urlData[ 'userID' ] : 0; 

                userStruct              = application.adminPanel.components.site.models.users.Users_Create_READ( urlData ); 
                
                listofLocations         = application.adminPanel.components.site.models.users.Users_ListOfLocations_READ();

                userSecurityRoleTypes   = application.adminPanel.components.site.models.users.Users_SecurityRoleTypes_READ();

                entryPointInfo          = application.adminPanel.components.site.models.users.Users_EntryPointInfo_READ();

                roleTypeQoQ             = '
            
                    SELECT  *
                    FROM    userSecurityRoleTypes.result
                    WHERE   type = :type
            
                ';

                fieldArray  = listToArray( valueList( userStruct.fielddata.field ) );
                typeArray   = listToArray( valueList( userStruct.fielddata.type ) );


                for( idx; idx <= arrayLen( fieldArray ); idx++ ){

                    fieldTypeStruct[ fieldArray[ idx ] ] = cfsqltypeLookupStruct[ reReplaceNoCase( typeArray[ idx ], "(.*)\([0-9]*\).*", '\1' ) ];

                }


                for( type in listRemoveDuplicates( valueList( userSecurityRoleTypes.result.type ), ',', true ) ){

                    query = queryExecute( roleTypeQoQ, { type = { value=type, cfsqltype='cf_sql_integer' } }, { dbtype='query', result='metaData' } );

                    structInsert( userSecurityRoleTypesStruct, type, query );

                }

                savecontent variable="htmlBlob"{
                    application.adminPanel.components.site.views.users.Users_Site_Admin_Copy_VIEW( urlData, userStruct.result, listOfLocations.result, userSecurityRoleTypes.result, entryPointInfo.result, userSecurityRoleTypesStruct, false, true );
                }

                domData         = application.adminPanel.java.jSoup.parse( htmlBlob ).select( 'form' );
                fieldsets       = domData.select( "fieldset[securitylevel]" );
                securityLevel   = application.securityRoles[ trim( userStruct.result.userType ) ];
                securityLevel   = ( structKeyExists( urlData, 'userType' ) && urlData.userType!= '' ) ? application.securityRoles[ urlData.userType ] : securityLevel;

                //writeDump( application.securityRoles[ trim( resultStruct.result.userType ) ] ) abort;

                //remove fieldsets and input fieldset that the user and or page are not allowed to have
                fieldsets.each(function( element, idx ){
                    if( element.attr('securitylevel') > securityLevel ){
                        domData.select( "fieldset[securitylevel=#element.attr('securitylevel')#]" ).remove();
                    } else {             
                        element.select( "*[securitylevel]" ).each( function( subel, subidx ){
                            //writeDump( var=this, label='this in element loop' );
                            if( subel.attr('securitylevel') > securityLevel ){
                                element.select( "*[securitylevel=#subel.attr('securitylevel')#]" ).remove();
                            }
                        } )
                    }
                    
                });       
                
                domData = application.adminPanel.components.utility.security.Security_DisableElementsByUserSecurityLevels_RENDER( urlData, domData, 'input,textarea,select,button' );           

                writeOutput( domData.outerHtml() );

            }catch( any e ){

                writeDump( e );

            }


        }

        public void function Users_Site_Admin_Copy_PROCESS( required struct formData, boolean debug ){

            //structs
            var resultStruct    = {};
            var jsonStruct      = {};

            //Array
            var booleanArray    = [];

            //Booleans
            var arrayPos        = 1;

            //set default shape for jsonStruct and booleanArray
            jsonStruct      = application.adminPanel.components.utility.datastructures.DataStructure_JSONStruct_GENERATE();
            booleanArray    = application.adminPanel.components.utility.datastructures.DataStructure_BooleanArray_GENERATE();

            //Set values for each step the hydra method will have to validate, mainly locations and messages
            booleanArray[ 1 ][ 'locationOnSuccess' ] = application.adminPanel.components.utility.strings.Strings_GeneratePageHref_TASK( 'siteListing' );
            booleanArray[ 1 ][ 'locationOnFailure' ] = 'noredirect';

            jsonStruct[ 'onSuccess' ][ 'message' ][ 1 ]  =  'You''ve successfully created a new user.';
            jsonStruct[ 'onSuccess' ][ 'status' ][ 1 ]   = 'success';

            jsonStruct[ 'onFailure' ][ 'message' ][ 1 ]  = 'Something has gone wrong with removing the previous user, please try again later.' ;
            jsonStruct[ 'onFailure' ][ 'status' ][ 1 ]   = 'failure';

            try{    

                formData                = variables.Users_Site_Admin_Copy_PROCESS___validateFormVariables( formData );

                formData.password       = ( formData.passwordReset ) ? formData.password : formData.origPassword;

                formData[ 'query' ]     = variables.Users_Site_Admin_Copy_PROCESS___shapeQuery( formData );

                resultStruct            = application.adminPanel.components.site.models.users.Users_Site_Admin_Create_CREATE( formData );

                application.adminPanel.components.utility.hydras.Hydra_Basic_TASK( formData, resultStruct, booleanArray, arrayPos, jsonStruct );

            } catch( any e ){

                var errorStruct = {};
                errorStruct[ 'cfcatch' ]        = e;
                errorStruct[ 'arguments' ]      = ARGUMENTS;
                errorStruct[ 'resultStruct' ]   = resultStruct;

                writeDump( errorStruct );

            }

        }

        private struct function Users_Site_Admin_Copy_PROCESS___validateFormVariables( required struct formData, boolean debug ){

            //Lists
            var falseIfNotDefinedList   = 'passwordReset,emailPreference,serverSecurity,rollSecurity,siteSecurity,wlSecurity,eCommSecurity,listEmployee,listAssociate,listContact,active';
            var nullIfNotDefinedList    = 'employeeLocations,associateLocations,contactLocations';
            var falseIfEmptyStringList   = 'validated,mobileServiceID';

        
            for( key in falseIfNotDefinedList ){

                formData[ key ] = ( structKeyExists( formData, key ) ) ? formData[ key ] : 0;

            }

            for( key in nullIfNotDefinedList ){

                formData[ key ] = ( structKeyExists( formData, key ) ) ? formData[ key ] : '';

            }

            for( key in falseIfEmptyStringList ){

                formData[ key ] = ( structKeyExists( formData, key ) && formData[ key ] != '' ) ? formData[ key ] : 0;

            }

            return formData;

        }
        
        private string function Users_Site_Admin_Copy_PROCESS___shapeQuery( required struct formData ){

            //strings
            var queryString = '';


            //arrays
            var stringArray = [];

            stringArray[ 1 ] = "
            Insert Into srlighting.users(
                siteID, 
                email, 
                password, 
                userType, 
                pricingLevel,
                serverSecurity, 
                rollSecurity, 
                siteSecurity, 
                wlSecurity, 
                eCommSecurity,
                listEmployee, 
                employeeLocations, 
                listAssociate, 
                associateLocations,
                listContact,
                contactLocations,
                fName, 
                lName, 
                title, 
                company, 
                address1, 
                address2, 
                city, 
                state, 
                zip, 
                phone1, 
                phoneType1, 
                phone2, 
                phoneType2, 
                linkedIn, 
                twitter, 
                facebook, 
                privateNotes, 
                publicNotes,
                active
                )    
            ";

            stringArray[ 2 ] = "
            Values(
                    :siteID,
                    :email,
                    :password,
                    :userType,
                    :pricingLevel,
                    :serverSecurity,
                    :rollSecurity,
                    :siteSecurity,
                    :wlSecurity,
                    :eCommSecurity,  
                    :listEmployee, 
                    :employeeLocations,
                    :listAssociate, 
                    :associateLocations,
                    :listContact,
                    :contactLocations,
                    :fName,
                    :lName,
                    :title, 
                    :company,
                    :address1,
                    :address2,
                    :city,
                    :state,
                    :zip,
                    :phone1,
                    :phoneType1,
                    :phone2,
                    :phoneType2,
                    :linkedIn,
                    :twitter,
                    :facebook,
                    :privateNotes,
                    :publicNotes,
                    :active
                )
            ";

                            
            queryString = arrayToList( stringArray , '' );


            return queryString;

        }


    //   **********************************************************************  
    //   *  User Site Admin Copy Page - END
    //   **********************************************************************  

    //   **********************************************************************  
    //   *  User Site Admin Edit Page - START                               
    //   **********************************************************************  

        public void function Users_Site_Admin_Edit_RETRIEVE( required struct urlData, boolean debug ){

            //struct
            var resultStruct                    = {};
            var listOfLocationsStruct           = {};
            var entryPointInfo                  = {};
            var userSecurityRoleTypesStruct     = {};
            var metaData                        = {};
            var element                         = {};

            //arrays
            var elements                        = [];
            var domData                         = [];
            var subels                          = [];

            //queries
            var roleTypeQoQ                     = queryNew( '' );
            var userSecurityRoleTypes           = queryNew( '' );

            //numerics
            var idx                             = 1;
            var value                           = 1;
            var securityLevel                   = 1;

            //strings
            var type                    = '';
            var query                   = '';
            var htmlBlob                = '';
            var key                     = '';
        

            //booleans
            local.debug                 = arguments.debug?: false;

            try{

                resultStruct            = application.adminPanel.components.site.models.users.Users_Site_Admin_Edit_READ( urlData );

                listofLocations         = application.adminPanel.components.site.models.users.Users_ListOfLocations_READ();

                userSecurityRoleTypes   = application.adminPanel.components.site.models.users.Users_SecurityRoleTypes_READ();

                entryPointInfo          = application.adminPanel.components.site.models.users.Users_EntryPointInfo_READ();

                roleTypeQoQ                 = '
            
                    SELECT  *
                    FROM    userSecurityRoleTypes.result
                    WHERE   type = :type
            
                ';

                for( type in listRemoveDuplicates( valueList( userSecurityRoleTypes.result.type ), ',', true ) ){

                    query = queryExecute( roleTypeQoQ, { type = { value=type, cfsqltype='cf_sql_integer' } }, { dbtype='query', result='metaData' } );

                    structInsert( userSecurityRoleTypesStruct, type, query );

                }
                

                savecontent variable='htmlBlob'{

                    writeOutput( application.adminPanel.components.site.views.users.Users_Site_Admin_Edit_VIEW( urlData, resultStruct.result, listOfLocations.result, userSecurityRoleTypes.result, entryPointInfo.result, userSecurityRoleTypesStruct, local.debug ) );

                }

                
                domData         = application.adminPanel.java.jSoup.parse( htmlBlob ).select( 'form' );
                fieldsets       = domData.select( "fieldset[securitylevel]" );
                securityLevel   = application.securityRoles[ trim( resultStruct.result.userType ) ];
                securityLevel   = ( structKeyExists( urlData, 'userType' ) && urlData.userType!= '' ) ? application.securityRoles[ urlData.userType ] : securityLevel;

                //writeDump( application.securityRoles[ trim( resultStruct.result.userType ) ] ) abort;

                //remove fieldsets and input fieldset that the user and or page are not allowed to have
                fieldsets.each(function( element, idx ){
                    if( element.attr('securitylevel') > securityLevel ){
                        domData.select( "fieldset[securitylevel=#element.attr('securitylevel')#]" ).remove();
                    } else {             
                        element.select( "*[securitylevel]" ).each( function( subel, subidx ){
                            //writeDump( var=this, label='this in element loop' );
                            if( subel.attr('securitylevel') > securityLevel ){
                                element.select( "*[securitylevel=#subel.attr('securitylevel')#]" ).remove();
                            }
                        } )
                    }
                    
                });  
                
                domData = application.adminPanel.components.utility.security.Security_DisableElementsByUserSecurityLevels_RENDER( urlData, domData, 'input,textarea,select,button' );           

                writeOutput( domData.outerHtml() );

            }catch( any e ){

                var errorStruct                 = structNew();
                errorStruct[ 'cfcatch' ]        = e;
                errorStruct[ 'ARGUMENTS' ]      = arguments;
                errorStruct[ 'VARIABLES' ]      = variables;
                errorStruct[ 'resultStruct' ]   = {};
                
                writeDump( errorStruct );

            }


        }

        public void function Users_Site_Admin_Edit_PROCESS( required struct formData, boolean debug ){

            //structs
            var resultStruct    = {};
            var jsonStruct      = {};

            //Array
            var booleanArray    = [];

            //Booleans
            var arrayPos        = 1;


            //set default shape for jsonStruct and booleanArray
            jsonStruct      = application.adminPanel.components.utility.datastructures.DataStructure_JSONStruct_GENERATE();
            booleanArray    = application.adminPanel.components.utility.datastructures.DataStructure_BooleanArray_GENERATE();

            //Set values for each step the hydra method will have to validate, mainly locations and messages
            booleanArray[ 1 ][ 'locationOnSuccess' ] = application.adminPanel.components.utility.strings.Strings_GeneratePageHref_TASK( 'siteListing' );
            booleanArray[ 1 ][ 'locationOnFailure' ] = 'noredirect';

            jsonStruct[ 'onSuccess' ][ 'message' ][ 1 ]  = 'You''ve successfully removed the previous user.';
            jsonStruct[ 'onSuccess' ][ 'status' ][ 1 ]   = 'success';

            jsonStruct[ 'onFailure' ][ 'message' ][ 1 ]  = 'Something has gone wrong with removing the previous user, please try again later.';
            jsonStruct[ 'onFailure' ][ 'status' ][ 1 ]   = 'failure';

            try{    

                formData                = variables.Users_Site_Admin_Edit_PROCESS___validateFormVariables( formData );

                formData.password       = ( formData.passwordReset ) ? formData.password : formData.origPassword;

                formData[ 'query' ]     = variables.Users_Site_Admin_Edit_PROCESS___shapeQuery( formData );

                resultStruct            = application.adminPanel.components.site.models.users.Users_Site_Admin_Edit_UPDATE( formData );

                application.adminPanel.components.utility.hydras.Hydra_Basic_TASK( formData, resultStruct, booleanArray, arrayPos, jsonStruct );

            } catch( any e ){

                var errorStruct = {};
                errorStruct[ 'cfcatch' ]        = e;
                errorStruct[ 'arguments' ]      = ARGUMENTS;
                errorStruct[ 'resultStruct' ]   = resultStruct;

                writeDump( errorStruct );

            }

        }

        
        private struct function Users_Site_Admin_Edit_PROCESS___validateFormVariables( required struct formData, boolean debug ){

            //Lists
            var falseIfNotDefinedList   = 'passwordReset,emailPreference,serverSecurity,rollSecurity,siteSecurity,wlSecurity,eCommSecurity,listEmployee,listAssociate,listContact,active';
            var nullIfNotDefinedList    = 'employeeLocations,associateLocations,contactLocations';
            var falseIfEmptyStringList   = 'validated,mobileServiceID,active';

            for( key in falseIfNotDefinedList ){

                formData[ key ] = ( structKeyExists( formData, key ) ) ? formData[ key ] : 0;

            }

            for( key in nullIfNotDefinedList ){

                formData[ key ] = ( structKeyExists( formData, key ) ) ? formData[ key ] : '';

            }

            for( key in falseIfEmptyStringList ){

                formData[ key ] = ( structKeyExists( formData, key ) && formData[ key ] != '' ) ? formData[ key ] : 0;

            }

            return formData;

        }

        
        private string function Users_Site_Admin_Edit_PROCESS___shapeQuery( required struct formData ){

            //strings
            var queryString = '';


            //arrays
            var stringArray = [];

            stringArray[ 1 ] = "
                Update users 
                    Set userType = :userType,      
            ";

            stringArray[ 2 ] = "
                password = :password,
                passwordChange = :passwordChange,
            ";

            stringArray[ 3 ] = "
                    serverSecurity = :serverSecurity,
                    rollSecurity = :rollSecurity,
                    siteSecurity = :siteSecurity,
                    wlSecurity = :wlSecurity,
                    eCommsecurity = :eCommSecurity,
                    listEmployee = :listEmployee, 
                    employeeLocations = :employeeLocations, 
                    listAssociate = :listAssociate, 
                    associateLocations = :associateLocations,
                    listContact        = :listContact,
                    contactLocations   = :contactLocations,   
                    fName = :fName,
                    lName = :lName,
                    title = :title,
                    company = :company,
                    accountNumber = :accountNumber,
                    validated = :validated,
                    address1 = :address1,
                    address2 = :address2,
                    city = :city,
                    state = :State,
                    zip = :zip,
                    pricingLevel = :pricingLevel,
                    phone1 = :phone1,
                    phoneType1 = :phoneType1,
                    phone2 = :phone2,
                    phoneType2 = :phoneType2,
                    mobileServiceID = :mobileServiceID,
                    linkedIn = :linkedIn,
                    twitter = :twitter,
                    facebook = :facebook,
                    publicNotes = :publicNotes,
                    privateNotes = :privateNotes,
                    emailPreference = :emailPreference,
                    active = :active
                Where   userID = :userID
                AND     siteID = :siteID
            ";

                            
            queryString = arrayToList( stringArray , '' );


            return queryString;

        }




    //   **********************************************************************  
    //   *  User Site Admin Edit Page - END                               
    //   **********************************************************************  

    //   **********************************************************************  
    //   *  User Site Admin Remove Page - START                               
    //   **********************************************************************


        public void function Users_Site_Admin_Remove_PROCESS( required struct formData, boolean debug ){

            //structs
            var resultStruct    = {};
            var jsonStruct      = {};

            //Array
            var booleanArray = [];

            //Numerics
            var arrayPos        = 1;

            //set default shape for jsonStruct and booleanArray
            jsonStruct      = application.adminPanel.components.utility.datastructures.DataStructure_JSONStruct_GENERATE();
            booleanArray    = application.adminPanel.components.utility.datastructures.DataStructure_BooleanArray_GENERATE();

            //Set values for each step the hydra method will have to validate, mainly locations and messages
            booleanArray[ 1 ][ 'locationOnSuccess' ] = application.adminPanel.components.utility.strings.Strings_GeneratePageHref_TASK( 'siteListing' );
            booleanArray[ 1 ][ 'locationOnFailure' ] = 'noredirect';

            jsonStruct[ 'onSuccess' ][ 'message' ][ 1 ]  =  'You''ve successfully removed the previous user.';
            jsonStruct[ 'onSuccess' ][ 'status' ][ 1 ]   = 'success';

            jsonStruct[ 'onFailure' ][ 'message' ][ 1 ]  = 'Something has gone wrong with removing the previous user, please try again later.';
            jsonStruct[ 'onFailure' ][ 'status' ][ 1 ]   = 'failure';

            try{    

                resultStruct    = application.adminPanel.components.site.models.users.Users_Site_Admin_Remove_DELETE( formData );

                application.adminPanel.components.utility.hydras.Hydra_Basic_TASK( formData, resultStruct, booleanArray, arrayPos, jsonStruct );

            } catch( any e ){

                var errorStruct = {};
                errorStruct[ 'cfcatch' ]        = e;
                errorStruct[ 'arguments' ]      = ARGUMENTS;
                errorStruct[ 'resultStruct' ]   = resultStruct;

                writeDump( errorStruct );

            }
            
        }


    //   **********************************************************************  
    //   *  User Site Admin Remove Page - END                               
    //   **********************************************************************  

    //   **********************************************************************  
    //   *  Users All Listing Page - START                               
    //   **********************************************************************  


        public void function Users_All_Listing_RETRIEVE( required struct urlData ){

            //Structs
            var resultStruct = {};

            try{

                resultStruct = APPLICATION[ 'adminPanel' ][ 'components' ][ 'site' ][ 'models' ][ 'users' ].Users_All_Listing_READ();

                APPLICATION[ 'adminPanel' ][ 'components' ][ 'site' ][ 'views' ][ 'users' ].Users_All_Listing_VIEW( urlData, false, resultStruct[ 'result' ] );

            } catch( any e ){

                writeDump( e );

            }


        }


    //   **********************************************************************  
    //   *  Users All Listing  Page - END                                 
    //   **********************************************************************  

    //   **********************************************************************  
    //   *  Users All Create Page - START
    //   **********************************************************************  

        public void function Users_All_Create_RETRIEVE( required struct urlData, boolean debug ){

            try{

                //structs
                var userStruct                      = {};
                var userSecurityRoleTypesStruct     = {};
                var cfsqltypeLookupStruct           = { 
                'array'         :   'array',
                'bigint'        :   'bigint',
                'binaryt'       :   'binary',
                'bit'           :   'bit',
                'longvarbinary' :   'blob',
                'char'          :   'varchar',
                'clob'          :   'nclob',
                'date'          :   'date',
                'decimal'       :   'decimal',
                'distinct'      :   'distinct',
                'double'        :   'double',
                'real'          :   'float',
                'integer'       :   'integer',
                'image'         :   'longvarbinary',
                'ntext'         :   'longnvarchar',
                'text'          :   'longvarchar',
                'nchar'         :   'varchar',
                'nvarchar'      :   'varchar',
                'null'          :   'null',
                'numeric'       :   'numeric',
                'nvarchar'      :   'varchar',
                'other'         :   'other',
                'ref'           :   'refcursor',
                'smallint'      :   'smallint',
                'struct'        :   'struct',
                'xml'           :   'sqlxml',
                'int'           :   'integer',
                'time'          :   'time',
                'datetime'      :   'timestamp',
                'tinyint'       :   'integer',
                'varbinary'     :   'varbinary',
                'varchar'       :   'varchar'
            };

                //Queries
                var listofLocationsQuery            = queryNew( '' );
                var userSecurityRoleTypes           = queryNew( '' );
                var entryPointInfoQuery             = queryNew( '' );
                var userData                        = queryNew( '' );

                //arrays
                var fieldArray                      = [];
                var typeArray                       = [];

                //Numerics
                var idx                             = 1;

                //Strings
                var key                             = '';

                local.debug                         = arguments.debug?: false;

                urlData[ 'userID' ]     =  ( structKeyExists( urlData, 'userID' ) && urlData[ 'userID' ] != '' && urlData[ 'userID' ] )? urlData[ 'userID' ] : 0; 

                userStruct              = application.adminPanel.components.site.models.users.Users_Create_READ( urlData ); 
                
                listofLocationsQuery    = application.adminPanel.components.site.models.users.Users_ListOfLocations_READ();

                userSecurityRoleTypes   = application.adminPanel.components.site.models.users.Users_SecurityRoleTypes_READ();

                entryPointInfoQuery     = application.adminPanel.components.site.models.users.Users_EntryPointInfo_READ();

                roleTypeQoQ                 = '
            
                    SELECT  *
                    FROM    userSecurityRoleTypes.result
                    WHERE   type = :type
            
                ';

                fieldArray  = listToArray( valueList( userStruct.fielddata.field ) );
                typeArray   = listToArray( valueList( userStruct.fielddata.type ) );


                for( idx; idx <= arrayLen( fieldArray ); idx++ ){

                    fieldTypeStruct[ fieldArray[ idx ] ] = cfsqltypeLookupStruct[ reReplaceNoCase( typeArray[ idx ], "(.*)\([0-9]*\).*", '\1' ) ];

                }

                for( key in fieldTypeStruct ){

                    switch( key ){

                        case 'userType':

                            queryAddColumn( userData, key, fieldTypeStruct[ key ], [urlData.userType] );

                            break;

                        case 'email':

                            queryAddColumn( userData, key, fieldTypeStruct[ key ], [urlData.email] );

                            break;

                        default:

                            queryAddColumn( userData, key, fieldTypeStruct[ key ], [''] );

                            break;

                    }

                }

                for( type in listRemoveDuplicates( valueList( userSecurityRoleTypes.result.type ), ',', true ) ){

                    query = queryExecute( roleTypeQoQ, { type = { value=type, cfsqltype='cf_sql_integer' } }, { dbtype='query', result='metaData' } );

                    structInsert( userSecurityRoleTypesStruct, type, query );

                }

                savecontent variable="htmlBlob"{
                    application.adminPanel.components.site.views.users.Users_All_Create_VIEW( urlData, userData, listOfLocationsQuery.result, userSecurityRoleTypes.result, entryPointInfoQuery.result, userSecurityRoleTypesStruct, debug, true );
                }

                domData         = application.adminPanel.java.jSoup.parse( htmlBlob ).select( 'form' );
                fieldsets       = domData.select( "fieldset[securitylevel]" );
                securityLevel   = application.securityRoles[ trim( urlData.userType ) ];
                securityLevel   = ( structKeyExists( urlData, 'userType' ) && urlData.userType!= '' ) ? application.securityRoles[ urlData.userType ] : securityLevel;

                //writeDump( application.securityRoles[ trim( resultStruct.result.userType ) ] ) abort;

                //remove fieldsets and input fieldset that the user and or page are not allowed to have
                fieldsets.each(function( element, idx ){
                    if( element.attr('securitylevel') > securityLevel ){
                        domData.select( "fieldset[securitylevel=#element.attr('securitylevel')#]" ).remove();
                    } else {             
                        element.select( "div[securitylevel]" ).each( function( subel, subidx ){
                            //writeDump( var=this, label='this in element loop' );
                            if( subel.attr('securitylevel') > securityLevel ){
                                element.select( "div[securitylevel=#subel.attr('securitylevel')#]" ).remove();
                            }
                        } )
                    }
                    
                }); 

                domData = application.adminPanel.components.utility.security.Security_DisableElementsByUserSecurityLevels_RENDER( urlData, domData, 'input,textarea,select,button' );           

                writeOutput( domData.outerHtml() );

            }catch( any e ){

                writeDump( urlData );

                writeDump( userStruct );          

                writeDump( e );

            }


        }

        public void function Users_All_Create_PROCESS( required struct formData, boolean debug ){

            //structs
            var resultStruct    = {};
            var jsonStruct      = {};

            //Array
            var booleanArray    = [];

            //booleans
            var arrayPos        = 1;

            //set default shape for jsonStruct and booleanArray
            jsonStruct      = application.adminPanel.components.utility.datastructures.DataStructure_JSONStruct_GENERATE();
            booleanArray    = application.adminPanel.components.utility.datastructures.DataStructure_BooleanArray_GENERATE();

            //Set values for each step the hydra method will have to validate, mainly locations and messages
            booleanArray[ 1 ][ 'locationOnSuccess' ] = application.adminPanel.components.utility.strings.Strings_GeneratePageHref_TASK( 'allListing' );
            booleanArray[ 1 ][ 'locationOnFailure' ] = 'noredirect';

            jsonStruct[ 'onSuccess' ][ 'message' ][ 1 ]  = 'You''ve successfully removed the previous user.';
            jsonStruct[ 'onSuccess' ][ 'status' ][ 1 ]   = 'success';

            jsonStruct[ 'onFailure' ][ 'message' ][ 1 ]  = 'Something has gone wrong with removing the previous user, please try again later.';
            jsonStruct[ 'onFailure' ][ 'status' ][ 1 ]   = 'failure' ;

            try{    

                formData                = variables.Users_All_Create_PROCESS___validateFormVariables( formData );

                formData.password       = ( formData.passwordReset ) ? formData.password : formData.origPassword;

                formData[ 'query' ]     = variables.Users_All_Create_PROCESS___shapeQuery( formData );

                resultStruct            = application.adminPanel.components.site.models.users.Users_All_Create_CREATE( formData );

                application.adminPanel.components.utility.hydras.Hydra_Basic_TASK( formData, resultStruct, booleanArray, arrayPos, jsonStruct );

            } catch( any e ){

                var errorStruct = {};
                errorStruct[ 'cfcatch' ]        = e;
                errorStruct[ 'arguments' ]      = ARGUMENTS;
                errorStruct[ 'resultStruct' ]   = resultStruct;

                writeDump( errorStruct );

            }

        }

        private struct function Users_All_Create_PROCESS___validateFormVariables( required struct formData, boolean debug ){

            //Lists
            var falseIfNotDefinedList   = 'passwordReset,emailPreference,serverSecurity,rollSecurity,siteSecurity,wlSecurity,eCommSecurity,listEmployee,listAssociate,listContact,active';
            var nullIfNotDefinedList    = 'employeeLocations,associateLocations,contactLocations';
            var falseIfEmptyStringList  = 'validated,mobileServiceID,active';

            for( key in falseIfNotDefinedList ){

                formData[ key ] = ( structKeyExists( formData, key ) ) ? formData[ key ] : 0;

            }

            for( key in nullIfNotDefinedList ){

                formData[ key ] = ( structKeyExists( formData, key ) ) ? formData[ key ] : '';

            }

            for( key in falseIfEmptyStringList ){

                formData[ key ] = ( structKeyExists( formData, key ) && formData[ key ] != '' ) ? formData[ key ] : 0;

            }

            return formData;

        }

        private string function Users_All_Create_PROCESS___shapeQuery( required struct formData ){

            //strings
            var queryString = '';


            //arrays
            var stringArray = [];

            stringArray[ 1 ] = "
            Insert Into srlighting.users(
                siteID, 
                email, 
                password, 
                userType, 
                pricingLevel,
                serverSecurity, 
                rollSecurity, 
                siteSecurity, 
                wlSecurity, 
                eCommSecurity,
                listEmployee, 
                employeeLocations, 
                listAssociate, 
                associateLocations,
                listContact,
                contactLocations,
                fName, 
                lName, 
                title, 
                company, 
                address1, 
                address2, 
                city, 
                state, 
                zip, 
                phone1, 
                phoneType1, 
                phone2, 
                phoneType2, 
                linkedIn, 
                twitter, 
                facebook, 
                privateNotes, 
                publicNotes
                )    
            ";

            stringArray[ 2 ] = "
            Values(
                    :siteID,
                    :email,
                    :password,
                    :userType,
                    :pricingLevel,
                    :serverSecurity,
                    :rollSecurity,
                    :siteSecurity,
                    :wlSecurity,
                    :eCommSecurity,  
                    :listEmployee, 
                    :employeeLocations,
                    :listAssociate, 
                    :associateLocations,
                    :listContact,
                    :contactLocations,
                    :fName,
                    :lName,
                    :title, 
                    :company,
                    :address1,
                    :address2,
                    :city,
                    :state,
                    :zip,
                    :phone1,
                    :phoneType1,
                    :phone2,
                    :phoneType2,
                    :linkedIn,
                    :twitter,
                    :facebook,
                    :privateNotes,
                    :publicNotes
                )
            ";
                    
            queryString = arrayToList( stringArray , '' );

            return queryString;

        }

    //   **********************************************************************  
    //   *  Users All Create Page - END                                 
    //   **********************************************************************  

    //   **********************************************************************  
    //   *  Users All Copy Page - START
    //   **********************************************************************  

        public void function Users_All_Copy_RETRIEVE( required struct urlData, boolean debug ){

            try{

                //structs
                var userStruct                      = structNew();
                var userSecurityRoleTypesStruct     = {};
                var cfsqltypeLookupStruct           = { 
                    'array'         :   'array',
                    'bigint'        :   'bigint',
                    'binaryt'       :   'binary',
                    'bit'           :   'bit',
                    'longvarbinary' :   'blob',
                    'char'          :   'varchar',
                    'clob'          :   'nclob',
                    'date'          :   'date',
                    'decimal'       :   'decimal',
                    'distinct'      :   'distinct',
                    'double'        :   'double',
                    'real'          :   'float',
                    'integer'       :   'integer',
                    'image'         :   'longvarbinary',
                    'ntext'         :   'longnvarchar',
                    'text'          :   'longvarchar',
                    'nchar'         :   'varchar',
                    'nvarchar'      :   'varchar',
                    'null'          :   'null',
                    'numeric'       :   'numeric',
                    'nvarchar'      :   'varchar',
                    'other'         :   'other',
                    'ref'           :   'refcursor',
                    'smallint'      :   'smallint',
                    'struct'        :   'struct',
                    'xml'           :   'sqlxml',
                    'int'           :   'integer',
                    'time'          :   'time',
                    'datetime'      :   'timestamp',
                    'tinyint'       :   'integer',
                    'varbinary'     :   'varbinary',
                    'varchar'       :   'varchar'
                };

                //arrays
                var fieldArray                      = [];
                var typeArray                       = [];

                //Queries
                userData                            = queryNew( '' );

                //Numerics
                var idx                             = 1;

                //Strings
                var key                             = '';

                urlData[ 'userID' ]     =  ( structKeyExists( urlData, 'userID' ) && urlData[ 'userID' ] != '' && urlData[ 'userID' ] )? urlData[ 'userID' ] : 0; 

                userStruct              = application.adminPanel.components.site.models.users.Users_Create_READ( urlData ); 
                
                listofLocations         = application.adminPanel.components.site.models.users.Users_ListOfLocations_READ();

                userSecurityRoleTypes   = application.adminPanel.components.site.models.users.Users_SecurityRoleTypes_READ();

                entryPointInfo          = application.adminPanel.components.site.models.users.Users_EntryPointInfo_READ();

                roleTypeQoQ             = '
            
                    SELECT  *
                    FROM    userSecurityRoleTypes.result
                    WHERE   type = :type
            
                ';

                fieldArray  = listToArray( valueList( userStruct.fielddata.field ) );
                typeArray   = listToArray( valueList( userStruct.fielddata.type ) );


                for( idx; idx <= arrayLen( fieldArray ); idx++ ){

                    fieldTypeStruct[ fieldArray[ idx ] ] = cfsqltypeLookupStruct[ reReplaceNoCase( typeArray[ idx ], "(.*)\([0-9]*\).*", '\1' ) ];

                }


                for( type in listRemoveDuplicates( valueList( userSecurityRoleTypes.result.type ), ',', true ) ){

                    query = queryExecute( roleTypeQoQ, { type = { value=type, cfsqltype='cf_sql_integer' } }, { dbtype='query', result='metaData' } );

                    structInsert( userSecurityRoleTypesStruct, type, query );

                }

                savecontent variable="htmlBlob"{
                    application.adminPanel.components.site.views.users.Users_All_Copy_VIEW( urlData, userStruct.result, listOfLocations.result, userSecurityRoleTypes.result, entryPointInfo.result, userSecurityRoleTypesStruct, false, true );
                }

                domData         = application.adminPanel.java.jSoup.parse( htmlBlob ).select( 'form' );
                fieldsets       = domData.select( "fieldset[securitylevel]" );
                securityLevel   = application.securityRoles[ trim( userStruct.result.userType ) ];
                securityLevel   = ( structKeyExists( urlData, 'userType' ) && urlData.userType!= '' ) ? application.securityRoles[ urlData.userType ] : securityLevel;

                //writeDump( application.securityRoles[ trim( resultStruct.result.userType ) ] ) abort;

                //remove fieldsets and input fieldset that the user and or page are not allowed to have
                fieldsets.each(function( element, idx ){
                    if( element.attr('securitylevel') > securityLevel ){
                        domData.select( "fieldset[securitylevel=#element.attr('securitylevel')#]" ).remove();
                    } else {             
                        element.select( "div[securitylevel]" ).each( function( subel, subidx ){
                            //writeDump( var=this, label='this in element loop' );
                            if( subel.attr('securitylevel') > securityLevel ){
                                element.select( "div[securitylevel=#subel.attr('securitylevel')#]" ).remove();
                            }
                        } )
                    }
                    
                });
                
                domData = application.adminPanel.components.utility.security.Security_DisableElementsByUserSecurityLevels_RENDER( urlData, domData, 'input,textarea,select,button' );           

                writeOutput( domData.outerHtml() );

            }catch( any e ){

                writeDump( e );

            }


        }

        public void function Users_All_Copy_PROCESS( required struct formData, boolean debug ){

            //structs
            var resultStruct    = {};
            var jsonStruct      = {};

            //Array
            var booleanArray    = [];

            //Booleans
            var arrayPos        = 1;

            //set default shape for jsonStruct and booleanArray
            jsonStruct      = application.adminPanel.components.utility.datastructures.DataStructure_JSONStruct_GENERATE();
            booleanArray    = application.adminPanel.components.utility.datastructures.DataStructure_BooleanArray_GENERATE();

            //Set values for each step the hydra method will have to validate, mainly locations and messages
            booleanArray[ 1 ][ 'locationOnSuccess' ]        = application.adminPanel.components.utility.strings.Strings_GeneratePageHref_TASK( 'allListing' );
            booleanArray[ 1 ][ 'locationOnFailure' ]        = 'noredirect';

            jsonStruct[ 'onSuccess' ][ 'message' ][ 1 ]     =  'You''ve successfully removed the previous user.';
            jsonStruct[ 'onSuccess' ][ 'status' ][ 1 ]      = 'success';

            jsonStruct[ 'onFailure' ][ 'message' ][ 1 ]     = 'Something has gone wrong with removing the previous user, please try again later.' ;
            jsonStruct[ 'onFailure' ][ 'status' ][ 1 ]      = 'failure';

            try{    

                formData                = variables.Users_All_Copy_PROCESS___validateFormVariables( formData );

                formData.password       = ( formData.passwordReset ) ? formData.password : formData.origPassword;

                formData[ 'query' ]     = variables.Users_All_Copy_PROCESS___shapeQuery( formData );

                resultStruct            = application.adminPanel.components.site.models.users.Users_All_Create_CREATE( formData );

                //writeDump( resultStruct );

                application.adminPanel.components.utility.hydras.Hydra_Basic_TASK( formData, resultStruct, booleanArray, arrayPos, jsonStruct );

            } catch( any e ){

                var errorStruct = {};
                errorStruct[ 'cfcatch' ]        = e;
                errorStruct[ 'arguments' ]      = ARGUMENTS;
                errorStruct[ 'resultStruct' ]   = resultStruct;

                writeDump( errorStruct );
                

            }

        }

        private struct function Users_All_Copy_PROCESS___validateFormVariables( required struct formData, boolean debug ){

            //Lists
            var falseIfNotDefinedList   = 'passwordReset,emailPreference,serverSecurity,rollSecurity,siteSecurity,wlSecurity,eCommSecurity,listEmployee,listAssociate,listContact,active';
            var nullIfNotDefinedList    = 'employeeLocations,associateLocations,contactLocations';
            var falseIfEmptyStringList   = 'validated,mobileServiceID,active';

            for( key in falseIfNotDefinedList ){

                formData[ key ] = ( structKeyExists( formData, key ) ) ? formData[ key ] : 0;

            }

            for( key in nullIfNotDefinedList ){

                formData[ key ] = ( structKeyExists( formData, key ) ) ? formData[ key ] : '';

            }

            for( key in falseIfEmptyStringList ){

                formData[ key ] = ( structKeyExists( formData, key ) && formData[ key ] != '' ) ? formData[ key ] : 0;

            }

            return formData;
        
        }

        private string function Users_All_Copy_PROCESS___shapeQuery( required struct formData ){


            //strings
            var queryString = '';


            //arrays
            var stringArray = [];

            stringArray[ 1 ] = "
            Insert Into srlighting.users(
                siteID, 
                email, 
                password, 
                userType, 
                pricingLevel,
                serverSecurity, 
                rollSecurity, 
                siteSecurity, 
                wlSecurity, 
                eCommSecurity,
                listEmployee, 
                employeeLocations, 
                listAssociate, 
                associateLocations,
                listContact,
                contactLocations,
                fName, 
                lName, 
                title, 
                company, 
                address1, 
                address2, 
                city, 
                state, 
                zip, 
                phone1, 
                phoneType1, 
                phone2, 
                phoneType2, 
                linkedIn, 
                twitter, 
                facebook, 
                privateNotes, 
                publicNotes
                )    
            ";

            stringArray[ 2 ] = "
            Values(
                    :siteID,
                    :email,
                    :password,
                    :userType,
                    :pricingLevel,
                    :serverSecurity,
                    :rollSecurity,
                    :siteSecurity,
                    :wlSecurity,
                    :eCommSecurity,  
                    :listEmployee, 
                    :employeeLocations,
                    :listAssociate, 
                    :associateLocations,
                    :listContact,
                    :contactLocations,
                    :fName,
                    :lName,
                    :title, 
                    :company,
                    :address1,
                    :address2,
                    :city,
                    :state,
                    :zip,
                    :phone1,
                    :phoneType1,
                    :phone2,
                    :phoneType2,
                    :linkedIn,
                    :twitter,
                    :facebook,
                    :privateNotes,
                    :publicNotes
                )
            ";

                            
            queryString = arrayToList( stringArray , '' );


            return queryString;

        }


    //   **********************************************************************  
    //   *  Users All Copy Page - END
    //   **********************************************************************  

    //   **********************************************************************  
    //   *  Users All Edit Page - START                               
    //   **********************************************************************  

        public void function Users_All_Edit_RETRIEVE( required struct urlData, boolean debug ){

            //struct
            var resultStruct                    = {};
            var listOfLocationsStruct           = {};
            var entryPointInfo                  = {};
            var userSecurityRoleTypesStruct     = {};
            var metaData                        = {};
            var element                         = {};

            //arrays
            var elements                        = [];
            var domData                         = [];
            var subels                          = [];

            //queries
            var roleTypeQoQ                     = queryNew( '' );
            var userSecurityRoleTypes           = queryNew( '' );

            //numerics
            var idx                             = 1;
            var value                           = 1;
            var securityLevel                   = 1;

            //strings
            var type                    = '';
            var query                   = '';
            var htmlBlob                = '';
            var key                     = '';
        

            //booleans
            local.debug                 = arguments.debug?: false;

            try{

                resultStruct            = application.adminPanel.components.site.models.users.Users_All_Edit_READ( urlData );

                listofLocations         = application.adminPanel.components.site.models.users.Users_ListOfLocations_READ();

                userSecurityRoleTypes   = application.adminPanel.components.site.models.users.Users_SecurityRoleTypes_READ();

                entryPointInfo          = application.adminPanel.components.site.models.users.Users_EntryPointInfo_READ();

                roleTypeQoQ                 = '
            
                    SELECT  *
                    FROM    userSecurityRoleTypes.result
                    WHERE   type = :type
            
                ';

                for( type in listRemoveDuplicates( valueList( userSecurityRoleTypes.result.type ), ',', true ) ){

                    query = queryExecute( roleTypeQoQ, { type = { value=type, cfsqltype='cf_sql_integer' } }, { dbtype='query', result='metaData' } );

                    structInsert( userSecurityRoleTypesStruct, type, query );

                }
                

                savecontent variable='htmlBlob'{

                    writeOutput( application.adminPanel.components.site.views.users.Users_All_Edit_VIEW( urlData, resultStruct.result, listOfLocations.result, userSecurityRoleTypes.result, entryPointInfo.result, userSecurityRoleTypesStruct, local.debug ) );

                }

                
                domData         = application.adminPanel.java.jSoup.parse( htmlBlob ).select( 'form' );
                fieldsets       = domData.select( "fieldset[securitylevel]" );
                securityLevel   = application.securityRoles[ trim( resultStruct.result.userType ) ];
                securityLevel   = ( structKeyExists( urlData, 'userType' ) && urlData.userType!= '' ) ? application.securityRoles[ urlData.userType ] : securityLevel;

                //writeDump( application.securityRoles[ trim( resultStruct.result.userType ) ] ) abort;

                //remove fieldsets and input fieldset that the user and or page are not allowed to have
                fieldsets.each(function( element, idx ){
                    if( element.attr('securitylevel') > securityLevel ){
                        domData.select( "fieldset[securitylevel=#element.attr('securitylevel')#]" ).remove();
                    } else {             
                        element.select( "div[securitylevel]" ).each( function( subel, subidx ){
                            //writeDump( var=this, label='this in element loop' );
                            if( subel.attr('securitylevel') > securityLevel ){
                                element.select( "div[securitylevel=#subel.attr('securitylevel')#]" ).remove();
                            }
                        } )
                    }
                    
                }); 
                
                domData = application.adminPanel.components.utility.security.Security_DisableElementsByUserSecurityLevels_RENDER( urlData, domData, 'input,textarea,select,button' );           

                writeOutput( domData.outerHtml() );

            }catch( any e ){

                var errorStruct                 = structNew();
                errorStruct[ 'cfcatch' ]        = e;
                errorStruct[ 'ARGUMENTS' ]      = arguments;
                errorStruct[ 'VARIABLES' ]      = variables;
                errorStruct[ 'resultStruct' ]   = {};
                
                writeDump( errorStruct );

            }


        }

        public void function Users_All_Edit_PROCESS( required struct formData, boolean debug ){

            //structs
            var resultStruct    = {};
            var jsonStruct      = {};

            //Array
            var booleanArray    = [];

            //Booleans
            var arrayPos        = 1;


            //set default shape for jsonStruct and booleanArray
            jsonStruct      = application.adminPanel.components.utility.datastructures.DataStructure_JSONStruct_GENERATE();
            booleanArray    = application.adminPanel.components.utility.datastructures.DataStructure_BooleanArray_GENERATE();

            //Set values for each step the hydra method will have to validate, mainly locations and messages
            booleanArray[ 1 ][ 'locationOnSuccess' ] = application.adminPanel.components.utility.strings.Strings_GeneratePageHref_TASK( 'allListing' );
            booleanArray[ 1 ][ 'locationOnFailure' ] = 'noredirect';

            jsonStruct[ 'onSuccess' ][ 'message' ][ 1 ]  = 'You''ve successfully removed the previous user.';
            jsonStruct[ 'onSuccess' ][ 'status' ][ 1 ]   = 'success';

            jsonStruct[ 'onFailure' ][ 'message' ][ 1 ]  = 'Something has gone wrong with removing the previous user, please try again later.';
            jsonStruct[ 'onFailure' ][ 'status' ][ 1 ]   = 'failure';

            try{    

                formData                = variables.Users_All_Edit_PROCESS___validateFormVariables( formData );

                formData.password       = ( formData.passwordReset ) ? formData.password : formData.origPassword;

                formData[ 'query' ]     = variables.Users_All_Edit_PROCESS___shapeQuery( formData );

                resultStruct            = application.adminPanel.components.site.models.users.Users_All_Edit_UPDATE( formData );

                //writeDump( resultStruct );

                application.adminPanel.components.utility.hydras.Hydra_Basic_TASK( formData, resultStruct, booleanArray, arrayPos, jsonStruct );

            } catch( any e ){

                var errorStruct = {};
                errorStruct[ 'cfcatch' ]        = e;
                errorStruct[ 'arguments' ]      = ARGUMENTS;
                errorStruct[ 'resultStruct' ]   = resultStruct;

                writeDump( errorStruct );

            }

        }
    
        private struct function Users_All_Edit_PROCESS___validateFormVariables( required struct formData, boolean debug ){

            //Lists
            var falseIfNotDefinedList   = 'passwordReset,emailPreference,serverSecurity,rollSecurity,siteSecurity,wlSecurity,eCommSecurity,listEmployee,listAssociate,listContact,active';
            var nullIfNotDefinedList    = 'employeeLocations,associateLocations,contactLocations';
            var falseIfEmptyStringList  = 'validated,mobileServiceID,active';

            for( key in falseIfNotDefinedList ){

                formData[ key ] = ( structKeyExists( formData, key ) ) ? formData[ key ] : 0;

            }

            for( key in nullIfNotDefinedList ){

                formData[ key ] = ( structKeyExists( formData, key ) ) ? formData[ key ] : '';

            }

            for( key in falseIfEmptyStringList ){

                formData[ key ] = ( structKeyExists( formData, key ) && formData[ key ] != '' ) ? formData[ key ] : 0;

            }

            return formData;

        }

        
        private string function Users_All_Edit_PROCESS___shapeQuery( required struct formData ){

           
            //strings
            var queryString = '';


            //arrays
            var stringArray = [];

            stringArray[ 1 ] = "
                Update users 
                    Set userType = :userType,      
            ";

            stringArray[ 2 ] = "
                password = :password,
                passwordChange = :passwordChange,
            ";

            stringArray[ 3 ] = "
                    serverSecurity = :serverSecurity,
                    rollSecurity = :rollSecurity,
                    siteSecurity = :siteSecurity,
                    wlSecurity = :wlSecurity,
                    eCommsecurity = :eCommSecurity,
                    listEmployee = :listEmployee, 
                    employeeLocations = :employeeLocations, 
                    listAssociate = :listAssociate, 
                    associateLocations = :associateLocations,
                    listContact        = :listContact,
                    contactLocations   = :contactLocations,   
                    fName = :fName,
                    lName = :lName,
                    title = :title,
                    company = :company,
                    accountNumber = :accountNumber,
                    validated = :validated,
                    address1 = :address1,
                    address2 = :address2,
                    city = :city,
                    state = :State,
                    zip = :zip,
                    pricingLevel = :pricingLevel,
                    phone1 = :phone1,
                    phoneType1 = :phoneType1,
                    phone2 = :phone2,
                    phoneType2 = :phoneType2,
                    mobileServiceID = :mobileServiceID,
                    linkedIn = :linkedIn,
                    twitter = :twitter,
                    facebook = :facebook,
                    publicNotes = :publicNotes,
                    privateNotes = :privateNotes,
                    emailPreference = :emailPreference,
                    active = :active
                Where   userID = :userID
                AND     siteID = :siteID
            ";


                            
            queryString = arrayToList( stringArray , '' );


            return queryString;

        }


    //   **********************************************************************  
    //   *  Users All Edit Page - END                               
    //   **********************************************************************  

    //   **********************************************************************  
    //   *  Users All Remove Page - START                               
    //   **********************************************************************

        public void function Users_All_Remove_PROCESS( required struct formData, boolean debug ){

            //structs
            var resultStruct    = {};
            var jsonStruct      = {};

            //Array
            var booleanArray = [];

            //Numerics
            var arrayPos        = 1;

            //set default shape for jsonStruct and booleanArray
            jsonStruct      = application.adminPanel.components.utility.datastructures.DataStructure_JSONStruct_GENERATE();
            booleanArray    = application.adminPanel.components.utility.datastructures.DataStructure_BooleanArray_GENERATE();

            //Set values for each step the hydra method will have to validate, mainly locations and messages
            booleanArray[ 1 ][ 'locationOnSuccess' ] = application.adminPanel.components.utility.strings.Strings_GeneratePageHref_TASK( 'allListing' );
            booleanArray[ 1 ][ 'locationOnFailure' ] = 'noredirect';

            jsonStruct[ 'onSuccess' ][ 'message' ][ 1 ]  =  'You''ve successfully removed the previous user.';
            jsonStruct[ 'onSuccess' ][ 'status' ][ 1 ]   = 'success';

            jsonStruct[ 'onFailure' ][ 'message' ][ 1 ]  = 'Something has gone wrong with removing the previous user, please try again later.';
            jsonStruct[ 'onFailure' ][ 'status' ][ 1 ]   = 'failure';

            try{    

                resultStruct    = application.adminPanel.components.site.models.users.Users_All_Remove_DELETE( formData );

                application.adminPanel.components.utility.hydras.Hydra_Basic_TASK( formData, resultStruct, booleanArray, arrayPos, jsonStruct );

            } catch( any e ){

                var errorStruct = {};
                errorStruct[ 'cfcatch' ]        = e;
                errorStruct[ 'arguments' ]      = ARGUMENTS;
                errorStruct[ 'resultStruct' ]   = resultStruct;

                writeDump( errorStruct );

            }

            
        }

    //   **********************************************************************  
    //   *  Users All Remove Page - END                               
    //   **********************************************************************  
    
    //   **********************************************************************  
    //   *  Users Admin Listing Page - START                               
    //   **********************************************************************  


        public void function Users_Admin_Listing_RETRIEVE( required struct urlData ){

            //Structs
            var resultStruct = {};

            try{

                resultStruct = APPLICATION[ 'adminPanel' ][ 'components' ][ 'site' ][ 'models' ][ 'users' ].Users_Admin_Listing_READ();

                APPLICATION[ 'adminPanel' ][ 'components' ][ 'site' ][ 'views' ][ 'users' ].Users_Admin_Listing_VIEW( urlData, false, resultStruct[ 'result' ] );

            } catch( any e ){

                writeDump( e );

            }


        }


    //   **********************************************************************  
    //   *  Users Admin Listing  Page - END                                 
    //   **********************************************************************  

    //   **********************************************************************  
    //   *  Users Admin Create Page - START
    //   **********************************************************************  

        public void function Users_Admin_Create_RETRIEVE( required struct urlData, boolean debug ){

            try{

                //structs
                var userStruct                      = {};
                var userSecurityRoleTypesStruct     = {};
                var cfsqltypeLookupStruct           = { 
                'array'         :   'array',
                'bigint'        :   'bigint',
                'binaryt'       :   'binary',
                'bit'           :   'bit',
                'longvarbinary' :   'blob',
                'char'          :   'varchar',
                'clob'          :   'nclob',
                'date'          :   'date',
                'decimal'       :   'decimal',
                'distinct'      :   'distinct',
                'double'        :   'double',
                'real'          :   'float',
                'integer'       :   'integer',
                'image'         :   'longvarbinary',
                'ntext'         :   'longnvarchar',
                'text'          :   'longvarchar',
                'nchar'         :   'varchar',
                'nvarchar'      :   'varchar',
                'null'          :   'null',
                'numeric'       :   'numeric',
                'nvarchar'      :   'varchar',
                'other'         :   'other',
                'ref'           :   'refcursor',
                'smallint'      :   'smallint',
                'struct'        :   'struct',
                'xml'           :   'sqlxml',
                'int'           :   'integer',
                'time'          :   'time',
                'datetime'      :   'timestamp',
                'tinyint'       :   'integer',
                'varbinary'     :   'varbinary',
                'varchar'       :   'varchar'
            };

                //Queries
                var listofLocationsQuery            = queryNew( '' );
                var userSecurityRoleTypes           = queryNew( '' );
                var entryPointInfoQuery             = queryNew( '' );
                var userData                        = queryNew( '' );

                //arrays
                var fieldArray                      = [];
                var typeArray                       = [];

                //Numerics
                var idx                             = 1;

                //Strings
                var key                             = '';

                local.debug                         = arguments.debug?: false;

                urlData[ 'userID' ]     =  ( structKeyExists( urlData, 'userID' ) && urlData[ 'userID' ] != '' && urlData[ 'userID' ] )? urlData[ 'userID' ] : 0; 

                userStruct              = application.adminPanel.components.site.models.users.Users_Create_READ( urlData ); 
                
                listofLocationsQuery    = application.adminPanel.components.site.models.users.Users_ListOfLocations_READ();

                userSecurityRoleTypes   = application.adminPanel.components.site.models.users.Users_SecurityRoleTypes_READ();

                entryPointInfoQuery     = application.adminPanel.components.site.models.users.Users_EntryPointInfo_READ();

                roleTypeQoQ                 = '
            
                    SELECT  *
                    FROM    userSecurityRoleTypes.result
                    WHERE   type = :type
            
                ';

                fieldArray  = listToArray( valueList( userStruct.fielddata.field ) );
                typeArray   = listToArray( valueList( userStruct.fielddata.type ) );


                for( idx; idx <= arrayLen( fieldArray ); idx++ ){

                    fieldTypeStruct[ fieldArray[ idx ] ] = cfsqltypeLookupStruct[ reReplaceNoCase( typeArray[ idx ], "(.*)\([0-9]*\).*", '\1' ) ];

                }

                for( key in fieldTypeStruct ){

                    switch( key ){

                        case 'userType':

                            queryAddColumn( userData, key, fieldTypeStruct[ key ], [urlData.userType] );

                            break;

                        case 'email':

                            queryAddColumn( userData, key, fieldTypeStruct[ key ], [urlData.email] );

                            break;

                        default:

                            queryAddColumn( userData, key, fieldTypeStruct[ key ], [''] );

                            break;

                    }

                }

                for( type in listRemoveDuplicates( valueList( userSecurityRoleTypes.result.type ), ',', true ) ){

                    query = queryExecute( roleTypeQoQ, { type = { value=type, cfsqltype='cf_sql_integer' } }, { dbtype='query', result='metaData' } );

                    structInsert( userSecurityRoleTypesStruct, type, query );

                }

                savecontent variable="htmlBlob"{
                    application.adminPanel.components.site.views.users.Users_Admin_Create_VIEW( urlData, userData, listOfLocationsQuery.result, userSecurityRoleTypes.result, entryPointInfoQuery.result, userSecurityRoleTypesStruct, debug, true );
                }

                domData         = application.adminPanel.java.jSoup.parse( htmlBlob ).select( 'form' );
                fieldsets       = domData.select( "fieldset[securitylevel]" );
                securityLevel   = application.securityRoles[ trim( urlData.userType ) ];
                securityLevel   = ( structKeyExists( urlData, 'userType' ) && urlData.userType!= '' ) ? application.securityRoles[ urlData.userType ] : securityLevel;

                //writeDump( application.securityRoles[ trim( resultStruct.result.userType ) ] ) abort;

                //remove fieldsets and input fieldset that the user and or page are not allowed to have
                fieldsets.each(function( element, idx ){
                    if( element.attr('securitylevel') > securityLevel ){
                        domData.select( "fieldset[securitylevel=#element.attr('securitylevel')#]" ).remove();
                    } else {             
                        element.select( "div[securitylevel]" ).each( function( subel, subidx ){
                            //writeDump( var=this, label='this in element loop' );
                            if( subel.attr('securitylevel') > securityLevel ){
                                element.select( "div[securitylevel=#subel.attr('securitylevel')#]" ).remove();
                            }
                        } )
                    }
                    
                }); 


                domData = application.adminPanel.components.utility.security.Security_DisableElementsByUserSecurityLevels_RENDER( urlData, domData, 'input,textarea,select,button' );           

                writeOutput( domData.outerHtml() );

            }catch( any e ){

                writeDump( urlData );

                writeDump( userStruct );          

                writeDump( e );

            }


        }

        public void function Users_Admin_Create_PROCESS( required struct formData, boolean debug ){

            //structs
            var resultStruct    = {};
            var jsonStruct      = {};

            //Array
            var booleanArray    = [];

            //booleans
            var arrayPos        = 1;

            //set default shape for jsonStruct and booleanArray
            jsonStruct      = application.adminPanel.components.utility.datastructures.DataStructure_JSONStruct_GENERATE();
            booleanArray    = application.adminPanel.components.utility.datastructures.DataStructure_BooleanArray_GENERATE();

            //Set values for each step the hydra method will have to validate, mainly locations and messages
            booleanArray[ 1 ][ 'locationOnSuccess' ] = application.adminPanel.components.utility.strings.Strings_GeneratePageHref_TASK( 'allListing' );
            booleanArray[ 1 ][ 'locationOnFailure' ] = 'noredirect';

            jsonStruct[ 'onSuccess' ][ 'message' ][ 1 ]  = 'You''ve successfully removed the previous user.';
            jsonStruct[ 'onSuccess' ][ 'status' ][ 1 ]   = 'success';

            jsonStruct[ 'onFailure' ][ 'message' ][ 1 ]  = 'Something has gone wrong with removing the previous user, please try again later.';
            jsonStruct[ 'onFailure' ][ 'status' ][ 1 ]   = 'failure' ;

            try{    

                formData                = variables.Users_Admin_Create_PROCESS___validateFormVariables( formData );

                formData.password       = ( formData.passwordReset ) ? formData.password : formData.origPassword;

                formData[ 'query' ]     = variables.Users_Admin_Create_PROCESS___shapeQuery( formData );

                resultStruct            = application.adminPanel.components.site.models.users.Users_Admin_Create_CREATE( formData );

                application.adminPanel.components.utility.hydras.Hydra_Basic_TASK( formData, resultStruct, booleanArray, arrayPos, jsonStruct );

            } catch( any e ){

                var errorStruct = {};
                errorStruct[ 'cfcatch' ]        = e;
                errorStruct[ 'arguments' ]      = ARGUMENTS;
                errorStruct[ 'resultStruct' ]   = resultStruct;

                writeDump( errorStruct );

            }

        }

        private struct function Users_Admin_Create_PROCESS___validateFormVariables( required struct formData, boolean debug ){

            //Lists
            var falseIfNotDefinedList   = 'passwordReset,emailPreference,serverSecurity,rollSecurity,siteSecurity,wlSecurity,eCommSecurity,listEmployee,listAssociate,listContact,active';
            var nullIfNotDefinedList    = 'employeeLocations,associateLocations,contactLocations';
            var falseIfEmptyStringList  = 'validated,mobileServiceID,active';

            for( key in falseIfNotDefinedList ){

                formData[ key ] = ( structKeyExists( formData, key ) ) ? formData[ key ] : 0;

            }

            for( key in nullIfNotDefinedList ){

                formData[ key ] = ( structKeyExists( formData, key ) ) ? formData[ key ] : '';

            }

            for( key in falseIfEmptyStringList ){

                formData[ key ] = ( structKeyExists( formData, key ) && formData[ key ] != '' ) ? formData[ key ] : 0;

            }

            return formData;

        }

        private string function Users_Admin_Create_PROCESS___shapeQuery( required struct formData ){

            //strings
            var queryString = '';


            //arrays
            var stringArray = [];

            stringArray[ 1 ] = "
            Insert Into srlighting.users(
                siteID, 
                email, 
                password, 
                userType, 
                pricingLevel,
                serverSecurity, 
                rollSecurity, 
                siteSecurity, 
                wlSecurity, 
                eCommSecurity,
                listEmployee, 
                employeeLocations, 
                listAssociate, 
                associateLocations,
                listContact,
                contactLocations,
                fName, 
                lName, 
                title, 
                company, 
                address1, 
                address2, 
                city, 
                state, 
                zip, 
                phone1, 
                phoneType1, 
                phone2, 
                phoneType2, 
                linkedIn, 
                twitter, 
                facebook, 
                privateNotes, 
                publicNotes
                )    
            ";

            stringArray[ 2 ] = "
            Values(
                    :siteID,
                    :email,
                    :password,
                    :userType,
                    :pricingLevel,
                    :serverSecurity,
                    :rollSecurity,
                    :siteSecurity,
                    :wlSecurity,
                    :eCommSecurity,  
                    :listEmployee, 
                    :employeeLocations,
                    :listAssociate, 
                    :associateLocations,
                    :listContact,
                    :contactLocations,
                    :fName,
                    :lName,
                    :title, 
                    :company,
                    :address1,
                    :address2,
                    :city,
                    :state,
                    :zip,
                    :phone1,
                    :phoneType1,
                    :phone2,
                    :phoneType2,
                    :linkedIn,
                    :twitter,
                    :facebook,
                    :privateNotes,
                    :publicNotes
                )
            ";
                    
            queryString = arrayToList( stringArray , '' );

            return queryString;

        }

    //   **********************************************************************  
    //   *  Users Admin Create Page - END                                 
    //   **********************************************************************  

    //   **********************************************************************  
    //   *  Users Admin Copy Page - START
    //   **********************************************************************  

        public void function Users_Admin_Copy_RETRIEVE( required struct urlData, boolean debug ){

            try{

                //structs
                var userStruct                      = structNew();
                var userSecurityRoleTypesStruct     = {};
                var cfsqltypeLookupStruct           = { 
                    'array'         :   'array',
                    'bigint'        :   'bigint',
                    'binaryt'       :   'binary',
                    'bit'           :   'bit',
                    'longvarbinary' :   'blob',
                    'char'          :   'varchar',
                    'clob'          :   'nclob',
                    'date'          :   'date',
                    'decimal'       :   'decimal',
                    'distinct'      :   'distinct',
                    'double'        :   'double',
                    'real'          :   'float',
                    'integer'       :   'integer',
                    'image'         :   'longvarbinary',
                    'ntext'         :   'longnvarchar',
                    'text'          :   'longvarchar',
                    'nchar'         :   'varchar',
                    'nvarchar'      :   'varchar',
                    'null'          :   'null',
                    'numeric'       :   'numeric',
                    'nvarchar'      :   'varchar',
                    'other'         :   'other',
                    'ref'           :   'refcursor',
                    'smallint'      :   'smallint',
                    'struct'        :   'struct',
                    'xml'           :   'sqlxml',
                    'int'           :   'integer',
                    'time'          :   'time',
                    'datetime'      :   'timestamp',
                    'tinyint'       :   'integer',
                    'varbinary'     :   'varbinary',
                    'varchar'       :   'varchar'
                };

                //arrays
                var fieldArray                      = [];
                var typeArray                       = [];

                //Queries
                userData                            = queryNew( '' );

                //Numerics
                var idx                             = 1;

                //Strings
                var key                             = '';

                urlData[ 'userID' ]     =  ( structKeyExists( urlData, 'userID' ) && urlData[ 'userID' ] != '' && urlData[ 'userID' ] )? urlData[ 'userID' ] : 0; 

                userStruct              = application.adminPanel.components.site.models.users.Users_Create_READ( urlData ); 
                
                listofLocations         = application.adminPanel.components.site.models.users.Users_ListOfLocations_READ();

                userSecurityRoleTypes   = application.adminPanel.components.site.models.users.Users_SecurityRoleTypes_READ();

                entryPointInfo          = application.adminPanel.components.site.models.users.Users_EntryPointInfo_READ();

                roleTypeQoQ             = '
            
                    SELECT  *
                    FROM    userSecurityRoleTypes.result
                    WHERE   type = :type
            
                ';

                fieldArray  = listToArray( valueList( userStruct.fielddata.field ) );
                typeArray   = listToArray( valueList( userStruct.fielddata.type ) );


                for( idx; idx <= arrayLen( fieldArray ); idx++ ){

                    fieldTypeStruct[ fieldArray[ idx ] ] = cfsqltypeLookupStruct[ reReplaceNoCase( typeArray[ idx ], "(.*)\([0-9]*\).*", '\1' ) ];

                }


                for( type in listRemoveDuplicates( valueList( userSecurityRoleTypes.result.type ), ',', true ) ){

                    query = queryExecute( roleTypeQoQ, { type = { value=type, cfsqltype='cf_sql_integer' } }, { dbtype='query', result='metaData' } );

                    structInsert( userSecurityRoleTypesStruct, type, query );

                }

                savecontent variable="htmlBlob"{
                    application.adminPanel.components.site.views.users.Users_Admin_Copy_VIEW( urlData, userStruct.result, listOfLocations.result, userSecurityRoleTypes.result, entryPointInfo.result, userSecurityRoleTypesStruct, false, true );
                }

                domData         = application.adminPanel.java.jSoup.parse( htmlBlob ).select( 'form' );
                fieldsets       = domData.select( "fieldset[securitylevel]" );
                securityLevel   = application.securityRoles[ trim( userStruct.result.userType ) ];
                securityLevel   = ( structKeyExists( urlData, 'userType' ) && urlData.userType!= '' ) ? application.securityRoles[ urlData.userType ] : securityLevel;

                //writeDump( application.securityRoles[ trim( resultStruct.result.userType ) ] ) abort;

                //remove fieldsets and input fieldset that the user and or page are not allowed to have
                fieldsets.each(function( element, idx ){
                    if( element.attr('securitylevel') > securityLevel ){
                        domData.select( "fieldset[securitylevel=#element.attr('securitylevel')#]" ).remove();
                    } else {             
                        element.select( "div[securitylevel]" ).each( function( subel, subidx ){
                            //writeDump( var=this, label='this in element loop' );
                            if( subel.attr('securitylevel') > securityLevel ){
                                element.select( "div[securitylevel=#subel.attr('securitylevel')#]" ).remove();
                            }
                        } )
                    }
                    
                });      
                
                domData = application.adminPanel.components.utility.security.Security_DisableElementsByUserSecurityLevels_RENDER( urlData, domData, 'input,textarea,select,button' );           

                writeOutput( domData.outerHtml() );

            }catch( any e ){

                writeDump( e );

            }


        }

        public void function Users_Admin_Copy_PROCESS( required struct formData, boolean debug ){

            //structs
            var resultStruct    = {};
            var jsonStruct      = {};

            //Array
            var booleanArray    = [];

            //Booleans
            var arrayPos        = 1;

            //set default shape for jsonStruct and booleanArray
            jsonStruct      = application.adminPanel.components.utility.datastructures.DataStructure_JSONStruct_GENERATE();
            booleanArray    = application.adminPanel.components.utility.datastructures.DataStructure_BooleanArray_GENERATE();

            //Set values for each step the hydra method will have to validate, mainly locations and messages
            booleanArray[ 1 ][ 'locationOnSuccess' ]        = application.adminPanel.components.utility.strings.Strings_GeneratePageHref_TASK( 'allListing' );
            booleanArray[ 1 ][ 'locationOnFailure' ]        = 'noredirect';

            jsonStruct[ 'onSuccess' ][ 'message' ][ 1 ]     =  'You''ve successfully removed the previous user.';
            jsonStruct[ 'onSuccess' ][ 'status' ][ 1 ]      = 'success';

            jsonStruct[ 'onFailure' ][ 'message' ][ 1 ]     = 'Something has gone wrong with removing the previous user, please try again later.' ;
            jsonStruct[ 'onFailure' ][ 'status' ][ 1 ]      = 'failure';

            try{    

                formData                = variables.Users_Admin_Copy_PROCESS___validateFormVariables( formData );

                formData.password       = ( formData.passwordReset ) ? formData.password : formData.origPassword;

                formData[ 'query' ]     = variables.Users_Admin_Copy_PROCESS___shapeQuery( formData );

                resultStruct            = application.adminPanel.components.site.models.users.Users_Admin_Create_CREATE( formData );

                //writeDump( resultStruct );

                application.adminPanel.components.utility.hydras.Hydra_Basic_TASK( formData, resultStruct, booleanArray, arrayPos, jsonStruct );

            } catch( any e ){

                var errorStruct = {};
                errorStruct[ 'cfcatch' ]        = e;
                errorStruct[ 'arguments' ]      = ARGUMENTS;
                errorStruct[ 'resultStruct' ]   = resultStruct;

                writeDump( errorStruct );
                

            }

        }

        private struct function Users_Admin_Copy_PROCESS___validateFormVariables( required struct formData, boolean debug ){

            //Lists
            var falseIfNotDefinedList   = 'passwordReset,emailPreference,serverSecurity,rollSecurity,siteSecurity,wlSecurity,eCommSecurity,listEmployee,listAssociate,listContact,active';
            var nullIfNotDefinedList    = 'employeeLocations,associateLocations,contactLocations';
            var falseIfEmptyStringList   = 'validated,mobileServiceID,active';

            for( key in falseIfNotDefinedList ){

                formData[ key ] = ( structKeyExists( formData, key ) ) ? formData[ key ] : 0;

            }

            for( key in nullIfNotDefinedList ){

                formData[ key ] = ( structKeyExists( formData, key ) ) ? formData[ key ] : '';

            }

            for( key in falseIfEmptyStringList ){

                formData[ key ] = ( structKeyExists( formData, key ) && formData[ key ] != '' ) ? formData[ key ] : 0;

            }

            return formData;
        
        }

        private string function Users_Admin_Copy_PROCESS___shapeQuery( required struct formData ){


            //strings
            var queryString = '';


            //arrays
            var stringArray = [];

            stringArray[ 1 ] = "
            Insert Into srlighting.users(
                siteID, 
                email, 
                password, 
                userType, 
                pricingLevel,
                serverSecurity, 
                rollSecurity, 
                siteSecurity, 
                wlSecurity, 
                eCommSecurity,
                listEmployee, 
                employeeLocations, 
                listAssociate, 
                associateLocations,
                listContact,
                contactLocations,
                fName, 
                lName, 
                title, 
                company, 
                address1, 
                address2, 
                city, 
                state, 
                zip, 
                phone1, 
                phoneType1, 
                phone2, 
                phoneType2, 
                linkedIn, 
                twitter, 
                facebook, 
                privateNotes, 
                publicNotes
                )    
            ";

            stringArray[ 2 ] = "
            Values(
                    :siteID,
                    :email,
                    :password,
                    :userType,
                    :pricingLevel,
                    :serverSecurity,
                    :rollSecurity,
                    :siteSecurity,
                    :wlSecurity,
                    :eCommSecurity,  
                    :listEmployee, 
                    :employeeLocations,
                    :listAssociate, 
                    :associateLocations,
                    :listContact,
                    :contactLocations,
                    :fName,
                    :lName,
                    :title, 
                    :company,
                    :address1,
                    :address2,
                    :city,
                    :state,
                    :zip,
                    :phone1,
                    :phoneType1,
                    :phone2,
                    :phoneType2,
                    :linkedIn,
                    :twitter,
                    :facebook,
                    :privateNotes,
                    :publicNotes
                )
            ";

                            
            queryString = arrayToList( stringArray , '' );


            return queryString;

        }


    //   **********************************************************************  
    //   *  Users Admin Copy Page - END
    //   **********************************************************************  

    //   **********************************************************************  
    //   *  Users Admin Edit Page - START                               
    //   **********************************************************************  

        public void function Users_Admin_Edit_RETRIEVE( required struct urlData, boolean debug ){

            //struct
            var resultStruct                    = {};
            var listOfLocationsStruct           = {};
            var entryPointInfo                  = {};
            var userSecurityRoleTypesStruct     = {};
            var metaData                        = {};
            var element                         = {};

            //arrays
            var elements                        = [];
            var domData                         = [];
            var subels                          = [];

            //queries
            var roleTypeQoQ                     = queryNew( '' );
            var userSecurityRoleTypes           = queryNew( '' );

            //numerics
            var idx                             = 1;
            var value                           = 1;
            var securityLevel                   = 1;

            //strings
            var type                    = '';
            var query                   = '';
            var htmlBlob                = '';
            var key                     = '';
        

            //booleans
            local.debug                 = arguments.debug?: false;

            try{

                resultStruct            = application.adminPanel.components.site.models.users.Users_Admin_Edit_READ( urlData );

                listofLocations         = application.adminPanel.components.site.models.users.Users_ListOfLocations_READ();

                userSecurityRoleTypes   = application.adminPanel.components.site.models.users.Users_SecurityRoleTypes_READ();

                entryPointInfo          = application.adminPanel.components.site.models.users.Users_EntryPointInfo_READ();

                roleTypeQoQ                 = '
            
                    SELECT  *
                    FROM    userSecurityRoleTypes.result
                    WHERE   type = :type
            
                ';

                for( type in listRemoveDuplicates( valueList( userSecurityRoleTypes.result.type ), ',', true ) ){

                    query = queryExecute( roleTypeQoQ, { type = { value=type, cfsqltype='cf_sql_integer' } }, { dbtype='query', result='metaData' } );

                    structInsert( userSecurityRoleTypesStruct, type, query );

                }
                

                savecontent variable='htmlBlob'{

                    writeOutput( application.adminPanel.components.site.views.users.Users_Admin_Edit_VIEW( urlData, resultStruct.result, listOfLocations.result, userSecurityRoleTypes.result, entryPointInfo.result, userSecurityRoleTypesStruct, local.debug ) );

                }

                
                domData         = application.adminPanel.java.jSoup.parse( htmlBlob ).select( 'form' );
                fieldsets       = domData.select( "fieldset[securitylevel]" );
                securityLevel   = application.securityRoles[ trim( resultStruct.result.userType ) ];
                securityLevel   = ( structKeyExists( urlData, 'userType' ) && urlData.userType!= '' ) ? application.securityRoles[ urlData.userType ] : securityLevel;

                //writeDump( application.securityRoles[ trim( resultStruct.result.userType ) ] ) abort;

                //remove fieldsets and input fieldset that the user and or page are not allowed to have
                fieldsets.each(function( element, idx ){
                    if( element.attr('securitylevel') > securityLevel ){
                        domData.select( "fieldset[securitylevel=#element.attr('securitylevel')#]" ).remove();
                    } else {             
                        element.select( "div[securitylevel]" ).each( function( subel, subidx ){
                            //writeDump( var=this, label='this in element loop' );
                            if( subel.attr('securitylevel') > securityLevel ){
                                element.select( "div[securitylevel=#subel.attr('securitylevel')#]" ).remove();
                            }
                        } )
                    }
                    
                });   
                
                domData = application.adminPanel.components.utility.security.Security_DisableElementsByUserSecurityLevels_RENDER( urlData, domData, 'input,textarea,select,button' );           

                writeOutput( domData.outerHtml() );

            }catch( any e ){

                var errorStruct                 = structNew();
                errorStruct[ 'cfcatch' ]        = e;
                errorStruct[ 'ARGUMENTS' ]      = arguments;
                errorStruct[ 'VARIABLES' ]      = variables;
                errorStruct[ 'resultStruct' ]   = {};
                
                writeDump( errorStruct );

            }


        }

        public void function Users_Admin_Edit_PROCESS( required struct formData, boolean debug ){

            //structs
            var resultStruct    = {};
            var jsonStruct      = {};

            //Array
            var booleanArray    = [];

            //Booleans
            var arrayPos        = 1;


            //set default shape for jsonStruct and booleanArray
            jsonStruct      = application.adminPanel.components.utility.datastructures.DataStructure_JSONStruct_GENERATE();
            booleanArray    = application.adminPanel.components.utility.datastructures.DataStructure_BooleanArray_GENERATE();

            //Set values for each step the hydra method will have to validate, mainly locations and messages
            booleanArray[ 1 ][ 'locationOnSuccess' ] = application.adminPanel.components.utility.strings.Strings_GeneratePageHref_TASK( 'allListing' );
            booleanArray[ 1 ][ 'locationOnFailure' ] = 'noredirect';

            jsonStruct[ 'onSuccess' ][ 'message' ][ 1 ]  = 'You''ve successfully removed the previous user.';
            jsonStruct[ 'onSuccess' ][ 'status' ][ 1 ]   = 'success';

            jsonStruct[ 'onFailure' ][ 'message' ][ 1 ]  = 'Something has gone wrong with removing the previous user, please try again later.';
            jsonStruct[ 'onFailure' ][ 'status' ][ 1 ]   = 'failure';

            try{    

                formData                = variables.Users_Admin_Edit_PROCESS___validateFormVariables( formData );

                formData.password       = ( formData.passwordReset ) ? formData.password : formData.origPassword;

                formData[ 'query' ]     = variables.Users_Admin_Edit_PROCESS___shapeQuery( formData );

                resultStruct            = application.adminPanel.components.site.models.users.Users_Admin_Edit_UPDATE( formData );

                //writeDump( resultStruct );

                application.adminPanel.components.utility.hydras.Hydra_Basic_TASK( formData, resultStruct, booleanArray, arrayPos, jsonStruct );

            } catch( any e ){

                var errorStruct = {};
                errorStruct[ 'cfcatch' ]        = e;
                errorStruct[ 'arguments' ]      = ARGUMENTS;
                errorStruct[ 'resultStruct' ]   = resultStruct;

                writeDump( errorStruct );

            }

        }

        private struct function Users_Admin_Edit_PROCESS___validateFormVariables( required struct formData, boolean debug ){

            //Lists
            var falseIfNotDefinedList   = 'passwordReset,emailPreference,serverSecurity,rollSecurity,siteSecurity,wlSecurity,eCommSecurity,listEmployee,listAssociate,listContact,active';
            var nullIfNotDefinedList    = 'employeeLocations,associateLocations,contactLocations';
            var falseIfEmptyStringList  = 'validated,mobileServiceID,active';

            for( key in falseIfNotDefinedList ){

                formData[ key ] = ( structKeyExists( formData, key ) ) ? formData[ key ] : 0;

            }

            for( key in nullIfNotDefinedList ){

                formData[ key ] = ( structKeyExists( formData, key ) ) ? formData[ key ] : '';

            }

            for( key in falseIfEmptyStringList ){

                formData[ key ] = ( structKeyExists( formData, key ) && formData[ key ] != '' ) ? formData[ key ] : 0;

            }

            return formData;

        }

        
        private string function Users_Admin_Edit_PROCESS___shapeQuery( required struct formData ){

        
            //strings
            var queryString = '';


            //arrays
            var stringArray = [];

            stringArray[ 1 ] = "
                Update users 
                    Set userType = :userType,      
            ";

            stringArray[ 2 ] = "
                password = :password,
                passwordChange = :passwordChange,
            ";

            stringArray[ 3 ] = "
                    serverSecurity = :serverSecurity,
                    rollSecurity = :rollSecurity,
                    siteSecurity = :siteSecurity,
                    wlSecurity = :wlSecurity,
                    eCommsecurity = :eCommSecurity,
                    listEmployee = :listEmployee, 
                    employeeLocations = :employeeLocations, 
                    listAssociate = :listAssociate, 
                    associateLocations = :associateLocations,
                    listContact        = :listContact,
                    contactLocations   = :contactLocations,   
                    fName = :fName,
                    lName = :lName,
                    title = :title,
                    company = :company,
                    accountNumber = :accountNumber,
                    validated = :validated,
                    address1 = :address1,
                    address2 = :address2,
                    city = :city,
                    state = :State,
                    zip = :zip,
                    pricingLevel = :pricingLevel,
                    phone1 = :phone1,
                    phoneType1 = :phoneType1,
                    phone2 = :phone2,
                    phoneType2 = :phoneType2,
                    mobileServiceID = :mobileServiceID,
                    linkedIn = :linkedIn,
                    twitter = :twitter,
                    facebook = :facebook,
                    publicNotes = :publicNotes,
                    privateNotes = :privateNotes,
                    emailPreference = :emailPreference,
                    active = :active
                Where   userID = :userID
                AND     siteID = :siteID
            ";


                            
            queryString = arrayToList( stringArray , '' );


            return queryString;

        }


    //   **********************************************************************  
    //   *  Users Admin Edit Page - END                               
    //   **********************************************************************  

    //   **********************************************************************  
    //   *  Users Admin Remove Page - START                               
    //   **********************************************************************

        public void function Users_Admin_Remove_PROCESS( required struct formData, boolean debug ){

            //structs
            var resultStruct    = {};
            var jsonStruct      = {};

            //Array
            var booleanArray = [];

            //Numerics
            var arrayPos        = 1;

            //set default shape for jsonStruct and booleanArray
            jsonStruct      = application.adminPanel.components.utility.datastructures.DataStructure_JSONStruct_GENERATE();
            booleanArray    = application.adminPanel.components.utility.datastructures.DataStructure_BooleanArray_GENERATE();

            //Set values for each step the hydra method will have to validate, mainly locations and messages
            booleanArray[ 1 ][ 'locationOnSuccess' ] = application.adminPanel.components.utility.strings.Strings_GeneratePageHref_TASK( 'allListing' );
            booleanArray[ 1 ][ 'locationOnFailure' ] = 'noredirect';

            jsonStruct[ 'onSuccess' ][ 'message' ][ 1 ]  =  'You''ve successfully removed the previous user.';
            jsonStruct[ 'onSuccess' ][ 'status' ][ 1 ]   = 'success';

            jsonStruct[ 'onFailure' ][ 'message' ][ 1 ]  = 'Something has gone wrong with removing the previous user, please try again later.';
            jsonStruct[ 'onFailure' ][ 'status' ][ 1 ]   = 'failure';

            try{    

                resultStruct    = application.adminPanel.components.site.models.users.Users_Admin_Remove_DELETE( formData );

                application.adminPanel.components.utility.hydras.Hydra_Basic_TASK( formData, resultStruct, booleanArray, arrayPos, jsonStruct );

            } catch( any e ){

                var errorStruct = {};
                errorStruct[ 'cfcatch' ]        = e;
                errorStruct[ 'arguments' ]      = ARGUMENTS;
                errorStruct[ 'resultStruct' ]   = resultStruct;

                writeDump( errorStruct );

            }

            
        }

    //   **********************************************************************  
    //   *  Users Admin Remove Page - END                               
    //   **********************************************************************  

}