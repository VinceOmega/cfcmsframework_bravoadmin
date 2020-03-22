<cfcomponent name="sendMailComponents" output=true hint="">

    <!---
        Index
     
    --->

     <!---
        @name: sendMail Components
        @hint:
     --->

      <!---   *********************************************************************************  --->
      <!---   Mail Components                                                                    --->
      <!---   *********************************************************************************  --->

        <!--- ************************************************************ --->
        <!--- ************************************************************ --->

            <!--- Main Components --->

            <cffunction name="SendMail_GenerateEmail_TASK" access="PUBLIC" output=true returntype="void" hint="">
                <cfargument name="EMTo"          type="string"   required=true>
                <cfargument name="EMFrom"        type="string"   required=true>
                <cfargument name="EMSubject"     type="string"   required=true>
                <cfargument name="EMMessage"     type="string"   required=true>
                <cfargument name="EMType"        type="string"   required=true>
                <cfargument name="EMProcess"     type="string"   required=true>
                <cfargument name="EMPassword"    type="string"   required=true>

                <cftry>

                    <!---EMTo, EMFrom, EMSubject, EMMessage, EMType, EMProcess, EMMessage  --->

                    <cfparam name="EMType"      default="html" />
                    <cfparam name="attachPDF"   default="" />
                    <cfparam name="EMBBC"       default="" />

                    <cfif NOT structKeyExists( VARIABLES, 'EMMailCheck') OR EMMailCheck IS NOT session.mailcheck>
                        <cfset sessionCheck = 0 />
                    <cfelse>
                        <cfset sessionCheck = 1 />
                    </cfif>

                    <cfset session.mailCheck=randrange(9999999,99999999) />

                    <cfif sessionCheck is 1>

                        <cfif structKeyExist( APPLICATION, 'getEntryPoint' ) AND structKeyExists( APPLICATION[ 'getEntryPoint' ], 'SCFORWARD' ) AND len( application.getentryPoint.SCFORWARD )>

                            <cfset SendMail_GenerateEmail_TASK___scforwardEnabled( EMTo, EMFrom, EMSubject, EMMessage, EMType, EMProcess, EMMessage )>

                        <cfelse>
                            
                            <cfset SendMail_GenerateEmail_TASK___scforwardDisabled( EMTo, EMFrom, EMSubject, EMMessage, EMType, EMProcess, EMMessage )>

                        </cfif>

                    </cfif>

                    <!---<cfquery name="updateLogEmail" datasource="products">
                    Insert Into logEmail (EMTo,EMFrom,EMSent,EMType,EMEntryPoint,EMSiteName,EMProcess,EMSubject,EMMessage)
                    Values ('#listfirst(EMTo)#','#EMFrom#','#sessionCheck#','#EMType#','#application.entryPoint#','#application.sitefullname#','#EMProcess#','#EMSubject#','#EMMessage#')
                    </cfquery>--->

                    <cfcatch type="any">

                        <cfset var errorStruct              = structNew()>
                        <cfset errorStruct[ 'cfcatch' ]     = cfcatch>
                        <cfset errorStruct[ 'ARGUMENTS' ]   = ARGUMENTS>
                        <cfset errorStruct[ 'VARIABLES' ]   = VARIABLES>

                        <cfdump var="#errorStruct#">

                    </cfcatch>

                </cftry>

                <cfif successMessage>
                    <cfset session.success = "Your request has been forwarded to #EMTo#">
                </cfif>


            </cffunction>

            <!--- Helper Components --->

            <cffunction name="SendMail_GenerateEmail_TASK___scforwardEnabled" access="PRIVATE" output=true returntype="void" hint="">
                <cfargument name="EMTo"          type="string"   required=true>
                <cfargument name="EMFrom"        type="string"   required=true>
                <cfargument name="EMSubject"     type="string"   required=true>
                <cfargument name="EMMessage"     type="string"   required=true>
                <cfargument name="EMType"        type="string"   required=true>
                <cfargument name="EMProcess"     type="string"   required=true>
                <cfargument name="EMPassword"    type="string"   required=true>


                <cftry>

                    <cfparam name="EMReplyTo" default="#application.getentryPoint.SCEMAIL#@site-communication.com" />
                    <cfparam name="EMFrom" default="#application.getentryPoint.SCEMAIL#@site-communication.com" />
                    <cfparam name="EMUserName" default="#application.getentryPoint.SCEMAIL#@site-communication.com" />
                    <cfparam name="EMPassword" default="#application.getentryPoint.SCPASSWORD#" />

                    <cfmail 
                        to="#EMTo#"
                        from="#EMFrom#"
                        replyto="#EMReplyTo#"
                        bcc="#EMBBC#"
                        subject="#EMSubject#"
                        username="#EMUserName#"
                        password="#EMPassword#"
                        server="smtp.gmail.com"
                        port="465" useSSL="true"
                        type="#EMType#"
                    >
                        <cfif attachPDF is not "">
                            <cfmailparam file="#attachPDF#">
                        </cfif>
                        #EMMessage#
                    </cfmail>

                    <cfcatch type="any">

                        <cfset var errorStruct              = structNew()>
                        <cfset errorStruct[ 'cfcatch' ]     = cfcatch>
                        <cfset errorStruct[ 'ARGUMENTS' ]   = ARGUMENTS>
                        <cfset errorStruct[ 'VARIABLES' ]   = VARIABLES>

                        <cfdump var="#errorStruct#">

                    </cfcatch>

                </cftry>

            </cffunction>

            <cffunction name="SendMail_GenerateEmail_TASK___scforwardDisabled" access="PRIVATE" output=true returntype="void" hint="">
                <cfargument name="EMTo"          type="string"   required=true>
                <cfargument name="EMFrom"        type="string"   required=true>
                <cfargument name="EMSubject"     type="string"   required=true>
                <cfargument name="EMMessage"     type="string"   required=true>
                <cfargument name="EMType"        type="string"   required=true>
                <cfargument name="EMProcess"     type="string"   required=true>
                <cfargument name="EMPassword"    type="string"   required=true>


                <cftry>

                    <cfparam name="EMReplyTo" default="#application.siteentrypoint#@myplumbingshowroom.com">
                    <cfparam name="EMFrom" default="#application.siteentrypoint#@myplumbingshowroom.com" />

                    <cfmail 
                        to="#EMTo#" 
                        from="#EMFrom#"
                        bcc="#EMBBC#"
                        replyto="#EMReplyTo#"
                        subject="#EMSubject#"
                        server="cf1.bravoaffiliates.com"
                        port="2523"
                        username="SMTPAccess"
                        password="cF1-SMTP!!*"
                        type="#EMType#"
                    >
                        #EMMessage#
                        <cfif attachPDF is not "">
                            <cfmailparam file="#attachPDF#" />
                        </cfif>

                    </cfmail>

                    <cfcatch type="any">

                        <cfset var errorStruct              = structNew()>
                        <cfset errorStruct[ 'cfcatch' ]     = cfcatch>
                        <cfset errorStruct[ 'ARGUMENTS' ]   = ARGUMENTS>
                        <cfset errorStruct[ 'VARIABLES' ]   = VARIABLES>

                        <cfdump var="#errorStruct#">

                    </cfcatch>

                </cftry>

            </cffunction>

        <!--- ************************************************************ --->
        <!--- ************************************************************ --->


      <!---   ********************************************************************************   --->
      <!---   Mail Components                                                                    --->
      <!---   ********************************************************************************   --->

</cfcomponent>