<cfcomponent displayName="ChromeView" output=true>

    <!---   **********************************************************************  --->
    <!---   *  Common Chrome Views - START                                          --->
    <!---   **********************************************************************  --->

        <!--- Header Related Functions - START --->

            <!---   **********************************************************************  --->
            <!---   **********************************************************************  --->

                <!--- MAIN FUNCTIONS --->


                <cffunction name="Chrome_Header_VIEW" access="PUBLIC" returntype="void" output=true hint="">
                    <cfargument name="urlData" type="struct" required=true>

                    <cfoutput>

                        <head>

                            <cfset variables.Chrome_Header_VIEW___MetaTags( urlData )>

                            <cfset variables.Chrome_Header_VIEW___LinkTags( urlData )>

                            <cfset variables.Chrome_Header_VIEW___ScriptTags( urlData )>

                            <cfset variables.Chrome_Header_VIEW___FallbacksForIE( urlData )>

                        </head>

                    </cfoutput>

                </cffunction>


                <!---   **********************************************************************  --->

                <!--- HELPER FUNCTIONS --->
                

                <cffunction name="Chrome_Header_VIEW___MetaTags" access="PRIVATE" returntype="void" output=true hint="">
                    <cfargument name="urlData" type="struct" required=true>


                    <cfoutput>

                        <meta charset= "utf-8">
                        <meta http-equiv="X-UA-Compatible" content="IE=edge">
                        <!-- Tell the browser to be responsive to screen width -->
                        <meta name="viewport" content="width=device-width, initial-scale=1">
                        <meta name="description" content="Bravo Business Media's Admin Panel for the My Plumbing Showroom platform - https://www.myplumbingshowroom.com">
                        <meta name="author" content="Bravo Business Media - https://www.bravobusinessmedia.com">

                    </cfoutput>

                </cffunction>


                <cffunction name="Chrome_Header_VIEW___LinkTags" access="PRIVATE" returntype="void" output=true hint="">
                    <cfargument name="urlData" type="struct" required=true>


                    <cfoutput>

                        <!-- Favicon icon -->
                        <link rel="icon" type="image/png" sizes="16x16" href="#application[ 'errorPanel' ][ 'Theme' ][ 'Material' ][ 'Assets' ]#images/favicon.png">

                        <title>Bravo Admin | #application.errorPanel.metaData.pages[ urlData[ 'page' ] ].seoTitle?: 'No Title For This Page'#</title>

                        <link href="https://fonts.googleapis.com/css?family=Quicksand:400,500,700&display=swap" rel="stylesheet">

                        <!--- Font Awesome 5 CDN --->
                        <link href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/5.11.2/css/all.css" rel="stylesheet">

                        <!--- Bootstrap Reset CSS --->
                        <link href="#application[ 'errorPanel' ][ 'Theme' ][ 'Material' ][ 'Assets' ]#plugins/bootstrap/css/bootstrap-reboot.min.css" rel="stylesheet">

                        <!--- Bootstrap Core CSS --->
                        <link href="#application[ 'errorPanel' ][ 'Theme' ][ 'Material' ][ 'Assets' ]#plugins/bootstrap/css/bootstrap.min.css" rel="stylesheet">

                        <!--- Bootstrap Grid CSS --->
                        <link href="#application[ 'errorPanel' ][ 'Theme' ][ 'Material' ][ 'Assets' ]#plugins/bootstrap/css/bootstrap-grid.min.css" rel="stylesheet">

                        <!--- Bootstrap Toggle --->
                        <link href="https://gitcdn.github.io/bootstrap-toggle/2.2.2/css/bootstrap-toggle.min.css" rel="stylesheet">

                        <!--- Bootstrap Select CSS --->
                        <link href="#application[ 'errorPanel' ][ 'Theme' ][ 'Material' ][ 'Assets' ]#plugins/bootstrap-select/bootstrap-select.min.css" rel="stylesheet">

                        <!--- Dropify CSS --->
                        <link href="https://cdnjs.cloudflare.com/ajax/libs/Dropify/0.2.2/css/dropify.min.css" rel="stylesheet">

                        <!--- Seeet Alert CSS --->
                        <link href="#application[ 'errorPanel' ][ 'Theme' ][ 'Material' ][ 'Assets' ]#plugins/sweetalert/sweetalert.css" rel="stylesheet">
                        <!--- Toastr CSS --->
                        <link href="//cdnjs.cloudflare.com/ajax/libs/toastr.js/latest/toastr.min.css" rel="stylesheet">

                        <!--- Chartist CSS --->
                        <link href="#application[ 'errorPanel' ][ 'Theme' ][ 'Material' ][ 'Assets' ]#chartist-js/dist/chartist.min.css" rel="stylesheet">
                        <link href="#application[ 'errorPanel' ][ 'Theme' ][ 'Material' ][ 'Assets' ]#chartist-js/dist/chartist.init.css" rel="stylesheet">
                        <link href="#application[ 'errorPanel' ][ 'Theme' ][ 'Material' ][ 'Assets' ]#chartist-plugin-tooltip-master/dist/chartist-plugin-tooltip.css" rel="stylesheet">
                        <link href="#application[ 'errorPanel' ][ 'Theme' ][ 'Material' ][ 'Assets' ]#css-chart/css-chart.css" rel="stylesheet">

                        <!-- Custom CSS -->
                        <link href="#application[ 'errorPanel' ][ 'Theme' ][ 'Material' ][ 'CSS' ]#style.css" rel="stylesheet">
                        
                        <!-- You can change the theme colors from here -->
                        <link href="#application[ 'errorPanel' ][ 'Theme' ][ 'Material' ][ 'CSS' ]#colors/gray.css" id="theme" rel="stylesheet">

                        <!--- Custom styles added --->
                        <link href="/style/css/custom.css" rel="stylesheet">

                    </cfoutput>

                </cffunction>

                <cffunction name="Chrome_Header_VIEW___ScriptTags" access="PRIVATE" returntype="void" output=true hint="">
                    <cfargument name="urlData" type="struct" required=true>

                    <cfoutput>

                        <!-- Include JQuery -->
                        <script src="#application[ 'errorPanel' ][ 'Theme' ][ 'Material' ][ 'Assets' ]#plugins/jquery/jquery.min.js"></script>

                        <!--- Include Data Tables --->
                        <!---
                            <script src="#application[ 'errorPanel' ][ 'Theme' ][ 'Material' ][ 'Assets' ]#plugins/datatables.net-bs4/js/dataTables.bootstrap4.min.js"></script>
                            <script src="#application[ 'errorPanel' ][ 'Theme' ][ 'Material' ][ 'Assets' ]#plugins/datatables.net-bs4/js/dataTables.responsive.min.js"></script>
                        --->

                        <script src="//cdn.datatables.net/1.10.19/js/jquery.dataTables.min.js"></script>

                    </cfoutput>

                </cffunction>


                <cffunction name="Chrome_Header_VIEW___FallbacksForIE" access="PRIVATE" returntype="void" output=true hint="">
                    <cfargument name="urlData" type="struct" required=true>


                    <cfoutput>

                        <!-- HTML5 Shim and Respond.js IE8 support of HTML5 elements and media queries -->
                        <!-- WARNING: Respond.js doesn't work if you view the page via file:// -->
                        <!--[if lt IE 9]>
                        <script src="https://oss.maxcdn.com/libs/html5shiv/3.7.0/html5shiv.js"></script>
                        <script src="https://oss.maxcdn.com/libs/respond.js/1.4.2/respond.min.js"></script>
                        <![endif]-->

                    </cfoutput>

                </cffunction>

            <!---   **********************************************************************  --->
            <!---   **********************************************************************  --->

        <!--- Header Related Functions - END --->

        <!--- Body Related Functions - START --->

            <!---   **********************************************************************  --->
            <!---   **********************************************************************  --->

            
                <!--- MAIN FUNCTIONS --->


                <cffunction name="Chrome_Body_VIEW" access="PUBLIC" returntype="void" output=true hint="">
                    <cfargument name="urlData"              type="struct"   required=true>
                    <cfargument name="htmlBlob"             type="string"   required=true>
                    <cfargument name="breadCrumbData"       type="struct"   required=true>
                    <cfargument name="debugCollection"      type="struct"   requierd=true>
                    <cfargument name="navigationData"       type="struct"   required=true>
                    <cfargument name="resultStruct"         type="struct"   required=true>
                    <cfargument name="partialBlob"          type="string"   required=false default="">


                    <cfoutput>

                        <body class="fix-header fix-sidebar card-no-border">

                            <!--- <cfset variables.Chrome_Body_VIEW___Preloader( urlData )> --->

                            <cfset variables.Chrome_Body_VIEW___ContentContainer( urlData, htmlBlob, breadCrumbData, debugCollection, navigationData, resultStruct, partialBlob )>

                            <cfset variables.Chrome_Body_VIEW___IncludeJavascript( urlData )>

                        </body>

                    </cfoutput>

                </cffunction>


                <!---   **********************************************************************  --->

                <!--- HELPER FUNCTIONS --->


                <cffunction name="Chrome_Body_VIEW___Preloader" access="PRIVATE" returntype="void" output=true hint="">
                    <cfargument name="urlData" type="struct" required=true>
                    
                    <!---
                        NOTE: See the wrappixel documentation to see learn how to change preloaders
                        https://www.wrappixel.com/demos/admin-templates/material-pro/Documentation/document.html##begin
                    --->

                    <cfoutput>

                        <div class="preloader">
                            <svg class="circular" viewBox="25 25 50 50">
                                <circle class="path" cx="50" cy="50" r="20" fill="none" stroke-width="2" stroke-miterlimit="10" /> 
                            </svg>
                        </div>

                    </cfoutput>

                </cffunction>


                <cffunction name="Chrome_Body_VIEW___ContentContainer" access="PRIVATE" returntype="void" output=true hint="">
                    <cfargument name="urlData"              type="struct"   required=true>
                    <cfargument name="htmlBlob"             type="string"   required=true>
                    <cfargument name="breadCrumbData"       type="struct"   required=true>
                    <cfargument name="debugCollection"      type="struct"   required=true>
                    <cfargument name="navigationData"       type="struct"   required=true>
                    <cfargument name="resultStruct"         type="struct"   required=true>
                    <cfargument name="paritalBlob"          type="string"   required=false default="">

                    <cfoutput>

                        <cfset var htmlBlobSidebar = ''>

                        <div id="main-wrapper">
                                                           
                            <cfset variables.Chrome_Body_VIEW___ContentContainer___TopBarContainer( urlData, debugCollection )>

                            <!--- <cfset variables.Chrome_Body_VIEW___ContentContainer___SideBarContainer( urlData, navigationData )> --->

                            <div class="page-wrapper">

                                <div class="container-fluid">

                                    <!--- <cfset variables.Chrome_Body_VIEW___ContentContainer___BreadcrumbGenerator( urlData, breadCrumbData, resultStruct )> --->

                                    <!--- <cfset variables.Chrome_Body_VIEW___ContentContainer___MessageNotification( urlData )> --->

                                    <cfset variables.Chrome_Body_VIEW___ContentContainer___DisplayPage( urlData, htmlBlob )>

                                    <!--- <cfset variables.Chrome_Body_VIEW___ContentContainer___FooterContainer( urlData )> --->

                                </div>

                            </div>

                            <cfset variables.Chrome_Body_VIEW___ContentContainer___RightSidebar( urlData, paritalBlob, queryNew( '' ), true, false )>

                        </div>

                    </cfoutput>

                </cffunction>


                <!--- Top Bar Section --->

                    <cffunction name="Chrome_Body_VIEW___ContentContainer___TopBarContainer" access="PRIVATE" returntype="void" output=true hint="">
                        <cfargument name="urlData"              type="struct"   required=true>
                        <cfargument name="debugCollection"      type="struct"   required=true>

                        <cfoutput>

                            <header class="topbar">

                                <nav class="navbar top-navbar navbar-expand-md navbar-light">

                                    <cfset variables.Chrome_Body_VIEW___ContentContainer___DebuggerMenu( urlData, debugCollection )>

                                    <div class="navbar-collapse">

                                        <!--- Logo --->
                                        <cfset variables.Chrome_Body_VIEW___ContentContainer___TopBarContainer___Logo( urlData )>

                                        <cfset variables.Chrome_Body_VIEW___ContentContainer___TopBarContainer___LeftSection( urlData )>

                                        <cfset variables.Chrome_Body_VIEW___ContentContainer___TopBarContainer___RightSection( urlData )>

                                    </div>

                                </nav>

                            </header>
                        
                        </cfoutput>

                    </cffunction>

                    <cffunction name="Chrome_Body_VIEW___ContentContainer___DebuggerMenu" acess="PRIVATE" returntype="void" output=true hint="">
                        <cfargument name="urlData"              type="struct"   required=true>
                        <cfargument name="debugCollection"      type="struct"    required=true>
                        
                            <!---

                            <cfdump var="#debugCollection#">
                        
                            <div id="debugging-menu" class="debugging-container">

                                <ul class="debugging-container__menu js-menu-collapsable">

                                <cfoutput>

                                    <cfloop array='#debugCollection[ 'SectionHeader' ]#' index='headers'>

                                        <section class="debugging-containter__menu__#headers#">
                                            <h3>#headers#</h3>
                                            <hr>
                                            <cfloop array='#debugCollection[ 'SectionLinks' ][ headers ]#' index='links'>

                                                <!--- <cfdump var="#links#"> --->

                                                <!--- <a href="#application[ 'errorPanel' ][ 'metaData' ][ 'pages' ][ urlData[ 'page' ] ]##debugCollection[ 'sectionLinks' ][ links ]#">#debugCollection[ 'sectionArgs' ][ links ]#</a> --->

                                            </cfloop>
                                            <hr>
                                        </section>

                                    </cfloop>

                                </cfoutput>

                                </ul>

                            </div>                        

                            --->

                    </cffunction>


                    <cffunction name="Chrome_Body_VIEW___ContentContainer___TopBarContainer___Logo" access="PRIVATE" returntype="void" output=true hint="">
                        <cfargument name="urlData" type="struct" required=true>
                    
                        <cfoutput>

                            <div class="navbar-header">

                                <a class="navbar-brand" href="#application.errorPanel.components.utility.strings.Strings_GeneratePageHref_TASK( 'dashboard' )#">
                                    <!-- Admin Panel - Bravo Logo -->
                                    <div class="">
                                        
                                        <div class="">
                                            <img src="#application[ 'errorPanel' ][ 'logo' ]#" alt="Bravo Admin Panel Logo" class="navbar-brand__logo">
                                        </div>
                                        
                                        <!---
                                        <div class="flip-card__face  flip-card--back">
                                            <span class="3dcard__back__slogan">SUCCESS STARTS HERE</span>
                                        </div>
                                        --->
                                        
                                    </div>

                                </a>

                            </div>

                        </cfoutput>

                    </cffunction>


                    <cffunction name="Chrome_Body_VIEW___ContentContainer___TopBarContainer___LeftSection" access="PRIVATE" returntype="void" output=true hint="">
                        <cfargument name="urlData" type="struct" required=true>
                        
                        <cfoutput>

                            <ul class="navbar-nav mr-auto mt-md-o">

                                <cfset variables.Chrome_Body_VIEW___ContentContainer___TopBarContainer___LeftSection___Toggle( urlData )>

                                <!--- <cfset variables.Chrome_Body_VIEW___ContentContainer___TopBarContainer___LeftSection___SiteSelector( urlData )> --->

                                <!---
                                    <cfset variables.Chrome_Body_VIEW___ContentContainer___TopBarContainer___LeftSection___Search( urlData )>

                                    <cfset variables.Chrome_Body_VIEW___ContentContainer___TopBarContainer___LeftSection___Dropdown( urlData )>
                                --->

                            </ul>

                        </cfoutput>

                    </cffunction>


                    <cffunction name="Chrome_Body_VIEW___ContentContainer___TopBarContainer___LeftSection___SiteSelector" aceess="PRIVATE" returntype="void" output=true hint="">
                        <cfargument name="urlData" type="struct" required=true>

                        <cfoutput>

                            <li class="nav-item">

                                <cfif session.adminPanel.user.ownedSites LTE 1 >

                                    <cfset variables.Chrome_Body_VIEW___ContentContainer___TopBarContainer___LeftSection___SiteSelector___SingleSiteOwner( urlData )>

                                <cfelse>

                                    <cfset variables.Chrome_Body_VIEW___ContentContainer___TopBarContainer___LeftSection___SiteSelector___MultipleSiteOwner( urlData )>

                                </cfif>

                            </li>                        

                        </cfoutput>

                    </cffunction>

                   <cffunction name="Chrome_Body_VIEW___ContentContainer___TopBarContainer___LeftSection___SiteSelector___SingleSiteOwner" access="PRIVATE" returntype="void" output=true hint="">
                        <cfargument name="urlData" type="struct" required=true>

                        <cfoutput>

                            <div class="user-profile">

                                <div class="profile-text">

                                    <cfif !session.adminPanel.user.ownedSites>

                                        <div class="user-profile__sitename">
                                            Please select a site from the right.
                                        </div>

                                    <cfelse>

                                        <div class="user-profile__sitename">
                                            #session.adminPanel.user.siteName#
                                        </div>

                                    </cfif>

                                </div>

                            </div>

                        </cfoutput>

                    </cffunction>

                    <cffunction name="Chrome_Body_VIEW___ContentContainer___TopBarContainer___LeftSection___SiteSelector___MultipleSiteOwner" access="PRIVATE" returntype="void" output=true hint="">
                        <cfargument name="urlData" type="struct" required=true>

                        <cfoutput>

                            <div class="user-profile">

                                <div class="profile-text">

                                    <div class="user-profile__sitename">
                                        <span>#session.adminPanel.user.siteName#</span>
                                    </div>

                                </div>

                            </div>

                        </cfoutput>

                    </cffunction>


                    <cffunction name="Chrome_Body_VIEW___ContentContainer___TopBarContainer___LeftSection___Toggle" access="PRIVATE" returntype="void" output=true hint="">
                        <cfargument name="urlData" type="struct" required=true>

                        <cfoutput>

                            <li class="nav-item"> <a class="nav-link nav-toggler hidden-md-up text-muted waves-effect waves-dark" href="javascript:void(0)"><i class="mdi mdi-menu"></i></a> </li>
                            <li class="nav-item"> <a class="nav-link sidebartoggler hidden-sm-down text-muted waves-effect waves-dark" href="javascript:void(0)"><i class="ti-menu"></i></a> </li>

                        </cfoutput>

                    </cffunction>


                    <cffunction name="Chrome_Body_VIEW___ContentContainer___TopBarContainer___LeftSection___Search" access="PRIVATE" returntype="void" output=true hint="">
                        <cfargument name="urlData" type="struct" required=true>

                        <cfoutput>

                            <li class="nav-item hidden-sm-down search-box">

                                <a class="nav-link hidden-sm-down text-muted waves-effect waves-dark" href="javascript:void(0)">

                                    <i class="ti-search"></i>

                                </a>

                                <form class="app-search">

                                    <input type="text" class="form-control" placeholder="Search & enter">
                                    
                                    <a class="srh-btn">

                                        <i class="ti-close"></i>

                                    </a> 

                                </form>

                            </li>  

                        </cfoutput>

                    </cffunction>


                    <cffunction name="Chrome_Body_VIEW___ContentContainer___TopBarContainer___LeftSection___Dropdown" access="PRIVATE" returntype="void" output=true hint="">
                        <cfargument name="urlData" type="struct" required=true>

                        <cfoutput>

                            <li class="nav-item dropdown mega-dropdown">

                                <a class="nav-link dropdown-toggle text-muted waves-effect waves-dark" href="" data-toggle="dropdown" aria-haspopup="true" aria-expanded="false">
                                    <i class="mdi mdi-view-grid"></i>
                                </a>

                                <div class="dropdown-menu scale-up-left">

                                    <ul class="mega-dropdown-menu row">

                                        <cfset variables.Chrome_Body_VIEW___ContentContainer___TopBarContainer___LeftSection___Dropdown___FAQsAccordion( urlData )>

                                        <cfset variables.Chrome_Body_VIEW___ContentContainer___TopBarContainer___LeftSection___Dropdown___ContactUsForm( urlData )>

                                    </ul>

                                </div>

                            </li>

                        </cfoutput>

                    </cffunction>


                    <cffunction name="Chrome_Body_VIEW___ContentContainer___TopBarContainer___LeftSection___Dropdown___FAQsAccordion" access="PRIVATE" returntype="void" output=true hint="">
                        <cfargument name="urlData" type="struct" required=true>

                        <cfoutput>

                            <li class="col-lg-4 col-xlg-4 m-b-30">

                                <h4 class="m-b-20">ACCORDION</h4>

                                <!-- Accordian -->
                                <div id="accordion" class="nav-accordion" role="tablist" aria-multiselectable="true">
                                    
                                    <div class="card">

                                        <div class="card-header" role="tab" id="headingOne">

                                            <h5 class="mb-0">

                                                <a data-toggle="collapse" data-parent="##accordion" href="##collapseOne" aria-expanded="true" aria-controls="collapseOne">
                                                    How do I reset my password?
                                                </a>

                                            </h5>

                                        </div>

                                        <div id="collapseOne" class="collapse show" role="tabpanel" aria-labelledby="headingOne">

                                            <div class="card-body"> 
                                                Anim pariatur cliche reprehenderit, enim
                                                eiusmod high. 
                                            </div>

                                        </div>

                                    </div>
                                    
                                    <div class="card">

                                        <div class="card-header" role="tab" id="headingTwo">

                                            <h5 class="mb-0">

                                                <a class="collapsed" data-toggle="collapse" data-parent="##accordion" href="##collapseTwo" aria-expanded="false" aria-controls="collapseTwo">
                                                    How to do I check my wishlist?
                                                </a>

                                            </h5>

                                        </div>

                                        <div id="collapseTwo" class="collapse" role="tabpanel" aria-labelledby="headingTwo">

                                            <div class="card-body"> 
                                                Anim pariatur cliche reprehenderit, enim
                                                eiusmod high life accusamus terry richardson ad squid. 
                                            </div>
                                            
                                        </div>

                                    </div>

                                    <div class="card">

                                        <div class="card-header" role="tab" id="headingThree">

                                            <h5 class="mb-0">

                                                <a class="collapsed" data-toggle="collapse" data-parent="##accordion" href="##collapseThree" aria-expanded="false" aria-controls="collapseThree">
                                                    How do I change prices on items?
                                                </a>
                                                
                                            </h5>

                                        </div>

                                        <div id="collapseThree" class="collapse" role="tabpanel" aria-labelledby="headingThree">

                                            <div class="card-body"> 
                                                Anim pariatur cliche reprehenderit, enim
                                                eiusmod high life accusamus terry richardson ad squid. 
                                            </div>

                                        </div>

                                    </div>

                                </div>

                            </li> 

                        </cfoutput>

                    </cffunction>


                    <cffunction name="Chrome_Body_VIEW___ContentContainer___TopBarContainer___LeftSection___Dropdown___ContactUsForm" access="PRIVATE" returntype="void" output=true hint="">
                        <cfargument name="urlData" type="struct" required=true>

                        <cfoutput>

                            <!--- Contact Us --->
                            <li class="col-lg-4 col-xlg-4 m-b-30">

                                <h4 class="m-b-20">Want to contact us?</h4>
                            
                                <p>Call 555-555-5555 <p>
                                
                                <hr/>
                                
                                <p> You can also submit a ticket </p>
                                
                                <form>

                                    <div class="form-group">

                                        <input type="text" class="form-control" id="exampleInputname1" placeholder="Enter Name">

                                    </div>

                                    <div class="form-group">

                                        <input type="email" class="form-control" placeholder="Enter email">

                                    </div>

                                    <div class="form-group">

                                        <textarea class="form-control" id="exampleTextarea" rows="3" placeholder="Message"></textarea>

                                    </div>

                                    <button type="button" class="btn btn-info" value="mailto:storesupport@myplumbingshowroom.com&quot;Subject=&amp;Body=">Submit</button>

                                </form>

                            </li>

                        </cfoutput>

                    </cffunction>


                    <cffunction name="Chrome_Body_VIEW___ContentContainer___TopBarContainer___RightSection" access="PRIVATE" returntype="void" output=true hint="">
                        <cfargument name="urlData" type="struct" required=true>

                        <cfoutput>

                            <div class="navbar-nav my-lg-0 btn-group btn-topbar">

                                <ul>

                                    <cfset variables.Chrome_Body_VIEW___ContentContainer___TopBarContainer___RightSection___Help( urlData )>
                                
                                    <cfset variables.Chrome_Body_VIEW___ContentContainer___TopBarContainer___RightSection___Support( urlData )>

                                    <!--- <cfset variables.Chrome_Body_VIEW___ContentContainer___TopBarContainer___RightSection___EditUserLink( urlData )> --->

                                </ul>


                                <!---
                                    <cfset variables.Chrome_Body_VIEW___ContentContainer___TopBarContainer___RightSection___BrandNotifications( urlData )>

                                    <cfset variables.Chrome_Body_VIEW___ContentContainer___TopBarContainer___RightSection___WishlistNotifications( urlData )>

                                    <cfset variables.Chrome_Body_VIEW___ContentContainer___TopBarContainer___RightSection___Flags( urlData )>
                                --->

                            </div>

                        </cfoutput>

                    </cffunction>

                    <cffunction name="Chrome_Body_VIEW___ContentContainer___TopBarContainer___RightSection___Support" access="PRIVATE" returntype="void" output=true hint="">
                        <cfargument name="urlData" type="struct" required=true>

                        <cfoutput>

                            <li class="btn-topbar__items">
                                <a href="javascript:void(0)" class="js-drawer"><i class="fa fa-2x fa-question-circle btn-topbar__items__help-icon" options="{}"></i><span class="btn-topbar__items__text">Help</span></a>
                            </li>

                        </cfoutput>

                    </cffunction>


                    <cffunction name="Chrome_Body_VIEW___ContentContainer___TopBarContainer___RightSection___Help" access="PRIVATE" returntype="void" output=true hint="">
                        <cfargument name="urlData" type="struct" required=true>

                        <cfoutput>

                            <li class="btn-topbar__items">
                                <a href="javascript:void(0)" class="js-drawer"><i class="fas fa-2x fa-comment-alt btn-topbar__items__support-icon" options="{}"></i><span class="btn-topbar__items__text">Support</span></a>
                            </li>

                        </cfoutput>

                    </cffunction>

                    <cffunction name="Chrome_Body_VIEW___ContentContainer___TopBarContainer___RightSection___EditUserLink" access="PRIVATE" returntype="void" output=true hint="">
                        <cfargument name="urlData" type="struct" required=true>

                        <cfoutput>
                                
                            <li class="btn-topbar__items">

                                <button type="Button" class="btn btn-secondary"><i class="fas fa-user">&nbsp;&nbsp;</i>#session.login.fName#&nbsp;#session.login.lName#</button>
                                <button type="button" class="btn btn-secondary dropdown-toggle dropdown-toggle-split" data-toggle='dropdown' aria-haspopup="true" aria-expanded="false">
                                    <span><i class="fas fa-chevron-down"></i></span>
                                </button>

                                <div class="dropdown-menu">
                                    <cfif structKeyExists( session, 'login' ) && lcase( session.login.userType ) EQ 'site' AND ( len( request.siteSelected ) AND isNumeric( request.siteSelected ) AND request.siteSelected GT 0 )>
                                                                                                                                                                                                                    
                                        <a href="javascript:void(0)" data-href="#APPLICATION[ 'editUserLink' ][ session.login.userType ]#" data-action='edit' data-userID="#session.login.userID#" class="js-edit-user user-edit-link dropdown-item" data-toggle="tooltip" title="This will allow you to edit your user (Note: Admin Users can only edit their users on the admin site)">
                                            Edit User
                                        </a>

                                    <cfelseif  structKeyExists( session, 'login' ) && lcase( session.login.userType ) EQ 'admin' AND session.adminPanel.user.site EQ 284 >

                                        <a href="javascript:void(0)" data-href="#APPLICATION[ 'editUserLink' ][ session.login.userType ]#" data-action='edit' data-userID="#session.login.userID#" class="js-edit-user user-edit-link dropdown-item" data-toggle="tooltip" title="This will allow you to edit your user (Note: Admin Users can only edit their users on the admin site)">
                                            Edit User
                                        </a>

                                    </cfif>

                                    <a href="#application.errorPanel.metaData.pages[ 'signout' ].href#" class="dropdown-item" data-toggle="tooltip" title="This will log you out of the application">
                                        Log out
                                    </a>
                                </div>

                            </li>

                            </span>
                                                                                                                       
                        </cfoutput>

                    </cffunction>

                    <cffunction name="Chrome_Body_VIEW___ContentContainer___TopBarContainer___RightSection___BrandNotifications" access="PRIVATE" returntype="void" output=true hint="">
                        <cfargument name="urlData"  type="struct"  required=true>

                        <cfoutput>

                            <li class="nav-item dropdown">

                                <a class="nav-link dropdown-toggle text-muted text-muted waves-effect waves-dark" href="" data-toggle="dropdown" aria-haspopup="true" aria-expanded="false"> 

                                    <i class="mdi mdi-message"></i>

                                    <div class="notify"> 

                                        <span class="heartbit"></span> 
                                        <span class="point"></span> 

                                    </div>

                                </a>

                                <div class="dropdown-menu dropdown-menu-right mailbox scale-up">

                                    <ul>

                                        <li>

                                            <div class="drop-title">Notifications</div>

                                        </li>

                                        <li>

                                            <div class="message-center">

                                                <!-- Message -->

                                                <a href="##">

                                                    <div class="btn btn-danger btn-circle">
                                                        <i class="fa fa-link"></i>
                                                    </div>

                                                    <div class="mail-contnet">
                                                        <h5>Luanch Admin</h5> 
                                                        <span class="mail-desc">Just see the my new admin!</span> 
                                                        <span class="time">9:30 AM</span>
                                                    </div>

                                                </a>

                                            </div>

                                        </li>

                                        <li>

                                            <a class="nav-link text-center" href="javascript:void(0);"> 
                                                <strong>Check all notifications</strong> 
                                                <i class="fa fa-angle-right"></i> 
                                            </a>

                                        </li>

                                    </ul>

                                </div>

                            </li>

                        </cfoutput>

                    </cffunction>

                    <cffunction name="Chrome_Body_VIEW___ContentContainer___TopBarContainer___RightSection___WishlistNotifications" access="PRIVATE" returntype="void" output=true hint="">
                        <cfargument name="urlData"  type="struct"  required=true>

                        <cfoutput>

                            <li class="nav-item dropdown">

                                <a class="nav-link dropdown-toggle text-muted waves-effect waves-dark" href="" id="2" data-toggle="dropdown" aria-haspopup="true" aria-expanded="false">
                                    <i class="mdi mdi-email"></i>
                                    <div class="notify">
                                         <span class="heartbit"></span> <span class="point"></span> 
                                    </div>
                                </a>

                                <div class="dropdown-menu mailbox dropdown-menu-right scale-up" aria-labelledby="2">

                                    <ul>

                                        <li>
                                            <div class="drop-title">You have 4 new whislist requests!</div>
                                        </li>

                                        <li>

                                            <div class="message-center">

                                                <!-- Message -->
                                                <a href="##">
                                                    
                                                    <div class="user-img"> 
                                                        <img src="/templates/vendors/material-pro/assets/images/users/1.jpg" alt="user" class="img-circle"> 
                                                        <span class="profile-status online pull-right"></span> 
                                                    </div>

                                                    <div class="mail-contnet">
                                                        <h5>Pavan kumar</h5> 
                                                        <span class="mail-desc">Just see the my admin!</span> 
                                                        <span class="time">9:30 AM</span> 
                                                    </div>

                                                </a>

                                            </div>

                                        </li>

                                        <li>

                                            <a class="nav-link text-center" href="javascript:void(0);"> 
                                                <strong>See all e-Mails</strong> 
                                                <i class="fa fa-angle-right"></i> 
                                            </a>

                                        </li>

                                    </ul>

                                </div>

                            </li>            

                        </cfoutput>
                        
                    </cffunction>


                    <cffunction name="Chrome_Body_VIEW___ContentContainer___TopBarContainer___RightSection___Flags" access="PRIVATE" returntype="void" output=true hint="">
                        <cfargument name="urlData"  type="struct"  required=true>

                        <li class="nav-item dropdown">

                            <a class="nav-link dropdown-toggle text-muted waves-effect waves-dark" href=""  data-toggle="dropdown"   aria-haspopup="true" aria-expanded="false"> 
                                <i class="flag-icon flag-icon-us"></i>
                            </a>

                            <div class="dropdown-menu dropdown-menu-right scale-up"> 

                                <a class="dropdown-item" href="##">
                                    <i class="flag-icon flag-icon-in"></i> 
                                    India
                                </a> 

                                <a class="dropdown-item" href="##">
                                    <i class="flag-icon flag-icon-fr"></i> 
                                    French
                                </a> 

                                <a class="dropdown-item" href="##">
                                    <i class="flag-icon flag-icon-cn"></i> 
                                    China
                                </a> 

                                <a class="dropdown-item" href="##">
                                    <i class="flag-icon flag-icon-de"></i> 
                                    Dutch
                                </a> 
                        
                            </div>

                        </li>

                    </cffunction>


                <!--- Top Bar Section --->

                <!--- Side Bar Section --->
                    
                    <cffunction name="Chrome_Body_VIEW___ContentContainer___SideBarContainer" access="PRIVATE" returntype="void" output=true hint="">
                        <cfargument name="urlData"          type="struct"   required=true>
                        <cfargument name="navigationData"   type="struct"   required=true>

                        <cfoutput>

                            <aside class="left-sidebar">
                                
                                <div class="scroll-sidebar">
                                    
                                    <!--- <cfset variables.Chrome_Body_VIEW___ContentContainer___SideBarContainer___SiteSelector( urlData )> --->

                                    <cfset variables.Chrome_Body_VIEW___ContentContainer___SideBarContainer___Navigation( urlData, navigationData )>                                    

                                </div>
                 
                                <cfset variables.Chrome_Body_VIEW___ContentContainer___SideBarContainer___Footer( urlData )>

                            </aside>

                        </cfoutput>
   
                    </cffunction>


                    <cffunction name="Chrome_Body_VIEW___ContentContainer___SideBarContainer___SiteSelector" access="PRIVATE" returntype="void" output=true hint="">
                        <cfargument name="urlData" type="struct" required=true>

                        <cfoutput>

                            <cfif session.adminPanel.user.ownedSites LTE 1 >

                                <cfset variables.Chrome_Body_VIEW___ContentContainer___SideBarContainer___SiteSelector___SingleSiteOwner( urlData )>

                            <cfelse>

                                <cfset variables.Chrome_Body_VIEW___ContentContainer___SideBarContainer___SiteSelector___MultipleSiteOwner( urlData )>

                            </cfif>                        

                        </cfoutput>

                    </cffunction>

                    <cffunction name="Chrome_Body_VIEW___ContentContainer___SideBarContainer___SiteSelector___SingleSiteOwner" access="PRIVATE" returntype="void" output=true hint="">
                        <cfargument name="urlData" type="struct" required=true>

                        <cfoutput>

                            <div class="user-profile">

                                <div class="profile-text">

                                    <cfif !session.adminPanel.user.ownedSites>

                                        <div class="user-profile__sitename">
                                            Please select a site from the right.
                                        </div>

                                    <cfelse>

                                        <div class="user-profile__sitename">
                                            #session.adminPanel.user.siteName#
                                        </div>

                                    </cfif>

                                </div>

                            </div>

                        </cfoutput>

                    </cffunction>

                    <cffunction name="Chrome_Body_VIEW___ContentContainer___SideBarContainer___SiteSelector___MultipleSiteOwner" access="PRIVATE" returntype="void" output=true hint="">
                        <cfargument name="urlData" type="struct" required=true>

                        <cfoutput>

                            <div class="user-profile">

                                <div class="profile-text">

                                    <div class="user-profile__sitename">
                                        <button class="btn btn-primary btn-site-selection btn-no-radius js-rsb-selectSites" type="button">#session.adminPanel.user.siteName#</button>
                                    </div>

                                </div>

                            </div>

                        </cfoutput>

                    </cffunction>


                    <cffunction name="Chrome_Body_VIEW___ContentContainer___SideBarContainer___Navigation" access="PRIVATE" returntype="void" output=true>
                        <cfargument name="urlData"              type="struct"   required=true>
                        <cfargument name="navigationData"       type="struct"   required=true>

                        <cfoutput>

                            <nav class="sidebar-nav">
                                
                                <ul id="sidebarnav">

                                    <!--- TODO: Redo nav logic and review the shape of the pages substruct. it should be an array --->

                                    <cfif isNumeric( request.siteSelected ) && request.siteSelected>

                                        <cfloop collection='#navigationData#' item='key'>

                                            <cfif navigationData[ key ][ 'inNav' ] && isStruct( navigationData[ key ] ) && !listFind( 'inNav,ishref,dir,navBarIcon', key ) >

                                                <li>

                                                    <a class="has-arrow waves-effect waves-dark" href="##" aria-expanded="false">

                                                        <i class="#navigationData[ key ][ 'navBarIcon' ]#"></i>
                                                        <span class="hide-menu">#key#</span>
            
                                                    </a>

                                                    <cfloop collection='#navigationData[ key ]#' item='pages'>

                                                        <cfif isStruct( navigationData[ key ][ pages ] ) && navigationData[ key ][ pages ][ 'inNav' ] && navigationData[ key ][ pages ][ 'atRoot' ] && structKeyExists( SESSION, 'login' ) && ( SESSION[ 'login' ][ 'securityLevel' ] GTE navigationData[ key ][ pages ][ 'security' ] ) && ( arrayFind( navigationData[ key ][ pages ][ 'allowedSites' ], 0 ) || arrayFind( navigationData[ key ][ pages ][ 'allowedSites' ], SESSION.adminPanel.user.site ) ) >
        
                                                            <ul aria-expanded="false" class="collapse">
        
                                                                <li><a href="#navigationData[ key ][ pages ][ 'href' ]#">#navigationData[ key ][ pages ][ 'title' ]#</a></li> 
                    
                                                            </ul>
        
                                                        </cfif>
        
                                                    </cfloop>

                                                </li>

                                            </cfif>

                                        </cfloop>

                                    </cfif>

                                </ul>

                            </nav>

                        </cfoutput>

                    </cffunction>


                    <cffunction name="Chrome_Body_VIEW___ContentContainer___SideBarContainer___Footer" access="PRIVATE" returntype="void" output=true>
                        <cfargument name="urlData" type="struct" required=true>

                        <cfoutput>

                            <div class="sidebar-footer">
                                <button class="btn btn-theme js-rsb-selectSites" type="button">
                                    <span>Switch Sites </span>
                                    <i class="fas fa-sync"></i>
                                </button>
                            </div>

                        </cfoutput>

                    </cffunction>

                <!--- Side Bar Section --->

                <!--- Breadcrumb Section --->

                    <cffunction name="Chrome_Body_VIEW___ContentContainer___BreadcrumbGenerator" access="PRIVATE" returntype="void" hint="">
                        <cfargument name="urlData"              type="struct"   required=true>
                        <cfargument name="breadCrumbData"       type="struct"   required=true>
                        <cfargument name="resultStruct"         type="struct"   required=true>

                        <cfoutput>

                            <cfif isNumeric( request.siteSelected ) && request.siteSelected>

                                <div class="row page-titles">

                                    <div class="col-md-5 col-8 align-self-center page-info">

                                        <h3 class="text-themecolor">Dashboard</h3>

                                        <ol class="breadcrumb">
                                            <li class="breadcrumb-item"><a href="javascript:void(0)">Home</a></li>
                                            <li class="breadcrumb-item active">Dashboard</li>
                                        </ol>

                                    </div>

                                    <cfset variables.Chrome_Body_VIEW___ContentContainer___BreadcrumbGenerator___AtAGalanceInformation( urlData, breadCrumbData, resultStruct )>

                                </div> 

                            </cfif>

                        </cfoutput>

                    </cffunction>

                    <cffunction name="Chrome_Body_VIEW___ContentContainer___BreadcrumbGenerator___AtAGalanceInformation" access="PRIVATE" returntype="void" hint="">
                        <cfargument name="urlData"              type="struct" required=true>
                        <cfargument name="breadCrumbData"       type="struct" required=true>
                        <cfargument name="resultStruct"         type="struct" required=true>

                        <cfoutput>

                            <div class="col-md-7 col-4 align-self-center">

                                <div class="d-flex m-t-10 justify-content-end">

                                    <div class="d-flex m-r-20 m-l-10 hidden-md-down">

                                        <div class="products-meter">
                                            <div class="products-meter__image"></div>
                                        </div>

                                        <div class="chart-text m-r-10">
                                            <h6 class="m-b-0"><small>PRODUCTS PUBLISHED</small></h6>
                                            <h4 id="productsCount" class="m-t-0 counter" data-count="#trim(resultStruct.productsPublished.result.solrCount)#">0</h4>
                                        </div>

                                    </div>

                                    <cfif resultStruct.exchangeRate.result.exRateUSDCAD != ''>

                                        <div class="d-flex m-r-20 m-l-10 hidden-md-down">

                                            <div class="exchange-rate">
                                                <i class="exchange-rate__usd fas fa-dollar-sign"></i>
                                            </div>

                                                <div class="chart-text m-r-10">
                                                    <h6 class="m-b-0"><small>EXCHANGE RATE</small></h6>
                                                    <h4 class="m-t-0 conversion-rate">1 USD = #resultStruct.exchangeRate.result.exRateUSDCAD# CAD</h4>
                                                </div>

                                        </div>

                                    </cfif>

                                    <!--- Button to enable right sidebar, disabled for now 
                                        <div class="">
                                            <button class="right-side-toggle waves-effect waves-light btn-success btn btn-circle btn-sm pull-right m-l-10"><i
                                                    class="ti-settings text-white"></i></button>
                                        </div>
                                    --->

                                </div>

                            </div>

                        </cfoutput>

                    </cffunction>

                <!--- Breadcrumb Section --->

                <!--- Page Content Section --->

                    <cffunction name="Chrome_Body_VIEW___ContentContainer___MessageNotification" access="PRIVATE" returntype="void" output=true hint="">
                        <cfargument name="urlData" type="struct" required=true>

                        <cfoutput>

                            <div class="col-xl-12 col-lg-12 col-md-12 col-xs-12">

                                <div class="alert alert-info">

                                    <button type="button" class="close" data-dismiss='alert' arai-label='Close'>
                                        <span aria-hidden=true><i class="far fa-window-close"></i></span>
                                    </button>

                                    <h3 class="">
                                        <i class="fa fa-exclamation-circle">

                                        </i>
                                        Information
                                    </h3>
                                    
                                    <span>There are 4 message to view from Bravo Business Media - <a href="javasript:void(0)" class="js-close" options="{}">VIEW ALL</a></span>

                                </div>

                            </div>

                        </cfoutput>

                    </cffunction>

                    <cffunction name="Chrome_Body_VIEW___ContentContainer___DisplayPage" access="PRIVATE" returntype="void" output=true hint="">
                        <cfargument name="urlData"      type="struct"   required=true>
                        <cfargument name="htmlBlob"     type="string"   required=true>

                        <cfoutput>

                            #htmlBlob#

                        </cfoutput>

                    </cffunction>

                <!--- Page Content Section --->

                <!--- Right Bar Section --->

                    <cffunction name="Chrome_Body_VIEW___ContentContainer___RightSidebar" access="PRIVATE" returntype="void" output=true hint="">
                        <cfargument name="urlData"          type="struct"   required=true>
                        <cfargument name="htmlBlob"         type="string"   required=false default="">
                        <cfargument name="queryData"        type="query"    required=false default=#queryNew( '' )#>
                        <cfargument name="useDataTables"    type="boolean"  required=false default=false>
                        <cfargument name="debug"            type="boolean"  required=false default=false>

                        <!--- 
                            NOTE: This function is meant to be used dynamically to load content into the view based on contextual actions.
                        --->

                        <cfoutput>

                            <div id="right-hand-sidebar" class="right-sidebar" style="background: ##eaeaea;">

                                <div class="slimscrollright">

                                    <cfif htmlBlob != ''>

                                        #htmlBlob#

                                    </cfif>

                                </div>

                                <cfset variables.Chrome_Body_VIEW___ContentContainer___RightSidebar___IncludeJavascript( urlData, useDataTables )>

                            </div>

                        </cfoutput>

                    </cffunction>

                    <cffunction name="Chrome_Body_VIEW___ContentContainer___RightSidebar___IncludeJavascript" access="PRIVATE" returntype="void" output=true hint="">
                        <cfargument name="urlData"          type="struct"       required=true>
                        <cfargument name="useDataTables"    type="boolean"      required=true>

                        <cfoutput>

                        
                            <script>

                                if( #useDataTables# ){

                                    $( document ).ready( function () {
                   
                                        $( '.dataTable' ).each( function(){

                                          if ( !$.fn.DataTable.isDataTable( '##' + $( this ).attr( 'id' ) ) ) {
                                                
                                                var json = #APPLICATION[ 'DataTables' ]#;
                                                var dataTable = ( ( typeof json[ $( this ).attr( 'id' ).toLowerCase() ] !== 'undefined' ) ? json[ $( this ).attr( 'id' ) ] : json[ 'default' ] );

                                                $( '##' + $(this).attr( 'id' ) ).DataTable(dataTable);

                                            }
                                        });

                                    });
                                
                                }

                            </script>
                            

                        </cfoutput>

                    </cffunction>

                <!--- Right Bar Section --->

                <!--- Footer Section --->

                    <cffunction name="Chrome_Body_VIEW___ContentContainer___FooterContainer" access="PRIVATE" returntype="void" output=true>
                        <cfargument name="urlData" type="struct" required=true>

                        <cfoutput>

                            <footer class="footer">


                            </footer>

                        </cfoutput>

                    </cffunction>

                <!--- Footer Section --->

                <!--- Javascript --->

                    <cffunction name="Chrome_Body_VIEW___IncludeJavascript" access="PRIVATE" returntype="void" output=true hint="">
                        <cfargument name="urlData" type="struct" required=true>

                        <cfoutput>
                            
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
                            <!--- bootstrap toggle --->
                            <script src="https://gitcdn.github.io/bootstrap-toggle/2.2.2/js/bootstrap-toggle.min.js"></script>
                            <!--- bootstrap dropdown --->
                            <script src="#application[ 'errorPanel' ][ 'Theme' ][ 'Material' ][ 'Assets' ]#plugins/bootstrap-select/bootstrap-select.min.js"></script>
                            <!--- Dropify --->
                            <script src="#application[ 'errorPanel' ][ 'Theme' ][ 'Material' ][ 'Assets' ]#plugins/dropify/dist/js/dropify.min.js"></script>

                            <!--- toastr --->
                            <script src="//cdnjs.cloudflare.com/ajax/libs/toastr.js/latest/toastr.min.js"></script>
                            <script src="#application[ 'errorPanel' ][ 'Theme' ][ 'Material' ][ 'Assets' ]#plugins/toast-master/js/jquery.toast.js"></script>

                            <!--- sparkline --->
                            <script src="#application[ 'errorPanel' ][ 'Theme' ][ 'Material' ][ 'Assets' ]#plugins/sparkline/jquery.charts-sparkline.js"></script>
                            <script src="#application[ 'errorPanel' ][ 'Theme' ][ 'Material' ][ 'Assets' ]#plugins/sparkline/jquery.sparkline.min.js"></script>

                            <!--Custom JavaScript -->
                            <script src="#application[ 'errorPanel' ][ 'Theme' ][ 'Material' ][ 'JS' ]#custom.min.js"></script>


                            <script src="/js/script.js"></script>



                            <script>

                                if(  #BooleanFormat( structKeyExists( urlData, 'forceSiteSelection' ) && urlData.forceSiteSelection )# ){

                                    $( document ).ready( function(){

                                        $( '.right-sidebar' ).slideDown( 50 );
                                        $( '.right-sidebar' ).toggleClass( 'shw-rside' );

                                    } );

                                }

                            </script>

                        </cfoutput>

                    </cffunction>

                <!--- Javascript --->

            <!---   **********************************************************************  --->
            <!---   **********************************************************************  --->

        <!--- Body Related Functions - END --->


    <!---   **********************************************************************  --->
    <!---   *  Common Chrome Views - END                                            --->
    <!---   **********************************************************************  --->

</cfcomponent>