<cfcomponent displayName="utilitiesHTMLElementsComponents" output=true>

<!---
 * Index
 *  
 * 8ZUdT - HTMLELEMENTS_StartDocumentFragment_RETRIEVE
 * iDRB2 - HTMLELEMENTS_EndDocumentFragment_RETRIEVE
 * 
 * 
--->
    
    <!---   **********************************************************************  --->
    <!---   *  HTML ELEMENTS Functions - START                                      --->
    <!---   **********************************************************************  --->
    
        <!---
         * @name: HTMLELEMENTS_StartDocumentFragment_RENDER
         * @hint: 'Prints the beginning of an HTML document for the control panel (e.g. the html doctype and the beginning of the html tag itself')
         * 
        --->

        <!--- 8ZUdT --->
        <cffunction name="HTMLELEMENTS_StartDocumentFragment_RENDER" returntype="void" output=true access="PUBLIC" hint="">

            <cfoutput>

                <!DOCTYPE html>

                    <html lang="en" style="#( ( ( structKeyExists( URL, 'debug' ) && isBoolean( URL[ 'debug' ] ) && URL[ 'debug' ] ) ) ? 'overflow: scroll' : '' )#">

            </cfoutput>

        </cffunction>


        <!---
          * @name: HTMLELEMENTS_EndDocumentFragment_RENDER
          * @descrition: 'Prints the end of an HTML document for the control panel (e.g. the end of the html tag itself')
          * 
        --->

        <!--- iDRB2 --->
        <cffunction name="HTMLELEMENTS_EndDocumentFragment_RENDER"  returntype="void" output=true access="PUBLIC" hint="">

            <cfoutput>

                </html>
                
            </cfoutput>

        </cffunction>


        <!--- --->
        <cffunction name="HTMLELEMENTS_FormHiddenFieldsInvokeProcessAndEnableAjax_RENDER" returntype="void" output=true access="PUBLIC" hint="">
            <cfargument name="processInvokeMethodName"  type="string"       required=true>
            <cfargument name="ajax"                     type="boolean"      required=false  default=false>

            <cfoutput>

                <fieldset securityLevel="1">
                    <input type="hidden" name="processInvoke"   value="#processInvokeMethodName#">
                    <input type="hidden" name="ajax"            value=#ajax#>
                </fieldset>

            </cfoutput>

        </cffunction>

        <!--- --->
        <cffunction name="HTMLELEMENTS_UserCrudForms_RENDER" returntype="void" output=true access="PUBLIC" hint="">
            <cfargument name="scopeData"                    type="struct"   required=true>
            <cfargument name="userQuery"                    type="query"    required=true>
            <cfargument name="ListOfLocations"              type="query"    required=true>
            <cfargument name="userSecurityRoleTypes"        type="query"    required=true>
            <cfargument name="entryPoint"                   type="query"    required=true>
            <cfargument name="userSecurityRoleTypesStruct"  type="struct"   required=true>
            <cfargument name="processInvokeMethodName"      type="string"   required=true>
            <cfargument name="ajax"                         type="string"   required=true>
            <cfargument name="enableEmailField"             type="boolean"  required=false default=false>

            <!--- Strings --->
            <cfset itemRequired         = "<span style='color:red;'>*</span>">
            <cfset idx                  = ""> 
            <cfset userTypeCallback     = "">
            <cfset userAvatar           = "">
            <cfset base64Image          = "">
            <cfset defaultFileValue     = "">

            <!--- Numeric --->
            <cfset i = 1>

            <!--- Lists --->
            <cfset columnList           = ''>
            <cfset userSecurityTypes    = listRemoveDuplicates( valueList( userSecurityRoleTypes.type ), ',', true )>

            <!--- Struct --->
            <cfset userData = {}>
            <cfset pricingLevel = {}>

            <cfset pricingLevel[ 'active' ] = []>
            <cfset pricingLevel[ 'name' ]   = []>

            <cfloop from="#i#" to=10 index=i>

                <cfset arrayAppend( pricingLevel.active,    entryPoint[ 'cpActive' & i ] )>
                <cfset arrayAppend( pricingLevel.name,      entryPoint[ 'cpName' & i ] )>

            </cfloop>

            <cfset columnList = userQuery.columnList>

            <cfloop index="i" from=1 to="#userQuery.recordCount#">

                <cfloop list="#userQuery.columnList#" index="idx">
                    
                    <cfset userData[ #idx# ] = userQuery[ #idx# ][ i ]?: '' >

                </cfloop>

            </cfloop>

            <cfset userData[ 'userType' ]  = scopeData[ 'userType' ]?: userData[ 'userType' ]>

            <cfset userAvatar           = ( len( userQuery.userID ) && fileExists( expandPath( "#APPLICATION[ 'UserAvatarsPath' ]##userQuery.userID#.jpg" ) ) )? "#APPLICATION[ 'UserAvatarsPath' ]##userQuery.userID#.jpg" : ''>
            <cfset base64Image          = ( len( userAvatar ) ) ? '' : application.errorPanel.components.utility.image.Image_GenerateDefaultUserAvatar_RENDER( userData[ 'fName' ], userData[ 'lName' ], 128 )>
            <cfset defaultFileValue     = ( len( userAvatar ) ) ? '' : base64Image>

            <cfoutput>

                <form id="userForm" class="row js-form form-material m-t-40" method="form" action="#application.errorPanel.metaData.pages[ reReplaceNoCase( scopeData[ 'page' ], '_', '-', 'all' ) ].href#" name="">
                    
                    <cfset THIS.HTMLELEMENTS_FormHiddenFieldsInvokeProcessAndEnableAjax_RENDER( processInvokeMethodName, ajax )>

                    <fieldset securityLevel='1'>
                        <input type="hidden" id="userID" name="userID" value="#userData[ 'userID' ]#">
                    </fieldset>

                    <fieldset class="col-xl-6 col-lg-6 col-md-12 col-sm-12 col-12 user-form-fields-grid-1" securityLevel='1'>

                        <div class="input-group">

                            <div class="input-group-prepend">
                                <label class="input-group-text" for="Email">Email&nbsp;</label>
                            </div>

                            <input class="form-control js-check-email" type="email" name="Email" placeholder="Email"  aria-label="Email Label" processInvoke='Users_Get_Info_By_Email_PROCESS' data-validation="#application.errorPanel.components.utility.strings.Strings_GeneratePageHref_TASK( 'getInfoByEmail' )#" value="#userData[ 'Email' ]#" <cfif !enableEmailField >disabled</cfif> required data-validation-required-message='This email is not formatted correctly'>

                        </div>

                        <div class="input-group form-group">

                            <div class="input-group-prepend">

                                <label class="input-group-text" for="userType">UserType&nbsp;</label>

                            </div>

                            <select id="userType" class="form-control user-form-fields-grid-1___select" name="userType">

                                <cfloop collection="#application.securityRolesAlias#" item="idx">
                                
                                    <cfswitch  expression='#idx#'>

                                        <cfcase value='user'>

                                            <cfif scopeData[ 'page' ] contains 'create'>

                                                <cfset userTypeCallback=application.errorPanel.components.utility.strings.Strings_GeneratePageHref_TASK( 'userCreate' )>

                                            <cfelseif scopeData[ 'page' ] contains 'edit'>

                                                <cfset userTypeCallback=application.errorPanel.components.utility.strings.Strings_GeneratePageHref_TASK( 'userEditing' )>

                                            <cfelseif scopeData[ 'page' ] contains 'copy'>

                                                <cfset userTypeCallback=application.errorPanel.components.utility.strings.Strings_GeneratePageHref_TASK( 'userCopy' )>

                                            </cfif>

                                        </cfcase>

                                        <cfcase value='special'>

                                            <cfif scopeData[ 'page' ] contains 'create'>

                                                <cfset userTypeCallback=application.errorPanel.components.utility.strings.Strings_GeneratePageHref_TASK( 'tradeCreate' )>

                                            <cfelseif scopeData[ 'page' ] contains 'edit'>

                                                <cfset userTypeCallback=application.errorPanel.components.utility.strings.Strings_GeneratePageHref_TASK( 'tradeEditing' )>
                                                
                                            <cfelseif scopeData[ 'page' ] contains 'copy'>

                                                <cfset userTypeCallback=application.errorPanel.components.utility.strings.Strings_GeneratePageHref_TASK( 'tradeCopy' )>

                                            </cfif>

                                        </cfcase>

                                        <cfcase value='site'>

                                            <cfif scopeData[ 'page' ] contains 'create'>

                                                <cfset userTypeCallback=application.errorPanel.components.utility.strings.Strings_GeneratePageHref_TASK( 'siteCreate' )>

                                            <cfelseif scopeData[ 'page' ] contains 'edit'>

                                                <cfset userTypeCallback=application.errorPanel.components.utility.strings.Strings_GeneratePageHref_TASK( 'siteEditing' )>
                                                
                                            <cfelseif scopeData[ 'page' ] contains 'copy'>

                                                <cfset userTypeCallback=application.errorPanel.components.utility.strings.Strings_GeneratePageHref_TASK( 'siteCopy' )>

                                            </cfif>

                                        </cfcase>

                                        <cfcase value='admin'>

                                            <cfif scopeData[ 'page' ] contains 'create'>

                                                <cfset userTypeCallback=application.errorPanel.components.utility.strings.Strings_GeneratePageHref_TASK( 'siteCreate' )>

                                            <cfelseif scopeData[ 'page' ] contains 'edit'>

                                                <cfset userTypeCallback=application.errorPanel.components.utility.strings.Strings_GeneratePageHref_TASK( 'siteEditing' )>
                                                
                                            <cfelseif scopeData[ 'page' ] contains 'copy'>

                                                <cfset userTypeCallback=application.errorPanel.components.utility.strings.Strings_GeneratePageHref_TASK( 'siteCopy' )>

                                            </cfif>

                                        </cfcase>

                                    </cfswitch>

                                    <option data-callback='#userTypeCallback#' value="#idx#" <cfif userData.userType == idx>selected</cfif> <cfif idx == 'Admin' >disabled</cfif> >#application.securityRolesAlias[ idx ]#</option>

                                </cfloop>

                            </select>

                        </div>


                        <div class="input-group">
                            
                            <div class="input-group-prepend">
                                <label class="input-group-text">Profile Image</label>
                            </div>
                            
                            <input type="file" name="profileUpload" class="dropify" value="#defaultFileValue#" data-default-file="#userAvatar#" data-base64-image="#base64Image#"/>

                        </div>

                        <div class="input-group">

                            <div class="input-group-prepend">
                                <label class="input-group-text"><i class="fab fa-diaspora red"/>&nbsp;&nbsp;First Name&nbsp;</label>
                            </div>

                            <input class="form-control" type="text" name="fName" placeholder="First Name" aria-label="First Name Label " value="#userData[ 'fName' ]#" required data-validation-required-message='First Name is Required'>

                        </div>

                        <div class="input-group">

                            <div class="input-group-prepend">
                                <label class="input-group-text"><i class="fab fa-diaspora red"/>&nbsp;&nbsp;Last Name&nbsp;</label>
                            </div>

                            <input class="form-control" type="text" name="lName" placeholder="Last Name" aria-label="Last Name Label " value="#userData[ 'lName' ]#" required data-validation-required-message='Last Name is Required'>

                        </div>

                        <div class="input-group">

                            <div class="input-group-prepend">
                                <label class="input-group-text">Title&nbsp;</label>
                            </div>

                            <input class="form-control" type="text" name="Title" placeholder="Title" aria-label="Title Label " value="#userData[ 'Title' ]#">

                        </div>
                        
                        <div class="input-group" securityLevel="100">

                            <div class="input-group-prepend">
                                <label class="input-group-text">Pricing&nbsp;</label>
                            </div>

                            <!--- <input class="form-control" type="text" name="pricingLevel" placeholder="pricingLevel" aria-label="Pricing Level Label " value="#userData[ 'pricingLevel' ]#"> --->

                            <select class="form-control" id="pricingLevel" name="pricingLevel" aria-label="Pricing Level">
                                <optgroup label='Default'>
                                    <option value=0>Site Pricing <option>
                                </outgroup>
                                <optgroup>
                                    <cfloop from=1 to=#arrayLen(pricingLevel[ 'active' ])# index=i>
                                        <cfif len( pricingLevel[ 'name' ][ i ] )>
                                            <option value=i <cfif userData[ 'pricingLevel' ] == i>selected="selected"</cfif>>#pricingLevel[ 'name' ][ i ]#<option>
                                        </cfif>
                                    </cfloop>
                                </optgroup>
                            </select>

                        </div>      

                        <div class="input-group">

                            <div class="input-group-prepend">
                                <label for="passwordReset" class="input-group-text">Reset Password</label>
                            </div>

                            <input id="passwordReset" class="" type="checkbox" name="passwordReset"  data-size="normal" data-toggle="toggle" data-onstyle='theme-slider' data-offstyle='theme-slider' data-on="Yes" data-off="No" value="1">

                            <input type="hidden" name="origPassword" value="#userData[ 'password' ]#" />
                            <input type="hidden" name="password" value="#application.errorPanel.components.utility.strings.STRINGS_GENERATEPASSWORD_TASK()#" />
                 
                        </div>

                        <div class="input-group form-group">
                            <div class="input-group-prepend">
                                <label for="emailPreference" class="input-group-text" >Email Signup</label>
                            </div>

                            <input type="checkbox" id="emailPreference" name="emailPreference" data-size="normal" data-toggle="toggle" data-onstyle='theme-slider' data-offstyle='theme-slider' data-on="Yes" data-off="No"  <cfif structKeyExists( userData, 'emailPreference' ) && isBoolean( userData[ 'emailPreference' ] ) && userData[ 'emailPreference' ] >checked</cfif>  value=1>
                        </div>

                        <div class="input-group">

                            <div class="input-group-prepend">
                                <label for="active" class="input-group-text">Active</label>
                            </div>

                            <input id="isActive" class="" type="checkbox" name="active" data-size="normal" data-toggle="toggle" data-onstyle='theme-slider' data-offstyle='theme-slider' data-on="Yes" data-off="No" <cfif structKeyExists( userData, 'active' ) && isBoolean( userData[ 'active' ] ) && userData[ 'active' ] >checked</cfif> value="1">

                        </div>
                    
                    </fieldset>

                    <fieldset class="col-xl-6 col-lg-6 col-md-12 col-sm-12 col-12 user-form-fields-grid-4" securityLevel='1'>

                        <div class="input-group">

                            <div class="input-group-prepend">
                                <span class="input-group-text" id="company">Company</span>
                            </div>

                            <input class="form-control" type="text" name="company" maxlength="50" value="#userData[ 'company' ]#" placeholder="Company" aria-label="Company" aria-describedby="company">
                            <input type="hidden" name="accountNumber" value="#userData[ 'accountNumber' ]#" />
                            <input type="hidden" name="validated" value="#userData[ 'validated' ]#" />
                        </div>

                        <div class="input-group">

                            <div class="input-group-prepend">
                                <span class="input-group-text" id="address1"><i class="fab fa-diaspora red"/>&nbsp;&nbsp;Address 1</span>
                            </div>

                            <input class="form-control" type="text" name="address1" maxlength="100" value="#userData[ 'address1' ]#" required placeholder="Address 1" aria-label="Address 1" aria-describedby="Address 1">

                        </div>

                        <div class="input-group">

                            <div class="input-group-prepend">
                                <span class="input-group-text" id="address2">Address 2</span>
                            </div>

                            <input class="form-control" type="text" name="address2" maxlength="100" value="#userData[ 'address2' ]#" placeholder="Address 2" aria-label="Address 2" aria-describedby="Address 2">

                        </div>


                        <div class="input-group">

                            <div class="input-group-prepend">
                                <span class="input-group-text" id="city-state-zip"><i class="fab fa-diaspora red"/>&nbsp;&nbsp;City/State/Zip</span>
                            </div>

                            <input class="form-control" type="text" name="city" maxlength="45" value="#userData[ 'city' ]#" required placeholder="City" aria-label="City" aria-describedby="city" size='170'>
                            <input class="form-control" type="text" name="state" maxlength="2" value="#userData[ 'state' ]#" required placeholder="State" aria-label="State" aria-describedby="state" size='50'>
                            <input class="form-control" type="text" name="zip" maxlength="10" value="#userData[ 'zip' ]#" required placeholder="Zip" aria-label="zip" aria-describedby="zip" size=100>

                        </div>


                        <div class="input-group">

                            <div class="input-group-prepend">
                                <span class="input-group-text" id="phone1"><i class="fab fa-diaspora red"/>&nbsp;&nbsp;Phone 1</span>
                            </div>

                            <input class="form-control" type="text" name="phone1" maxlength="45" value="#userData[ 'phone1' ]#" style="width:170px;display:inline-block;"  required data-validation-required-message='Phone number is required' placeholder="Phone 1"/>
                            <select class="form-control" name="phoneType1" style="width:152px;display:inline-block;">
                             <option value="0" <cfif userData[ 'phoneType1' ] is 0>selected = "selected"</cfif>>Office</option>
                             <option value="1" <cfif userData[ 'phoneType1' ] is 1>selected = "selected"</cfif>>Cell</option>
                             <option value="2" <cfif userData[ 'phoneType1' ] is 2>selected = "selected"</cfif>>Home</option>
                             <option value="3" <cfif userData[ 'phoneType1' ] is 3>selected = "selected"</cfif>>Other</option>
                            </select>

                        </div>

                        <div class="input-group">

                            <div class="input-group-prepend">
                                <span class="input-group-text" id="phone2">Phone 2</span>
                            </div>

                            <input class="form-control" type="text" name="phone2" maxlength="45" value="#userData[ 'phone2' ]#" style="width:170px;display:inline-block;"/>
                            <select class="form-control" name="phoneType2"  style="width:152px;display:inline-block;">
                                <option value="0" <cfif userData[ 'phoneType2' ] is 0>selected = "selected"</cfif>>Office</option>
                                <option value="1" <cfif userData[ 'phoneType2' ] is 1>selected = "selected"</cfif>>Cell</option>
                                <option value="2" <cfif userData[ 'phoneType2' ] is 2>selected = "selected"</cfif>>Home</option>
                                <option value="3" <cfif userData[ 'phoneType2' ] is 3>selected = "selected"</cfif>>Other</option>
                            </select>

                        </div>

                        <input type="hidden" name="mobileServiceID" value="#userData[ 'mobileServiceID' ]#" />

                        <div class="input-group">
    
                            <div class="input-group-prepend">
                                <span class="input-group-text" id="linkedIn">LinkedIn</span>
                            </div>
    
                            <input class="form-control" type="text" name="linkedIn" maxlength="100" value="#userData[ 'linkedIn' ]#" placeholder="LinkedIn" aria-label="LinkedIn" aria-describedby="LinkedIn">                 
    
                        </div>
    
                        <div class="input-group">
                            
                            <div class="input-group-prepend">
                                <span class="input-group-text" id="facebook">Facebook</span>
                            </div>
    
                            <input class="form-control" type="text" name="facebook" maxlength="100" value="#userData[ 'facebook' ]#" placeholder="Facebook" aria-label="Facebook" aria-describedby="Facebook">                 
    
                        </div>
    
                        <div class="input-group">
                            
                            <div class="input-group-prepend">
                                <span class="input-group-text" id="twitter">Twitter</span>
                            </div>
    
                            <input class="form-control" type="text" name="twitter" maxlength="100" value="#userData[ 'twitter' ]#" placeholder="Twitter" aria-label="twitter" aria-describedby="twitter">                 
    
                        </div>

                    </fieldset>

                    <fieldset class="col-xl-6 col-lg-6 col-md-12 col-sm-12 col-12 user-form-fields-grid-2" securityLevel='200'>

                        <cfloop list="#userSecurityTypes#" index='idx'>
                            <cfset VARIABLES.HTMLELEMENTS_UserCrudForms_RENDER___createDropDownForSecurity( userSecurityRoleTypesStruct, idx, userData )>
                        </cfloop>
                     
                    </fieldset>

                    <fieldset class="col-xl-6 col-lg-6 col-md-12 col-sm-12 col-12 user-form-fields-grid-3" securityLevel='200'>

                        <div class="input-group">

                            <div class="input-group-prepend">
                                <label for="locationList" class="input-group-text">Locaton List</label>
                            </div>

                            <input type="checkbox" id="listEmployee" name="listEmployee" data-size="normal" data-toggle="toggle" data-onstyle='theme-slider' data-offstyle='theme-slider' data-on="Yes" data-off="No" <cfif isBoolean( userData[ 'listEmployee' ] ) && userData[ 'listEmployee' ]>checked</cfif> value=1>

                            <select class="form-control" id="locationList" name="employeeLocations" multiple="multiple" style="display:inline-block">
                                <cfloop query="ListOfLocations">
                                    <option value="#establishmentID#" <cfif ListContains(userData[ 'employeeLocations' ], establishmentID)>selected="selected"</cfif>>#name# - #city#, #state#</option>
                                </cfloop>
                            </select>

                        </div>

                        <div class="input-group">
                
                            <div class="input-group-prepend">
                                <label for="locationListWL" class="input-group-text">Customer Associate</label>
                            </div>

                            <input type="checkbox" id="listAssociate" name="listAssociate" data-size="normal" data-toggle="toggle" data-onstyle='theme-slider' data-offstyle='theme-slider' data-on="Yes" data-off="No" <cfif isBoolean( userData[ 'listAssociate' ] ) && userData[ 'listAssociate' ]>checked</cfif> value=1>

                            <select class="form-control" id="locationListWL" name="associateLocations" multiple="multiple" style=" display:inline-block;">
                                <cfloop query="ListOfLocations">
                                    <option value="#establishmentID#" <cfif ListContains(userData[ 'associateLocations' ], establishmentID)>selected="selected"</cfif>>#name# - #city#, #state#</option>
                                </cfloop>
                            </select>

                        </div>

                        <div class="input-group">
                
                            <div class="input-group-prepend">
                                <label for="contactList" class="input-group-text">Location Contact</label>
                            </div>

                            <input type="checkbox" id="listContact" name="listContact" data-size="normal" data-toggle="toggle" data-onstyle='theme-slider' data-offstyle='theme-slider' data-on="Yes" data-off="No" <cfif  isBoolean( userData[ 'listContact' ] ) &&  userData[ 'listContact' ]>checked</cfif> value=1>

                            <select class="form-control" id="contactList" name="contactLocations" multiple="multiple" style="display:inline-block">
                                <cfloop query="ListOfLocations">
                                    <option value="#establishmentID#" <cfif ListContains(userData[ 'contactLocations' ], establishmentID)>selected="selected"</cfif>>#name# - #city#, #state#</option>
                                </cfloop>
                            </select>

                        </div>

                    </fieldset>

                    <fieldset class="col-xl-12 col-lg-12 col-md-12 col-sm-12 col-12 user-form-fields-grid-5" securityLevel='1'>

                        <div class="input-group form-group">
    
                            <div class="input-group-prepend">
                                <label for="publicNotes" class="input-group-text">User Bio</label>
                            </div>

                            <textarea id="publicNotes" class="form-control" name="publicNotes" maxlength="255" rows="5">#userData[ 'publicNotes' ]#</textarea>
                            
                        </div>

                        <div class="input-group form-group">

                            <div class="input-group-prepend">
                                <label for="privatesNotes" class="input-group-text">Private Notes</label>
                            </div>
    
                            <textarea id="privateNotes" class="form-control" name="privateNotes" maxlength="255" rows="5">#userData[ 'privateNotes' ]#</textarea>
    
                        </div>

                    </fieldset>

                    

                    <fieldset class="col-xl-12 col-lg-12 col-md-12 col-sm-12 col-12" securitylevel="1">
                        <input class="btn btn-theme waves-effect waves-light m-r-10" type="submit" value="Save">
                        <button type='button' class="btn btn-theme js-close-sidebar">Cancel</button>
                    </fieldset>

                </form>
                
            </cfoutput>


        </cffunction>

        <!--- --->
        <cffunction name="HTMLELEMENTS_UserCrudForms_RENDER___createDropDownForSecurity" returntype="void" output=true access="PRIVATE" hint="">
            <cfargument name="userSecurityRoleTypes"        type="struct"   required=true>
            <cfargument name="type"                         type="numeric"  required=true>
            <cfargument name="userData"                     type="struct"   required=true>

            <!--- Strings --->
            <cfset idx = ''>

            <!--- Numerics --->
            <cfset i = 1>

            <!--- Structs --->
            <cfset attrStruct = { 
                1: { Label: 'Server',       Name: 'serverSecurity', Id: 'userSecurityServer' },                 
                2: { Label: 'Site',         Name: 'siteSecurity',   Id: 'userSecuritySite' },
                3: { Label: 'Wish List',    Name: 'wlSecurity',     Id: 'userSecurityWL' },
                4: { Label: 'Commerce',     Name: 'eCommSecurity',  Id: 'userSecurityCommerce' },
                5: { Label: 'Contact Type', Name: 'rollSecurity',   Id: 'userSecurityRoll' } 
            }> 

            <cfoutput>

                <div class="input-group form-group">

                    <div class="input-group-prepend">
                        <label class="input-group-text" for="#attrStruct[ type ][ 'name' ]#" <cfif type == 1>securityLevel=255</cfif>>#attrStruct[ type ][ 'label' ]#</label>
                    </div>
                    
                    <select id="#attrStruct[ type ][ 'id' ]#" class="form-control" name="#attrStruct[ type ][ 'name' ]#" multiple role="menu" widget <cfif type == 1>securityLevel=255</cfif> >
                        <cfloop startrow="1" endrow="#userSecurityRoleTypes[ type ].recordCount#" query="#userSecurityRoleTypes[ type ]#">
                            <option value="#userSecurityRoleTypes[ type ].userSecurityId#" <cfif structKeyExists( userData, attrStruct[ type ][ 'Name' ] ) && userData[ attrStruct[ type ][ 'Name' ] ] != ''  && listFindNoCase( userData[ attrStruct[ type ][ 'Name' ] ], userSecurityRoleTypes[ type ].userSecurityId ) >selected</cfif> > #userSecurityRoleTypes[ type ].typeName# -  #userSecurityRoleTypes[ type ].description# </option>
                        </cfloop>
                    </select>

                </div>

            </cfoutput>
            
        </cffunction>

        <!--- --->
        <cffunction name="HTMLELEMENTS_ParseHTMLElementsBySecurityLevels_RENDER" returntype="component" output=true access="PRIVATE" hint="">
            <cfargument name="domData"          type="component"    required=true>
            <cfargument name="domSelector"      type="string"       required=true>
            <cfargument name="securityLevel"    type="numeric"      required=true>
            <cfargument name="action"           type="string"       required=false  default="remove">
            
            <cfscript>

                //arrays
                var elements            = [];

                //structs
                var element             = {};

                //numerics
                var idx                 = 1;

                //booleans
                var doSubElementSearch  = false;

                elements = domData.select( domSelector );

                elements.each(function( element, idx ){
                    if( element.attr('securitylevel') > securityLevel ){
                        domData.select( "*[securitylevel=#element.attr('securitylevel')#]" ).remove();
                    }
                });

                return domData;

            </cfscript>

        </cffunction>


    <!---   **********************************************************************  --->
    <!---   *  HTML ELEMENTS Functions - END                                        --->
    <!---   **********************************************************************  --->


    </cfcomponent>