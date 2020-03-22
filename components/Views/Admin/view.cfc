<cfcomponent displayName="BrandView" output=true hint="">

    <!---   **********************************************************************  --->
    <!---   *  Brand Listing - START                                                --->
    <!---   **********************************************************************  --->


        <cffunction name="Admin_Brand_Listing_VIEW" access="PUBLIC" returntype="void" output=true hint="">
            <cfargument name="urlData"      type="struct"   required=true>
            <cfargument name="debug"        type="boolean"  required=true>
            <cfargument name="userData"     type="query"    required=true>

            <cfoutput>

                <div class="card-page card-dashboard-analytics card-outline-info">

                    <div class="card-header">
                        <h4 class="m-b-0t ">#application.adminPanel.metaData.pages[ urlData[ 'page' ] ].title#</h4>
                        <button class="btn btn-primary js-brand-new waves-effect waves-light m-r-10"    data-action="new"           type="button">Create Brand <i class="fa fa-user-plus" aria-hidden="true"></i></button>
                        <button class="btn btn-primary js-export-brands waves-effect waves-light m-r-10"         data-action="exportBrand"    userType='User' data-href='#application.adminPanel.components.utility.strings.Strings_GeneratePageHref_TASK( 'brandExport' )#' type="button">Export Brand <i class="fas fa-save" aria-hidden="true"></i></button>
                    </div>

                    <div class="card-body">
                        <table id="renderDataTable" class="display compact dataTable" cellspacing="0" width="100%">
                            <thead>
                                <tr>
                                    <th>Brand Name</th>
                                    <th>Products</th>
                                    <th>Visiblity</th>
                                    <th>Account</th>
                                    <th>Sales Rep</th>        
                                    <th>Price</th>
                                    <th>Data Date </th>
                                    <th>Data Next</th>
                                    <th>Price Date</th>
                                    <th>Price Next</th>
                                    <th>Actions</th>
                                </tr>
                            </thead>
                            
                            <tbody class="dataTable___TableBody">

                                <cfloop query="userData">
                                    <tr>
                                        <td title="brandID: #userData.brandID# / brandCode: #userData.brandCode#" class="dataTable___TableBody___QueryRow" >
                                            #userData.brandName#
                                        </td>
                                        <td title="Brand: #userData.brandName#&##13;products: #userData.numProducts#&##13;images:#userData.numImages#" class="dataTable___TableBody___QueryRow___QueryCell" >
                                            #userData.numProducts#
                                        </td>
                                        <td class="dataTable___TableBody___QueryRow___QueryCell" >
                                            #( userData.brandVisibile )? application.securitylevels[ userData.brandVisibile ] : 'Brand Default' #
                                        </td>
                                        <td><cfif userData.theAccountNumber is "">Update Required<cfelse>#userData.theAccountNumber#</cfif></td>
                                            <td title="#userData.salesRepPhone#">
                                             <cfif userData.salesRepFirstName is not "" and userData.salesRepLastName is not "">
                                              #userData.salesRepFirstName# #userData.salesRepLastName#
                                             <cfelseif userData.salesRepAgency is not "" >
                                              #userData.salesRepAgency#
                                             <cfelse>
                                              Update Required
                                             </cfif>
                                            </td>
                                            <td><cfif userData.detailedBrandSelection gt 1>*<cfelse>#iif(userData.markupType is 1,DE('X ('),DE('% ('))##userData.markup#)</cfif></td>
                                            <td>#dateFormat(userData.dataLastUpdate,'mm/dd/yyyy')#</td>
                                            <td title="#iif(userData.dataNextConf is 0,de('Unconfirmed'),de('Confirmed'))#">#dateFormat(userData.dataNextUpdate,'mm/dd/yyyy')#</td>
                                            <td>#dateFormat(userData.priceLastUpdate,'mm/dd/yyyy')#</td>
                                            <td title="#iif(userData.priceNextConf is 0,de('Unconfirmed'),de('Confirmed'))#">#dateFormat(userData.priceNextUpdate,'mm/dd/yyyy')#</td>
                                        <td class="dataTable___TableBody___QueryRow___QueryCell">
                                            <a href="##" data-userID="##" data-action="edit"      data-href="#application.adminPanel.components.utility.strings.Strings_GeneratePageHref_TASK( 'userEditing' )#" ><i class="fas fa-pencil-alt">&nbsp;&nbsp;</i></a>
                                            <a href="##" data-userID="##" data-action='copy'      data-href="#application.adminPanel.components.utility.strings.Strings_GeneratePageHref_TASK( 'userCopy' )#" >   <i class="far fa-copy">&nbsp;&nbsp;</i></a>
                                            <a href="##" data-userID="##" data-action='delete'    data-href="#application.adminPanel.components.utility.strings.Strings_GeneratePageHref_TASK( 'userRemove' )#" processInvoke='Users_Remove_PROCESS'> <i class="fas fa-trash-alt">&nbsp;&nbsp;</i></a>                                            
                                        </td>
                                    </tr>
                                </cfloop>

                            </tbody>

                        </table>

                    </div>

                </div>

                <!--- <cfset variables.Admin_SharedIFrame_VIEW( urlData )> --->

                <cfset variables.Admin_Brand_Listing_VIEW___IncludeJavascript( urlData )>
        
            </cfoutput>

        </cffunction>

        <cffunction name="Admin_Brand_Listing_VIEW___IncludeJavascript" access="PRIVATE" returntype="void" output=true hint="">

            <cfoutput>

                <script>
                    $.fn.dataTable.render.ellipsis = function ( cutoff ) {
                        return function ( data, type, row ) {
                            return type === 'display' && data.length > cutoff ?
                                data.substr( 0, cutoff ) +'...' :
                                data;
                        }
                    };
                    $(document).ready(function() {
                    $('renderDataTable').DataTable({
                    "dom": "<'row'<'col-sm-5'B><'col-sm-3 mtop10'l><'col-sm-4 mtop10'f>>"+
                            "<'row'<'col-sm-12'tr>>" +
                            "<'row'<'col-sm-5'i><'col-sm-7'p>>",
                    "pageLength": 20,
                    "bPaginate": true,
                    columnDefs: [ 
                    { targets: 0, render: $.fn.dataTable.render.ellipsis(20)},
                    { targets: 4, render: $.fn.dataTable.render.ellipsis(15)}],
                    "colReorder": {reorderCallback: function () {console.log( 'callback' )}},
                    "lengthMenu" : [[20, 50, 100, -1], [20, 50, 100, "All"]],
                    "buttons": ['copy',
                    {extend: 'excel',exportOptions: {columns: ':visible'}},
                    {extend: 'pdf',exportOptions: {columns: ':visible'}},
                    {extend: 'print',exportOptions: {columns: ':visible'}},
                    'colvis'],
                    "responsive": {details: { Type: 'column'}}
                    });
                    });

                </script>

            </cfoutput>

        </cffunction>

    <!---   **********************************************************************  --->
    <!---   *  Brand Listing - END                                                  --->
    <!---   **********************************************************************  --->


</cfcomponent>