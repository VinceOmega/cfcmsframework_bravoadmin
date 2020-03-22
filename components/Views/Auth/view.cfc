<cfcomponent displayName="AuthView" output=true>

    <!---   **********************************************************************  --->
    <!---   *  Auth Login - START                                                   --->
    <!---   **********************************************************************  --->


        <cffunction name="Auth_Login_VIEW" access="PUBLIC" returntype="void" output=true hint="">
            <cfargument name="urlData"      type="struct"   required=true>
            <cfargument name="viewSuffix"   type="string"   required=true>

            <cfoutput>

                <cfset invoke( VARIABLES, 'Auth_Login_VIEW___' & viewSuffix, { urlData = urlData } )>

            </cfoutput>

        </cffunction>

        <cffunction name="Auth_Login_VIEW___InactiveSession" access="PRIVATE" returntype="void" output=true hint="">
            <cfargument name="urlData"      type="struct"   required=true>

            <cfoutput>

                <!--- Nothing, bascially this becomes the login screen if you visit it directly --->

            </cfoutput>

        </cffunction>

        <cffunction name="Auth_Login_VIEW___ActiveSession"  access="PRIVATE" returntype="void" output=true hint="">
            <cfargument name="urlData"      type="struct"   required=true>

            <cfoutput>

                <div class="card-page card-dashboard-analytics card-outline-info">

                    <div class="card-header">

                        <h4 class="m-b-0t text-white">#application.adminPanel.metaData.navigation[ urlData[ 'route' ] ][ urlData[ 'page' ] ].title#</h4>

                    </div>

                    <div class="card-body"> 
                        
                        This page is used for authenicating into the control panel remotely.
            
                    </div>

                </div>  

            </cfoutput>


        </cffunction>


    <!---   **********************************************************************  --->
    <!---   *  Auth Login - END                                                     --->
    <!---   **********************************************************************  --->

</cfcomponent>