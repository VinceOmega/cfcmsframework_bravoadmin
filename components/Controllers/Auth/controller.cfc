component displayName="AuthController" output=true hint=""{

    /********
     * Index
     * 
     * 
     * 
     * 
     * ******/

    this.metaData       = {};
    this.metaData.Auth  = {};

    // *************************************************************
    // * Auth Login Page
    // *************************************************************

        public void function Auth_Login_RETRIEVE( required struct urlData, boolean debug ){

            //struct
            var jsonStruct = {};

            //string
            var viewSuffix  = session.adminPanel.user.loggedIn ?  'Active' : 'Inactive' ;
            var output      = '';

            viewSuffix      &= 'Session';

            if( !len( pageAlias ) ){
                application.adminPanel.components.site.views.auth.Auth_Login_VIEW( urlData, viewSuffix );
            } else {

                savecontent variable='output'{

                    writeOutput( this.Auth_Login_PROCESS( urlData, urlData[ 'pageAlias' ] ) );

                }
                
                jsonStruct = deserializeJSON( output );

                writeDump( jsonStruct );

                location( url='#jsonStruct[ 'location' ]#', addtoken=false);

            }

        }

        public void function Auth_Login_PROCESS( required struct formData, required string pageAlias, boolean debug ){

            //structs
            var resultStruct    = {};
            var jsonStruct      = {};

            //Array
            var booleanArray    = [];

            //Booleans
            var arrayPos        = 1;

            //strings
            var loginString     = '';

            formData[ 'ajax' ]  = true;

            //default to false, and set in the resultStruct for the the hydra
            resultStruct[ 'success' ] = false;

            //set default shape for jsonStruct and booleanArray
            jsonStruct      = application.adminPanel.components.utility.datastructures.DataStructure_JSONStruct_GENERATE();
            booleanArray    = application.adminPanel.components.utility.datastructures.DataStructure_BooleanArray_GENERATE();

            //Set values for each step the hydra method will have to validate, mainly locations and messages
            booleanArray[ 1 ][ 'locationOnSuccess' ] = application.adminPanel.components.utility.strings.Strings_GeneratePageHref_TASK( pageAlias );
            booleanArray[ 1 ][ 'locationOnFailure' ] = 'noredirect';

            jsonStruct[ 'onSuccess' ][ 'message' ][ 1 ]  =  'Weclome to the admin panel!';
            jsonStruct[ 'onSuccess' ][ 'status' ][ 1 ]   = 'success';
            jsonStruct[ 'onSuccess' ][ 'sessionid' ]     = 'bravoAdminPanel' & '_' & cookie.cfid & '_' & cookie.cftoken;

            jsonStruct[ 'onFailure' ][ 'message' ][ 1 ]  = 'Either your credentials are wrong or there''s a problem with our system. Try again later or contact Bravo customer service.' ;
            jsonStruct[ 'onFailure' ][ 'status' ][ 1 ]   = 'failure';

            try{    

                loginString = decrypt( replace( formData.loginCode,'~~~',';','ALL' ), "Br4v02000","CFMX_COMPAT","HEX" );
    
                if( !structKeyExists( session[ 'login' ], 'email' )  || listFirst( loginString,'~' ) != session.login.email ){

                    if( listGetAt(loginString,4,'~') is dateFormat(now(),"mm/dd/yyyy") and timeFormat(now(),"HHmmss") - listLast(loginString,"~") lt 30 ){

                        formData.email              = listFirst( loginString, '~' );

                        formData.password           = listGetAt( loginString, 2 , '~');

                        formData.entryPointCode     = listGetAt( loginString, 3, '~' );

                        resultStruct = application.adminPanel.components.site.models.auth.Auth_Login_READ( formData );

                    } 

                } 

                application.adminPanel.components.utility.hydras.Hydra_Basic_TASK( formData, resultStruct, booleanArray, arrayPos, jsonStruct );

            } catch( any e ){

                var errorStruct = {};
                errorStruct[ 'cfcatch' ]        = e;
                errorStruct[ 'arguments' ]      = ARGUMENTS;
                errorStruct[ 'resultStruct' ]   = resultStruct;

                application.adminPanel.components.utility.hydras.Hydra_Basic_TASK( formData, resultStruct, booleanArray, arrayPos, jsonStruct );

            }

        }

    // *************************************************************
    // * Auth Login Page
    // *************************************************************


}