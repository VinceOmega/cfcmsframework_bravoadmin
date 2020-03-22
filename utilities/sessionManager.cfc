component displayName="sessionManager" output=true hint="" {



	/**
	*
	*
	**/

	// *********************************************************
	// * Session Manager - START 
	// *********************************************************

		/**
		*
		*
		**/

        //  **********************************************************************
        //  **********************************************************************

        	// MAIN FUNCTIONS 

        		public void function SessionManager_CreateUserSession_TASK( required query userData ){

					//structs
					var resultStruct = {};

					if( userData.recordCount ){

						//Are you logging in while logged in? Give the user a brand new session.
						if( session.login.loggedIn ){

							this.SessionManager_DestoryUserSession_TASK();

						}
					
							session.adminPanel.user.loggedIn 	= true;
							session.login.loggedIn 				= true;
							session.login.signupDate 			= userData.createDate;
							session.login.guest 				= false;
							session.login.userid 				= userData.userid;
							session.login.email 				= userData.email;
							session.login.fName 				= userData.fname;
							session.login.lName 				= userData.lname; 
							session.login.address1 				= userData.address1;
							session.login.address2 				= userData.address2;
							session.login.city 					= userData.city;
							session.login.state 				= userData.state;
							session.login.zip 					= userData.zip;
							session.login.phone 				= userData.phone1;
							session.login.company 				= userData.company;
							session.login.account 				= userData.accountNumber;
							session.login.passwordPrivate 		= userData.passwordPrivate;
							session.login.validated 			= userData.validated;
							session.login.userType 				= userData.userType;
							session.adminPanel.user.ownedSites 	= userData.recordCount;
							session.login.numsites 				= userData.recordCount;
			
							session.login.pricingLevel 			= ( application.siteID == 251 && userLogin.pricingLevel == 0 && application.getEntryPoint.cpActive10 == 1 ) ? 10 : userData.pricingLevel;
							session.login.securityLevel 		= application.securityRoles[ userData.userType ]?: 0;
			
							session.login.securityServer 		= userData.serverSecurity;
							session.login.securityContact 		= userData.rollSecurity;
							session.login.securitySite 			= userData.siteSecurity;
							session.login.securityWishList 		= userData.wlSecurity;
							session.login.securityCommerce 		= userData.ecommSecurity;
							session.login.showAdminLink 		= false;

							resultStruct = variables.SessionManager_CreateUserSession_TASK___getUserData( userData.email );

							if( resultStruct.result.recordCount == 1 ){

								this.SessionManager_SetSite_TASK( resultStruct.result.entryPointCode, resultStruct.result.EstablishmentFullName, resultStruct.result.recordCount  );

							}
			
							if( listFindNoCase( userData.userType, "admin" ) or ( listFindNoCase( userData.userType, "site" ) and !application.siteID is 496 ) ){
			
								 session.login.showAdminLink 	= true;
								 session.login.adminLink 		= application.errorPanel.components.utility.strings.Strings_GeneratePageHref_TASK( 'dashboard' );
								 session.login.adminLinkName 	= "Site Administration";
			
							} else if( listFindNoCase( userData.userType, "special") && userData.pricingLevel > 0 ){
			
								 session.login.adminLink 		= Evaluate( "application.getentrypoint.cpLoginLink#userData.pricingLevel#" );
								 session.login.adminLinkName 	= Evaluate( "application.getentrypoint.cpName#userData.pricingLevel#" );
			
							}else{
			
								 session.login.adminLink 		= "";
								 session.login.adminLinkName 	= "";
			
							}
			
					} else {
			
						//session.warning = application.t9n[ session.languageID ].tr_loginFailedWarning;
						session.warning = 'Incorrect username/password, please try again.';
			
						if( structKeyExists( userData, 'wlProductID' ) && userData.wlProductID != '' ){
							
							location( url=application.errorPanel.components.utility.strings.Strings_GeneratePageHref_TASK( 'signin', 'WLProductID=' & userData.wlProductID & 'loginType=login' ), addtoken=false );
			
						} else {
			
							location( url=application.errorPanel.components.utility.strings.Strings_GeneratePageHref_TASK( 'signin' ), addtoken=false );
			
						}
			
					}

				}

		// 	************************************************************************

			// HELPER FUNCTIONS

			public struct function SessionManager_CreateUserSession_TASK___getUserData( required string email ){

				try{

					//Queries
					var result          = queryNew( '' );
	
					//Structs
					var metaData        = {};
					var resultStruct    = {};
	
					//Booleans
					var success         = false;
	
	
					result = queryExecute(
						"   
							SELECT DISTINCT e.entryPointCode, eep.EstablishmentFullName, eep.EstablishmentCity, eep.EstablishmentState, eep.EstablishmentPhone
								FROM entrypoints e
									JOIN establishments eep ON eep.establishmentEntryPoint = e.entrypointCode
								WHERE eep.establishmentType = 'L'
									AND eep.establishmentKey = 0
									AND e.entryPointCode IN (
										SELECT DISTINCT u.siteID
												FROM users u
												JOIN users u2 ON u.email = u2.email AND u.password = u2.password
												WHERE u.email = :email
												AND u.userType = 'Site'
												ORDER BY u.siteID
									)
						"
						,
						{ 
							email = { value=trim( email ) , cfsqltype='cf_sql_varchar' }
						},
						{
	
							datasource  = application.mainDatabase,
							result      = "metaData"
	
						}
	
					);
	
					success = true;
	
				} catch( any e ){
	
					var errorStruct             = structNew();
					errorStruct[ 'cfcatch' ]    = e;
					errorStruct[ 'metaData' ]   = metaData;
					errorStruct[ 'arguments' ]  = arguments;
					errorStruct[ 'success' ]    = success;
	
				}
	
				resultStruct[ 'success' ]       = success?: false;
				resultStruct[ 'result' ]        = result?: queryNew( '' );
				resultStruct[ 'errors' ]        = errorStruct?: {};
	
				return resultStruct;

			}
				
		// 	************************************************************************
		// 	************************************************************************

		// 	************************************************************************
		// 	************************************************************************


				public void function SessionManager_SetSite_TASK( required numeric siteID, required string siteName, required numeric recordCount ){

					lock scope="Session" timeout="5" type="exclusive"{

						session.adminPanel.user.site 		= siteID;
						session.login.siteID 				= siteID;
						session.adminPanel.user.siteName 	= siteName;
						session.login.entryPoint 			= siteName;
						session.adminPanel.user.ownedSites	= recordCount;
						session.login.ownedSites 			= recordCount;

					}

				}

		// 	*********************************************************************
		// 	*********************************************************************

				public void function SessionManager_DestoryUserSession_TASK(){

					//Structs
					var app = {};

					//Strings
					var key = '';

					request.mobileStatus = session.mobileStatus;
					request.languageID = session.languageID;

					lock scope="Session" timeout="10" type="exclusive"{
						structclear(session);
					}

					app = createObject( 'component', 'Application' );

					app.onSessionStart();

					session.cfid = cookie.cfid;
					session.cftoken = cookie.cftoken;
					session.sessionid = app.name & '_' & cookie.cfid & '_' & cookie.cftoken;

					for( key in cookie ){

						cookie[ key ] = { value="", expires="now" };

					}

					translatePage = 'appMPS';

					include '/mpsScripts/TranslateFrench.cfm';

					session.mobileStatus = request.mobileStatus;
					session.languageID = request.languageID;
					
					session.growl.message 	= tr_Logout_message;
					session.growl.status 	= 'success';

				}

		// 	***********************************************************************
		// 	***********************************************************************



	//**********************************************************
	//* Session Manager - END
	//**********************************************************

}