component displayName="UsersModel" output="true" hint="" {


/******
 * Index
 * 
 *
 * 
 * 
 * 
******/

    //   **********************************************************************  
    //   *  Users Listing Page - START                               
    //   **********************************************************************  


        /**
         * @hint:
         */

        public struct function Users_Listing_READ(){

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
                        Select * From users u
                            Where siteID = :siteID
                                And UserType = 'User'
                                Order By if(validated = '' or validated is null,1,0),case when lName = '' then 2 else 1 end asc, lName, fName

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
    //   *  Users Listing Page - END                               
    //   ********************************************************************** 

    //   **********************************************************************  
    //   *  Users Edit Page - START                               
    //   **********************************************************************  

        public struct function Users_Edit_READ( urlData ){

            try{

                //Queries
                var result          = queryNew( '' );

                //Structs
                var metaData        = {};
                var resultStruct    = {};
                var paramStruct     = {};

                //Booleans
                var success         = false;


                result = queryExecute( 
                    "
                        SELECT *
                        FROM users
                        WHERE userID = '#urlData.userID#'
                    "
                    , 
                    {}
                    ,
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

        public struct function Users_Edit_UPDATE( formData ){

            try{

                //Queries
                var result          = queryNew( '' );

                //Structs
                var metaData        = {};
                var resultStruct    = {};
                var paramStruct     = {};

                //Booleans
                var success         = false;


                if( structKeyExists( formData, 'passwordReset' ) ){

                    paramStruct = {
                        userType        = { value=formData.userType?:'',        cfsqltype='cf_sql_varchar' },
                        password        = { value=formData.password,            cfsqltype='cf_sql_varchar' },
                        passwordChange  = { value=formData.passwordReset?:0,    cfsqltype='cf_sql_tinyint' },
                        fName           = { value=formData.fName?:'',           cfsqltype='cf_sql_varchar' },
                        lName           = { value=formData.lName?:'',           cfsqltype='cf_sql_varchar' },
                        title           = { value=formData.title?:'',           cfsqltype='cf_sql_varchar' },
                        company         = { value=formData.company?:'',         cfsqltype='cf_sql_varchar' },
                        accountNumber   = { value=formData.accountNumber?:'',   cfsqltype='cf_sql_varchar' },
                        validated       = { value=formData.validated?:0,        cfsqltype='cf_sql_tinyint' },
                        passwordPrivate = { value=formData.passwordPrivate?:'', cfsqltype='cf_sql_varchar' },
                        address1        = { value=formData.address1?:'',        cfsqltype='cf_sql_varchar' },
                        address2        = { value=formData.address2?:'',        cfsqltype='cf_sql_varchar' },
                        city            = { value=formData.city?:'',            cfsqltype='cf_sql_varchar' },
                        state           = { value=formData.state?:'',           cfsqltype='cf_sql_char' },
                        zip             = { value=formData.zip?:'',             cfsqltype='cf_sql_varchar' },
                        phone1          = { value=formData.phone1?:'',          cfsqltype='cf_sql_varchar' },
                        phoneType1      = { value=formData.phoneType1?:0,       cfsqltype='cf_sql_integer' },
                        phone2          = { value=formData.phone2?:'',          cfsqltype='cf_sql_varchar' },
                        phoneType2      = { value=formData.phoneType2?:0,       cfsqltype='cf_sql_integer' },
                        linkedIn        = { value=formData.linkedIn?:'',        cfsqltype='cf_sql_varchar' },
                        twitter         = { value=formData.twitter?:'',         cfsqltype='cf_sql_varchar' },
                        facebook        = { value=formData.facebook?:'',        cfsqltype='cf_sql_varchar' },
                        privateNotes    = { value=formData.privateNotes?:'',    cfsqltype='cf_sql_varchar' },
                        publicNotes     = { value=formData.publicNotes?:'',     cfsqltype='cf_sql_varchar' },
                        active          = { value=formData.active?:0,           cfsqltype='cf_sql_integer' },
                        userID          = { value=formData.userID,              cfsqltype='cf_sql_integer' },
                        siteID          = { value=session.adminPanel.user.site, cfsqltype='cf_sql_integer' }
                    }

                } else {

                    paramStruct = {
                        userType        = { value=formData.userType?:'',        cfsqltype='cf_sql_varchar' },
                        fName           = { value=formData.fName?:'',           cfsqltype='cf_sql_varchar' },
                        lName           = { value=formData.lName?:'',           cfsqltype='cf_sql_varchar' },
                        title           = { value=formData.title?:'',           cfsqltype='cf_sql_varchar' },
                        company         = { value=formData.company?:'',         cfsqltype='cf_sql_varchar' },
                        accountNumber   = { value=formData.accountNumber?:'',   cfsqltype='cf_sql_varchar' },
                        validated       = { value=formData.validated?:0,        cfsqltype='cf_sql_tinyint' },
                        password        = { value=formData.password,            cfsqltype='cf_sql_varchar' },
                        address1        = { value=formData.address1?:'',        cfsqltype='cf_sql_varchar' },
                        address2        = { value=formData.address2?:'',        cfsqltype='cf_sql_varchar' },
                        city            = { value=formData.city?:'',            cfsqltype='cf_sql_varchar' },
                        state           = { value=formData.state?:'',           cfsqltype='cf_sql_char' },
                        zip             = { value=formData.zip?:'',             cfsqltype='cf_sql_varchar' },
                        phone1          = { value=formData.phone1?:'',          cfsqltype='cf_sql_varchar' },
                        phoneType1      = { value=formData.phoneType1?:0,       cfsqltype='cf_sql_integer' },
                        phone2          = { value=formData.phone2?:'',          cfsqltype='cf_sql_varchar' },
                        phoneType2      = { value=formData.phoneType2?:0,       cfsqltype='cf_sql_integer' },
                        linkedIn        = { value=formData.linkedIn?:'',        cfsqltype='cf_sql_varchar' },
                        twitter         = { value=formData.twitter?:'',         cfsqltype='cf_sql_varchar' },
                        facebook        = { value=formData.facebook?:'',        cfsqltype='cf_sql_varchar' },
                        privateNotes    = { value=formData.privateNotes?:'',    cfsqltype='cf_sql_varchar' },
                        publicNotes     = { value=formData.publicNotes?:'',     cfsqltype='cf_sql_varchar' },
                        active          = { value=formData.active?:0,           cfsqltype='cf_sql_integer' },
                        userID          = { value=formData.userID,              cfsqltype='cf_sql_integer' },
                        siteID          = { value=session.adminPanel.user.site, cfsqltype='cf_sql_integer' }
                    }

                }


                result = queryExecute( formData[ 'query' ], paramStruct,
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

            resultStruct[ 'success' ]       = success?: false;
            resultStruct[ 'result' ]        = result?: queryNew( '' );
            resultStruct[ 'errors' ]        = errorStruct?: {};

            return resultStruct;

        }


    //   **********************************************************************  
    //   *  Users Edit Page - END
    //   **********************************************************************  
    
    //   **********************************************************************  
    //   *  Users Create Page - START                               
    //   **********************************************************************  

        public struct function Users_Create_READ( urlData ){

            try{

                //Queries
                var result          = queryNew( '' );
                var fielddata       = queryNew( '' );

                //Structs
                var metaData        = {};
                var resultStruct    = {};
                var paramStruct     = {};

                //Booleans
                var success         = false;



                result = queryExecute( 
                    "
                        SELECT *
                        FROM users
                        WHERE userID = :userID
                    
                    ", 
                    { 
                        userID = { value=urlData.userID, cfsqltype="cf_sql_integer" } 
                    },
                    {

                        datasource  = application.mainDatabase,
                        result      = "metaData.result"

                    }

                );

                fielddata = queryExecute( 
                    "
                        SHOW COLUMNS FROM `users`     
                    "
                    , {},
                    {

                        datasource  = application.mainDatabase,
                        result      = "metaData.fielddata"

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
            resultStruct[ 'fielddata' ]     = fielddata; 
            resultStruct[ 'errors' ]        = errorStruct?: {};

            return resultStruct;

        }

        public struct function Users_Create_CREATE( formData ){

            try{

                //Queries
                var result          = queryNew( '' );
                var affectedRecord  = queryNew( '' );

                //Structs
                var metaData        = {};
                var resultStruct    = {};
                var paramStruct     = {};

                //Booleans
                var success         = false;

                paramStruct = {

                    siteID              = { value=session.adminpanel.user.site,     cfsqltype='cf_sql_integer' },
                    email               = { value=formData.email,                   cfsqltype='cf_sql_varchar' },
                    password            = { value=formData.password,                cfsqltype='cf_sql_varchar' },
                    userType            = { value=formData.userType,                cfsqltype='cf_sql_varchar' },
                    fName               = { value=formData.fName,                   cfsqltype='cf_sql_varchar' },
                    lName               = { value=formData.lName,                   cfsqltype='cf_sql_varchar' },
                    title               = { value=formData.title,                   cfsqltype='cf_sql_varchar' },
                    company             = { value=formData.company,                 cfsqltype='cf_sql_varchar' },
                    address1            = { value=formData.address1,                cfsqltype='cf_sql_varchar' },
                    address2            = { value=formData.address2,                cfsqltype='cf_sql_varchar' },
                    city                = { value=formData.city,                    cfsqltype='cf_sql_varchar' },
                    state               = { value=formData.state,                   cfsqltype='cf_sql_char' },
                    zip                 = { value=formData.zip,                     cfsqltype='cf_sql_varchar' },
                    phone1              = { value=formData.phone1,                  cfsqltype='cf_sql_varchar' },
                    phoneType1          = { value=formData.phoneType1,              cfsqltype='cf_sql_integer' },
                    phone2              = { value=formData.phone2,                  cfsqltype='cf_sql_varchar' },
                    phoneType2          = { value=formData.phoneType2,              cfsqltype='cf_sql_integer' },
                    linkedIn            = { value=formData.linkedIn,                cfsqltype='cf_sql_varchar' },
                    twitter             = { value=formData.twitter,                 cfsqltype='cf_sql_varchar' },
                    facebook            = { value=formData.facebook,                cfsqltype='cf_sql_varchar' },
                    privateNotes        = { value=formData.privateNotes,            cfsqltype='cf_sql_varchar' },
                    publicNotes         = { value=formData.publicNotes,             cfsqltype='cf_sql_varchar' }
                };


                result = queryExecute( formData[ 'query' ], paramStruct,
                    {

                        datasource  = application.mainDatabase,
                        result      = "metaData"

                    }

                );

                affectedRecord = queryExecute( 'SELECT userid FROM users WHERE siteID = :siteID ORDER BY userid DESC LIMIT 1;', { siteID = request.siteSelected },
                {
                    datasource      = application.mainDatabase,
                    result          = 'metaData'
                } )

                result = result?: queryNew( '' );
                queryAddColumn( result, 'userid', 'Integer', [ affectedRecord.userID ] );

                success = true;

            } catch( any e ){

                var errorStruct             = structNew();
                errorStruct[ 'cfcatch' ]    = e;
                errorStruct[ 'metaData' ]   = metaData;
                errorStruct[ 'arguments' ]  = arguments;
                errorStruct[ 'success' ]    = success;

            }

            resultStruct[ 'success' ]           = success?: false;
            resultStruct[ 'result' ]            = result?: queryNew( '' );
            resultStruct[ 'errors' ]            = errorStruct?: {};

            return resultStruct;

        }


    //   **********************************************************************  
    //   *  Users Create Page - END
    //   **********************************************************************  
  
    //   **********************************************************************  
    //   *  Users Check Page - START                               
    //   **********************************************************************  

        public struct function Users_Check_READ( formData ){

            try{

                //Queries
                var result          = queryNew( '' );
                var fielddata       = queryNew( '' );

                //Structs
                var metaData        = {};
                var resultStruct    = {};
                var paramStruct     = {};

                //Booleans
                var success         = false;


                result   = queryExecute( 
                    "
                        SELECT  *
                        FROM    users
                        WHERE   email = :email
                        AND     siteID = :siteID
                    "
                    ,   {
                            email   = { value = formData.email,                 cfsqltype = 'cf_sql_varchar' },
                            siteID  = { value = session.adminPanel.user.site,   cfsqltype = 'cf_sql_integer' }
                        
                        },
                    {

                        datasource  = application.mainDatabase,
                        result      = "metaData.result"

                    }

                );   

                fielddata = queryExecute( 
                    "
                        SHOW COLUMNS FROM `users`     
                    "
                    , {},
                    {

                        datasource  = application.mainDatabase,
                        result      = "metaData.fielddata"

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
            resultStruct[ 'fielddata' ]     = fielddata;
            resultStruct[ 'errors' ]        = errorStruct?: {};

            return resultStruct;

        }


    //   **********************************************************************  
    //   *  Users Check Page - END
    //   **********************************************************************  

    //   **********************************************************************  
    //   *  Users Remove Page - START                               
    //   **********************************************************************  

        /**
         * @hint:
         */

         public struct function Users_Remove_DELETE( required struct formData ){

            try{

                //Queries
                var result          = queryNew( '' );

                //Structs
                var metaData        = {};
                var resultStruct    = {};

                //Booleans
                var success         = false;


                resultStruct =  Users_SharedRemoveUsersQuery_DELETE( formData );


            } catch( any e ){

                var errorStruct             = structNew();
                errorStruct[ 'cfcatch' ]    = e;
                errorStruct[ 'metaData' ]   = metaData;
                errorStruct[ 'arguments' ]  = arguments;

            }

            resultStruct[ 'errors' ]        = errorStruct?: {};

            return resultStruct;

         }

    //   **********************************************************************  
    //   *  Users Remove Page - END
    //   ********************************************************************** 

    //   **********************************************************************
    //   *  Users Get Info - START
    //   **********************************************************************

         /**
          * @hint:
          */

         public struct function Users_Get_Info_READ( required struct formData, boolean debug ){

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
                        SELECT *
                        FROM users
                        WHERE   email   = :email
                        AND     siteID  = :siteID

                    ",
                    {

                        email   = { value=formData.email, cfsqltype='cf_sql_varchar' },
                        siteID  = { value=session.adminPanel.user.site, cfsqltype='cf_sql_integer' }

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

            resultStruct[ 'success' ]       = success?:false;
            resultStruct[ 'result' ]        = result?:queryNew('');
            resultStruct[ 'metaData' ]      = metaData;
            resultStruct[ 'errors' ]        = errorStruct?: {};

            return resultStruct;

         }

    //   **********************************************************************
    //   *  Users Get Info - END
    //   **********************************************************************

    //   **********************************************************************  
    //   *  Users Trade Professional Listing Page - START                               
    //   **********************************************************************  


        /**
         * @hint:
         */

        public struct function Users_Trade_Listing_READ(){

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
                        Select * From users u
                            Where siteID = :siteID
                                And UserType = 'Special'
                                Order By if(validated = '' or validated is null,1,0),case when lName = '' then 2 else 1 end asc, lName, fName

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
            resultStruct[ 'metaData' ]      = metaData;
            resultStruct[ 'errors' ]        = errorStruct?: {};

            return resultStruct;


        }


    //   **********************************************************************  
    //   *  Users Trade Professional Listing Page - END                               
    //   ********************************************************************** 

    //   **********************************************************************  
    //   *  Users Trade Professional Edit Page - START                               
    //   **********************************************************************  

        public struct function Users_Trade_Edit_READ( urlData ){

            try{

                //Queries
                var result          = queryNew( '' );

                //Structs
                var metaData        = {};
                var resultStruct    = {};
                var paramStruct     = {};

                //Booleans
                var success         = false;


                result = queryExecute( 
                    "
                        SELECT *
                        FROM users
                        WHERE userID = '#urlData.userID#'
                    "
                    , 
                    {},
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

        public struct function Users_Trade_Edit_UPDATE( formData ){

            try{

                //Queries
                var result          = queryNew( '' );

                //Structs
                var metaData        = {};
                var resultStruct    = {};
                var paramStruct     = {};

                //Booleans
                var success         = false;

                if( structKeyExists( formData, 'passwordReset' ) ){

                    paramStruct = {

                        userType        = { value=formData.userType?:'',            cfsqltype='cf_sql_varchar' },
                        password        = { value=formData.password,                cfsqltype='cf_sql_varchar' },
                        passwordChange  = { value=formData.passwordReset?:0,       cfsqltype='cf_sql_tinyint' },
                        pricingLevel    = { value=formData.pricingLevel?:0,         cfsqltype='cf_sql_integer' },
                        fName           = { value=formData.fName?:'',               cfsqltype='cf_sql_varchar' },
                        lName           = { value=formData.lName?:'',               cfsqltype='cf_sql_varchar' },
                        title           = { value=formData.title?:'',               cfsqltype='cf_sql_varchar' },
                        company         = { value=formData.company?:'',             cfsqltype='cf_sql_varchar' },
                        accountNumber   = { value=formData.accountNumber?:'',       cfsqltype='cf_sql_varchar' },
                        validated       = { value=formData.validated?:0,            cfsqltype='cf_sql_tinyint' },
                        passwordPrivate = { value=formData.passwordPrivate?:'',     cfsqltype='cf_sql_varchar' },
                        address1        = { value=formData.address1?:'',            cfsqltype='cf_sql_varchar' },
                        address2        = { value=formData.address2?:'',            cfsqltype='cf_sql_varchar' },
                        city            = { value=formData.city?:'',                cfsqltype='cf_sql_varchar' },
                        state           = { value=formData.state?:'',               cfsqltype='cf_sql_char' },
                        zip             = { value=formData.zip?:'',                 cfsqltype='cf_sql_varchar' },
                        phone1          = { value=formData.phone1?:'',              cfsqltype='cf_sql_varchar' },
                        phoneType1      = { value=formData.phoneType1?:0,           cfsqltype='cf_sql_integer' },
                        phone2          = { value=formData.phone2?:'',              cfsqltype='cf_sql_varchar' },
                        phoneType2      = { value=formData.phoneType2?:0,           cfsqltype='cf_sql_integer' },
                        linkedIn        = { value=formData.linkedIn?:'',            cfsqltype='cf_sql_varchar' },
                        twitter         = { value=formData.twitter?:'',             cfsqltype='cf_sql_varchar' },
                        facebook        = { value=formData.facebook?:'',            cfsqltype='cf_sql_varchar' },
                        privateNotes    = { value=formData.privateNotes?:'',        cfsqltype='cf_sql_varchar' },
                        publicNotes     = { value=formData.publicNotes?:'',         cfsqltype='cf_sql_varchar' },
                        active          = { value=formData.active?:0,               cfsqltype='cf_sql_bit' },
                        userID          = { value=formData.userID,                  cfsqltype='cf_sql_integer' },
                        siteID          = { value=session.adminPanel.user.site,     cfsqltype='cf_sql_integer' }

                    }

                } else {

                    paramStruct = {

                        userType        = { value=formData.userType?:'',            cfsqltype='cf_sql_varchar' },
                        pricingLevel    = { value=formData.pricingLevel?:0,         cfsqltype='cf_sql_integer' },
                        fName           = { value=formData.fName?:'',               cfsqltype='cf_sql_varchar' },
                        lName           = { value=formData.lName?:'',               cfsqltype='cf_sql_varchar' },
                        title           = { value=formData.title?:'',               cfsqltype='cf_sql_varchar' },
                        company         = { value=formData.company?:'',             cfsqltype='cf_sql_varchar' },
                        accountNumber   = { value=formData.accountNumber?:'',       cfsqltype='cf_sql_varchar' },
                        validated       = { value=formData.validated?:0,            cfsqltype='cf_sql_tinyint' },
                        password        = { value=formData.password?:'',            cfsqltype='cf_sql_varchar' },
                        address1        = { value=formData.address1?:'',            cfsqltype='cf_sql_varchar' },
                        address2        = { value=formData.address2?:'',            cfsqltype='cf_sql_varchar' },
                        city            = { value=formData.city?:'',                cfsqltype='cf_sql_varchar' },
                        state           = { value=formData.state?:'',               cfsqltype='cf_sql_char' },
                        zip             = { value=formData.zip?:'',                 cfsqltype='cf_sql_varchar' },
                        phone1          = { value=formData.phone1?:'',              cfsqltype='cf_sql_varchar' },
                        phoneType1      = { value=formData.phoneType1?:0,           cfsqltype='cf_sql_integer' },
                        phone2          = { value=formData.phone2?:'',              cfsqltype='cf_sql_varchar' },
                        phoneType2      = { value=formData.phoneType2?:0,           cfsqltype='cf_sql_integer' },
                        linkedIn        = { value=formData.linkedIn?:'',            cfsqltype='cf_sql_varchar' },
                        twitter         = { value=formData.twitter?:'',             cfsqltype='cf_sql_varchar' },
                        facebook        = { value=formData.facebook?:'',            cfsqltype='cf_sql_varchar' },
                        privateNotes    = { value=formData.privateNotes?:'',        cfsqltype='cf_sql_varchar' },
                        publicNotes     = { value=formData.publicNotes?:'',         cfsqltype='cf_sql_varchar' },
                        userID          = { value=formData.userID,                  cfsqltype='cf_sql_integer' },
                        siteID          = { value=session.adminPanel.user.site,     cfsqltype='cf_sql_integer' }

                    };

                }


                result = queryExecute( formData[ 'query' ], paramStruct,
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

            resultStruct[ 'success' ]       = success?:false;
            resultStruct[ 'result' ]        = result?:queryNew( '' );
            resultStruct[ 'errors' ]        = errorStruct?: {};

            return resultStruct;

        }


    //   **********************************************************************  
    //   *  Users Trade Professional Edit Page - END
    //   **********************************************************************  
    
    //   **********************************************************************  
    //   *  Users Trade Professional Create Page - START                               
    //   **********************************************************************  

        public struct function Users_Trade_Create_CREATE( formData ){

            //Queries
            var result          = queryNew( '' );
            var affectedRecord  = queryNew( '' );

            //Structs
            var metaData        = {};
            var resultStruct    = {};
            var paramStruct     = {};

            //Booleans
            var success         = false;

            try{

                paramStruct = {

                    siteID              = { value=session.adminpanel.user.site,     cfsqltype='cf_sql_integer' },
                    email               = { value=formData.email,                   cfsqltype='cf_sql_varchar' },
                    password            = { value=formData.password,                cfsqltype='cf_sql_varchar' },
                    userType            = { value=formData.userType,                cfsqltype='cf_sql_varchar' },
                    pricingLevel        = { value=formData.pricingLevel,            cfsqltype='cf_sql_integer' },
                    fName               = { value=formData.fName,                   cfsqltype='cf_sql_varchar' },
                    lName               = { value=formData.lName,                   cfsqltype='cf_sql_varchar' },
                    title               = { value=formData.title,                   cfsqltype='cf_sql_varchar' },
                    company             = { value=formData.company,                 cfsqltype='cf_sql_varchar' },
                    address1            = { value=formData.address1,                cfsqltype='cf_sql_varchar' },
                    address2            = { value=formData.address2,                cfsqltype='cf_sql_varchar' },
                    city                = { value=formData.city,                    cfsqltype='cf_sql_varchar' },
                    state               = { value=formData.state,                   cfsqltype='cf_sql_char' },
                    zip                 = { value=formData.zip,                     cfsqltype='cf_sql_varchar' },
                    phone1              = { value=formData.phone1,                  cfsqltype='cf_sql_varchar' },
                    phoneType1          = { value=formData.phoneType1,              cfsqltype='cf_sql_integer' },
                    phone2              = { value=formData.phone2,                  cfsqltype='cf_sql_varchar' },
                    phoneType2          = { value=formData.phoneType2,              cfsqltype='cf_sql_integer' },
                    linkedIn            = { value=formData.linkedIn,                cfsqltype='cf_sql_varchar' },
                    twitter             = { value=formData.twitter,                 cfsqltype='cf_sql_varchar' },
                    facebook            = { value=formData.facebook,                cfsqltype='cf_sql_varchar' },
                    privateNotes        = { value=formData.privateNotes,            cfsqltype='cf_sql_varchar' },
                    publicNotes         = { value=formData.publicNotes,             cfsqltype='cf_sql_varchar' }
                };


                result = queryExecute( formData[ 'query' ], 
                        paramStruct,
                    {

                        datasource  = application.mainDatabase,
                        result      = "metaData"

                    }

                );

                affectedRecord = queryExecute( 'SELECT userid FROM users ORDER BY userid DESC LIMIT 1;', {},
                {
                    datasource      = application.mainDatabase,
                    result          = 'metaData'
                } )

                queryAddColumn( result, 'userid', 'Integer', [ affectedRecord.userID ] );

                success = true;

            } catch( any e ){

                var errorStruct             = structNew();
                errorStruct[ 'cfcatch' ]    = e;
                errorStruct[ 'metaData' ]   = metaData;
                errorStruct[ 'arguments' ]  = arguments;
                errorStruct[ 'success' ]    = success;

                writeDump( errorStruct );
                abort;

            }

            resultStruct[ 'success' ]       = success;
            resultStruct[ 'result' ]        = result?: queryNew('');
            resultStruct[ 'errors' ]        = errorStruct?: {};

            return resultStruct;

        }


    //   **********************************************************************  
    //   *  Users Trade Professional Create Page - END
    //   **********************************************************************  
  
    //   **********************************************************************  
    //   *  Users Trade Professional Remove Page - START                               
    //   **********************************************************************  

        /**
         * @hint:
         */

         public struct function Users_Trade_Remove_DELETE( required struct formData  ){

            try{

                //Queries
                var result          = queryNew( '' );

                //Structs
                var metaData        = {};
                var resultStruct    = {};



                resultStruct =  Users_SharedRemoveUsersQuery_DELETE( formData );


            } catch( any e ){

                var errorStruct             = structNew();
                errorStruct[ 'cfcatch' ]    = e;
                errorStruct[ 'metaData' ]   = metaData;
                errorStruct[ 'arguments' ]  = arguments;

            }

            resultStruct[ 'errors' ]        = errorStruct?: {};

            return resultStruct;

         }

    //   **********************************************************************  
    //   *  Users Trade Professional Remove Page - END
    //   ********************************************************************** 

    //   **********************************************************************  
    //   *  Users Site Admin Listing Page - START                               
    //   **********************************************************************  


        /**
         * @hint:
         */

        public struct function Users_Site_Admin_Listing_READ(){

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
                        Select * From users u
                            Where siteID = :siteID
                                And UserType = 'Site'
                                Order By if(validated = '' or validated is null,1,0),case when lName = '' then 2 else 1 end asc, lName, fName

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
    //   *  Users Site Admin Listing Page - END                               
    //   ********************************************************************** 

    //   **********************************************************************  
    //   *  Users Site Admin Edit Page - START                               
    //   **********************************************************************  

        public struct function Users_Site_Admin_Edit_READ( urlData ){

            try{

                //Queries
                var result          = queryNew( '' );

                //Structs
                var metaData        = {};
                var resultStruct    = {};
                var paramStruct     = {};

                //Booleans
                var success         = false;


                result = queryExecute( 
                    "
                        SELECT *
                        FROM users
                        WHERE userID = '#urlData.userID#'
                    "
                    , 
                    {},
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

        public struct function Users_Site_Admin_Edit_UPDATE( formData ){

            try{

                //Queries
                var result          = queryNew( '' );

                //Structs
                var metaData        = {};
                var resultStruct    = {};
                var paramStruct     = {};

                //Booleans
                var success         = false;

                paramStruct = {

                    userType            = { value=formData.userType,                cfsqltype='cf_sql_varchar' },
                    password            = { value=formData.password,                cfsqltype='cf_sql_varchar' },
                    passwordChange      = { value=formData.passwordReset,           cfsqltype='cf_sql_varchar' },
                    serverSecurity      = { value=formData.serverSecurity,          cfsqltype='cf_sql_varchar' },
                    rollSecurity        = { value=formData.rollSecurity,            cfsqltype='cf_sql_varchar' },
                    siteSecurity        = { value=formData.siteSecurity,            cfsqltype='cf_sql_varchar' },
                    wlSecurity          = { value=formData.wlSecurity,              cfsqltype='cf_sql_varchar' },
                    eCommSecurity       = { value=formData.eCommSecurity,           cfsqltype='cf_sql_varchar' },
                    listEmployee        = { value=formData.listEmployee,            cfsqltype='cf_sql_varchar' },
                    employeeLocations   = { value=formData.employeeLocations,       cfsqltype='cf_sql_varchar' },
                    listAssociate       = { value=formData.listAssociate,           cfsqltype='cf_sql_varchar' },
                    associateLocations  = { value=formData.associateLocations,      cfsqltype='cf_sql_varchar' },
                    listContact         = { value=formData.listContact,             cfsqltype='cf_sql_varchar' },
                    contactLocations    = { value=formData.contactLocations,        cfsqltype='cf_sql_varchar' },
                    fName               = { value=formData.fName,                   cfsqltype='cf_sql_varchar' },
                    lName               = { value=formData.lName,                   cfsqltype='cf_sql_varchar' },
                    title               = { value=formData.title,                   cfsqltype='cf_sql_varchar' },
                    company             = { value=formData.company,                 cfsqltype='cf_sql_varchar' },
                    accountNumber       = { value=formData.accountNumber,           cfsqltype='cf_sql_varchar' },
                    validated           = { value=formData.validated,               cfsqltype='cf_sql_tinyint' },
                    address1            = { value=formData.address1,                cfsqltype='cf_sql_varchar' },
                    address2            = { value=formData.address2,                cfsqltype='cf_sql_varchar' },
                    city                = { value=formData.city,                    cfsqltype='cf_sql_varchar' },
                    state               = { value=formData.state,                   cfsqltype='cf_sql_char' },
                    zip                 = { value=formData.zip,                     cfsqltype='cf_sql_varchar' },
                    pricingLevel        = { value=formData.pricingLevel,            cfsqltype='cf_sql_integer' },
                    phone1              = { value=formData.phone1,                  cfsqltype='cf_sql_varchar' },
                    phoneType1          = { value=formData.phoneType1,              cfsqltype='cf_sql_integer' },
                    phone2              = { value=formData.phone2,                  cfsqltype='cf_sql_varchar' },
                    phoneType2          = { value=formData.phoneType2,              cfsqltype='cf_sql_integer' },
                    mobileServiceID     = { value=formData.mobileServiceID,         cfsqltype='cf_sql_varchar' },
                    linkedIn            = { value=formData.linkedIn,                cfsqltype='cf_sql_varchar' },
                    twitter             = { value=formData.twitter,                 cfsqltype='cf_sql_varchar' },
                    facebook            = { value=formData.facebook,                cfsqltype='cf_sql_varchar' },
                    publicNotes         = { value=formData.publicNotes,             cfsqltype='cf_sql_varchar' },
                    privateNotes        = { value=formData.privateNotes,            cfsqltype='cf_sql_varchar' },
                    emailPreference     = { value=formData.emailPreference,         cfsqltype='cf_sql_varchar' },
                    active              = { value=formData.active?:0,               cfsqltype='cf_sql_bit'     },
                    userID              = { value=formData.userID,                  cfsqltype='cf_sql_integer' },
                    siteID              = { value=session.adminPanel.user.site,     cfsqltype='cf_sql_integer' }
                };


                result = queryExecute( formData[ 'query' ], paramStruct,
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

            resultStruct[ 'success' ]       = success?:false;
            resultStruct[ 'result' ]        = result?:queryNew( '' );
            resultStruct[ 'errors' ]        = errorStruct?: {};

            return resultStruct;

        }


    //   **********************************************************************  
    //   *  Users Site Admin Edit Page - END
    //   **********************************************************************  
    

    //   **********************************************************************  
    //   *  Users Site Admin Create Page - START                               
    //   **********************************************************************  

        public struct function Users_Site_Admin_Create_CREATE( formData ){

            try{

                //Queries
                var result          = queryNew( '' );
                var affectedRecord  = queryNew( '' );

                //Structs
                var metaData        = {};
                var resultStruct    = {};
                var paramStruct     = {};

                //Booleans
                var success         = false;

                paramStruct = {

                    siteID              = { value=session.adminpanel.user.site,     cfsqltype='cf_sql_integer' },
                    email               = { value=formData.email,                   cfsqltype='cf_sql_varchar' },
                    password            = { value=formData.password,                cfsqltype='cf_sql_varchar' },
                    userType            = { value=formData.userType,                cfsqltype='cf_sql_varchar' },
                    pricingLevel        = { value=formData.pricingLevel,            cfsqltype='cf_sql_integer' },
                    serverSecurity      = { value=formData.serverSecurity,          cfsqltype='cf_sql_varchar' },
                    rollSecurity        = { value=formData.rollSecurity,            cfsqltype='cf_sql_varchar' },
                    siteSecurity        = { value=formData.siteSecurity,            cfsqltype='cf_sql_varchar' },
                    wlSecurity          = { value=formData.wlSecurity,              cfsqltype='cf_sql_varchar' },
                    eCommSecurity       = { value=formData.eCommSecurity,           cfsqltype='cf_sql_varchar' },
                    listEmployee        = { value=formData.listEmployee,            cfsqltype='cf_sql_varchar' },
                    employeeLocations   = { value=formData.employeeLocations?:'',   cfsqltype='cf_sql_varchar' },
                    listAssociate       = { value=formData.listAssociate,           cfsqltype='cf_sql_varchar' },
                    associateLocations  = { value=formData.associateLocations?:'',  cfsqltype='cf_sql_varchar' },
                    listContact         = { value=formData.listContact,             cfsqltype='cf_sql_varchar' },
                    contactLocations    = { value=formData.contactLocations?:'',    cfsqltype='cf_sql_varchar' },
                    fName               = { value=formData.fName,                   cfsqltype='cf_sql_varchar' },
                    lName               = { value=formData.lName,                   cfsqltype='cf_sql_varchar' },
                    title               = { value=formData.title,                   cfsqltype='cf_sql_varchar' },
                    company             = { value=formData.company,                 cfsqltype='cf_sql_varchar' },
                    address1            = { value=formData.address1,                cfsqltype='cf_sql_varchar' },
                    address2            = { value=formData.address2,                cfsqltype='cf_sql_varchar' },
                    city                = { value=formData.city,                    cfsqltype='cf_sql_varchar' },
                    state               = { value=formData.state,                   cfsqltype='cf_sql_char' },
                    zip                 = { value=formData.zip,                     cfsqltype='cf_sql_varchar' },
                    phone1              = { value=formData.phone1,                  cfsqltype='cf_sql_varchar' },
                    phoneType1          = { value=formData.phoneType1,              cfsqltype='cf_sql_integer' },
                    phone2              = { value=formData.phone2,                  cfsqltype='cf_sql_varchar' },
                    phoneType2          = { value=formData.phoneType2,              cfsqltype='cf_sql_integer' },
                    linkedIn            = { value=formData.linkedIn,                cfsqltype='cf_sql_varchar' },
                    twitter             = { value=formData.twitter,                 cfsqltype='cf_sql_varchar' },
                    facebook            = { value=formData.facebook,                cfsqltype='cf_sql_varchar' },
                    privateNotes        = { value=formData.privateNotes,            cfsqltype='cf_sql_varchar' },
                    publicNotes         = { value=formData.publicNotes,             cfsqltype='cf_sql_varchar' },
                    active              = { value=formData.active,                  cfsqltype='cf_sql_integer' }
                };


                result = queryExecute( formData[ 'query' ], paramStruct,
                    {

                        datasource  = application.mainDatabase,
                        result      = "metaData"

                    }

                );

                affectedRecord = queryExecute( 'SELECT userid FROM users ORDER BY userid DESC LIMIT 1;', {},
                {
                    datasource      = application.mainDatabase,
                    result          = 'metaData'
                } )

                queryAddColumn( result, 'userid', 'Integer', [ affectedRecord.userID ] );

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
    //   *  Users Site Admin Create Page - END
    //   **********************************************************************  
  

    //   **********************************************************************  
    //   *  Users Site Admin Remove Page - START                               
    //   **********************************************************************  

        /**
         * @hint:
         */

         public struct function Users_Site_Admin_Remove_DELETE( required struct formData  ){

            try{

                //Queries
                var result          = queryNew( '' );

                //Structs
                var metaData        = {};
                var resultStruct    = {};

 
                resultStruct =  Users_SharedRemoveUsersQuery_DELETE( formData );


            } catch( any e ){

                var errorStruct             = structNew();
                errorStruct[ 'cfcatch' ]    = e;
                errorStruct[ 'metaData' ]   = metaData;
                errorStruct[ 'arguments' ]  = arguments;

            }


            resultStruct[ 'errors' ]        = errorStruct?: {};

            return resultStruct;

         }

    //   **********************************************************************  
    //   *  Users Site Admin Remove Page - END
    //   **********************************************************************    
   
    //   **********************************************************************  
    //   *  Users All Listing Page - START                               
    //   **********************************************************************  


        /**
         * @hint:
         */

        public struct function Users_All_Listing_READ(){

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
                        Select * From users u
                            Where siteID = :siteID
                                Order By if(validated = '' or validated is null,1,0),case when lName = '' then 2 else 1 end asc, lName, fName

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
    //   *  Users All Listing Page - END                               
    //   ********************************************************************** 

    //   **********************************************************************  
    //   *  Users All Edit Page - START                               
    //   **********************************************************************  

        public struct function Users_All_Edit_READ( urlData ){

            try{

                //Queries
                var result          = queryNew( '' );

                //Structs
                var metaData        = {};
                var resultStruct    = {};
                var paramStruct     = {};

                //Booleans
                var success         = false;


                result = queryExecute( 
                    "
                        SELECT *
                        FROM users
                        WHERE userID = '#urlData.userID#'
                    "
                    , 
                    {},
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

        public struct function Users_All_Edit_UPDATE( formData ){

            try{

                //Queries
                var result          = queryNew( '' );

                //Structs
                var metaData        = {};
                var resultStruct    = {};
                var paramStruct     = {};

                //Booleans
                var success         = false;

                paramStruct = {

                    userType            = { value=formData.userType,                cfsqltype='cf_sql_varchar' },
                    password            = { value=formData.password,                cfsqltype='cf_sql_varchar' },
                    passwordChange      = { value=formData.passwordReset,           cfsqltype='cf_sql_varchar' },
                    serverSecurity      = { value=formData.serverSecurity,          cfsqltype='cf_sql_varchar' },
                    rollSecurity        = { value=formData.rollSecurity,            cfsqltype='cf_sql_varchar' },
                    siteSecurity        = { value=formData.siteSecurity,            cfsqltype='cf_sql_varchar' },
                    wlSecurity          = { value=formData.wlSecurity,              cfsqltype='cf_sql_varchar' },
                    eCommSecurity       = { value=formData.eCommSecurity,           cfsqltype='cf_sql_varchar' },
                    listEmployee        = { value=formData.listEmployee,            cfsqltype='cf_sql_varchar' },
                    employeeLocations   = { value=formData.employeeLocations,       cfsqltype='cf_sql_varchar' },
                    listAssociate       = { value=formData.listAssociate,           cfsqltype='cf_sql_varchar' },
                    associateLocations  = { value=formData.associateLocations,      cfsqltype='cf_sql_varchar' },
                    listContact         = { value=formData.listContact,             cfsqltype='cf_sql_varchar' },
                    contactLocations    = { value=formData.contactLocations,        cfsqltype='cf_sql_varchar' },
                    fName               = { value=formData.fName,                   cfsqltype='cf_sql_varchar' },
                    lName               = { value=formData.lName,                   cfsqltype='cf_sql_varchar' },
                    title               = { value=formData.title,                   cfsqltype='cf_sql_varchar' },
                    company             = { value=formData.company,                 cfsqltype='cf_sql_varchar' },
                    accountNumber       = { value=formData.accountNumber,           cfsqltype='cf_sql_varchar' },
                    validated           = { value=formData.validated,               cfsqltype='cf_sql_tinyint' },
                    address1            = { value=formData.address1,                cfsqltype='cf_sql_varchar' },
                    address2            = { value=formData.address2,                cfsqltype='cf_sql_varchar' },
                    city                = { value=formData.city,                    cfsqltype='cf_sql_varchar' },
                    state               = { value=formData.state,                   cfsqltype='cf_sql_char' },
                    zip                 = { value=formData.zip,                     cfsqltype='cf_sql_varchar' },
                    pricingLevel        = { value=formData.pricingLevel,            cfsqltype='cf_sql_integer' },
                    phone1              = { value=formData.phone1,                  cfsqltype='cf_sql_varchar' },
                    phoneType1          = { value=formData.phoneType1,              cfsqltype='cf_sql_integer' },
                    phone2              = { value=formData.phone2,                  cfsqltype='cf_sql_varchar' },
                    phoneType2          = { value=formData.phoneType2,              cfsqltype='cf_sql_integer' },
                    mobileServiceID     = { value=formData.mobileServiceID,         cfsqltype='cf_sql_varchar' },
                    linkedIn            = { value=formData.linkedIn,                cfsqltype='cf_sql_varchar' },
                    twitter             = { value=formData.twitter,                 cfsqltype='cf_sql_varchar' },
                    facebook            = { value=formData.facebook,                cfsqltype='cf_sql_varchar' },
                    publicNotes         = { value=formData.publicNotes,             cfsqltype='cf_sql_varchar' },
                    privateNotes        = { value=formData.privateNotes,            cfsqltype='cf_sql_varchar' },
                    emailPreference     = { value=formData.emailPreference,         cfsqltype='cf_sql_varchar' },
                    active              = { value=formData.active?:0,               cfsqltype='cf_sql_bit'     },
                    userID              = { value=formData.userID,                  cfsqltype='cf_sql_integer' },
                    siteID              = { value=session.adminPanel.user.site,     cfsqltype='cf_sql_integer' }
                };

                result = queryExecute( formData[ 'query' ], paramStruct,
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

            resultStruct[ 'success' ]       = success?:false;
            resultStruct[ 'result' ]        = result?:queryNew( '' );
            resultStruct[ 'errors' ]        = errorStruct?: {};

            return resultStruct;

        }


    //   **********************************************************************  
    //   *  Users All Edit Page - END
    //   **********************************************************************  
    
    //   **********************************************************************  
    //   *  Users All Create Page - START                               
    //   **********************************************************************  

        public struct function Users_All_Create_CREATE( formData ){

            try{

                //Queries
                var result          = queryNew( '' );
                var affectedRecord  = queryNew( '' );

                //Structs
                var metaData        = {};
                var resultStruct    = {};
                var paramStruct     = {};

                //Booleans
                var success         = false;

                paramStruct = {

                    siteID              = { value=session.adminpanel.user.site,     cfsqltype='cf_sql_integer' },
                    email               = { value=formData.email,                   cfsqltype='cf_sql_varchar' },
                    password            = { value=formData.password,                cfsqltype='cf_sql_varchar' },
                    userType            = { value=formData.userType,                cfsqltype='cf_sql_varchar' },
                    pricingLevel        = { value=formData.pricingLevel,            cfsqltype='cf_sql_integer' },
                    serverSecurity      = { value=formData.serverSecurity,          cfsqltype='cf_sql_varchar' },
                    rollSecurity        = { value=formData.rollSecurity,            cfsqltype='cf_sql_varchar' },
                    siteSecurity        = { value=formData.siteSecurity,            cfsqltype='cf_sql_varchar' },
                    wlSecurity          = { value=formData.wlSecurity,              cfsqltype='cf_sql_varchar' },
                    eCommSecurity       = { value=formData.eCommSecurity,           cfsqltype='cf_sql_varchar' },
                    listEmployee        = { value=formData.listEmployee,            cfsqltype='cf_sql_varchar' },
                    employeeLocations   = { value=formData.employeeLocations?:'',   cfsqltype='cf_sql_varchar' },
                    listAssociate       = { value=formData.listAssociate,           cfsqltype='cf_sql_varchar' },
                    associateLocations  = { value=formData.associateLocations?:'',  cfsqltype='cf_sql_varchar' },
                    listContact         = { value=formData.listContact,             cfsqltype='cf_sql_varchar' },
                    contactLocations    = { value=formData.contactLocations?:'',    cfsqltype='cf_sql_varchar' },
                    fName               = { value=formData.fName,                   cfsqltype='cf_sql_varchar' },
                    lName               = { value=formData.lName,                   cfsqltype='cf_sql_varchar' },
                    title               = { value=formData.title,                   cfsqltype='cf_sql_varchar' },
                    company             = { value=formData.company,                 cfsqltype='cf_sql_varchar' },
                    address1            = { value=formData.address1,                cfsqltype='cf_sql_varchar' },
                    address2            = { value=formData.address2,                cfsqltype='cf_sql_varchar' },
                    city                = { value=formData.city,                    cfsqltype='cf_sql_varchar' },
                    state               = { value=formData.state,                   cfsqltype='cf_sql_char' },
                    zip                 = { value=formData.zip,                     cfsqltype='cf_sql_varchar' },
                    phone1              = { value=formData.phone1,                  cfsqltype='cf_sql_varchar' },
                    phoneType1          = { value=formData.phoneType1,              cfsqltype='cf_sql_integer' },
                    phone2              = { value=formData.phone2,                  cfsqltype='cf_sql_varchar' },
                    phoneType2          = { value=formData.phoneType2,              cfsqltype='cf_sql_integer' },
                    linkedIn            = { value=formData.linkedIn,                cfsqltype='cf_sql_varchar' },
                    twitter             = { value=formData.twitter,                 cfsqltype='cf_sql_varchar' },
                    facebook            = { value=formData.facebook,                cfsqltype='cf_sql_varchar' },
                    privateNotes        = { value=formData.privateNotes,            cfsqltype='cf_sql_varchar' },
                    publicNotes         = { value=formData.publicNotes,             cfsqltype='cf_sql_varchar' },
                    active              = { value=formData.active,                  cfsqltype='cf_sql_integer' }
                };


                result = queryExecute( formData[ 'query' ], paramStruct,
                    {

                        datasource  = application.mainDatabase,
                        result      = "metaData"

                    }

                );

                affectedRecord = queryExecute( 'SELECT userid FROM users ORDER BY userid DESC LIMIT 1;', {},
                {
                    datasource      = application.mainDatabase,
                    result          = 'metaData'
                } )

                queryAddColumn( result, 'userid', 'Integer', [ affectedRecord.userID ] );

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
    //   *  Users All Create Page - END
    //   **********************************************************************  
  
    //   **********************************************************************  
    //   *  Users All Remove Page - START                               
    //   **********************************************************************  

        /**
         * @hint:
         */

         public struct function Users_All_Remove_DELETE( required struct formData  ){

            try{

                //Queries
                var result          = queryNew( '' );

                //Structs
                var metaData        = {};
                var resultStruct    = {};

 
                resultStruct =  Users_SharedRemoveUsersQuery_DELETE( formData );


            } catch( any e ){

                var errorStruct             = structNew();
                errorStruct[ 'cfcatch' ]    = e;
                errorStruct[ 'metaData' ]   = metaData;
                errorStruct[ 'arguments' ]  = arguments;

            }


            resultStruct[ 'errors' ]        = errorStruct?: {};

            return resultStruct;

         }

    //   **********************************************************************  
    //   *  Users All Remove Page - END
    //   ********************************************************************** 

    //   **********************************************************************  
    //   *  Users Admin Listing Page - START                               
    //   **********************************************************************  


        /**
         * @hint:
         */

        public struct function Users_Admin_Listing_READ(){

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
                        Select * From users u
                            Where siteID = :siteID
                                Order By if(validated = '' or validated is null,1,0),case when lName = '' then 2 else 1 end asc, lName, fName

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
    //   *  Users Admin Listing Page - END                               
    //   ********************************************************************** 

    //   **********************************************************************  
    //   *  Users Admin Edit Page - START                               
    //   **********************************************************************  

        public struct function Users_Admin_Edit_READ( urlData ){

            try{

                //Queries
                var result          = queryNew( '' );

                //Structs
                var metaData        = {};
                var resultStruct    = {};
                var paramStruct     = {};

                //Booleans
                var success         = false;


                result = queryExecute( 
                    "
                        SELECT *
                        FROM users
                        WHERE userID = '#urlData.userID#'
                    "
                    , 
                    {},
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

        public struct function Users_Admin_Edit_UPDATE( formData ){

            try{

                //Queries
                var result          = queryNew( '' );

                //Structs
                var metaData        = {};
                var resultStruct    = {};
                var paramStruct     = {};

                //Booleans
                var success         = false;

                paramStruct = {

                    userType            = { value=formData.userType,                cfsqltype='cf_sql_varchar' },
                    password            = { value=formData.password,                cfsqltype='cf_sql_varchar' },
                    passwordChange      = { value=formData.passwordReset,           cfsqltype='cf_sql_varchar' },
                    serverSecurity      = { value=formData.serverSecurity,          cfsqltype='cf_sql_varchar' },
                    rollSecurity        = { value=formData.rollSecurity,            cfsqltype='cf_sql_varchar' },
                    siteSecurity        = { value=formData.siteSecurity,            cfsqltype='cf_sql_varchar' },
                    wlSecurity          = { value=formData.wlSecurity,              cfsqltype='cf_sql_varchar' },
                    eCommSecurity       = { value=formData.eCommSecurity,           cfsqltype='cf_sql_varchar' },
                    listEmployee        = { value=formData.listEmployee,            cfsqltype='cf_sql_varchar' },
                    employeeLocations   = { value=formData.employeeLocations,       cfsqltype='cf_sql_varchar' },
                    listAssociate       = { value=formData.listAssociate,           cfsqltype='cf_sql_varchar' },
                    associateLocations  = { value=formData.associateLocations,      cfsqltype='cf_sql_varchar' },
                    listContact         = { value=formData.listContact,             cfsqltype='cf_sql_varchar' },
                    contactLocations    = { value=formData.contactLocations,        cfsqltype='cf_sql_varchar' },
                    fName               = { value=formData.fName,                   cfsqltype='cf_sql_varchar' },
                    lName               = { value=formData.lName,                   cfsqltype='cf_sql_varchar' },
                    title               = { value=formData.title,                   cfsqltype='cf_sql_varchar' },
                    company             = { value=formData.company,                 cfsqltype='cf_sql_varchar' },
                    accountNumber       = { value=formData.accountNumber,           cfsqltype='cf_sql_varchar' },
                    validated           = { value=formData.validated,               cfsqltype='cf_sql_tinyint' },
                    address1            = { value=formData.address1,                cfsqltype='cf_sql_varchar' },
                    address2            = { value=formData.address2,                cfsqltype='cf_sql_varchar' },
                    city                = { value=formData.city,                    cfsqltype='cf_sql_varchar' },
                    state               = { value=formData.state,                   cfsqltype='cf_sql_char' },
                    zip                 = { value=formData.zip,                     cfsqltype='cf_sql_varchar' },
                    pricingLevel        = { value=formData.pricingLevel,            cfsqltype='cf_sql_integer' },
                    phone1              = { value=formData.phone1,                  cfsqltype='cf_sql_varchar' },
                    phoneType1          = { value=formData.phoneType1,              cfsqltype='cf_sql_integer' },
                    phone2              = { value=formData.phone2,                  cfsqltype='cf_sql_varchar' },
                    phoneType2          = { value=formData.phoneType2,              cfsqltype='cf_sql_integer' },
                    mobileServiceID     = { value=formData.mobileServiceID,         cfsqltype='cf_sql_varchar' },
                    linkedIn            = { value=formData.linkedIn,                cfsqltype='cf_sql_varchar' },
                    twitter             = { value=formData.twitter,                 cfsqltype='cf_sql_varchar' },
                    facebook            = { value=formData.facebook,                cfsqltype='cf_sql_varchar' },
                    publicNotes         = { value=formData.publicNotes,             cfsqltype='cf_sql_varchar' },
                    privateNotes        = { value=formData.privateNotes,            cfsqltype='cf_sql_varchar' },
                    emailPreference     = { value=formData.emailPreference,         cfsqltype='cf_sql_varchar' },
                    active              = { value=formData.active?:0,               cfsqltype='cf_sql_bit'     },
                    userID              = { value=formData.userID,                  cfsqltype='cf_sql_integer' },
                    siteID              = { value=session.adminPanel.user.site,     cfsqltype='cf_sql_integer' }
                };

                result = queryExecute( formData[ 'query' ], paramStruct,
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

            resultStruct[ 'success' ]       = success?:false;
            resultStruct[ 'result' ]        = result?:queryNew( '' );
            resultStruct[ 'errors' ]        = errorStruct?: {};

            return resultStruct;

        }


    //   **********************************************************************  
    //   *  Users Admin Edit Page - END
    //   **********************************************************************  
    
    //   **********************************************************************  
    //   *  Users Admin Create Page - START                               
    //   **********************************************************************  

        public struct function Users_Admin_Create_CREATE( formData ){

            try{

                //Queries
                var result          = queryNew( '' );
                var affectedRecord  = queryNew( '' );

                //Structs
                var metaData        = {};
                var resultStruct    = {};
                var paramStruct     = {};

                //Booleans
                var success         = false;

                paramStruct = {

                    siteID              = { value=session.adminpanel.user.site,     cfsqltype='cf_sql_integer' },
                    email               = { value=formData.email,                   cfsqltype='cf_sql_varchar' },
                    password            = { value=formData.password,                cfsqltype='cf_sql_varchar' },
                    userType            = { value=formData.userType,                cfsqltype='cf_sql_varchar' },
                    pricingLevel        = { value=formData.pricingLevel,            cfsqltype='cf_sql_integer' },
                    serverSecurity      = { value=formData.serverSecurity,          cfsqltype='cf_sql_varchar' },
                    rollSecurity        = { value=formData.rollSecurity,            cfsqltype='cf_sql_varchar' },
                    siteSecurity        = { value=formData.siteSecurity,            cfsqltype='cf_sql_varchar' },
                    wlSecurity          = { value=formData.wlSecurity,              cfsqltype='cf_sql_varchar' },
                    eCommSecurity       = { value=formData.eCommSecurity,           cfsqltype='cf_sql_varchar' },
                    listEmployee        = { value=formData.listEmployee,            cfsqltype='cf_sql_varchar' },
                    employeeLocations   = { value=formData.employeeLocations?:'',   cfsqltype='cf_sql_varchar' },
                    listAssociate       = { value=formData.listAssociate,           cfsqltype='cf_sql_varchar' },
                    associateLocations  = { value=formData.associateLocations?:'',  cfsqltype='cf_sql_varchar' },
                    listContact         = { value=formData.listContact,             cfsqltype='cf_sql_varchar' },
                    contactLocations    = { value=formData.contactLocations?:'',    cfsqltype='cf_sql_varchar' },
                    fName               = { value=formData.fName,                   cfsqltype='cf_sql_varchar' },
                    lName               = { value=formData.lName,                   cfsqltype='cf_sql_varchar' },
                    title               = { value=formData.title,                   cfsqltype='cf_sql_varchar' },
                    company             = { value=formData.company,                 cfsqltype='cf_sql_varchar' },
                    address1            = { value=formData.address1,                cfsqltype='cf_sql_varchar' },
                    address2            = { value=formData.address2,                cfsqltype='cf_sql_varchar' },
                    city                = { value=formData.city,                    cfsqltype='cf_sql_varchar' },
                    state               = { value=formData.state,                   cfsqltype='cf_sql_char' },
                    zip                 = { value=formData.zip,                     cfsqltype='cf_sql_varchar' },
                    phone1              = { value=formData.phone1,                  cfsqltype='cf_sql_varchar' },
                    phoneType1          = { value=formData.phoneType1,              cfsqltype='cf_sql_integer' },
                    phone2              = { value=formData.phone2,                  cfsqltype='cf_sql_varchar' },
                    phoneType2          = { value=formData.phoneType2,              cfsqltype='cf_sql_integer' },
                    linkedIn            = { value=formData.linkedIn,                cfsqltype='cf_sql_varchar' },
                    twitter             = { value=formData.twitter,                 cfsqltype='cf_sql_varchar' },
                    facebook            = { value=formData.facebook,                cfsqltype='cf_sql_varchar' },
                    privateNotes        = { value=formData.privateNotes,            cfsqltype='cf_sql_varchar' },
                    publicNotes         = { value=formData.publicNotes,             cfsqltype='cf_sql_varchar' },
                    active              = { value=formData.active,                  cfsqltype='cf_sql_integer' }
                };


                result = queryExecute( formData[ 'query' ], paramStruct,
                    {

                        datasource  = application.mainDatabase,
                        result      = "metaData"

                    }

                );

                affectedRecord = queryExecute( 'SELECT userid FROM users ORDER BY userid DESC LIMIT 1;', {},
                {
                    datasource      = application.mainDatabase,
                    result          = 'metaData'
                } )

                queryAddColumn( result, 'userid', 'Integer', [ affectedRecord.userID ] );

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
    //   *  Users Admin Create Page - END
    //   **********************************************************************  
  
    //   **********************************************************************  
    //   *  Users Admin Remove Page - START                               
    //   **********************************************************************  

        /**
         * @hint:
         */

         public struct function Users_Admin_Remove_DELETE( required struct formData  ){

            try{

                //Queries
                var result          = queryNew( '' );

                //Structs
                var metaData        = {};
                var resultStruct    = {};

 
                resultStruct =  Users_SharedRemoveUsersQuery_DELETE( formData );


            } catch( any e ){

                var errorStruct             = structNew();
                errorStruct[ 'cfcatch' ]    = e;
                errorStruct[ 'metaData' ]   = metaData;
                errorStruct[ 'arguments' ]  = arguments;

            }


            resultStruct[ 'errors' ]        = errorStruct?: {};

            return resultStruct;

         }

    //   **********************************************************************  
    //   *  Users Admin Remove Page - END
    //   ********************************************************************** 

    //   **********************************************************************
    //   *  Users Export - START
    //   **********************************************************************

        public struct function Users_Export_READ( required string query, required string userType ){

            try{

                //Queries
                var result          = queryNew( '' );

                //Structs
                var metaData        = {};
                var resultStruct    = {};
                var paramStruct     = {};

                //Numerics
                var i               = 1;

                //Booleans
                var success         = false;

                paramStruct = {

                    siteID   = { value=session.adminpanel.user.site, cfsqltype='cf_sql_integer' },
                    userType = { value=userType, cfsqltype='cf_sql_varchar' }

                };

                if( lcase( userType ) == 'any' ){
                    structDelete( paramStruct, 'userType' )
                }


                result = queryExecute( query, paramStruct,
                    {

                        datasource  = application.mainDatabase,
                        result      = "metaData"

                    }

                );

                for( i; i < result.recordCount; i++ ){

                    QuerySetCell( result, 'userType', application[ 'securityRolesAlias' ][ result[ 'userType' ][ i ] ], i )

                }

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
    //   *  Users Export - END
    //   **********************************************************************

    //  ***********************************************************************
    //  *   Users Page Agnostic Functions - START
    //  ***********************************************************************

        public struct function Users_ListOfLocations_READ(){


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
                    Select e.establishmentID, e.establishmentType, e.establishmentKey,
                            e.EstablishmentFullName as Name,  e.EstablishmentAddress1 as address1,
                            e.EstablishmentAddress2 as address2, e.EstablishmentCity as City, 
                            e.EstablishmentState as State, e.EstablishmentZip as zip,
                            e.EstablishmentPhone as phone1, e.establishmentFullName as company
                        From establishments e 
                    Where e.EstablishmentEntryPoint = :siteID 
                        And e.EstablishmentType = 'L' 
                        And e.EstablishmentKey > 0 
                        And e.establishmentActive = 1 
                    Order by e.EstablishmentFullName

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

        public struct function Users_SecurityRoleTypes_READ(){

            try{

                //Queries
                var result          = queryNew( '' );

                //Structs
                var metaData        = {};
                var resultStruct    = {};
                var paramStruct     = {};

                //Booleans
                var success         = false;


                result = queryExecute( 
                    "
                        SELECT *
                        FROM usersecurity
                        
                    "
                    , 
                    {},
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

        public struct function Users_EntryPointInfo_READ(){


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
                        Select * from entryPoints Where entryPointCode = :siteID
                    ",
                    {

                        siteId = { value=request.siteSelected, cfsqltype='cf_sql_integer' }

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


        private struct function Users_SharedRemoveUsersQuery_DELETE( required struct formData ){

            //queries
            var result          = queryNew( '' );

            //structs
            var resultStruct    = structNew();
            var metaData        = structNew();

            //Booleans
            success             = false;

            try{

                result = queryExecute(
                    "
                        UPDATE users
                        SET active    = 0
                        WHERE
                            userID      = :userID AND
                            siteID      = :siteID

                    ",
                    {
                        userID    = { value = formData.userID,              cfsqltype='CF_SQL_INTEGER' },
                        siteID    = { value = session.adminPanel.user.site, cfsqltype='CF_SQL_INTEGER' }

                    },
                    {

                        datasource  = application.mainDatabase,
                        result      = "metaData"

                    }

                );

            success = true;

            } catch( any e ) {
                
                writeDump( e );

            }

            resultStruct[ 'success' ]   = success;
            resultStruct[ 'result' ]    = result?:queryNew( '' );
            resultStruct[ 'metaData' ]  = metaData?:structNew();

            return resultStruct;

        }

    //  ***********************************************************************
    //  *   Users Page Agnostic Functions - END
    //  ***********************************************************************
}