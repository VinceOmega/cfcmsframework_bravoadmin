<cfcomponent displayname="" output=true hint="">

	<!--- Index --->
	<!---
	


	--->


	<cffunction name="Analytics_UniqueVisitors_VIEW" access="PUBLIC" output=true returntype="void" hint="">
		<cfargument name="urlData" 	type="struct" 	required=true>
		<cfargument name="debug" 	type="boolean" 	required=false default=false>

		<cfoutput>

		    <div class="card-page card-dashboard-analytics card-outline-info">

                <div class="card-header">

                    <h4 class="m-b-0t text-white">Unique Analytics</h4>

                </div>

                <div class="card-body"> 
                    

					<p>Stats goes here.</p>
					
        
                </div>


            </div>                


		</cfoutput>

	</cffunction>


	<cffunction name="Analytics_OrganicTraffic_VIEW" access="PUBLIC" output=true returntype="void" hint="">
		<cfargument name="urlData" 	type="struct" 	required=true>
		<cfargument name="debug" 	type="boolean" 	required=false default=false>

		<cfoutput>

		    <div class="card-page card-dashboard-analytics card-outline-info">

                <div class="card-header">

                    <h4 class="m-b-0t text-white">OrganicTraffic</h4>

                </div>

                <div class="card-body"> 
                    

					<p>Traffic goes here.</p>
					
        
                </div>


            </div>                


		</cfoutput>

	</cffunction>


</cfcomponent>