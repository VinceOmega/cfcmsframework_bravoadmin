<cfcomponent displayName="LoginView" output=true hint="">


    <!---   **********************************************************************  --->
    <!---   *  Login Body Views - START                                             --->
    <!---   **********************************************************************  --->


            <!---   **********************************************************************  --->
            <!---   **********************************************************************  --->

            
                <!--- MAIN FUNCTIONS --->


                <cffunction name="Login_Body_VIEW" access="PUBLIC" returntype="void" output=true hint="">
                    <cfargument name="urlData"     type="struct" required=true>
                    <cfargument name="htmlBlob"    type="string" required=true>

                    <cfoutput>

                        <body>

                            <cfset VARIABLES.Login_Body_VIEW___PreLoader( urlData )>

                            <cfset invoke( VARIABLES, 'Login_Body_VIEW___' & APPLICATION[ 'adminPanel' ][ 'loginLayout' ], { urlData = urlData, htmlBlob = htmlBlob } )>

                            <cfset VARIABLES.Login_Body_VIEW___IncludeJavascript( urlData )>

                        </body>

                    </cfoutput>

                </cffunction>


                <!---   **********************************************************************  --->


                <!--- HELPER FUNCTIONS --->

                <cffunction name="Login_Body_VIEW___Preloader" access="PRIVATE" returntype="void" output=true hint="">
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

                
                <cffunction name="Login_Body_VIEW___LeftSideBar" access="PRIVATE" returntype="void" output=true hint="">
                    <cfargument name="urlData"      type="struct"   required=true>
                    <cfargument name="htmlBlob"     type="string"   required=true>
        
                    <cfoutput>
                        
                        <section id="wrapper" class="login-register login-sidebar" style="#( ( ( structKeyExists( URL, 'debug' ) && isBoolean( URL[ 'debug' ] ) && URL[ 'debug' ] ) ) ? 'none' : 'background-image:url(' & APPLICATION[ 'adminPanel' ][ 'loginPageConfig' ][ 'photoCycle' ][ randRange( 1, arrayLen( APPLICATION[ 'adminPanel' ][ 'loginPageConfig' ][ 'photoCycle' ] ) ) ] & ')' )#">
                            <div class="login-box card card-transparent-white login-box--reverse">
                                <div class="card-body">
                                    
                                    <cfset VARIABLES.Login_Body_VIEW___LeftSideBar___SideBar( urlData )>

                                </div>
                            </div>

                            <div class="card card-transparent-white <cfif urlData.page == 'signout' >card-fill-screen</cfif>">
                                <cfset VARIABLES.Login_Body_VIEW___LeftSideBar___ContentContainer( urlData, htmlBlob )>
                            </div>

                        </section>
        
                    </cfoutput>
        
                </cffunction>


                <cffunction name="Login_Body_VIEW___LeftSideBar___SideBar" access="PRIVATE" returntype="void" output=true hint="">
                    <cfargument name="urlData"      type="struct"   required=true>

                    <cfoutput>

                        <form class="form-horizontal form-material" id="loginform" action="/login/login/signin" method='POST'>

                            <!--- --->
                            <cfset application.adminPanel.components.utility.htmlelements.HTMLELEMENTS_FormHiddenFieldsInvokeProcessAndEnableAjax_RENDER( 'Login_Signin_PROCESS', false )>

                            <a href="https://www.bravobusinessmedia.com/" class="text-center db"><img src="/img/common/bravo_logo.png" alt="Bravo Business Media Logo" class="login-box__logo"/><br/><span class="login-box__logo-subtext --bravo-dark-blue-text">Admin Panel</span></a>
                            
                            <div class="form-group m-t-40">
                                <div class="col-xs-12">
                                    <input class="form-control" name="email" type="text" required="" placeholder="Username">
                                </div>
                            </div>
                            <div class="form-group">
                                <div class="col-xs-12">
                                    <input class="form-control" name="password" type="password" required="" placeholder="Password">
                                </div>
                            </div>
                            <div class="form-group">
                                <div class="d-flex no-block align-items-center">
                                    <div class="checkbox checkbox-primary p-t-0">
                                        <input id="checkbox-signup" type="checkbox">
                                        <label for="checkbox-signup"> Remember me </label>
                                    </div>
                                    <div class="ml-auto">
                                        <a href="javascript:void(0)" id="to-recover" class="text-muted"><i class="fa fa-lock m-r-5"></i> Forgot pwd?</a> 
                                    </div>
                                </div>
                            </div>
                            <div class="form-group text-center m-t-20">
                                <div class="col-xs-12">
                                    <button class="btn btn-theme btn-lg btn-block text-uppercase waves-effect waves-light" type="submit">Log In</button>
                                </div>
                            </div>

                        </form>

                    </cfoutput>

                </cffunction>


                <cffunction name="Login_Body_VIEW___LeftSideBar___ContentContainer" access="PRIVATE" returntype="void" output=true hint="">
                    <cfargument name="urlData"      type="struct"   required=true>
                    <cfargument name="htmlBlob"     type="string"   required=true>

                    <cfoutput>

                        #htmlBlob#

                    </cfoutput>

                </cffunction>


                <cffunction name="Login_Body_VIEW___LeftSideBar___SideBar___SocialButtons" access="PRIVATE" returntype="void" output=true hint="">
                    <cfargument name="urlData"      type="struct"   required=true>
                    <cfargument name="htmlBlob"     type="string"   required=true>

                    <cfoutput>

                        <div class="row">
                            <div class="col-xs-12 col-sm-12 col-md-12 m-t-10 text-center">
                                <div class="social">
                                    <button class="btn btn-facebook" data-toggle="tooltip" title="Login with Facebook"> <i aria-hidden="true" class="fab fa-facebook-f"></i> </button>
                                    <button class="btn btn-googleplus" data-toggle="tooltip" title="Login with Google"> <i aria-hidden="true" class="fab fa-google-plus-g"></i> </button>
                                </div>
                            </div>
                        </div>

                    </cfoutput>

                </cffunction>


                <cffunction name="Login_Body_VIEW___IncludeJavascript" access="PRIVATE" returntype="void" output=true hint="">
                    <cfargument name="urlData"  type="struct"   required=true>

                    <cfoutput>
                            
                        <!-- Bootstrap tether Core JavaScript -->
                        <script src="#APPLICATION[ 'adminPanel' ][ 'Theme' ][ 'Material' ][ 'Assets' ]#plugins/popper/popper.min.js"></script>
                        <script src="#APPLICATION[ 'adminPanel' ][ 'Theme' ][ 'Material' ][ 'Assets' ]#plugins/bootstrap/js/bootstrap.min.js"></script>
                        <!-- slimscrollbar scrollbar JavaScript -->
                        <script src="#APPLICATION[ 'adminPanel' ][ 'Theme' ][ 'Material' ][ 'JS' ]#jquery.slimscroll.js"></script>
                        <!--Wave Effects -->
                        <script src="#APPLICATION[ 'adminPanel' ][ 'Theme' ][ 'Material' ][ 'JS' ]#"></script>
                        <!--Menu sidebar -->
                        <script src="#APPLICATION[ 'adminPanel' ][ 'Theme' ][ 'Material' ][ 'JS' ]#sidebarmenu.js"></script>
                        <!--stickey kit -->
                        <script src="#APPLICATION[ 'adminPanel' ][ 'Theme' ][ 'Material' ][ 'Assets' ]#plugins/sticky-kit-master/dist/sticky-kit.min.js"></script>
                        <script src="#APPLICATION[ 'adminPanel' ][ 'Theme' ][ 'Material' ][ 'Assets' ]#plugins/sparkline/jquery.sparkline.min.js"></script>
                        <!--Custom JavaScript -->
                        <script src="#APPLICATION[ 'adminPanel' ][ 'Theme' ][ 'Material' ][ 'JS' ]#custom.min.js"></script>
                        <!-- ============================================================== -->
                        <!-- Style switcher -->
                        <!-- ============================================================== -->
                        <script src="#APPLICATION[ 'adminPanel' ][ 'Theme' ][ 'Material' ][ 'Assets' ]#plugins/styleswitcher/jQuery.style.switcher.js"></script>

                    </cfoutput>

                </cffunction>


        <!---   **********************************************************************  --->
        <!---   **********************************************************************  --->


    <!---   **********************************************************************  --->
    <!---   *  Login Body Views - END                                               --->
    <!---   **********************************************************************  --->


    <!---   **********************************************************************  --->
    <!---   *  Signin Page Views - START                                            --->
    <!---   **********************************************************************  --->


        <cffunction name="Login_Signin_VIEW" access="PUBLIC" returntype="void" output=true hint="">
            <cfargument name="urlData"      type="struct" required=true>

            <cfoutput>

                <!--- No content --->

            </cfoutput>

        </cffunction>


    <!---   **********************************************************************  --->
    <!---   *  Signin Page Views - END                                              --->
    <!---   **********************************************************************  --->


    <!---   **********************************************************************  --->
    <!---   * Signout Page Views - START                                            --->
    <!---   **********************************************************************  --->

        <cffunction name="Login_Signout_VIEW" access="PUBLIC" returntype="void" output=true hint="">
            <cfargument name="urlData"      type="struct"   required=true>

            <cfoutput>

                <div id="logout-message-container" class="logout-message-container">

                    <div class="logout-message-container__inner-container">

                        <form name="logout_form" method="post" action="#application.adminPanel.metaData.pages[ urlData.page ].href#" enctype="multipart/form-data">
                            
                            <div class="logout-message-container__inner-container__wrapper">

                                <cfset application.adminPanel.components.utility.htmlElements.HTMLELEMENTS_FormHiddenFieldsInvokeProcessAndEnableAjax_RENDER( 'Login_Signout_PROCESS' )>

                                <p class="logout-message-container___inner-container___wrapper__logout-message" > Are you sure you want to log out? </p> 

                                <fieldset class="logout-message-container__inner-container__wrapper__buttons-fieldset">

                                    <input type="submit" value="Yes" name="logout" class="btn btn-theme"/> <a href="<cfif len( session.adminPanel.user.lastVisited ) >#session.adminPanel.user.lastVisited#<cfelseif len(cgi.HTTP_REFERER)>#cgi.HTTP_REFERER#<cfelse>#application.adminPanel.components.utility.strings.Strings_GeneratePageHref_TASK( 'signin' )#</cfif>" alt="Go Back" class="btn btn-theme">No</a>

                                </fieldset>

                            </div>

                        </form>


                    </div>

                </div>
 
                <cfset variables.Login_Signout_VIEW___IncludeJavascript( urlData )>

            </cfoutput>

        </cffunction>

        <cffunction name="Login_Signout_VIEW___IncludeJavascript" access="PRIVATE" retuntype="void" ouptput=true hint="">
            <cfargument name="urlData"      type="struct"   required=true>

            <cfoutput>

                <script>

                    /*
                    $( document ).ready(function(){

                        $.ajax({
                            type: "post",
                            url: #application.adminPanel.components.utility.strings.Strings_GeneratePageHref_TASK( 'signout' )#,
                            data: {
                                ajax: true,
                                procesInvoke: 'Login_Signout_PROCESS',
                                userID: #session.login.userID#,
                                logoutTS: #now()#
                            },
                            dataType: "json",
                            success: function (response) {
                                
                            }
                        });

                    });
                    */

                </script>

            </cfoutput>

        </cffunction>


    <!---   **********************************************************************  --->
    <!---   * Signout Page END - END                                                --->
    <!---   **********************************************************************  --->
    

</cfcomponent>