<cfcomponent displayName="UsersView" output=true hint="">

    <!---   **********************************************************************  --->
    <!---   *  Users Listing - START                                                --->
    <!---   **********************************************************************  --->


        <cffunction name="Users_Listing_VIEW" access="PUBLIC" output=true hint="">
            <cfargument name="urlData"      type="struct"   required=true>
            <cfargument name="debug"        type="boolean"  required=true>
            <cfargument name="userData"     type="query"    required=true>

            <cfoutput>

                <div class="card-page card-dashboard-analytics card-outline-info">

                    <div class="card-header">
                        <h4 class="m-b-0t ">#application.adminPanel.metaData.pages[ urlData[ 'page' ] ].title#</h4>
                        <button class="btn btn-theme js-user-customer-new waves-effect waves-light m-r-10"    data-action="new"           type="button">Create User <i class="fa fa-user-plus" aria-hidden="true"></i></button>
                        <button class="btn btn-theme js-export-users waves-effect waves-light m-r-10"         data-action="exportUser"    userType='User' data-href='#application.adminPanel.components.utility.strings.Strings_GeneratePageHref_TASK( 'userExport' )#' type="button">Export Users <i class="fas fa-save" aria-hidden="true"></i></button>
                    </div>

                    <div class="card-prompt" >
                        <div class="card-prompt__holder">
                            <form id="checkEmail" name="checkEmail" method="post" action="/adminpanel/users/checkEmail" _lpchecked="1" class="form-material m-t-40">
                                <cfset application.adminPanel.components.utility.htmlElements.HTMLELEMENTS_FormHiddenFieldsInvokeProcessAndEnableAjax_RENDER( 'Users_Check_PROCESS', false )>
                                <input type="hidden"    name="userType"             value="User">
                                <input type="hidden"    name="formInvokeMethod"     value="Users_Create_PROCESS">
                                <input type="hidden"    name="page"                 value="create">
                                <div class="form-group card-prompt__holder__form-group">
                                    <input type="email" value="" placeholder="my@email.com" name="email" class="form-control">
                                    <button type="submit" data-onConfirm="#application.adminPanel.components.utility.strings.Strings_GeneratePageHref_TASK( 'userGetInfo' )#" data-href="#application.adminPanel.components.utility.strings.Strings_GeneratePageHref_TASK( 'userCreate' )#" class="btn btn-theme waves-effect waves-light m-r-10">Check</button>
                                </div>
                            </form>
                        </div>
                    </div>

                    <div class="card-body">
                        <table id="DTUsers" class="display compact dataTable" cellspacing="0" width="100%">
                            <thead>
                                <tr>
                                    <th>Last Login</th>
                                    <th>Name</th>
                                    <th>Email</th>
                                    <th>Phone</th>
                                    <th>Status</th>
                                    <th>Actions</th>
                                </tr>
                            </thead>
                            
                            <tbody>

                                <cfloop query="userData">
                                    <tr>

                                        <td class="dataTable___lastLogin" title="Number of logins: #loginCount#" data-toggle="tooltip" >
                                            #dateFormat( lastLogin, 'mm-dd-yyyy')#  #timeFormat( lastLogin, 'hh:mm')#
                                       </td>
                                        <td class="dataTable___Name" >
                                            #fname# #lname#
                                        </td>
                                        <td class="dataTable___Email" title="#email#">#email#</td>
                                        <td class="dataTable___phoneType1" title="#phoneType1#">#phone1#</td>
                                        <td class="dataTable___activeStatus" title="#active#"><i class="fas <cfif active > fa-user green-darker-10 <cfelse> fa-user-slash red </cfif>"/></td>
                                        <td class="dataTable___Actions">
                                            <a href="##" data-userID="#userID#" data-action="edit"      data-href="#application.adminPanel.components.utility.strings.Strings_GeneratePageHref_TASK( 'userEditing' )#" ><i class="fas fa-pencil-alt">&nbsp;&nbsp;</i></a>
                                            <a href="##" data-userID="#userID#" data-action='copy'      data-href="#application.adminPanel.components.utility.strings.Strings_GeneratePageHref_TASK( 'userCopy' )#" >   <i class="far fa-copy">&nbsp;&nbsp;</i></a>
                                            <a href="##" data-userID="#userID#" data-action='delete'    data-href="#application.adminPanel.components.utility.strings.Strings_GeneratePageHref_TASK( 'userRemove' )#" processInvoke='Users_Remove_PROCESS'> <i class="fas fa-trash-alt">&nbsp;&nbsp;</i></a>                                            
                                        </td>
                                    </tr>
                                </cfloop>

                            </tbody>

                        </table>

                    </div>

                </div>

                <cfset variables.Users_SharedIFrame_VIEW( urlData )>

                <cfset variables.Users_Listing_VIEW___IncludeJavascript( urlData )>
        
            </cfoutput>

        </cffunction>


        <cffunction name="Users_Listing_VIEW___IncludeJavascript" access="PRIVATE" output=true hint="">
            <cfargument name="urlData" type="struct" required=true>

            <cfoutput>

                <script>
    
                    $( document ).ready( function(){

                        $('##DTUsers').dataTable();

                    } );

                </script>

            </cfoutput>

        </cffunction>

    <!---   **********************************************************************  --->
    <!---   *  Users Listing - END                                                  --->
    <!---   **********************************************************************  --->

    <!---   **********************************************************************  --->
    <!---   *  Users Create - START                                                 --->
    <!---   **********************************************************************  --->

        <cffunction name="Users_Create_VIEW" access="PUBLIC" output=true hint="">
            <cfargument name="urlData"                      type="struct"   required=true>
            <cfargument name="userQuery"                    type="query"    required=true>
            <cfargument name="listOfLocationsQuery"         type="query"    required=true>
            <cfargument name="userSecurityRoleTypes"        type="query"    required=true>
            <cfargument name="entryPointQuery"              type="query"    required=true>
            <cfargument name="userSecurityRoleTypesStruct"  type="struct"   required=true>
            <cfargument name="debug"                        type="boolean"  required=false>

            <cfoutput>

                <cfset application.adminPanel.components.utility.HTMLElements.HTMLELEMENTS_UserCrudForms_RENDER( urlData, userQuery, listOfLocationsQuery, userSecurityRoleTypes, entryPointQuery, userSecurityRoleTypesStruct, 'Users_Create_PROCESS', true )>

            </cfoutput>

        </cffunction>

        <cffunction name="Users_Create_VIEW___IncludeJavascript" access="PRIVATE" output=true hint="">
            <cfargument name="urlData" type="struct" required=true>

            <cfoutput>

                <script>

                    $( document ).ready( function(){


                    } );

                </script>

            </cfoutput>

        </cffunction>

    <!---   **********************************************************************  --->
    <!---   *  Users Create - END                                                   --->
    <!---   **********************************************************************  --->

    <!---   **********************************************************************  --->
    <!---   *  Users Edit - START                                                   --->
    <!---   **********************************************************************  --->

        <cffunction name="Users_Edit_VIEW" access="PUBLIC" output=true hint="">
            <cfargument name="urlData"                      type="struct"   required=true>
            <cfargument name="userQuery"                    type="query"    required=true>
            <cfargument name="listOfLocationsQuery"         type="query"    required=true>
            <cfargument name="userSecurityRoleTypes"        type="query"    required=true>
            <cfargument name="entryPointQuery"              type="query"    required=true>
            <cfargument name="userSecurityRoleTypesStruct"  type="struct"    required=true>
            <cfargument name="debug"                        type="boolean"  required=false>

            <cfoutput>

                <cfset application.adminPanel.components.utility.HTMLElements.HTMLELEMENTS_UserCrudForms_RENDER( urlData, userQuery, listOfLocationsQuery, userSecurityRoleTypes, entryPointQuery, userSecurityRoleTypesStruct, 'Users_Edit_PROCESS', true )>

            </cfoutput>

        </cffunction>

        <cffunction name="Users_Edit_VIEW___IncludeJavascript" access="PRIVATE" output=true hint="">
            <cfargument name="urlData" type="struct" required=true>

            <cfoutput>

                <script>
    
                    $( document ).ready( function(){


                    } );

                </script>

            </cfoutput>

        </cffunction>

    <!---   **********************************************************************  --->
    <!---   *  Users Edit - END                                                     --->
    <!---   **********************************************************************  --->

    <!---   **********************************************************************  --->
    <!---   *  Users Copy - START                                                   --->
    <!---   **********************************************************************  --->

        <cffunction name="Users_Copy_VIEW" access="PUBLIC" output=true hint="">
            <cfargument name="urlData"                      type="struct"   required=true>
            <cfargument name="userQuery"                    type="query"    required=true>
            <cfargument name="listOfLocationsQuery"         type="query"    required=true>
            <cfargument name="userSecurityRoleTypes"        type="query"    required=true>
            <cfargument name="entryPointQuery"              type="query"    required=true>
            <cfargument name="userSecurityRoleTypesStruct"  type="struct"   required=true>
            <cfargument name="debug"                        type="boolean"  required=false>

            <cfoutput>

                <cfset application.adminPanel.components.utility.HTMLElements.HTMLELEMENTS_UserCrudForms_RENDER( urlData, userQuery, listOfLocationsQuery, userSecurityRoleTypes, entryPointQuery, userSecurityRoleTypesStruct, 'Users_Copy_PROCESS', true, true )>

            </cfoutput>

        </cffunction>

        <cffunction name="Users_Copy_VIEW___IncludeJavascript" access="PRIVATE" output=true hint="">
            <cfargument name="urlData" type="struct" required=true>

            <cfoutput>

                <script>

                    $( document ).ready( function(){


                    } );

                </script>

            </cfoutput>

        </cffunction>

    <!---   **********************************************************************  --->
    <!---   *  Users Copy - END                                                     --->
    <!---   **********************************************************************  --->

    <!---   **********************************************************************  --->
    <!---   *  Users Trade Profressional Listing - START                            --->
    <!---   **********************************************************************  --->

        <cffunction name="Users_Trade_Listing_VIEW" access="PUBLIC" output=true hint="">
            <cfargument name="urlData"      type="struct"   required=true>
            <cfargument name="debug"        type="boolean"  required=true>
            <cfargument name="userData"     type="query"    required=true>

            <cfoutput>

                <div class="card-page card-dashboard-analytics card-outline-info">

                    <div class="card-header">
                        <h4 class="m-b-0t ">#application.adminPanel.metaData.pages[ urlData[ 'page' ] ].title#</h4>
                        <button class="btn btn-theme js-user-customer-new waves-effect waves-light m-r-10"    data-action="new" type="button">Create User <i class="fa fa-user-plus" aria-hidden="true"></i></button>
                        <button class="btn btn-theme js-export-users waves-effect waves-light m-r-10"         data-action="exportUser" userType='Special' data-href='#application.adminPanel.components.utility.strings.Strings_GeneratePageHref_TASK( 'userExport' )#' type="button">Export Users <i class="fas fa-save" aria-hidden="true"></i></button>
                     </div>

                    <div class="card-prompt" >
                        <div class="card-prompt__holder">
                            <form id="checkEmail" name="checkEmail" method="post" action="/adminpanel/users/check" _lpchecked="1" class="form-material m-t-40">
                                <cfset application.adminPanel.components.utility.htmlElements.HTMLELEMENTS_FormHiddenFieldsInvokeProcessAndEnableAjax_RENDER( 'Users_Check_PROCESS', false )>
                                <input type="hidden"    name="userType"             value="Special">
                                <input type="hidden"    name="formInvokeMethod"     value="Users_Trade_Create_PROCESS">
                                <input type="hidden"    name="page"                 value="create">
                                <div class="form-group card-prompt__holder__form-group">
                                    <input type="email" value="" placeholder="my@email.com" name="email" class="form-control">
                                    <button type="submit" data-onConfirm="#application.adminPanel.components.utility.strings.Strings_GeneratePageHref_TASK( 'userGetInfo' )#" data-href="#application.adminPanel.components.utility.strings.Strings_GeneratePageHref_TASK( 'tradeCreate' )#" class="btn btn-theme waves-effect waves-light m-r-10">Check</button>
                                </div>
                            </form>
                        </div>
                    </div>

                    <div class="card-body">
                        <table id="DTUsers" class="display compact dataTable" cellspacing="0" width="100%">
                            <thead>
                                <tr>
                                <th>Last Login</th>
                                <th>Name</th>
                                <th>Email</th>
                                <th>Phone</th>
                                <th>Status</th>
                                <th>Actions</th>
                                </tr>
                            </thead>
                            
                            <tbody>

                                <cfloop query="userData">
                                    <tr>
                                        <td class="dataTable___lastLogin" title="Number of logins: #loginCount#" data-toggle="tooltip" >
                                            #dateFormat( lastLogin, 'mm-dd-yyyy')#  #timeFormat( lastLogin, 'hh:mm')#
                                        </td>
                                        <td class="dataTable___Name" >
                                            #fname# #lname#
                                        </td>
                                        <td class="dataTable___Email" title="#email#">#email#</td>
                                        <td class="dataTable___phoneType1" title="#phoneType1#">#phone1#</td>
                                        <td class="dataTable___activeStatus" title="#active#"><i class="fas <cfif active > fa-user green-darker-10 <cfelse> fa-user-slash red </cfif>"/></td>
                                        <td class="dataTable___Actions">
                                            <a href="##" data-userID="#userID#" data-action="edit"      data-href="#application.adminPanel.components.utility.strings.Strings_GeneratePageHref_TASK( 'tradeEditing' )#" ><i class="fas fa-pencil-alt">&nbsp;&nbsp;</i></a>
                                            <a href="##" data-userID="#userID#" data-action='copy'      data-href="#application.adminPanel.components.utility.strings.Strings_GeneratePageHref_TASK( 'tradeCopy' )#" >   <i class="far fa-copy">&nbsp;&nbsp;</i></a>
                                            <a href="##" data-userID="#userID#" data-action='delete'    data-href="#application.adminPanel.components.utility.strings.Strings_GeneratePageHref_TASK( 'tradeRemove' )#" processInvoke='Users_Trade_Remove_PROCESS'> <i class="fas fa-trash-alt">&nbsp;&nbsp;</i></a>                                                
                                        </td>
                                    </tr>
                                </cfloop>

                            </tbody>

                        </table>

                    </div>

                </div>

                <cfset variables.Users_SharedIFrame_VIEW( urlData )>

                <cfset variables.Users_Trade_Listing_VIEW___IncludeJavascript( urlData )>
        
            </cfoutput>

        </cffunction>


        <cffunction name="Users_Trade_Listing_VIEW___IncludeJavascript" access="PRIVATE" output=true hint="">
            <cfargument name="urlData" type="struct" required=true>

            <cfoutput>

                <script>

                    $( document ).ready( function(){

                        $('##DTUsers').dataTable();

                    } );

                </script>

            </cfoutput>

        </cffunction>

    <!---   **********************************************************************  --->
    <!---   *  Users Trade Profressional Listing - END                              --->
    <!---   **********************************************************************  --->

    <!---   **********************************************************************  --->
    <!---   *  Users Trade Profressional Create - START                             --->
    <!---   **********************************************************************  --->

        <cffunction name="Users_Trade_Create_VIEW" access="PUBLIC" output=true hint="">
            <cfargument name="urlData"                      type="struct"   required=true>
            <cfargument name="userQuery"                    type="query"    required=true>
            <cfargument name="listOfLocationsQuery"         type="query"    required=true>
            <cfargument name="userSecurityRoleTypes"        type="query"    required=true>
            <cfargument name="entryPointQuery"              type="query"    required=true>
            <cfargument name="userSecurityRoleTypesStruct"  type="struct"   required=true>
            <cfargument name="debug"                        type="boolean"  required=false>

            <cfoutput>

                <cfset application.adminPanel.components.utility.HTMLElements.HTMLELEMENTS_UserCrudForms_RENDER( urlData, userQuery, listOfLocationsQuery, userSecurityRoleTypes, entryPointQuery, userSecurityRoleTypesStruct, 'Users_Trade_Create_PROCESS', true )>

            </cfoutput>

        </cffunction>

        <cffunction name="Users_Trade_Create_VIEW___IncludeJavascript" access="PRIVATE" output=true hint="">
            <cfargument name="urlData" type="struct" required=true>

            <cfoutput>

                <script>

                    $( document ).ready( function(){


                    } );

                </script>

            </cfoutput>

        </cffunction>

    <!---   **********************************************************************  --->
    <!---   *  Users Trade Profressional Create - END                               --->
    <!---   **********************************************************************  --->

    <!---   **********************************************************************  --->
    <!---   *  Users Trade Profressional Copy - START                               --->
    <!---   **********************************************************************  --->

        <cffunction name="Users_Trade_Copy_VIEW" access="PUBLIC" output=true hint="">
            <cfargument name="urlData"                      type="struct"   required=true>
            <cfargument name="userQuery"                    type="query"    required=true>
            <cfargument name="listOfLocationsQuery"         type="query"    required=true>
            <cfargument name="userSecurityRoleTypes"        type="query"    required=true>
            <cfargument name="entryPointQuery"              type="query"    required=true>
            <cfargument name="userSecurityRoleTypesStruct"  type="struct"   required=true>
            <cfargument name="debug"                        type="boolean"  required=false>

            <cfoutput>

                <cfset application.adminPanel.components.utility.HTMLElements.HTMLELEMENTS_UserCrudForms_RENDER( urlData, userQuery, listOfLocationsQuery, userSecurityRoleTypes, entryPointQuery, userSecurityRoleTypesStruct, 'Users_Trade_Copy_PROCESS', true, true )>

            </cfoutput>

        </cffunction>

        <cffunction name="Users_Trade_Copy_VIEW___IncludeJavascript" access="PRIVATE" output=true hint="">
            <cfargument name="urlData" type="struct" required=true>

            <cfoutput>

                <script>

                    $( document ).ready( function(){


                    } );

                </script>

            </cfoutput>

        </cffunction>

    <!---   **********************************************************************  --->
    <!---   *  Users Trade Profressional Copy - END                                 --->
    <!---   **********************************************************************  --->

    <!---   **********************************************************************  --->
    <!---   *  Users Trade Profressional Edit - START                               --->
    <!---   **********************************************************************  --->

        <cffunction name="Users_Trade_Edit_VIEW" access="PUBLIC" output=true hint="">
            <cfargument name="urlData"                      type="struct"   required=true>
            <cfargument name="userQuery"                    type="query"    required=true>
            <cfargument name="listOfLocationsQuery"         type="query"    required=true>
            <cfargument name="userSecurityRoleTypes"        type="query"    required=true>
            <cfargument name="entryPointQuery"              type="query"    required=true>
            <cfargument name="userSecurityRoleTypesStruct"  type="struct"    required=true>
            <cfargument name="debug"                        type="boolean"  required=false>

            <cfoutput>

                <cfset application.adminPanel.components.utility.HTMLElements.HTMLELEMENTS_UserCrudForms_RENDER( urlData, userQuery, listOfLocationsQuery, userSecurityRoleTypes, entryPointQuery, userSecurityRoleTypesStruct, 'Users_Trade_Edit_PROCESS', true )>

            </cfoutput>

        </cffunction>

        <cffunction name="Users_Trade_Edit_VIEW___IncludeJavascript" access="PRIVATE" output=true hint="">
            <cfargument name="urlData" type="struct" required=true>

            <cfoutput>

                <script>

                    $( document ).ready( function(){


                    } );

                </script>

            </cfoutput>

        </cffunction>

    <!---   **********************************************************************  --->
    <!---   *  Users Trade Profressional Edit - END                                 --->
    <!---   **********************************************************************  --->

    <!---   **********************************************************************  --->
    <!---   *  Users Site Admin Listing - START                                     --->
    <!---   **********************************************************************  --->

        <cffunction name="Users_Site_Admin_Listing_VIEW" access="PUBLIC" output=true hint="">
            <cfargument name="urlData"      type="struct"   required=true>
            <cfargument name="debug"        type="boolean"  required=true>
            <cfargument name="userData"     type="query"    required=true>

            <cfoutput>

                <div class="card-page card-dashboard-analytics card-outline-info">

                    <div class="card-header">
                        <h4 class="m-b-0t ">#application.adminPanel.metaData.pages[ urlData[ 'page' ] ].title#</h4>
                        <button class="btn btn-theme js-user-customer-new waves-effect waves-light m-r-10"    data-action="new"           type="button">Create User <i class="fa fa-user-plus" aria-hidden="true"></i></button>
                        <button class="btn btn-theme js-export-users waves-effect waves-light m-r-10"         data-action="exportUser"    userType='Site' data-href='#application.adminPanel.components.utility.strings.Strings_GeneratePageHref_TASK( 'userExport' )#' type="button">Export Users <i class="fas fa-save" aria-hidden="true"></i></button>
                    </div>

                    <div class="card-prompt" >
                        <div class="card-prompt__holder">
                            <form id="checkEmail" name="checkEmail" method="post" action="/adminpanel/users/checkEmail" _lpchecked="1" class="form-material m-t-40">
                                <cfset application.adminPanel.components.utility.htmlElements.HTMLELEMENTS_FormHiddenFieldsInvokeProcessAndEnableAjax_RENDER( 'Users_Check_PROCESS', false )>
                                <input type="hidden"        name="userType"              value="Site">
                                <input type="hidden"        name="formInvokeMethod"      value="Users_Site_Admin_Create_PROCESS">
                                <input type="hidden"        name="page"                  value="create">
                                <div class="form-group card-prompt__holder__form-group">
                                    <input type="email" value="" placeholder="my@email.com" name="email" class="form-control">
                                    <button type="submit" data-onConfirm="#application.adminPanel.components.utility.strings.Strings_GeneratePageHref_TASK( 'userGetInfo' )#"  data-href="#application.adminPanel.components.utility.strings.Strings_GeneratePageHref_TASK( 'siteCreate' )#" class="btn btn-theme waves-effect waves-light m-r-10">Check</button>
                                </div>
                            </form>
                        </div>
                    </div>

                    <div class="card-body">
                        <table id="DTUsers" class="display compact dataTable" cellspacing="0" width="100%">
                            <thead>
                                <tr>
                                <th>Last Login</th>
                                <th>Name</th>
                                <th>Email</th>
                                <th>Phone</th>
                                <th>Status</th>
                                <th>Actions</th>
                                </tr>
                            </thead>
                            
                            <tbody>

                                <cfloop query="userData">
                                    <tr>
                                        <td class="dataTable___lastLogin" title="Number of logins: #loginCount#" data-toggle="tooltip" >
                                            #dateFormat( lastLogin, 'mm-dd-yyyy')#  #timeFormat( lastLogin, 'hh:mm')#
                                        </td>
                                        <td class="dataTable___Name" >
                                            #fname# #lname#
                                        </td>
                                        <td class="dataTable___Email" title="#email#">#email#</td>
                                        <td class="dataTable___phoneType1" title="#phoneType1#">#phone1#</td>
                                        <td class="dataTable___activeStatus" title="#active#"><i class="fas <cfif active > fa-user green-darker-10 <cfelse> fa-user-slash red </cfif>"/></td>
                                        <td class="dataTable___Actions">
                                            <a href="##" data-userID="#userID#" data-action="edit"      data-href="#application.adminPanel.components.utility.strings.Strings_GeneratePageHref_TASK( 'siteEditing' )#"><i class="fas fa-pencil-alt">&nbsp;&nbsp;</i></a>
                                            <a href="##" data-userID="#userID#" data-action='copy'      data-href="#application.adminPanel.components.utility.strings.Strings_GeneratePageHref_TASK( 'siteCopy' )#"><i class="far fa-copy">&nbsp;&nbsp;</i></a>
                                            <a href="##" data-userID="#userID#" data-action='delete'    data-href="#application.adminPanel.components.utility.strings.Strings_GeneratePageHref_TASK( 'siteRemove' )#" processInvoke='Users_Site_Admin_Remove_PROCESS'><i class="fas fa-trash-alt">&nbsp;&nbsp;</i></a>                                            
                                        </td>
                                    </tr>
                                </cfloop>

                            </tbody>

                        </table>

                    </div>

                </div>

                <cfset variables.Users_SharedIFrame_VIEW( urlData )>

                <cfset variables.User_Site_Admin_Listing_VIEW___IncludeJavascript( urlData )>
        
            </cfoutput>

        </cffunction>


        <cffunction name="User_Site_Admin_Listing_VIEW___IncludeJavascript" access="PRIVATE" output=true hint="">
            <cfargument name="urlData" type="struct" required=true>

            <cfoutput>

                <script>

                    $( document ).ready( function(){

                        $('##DTUsers').DataTable();

                    } );

                </script>

            </cfoutput>

        </cffunction>

    <!---   **********************************************************************  --->
    <!---   *  Users Site Admin Listing - END                                       --->
    <!---   **********************************************************************  --->

    <!---   **********************************************************************  --->
    <!---   *  Users Site Admin Create - START                                      --->
    <!---   **********************************************************************  --->

        <cffunction name="Users_Site_Admin_Create_VIEW" access="PUBLIC" output=true hint="">
            <cfargument name="urlData"                      type="struct"   required=true>
            <cfargument name="userQuery"                    type="query"    required=true>
            <cfargument name="listOfLocationsQuery"         type="query"    required=true>
            <cfargument name="userSecurityRoleTypes"        type="query"    required=true>
            <cfargument name="entryPointQuery"              type="query"    required=true>
            <cfargument name="userSecurityRoleTypesStruct"  type="struct"   required=true>
            <cfargument name="debug"                        type="boolean"  required=false>

            <cfoutput>

                <cfset application.adminPanel.components.utility.HTMLElements.HTMLELEMENTS_UserCrudForms_RENDER( urlData, userQuery, listOfLocationsQuery, userSecurityRoleTypes, entryPointQuery, userSecurityRoleTypesStruct, 'Users_Site_Admin_Create_PROCESS', true )>

            </cfoutput>

        </cffunction>

        <cffunction name="Users_Site_Admin_Create_VIEW___IncludeJavascript" access="PRIVATE" output=true hint="">
            <cfargument name="urlData" type="struct" required=true>

            <cfoutput>

                <script>

                    $( document ).ready( function(){


                    } );

                </script>

            </cfoutput>

        </cffunction>

    <!---   **********************************************************************  --->
    <!---   *  Users Site Admin Create - END                                        --->
    <!---   **********************************************************************  --->

    <!---   **********************************************************************  --->
    <!---   *  Users Site Admin Copy - START                                        --->
    <!---   **********************************************************************  --->

        <cffunction name="Users_Site_Admin_Copy_VIEW" access="PUBLIC" output=true hint="">
            <cfargument name="urlData"                      type="struct"   required=true>
            <cfargument name="userQuery"                    type="query"    required=true>
            <cfargument name="listOfLocationsQuery"         type="query"    required=true>
            <cfargument name="userSecurityRoleTypes"        type="query"    required=true>
            <cfargument name="entryPointQuery"              type="query"    required=true>
            <cfargument name="userSecurityRoleTypesStruct"  type="struct"   required=true>
            <cfargument name="debug"                        type="boolean"  required=false>

            <cfoutput>

                <cfset application.adminPanel.components.utility.HTMLElements.HTMLELEMENTS_UserCrudForms_RENDER( urlData, userQuery, listOfLocationsQuery, userSecurityRoleTypes, entryPointQuery, userSecurityRoleTypesStruct, 'Users_Site_Admin_Copy_PROCESS', true, true )>

            </cfoutput>

        </cffunction>

        <cffunction name="Users_Site_Admin_Copy_VIEW___IncludeJavascript" access="PRIVATE" output=true hint="">
            <cfargument name="urlData" type="struct" required=true>

            <cfoutput>

                <script>

                    $( document ).ready( function(){


                    } );

                </script>

            </cfoutput>

        </cffunction>

    <!---   **********************************************************************  --->
    <!---   *  Users Site Admin Copy - END                                          --->
    <!---   **********************************************************************  --->

    <!---   **********************************************************************  --->
    <!---   *  Users Site Admin Edit - START                                        --->
    <!---   **********************************************************************  --->

        <cffunction name="Users_Site_Admin_Edit_VIEW" access="PUBLIC" output=true hint="">
            <cfargument name="urlData"                      type="struct"   required=true>
            <cfargument name="userQuery"                    type="query"    required=true>
            <cfargument name="listOfLocationsQuery"         type="query"    required=true>
            <cfargument name="userSecurityRoleTypes"        type="query"    required=true>
            <cfargument name="entryPointQuery"              type="query"    required=true>
            <cfargument name="userSecurityRoleTypesStruct"  type="struct"    required=true>
            <cfargument name="debug"                        type="boolean"  required=false>

            <cfoutput>

                <cfset application.adminPanel.components.utility.HTMLElements.HTMLELEMENTS_UserCrudForms_RENDER( urlData, userQuery, listOfLocationsQuery, userSecurityRoleTypes, entryPointQuery, userSecurityRoleTypesStruct, 'Users_Site_Admin_Edit_PROCESS', true )>

            </cfoutput>

        </cffunction>

        <cffunction name="Users_Site_Admin_Edit_VIEW___IncludeJavascript" access="PRIVATE" output=true hint="">
            <cfargument name="urlData" type="struct" required=true>

            <cfoutput>

                <script>

                    $( document ).ready( function(){


                    } );

                </script>

            </cfoutput>

        </cffunction>

    <!---   **********************************************************************  --->
    <!---   *  Users Site Admin Edit - END                                          --->
    <!---   **********************************************************************  --->
 
    <!---   **********************************************************************  --->
    <!---   *  Users All Listing - START                                             --->
    <!---   **********************************************************************  --->

        <cffunction name="Users_All_Listing_VIEW" access="PUBLIC" output=true hint="">
            <cfargument name="urlData"      type="struct"   required=true>
            <cfargument name="debug"        type="boolean"  required=true>
            <cfargument name="userData"     type="query"    required=true>

            <cfoutput>

                <div class="card-page card-dashboard-analytics card-outline-info">

                    <div class="card-header">
                        <h4 class="m-b-0t">#application.adminPanel.metaData.pages[ urlData[ 'page' ] ].title#</h4>
                        <button class="btn btn-theme js-user-customer-new waves-effect waves-light m-r-10"    data-action="new"           type="button">Create User <i class="fa fa-user-plus" aria-hidden="true"></i></button>
                        <button class="btn btn-theme js-export-users waves-effect waves-light m-r-10"         data-action="exportUser"    userType='Any' data-href='#application.adminPanel.components.utility.strings.Strings_GeneratePageHref_TASK( 'userExport' )#' type="button">Export Users <i class="fas fa-save" aria-hidden="true"></i></button>
                    </div>

                    <div class="card-prompt" >
                        <div class="card-prompt__holder">
                            <form id="checkEmail" name="checkEmail" method="post" action="/adminpanel/users/checkEmail" _lpchecked="1" class="form-material m-t-40">
                                <cfset application.adminPanel.components.utility.htmlElements.HTMLELEMENTS_FormHiddenFieldsInvokeProcessAndEnableAjax_RENDER( 'Users_Check_PROCESS', false )>
                                <input type="hidden"        name="userType"              value="Site">
                                <input type="hidden"        name="formInvokeMethod"      value="Users_All_Create_PROCESS">
                                <input type="hidden"        name="page"                  value="create">
                                <div class="form-group card-prompt__holder__form-group">
                                    <input type="email" value="" placeholder="my@email.com" name="email" class="form-control">
                                    <button type="submit" data-onConfirm="#application.adminPanel.components.utility.strings.Strings_GeneratePageHref_TASK( 'userGetInfo' )#"  data-href="#application.adminPanel.components.utility.strings.Strings_GeneratePageHref_TASK( 'allCreate' )#" class="btn btn-theme waves-effect waves-light m-r-10">Check</button>
                                </div>
                            </form>
                        </div>
                    </div>

                    <div class="card-body">
                        <table id="DTUsers" class="display compact dataTable" cellspacing="0" width="100%">
                            <thead>
                                <tr>
                                    <th>Last Login</th>
                                    <th>Type</th>
                                    <th>Name</th>
                                    <th>Email</th>
                                    <th>Phone</th>
                                    <th>Status</th>
                                    <th>Actions</th>
                                </tr>
                            </thead>
                            
                            <tbody>

                                <cfloop query="userData">
                                    <tr>
                                        <td class="dataTable___lastLogin" title="Number of logins: #loginCount#" data-toggle="tooltip" >
                                            #dateFormat( lastLogin, 'mm-dd-yyyy')#  #timeFormat( lastLogin, 'hh:mm')#
                                        </td>
                                        <td class="dataTable___userType" >
                                            #application.securityrolesalias[ userType ]#
                                        </td>                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                        
                                        <td class="dataTable___Name" >
                                            #fname# #lname#
                                        </td>
                                        <td class="dataTable___Email" title="#email#">#email#</td>
                                        <td class="dataTable___phoneType1" title="#phoneType1#">#phone1#</td>
                                        <td class="dataTable___activeStatus" title="#active#"><i class="fas <cfif active > fa-user green-darker-10 <cfelse> fa-user-slash red </cfif>"/></td>
                                        <td class="dataTable___Actions">
                                            <a href="##" data-userID="#userID#" data-action="edit"      data-href="#application.adminPanel.components.utility.strings.Strings_GeneratePageHref_TASK( 'allEditing' )#"><i class="fas fa-pencil-alt">&nbsp;&nbsp;</i></a>
                                            <a href="##" data-userID="#userID#" data-action='copy'      data-href="#application.adminPanel.components.utility.strings.Strings_GeneratePageHref_TASK( 'allCopy' )#"><i class="far fa-copy">&nbsp;&nbsp;</i></a>
                                            <a href="##" data-userID="#userID#" data-action='delete'    data-href="#application.adminPanel.components.utility.strings.Strings_GeneratePageHref_TASK( 'allRemove' )#" processInvoke='Users_All_Remove_PROCESS'><i class="fas fa-trash-alt">&nbsp;&nbsp;</i></a>                                            
                                        </td>
                                    </tr>
                                </cfloop>

                            </tbody>

                        </table>

                    </div>

                </div>

                <cfset variables.Users_SharedIFrame_VIEW( urlData )>

                <cfset variables.Users_All_Listing_VIEW___IncludeJavascript( urlData )>
        
            </cfoutput>

        </cffunction>


        <cffunction name="Users_All_Listing_VIEW___IncludeJavascript" access="PRIVATE" output=true hint="">
            <cfargument name="urlData" type="struct" required=true>

            <cfoutput>

                <script>

                    $( document ).ready( function(){

                        $('##DTUsers').DataTable();

                    } );

                </script>

            </cfoutput>

        </cffunction>

    <!---   **********************************************************************  --->
    <!---   *  Users All Listing - END                                               --->
    <!---   **********************************************************************  --->

    <!---   **********************************************************************  --->
    <!---   *  Users All Create - START                                              --->
    <!---   **********************************************************************  --->

        <cffunction name="Users_All_Create_VIEW" access="PUBLIC" output=true hint="">
            <cfargument name="urlData"                      type="struct"   required=true>
            <cfargument name="userQuery"                    type="query"    required=true>
            <cfargument name="listOfLocationsQuery"         type="query"    required=true>
            <cfargument name="userSecurityRoleTypes"        type="query"    required=true>
            <cfargument name="entryPointQuery"              type="query"    required=true>
            <cfargument name="userSecurityRoleTypesStruct"  type="struct"   required=true>
            <cfargument name="debug"                        type="boolean"  required=false>

            <cfoutput>

                <cfset application.adminPanel.components.utility.HTMLElements.HTMLELEMENTS_UserCrudForms_RENDER( urlData, userQuery, listOfLocationsQuery, userSecurityRoleTypes, entryPointQuery, userSecurityRoleTypesStruct, 'Users_All_Create_PROCESS', true )>

            </cfoutput>

        </cffunction>

        <cffunction name="Users_All_Create_VIEW___IncludeJavascript" access="PRIVATE" output=true hint="">
            <cfargument name="urlData" type="struct" required=true>

            <cfoutput>

                <script>

                    $( document ).ready( function(){


                    } );

                </script>

            </cfoutput>

        </cffunction>

    <!---   **********************************************************************  --->
    <!---   *  Users All Create - END                                                --->
    <!---   **********************************************************************  --->

    <!---   **********************************************************************  --->
    <!---   *  Users All Copy - START                                                --->
    <!---   **********************************************************************  --->

        <cffunction name="Users_All_Copy_VIEW" access="PUBLIC" output=true hint="">
            <cfargument name="urlData"                      type="struct"   required=true>
            <cfargument name="userQuery"                    type="query"    required=true>
            <cfargument name="listOfLocationsQuery"         type="query"    required=true>
            <cfargument name="userSecurityRoleTypes"        type="query"    required=true>
            <cfargument name="entryPointQuery"              type="query"    required=true>
            <cfargument name="userSecurityRoleTypesStruct"  type="struct"   required=true>
            <cfargument name="debug"                        type="boolean"  required=false>

            <cfoutput>

                <cfset application.adminPanel.components.utility.HTMLElements.HTMLELEMENTS_UserCrudForms_RENDER( urlData, userQuery, listOfLocationsQuery, userSecurityRoleTypes, entryPointQuery, userSecurityRoleTypesStruct, 'Users_All_Copy_PROCESS', true, true )>

            </cfoutput>

        </cffunction>

        <cffunction name="Users_All_Copy_VIEW___IncludeJavascript" access="PRIVATE" output=true hint="">
            <cfargument name="urlData" type="struct" required=true>

            <cfoutput>

                <script>

                    $( document ).ready( function(){


                    } );

                </script>

            </cfoutput>

        </cffunction>

    <!---   **********************************************************************  --->
    <!---   *  Users All Copy - END                                                  --->
    <!---   **********************************************************************  --->

    <!---   **********************************************************************  --->
    <!---   *  Users All Edit - START                                                --->
    <!---   **********************************************************************  --->

        <cffunction name="Users_All_Edit_VIEW" access="PUBLIC" returntype="void" output=true hint="">
            <cfargument name="urlData"                      type="struct"   required=true>
            <cfargument name="userQuery"                    type="query"    required=true>
            <cfargument name="listOfLocationsQuery"         type="query"    required=true>
            <cfargument name="userSecurityRoleTypes"        type="query"    required=true>
            <cfargument name="entryPointQuery"              type="query"    required=true>
            <cfargument name="userSecurityRoleTypesStruct"  type="struct"    required=true>
            <cfargument name="debug"                        type="boolean"  required=false>

            <cfoutput>

                <cfset application.adminPanel.components.utility.HTMLElements.HTMLELEMENTS_UserCrudForms_RENDER( urlData, userQuery, listOfLocationsQuery, userSecurityRoleTypes, entryPointQuery, userSecurityRoleTypesStruct, 'Users_All_Edit_PROCESS', true )>

            </cfoutput>

        </cffunction>

        <cffunction name="Users_All_Edit_VIEW___IncludeJavascript" returntype="void" access="PRIVATE" output=true hint="">
            <cfargument name="urlData" type="struct" required=true>

            <cfoutput>

                <script>

                    $( document ).ready( function(){


                    } );

                </script>

            </cfoutput>

        </cffunction>

    <!---   **********************************************************************  --->
    <!---   *  Users All Edit - END                                                 --->
    <!---   **********************************************************************  --->

    <!---   **********************************************************************  --->
    <!---   *  Users Admin Listing - START                                             --->
    <!---   **********************************************************************  --->

        <cffunction name="Users_Admin_Listing_VIEW" access="PUBLIC" output=true hint="">
            <cfargument name="urlData"      type="struct"   required=true>
            <cfargument name="debug"        type="boolean"  required=true>
            <cfargument name="userData"     type="query"    required=true>

            <cfoutput>

                <div class="card-page card-dashboard-analytics card-outline-info">

                    <div class="card-header">
                        <h4 class="m-b-0t">#application.adminPanel.metaData.pages[ urlData[ 'page' ] ].title#</h4>
                        <button class="btn btn-theme js-user-customer-new waves-effect waves-light m-r-10"    data-action="new"           type="button">Create User <i class="fa fa-user-plus" aria-hidden="true"></i></button>
                        <button class="btn btn-theme js-export-users waves-effect waves-light m-r-10"         data-action="exportUser"    userType='admin' data-href='#application.adminPanel.components.utility.strings.Strings_GeneratePageHref_TASK( 'userExport' )#' type="button">Export Users <i class="fas fa-save" aria-hidden="true"></i></button>
                    </div>

                    <div class="card-prompt" >
                        <div class="card-prompt__holder">
                            <form id="checkEmail" name="checkEmail" method="post" action="/adminpanel/users/checkEmail" _lpchecked="1" class="form-material m-t-40">
                                <cfset application.adminPanel.components.utility.htmlElements.HTMLELEMENTS_FormHiddenFieldsInvokeProcessAndEnableAjax_RENDER( 'Users_Check_PROCESS', false )>
                                <input type="hidden"        name="userType"              value="Site">
                                <input type="hidden"        name="formInvokeMethod"      value="Users_Admin_Create_PROCESS">
                                <input type="hidden"        name="page"                  value="create">
                                <div class="form-group card-prompt__holder__form-group">
                                    <input type="email" value="" placeholder="my@email.com" name="email" class="form-control">
                                    <button type="submit" data-onConfirm="#application.adminPanel.components.utility.strings.Strings_GeneratePageHref_TASK( 'userGetInfo' )#"  data-href="#application.adminPanel.components.utility.strings.Strings_GeneratePageHref_TASK( 'siteCheck' )#" class="btn btn-theme waves-effect waves-light m-r-10">Check</button>
                                </div>
                            </form>
                        </div>
                    </div>

                    <div class="card-body">
                        <table id="DTUsers" class="display compact dataTable" cellspacing="0" width="100%">
                            <thead>
                                <tr>
                                <th>Lsat Login</th>
                                <th>Name</th>
                                <th>Email</th>
                                <th>Phone</th>
                                <th>Active Status</th>
                                <th>Actions</th>
                                </tr>
                            </thead>
                            
                            <tbody>

                                <cfloop query="userData">
                                    <tr>
                                        <td class="dataTable___lastLogin" title="#loginCount#" data-toggle="tooltip" >
                                            #lastLogin#
                                        </td>
                                        <td class="dataTable___Name" >
                                            #fname# #lname#
                                        </td>
                                        <td class="dataTable___Email" title="#email#">#email#</td>
                                        <td class="dataTable___phoneType1" title="#phoneType1#">#phone1#</td>
                                        <td class="dataTable___activeStatus" title="#active#"><i class="fas <cfif active > fa-user green-darker-10 <cfelse> fa-user-slash red </cfif>"/></td>
                                        <td class="dataTable___Actions">
                                            <a href="##" data-userID="#userID#" data-action="edit"      data-href="#application.adminPanel.components.utility.strings.Strings_GeneratePageHref_TASK( 'allEditing' )#"><i class="fas fa-pencil-alt">&nbsp;&nbsp;</i></a>
                                            <a href="##" data-userID="#userID#" data-action='copy'      data-href="#application.adminPanel.components.utility.strings.Strings_GeneratePageHref_TASK( 'allCopy' )#"><i class="far fa-copy">&nbsp;&nbsp;</i></a>
                                            <a href="##" data-userID="#userID#" data-action='delete'    data-href="#application.adminPanel.components.utility.strings.Strings_GeneratePageHref_TASK( 'allRemove' )#" processInvoke='Users_Admin_Remove_PROCESS'><i class="fas fa-trash-alt">&nbsp;&nbsp;</i></a>                                            
                                        </td>
                                    </tr>
                                </cfloop>

                            </tbody>

                        </table>

                    </div>

                </div>

                <cfset variables.Users_SharedIFrame_VIEW( urlData )>

                <cfset variables.Users_Admin_Listing_VIEW___IncludeJavascript( urlData )>
        
            </cfoutput>

        </cffunction>


        <cffunction name="Users_Admin_Listing_VIEW___IncludeJavascript" access="PRIVATE" output=true hint="">
            <cfargument name="urlData" type="struct" required=true>

            <cfoutput>

                <script>

                    $( document ).ready( function(){

                        $('##DTUsers').DataTable();

                    } );

                </script>

            </cfoutput>

        </cffunction>

    <!---   **********************************************************************  --->
    <!---   *  Users Admin Listing - END                                               --->
    <!---   **********************************************************************  --->

    <!---   **********************************************************************  --->
    <!---   *  Users Admin Create - START                                              --->
    <!---   **********************************************************************  --->

        <cffunction name="Users_Admin_Create_VIEW" access="PUBLIC" output=true hint="">
            <cfargument name="urlData"                      type="struct"   required=true>
            <cfargument name="userQuery"                    type="query"    required=true>
            <cfargument name="listOfLocationsQuery"         type="query"    required=true>
            <cfargument name="userSecurityRoleTypes"        type="query"    required=true>
            <cfargument name="entryPointQuery"              type="query"    required=true>
            <cfargument name="userSecurityRoleTypesStruct"  type="struct"   required=true>
            <cfargument name="debug"                        type="boolean"  required=false>

            <cfoutput>

                <cfset application.adminPanel.components.utility.HTMLElements.HTMLELEMENTS_UserCrudForms_RENDER( urlData, userQuery, listOfLocationsQuery, userSecurityRoleTypes, entryPointQuery, userSecurityRoleTypesStruct, 'Users_Admin_Create_PROCESS', true )>

            </cfoutput>

        </cffunction>

        <cffunction name="Users_Admin_Create_VIEW___IncludeJavascript" access="PRIVATE" output=true hint="">
            <cfargument name="urlData" type="struct" required=true>

            <cfoutput>

                <script>

                    $( document ).ready( function(){


                    } );

                </script>

            </cfoutput>

        </cffunction>

    <!---   **********************************************************************  --->
    <!---   *  Users Admin Create - END                                               --->
    <!---   **********************************************************************  --->

    <!---   **********************************************************************  --->
    <!---   *  Users Admin Copy - START                                               --->
    <!---   **********************************************************************  --->

        <cffunction name="Users_Admin_Copy_VIEW" access="PUBLIC" output=true hint="">
            <cfargument name="urlData"                      type="struct"   required=true>
            <cfargument name="userQuery"                    type="query"    required=true>
            <cfargument name="listOfLocationsQuery"         type="query"    required=true>
            <cfargument name="userSecurityRoleTypes"        type="query"    required=true>
            <cfargument name="entryPointQuery"              type="query"    required=true>
            <cfargument name="userSecurityRoleTypesStruct"  type="struct"   required=true>
            <cfargument name="debug"                        type="boolean"  required=false>

            <cfoutput>

                <cfset application.adminPanel.components.utility.HTMLElements.HTMLELEMENTS_UserCrudForms_RENDER( urlData, userQuery, listOfLocationsQuery, userSecurityRoleTypes, entryPointQuery, userSecurityRoleTypesStruct, 'Users_Admin_Copy_PROCESS', true, true )>

            </cfoutput>

        </cffunction>

        <cffunction name="Users_Admin_Copy_VIEW___IncludeJavascript" access="PRIVATE" output=true hint="">
            <cfargument name="urlData" type="struct" required=true>

            <cfoutput>

                <script>

                    $( document ).ready( function(){


                    } );

                </script>

            </cfoutput>

        </cffunction>

    <!---   **********************************************************************  --->
    <!---   *  Users Admin Copy - END                                                  --->
    <!---   **********************************************************************  --->

    <!---   **********************************************************************  --->
    <!---   *  Users Admin Edit - START                                                --->
    <!---   **********************************************************************  --->

        <cffunction name="Users_Admin_Edit_VIEW" access="PUBLIC" returntype="void" output=true hint="">
            <cfargument name="urlData"                      type="struct"   required=true>
            <cfargument name="userQuery"                    type="query"    required=true>
            <cfargument name="listOfLocationsQuery"         type="query"    required=true>
            <cfargument name="userSecurityRoleTypes"        type="query"    required=true>
            <cfargument name="entryPointQuery"              type="query"    required=true>
            <cfargument name="userSecurityRoleTypesStruct"  type="struct"    required=true>
            <cfargument name="debug"                        type="boolean"  required=false>

            <cfoutput>

                <cfset application.adminPanel.components.utility.HTMLElements.HTMLELEMENTS_UserCrudForms_RENDER( urlData, userQuery, listOfLocationsQuery, userSecurityRoleTypes, entryPointQuery, userSecurityRoleTypesStruct, 'Users_Admin_Edit_PROCESS', true )>

            </cfoutput>

        </cffunction>

        <cffunction name="Users_Admin_Edit_VIEW___IncludeJavascript" returntype="void" access="PRIVATE" output=true hint="">
            <cfargument name="urlData" type="struct" required=true>

            <cfoutput>

                <script>

                    $( document ).ready( function(){


                    } );

                </script>

            </cfoutput>

        </cffunction>

    <!---   **********************************************************************  --->
    <!---   *  Users Admin Edit - END                                               --->
    <!---   **********************************************************************  --->

    <!---   **********************************************************************  --->
    <!---   * Users Export Page - START                                             --->
    <!---   **********************************************************************  --->

        <cffunction name="Users_Export_VIEW" access="PUBLIC" returntype="void" output=true hint="">
            <cfargument     name="urlData"            type="struct"     required=true>
            <cfargument     name="mySpreadsheet"      type="any"        required=true>

            <cfoutput>

                <cfcontent type="application/vnd.ms-excel" variable="#SpreadSheetReadBinary(mySpreadsheet)#" >
                <cfheader name="Content-Disposition" value="attachment; filename=UserExport-#DateFormat(Now(),'mm-dd-yyyy')#.xls" >

            </cfoutput>

        </cffunction>

    <!---   **********************************************************************  --->
    <!---   * Users Export Page  - END                                              --->
    <!---   **********************************************************************  --->

    <!---   **********************************************************************  --->
    <!---   * Users Shared Modules - START                                          --->
    <!---   **********************************************************************  --->

        <cffunction name="Users_SharedIFrame_VIEW" access="PRIVATE" returntype="void" output=true hint="">
            <cfargument name="urlData"  type="struct"  required=true>

            <cfoutput>

                <iframe class="hide" id="loadExport" src="/adminpanel/dashboard/dashboard?chromeless=true" width="100%" height="0"></iframe>

            </cfoutput>

        </cffunction>

    <!---   **********************************************************************  --->
    <!---   * Users Shared Modules  - END                                           --->
    <!---   **********************************************************************  --->

</cfcomponent>