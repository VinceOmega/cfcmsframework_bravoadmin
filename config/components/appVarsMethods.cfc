component displayName="" output=true hint="" {

    /*******
     * 
     * 
     * 
     * 
     * 
     * 
     * ****/
     

    //    **********************************************************************
    //    *  App Vars Functions - START
    //    * ********************************************************************

        public boolean function resetAppVarsFlag(){

            //Queries
			var result = queryNew( '' );
			
			//Struct
			var metaData = structNew();

            transaction{
            
                try{

                    result = queryExecute( 
                        "
                            UPDATE siteReset
                                SET cfserver cf#application.serverID# = 0
                            WHERE siteID = :siteID
                        ",
                        {
                            siteID  = { value=application.VTappInstallProjectEntryPoint, cfsqltype="cf_sql_integer" }
                        },
                        {
							datasource = application.MainDatabase,
							result = "metaData"
                        }
                    );

                    transaction action='commit';

                } catch( any e ){

                    transaction action='rollback';

                    writeDump( e );

                    return false;

                }

            }

            return true;

        }
        
        public boolean function checkAgainstAppVarsFlagRebuild(){

            //Queries
			var result = queryNew( '' );
			
			//Structs
			var metaData = {};

            //Strings
			var theOtherServers = '';
			var thisServer 		= '';

            transaction{

                try{

                    //Is this a single site / single server rebuild?
                    if( isDefined( url.updateApplicationVariables ) ){
                        //Which is the 'other' server?
                        if( serverID is 1 ){
                
                            theOtherServers = "2,3";
                
                        } else if( serverID is 2 ){
                
                            theOtherServers = "1,3";
                
                        } else {
                
                            theOtherServers = "1,2";

                        }
                                
                        for( thisServer in theOtherServers ){

                            result = queryExecute(
                                "
                                    UPDATE siteReset
                                    SET cf#thisServer# = 1,
                                        resetDate = :timeStamp
                                    WHERE siteID = :siteID
                                ",
                                {   
                                    siteID  = { value=application.VTappInstallProjectEntryPoint, cfsqltype="cf_sql_integer" },
                                    timeStamp = { value=now(), cfsqltype='cf_sql_timestamp' }
                                },
								{
									datasource = application.MainDatabase,
									result = "metaData"
								}

							);

                        }

                    }   

                    transaction action='commit';

                } catch( any e ){

                    transaction action='rollback';

                    writeDump( e );

                    return false;

                }

            }

            return true;

        }

        public query function getEntryPoint(){

            //Queries
			var result = queryNew( '' );
			
			//Structs
			var metaData = {};

            //get entry point information

            try{

                result = queryExecute(
                    "
                        Select * 
                            From entryPoints ep
                            Left Join establishments e on ep.entryPointCode = e.establishmentEntryPoint and establishmentKey = 0
                            Left Join establishmentDetailDealers ed on ep.entryPointCode = ed.establishmentKey
                        Where ep.entryPointCode = :siteID
                    ",
                    { 
                        siteID  = { value=application.VTappInstallProjectEntryPoint, cfsqltype="cf_sql_integer" }
                    },
					{
						datasource = application.MainDatabase,
						result = "metaData"
					}                    
                );

            } catch( any e ){

                writeDump( e );
                return result;

            }

            return result;

        }

        public query function getAppMetaInfo(){

            //Queries
			var result = queryNew( '' );
			
			//Structs
			var metaData = {};

            try{

                result = queryExecute(
                    "
                        SELECT  m.metaInfoID, m.siteID, m.url, m.forwardType, m.forwardTo,
                                m.seoTitle, m.seoKeywords, m.seoDescription, m.seoComment, 
                                m.seoIndex, m.seoFollow, m.includeYN
                            FROM metainfo m
                        WHERE siteID = :siteID 
                            AND active = 1
                            ORDER BY m.url
                    ",
                    { 
                        siteID  = { value=application.VTappInstallProjectEntryPoint, cfsqltype="cf_sql_integer" }
                    },
					{
						datasource = application.MainDatabase,
						result = "metaData"
					}
                );

            } catch( any e ){

                writeDump( e );

            }

            return result;

        }

        public query function getEstablishmentDetail(){

            //Queries
			var result = queryNew( '' );
			
			//Structs
			var metaData = {};

            try{

                result = queryExecute(
                    "
                        Select EstablishmentDetaildealers.* 
                            From Establishments
                            join establishmentdetaildealers on establishments.establishmenttype = establishmentdetaildealers.establishmenttype and
                            establishments.establishmentkey = establishmentdetaildealers.establishmentkey 
                        Where Establishments.EstablishmentType  = :type 
                            And Establishments.EstablishmentKey = :key
                    ",
                    {
                        type    =  { value='W', cfsqltype='cf_sql_varchar', maxlength=1, null=false },
                        key     =  { value=application.VTappInstallProjectEntryPoint, cfsqltype='cf_sql_integer', null=false }

                    },
					{
						datasource = application.MainDatabase,
						result = "metaData"
					}
				
				);

            } catch( any e ){

                writeDump( e );

            }

            return result;

		}
		
		public query function getEstablishment(){

			//Queries
			var result = queryNew( '' );

			//Structs
			var metaData = {};

			try{

				result = queryExecute(
					"
						Select Establishments.*, States.StateAbbrev
							From Establishments
							Left Join States
								On States.StateCode = Establishments.EstablishmentStateCode 
						Where EstablishmentType = 	:Type 
							And EstablishmentKey = 	:Key
					",
                    {
                        type    =  { value='W', cfsqltype='cf_sql_varchar', maxlength=1, null=false },
                        key     =  { value=application.VTappInstallProjectEntryPoint, cfsqltype='cf_sql_integer', null=false }

                    },
					{
						datasource = application.MainDatabase,
						result = "metaData"
					}
					
				);

			} catch( any e ){

				writeDump( e );

			}

			return result;

		}

        public query function getZStateCodes(){

            //Queries
			var result = queryNew( '' );
			
			//Structs
			var metaData = {};

            try{

                result = queryExecute(
                    "
                        SELECT s.*
                            FROM States s
                        ORDER BY s.StateDisplayOrder;
					",
					{},
					{
						datasource = application.MainDatabase,
						result = "metaData"
					}

                );

            } catch( any e ){

                writeDump( e );

            }

            return result;

        }

        public query function getUSStateCodes(){

            //Queries
			var result = queryNew( '' );
			
			//Structs
			var metaData = {};

            try{

                result = queryExecute(
                    "
                        SELECT s.*
                            FROM States s
                        WHERE continentalUS = 1
                        ORDER BY s.StateDisplayOrder;
					",
					{},
					{
						datasource = application.MainDatabase,
						result = "metaData"
					}

                );

            } catch( any e ){

                writeDump( e );

            }

            return result;

        }

        public query function getFeatBrands(){

            //Queries
			var result = queryNew( '' );
			
			//Structs
			var metaData = {};

            try{

                result = queryExecute(
                    "
                        Select b.brandID, b.brandName, b.brandCode
                            From siteBrands bi
                            Left Join brands b on bi.brandID = b.brandID
                        Where bi.siteID = :entryPoint 
                            And bi.featuredBrand = 1
                    ",
                    { 

                        entryPoint = { value = application.VTappInstallProjectEntryPoint, cfsqltype='cf_sql_integer' }

                    },
					{
						datasource = application.ProductsDatabase,
						result = "metaData"
					}                
					
				);

            } catch( any e ){

				writeDump( e );

			}
			
			return result;

		}
		
		public query function getPrivateBrands(){

			//Queries
			var result = queryNew( '' );

			//Structs
			var metaData = {};

			try{

				result = queryExecute(
					"
					    Select b.brandID, b.brandName, b.brandCode
      						From siteBrands bi
      						Left Join brands b on bi.brandID = b.brandID
     					Where bi.siteID = :entryPoint 
       						And bi.visibleTo > 1
					",
					{ 

                        entryPoint = { value = application.VTappInstallProjectEntryPoint, cfsqltype='cf_sql_integer' }

					},
					{
						datasource = application.ProductsDatabase,
						result = "metaData"
					}

				);

			} catch( any e ){

				writeDump( e );

			}

			return result;

		}

		public query function getSiteBrands(){

			//Queries
			var result = queryNew( '' );

			//Structs
			var metaData = {};

			try{

				result = queryExecute(
					"
					    Select GROUP_CONCAT(s.brandID) as brandIDs, count(s.brandID) as bcount 
      						From siteBrands s
     					Where siteID = :EntryPoint
     						Order By s.brandID ASC
					",
					{ 

                        entryPoint = { value = application.VTappInstallProjectEntryPoint, cfsqltype='cf_sql_integer' }

					},
					{
						datasource = application.ProductsDatabase,
						result = "metaData"
					}
				);

			} catch( any e ){

				writeDump( e );

			}

			return result;

		}

		/*****
		 * @hint: This function sets up the admin users 
		 * 
		 * 
		 * 
		 * */

		public query function getSiteSetupAgents(){

			//Queries
			var result = queryNew( '' );

			//Structs
			var metaData = {};

			try{

				result = queryExecute(
					"
					    Select u.userID, u.fName, u.lName, u.email
      					From users u
     					Where userType = 'Admin'
       					And FIND_IN_SET('100', u.serverSecurity)
     					Order By u.fName, u.lName
					
					",
					{


					},
					{
						datasource 	= application.MainDatabase,
						result 		= "metaData"
					}
				);

			} catch( any e ){

				writeDump( e );

			}

			return result;

		}

		/**
		 *  @hint: wish list notification
		 * 
		 * 
		 * */

		public query function getWLNotificationList(){

			//Query
			var result 		= queryNew( '' );

			//Structs
			var metaData 	= {};


			try{

				result = queryExecute(
					"
						Select GROUP_CONCAT( u.email ) as email
      						From users u
     					Where siteID = :siteID 
       						And FIND_IN_SET('310', wlSecurity)
					
					",
					{

						siteID = { value=application.VTappInstallProjectEntryPoint, cfsqltype="cf_sql_integer" }

					},
					{ 

						datasource	= application.MainDatabase,
						result 		= "metaData"

					}
				)

			} catch( any e ){

				writeDump( e );

			}

			return result;

		}

		/**
		 *  @hint: User Notifications
		 * 
		 * 
		 * */

		public query function getUserNotificationList(){

			//Query
			var result 		= queryNew( '' );

			//Structs
			var metaData 	= {};

			try{

				result = queryExecute(
					"
						Select GROUP_CONCAT(email) as email
						From users
						Where siteID = :siteID 
						And FIND_IN_SET('250', siteSecurity)
					
					",
					{

						siteID = { value=application.VTappInstallProjectEntryPoint, cfsqltype="cf_sql_integer" }

					},
					{
						datasource 	= application.MainDatabase,
						result 		= "metaData"
					}
				);

			} catch( any e ){

				writeDump( e );

			}

			return result;

		}

		/**
		 * @hint : Order Notification
		 */

		public query function getEcommerceEmailTo(){

			//Queries
			var result 		= queryNew( '' );

			//Structs
			var metaData  	= {};

			try{

				result = queryExecute(
					"
						Select GROUP_CONCAT(u.email) as email
							From users u
						Where siteID = :siteID 
							And FIND_IN_SET('410', eCommSecurity)
					
					",
					{

						siteID = { value=application.VTappInstallProjectEntryPoint, cfsqltype="cf_sql_integer" }

					},
					{
						datasource 	= application.MainDatabase,
						result 		= "metaData"
					}
				);

			} catch( any e ){

				writeDump( e );

			}

			return result;

		}

		/**
		 * @hint : Site Question Notification
		 */

		public query function getQuestionEmailTo(){

			//Queries
			var result 		= queryNew( '' );

			//Structs
			var metaData  	= {};

			try{

				result = queryExecute(
					"
						Select GROUP_CONCAT(email) as email
							From users
						Where siteID = :siteID 
							And FIND_IN_SET('280', siteSecurity)
					
					",
					{

						siteID = { value=application.VTappInstallProjectEntryPoint, cfsqltype="cf_sql_integer" }

					},
					{
						datasource 	= application.MainDatabase,
						result 		= "metaData"
					}
				);

			} catch( any e ){

				writeDump( e );

			}

			return result;

		}


		/**
		 * @hint : States to tax
		*/
			
		public query function getStatesToTax(){

			//Queries
			var result 		= queryNew( '' );

			//Structs
			var metaData 	= {};

			try{

				result = queryExecute(
					"
						Select group_concat(s.stateName) as states 
							From siteTaxes st
							Join states s on st.stateID = s.stateCode
						Where st.siteID = :siteID
					
					",
					{

						siteID = { value=application.VTappInstallProjectEntryPoint, cfsqltype="cf_sql_integer" }

					},
					{
						datasource 	= application.MainDatabase,
						result 		= "metaData"
					}
				);

			} catch( any e ){

				writeDump( e );

			}

			return result;

		}


		/**
		 * @hint : Location Assoicates
		 */

		public query function getLocationAssignments(){

			//Queries
			var result 		= queryNew( '' );

			//Structs
			var metaData  	= {};

			try{

				result = queryExecute(
					"
						Select e.EstablishmentFullName, u.fname, u.lname, u.email, u.siteID, e.establishmentID, u.userID, u.publicNotes as userBio, u.title
							From srlighting.users u
							Join srlighting.establishments e on u.siteID = e.establishmentEntryPoint
							And e.displayAsLocation = 1
							And FIND_IN_SET( e.establishmentID, u.employeeLocations ) > 0
						Where siteID = :siteID
							And u.listEmployee = 1
							Order By EstablishmentFullName, lname, fname
					
					",
					{

						siteID = { value=application.VTappInstallProjectEntryPoint, cfsqltype="cf_sql_integer" }

					},
					{
						datasource 	= application.ProductsDatabase,
						result 		= "metaData"
					}
				);

			} catch( any e ){

				writeDump( e );

			}

			return result;

		}

		/**
		 * @hint : Wish List Associates
		 */

		public query function getWLAssignments(){

			//Queries
			var result 		= queryNew( '' );

			//Structs
			var metaData  	= {};

			try{

				result = queryExecute(
					"
						Select e.EstablishmentFullName, u.fname, u.lname, u.email, u.siteID, e.establishmentID, u.userID
							From srlighting.users u
							Join srlighting.establishments e 
								On u.siteID = e.establishmentEntryPoint
								And e.displayOnWishlist = 1
								And FIND_IN_SET(e.establishmentID, u.associateLocations) > 0
						Where siteID = :siteID
							And u.listAssociate = 1
							Order By EstablishmentFullName, lname, fname
					
					",
					{

						siteID = { value=application.VTappInstallProjectEntryPoint, cfsqltype="cf_sql_integer" }

					},
					{
						datasource 	= application.ProductsDatabase,
						result 		= "metaData"
					}
				);

			} catch( any e ){

				writeDump( e );

			}

			return result;

		}

		/**
		 * @hint: Contact Associates
		 */

		public query function getContactAssignments(){

			//Queries
			var result 		= queryNew( '' );

			//Structs
			var metaData 	= {};

			try{

				result = queryExecute(
					"
						Select e.EstablishmentFullName, u.fname, u.lname, u.email, u.siteID, e.establishmentID, e.establishmentKey, u.userID
							From srlighting.users u
							Join srlighting.establishments e on u.siteID = e.establishmentEntryPoint
							And e.establishmentActive = 1
							And FIND_IN_SET(e.establishmentID, u.contactLocations) > 0
						Where siteID = :siteID
							And u.listContact = 1
							Order By EstablishmentFullName, lname, fname
					",
					{

						siteID = { value=application.VTappInstallProjectEntryPoint, cfsqltype="cf_sql_integer" }

					},
					{
						datasource 	= application.ProductsDatabase,
						result 		= "metaData"
					}

				);

			} catch( any e ){

				writeDump( e );

			}

			return result;

		}

		/**
		 * @hint: Site Locations
		 */

		public query function getSiteLocations(){

			//Queries
			var result 					= queryNew( '' );

			//Strings
			var establishmentKeyColumn 	= '';
			var appendSortDirection 	= '';
			var key 					= '';
			var href 					= ''; 				

			//Structs
			var metaData 				= {};

			try{

				appendSortDirection 	= 	( listFind( '152,370', application.VTappInstallProjectEntryPoint ) ) ? 'desc' : 'asc';
				establishmentKeyColumn 	= 	( listFind( '385,412,484,182,495,518,535', application.VTappInstallProjectEntryPoint ) ) ? 'establishmentKey' : 'establishmentFullName ' & appendSortDirection;

				result = queryExecute(
					"
						Select ep.EntryPointName, e.establishmentType, e.establishmentKey, e.establishmentID, 
							e.EstablishmentFullName as Name, e.establishmentTitle as title,
							e.establishmentDescription as Description, e.EstablishmentAddress1 as Address1,
							e.EstablishmentAddress2 as Address2 ,e.EstablishmentCity as City,e.EstablishmentState as State, 
							e.EstablishmentZip as zip, e.EstablishmentPhone as Phone, e.EstablishmentEmail as email, 
							e.directions, EstablishmentPhone800 as Fax, e.googleMap, e.displayOnWishList,
							establishmentNotes, establishmentNotesIntro, latitude, longitude,
							eh.*, ed.establishmentDetailFreeShippingAmount, 
							ed.establishmentDetailOversizedShippingAmount,
							ed.establishmentDetailOversizedFreeShippingAmount, concat(e.EstablishmentCity, ' ', e.EstablishmentState) as cityState,
							9999 as distance, '' as locationLink
						From entrypoints ep
							Left Join establishments e on ep.EntryPointCode = e.EstablishmentEntryPoint
							Left Join establishmentdetaildealers ed on ep.EntryPointCode = ed.establishmentkey
							Left Join establishmentsHours eh on eh.EstablishmentHoursID = e.EstablishmentID
						Where ep.entryPointCode = :siteID and 
							e.EstablishmentType = 'L' and e.EstablishmentKey > 0 and 
							e.establishmentActive = 1 and e.displayAsLocation = 1
						Order By e.#establishmentKeyColumn#
					",
					{

						siteID = { value=application.VTappInstallProjectEntryPoint, cfsqltype="cf_sql_integer" }

					},
					{
						datasource 	= application.MainDatabase,
						result 		= "metaData"
					}

				);

			//Set the location links
			for( key in result ){

				href = '/' & replace( key.name," ","-","ALL" ) & '-' & key.state & '-v' & key.currentRow & '.HTML';
				querySetCell( result , "locationLink", href , key.currentRow );

			}

			} catch( any e ){

				writeDump( e );

			}

			return result;

		}

		/**
		 * @hint: Site Locations 0
		 * 
		 */

		public query function getSiteLocationZero(){

			//Queries
			var result 		= queryNew( '' );

			//Structs
			var metaData 	= {};

			try{

				result = queryExecute(
					"
						SELECT ep.EntryPointName, e.establishmentType, e.establishmentKey, e.establishmentID, 
							e.EstablishmentFullName as Name, 
							e.establishmentDescription as Description, e. EstablishmentAddress1 Address1,
							e.EstablishmentAddress2 as Address2 ,e.EstablishmentCity as City,e.EstablishmentState as State, 
							e.EstablishmentZip as zip, e.EstablishmentPhone as Phone, e.EstablishmentEmail as email, 
							e.directions, EstablishmentPhone800 as Fax, e.googleMap, e.displayOnWishList,
							establishmentNotes, establishmentNotesIntro, 
							eh.*, ed.establishmentDetailFreeShippingAmount, 
							ed.establishmentDetailOversizedShippingAmount,
							ed.establishmentDetailOversizedFreeShippingAmount
						FROM entrypoints ep
						Left Join establishments e on ep.EntryPointCode = e.EstablishmentEntryPoint
						Left Join establishmentdetaildealers ed on ep.EntryPointCode = ed.establishmentkey
						Left Join establishmentsHours eh on eh.EstablishmentHoursID = e.EstablishmentID
						Where ep.entryPointCode = :siteID 
						And e.EstablishmentType = 'L' 
						And e.EstablishmentKey = 0 
						Order By e.EstablishmentFullName
					",
					{

						siteID = { value=application.VTappInstallProjectEntryPoint, cfsqltype="cf_sql_integer" }

					},
					{
						datasource 	= application.MainDatabase,
						result 		= "metaData"
					}

				);

			} catch( any e ){

				writeDump( e );

			}

			return result;

		}

		/**
		 * @hint: Wish List Locations
		 */

		 public query function getSiteLocationWL(){

			//Queries
			var result 		= queryNew( '' );

			//Structs
			var metaData 	= {};

			try{

				result = queryExecute(
					"
						SELECT ep.EntryPointName, e.establishmentType, e.establishmentKey, e.establishmentID, 
							e.EstablishmentFullName as Name, 
							e.establishmentDescription as Description, e. EstablishmentAddress1 Address1,
							e.EstablishmentAddress2 as Address2 ,e.EstablishmentCity as City,e.EstablishmentState as State, 
							e.EstablishmentZip as zip, e.EstablishmentPhone as Phone, e.EstablishmentEmail as email, 
							e.directions, EstablishmentPhone800 as Fax, e.googleMap,
							establishmentNotes, establishmentNotesIntro, 
							eh.*, ed.establishmentDetailFreeShippingAmount, 
							ed.establishmentDetailOversizedShippingAmount,
							ed.establishmentDetailOversizedFreeShippingAmount
						FROM entrypoints ep
						Left Join establishments e on ep.EntryPointCode = e.EstablishmentEntryPoint
						Left Join establishmentdetaildealers ed on ep.EntryPointCode = ed.establishmentkey
						Left Join establishmentsHours eh on eh.EstablishmentHoursID = e.EstablishmentID
						Where ep.entryPointCode = :siteID
							and 
								e.EstablishmentType = 'L' and e.EstablishmentKey > 0 and 
								e.establishmentActive = 1 and e.displayOnWishList = 1
						Order By e.EstablishmentFullName
					",
					{

						siteID = { value=application.VTappInstallProjectEntryPoint, cfsqltype="cf_sql_integer" }

					},
					{
						datasource 	= application.MainDatabase,
						result 		= "metaData"
					}

				);

			} catch( any e ){

				writeDump( e );

			}

			return result;


		 }


		/**
		 * @hint: Location
		 * 
		 */

		 public query function getLocationZero(){

			//Queries
			var result 		= queryNew( '' );

			//Structs
			var metaData 	= {};

			try{

				result = queryExecute(
					"
						SELECT e.establishmentfullName as siteName,
							e.establishmentaddress1 as address1, e.establishmentaddress2 as address2, 
							e.establishmentcity as city , e.establishmentstate as state, 
							e.establishmentzip as zip,e.establishmentphone as phone, e.establishmentemail as email
						FROM srlighting.establishments e
						Where e.establishmententrypoint = :siteID and
							e.establishmentType = 'L' and e.EstablishmentKey = 0
					",
					{

						siteID = { value=application.VTappInstallProjectEntryPoint, cfsqltype="cf_sql_integer" }

					},
					{
						datasource 	= application.MainDatabase,
						result 		= "metaData"
					}

				);

			} catch( any e ){

				writeDump( e );

			}

			return result;

		 }

		 /**
		  * @hint: Sites Features Query (used for UserIQ)
		  */

		  public query function getSiteFeatures(){

			//Queries
			var result 		= queryNew( '' );

			//Structs
			var metaData 	= {};

			try{

				result = queryExecute(
					"
						SELECT sfn.siteFeatureCode, if(sf.Active,'Yes','No') as active
						FROM siteFeatureNames sfn
						left join sitefeatures sf on sfn.sitefeaturenameID = sf.sitefeaturenameID 
						and sf.siteID = :siteID
						order by siteFeatureCode
					",
					{

						siteID = { value=application.VTappInstallProjectEntryPoint, cfsqltype="cf_sql_integer" }

					},
					{
						datasource 	= application.MainDatabase,
						result 		= "metaData"
					}

				);

			} catch( any e ){

				writeDump( e );

			}

			return result;

		  }

		  /**
		   * @hint: 
		   */

		  public string function setSolrSortValue( required query getEntryPoint ){

			//list
			var listOfColumns 				= getEntryPoint.columnList;

			//strings
			var columns  					= '';
			var facetSymbolToAppend 		= '&f.';
			var result 						= '';

			//arrays
			var columnsToCheck 				= [ 'sortCategoryGroupYN', 'sortCategoryYN', 'sortSubCategoryYN', 'sortBrandYN', 'sortCollectionYN', 'sortStyleYN', 'sortFinishStandardYN', 'sortFinishYN' ];
			var arrayOfValuesToAppend 		= [ 'categoryGroup', 'category', 'subCategory', 'brand', 'collection', 'style', 'finishStandard', 'finish' ];
			var bitArrayOfValuesToAppend 	= [ '.facet.sort=count', '.facet.sort=alpha' ];
			var stringArray 				= [ result, facetSymbolToAppend, '', '' ];

			//booleans
			var debug 						= false;

			for( columns in listToArray( listOfColumns ) ){

				if( debug && 0 ){
					writeDump( arrayFindNoCase( columnsToCheck, trim( columns ) ) );
				}

				if( arrayFindNoCase( columnsToCheck, trim( columns ) ) ){

					stringArray[ 3 ] 	= arrayOfValuesToAppend[ arrayFindNoCase( columnsToCheck, trim( columns ) ) ];
					stringArray[ 4 ] 	= bitArrayOfValuesToAppend[ getEntryPoint[ columnsToCheck[ arrayFindNoCase( columnsToCheck, trim( columns ) ) ] ][ 1 ] + 1 ]
					result 				= listAppend( arrayToList( stringArray, '' ), '' );
					stringArray[ 1 ] 	= result;

				}

				if( debug ){
					writeDump( columns );
					writeDump( stringArray );
				}

			}

			result = reReplaceNoCase( result, ',', '', 'all' );

			return result;

		}

		/**
		 * @hint: Spex Builder PDF Settings
		 */

		 public query function getSpexBuilderSettings(){

			//Queries
			var result 		= queryNew( '' );

			//Structs
			var metaData 	= {};

			try{

				result = queryExecute(
					"
						SELECT * FROM wishListPDFDetails
					",
					{

					},
					{
						datasource 	= application.ProductsDatabase,
						result 		= "metaData"
					}

				);

			} catch( any e ){

				writeDump( e );

			}

			return result;

		 }

		 /**
		  * @hint: 
		  */
		  public query function getMobileServices(){

			//Queries
			var result 		= queryNew( '' );

			//Structs
			var metaData 	= {};

			try{

				result = queryExecute(
					"
        				Select * From mobileServices
					",
					{

					},
					{
						datasource 	= application.ProductsDatabase,
						result 		= "metaData"
					}

				);

			} catch( any e ){

				writeDump( e );

			}

			return result;

		 }

		 /**
		  * @hint: 
		  */
		  public struct function getFinishGroups( required struct finishGroupImages ){

			//Queries
			var result 			= queryNew( '' );

			//Structs
			var metaData 		= {};

			//Numerics
			var row 			= 1;

			try{

				result = queryExecute(
					"
        				Select * 
							from finishGroups 
						Where imageName is not null 
							And imageName <> ''

					",
					{

					},
					{
						datasource 	= application.ProductsDatabase,
						result 		= "metaData"
					}

				);
				
				for( row in result.recordCount ){

					finishGroupImages[ replace( result[ 'finishGroupName' ][ row ], '', '_', 'all' ) ] = result[ 'imageName' ][ row ];

				}

			} catch( any e ){

				writeDump( e );

			}

			return finishGroupImages;

		 }

		/**
		 * General functions
		 */

		 
        public query function getAllSites(){

            //Queries
			var result = queryNew( '' );
			
			//Structs
			var metaData = {};

            //get entry point information

            try{

                result = queryExecute(
                    "
                        Select EntryPointCode, EntryPointName
                    	From entryPoints ep

                    ",
                    { 
                    },
					{
						datasource = application.MainDatabase,
						result = "metaData"
					}                    
                );

            } catch( any e ){

                writeDump( e );

            }

            return result;

		}
		

		public query function getAllUsers(){

            //Queries
			var result = queryNew( '' );
			
			//Structs
			var metaData = {};

            //get entry point information

            try{

                result = queryExecute(
                    "
                        Select u.userID, u.fName, u.lName
                    	From users u

                    ",
                    { 
                    },
					{
						datasource = application.MainDatabase,
						result = "metaData"
					}                    
                );

            } catch( any e ){

                writeDump( e );

            }

            return result;

		}

    //    **********************************************************************
    //    *  App Vars Functions - END
    //    * ********************************************************************

}