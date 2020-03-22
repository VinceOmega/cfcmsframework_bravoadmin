<!--- Delete any code under this line before push to production. --->




<cfabort>

<cfscript>

    r = randRange(1, 255, 'CFMX_COMPAT');
    g = randRange(1, 255, 'CFMX_COMPAT');
    b = randRange(1, 255, 'CFMX_COMPAT');

    r2 = formatBaseN( r, 16 );
    g2 = formatBaseN( g, 16 );
    b2 = formatBaseN( b, 16 );

    // r2 = bitshln(r2, 16) & '0xff';
    // g2 = bitshln(g2, 8) & '0xff';
    // b2 = bitshln(b2, 0) & '0xff';

    r2 = ( len( r2 ) < 2 ) ? "0" & r2 : r2 ;
    g2 = ( len( g2 ) < 2 ) ? "0" & g2 : g2 ;
    b2 = ( len( b2 ) < 2 ) ? "0" & b2 : b2 ;


    writeDump( r2 );
    writeDump( g2 );
    writeDump( b2 );

    hexValue = r2 & g2 & b2;
    Lum = .21266 * r + .7152 * g + .0722 * b;
    textColor = ( Lum < 100 ) ? "FFFFFF" : "000000";
    userInitals = ( structKeyExists( session, 'login' ) && structKeyExists( session.login, 'fname' ) ) ? left( session.login.fname, 1 ) & left( session.login.lname, 1 ) : 'GU' ;

    hex = "##" & textColor;

    writeDump( hex );

    img = ImageNew( '', 50, 50, 'argb', '#r#,#g#,#b#');
    imageSetAntialiasing( img, true );
    imageSetDrawingColor( img, '#r#,#g#,#b#' );
    imageDrawRect( img, 25, 25, 50, 50, true );
    imageSetDrawingColor( img, '#hex#' );
    imageDrawText( img, userInitals, 25, 25 );

    cfimage( source='#img#', action='writeToBrowser' );

    savecontent variable='fileBlob'{
        cfimage( source='#img#', action='writeToBrowser' )
    }

    writeOutput( fileBlob );

    writeDump( hexValue );
    writeDump( Lum );

    base64 =  ToBase64( fileBlob , 'utf-8' );

    


    cfimage( source='https://ui-avatars.com/api/?name=#userInitals#&background=#hexValue#&color=#textColor#', action='read', name='uiAvatars', format='png' );
    writedump(uiAvatars);

</cfscript>

<cfoutput>
    <img src="data:image/*;base64,#ToBase64(uiAvatars)#" style="border-radius: 100px;">
</cfoutput>

<cfabort>

