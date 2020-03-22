<cfscript>

    lock scope="application" type="exclusive" timeout="5"{

        //Check to see if this is a struct that exists, if not then create it.
        APPLICATION[ 'adminPanel' ] ?: structNew();

        //Admin Panel Logo
        APPLICATION[ 'adminPanel' ][ 'logo' ]                                       = '/img/common/bravo_logo.png';

        //Pre-Defined External Links
        APPLICATION[ 'adminPanel' ][ 'externalLinks' ]                              = structNew();
        APPLICATION[ 'adminPanel' ][ 'externalLinks' ][ 'bravoMarketingSite' ]      = 'https://bravobusinessmedia.com';
        APPLICATION[ 'adminPanel' ][ 'externalLinks' ][ 'myPlumbingShowroom' ]      = 'https://myplumbingshowroom.com';

        //Login Page config
        APPLICATION[ 'adminPanel' ][ 'loginPageConfig' ]                            = structNew();
        APPLICATION[ 'adminPanel' ][ 'loginPageConfig' ][ 'photoCycle' ]            = [ '/img/login/1.jpg', '/img/login/2.jpg', '/img/login/3.jpg', '/img/login/4.jpg'  ];
        APPLICATION[ 'adminPanel' ][ 'loginLayout' ]                                = 'LeftSideBar';

        //Material Theme Resources
        APPLICATION[ 'adminPanel' ][ 'Theme' ]                                      = structNew();
        APPLICATION[ 'adminPanel' ][ 'Theme' ][ 'Material' ]                        = structNew();
        APPLICATION[ 'adminPanel' ][ 'Theme' ][ 'Material' ][ 'Assets' ]            = '/templates/vendors/material-pro/assets/';
        APPLICATION[ 'adminPanel' ][ 'Theme' ][ 'Material' ][ 'CSS' ]               = '/templates/vendors/material-pro/css/';
        APPLICATION[ 'adminPanel' ][ 'Theme' ][ 'Material' ][ 'JS' ]                = '/templates/vendors/material-pro/js/';
        APPLICATION[ 'adminPanel' ][ 'Theme' ][ 'Material' ][ 'SCSS' ]              = '/templates/vendors/material-pro/scss/';

        /********************************************************************************************************************/

        //structClear(application)
		APPLICATION[ 'EntryPoint' ]                         = this.VTappInstallProjectEntryPoint;
		APPLICATION[ 'SolrPair' ] 							= '1,2';
        APPLICATION[ 'ScriptsDirectory' ]                   = 'Scripts/';
        APPLICATION[ 'MainDatabase' ]                       = 'SRLighting';
        APPLICATION[ 'ProductsDatabase' ]                   = 'Products';
        APPLICATION[ 'zIndexDatabase' ]                     = "zindex";
        APPLICATION[ 'InstallationType' ]                   = 0 ;
        APPLICATION[ 'CustomScriptsCFMappingDirectory' ]    = '/CustomScriptsBravo/' ;
        APPLICATION[ 'GetEntryPoint' ]                    	= this.configComponentsForAppVars.getEntryPoint();
        
        /********************************************************************************************************************/
        querySetCell( APPLICATION[ 'GetEntryPoint' ],"localDNS","http://#this.appName#.BravoAdmin#application.serverID#.com/");
        /********************************************************************************************************************/

        APPLICATION[ 'metaInfo' ]                           this.configComponentsForAppVars.getAppMetaInfo();
		APPLICATION[ 'customPricingActive' ] 				= 0;
		
		/*******************************************************************************************************************/

		//Is Special Pricing active
		for( i=1; i<=10; i++ ){
			APPLICATION[ 'customPricingActive' ] = ( !APPLICATION[ 'customPricingActive' ] && evaluate( '#APPLICATION[ 'EntryPointQuery' ]#.cpActive#i#') ) ? 1 : APPLICATION[ 'customPricingActive' ];
		}

		/*******************************************************************************************************************/
		//Establish all application variables
		APPLICATION[ 'EstablishmentDetail' ] 				= this.configComponentsForAppVars.getEstablishmentDetail();
		APPLICATION[ 'Establishment' ] 						= this.configComponentsForAppVars.getEstablishment();
		APPLICATION[ 'zStateCodes' ] 						= this.configComponentsForAppVars.getZStateCodes();
		APPLICATION[ 'USStateCodes' ] 						= this.configComponentsForAppVars.getUSStateCodes();
		APPLICATION[ 'FeatBrands' ] 						= this.configComponentsForAppVars.getFeatBrands();
		APPLICATION[ 'featuresBrandList' ] 					= valueList( APPLICATION[ 'FeatBrands' ].brandCode );
		APPLICATION[ 'PrivateBrands' ] 						= this.configComponentsForAppVars.getPrivateBrands();
		APPLICATION[ 'privateBrandList' ] 					= valueList( APPLICATION[ 'PrivateBrands' ].brandCode );
		APPLICATION[ 'SiteBrands' ] 						= this.configComponentsForAppVars.getSiteBrands();
   		APPLICATION[ 'siteBrandList' ] 						= APPLICATION[ 'SiteBrands' ].brandIDs;
   		APPLICATION[ 'siteBrandCount' ] 					= APPLICATION[ 'SiteBrands' ].bcount;
		APPLICATION[ 'siteSetupAgents' ] 					= this.configComponentsForAppVars.getSiteSetupAgents();
		APPLICATION[ 'siteEmailWLNotificationQuery' ] 		= this.configComponentsForAppVars.getWLNotificationList();
		APPLICATION[ 'siteEmailWLNotification' ] 			= APPLICATION[ 'siteEmailWLNotificationQuery' ].email;
		APPLICATION[ 'userNotificationListQuery' ] 			= this.configComponentsForAppVars.GetUserNotificationList();
		APPLICATION[ 'siteUserNotification' ] 				= APPLICATION[ 'userNotificationListQuery' ].email;
		APPLICATION[ 'siteEmailECommerceBCCQuery' ] 		= this.configComponentsForAppVars.getEcommerceEmailTo();
		APPLICATION[ 'siteEmailECommerceBCC' ] 				= APPLICATION[ 'siteEmailECommerceBCCQuery' ].email;
		APPLICATION[ 'questionEmailToQuery' ] 				= this.configComponentsForAppVars.getQuesitonEmailTo();
		APPLICATION[ 'siteEmailQuestions' ] 				= APPLICATION[ 'questionEmailToQuery' ].email();
		APPLICATION[ 'stateToTaxQuery' ] 					= this.configComponentsForAppVars.getStatesToTax();
		APPLICATION[ 'siteEcommerceTaxedStates' ] 			= APPLICATION[ 'stateToTaxQuery' ].states;
		APPLICATION[ 'getLocationAssignments' ] 			= this.configComponentsForAppVars.getLocationAssignments();
		APPLICATION[ 'getWLAssignments' ] 					= this.configComponentsForAppVars.getWLAssignments();
		APPLICATION[ 'getContactAssignments' ] 				= this.configComponentsForAppVars.getContactAssignments();
		APPLICATION[ 'siteLocations' ] 						= this.configComponentsForAppVars.getSiteLocations();
		APPLICATION[ 'siteLocation0' ] 						= this.configComponentsForAppVars.getSiteLocationZero();
		APPLICATION[ 'getSiteLocationZero' ] 				= this.configComponentsForAppVars.getSiteLocationZero();
		APPLICATION[ 'siteLocationsWL' ] 					= this.configComponentsForAppVars.getSiteLocatoinsWL();
		APPLICATION[ 'getSiteFeatures' ]					= this.configComponentsForAppVars.getSiteFeatures();
		APPLICATION[ 'siteID' ] 							= this.VTappInstallProjectEntryPoint ;
		APPLICATION[ 'getEntryPoint' ] 						= APPLICATION[ 'GetEntryPoint' ] ;
		APPLICATION[ 'isMobile' ] 							= APPLICATION[ 'GetEntryPoint' ].mobileYN ;
		APPLICATION[ 'siteEntryPoint' ] 					= APPLICATION[ 'GetEntryPoint' ].entryPointAbbrev ;
		APPLICATION[ 'siteActive' ] 						= APPLICATION[ 'GetEntryPoint' ].activeYN ;
		APPLICATION[ 'siteIndex' ] 							= APPLICATION[ 'GetEntryPoint' ].indexYN ;
		APPLICATION[ 'siteSolrCore' ] 						= APPLICATION[ 'GetEntryPoint' ].solrCore ;
		APPLICATION[ 'siteSolrServer' ] 					= APPLICATION[ 'GetEntryPoint' ].solrServer ;
		APPLICATION[ 'siteSolrSetup' ] 						= APPLICATION[ 'GetEntryPoint' ].solrSetupYN;
		APPLICATION[ 'siteType' ] 							= APPLICATION[ 'GetEntryPoint' ].SiteType ;
		APPLICATION[ 'siteName' ] 							= APPLICATION[ 'GetEntryPoint' ].entryPointName ;
		APPLICATION[ 'siteFullName' ] 						= APPLICATION[ 'GetEntryPoint' ].entryPointName ;
		APPLICATION[ 'siteLocationPlace' ] 					= APPLICATION[ 'GetEntryPoint' ].siteLocationPlace ;
		APPLICATION[ 'sitePhone' ] 							= APPLICATION[ 'GetEntryPoint' ].EstablishmentDetailContactPhone ;
		APPLICATION[ 'sitePhone800' ] 						= APPLICATION[ 'GetEntryPoint' ].EstablishmentDetailContactPhone ;
		APPLICATION[ 'siteEmail' ] 							= APPLICATION[ 'GetEntryPoint' ].establishmentEmail ;
		APPLICATION[ 'siteLocalURL' ] 						= APPLICATION[ 'GetEntryPoint' ].localURL ;
		APPLICATION[ 'siteGlobalURL' ] 						= APPLICATION[ 'GetEntryPoint' ].globalURL ;
		APPLICATION[ 'siteEcommerce' ] 						= APPLICATION[ 'GetEntryPoint' ].ecommerceYN ;
		APPLICATION[ 'sitePExpress' ] 						= APPLICATION[ 'GetEntryPoint' ].pExpressYN ;
		APPLICATION[ 'siteWishLists' ] 						= APPLICATION[ 'GetEntryPoint' ].wishListsYN ;
		APPLICATION[ 'siteCustomProducts' ] 				= APPLICATION[ 'GetEntryPoint' ].customYN ;
		APPLICATION[ 'siteCompare' ] 						= APPLICATION[ 'GetEntryPoint' ].compareYN ;
		APPLICATION[ 'sitePricing' ] 						= APPLICATION[ 'GetEntryPoint' ].priceYN ;
		APPLICATION[ 'showPriceTo' ] 						= APPLICATION[ 'GetEntryPoint' ].showPriceTo ;
		APPLICATION[ 'siteBrands' ] 						= APPLICATION[ 'GetEntryPoint' ].brandsYN ;
		APPLICATION[ 'siteDocuments' ] 						= APPLICATION[ 'GetEntryPoint' ].showDocumentsYN ;
		APPLICATION[ 'siteUseProductLink' ] 				= APPLICATION[ 'GetEntryPoint' ].UseProductLink ;
		APPLICATION[ 'siteAvailability' ] 					= APPLICATION[ 'GetEntryPoint' ].availabilityYN ;
		APPLICATION[ 'siteTheme' ] 							= APPLICATION[ 'GetEntryPoint' ].siteTheme ;
		APPLICATION[ 'siteStyleSheet' ] 					= APPLICATION[ 'GetEntryPoint' ].siteStylesheet ;
		APPLICATION[ 'siteSEOTitle' ] 						= APPLICATION[ 'GetEntryPoint' ].seoSiteTitle ;
		APPLICATION[ 'siteSEODescription' ] 				= APPLICATION[ 'GetEntryPoint' ].seoSiteDescription ;
		APPLICATION[ 'siteSEOKeywords' ] 					= APPLICATION[ 'GetEntryPoint' ].seoSiteKeywords ;
		APPLICATION[ 'siteSEOComment' ] 					= APPLICATION[ 'GetEntryPoint' ].seoSitecomment ;
		APPLICATION[ 'siteLocationStatement' ] 				= APPLICATION[ 'GetEntryPoint' ].siteLocationStatement ;
		APPLICATION[ 'MPSSupportEmail' ] 					= "storeSupport@MyPlumbingShowroom.com" ;
		APPLICATION[ 'GoogleAnalytics' ] 					= APPLICATION[ 'GetEntryPoint' ].analyticsCode ;
		APPLICATION[ 'WebmasterCode' ] 						= APPLICATION[ 'GetEntryPoint' ].WebmasterCode ;
		APPLICATION[ 'siteBingWebmaster' ] 					= APPLICATION[ 'GetEntryPoint' ].BingWebmaster ;
		APPLICATION[ 'sitePintrestCode' ] 					= APPLICATION[ 'GetEntryPoint' ].PintrestCode ;
		APPLICATION[ 'siteWLName' ] 						= APPLICATION[ 'GetEntryPoint' ].wlName ;
		APPLICATION[ 'site' ] 								= APPLICATION[ 'GetEntryPoint' ].site ;
		APPLICATION[ 'siteDescription' ] 					= APPLICATION[ 'GetEntryPoint' ].siteDescription ;
		APPLICATION[ 'siteFreeShippingAmount' ] 			= APPLICATION[ 'GetEntryPoint' ].establishmentDetailFreeShippingAmount ;
		APPLICATION[ 'siteOversizedShippingAmount' ] 		= APPLICATION[ 'GetEntryPoint' ].establishmentDetailOversizedShippingAmount ;
		APPLICATION[ 'siteOversizedFreeShippingAmount' ] 	= APPLICATION[ 'GetEntryPoint' ].establishmentDetailOversizedFreeShippingAmount ;
		APPLICATION[ 'zIndex' ] 							= "zIndex_#APPLICATION[ 'GetEntryPoint' ].solrCore#";
		APPLICATION[ 'siteMSAStatement' ] 					= APPLICATION[ 'GetEntryPoint' ].siteMSAStatement ;
		APPLICATION[ 'siteBrandTypes' ] 					= APPLICATION[ 'GetEntryPoint' ].showBrandType;
		APPLICATION[ 'siteShowFC' ] 						= APPLICATION[ 'GetEntryPoint' ].showfcY;
		APPLICATION[ 'siteTemplate' ] 						= APPLICATION[ 'GetEntryPoint' ].siteTemplat;
		APPLICATION[ 'siteSearchTemplate' ] 				= APPLICATION[ 'GetEntryPoint' ].searchTemplat;
		APPLICATION[ 'siteDetailTemplate' ] 				= APPLICATION[ 'GetEntryPoint' ].detailTemplat;
		APPLICATION[ 'sitePNSearch' ] 						= APPLICATION[ 'GetEntryPoint' ].PNSearc;
		APPLICATION[ 'sitePNDetail' ] 						= APPLICATION[ 'GetEntryPoint' ].PNDetai;
		APPLICATION[ 'sitePNCompare' ] 						= APPLICATION[ 'GetEntryPoint' ].PNCompar;
		APPLICATION[ 'sitePNWL' ] 							= APPLICATION[ 'GetEntryPoint' ].PNW;
		APPLICATION[ 'siteBRSearch' ] 						= APPLICATION[ 'GetEntryPoint' ].BRSearc;
		APPLICATION[ 'siteBRDetail' ] 						= APPLICATION[ 'GetEntryPoint' ].BRDetai;
		APPLICATION[ 'siteBRCompare' ] 						= APPLICATION[ 'GetEntryPoint' ].BRCompar;
		APPLICATION[ 'siteBRWL' ] 							= APPLICATION[ 'GetEntryPoint' ].BRW;
		APPLICATION[ 'siteLIWL' ] 							= APPLICATION[ 'GetEntryPoint' ].LIW;
		APPLICATION[ 'siteMSRPWL' ] 						= APPLICATION[ 'GetEntryPoint' ].MSRPW;
		APPLICATION[ 'sitePriceLabel' ] 					= APPLICATION[ 'GetEntryPoint' ].PriceLabe;
		APPLICATION[ 'sitePriceNote' ] 						= APPLICATION[ 'GetEntryPoint' ].PriceNot;
		APPLICATION[ 'siteLocationLink' ] 					= APPLICATION[ 'GetEntryPoint' ].siteLocationLin;
		APPLICATION[ 'siteLocationRadius' ] 				= APPLICATION[ 'GetEntryPoint' ].LocationRadiu;
		APPLICATION[ 'siteContactButtonYN' ] 				= APPLICATION[ 'GetEntryPoint' ].contactButtonY;
		APPLICATION[ 'siteContactLocationsYN' ] 			= APPLICATION[ 'GetEntryPoint' ].contactLocationsYN;
		APPLICATION[ 'siteContactButton' ] 					= APPLICATION[ 'GetEntryPoint' ].contactButto;
		APPLICATION[ 'siteContactText' ] 					= APPLICATION[ 'GetEntryPoint' ].contactTex;
		APPLICATION[ 'siteContactInformation' ] 			= APPLICATION[ 'GetEntryPoint' ].siteContactInformation ;
		APPLICATION[ 'siteContactQuestions' ] 				= APPLICATION[ 'GetEntryPoint' ].siteContactQuestions ;
		APPLICATION[ 'onSaleName' ] 						= APPLICATION[ 'GetEntryPoint' ].onSaleName ;
		APPLICATION[ 'onDisplayName' ] 						= APPLICATION[ 'GetEntryPoint' ].onDisplayName ;
		APPLICATION[ 'onStockName' ] 						= APPLICATION[ 'GetEntryPoint' ].onStockName ;
		APPLICATION[ 'onFeaturedName' ] 					= APPLICATION[ 'GetEntryPoint' ].onFeaturedName ;
		APPLICATION[ 'onCustomName1' ] 						= APPLICATION[ 'GetEntryPoint' ].onCustomName1 ;
		APPLICATION[ 'onCustomName2' ] 						= APPLICATION[ 'GetEntryPoint' ].onCustomName2 ;
		APPLICATION[ 'onCustomName3' ] 						= APPLICATION[ 'GetEntryPoint' ].onCustomName3 ;
		APPLICATION[ 'onSaleSFS' ] 							= APPLICATION[ 'GetEntryPoint' ].onSaleSFS ;
		APPLICATION[ 'onDisplaySFS' ] 						= APPLICATION[ 'GetEntryPoint' ].onDisplaySFS ;
		APPLICATION[ 'onStockSFS' ] 						= APPLICATION[ 'GetEntryPoint' ].onStockSFS ;
		APPLICATION[ 'onFeaturedSFS' ] 						= APPLICATION[ 'GetEntryPoint' ].onFeaturedSFS ;
		APPLICATION[ 'onCustom1SFS' ] 						= APPLICATION[ 'GetEntryPoint' ].onCustom1SFS ;
		APPLICATION[ 'onCustom2SFS' ] 						= APPLICATION[ 'GetEntryPoint' ].onCustom2SFS ;
		APPLICATION[ 'onCustom3SFS' ] 						= APPLICATION[ 'GetEntryPoint' ].onCustom3SFS ;
		APPLICATION[ 'onSaleSFD' ] 							= APPLICATION[ 'GetEntryPoint' ].onSaleSFD ;
		APPLICATION[ 'onDisplaySFD' ] 						= APPLICATION[ 'GetEntryPoint' ].onDisplaySFD ;
		APPLICATION[ 'onStockSFD' ] 						= APPLICATION[ 'GetEntryPoint' ].onStockSFD ;
		APPLICATION[ 'onFeaturedSFD' ] 						= APPLICATION[ 'GetEntryPoint' ].onFeaturedSFD ;
		APPLICATION[ 'onCustom1SFD' ] 						= APPLICATION[ 'GetEntryPoint' ].onCustom1SFD ;
		APPLICATION[ 'onCustom2SFD' ] 						= APPLICATION[ 'GetEntryPoint' ].onCustom2SFD ;
		APPLICATION[ 'onCustom3SFD' ] 						= APPLICATION[ 'GetEntryPoint' ].onCustom3SFD ;
		APPLICATION[ 'siteLocalImages' ] 					= "C:\Web\Bravo\#APPLICATION[ 'GetEntryPoint' ].localURL#\localSite\images\" ;
		APPLICATION[ 'siteGlobalImages' ] 					= "C:\Web\productImages\assets\images\" ;
		APPLICATION[ 'siteDiscountYN' ] 					= APPLICATION[ 'GetEntryPoint' ].siteDiscountYN ;
		APPLICATION[ 'siteDiscountID' ] 					= APPLICATION[ 'GetEntryPoint' ].siteDiscountID ;
		APPLICATION[ 'siteOrderEmail' ] 					= APPLICATION[ 'GetLocationZero' ].email ;
		APPLICATION[ 'siteOrderName' ] 						= APPLICATION[ 'GetLocationZero' ].siteName ;
		APPLICATION[ 'siteOrderAddress1' ] 					= APPLICATION[ 'GetLocationZero' ].Address1 ;
		APPLICATION[ 'siteOrderAddress2' ] 					= APPLICATION[ 'GetLocationZero' ].Address2 ;
		APPLICATION[ 'siteOrderCity' ] 						= APPLICATION[ 'GetLocationZero' ].City;
		APPLICATION[ 'siteOrderState' ] 					= APPLICATION[ 'GetLocationZero' ].State;
		APPLICATION[ 'siteOrderZip' ] 						= APPLICATION[ 'GetLocationZero' ].Zip;
		APPLICATION[ 'wlDuplicateProductButtonTitle' ] 		= "Product listed multiple times, click to go to #APPLICATION[ 'siteWLName' ]# to modify!";
		/***********************************************************************************************************************************************/
		APPLICATION[ 'siteMSA' ] 	=  ( APPLICATION[ 'GetEntryPoint' ].siteMSALink == "" ) ?  '/'  : ( "/" & APPLICATION[ 'GetEntryPoint' ].siteMSALink & "/" );
        /***********************************************************************************************************************************************/
        //Solr Sorting Variables Set Start
        APPLICATION[ 'sortSolr' ] 	= this.configComponentsForAppVars.setSolrSortValue( APPLICATION[ 'GetEntryPoint' ] );
		/***********************************************************************************************************************************************/
        //application.securityLevel values
        APPLICATION[ 'securityLevels' ] = structNew();
        structInsert(APPLICATION[ 'securityLevels' ],"1","Public");
        structInsert(APPLICATION[ 'securityLevels' ],"50","Logged In");
        structInsert(APPLICATION[ 'securityLevels' ],"100","Special Pricing");
        structInsert(APPLICATION[ 'securityLevels' ],"200","Site / Employee");
		structInsert(APPLICATION[ 'securityLevels' ],"255","No One");
		/***********************************************************************************************************************************************/
		APPLICATION[ 'getSpexBuilderSettings' ] 			= this.configComponentsForAppVars.getSpexBuilderSettings();
        //Email to Text Message extensions
        APPLICATION[ 'mobileServices' ] 					= this.configComponentsForAppVars.getMobileServices();
		/***********************************************************************************************************************************************/
        //Brand Types
		APPLICATION[ 'brandTypes' ] 						= QueryNew("brandTypeID,brandTypeName,siteFieldName,brandFieldName");
		/***********************************************************************************************************************************************/
        QueryAddRow(APPLICATION[ 'brandTypes' ],5);
        QuerySetCell(APPLICATION[ 'brandTypes' ], "brandTypeID", 1, 1);
        QuerySetCell(APPLICATION[ 'brandTypes' ], "brandTypeName", "Lighting", 1);
        QuerySetCell(APPLICATION[ 'brandTypes' ], "siteFieldName", "showLightingBrands", 1);
        QuerySetCell(APPLICATION[ 'brandTypes' ], "brandFieldName", "lightingBrandYN", 1);
        QuerySetCell(APPLICATION[ 'brandTypes' ], "brandTypeID", 2, 2);
        QuerySetCell(APPLICATION[ 'brandTypes' ], "brandTypeName", "Plumbing", 2);
        QuerySetCell(APPLICATION[ 'brandTypes' ], "siteFieldName", "showPlumbingBrands", 2);
        QuerySetCell(APPLICATION[ 'brandTypes' ], "brandFieldName", "plumbingBrandYN", 2);
        QuerySetCell(APPLICATION[ 'brandTypes' ], "brandTypeID", 3, 3);
        QuerySetCell(APPLICATION[ 'brandTypes' ], "brandTypeName", "Hearth & Home", 3);
        QuerySetCell(APPLICATION[ 'brandTypes' ], "siteFieldName", "showHearthBrands", 3);
        QuerySetCell(APPLICATION[ 'brandTypes' ], "brandFieldName", "hearthBrandYN", 3);
        QuerySetCell(APPLICATION[ 'brandTypes' ], "brandTypeID", 4, 4);
        QuerySetCell(APPLICATION[ 'brandTypes' ], "brandTypeName", "Appliances", 4);
        QuerySetCell(APPLICATION[ 'brandTypes' ], "siteFieldName", "showApplianceBrands", 4);
        QuerySetCell(APPLICATION[ 'brandTypes' ], "brandFieldName", "applianceBrandYN", 4);
        QuerySetCell(APPLICATION[ 'brandTypes' ], "brandTypeID", 5, 5);
        QuerySetCell(APPLICATION[ 'brandTypes' ], "brandTypeName", "Hardware", 5);
        QuerySetCell(APPLICATION[ 'brandTypes' ], "siteFieldName", "showHardwareBrands", 5);
        QuerySetCell(APPLICATION[ 'brandTypes' ], "brandFieldName", "hardwareBrandYN", 5);
		/************************************************************************************************************************************************/
        APPLICATION[ 'finishGroupImages' ] = this.configComponentsForAppVars.getFinishGroups( APPLICATION[ 'finishGroupImages' ] );
        /************************************************************************************************************************************************/
        //absolutely nothing should appear below the following tag
        APPLICATION[ 'ApplicationVariablesOK' ] = "True";
        APPLICATION[ 'ApplicationVariablesBuiltWhen' ] = Now();
        APPLICATION[ 'ApplicationVariablesBuiltWhen' ] = Application.ApplicationVariablesBuiltWhen;
        APPLICATION[ 'MainAppVarsRebuilt' ] = "True";

    }

</cfscript>