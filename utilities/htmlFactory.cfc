<cfcomponent name='htmlFactory' output=true hint='Component that generates html'>


    <!---
        /**
        *  Component that generates html
        * 
        *  @author:    Larry Stanfield
        *  @version:   1.0  
        *  @since:     12-05-2019
        *  @see:       https://docs.oracle.com/javase/8/docs/technotes/tools/windows/javadoc.html#CHDJGIJB
        */

        /***
         *  Index
         * 
         *  top Level
         *  
         *  init            : id ASsb96yLP29huGQODzna
         *                
         */

        /**
         * This function initalizes the state of all properties of the class
         * 
         *  @author:    Larry Stanfield
         *  @version:   1.0
         *  @since:     12-05-2019
         */
    --->

    <!--- init (initalization) - ASsb96yLP29huGQODzna --->
    <cffunction name="init" access="public" returntype="struct" hint="">

        <cfreturn this>

    </cffunction>


    <cffunction name="html" access="public" returntype="string" output=true>
        <cfargument name="dataStruct" type="struct" required=true hint="see above">

        <!--- strings --->
        <cfset html = "">

        <cfsavecontent variable='html'>

            <cfoutput>

                <cfset variables.html_generateMarkup( dataStruct )>

            </cfoutput>

        </cfsavecontent>

        <cfreturn html>

    </cffunction>


    <cffunction name="html_generateMarkup" access="private" returntype="void" output=true>
        <cfargument name="dataStruct" type="struct" required=true hint="">

        <!--- strings --->
        <cfset tag = ''>
        <cfset tagAttrs = ''>

        <!--- structs --->
        <cfset tagStruct = {}>


        <!--- numerics --->
        <cfset idx = 0>


        <!--- arrays --->
        <cfset attributesArray = [ ]>



        <cfoutput>

            <cfloop collection="#dataStruct#" item="tag">

                <cfif structKeyExists( dataStruct[ tag ], 'attributes' ) && isStruct( dataStruct[ tag ][ 'attributes' ] ) && structCount( dataStruct[ tag ][ 'attributes' ] )>

                    <cfset attributesArray = structKeyArray( dataStruct[ tag ][ 'attributes' ] )>

                    <cfloop from=1 to=#arrayLen( attributesArray )# index="idx">

                        <cfset tagAttrs = tagAttrs & attributesArray[ idx ] & '=' & dataStruct[ tag ][ 'attributes' ][ attributesArray[ idx ] ]>

                    </cfloop>

                </cfif>

                <cfif structKeyExists( dataStruct[ tag ], 'pair' ) && dataStruct[ tag ][ 'pair' ]>

                    <cfif structKeyExists( dataStruct[ tag ], 'children' ) && isStruct( dataStruct[ tag ][ 'attributes' ] ) && structCount( dataStruct[ tag ][ 'children' ] ) >

                        <#tag# #tagAttrs#>#dataStruct[ tag ][ 'value' ]# #this.html( dataStruct[ tag ][ 'children' ] )#</#tag#>

                    <cfelse>

                        <#tag# #tagAttrs#>#dataStruct[ tag ][ 'value' ]# </#tag#>

                    </cfif>

                <cfelse>

                    <#tag# #tagAttrs#/>

                </cfif>


            </cfloop>

        </cfoutput>

    </cffunction>


</cfcomponent>