<cfoutput>

    <html>

        <head>
            <meta charset= "utf-8">
            <meta http-equiv="X-UA-Compatible" content="IE=edge">
            <!-- Tell the browser to be responsive to screen width -->
            <meta name="viewport" content="width=device-width, initial-scale=1">
            <meta name="description" content="Bravo Business Media's Admin Panel for the My Plumbing Showroom platform - https://www.myplumbingshowroom.com">
            <meta name="author" content="Bravo Business Media - https://www.bravobusinessmedia.com">
                        <!-- Favicon icon -->
                        <link rel="icon" type="image/png" sizes="16x16" href="#application[ 'errorPanel' ][ 'Theme' ][ 'Material' ][ 'Assets' ]#images/favicon.png">

                        <title>Test</title>

                        <link href="https://fonts.googleapis.com/css?family=Quicksand:400,500,700&display=swap" rel="stylesheet">

                        <!--- Font Awesome 5 CDN --->
                        <link href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/5.11.2/css/all.css" rel="stylesheet">

                        <!-- Bootstrap Core CSS -->
                        <link href="#application[ 'errorPanel' ][ 'Theme' ][ 'Material' ][ 'Assets' ]#plugins/bootstrap/css/bootstrap.min.css" rel="stylesheet">

                        <!--- Bootstrap Select CSS --->
                        <link href="#application[ 'errorPanel' ][ 'Theme' ][ 'Material' ][ 'Assets' ]#plugins/bootstrap-select/bootstrap-select.min.css" rel="stylesheet">

                        <!--- Seeet Alert CSS --->
                        <link href="#application[ 'errorPanel' ][ 'Theme' ][ 'Material' ][ 'Assets' ]#plugins/sweetalert/sweetalert.css" rel="stylesheet">
                        <!--- Toastr CSS --->
                        <link href="//cdnjs.cloudflare.com/ajax/libs/toastr.js/latest/toastr.min.css" rel="stylesheet">

                        <!-- Custom CSS -->
                        <link href="#application[ 'errorPanel' ][ 'Theme' ][ 'Material' ][ 'CSS' ]#style.css" rel="stylesheet">
                        
                        <!-- You can change the theme colors from here -->
                        <link href="#application[ 'errorPanel' ][ 'Theme' ][ 'Material' ][ 'CSS' ]#colors/gray.css" id="theme" rel="stylesheet">

                        <!--- Custom styles added --->
                        <link href="/style/css/custom.css" rel="stylesheet">

                                                <!-- Include JQuery -->
                                                <script src="#application[ 'errorPanel' ][ 'Theme' ][ 'Material' ][ 'Assets' ]#plugins/jquery/jquery.min.js"></script>

                                                <!--- Include Data Tables --->
                                                <!---
                                                    <script src="#application[ 'errorPanel' ][ 'Theme' ][ 'Material' ][ 'Assets' ]#plugins/datatables.net-bs4/js/dataTables.bootstrap4.min.js"></script>
                                                    <script src="#application[ 'errorPanel' ][ 'Theme' ][ 'Material' ][ 'Assets' ]#plugins/datatables.net-bs4/js/dataTables.responsive.min.js"></script>
                                                --->
                        
                                                <script src="//cdn.datatables.net/1.10.19/js/jquery.dataTables.min.js"></script>

                                            </head>

                                            <body>

                                                <table id="tableContacts" class="display" style="width:100%">
                                                    <thead>
                                                        <tr>
                                                            <th>Name</th>
                                                            <th>Position</th>
                                                            <th>Office</th>
                                                            <th>Age</th>
                                                            <th>Start date</th>
                                                            <th>Salary</th>
                                                        </tr>
                                                    </thead>
                                                    <tfoot>
                                                        <tr>
                                                            <th>Name</th>
                                                            <th>Position</th>
                                                            <th>Office</th>
                                                            <th>Age</th>
                                                            <th>Start date</th>
                                                            <th>Salary</th>
                                                        </tr>
                                                    </tfoot>
                                                </table>


                                            <!---
                                            <cfset resultStruct = {}>
                                            <cfset resultStruct[ 'productsPublished' ] =  application[ 'errorPanel' ][ 'components' ][ 'site' ][ 'models' ][ 'chrome' ].Chrome_ProductsPublished_READ()>
                                            --->

                                            <!--- <h4 class="m-t-0 counter" data-count="#trim(resultStruct.productsPublished.result.solrCount)#">0</h4> --->

                                <!-- Bootstrap tether Core JavaScript -->
                                <script src="#application[ 'errorPanel' ][ 'Theme' ][ 'Material' ][ 'Assets' ]#plugins/popper/popper.min.js"></script>
                                <script src="#application[ 'errorPanel' ][ 'Theme' ][ 'Material' ][ 'Assets' ]#plugins/bootstrap/js/bootstrap.min.js"></script>
                                <!-- slimscrollbar scrollbar JavaScript -->
                                <script src="#application[ 'errorPanel' ][ 'Theme' ][ 'Material' ][ 'JS' ]#jquery.slimscroll.js"></script>
                                <!--Wave Effects -->
                                <script src="#application[ 'errorPanel' ][ 'Theme' ][ 'Material' ][ 'JS' ]#waves.js"></script>
                                <!--Menu sidebar -->
                                <script src="#application[ 'errorPanel' ][ 'Theme' ][ 'Material' ][ 'JS' ]#sidebarmenu.js"></script>
                                <!--stickey kit -->
                                <script src="#application[ 'errorPanel' ][ 'Theme' ][ 'Material' ][ 'Assets' ]#plugins/sticky-kit-master/dist/sticky-kit.min.js"></script>
                                <script src="#application[ 'errorPanel' ][ 'Theme' ][ 'Material' ][ 'Assets' ]#plugins/sparkline/jquery.sparkline.min.js"></script>
                                <!--- sweet alert system --->
                                <script src="#application[ 'errorPanel' ][ 'Theme' ][ 'Material' ][ 'Assets' ]#plugins/sweetalert/sweetalert.min.js"></script>
                                <!--- bootstrap switch --->
                                <script src="#application[ 'errorPanel' ][ 'Theme' ][ 'Material' ][ 'Assets' ]#plugins/bootstrap-switch/bootstrap-switch.min.js"></script>
                                <!--- bootstrap dropdown --->
                                <script src="#application[ 'errorPanel' ][ 'Theme' ][ 'Material' ][ 'Assets' ]#plugins/bootstrap-select/bootstrap-select.min.js"></script>
                                
                                <!--- toastr --->
                                <script src="//cdnjs.cloudflare.com/ajax/libs/toastr.js/latest/toastr.min.js"></script>
                                <script src="#application[ 'errorPanel' ][ 'Theme' ][ 'Material' ][ 'Assets' ]#plugins/toast-master/js/jquery.toast.js"></script>
    
                                <!--Custom JavaScript -->
                                <script src="#application[ 'errorPanel' ][ 'Theme' ][ 'Material' ][ 'JS' ]#custom.min.js"></script>
    
                                <!-- ============================================================== -->
                                <!-- Style switcher -->
                                <!-- ============================================================== -->
                                <script src="#application[ 'errorPanel' ][ 'Theme' ][ 'Material' ][ 'Assets' ]#plugins/styleswitcher/jQuery.style.switcher.js"></script>
    
    <cftry>

        <script>

            $(document).ready(function() {
                
                var pagesStruct = '';
                $.ajax({
                    url: '/config/metaData/pages.json',
                    method: 'GET',
                    dataType: 'json',
                    async: false,
                    success: function( data ){

                        pagesStruct = data;

                    }
                })

                console.log( pagesStruct );

                try{
                
                    $( 'tableContacts' ).dataTable( #APPLICATION[ 'dataTables' ][ 'tableContacts' ]# );

                } catch( e ){

                    console.log(e);
                    
                }


            } );

        </script>

        <cfcatch type="any">

            <cfdump var="#cfcatch#">

        </cfcatch>

    </cftry>

</body>

</html>

</cfoutput>


<cfabort>

<cfscript>




    abort;

    //Breadcrumbs

    function Chrome_Body_RETRIEVE___Breadcrumb___GenerateBreadCrumb( page, section, alias, breadCrumbCollection ){

        //structs
        resultStruct                    = {};
        homePageStruct                  = {};
        local.breadCrumbCollection      = ( structCount( arguments.breadCrumbCollection ) ) ? arguments.breadCrumbCollection : {

            'pages': {

                'home':{

                },

                'currentPage':{

                },

                'parentPage': {

                },

                'childrenPage': {

                }

            }

        };

        if( !structCount( homePageStruct ) ){

            homePageStruct  = structFindKey( application.errorPanel.metaData.pages[ pages ], 'isHome' );

            if ( !homePageStruct[ 1 ][ 'owner' ].isHome ){

                homePageStruct = {};

            }

        }

        if( !structCount( breadCrumbCollection[ 'pages' ][ 'home' ] ) ){

            breadCrumbCollection[ 'pages' ][ 'home' ] = homePageStruct[ 1 ][ 'owner' ];

        }

        resultStruct = structFindValue( application.errorPanel.metaData.pages[ page ], alias );

        if( resultStruct[ 1 ][ 'owner' ][ 'alias' ] != alias ){

            resultStruct = {};

        }

        if( isArray( resultStruct ) && arrayLen( resultStruct ) ){

            if( resultStruct[ 1 ][ 'owner' ][ 'isParent' ] && !structCount( breadCrumbCollection[ 'pages' ][ 'currentPage' ] ) ){

                breadCrumbCollection[ 'pages' ][ 'currentPage' ] = resultStruct[ 1 ][ 'owner' ];

            } else if( resultStruct[ 1 ][ 'owner' ][ 'hasParent' ] && !structCount( breadCrumbCollection[ 'pages' ][ 'currentPage' ] ) ) {

                breadCrumbCollection[ 'pages' ][ 'currentPage' ] = resultStruct[ 1 ][ 'owner' ];

                breadCrumbCollection = Chrome_Body_RETRIEVE___Breadcrumb___GenerateBreadCrumb(  );


            } else if( resultStruct[ 1 ][ 'owner' ][ 'isParent' ] && structCount( breadCrumbCollection[ 'pages' ][ 'currentPage' ] ) ){

            } else if( resultStruct[ 1 ][ 'owner' ][ 'hasParent' ] && structCount( breadCrumbCollection[ 'pages' ][ 'currentPage' ] ) ){

            } else {

            }

        }


    }

    //Chrome_Body_RETRIEVE___Breadcrumb___GenerateBreadCrumb( 'allListing', 'Users', 'allListing', {} )

    abort;

    appName = 'bravoAdminPanel';
    jSessTracker = CreateObject('java', 'coldfusion.runtime.SessionTracker');
    appSessions = jSessTracker.getSessionCollection(JavaCast('string', appName));
    targetSession = appSessions[appName & '_' & cookie.cfid & '_' & cookie.cftoken];
    //targetSession = appSessions[ 'bravoAdminPanel_13945_98ee18d20af5f217-BCD184CF-0771-B5A8-E0355E5E788A3737' ];
    // Dumping, reading, writing WILL update the last accessed time.
    // There are ways around this if needed...
    WriteDump(targetSession);

    abort;

    include '/config/metaData/pages.cfc';

    writeDump( local.metaData );

    abort;

   invokeFunction = 'pageActions_' & 'check' & '_TASK';


   writeDump( arrayFind( arrayFindAll( structFind( GetMetaData( application.errorPanel.components.utility.pageActions ), 'functions' ), function( struct ){
                                    if( !abs( compare( structFind( struct, 'name' ), invokeFunction ) ) ){
                                        return true;
                                    } else {
                                        return false;
                                    }
                                } ), 1 ) );

    
    try{

        formData        = {};

        userData        = queryNew( '' );
        result          = queryNew( '' );
        i               = 1;
        fieldTypeStruct = {};
        cfsqltypeLookupStruct = { 
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
        result = application.errorPanel.components.site.models.users.Users_Check_READ( formData );


        writeDump( result );

        writeDump( 'dumping out information' );

        fieldArray  = listToArray( valueList( result.result.field ) );
        typeArray   = listToArray( valueList( result.result.type ) );


        for( i; i <= arrayLen( fieldArray ); i++ ){

            fieldTypeStruct[ fieldArray[ i ] ] = cfsqltypeLookupStruct[ reReplaceNoCase( typeArray[ i ], "(.*)\([0-9]*\).*", '\1' ) ];

        }

        for( key in fieldTypeStruct ){

            switch( key ){

                case 'userType':

                    queryAddColumn( userData, key, fieldTypeStruct[ key ], [formData[ key ] ] );

                    break;

                case 'email':

                    queryAddColumn( userData, key, fieldTypeStruct[ key ], [formData[ key ] ] );

                    break;

                default:

                    queryAddColumn( userData, key, fieldTypeStruct[ key ], [''] );

                    break;

            }

        }




        /*
        public struct function createJavaComponents(){

            //structs
            var directoryStruct         = {};
            var returnStruct            = {};

            //strings
            var path                    = '';
            var subpath                 = '';
            var topLevelKeys            = '';
            var subLevelKeys            = '';
            var componentKeys           = '';
            var componentsPath          = '';
            var validTLKeys             = 'vendor,homebrew';

            //array
            var pathArray               = [];
            var subPathArray            = [];

            //boolean
            var debug                   = true;

            directoryStruct = directoryList( expandPath( './java' ) );

            for( path in directoryStruct ){

                pathArray = listToArray( path, '\' );

                if( listFind( validTLKeys, pathArray[ arrayLen( pathArray ) ] ) ){

                    structInsert( returnStruct, pathArray[ arrayLen( pathArray ) ], structNew() );

                    for( subpath in directoryList( path ) ){

                        subPathArray    = listToArray( subpath, '\' );
                        componentsPath  = 'java' & '.' & pathArray[ arrayLen( pathArray ) ] & '.' & removeChars( subpathArray[ arrayLen( subpathArray ) ], len( subpathArray[ arrayLen( subpathArray ) ] ) -3, 4 );
                        
                        if( debug ){
                            writeDump( componentsPath );
                        }

                        structInsert( returnStruct[ pathArray[ arrayLen( pathArray ) ] ], subpathArray[ arrayLen( subpathArray ) ], createObject( 'java', componentsPath ).init() );

                    }

                }

            }

            if( debug ){
                writeDump( returnStruct );
            }

            return returnStruct;

        }*/

        //writeDump( createJavaComponents() );

        //writeDump( application[ 'errorPanel' ][ 'java' ][ 'jSoup' ] );
    } catch( any e ){
        writeDump(e);
    }

</cfscript>

<cfabort>

<cfscript>

    q = queryNew( '' );

    sql = "
                                    SELECT DISTINCT entrypointCode, EstablishmentFullName, EstablishmentCity, EstablishmentState, EstablishmentPhone
                                    FROM entrypoints e
                                        JOIN establishments eep ON eep.establishmentEntryPoint = e.entrypointCode
                                    WHERE eep.establishmentType = 'L'
                                        AND eep.establishmentKey = 0
                                        ORDER BY e.EntryPointCode ASC;
    
    ";

    q = queryExecute( sql, {}, { datasource='srlighting' } );

    </cfscript>

    <cfoutput>

        <table id="renderDataTable" class="display compact dataTable" cellspacing="0" width="100%">

            <thead class="dataTable___TableHead">
                <tr class="dataTable___TableHead___QueryRow">
                    <th class="dataTable___TableHead___QueryRow___QueryHeader">
                        Site
                    </th>
                    <th class="dataTable___TableHead___QueryRow___QueryHeader">
                        City
                    </th>
                    <th class="dataTable___TableHead___QueryRow___QueryHeader">
                        State
                    </th>
                </tr>
            </thead>

            <tbod class="dataTable___TableBody">
                <cfloop query="q">
                    <tr class="dataTable___TableBody___QueryRow">
                        <td class="dataTable___TableBody___QueryRow___QueryCell">
                            <a href="javascript:void(0)" data-id="#q.EntryPointCode#" class="dataTable___TableBody___QueryRow___QueryCell___Href">#q.EstablishmentFullName#</a>
                        </td>
                        <td class="dataTable___TableBody___QueryRow___QueryCell">
                            <a href="javascript:void(0)" data-id="#q.EntryPointCode#" class="dataTable___TableBody___QueryRow___QueryCell___Href">#q.EstablishmentCity#</a>
                        </td>
                        <td class="dataTable___TableBody___QueryRow___QueryCell">
                            <a href="javascript:void(0)" data-id="#q.EntryPointCode#" class="dataTable___TableBody___QueryRow___QueryCell___Href">#q.EstablishmentState#</a>
                        </td>
                    </th>
                    
                </cfloop>
            </tbody>

        </table>

    </cfoutput>

    <cfscript>

    abort;

    urlQueryArray = listToArray( cgi.query_string, '&' );

    pusedoURLScope = {};

  
    for( key in urlQueryArray ){

        writeDump( reReplaceNoCase( key, '(.*)=.*', '\1' ) );


        pusedoURLScope[ reReplaceNoCase( key, '(.*)=.*', '\1' ) ] = reReplaceNoCase( key, '.*=(.*)', '\1' );


    }

    writeDump( pusedoURLScope );

    abort;
    
    include 'config/metaData/pages.cfc';

    writeDump( structFind( local.metaData, 'dashboard' ) );

    abort;

    public struct function Login_Signin_READ( required struct formData ){

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
                    Select * From users 
                    Where email     = :email
                    And password    = :password
                    And
                    ( userType 		= 'admin'
                      OR userType = 'site'
                    )

                ",
                {
                    
                    email       = { value = trim( formData.email ), cfsqltype="cf_sql_varchar" },
                    password    = { value = trim( formData.password ), cfsqltype="cf_sql_varchar" }

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
    
    public void function SessionManager_CreateUserSession_TASK( required query userData ){

        if( userData.recordCount ){

            lock scope="Session" timeout="5" type="exclusive"{
        
                session.adminPanel.user.loggedIn 	= true;
                session.login.loggedIn 				= true;
                session.login.signupDate 			= userData.createDate;
                session.login.guest 				= false;
                session.login.userid 				= userData.userid;
                session.login.email 				= userData.email;
                session.login.fName 				= userData.fname;
                session.login.lName 				= userData.lname; 
                session.login.address1 				= userData.address1;
                session.login.address2 				= userData.address2;
                session.login.city 					= userData.city;
                session.login.state 				= userData.state;
                session.login.zip 					= userData.zip;
                session.login.phone 				= userData.phone1;
                session.login.company 				= userData.company;
                session.login.account 				= userData.accountNumber;
                session.login.passwordPrivate 		= userData.passwordPrivate;
                session.login.validated 			= userData.validated;
                session.login.userType 				= userData.userType;

                session.login.pricingLevel 			= ( application.siteID == 251 && userLogin.pricingLevel == 0 && application.getEntryPoint.cpActive10 == 1 ) ? 10 : userData.pricingLevel;
                session.login.securityLevel 		= application.securityRoles[ userData.userType ]?: 0;

                session.login.securityServer 		= userData.serverSecurity;
                session.login.securityContact 		= userData.rollSecurity;
                session.login.securitySite 			= userData.siteSecurity;
                session.login.securityWishList 		= userData.wlSecurity ;
                session.login.securityCommerce 		= userData.ecommSecurity;
                session.login.showAdminLink 		= false;

                if( listFindNoCase( userData.userType, "admin" ) or ( listFindNoCase( userData.userType, "site" ) and !application.siteID is 496 ) ){

                     session.login.showAdminLink 	= true;
                     session.login.adminLink 		= application.errorPanel.components.utility.strings.Strings_GeneratePageHref_TASK( 'dashboard' );
                     session.login.adminLinkName 	= "Site Administration";

                } else if( listFindNoCase( userData.userType, "special") && userData.pricingLevel > 0 ){

                     session.login.adminLink 		= Evaluate( "application.getentrypoint.cpLoginLink#userData.pricingLevel#" );
                     session.login.adminLinkName 	= Evaluate( "application.getentrypoint.cpName#userData.pricingLevel#" );

                }else{

                     session.login.adminLink 		= "";
                     session.login.adminLinkName 	= "";

                }


            }

        } else {

            //session.warning = application.t9n[ session.languageID ].tr_loginFailedWarning;
            session.warning = 'Incorrect username/password, please try again.';

            if( structKeyExists( formData, 'wlProductID' ) && formData.wlProductID != '' ){
                
                location( url=application.errorPanel.components.utility.strings.Strings_GeneratePageHref_TASK( 'signin', 'WLProductID=' & formData.wlProductID & 'loginType=login' ), addtoken=false );

            } else {

                location( url=application.errorPanel.components.utility.strings.Strings_GeneratePageHref_TASK( 'signin' ), addtoken=false );

            }

        }

    }

    formData[ 'email' ]         = 'larry@bravobusinessmedia.com';
    formData[ 'password' ]      = 'Rising@7106';

    resultStruct                = Login_Signin_Read( formData );

     writeDump( SessionManager_CreateUserSession_TASK( resultStruct.result ) );

     writeDump( application.errorPanel.components.utility.strings.Strings_GeneratePageHref_TASK( 'dashboard' ) );
    
     writeDump(session);
    
     abort;

    //writeDump( application.t9n );


    /*
    writeDump(

        arrayFind( arrayFindAll( structFind( GetMetaData( application.errorPanel.components.utility.pageActions ), 'functions' ), function( struct ){
            return compare( structFind( struct, 'name' ), 'pageActions_Signin_TASK' );
        } ), 1 )

    );*/

    abort;

    writeDump( isNumeric( '19111' ) );

    writeDump( isValid( 'string', 19111 ) );

    writeDump( isNumeric(19111) );

    writeDump( isNumeric( '215-847-5012' ) );

    writeDump( isNumeric( '215.847.5012' ) );

    ///writeDump( application );
    
    //writeDump( application.errorPanel.metaData );    

    /*
    temp = {};
    temp = structFindValue( application.errorPanel.metaData.pages[ 'Listing' ], 'userListing' );

    hrefString = '';

    stringArray = [];

    stringArray[ 1 ] = temp[ 1 ][ 'owner' ][ 'dir' ];
    stringArray[ 2 ] = temp[ 1 ][ 'owner' ][ 'section' ];
    stringArray[ 3 ] = temp[ 1 ][ 'owner' ][ 'slug' ];

    hrefString = listAppend( hrefString, arrayToList( stringArray, '/' ), '/' );


    writeDump( lcase( '/' & hrefString ) );
    */

    /*
    
    for( page in application.errorPanel.metaData.pages ){

        if( isStruct( application.errorPanel.metaData.pages[ page ] ) ){
            writeDump( application.errorPanel.components.utility.strings.Strings_GeneratePageHref_TASK( application.errorPanel.metaData.pages[ page ].alias ) );
        }

    } */

    abort;

    public struct function createPageObject( components ){

        //Structs
        var resultStruct                = {};
        resultStruct[ 'navigation' ]    = {};
        resultStruct[ 'pages' ]         = {};

        //Strings
        var key                         = '';

        for( key in components ){

            if( structKeyExists( components[ key ], 'metaData' ) ){
            
                for( sections in components[ key ].metaData ){

                    for( pages in sections ){
                    
                        structInsert( resultStruct[ 'navigation' ], 'pages', this.configComponentsForMetaData.getRouteInMetaData( sections ) );

                    }

                       if( this.debug ){ writeDump( getMetaData( components[ key ] ) ) };

                }

            }

        }        

        return resultStruct;

    }

    createPageObject( application.errorPanel.components.site.controllers );

    //writeDump( application.errorPanel.components.site.controllers.Login.Login_Signin_RETRIEVE )


    abort;

    writeDump(application);
    writeDump(session);

    abort;

    try{

        urlData[ 'title' ] = 'This is a title';

        /*
        writeDump( application );
        writeDump( arguments );
        writeDump( local );
        writeDump( request ); 
        writeDump( cgi );
        writeDump( server );
        */

       // oHTML = createObject( "component", "utilities.htmlElements" );

       // oView = createObject( "component", "components.Controllers.Chrome.controller" );

        //writeDump( oHTML );

        //writeDump( oView );

        //writeDump( invoke( 'components.Controllers.Chrome.controller', 'Chrome_Header_RETRIEVE' ) );

        //oDashboard  = createObject( "component", "components.Controllers.Dashboard.controller" );

        //writeDump( oDashboard );
        
        
        savecontent variable="htmlBlob"{
           application[ 'errorPanel' ][ 'components' ][ 'site' ][ 'controllers' ][ 'dashboard' ].dashboard_dashboard_RETRIEVE( urlData );
        }        

        application[ 'errorPanel' ][ 'components' ][ 'utility' ][ 'htmlElements' ].HTMLELEMENTS_StartDocumentFragment_RENDER();

        application[ 'errorPanel' ][ 'components' ][ 'site' ][ 'controllers' ][ 'chrome' ].Chrome_Header_RETRIEVE( urlData );

        application[ 'errorPanel' ][ 'components' ][ 'site' ][ 'controllers' ][ 'chrome' ].Chrome_Body_RETRIEVE( urlData, htmlBlob, '', '' );

        application[ 'errorPanel' ][ 'components' ][ 'utility' ][ 'htmlElements' ].HTMLELEMENTS_EndDocumentFragment_RENDER();   
        

    } catch( any e ){

        writeDump( e );

    }



</cfscript>
