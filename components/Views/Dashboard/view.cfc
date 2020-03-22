<cfcomponent displayName="DashboardView" output=true>


    <!---   **********************************************************************  --->
    <!---   *   Dashboard Users Sites View For Right Sidebar - START                --->
    <!---   **********************************************************************  --->

        <cffunction name="Dashboard_UserSites_VIEW" access="PUBLIC" returntype="void" output=true hint="">
            <cfargument name="urlData"          type="struct"   required=true>
            <cfargument name="userQueryData"    type="query"    required=true>
            <cfargument name="debug"            type="boolean"  required=false default=false>

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

                    <tbody class="dataTable___TableBody">
                        <cfloop query="userQueryData">
                            <tr class="dataTable___TableBody___QueryRow">
                                <td class="dataTable___TableBody___QueryRow___QueryCell">
                                    <a href="javascript:void(0)" data-id="#userQueryData.EntryPointCode#" data-count="#userQueryData.recordCount#" class="dataTable___TableBody___QueryRow___QueryCell___Href">#userQueryData.EstablishmentFullName#</a>
                                </td>
                                <td class="dataTable___TableBody___QueryRow___QueryCell">
                                    <a href="javascript:void(0)" data-id="#userQueryData.EntryPointCode#" data-count="#userQueryData.recordCount#" class="dataTable___TableBody___QueryRow___QueryCell___Href">#userQueryData.EstablishmentCity#</a>
                                </td>
                                <td class="dataTable___TableBody___QueryRow___QueryCell">
                                    <a href="javascript:void(0)" data-id="#userQueryData.EntryPointCode#" data-count="#userQueryData.recordCount#" class="dataTable___TableBody___QueryRow___QueryCell___Href">#userQueryData.EstablishmentState#</a>
                                </td>
                            </th>
                            
                        </cfloop>
                    </tbody>

                </table>

            </cfoutput>

        </cffunction>

    <!---   **********************************************************************  --->
    <!---   *   Dashboard Users Sites View For Right Sidebar - END                  --->
    <!---   **********************************************************************  --->

    
    <!---   ************************************************************************  --->
    <!---   *   Dashboard RightSideBar - START                                        --->
    <!---   ************************************************************************  --->

        <cffunction name="Dashboard_RightSideBarPage_VIEW" acess="PUBLIC" returntype="void" output=true hint="">
            <cfargument name="urlData"      type="struct"   required=true>

            <cfoutput>

                
                <div class="card-page card-outline-info">

                    <div class="card-header">
                        <input form='userForm' class='btn btn-theme waves-effect waves-light m-r-10 js-submit' type='submit' value='Save' data-form='userForm'>
                        <button class='btn btn-theme js-close-sidebar'>
                            Cancel
                        </button>
                        <h4 class='m-b-0t' id="rightSideBarTitle">{title}</h4>
                    </div>

                    <div class="card-body">
                    </div>

                </div>

            </cfoutput>

        </cffunction>

    <!---   ************************************************************************  --->
    <!---   *   Dashboard RightSideBar - END                                          --->
    <!---   ************************************************************************  --->

        <cffunction name="Dashboard_Reports_VIEW" access="PUBLIC" returntype="void" output=true hint="" extends="html">
            <cfargument name="urlData"          type="struct"   required=true>
            <cfargument name="query"            type="query"    required=true>
            <cfargument name="debug"            type="boolean"  required=false default=false>

            <!--- Strings --->
            <cfset idx = ''>

            <!--- numerics --->
            <cfset index  = 1>
            <cfset paginationTo = query.recordCount - 100>
            

            <cfif paginationTo lt 0 >

                <cfset paginationTo = 0>

            </cfif>

            <cfoutput>

                <div class="reports_view">

                    <ul>

                        <cfloop index="index" from=1 to="#query.recordCount#">

                            <cfloop index="idx" list="#query.columnList#">



                                    <cfif idx neq 'errorObj'>
                                        <li class="reports_view__entries #lcase(idx)#">

                                            Error at site:    #APPLICATION[ 'errorPanel' ][ 'siteLookUpById' ][ query[ 'siteID' ][ index ] ]# By  #APPLICATION[ 'errorPanel' ][ 'userLookUpById' ][ query[ 'userID' ][ index ] ]# @ #dateTimeFormat( query[ 'createDate' ][ index ], 'm-d-yyy h:m' )#

                                        </li>

                                    </cfif>


                            </cfloop>

                        </cfloop>

                    </ul>


                </div>


            </cfoutput>

        </cffunction>



        <cffunction name="Dashboard_Reports_VIEW___GenerateErrorEntries" access="PRIVATE" returntype="void" output=true hint="" extends="html">


        </cffunction>

</cfcomponent>