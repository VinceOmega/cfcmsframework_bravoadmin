<cfscript>


	//Check to see if this is a struct that exists, if not then create it.
	APPLICATION[ 'errorPanel' ] ?: structNew();


	//Pre-Defined External Links
	APPLICATION[ 'errorPanel' ][ 'externalLinks' ]                              = structNew();
	APPLICATION[ 'errorPanel' ][ 'externalLinks' ][ 'bravoMarketingSite' ]      = 'https://bravobusinessmedia.com';
	APPLICATION[ 'errorPanel' ][ 'externalLinks' ][ 'myPlumbingShowroom' ]      = 'https://myplumbingshowroom.com';

	//Login Page config
	APPLICATION[ 'errorPanel' ][ 'loginPageConfig' ]                            = structNew();
	APPLICATION[ 'errorPanel' ][ 'loginPageConfig' ][ 'photoCycle' ]            = [ '/img/login/1.jpg', '/img/login/2.jpg', '/img/login/3.jpg', '/img/login/4.jpg'  ];
	APPLICATION[ 'errorPanel' ][ 'loginLayout' ]                                = 'LeftSideBar';

	//Material Theme Resources
	APPLICATION[ 'errorPanel' ][ 'Theme' ]                                      = structNew();
	APPLICATION[ 'errorPanel' ][ 'Theme' ][ 'Material' ]                        = structNew();
	APPLICATION[ 'errorPanel' ][ 'Theme' ][ 'Material' ][ 'Assets' ]            = '/templates/vendors/material-pro/assets/';
	APPLICATION[ 'errorPanel' ][ 'Theme' ][ 'Material' ][ 'CSS' ]               = '/templates/vendors/material-pro/css/';
	APPLICATION[ 'errorPanel' ][ 'Theme' ][ 'Material' ][ 'JS' ]                = '/templates/vendors/material-pro/js/';
	APPLICATION[ 'errorPanel' ][ 'Theme' ][ 'Material' ][ 'SCSS' ]              = '/templates/vendors/material-pro/scss/';

	//Admin Panel Logo
	APPLICATION[ 'errorPanel' ][ 'logo' ]                                           = '/img/common/bravo_logo.png';
	APPLICATION[ 'SolrPair' ] 														= '1,2';
	APPLICATION[ 'ScriptsDirectory' ]                                               = 'Scripts/';
	APPLICATION[ 'MainDatabase' ]                                                   = 'SRLighting';
	APPLICATION[ 'ProductsDatabase' ]                                               = 'Products';
	APPLICATION[ 'zIndexDatabase' ]                                                 = "zindex";
	APPLICATION[ 'InstallationType' ]                                               = 0 ;
	APPLICATION[ 'CustomScriptsCFMappingDirectory' ]                                = '/CustomScriptsBravo/' ;


	/************************************************************************************************************************************************/
	APPLICATION[ 'devIds' ]                                 = [ '0000582', '0017804', '0000837' ];
	APPLICATION[ 'devActions' ]                             = [ 'reset', 'cfDumpScope' ];
	APPLICATION[ 'devActionsArgStruct' ]                    = {
		'reset': [ 'application', 'session', 'server' ],
		'cfDumpScope' :  [ 
			'application', 'server', 'session', 
			'cookie', 'request', 'local', 'variables', 'arguments',
			'cgi', 'this', 'client', 'all'
		]
	};
	/************************************************************************************************************************************************/

	APPLICATION[ 'DataTables' ] 							= serializeJSON( {
		'tablecontacts' 	:  {
			'dom': "
				<'row'<'col-sm-6'B><'col-sm-3'l><'col-sm-3'f>>
				<'row'<'col-sm-12'tr>>
				<'row'<'col-sm-5'i><'col-sm-7'p>>
			",
			'pageLength': 10,
			'bPaginate': true,
			'order': [ 3, 'asc' ],
			'lengthMenu' : [ [ 10, 25, 50, -1 ], [ 10, 25, 50, 'All' ] ],
			'buttons': [
				'copy',
				{
					extend: 'excel', exportOptions: { columns: 'visible' }
				},
				{
					extend: 'print', exportOptions: { columns: 'visible' }
				},
				'colvis'
			],
			'responsive': { details: { Type: 'column' } }				
		} ,
		'tablecatalogs' 	: {
			'dom': "
				<'row'<'col-sm-6'B><'col-sm-3'l><'col-sm-3'f>>
				<'row'<'col-sm-12'tr>>
				<'row'<'col-sm-5'i><'col-sm-7'p>>
			",
			'pageLength': 10,
			'bPaginate': true,
			'order':  [ [ 0, 'desc' ],[ 2, 'desc'] ],
			'lengthMenu' : [ [ 10, 25, 50, -1 ], [ 10, 25, 50, 'All' ] ],
			'buttons': [
				'copy',
				{
					extend: 'excel', exportOptions: { columns: 'visible' }
				},
				{
					extend: 'print', exportOptions: { columns: 'visible' }
				},
				'colvis'
			],
			'responsive': { details: { Type: 'column' } }				
		} ,
		'tablenotes' 		: {
			'dom': "
				<'row'<'col-sm-6'B><'col-sm-3'l><'col-sm-3'f>>
				<'row'<'col-sm-12'tr>>
				<'row'<'col-sm-5'i><'col-sm-7'p>>
			",
			'pageLength': 10,
			'bPaginate': true,
			'order':  [ ],
			'lengthMenu' : [ [ 10, 25, 50, -1 ], [ 10, 25, 50, 'All' ] ],
			'buttons': [
				'copy',
				{
					extend: 'excel', exportOptions: { columns: 'visible' }
				},
				{
					extend: 'print', exportOptions: { columns: 'visible' }
				},
				'colvis'
			],
			'responsive': { details: { Type: 'column' } }				
		} ,
		'tabledataloads' 	: {
			'dom': "
				<'row'<'col-sm-6'B><'col-sm-3'l><'col-sm-3'f>>
				<'row'<'col-sm-12'tr>>
				<'row'<'col-sm-5'i><'col-sm-7'p>>
			",
			'pageLength': 10,
			'bPaginate': true,
			'order':  [ 0, 'desc' ],
			'lengthMenu' : [ [ 10, 25, 50, -1 ], [ 10, 25, 50, 'All' ] ],
			'buttons': [
				'copy',
				{
					extend: 'excel', exportOptions: { columns: 'visible' }
				},
				{
					extend: 'print', exportOptions: { columns: 'visible' }
				},
				'colvis'
			],
			'responsive': { details: { Type: 'column' } }				
		} ,
		'tablecustomers' 	: {
			'dom': "
				<'row'<'col-sm-6'B><'col-sm-3'l><'col-sm-3'f>>
				<'row'<'col-sm-12'tr>>
				<'row'<'col-sm-5'i><'col-sm-7'p>>
			",
			'pageLength': 10,
			'bPaginate': true,
			'order':  [ 1, 'asc' ],
			'lengthMenu' : [ [ 10, 25, 50, -1 ], [ 10, 25, 50, 'All' ] ],
			'buttons': [
				'copy',
				{
					extend: 'excel', exportOptions: { columns: 'visible' }
				},
				{
					extend: 'print', exportOptions: { columns: 'visible' }
				},
				'colvis'
			],
			'responsive': { details: { Type: 'column' } }				
		} ,
		'tablelanding' 		:  {
			'  dom': "
				<'row'<'col-sm-6'B><'col-sm-3'l><'col-sm-3'f>>
				<'row'<'col-sm-12'tr>>
				<'row'<'col-sm-5'i><'col-sm-7'p>>
			",
			'pageLength': 10,
			'bPaginate': true,
			'order':  [ 0, 'asc' ],
			'lengthMenu' : [ [ 10, 25, 50, -1 ], [ 10, 25, 50, 'All' ] ],
			'buttons': [
				'copy',
				{
					extend: 'excel', exportOptions: { columns: 'visible' }
				},
				{
					extend: 'print', exportOptions: { columns: 'visible' }
				},
				'colvis'
			],
			'responsive': { details: { Type: 'column' } }				
		} ,
		'tablegroups' 		: {
			'dom': "
				<'row'<'col-sm-6'B><'col-sm-3'l><'col-sm-3'f>>
				<'row'<'col-sm-12'tr>>
				<'row'<'col-sm-5'i><'col-sm-7'p>>
			",
			'pageLength': 10,
			'bPaginate': true,
			'order':  [ 0, 'asc' ],
			'lengthMenu' : [ [ 10, 25, 50, -1 ], [ 10, 25, 50, 'All' ] ],
			'buttons': [
				'copy',
				{
					extend: 'excel', exportOptions: { columns: 'visible' }
				},
				{
					extend: 'print', exportOptions: { columns: 'visible' }
				},
				'colvis'
			],
			'responsive': { details: { Type: 'column' } }				
		} ,
		'default'			: {
			'pageLength': 10,
			'bPaginate': true,
			'order':  [ 0, 'asc' ],
			'lengthMenu' : [ [ 10, 25, 50, -1 ], [ 10, 25, 50, 'All' ] ],
			'responsive': { details: { Type: 'column' } }				
		} 
	} );
	/************************************************************************************************************************************************/
</cfscript>