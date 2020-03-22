component displayname="AnalyticsController" output=true hint=""{
	

	//JavaDoc
	/**
	*
	**/

	//Index for file ( 387485fherjerj - function name )
	/*
	* 
	*
	*/

this.metaData           = {};
this.metaData.analytics = {};

	/**************************************************************
	/* Unique Visitors - START
	/*************************************************************/

		//MAIN FUNCTION

		public void function Analytics_UniqueVisitors_RETRIEVE( required struct urlData, boolean debug ){

			try{


				application.adminPanel.components.site.views.analytics.Analytics_UniqueVisitors_VIEW( urlData );


			} catch( any e ){

				var errorStruct 			= {};
				errorStruct[ 'cfcatch' ] 	= e;
				errorStruct[ 'arguments' ] 	= arguments;

				writeDump( errorStruct );

			}

		}


	/**************************************************************
	/* Unique Visitors - END
	/*************************************************************/


	/*************************************************************/
	/* Organic Traffic - START
	/*************************************************************/

		//MAIN FUNCTION

		public void function Analytics_OrganicTraffic_RETRIEVE( required struct urlData, boolean debug ){

			try{


				application.adminPanel.components.site.views.analytics.Analytics_OrganicTraffic_VIEW( urlData );


			} catch( any e ){

				var errorStruct 			= {};
				errorStruct[ 'cfcatch' ] 	= e;
				errorStruct[ 'arguments' ] 	= arguments;

				writeDump( errorStruct );

			}

		}


	/*************************************************************/
	/* Organic Traffic - END
	/*************************************************************/

}