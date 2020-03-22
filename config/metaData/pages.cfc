<cfscript>

    //Set default values
    url.page = url.page?: '';

    //Define Sections
    local.metaData.Admin         = { 'inNav': true,  'ishref': false, 'dir': 'adminPanel', 'navBarIcon': 'fas fa-cogs' };
    local.metaData.Dashboard     = { 'inNav': true,  'ishref': false, 'dir': 'adminPanel', 'navBarIcon': 'fas fa-home' };
    local.metaData.Catalog       = { 'inNav': true,  'ishref': false, 'dir': 'adminPanel', 'navBarIcon': '' };
    local.metaData.Inventory     = { 'inNav': true,  'ishref': false, 'dir': 'adminPanel', 'navBarIcon': 'fas fa-warehouse' };
    Local.metaData.Analytics     = { 'inNav': false, 'ishref': false, 'dir': 'adminPanel', 'navBarIcon': '' };
    local.metaData.Site          = { 'inNav': true,  'ishref': false, 'dir': 'adminPanel', 'navBarIcon': '' };
    local.metaData.Users         = { 'inNav': true,  'ishref': false, 'dir': 'adminPanel', 'navBarIcon': 'fas fa-users' };
    local.metaData.WishList      = { 'inNav': true,  'ishref': false, 'dir': 'adminPanel', 'navBarIcon': '' };
    local.metaData.Login         = { 'inNav': false, 'ishref': false, 'dir': 'login'     , 'navBarIcon': '' };
    local.metaData.Auth          = { 'inNav': false, 'ishref': false, 'dir': 'auth'      , 'navBarIcon': '' };
    local.metaData.Chrome        = { 'inNav': false, 'ishref': false, 'dir': ''          , 'navBarIcon': '' };

    //Define Pages

    /*************************************************************************/
    /*  Admin Pages
    /*************************************************************************/

        Local.metaData.Admin.BrandListing = {

            'alias': 'brandListing',
            'pageButtons': [], 
            'isPage': true,                                                   
            'isParent': true,
            'hasParent': false,
            'inNav':    true,
            'atRoot':   true,
            'hasChildren': [],
            'parentPage': '',
            'section':  'Admin',
            'dir': 'adminPanel',
            'slug': 'brand-listing',
            'title':  'Brand Listing',
            'seoTitle':   'Brand Listing Page',
            'seoKeywords':   'Brand Listing Page, MPS, myplumbingshowroom.com, bravo, business, media',
            'seoRobots': 'noindex, nofollow',
            'security':  0,
            'allowedSites': [ 0 ],
            'text': [
                {
                    
                }
            ]

        };

    /*************************************************************************/
    /*  Analytics Pages
    /*************************************************************************/

        Local.metaData.Analytics.UniqueVisitors = {

            'alias': 'analyticsUniqueVisitors',
            'pageButtons': [], 
            'isPage': true,
            'isParent': true,
            'hasParent': false,
            'inNav':    true,
            'atRoot':   true,
            'hasChildren': [],
            'parentPage': '',
            'section':  'Analytics',
            'dir': 'adminPanel',
            'slug': 'unique-visitors',
            'title': 'Unique Vistors',
            'seoTitle':   'Unique Vistors Page',
            'seoKeywords':   'Unique Vistors Page, MPS, myplumbingshowroom.com, bravo, business, media',
            'seoRobots': 'noindex, nofollow',
            'security': 0,
            'allowedSites': [ 0 ],
            'text': [
                {
                    
                }
            ]

        };

        local.metaData.Analytics.analyticsOrganicTraffic = {

            'alias': 'analyticsOrganicTraffic',
            'pageButtons': [], 
            'isPage': true,
            'isParent': true,
            'hasParent': false,
            'inNav':    true,
            'atRoot':   true,
            'hasChildren': [],
            'parentPage': '',
            'section':  'Analytics',
            'dir': 'adminPanel',
            'slug': 'organic-traffic',
            'title': 'Organic Traffic',
            'seoTitle':   'Organic Traffic Page',
            'seoKeywords':   'Organic Traffic Page, MPS, myplumbingshowroom.com, bravo, business, media',
            'seoRobots': 'noindex, nofollow',
            'security': 0,
            'allowedSites': [ 0 ],
            'text': [
                {
                    
                }
            ]
        };


    
    /*************************************************************************/
    /*  Dashboard Pages
    /*************************************************************************/

        local.metaData.Dashboard.Dashboard = {

            'alias': 'dashboard',
            'pageButtons': [], 
            'isPage': true,
            'isParent': true,
            'hasParent': false,
            'inNav':    true,
            'atRoot':   true,
            'isHome':   true,
            'hasChildren': [],
            'parentPage': '',
            'section':  'Dashboard',
            'dir': 'adminPanel',
            'slug': 'dashboard',
            'title': 'Dashboard',
            'seoTitle':   'Dashboard Page',
            'seoKeywords':   'Dashboard Page, MPS, myplumbingshowroom.com, bravo, business, media',
            'seoRobots': 'noindex, nofollow',
            'security': 0,
            'allowedSites': [ 0 ],
            'text': [
                {
                    
                }
            ]

        };

        local.metaData.Dashboard.HelloWorld = {

            'alias': 'helloWorld',
            'pageButtons': [], 
            'isPage': true,
            'isParent': true,
            'hasParent': false,
            'inNav':    true,
            'atRoot':   true,
            'hasChildren': [],
            'parentPage': '',
            'section':  'Dashboard',
            'dir': 'adminPanel',
            'slug': 'hello-world',
            'title': 'Hello World',
            'seoTitle':   'Hello World Page',
            'seoKeywords':   'Hello World Page, MPS, myplumbingshowroom.com, bravo, business, media',
            'seoRobots': 'noindex, nofollow',
            'security': 0,
            'allowedSites': [ 0 ],
            'text': [
                {
                    
                }
            ]

        };

        local.metaData.Dashboard.userSites = {

            'alias': 'userSites',
            'pageButtons': [], 
            'isPage': true,
            'isParent': true,
            'hasParent': false,
            'inNav':    false,
            'atRoot':   true,
            'hasChildren': [],
            'parentPage': '',
            'section':  'Dashboard',
            'dir': 'adminPanel',
            'slug': 'userSites',
            'title': 'Select Your Site',
            'seoTitle':   'Hello World Page',
            'seoKeywords':   'Hello World Page, MPS, myplumbingshowroom.com, bravo, business, media',
            'seoRobots': 'noindex, nofollow',
            'security': 0,
            'allowedSites': [ 0 ],
            'text': [
                {
                    
                }
            ]

        };

        local.metaData.Dashboard.RightSideBarPage = {

            
            'alias': 'rightSideBarPage',
            'pageButtons': [], 
            'isPage': true,
            'isParent': false,
            'hasParent': false,
            'inNav':    false,
            'atRoot':   true,
            'hasChildren': [],
            'parentPage': '',
            'section':  'Dashboard',
            'dir': 'adminPanel',
            'slug': 'rightsidebarpage',
            'title': 'Right Side Bar Page',
            'seoTitle':   'Right Side Bar Page',
            'seoKeywords':   'Right Side Bar Page, MPS, myplumbingshowroom.com, bravo, business, media',
            'seoRobots': 'noindex, nofollow',
            'security': 0,
            'allowedSites': [ 0 ],
            'text': [
                {
                    
                }
            ]

        }

    /*************************************************************************/
    /*  Login Pages
    /*************************************************************************/

        local.metaData.Login.Signin = {

            'alias': 'signin',
            'pageButtons': [], 
            'isPage': true,
            'isParent': true,
            'hasParent': false,
            'inNav':    false,
            'atRoot':   true,
            'hasChildren': [],
            'parentPage': '',
            'section':  'Login',
            'dir': 'login',
            'slug': 'signin',
            'title':    'Login Page',
            'seoTitle':   'Login Page',
            'seoKeywords':   'Login Page, MPS, myplumbingshowroom.com, bravo, business, media',
            'seoRobots': 'noindex, nofollow',
            'security': 0,
            'allowedSites': [ 0 ],
            'text': [
                {
                    
                }
            ]
        };

        local.metaData.Login.Signout = {

            'alias': 'signout',
            'pageButtons': [], 
            'isPage': true,
            'isParent': true,
            'hasParent': false,
            'inNav':    false,
            'atRoot':   true,
            'hasChildren': [],
            'parentPage': '',
            'section':  'Login',
            'dir': 'login',
            'slug': 'signout',
            'title':    'Signout Page',
            'seoTitle':   'Signout Page',
            'seoKeywords':   'Signout Page, MPS, myplumbingshowroom.com, bravo, business, media',
            'seoRobots': 'noindex, nofollow',
            'security': 0,
            'allowedSites': [ 0 ],
            'text': [
                {
                    
                }
            ]
        };

    
    /*************************************************************************/
    /*  Users Pages
    /*************************************************************************/

        local.metaData.Users.Listing = {

            'alias': 'userListing',
            'pageButtons': [], 
            'isPage': true,
            'isParent': true,
            'hasParent': false,
            'inNav':    true,
            'atRoot':   true,
            'hasChildren': [ 'userEditing', 'userCreate', 'userCopy', 'userRemove' ],
            'parentPage': '',
            'section':  'Users',
            'dir': 'adminPanel',
            'slug': 'listing',
            'title': 'Customer',
            'seoTitle':   'Listing Page',
            'seoKeywords':   'Listing Page, MPS, myplumbingshowroom.com, bravo, business, media',
            'seoRobots': 'noindex, nofollow',
            'security': 200,
            'userSecurity': [ 250 ],
            'withoutRightsCanView': true,
            'allowedSites': [ 0 ],
            'text': [
                {
                    
                }
            ]

        }

        local.metaData.Users.Edit = {

            'alias': 'userEditing',
            'pageButtons': [], 
            'isPage': true,
            'isParent': false,
            'hasParent': true,
            'inNav':    false,
            'atRoot':   false,
            'hasChildren': [],
            'parentPage': 'userListing',
            'section':  'Users',
            'dir': 'adminPanel',
            'slug': 'edit',
            'title':  'User Edit Page',
            'seoTitle':   'Edit Page',
            'seoKeywords':   'Edit Page, MPS, myplumbingshowroom.com, bravo, business, media',
            'seoRobots': 'noindex, nofollow',
            'security': 200,
            'userSecurity': [ 250 ],
            'withoutRightsCanView': true,
            'allowedSites': [ 0 ],
            'text': [
                {
                    
                }
            ]

        }

        local.metaData.Users.Create = {

            'alias': 'userCreate',
            'pageButtons': [], 
            'isPage': true,
            'isParent': false,
            'hasParent': true,
            'inNav':    false,
            'atRoot':   false,
            'hasChildren': [],
            'parentPage': 'userListing',
            'section':  'Users',
            'dir': 'adminPanel',
            'slug': 'create',
            'title':  'User Create Page',
            'seoTitle':   'Create Page',
            'seoKeywords':   'Create Page, MPS, myplumbingshowroom.com, bravo, business, media',
            'seoRobots': 'noindex, nofollow',
            'security': 200,
            'userSecurity': [ 250 ],
            'withoutRightsCanView': true,
            'allowedSites': [ 0 ],
            'text': [
                {
                    
                }
            ]

        }

        local.metaData.Users.Copy = {

            'alias': 'userCopy',
            'pageButtons': [], 
            'isPage': true,
            'isParent': false,
            'hasParent': true,
            'inNav':    false,
            'atRoot':   false,
            'hasChildren': [],
            'parentPage': 'userListing',
            'section':  'Users',
            'dir': 'adminPanel',
            'slug': 'copy',
            'title':  'User Copy Page',
            'seoTitle':   'Copy Page',
            'seoKeywords':   'Copy Page, MPS, myplumbingshowroom.com, bravo, business, media',
            'seoRobots': 'noindex, nofollow',
            'security': 200,
            'userSecurity': [ 250 ],
            'withoutRightsCanView': true,
            'allowedSites': [ 0 ],
            'text': [
                {
                    
                }
            ]

        }

        local.metaData.Users.Remove = {

            'alias': 'userRemove',
            'pageButtons': [], 
            'isPage': true,
            'isParent': false,
            'hasParent': true,
            'inNav':    false,
            'atRoot':   false,
            'hasChildren': [],
            'parentPage': 'userListing',
            'section':  'Users',
            'dir': 'adminPanel',
            'slug': 'remove',
            'title':  'User Remove Page',
            'seoTitle':   'Remove Page',
            'seoKeywords':   'Remove Page, MPS, myplumbingshowroom.com, bravo, business, media',
            'seoRobots': 'noindex, nofollow',
            'security': 200,
            'userSecurity': [ 250 ],
            'withoutRightsCanView': true,
            'allowedSites': [ 0 ],
            'text': [
                {
                    
                }
            ]

        }

        local.metaData.Users.TradeListing = {

            'alias': 'tradeListing',
            'pageButtons': [], 
            'isPage': true,
            'isParent': true,
            'hasParent': false,
            'inNav':    true,
            'atRoot':   true,
            'hasChildren': [ 'tradeEditing', 'tradeCreate', 'tradeCopy','tradeRemove' ],
            'parentPage': '',
            'section':  'Users',
            'dir': 'adminPanel',
            'slug': 'trade-listing',
            'title': 'Professional',
            'seoTitle':   'Listing Page',
            'seoKeywords':   'Listing Page, MPS, myplumbingshowroom.com, bravo, business, media',
            'seoRobots': 'noindex, nofollow',
            'security': 200,
            'userSecurity': [ 250 ],
            'withoutRightsCanView': true,
            'allowedSites': [ 0 ],
            'text': [
                {
                    
                }
            ]

        }

        local.metaData.Users.TradeEdit = {

            'alias': 'tradeEditing',
            'pageButtons': [], 
            'isPage': true,
            'isParent': false,
            'hasParent': true,
            'inNav':    false,
            'atRoot':   false,
            'hasChildren': [],
            'parentPage': 'tradeListing',
            'section':  'Users',
            'dir': 'adminPanel',
            'slug': 'trade-edit',
            'title':  'User Edit Page',
            'seoTitle':   'Edit Page',
            'seoKeywords':   'Edit Page, MPS, myplumbingshowroom.com, bravo, business, media',
            'seoRobots': 'noindex, nofollow',
            'security': 200,
            'userSecurity': [ 250 ],
            'withoutRightsCanView': true,
            'allowedSites': [ 0 ],
            'text': [
                {
                    
                }
            ]

        }

        local.metaData.Users.TradeCreate = {

            'alias': 'tradeCreate',
            'pageButtons': [], 
            'isPage': true,
            'isParent': false,
            'hasParent': true,
            'inNav':    false,
            'atRoot':   false,
            'hasChildren': [],
            'parentPage': 'tradeListing',
            'section':  'Users',
            'dir': 'adminPanel',
            'slug': 'trade-create',
            'title':  'User Create Page',
            'seoTitle':   'Create Page',
            'seoKeywords':   'Create Page, MPS, myplumbingshowroom.com, bravo, business, media',
            'seoRobots': 'noindex, nofollow',
            'security': 200,
            'userSecurity': [ 250 ],
            'withoutRightsCanView': true,
            'allowedSites': [ 0 ],
            'text': [
                {
                    
                }
            ]

        }

        local.metaData.Users.TradeCopy = {

            'alias': 'tradeCopy',
            'pageButtons': [], 
            'isPage': true,
            'isParent': false,
            'hasParent': true,
            'inNav':    false,
            'atRoot':   false,
            'hasChildren': [],
            'parentPage': 'tradeListing',
            'section':  'Users',
            'dir': 'adminPanel',
            'slug': 'trade-copy',
            'title':  'User Trade Page',
            'seoTitle':   'Trade Page',
            'seoKeywords':   'Trade Page, MPS, myplumbingshowroom.com, bravo, business, media',
            'seoRobots': 'noindex, nofollow',
            'security': 200,
            'userSecurity': [ 250 ],
            'withoutRightsCanView': true,
            'allowedSites': [ 0 ],
            'text': [
                {
                    
                }
            ]

        }

        local.metaData.Users.TradeRemove = {

            'alias': 'tradeRemove',
            'pageButtons': [], 
            'isPage': true,
            'isParent': false,
            'hasParent': true,
            'inNav':    false,
            'atRoot':   false,
            'hasChildren': [],
            'parentPage': 'tradeListing',
            'section':  'Users',
            'dir': 'adminPanel',
            'slug': 'trade-remove',
            'title':  'User Remove Page',
            'seoTitle':   'Remove Page',
            'seoKeywords':   'Remove Page, MPS, myplumbingshowroom.com, bravo, business, media',
            'seoRobots': 'noindex, nofollow',
            'security': 200,
            'userSecurity': [ 250 ],
            'withoutRightsCanView': true,
            'allowedSites': [ 0 ],
            'text': [
                {
                    
                }
            ]

        }

        local.metaData.Users.SiteListing = {

            'alias': 'siteListing',
            'pageButtons': [], 
            'isPage': true,
            'isParent': true,
            'hasParent': false,
            'inNav':    true,
            'atRoot':   true,
            'hasChildren': [ 'siteEditing', 'siteCreate', 'siteCopy', 'siteRemove' ],
            'parentPage': '',
            'section':  'Users',
            'dir': 'adminPanel',
            'slug': 'site-admin-listing',
            'title': 'Site Admin',
            'seoTitle':   'Listing Page',
            'seoKeywords':   'Listing Page, MPS, myplumbingshowroom.com, bravo, business, media',
            'seoRobots': 'noindex, nofollow',
            'security': 200,
            'userSecurity': [ 250 ],
            'withoutRightsCanView': true,
            'allowedSites': [ 0 ],
            'text': [
                {
                    
                }
            ]

        }

        local.metaData.Users.SiteEdit = {

            'alias': 'siteEditing',
            'pageButtons': [], 
            'isPage': true,
            'isParent': false,
            'hasParent': true,
            'inNav':    false,
            'atRoot':   false,
            'hasChildren': [],
            'parentPage': 'siteListing',
            'section':  'Users',
            'dir': 'adminPanel',
            'slug': 'site-admin-edit',
            'title':  'User Edit Page',
            'seoTitle':   'Edit Page',
            'seoKeywords':   'Edit Page, MPS, myplumbingshowroom.com, bravo, business, media',
            'seoRobots': 'noindex, nofollow',
            'security': 200,
            'userSecurity': [ 250 ],
            'withoutRightsCanView': true,
            'allowedSites': [ 0 ],
            'text': [
                {
                    
                }
            ]

        }

        local.metaData.Users.SiteCreate = {

            'alias': 'siteCreate',
            'pageButtons': [], 
            'isPage': true,
            'isParent': false,
            'hasParent': true,
            'inNav':    false,
            'atRoot':   false,
            'hasChildren': [],
            'parentPage': 'siteListing',
            'section':  'Users',
            'dir': 'adminPanel',
            'slug': 'site-admin-create',
            'title':  'User Create Page',
            'seoTitle':   'Create Page',
            'seoKeywords':   'Create Page, MPS, myplumbingshowroom.com, bravo, business, media',
            'seoRobots': 'noindex, nofollow',
            'security': 200,
            'userSecurity': [ 250 ],
            'withoutRightsCanView': true,
            'allowedSites': [ 0 ],
            'text': [
                {
                    
                }
            ]

        }

        local.metaData.Users.SiteCopy = {

            'alias': 'siteCopy',
            'pageButtons': [], 
            'isPage': true,
            'isParent': false,
            'hasParent': true,
            'inNav':    false,
            'atRoot':   false,
            'hasChildren': [],
            'parentPage': 'siteListing',
            'section':  'Users',
            'dir': 'adminPanel',
            'slug': 'site-admin-copy',
            'title':  'User Copy Page',
            'seoTitle':   'Copy Page',
            'seoKeywords':   'Copy Page, MPS, myplumbingshowroom.com, bravo, business, media',
            'seoRobots': 'noindex, nofollow',
            'security': 200,
            'userSecurity': [ 250 ],
            'withoutRightsCanView': true,
            'allowedSites': [ 0 ],
            'text': [
                {
                    
                }
            ]

        }

        local.metaData.Users.SiteRemove = {

            'alias': 'siteRemove',
            'pageButtons': [], 
            'isPage': true,
            'isParent': false,
            'hasParent': true,
            'inNav':    false,
            'atRoot':   false,
            'hasChildren': [],
            'pageParent': 'siteListing',
            'section':  'Users',
            'dir': 'adminPanel',
            'slug': 'site-admin-remove',
            'title':  'User Remove Page',
            'seoTitle':   'Remove Page',
            'seoKeywords':   'Remove Page, MPS, myplumbingshowroom.com, bravo, business, media',
            'seoRobots': 'noindex, nofollow',
            'security': 200,
            'userSecurity': [ 250 ],
            'withoutRightsCanView': true,
            'allowedSites': [ 0 ],
            'text': [
                {
                    
                }
            ]

        }

        local.metaData.Users.AdminListing = {

            'alias': 'adminListing',
            'pageButtons': [], 
            'isPage': true,
            'isParent': true,
            'hasParent': false,
            'inNav':    true,
            'atRoot':   true,
            'hasChildren': [ 'adminEditing', 'adminCreate', 'adminCopy','adminRemove' ],
            'pageParent': '',
            'section':  'Users',
            'dir': 'adminPanel',
            'slug': 'admin-listing',
            'title': 'Global Admin',
            'seoTitle':   'Listing Page',
            'seoKeywords':   'Listing Page, MPS, myplumbingshowroom.com, bravo, business, media',
            'seoRobots': 'noindex, nofollow',
            'security': 255,
            'userSecurity': [ 250 ],
            'withoutRightsCanView': true,
            'allowedSites': [ 284 ],
            'text': [
                {
                    
                }
            ]

        }

        local.metaData.Users.AdminEdit = {

            'alias': 'adminEditing',
            'pageButtons': [], 
            'isPage': true,
            'isParent': false,
            'hasParent': true,
            'inNav':    false,
            'atRoot':   false,
            'hasChildren': [],
            'pageParent': 'adminListing',
            'section':  'Users',
            'dir': 'adminPanel',
            'slug': 'admin-edit',
            'title':  'User Edit Page',
            'seoTitle':   'Edit Page',
            'seoKeywords':   'Edit Page, MPS, myplumbingshowroom.com, bravo, business, media',
            'seoRobots': 'noindex, nofollow',
            'security': 255,
            'userSecurity': [ 250 ],
            'withoutRightsCanView': true,
            'allowedSites': [ 284 ],
            'text': [
                {
                    
                }
            ]

        }

        local.metaData.Users.AdminCreate = {

            'alias': 'adminCreate',
            'pageButtons': [], 
            'isPage': true,
            'isParent': false,
            'hasParent': true,
            'inNav':    false,
            'atRoot':   false,
            'hasChildren': [],
            'pageParent': 'adminListing',
            'section':  'Users',
            'dir': 'adminPanel',
            'slug': 'admin-create',
            'title':  'User Create Page',
            'seoTitle':   'Create Page',
            'seoKeywords':   'Create Page, MPS, myplumbingshowroom.com, bravo, business, media',
            'seoRobots': 'noindex, nofollow',
            'security': 255,
            'userSecurity': [ 250 ],
            'withoutRightsCanView': true,
            'allowedSites': [ 284 ],
            'text': [
                {
                    
                }
            ]

        }

        local.metaData.Users.AdminCopy = {

            'alias': 'adminCopy',
            'pageButtons': [], 
            'isPage': true,
            'isParent': false,
            'hasParent': true,
            'inNav':    false,
            'atRoot':   false,
            'hasChildren': [],
            'pageParent': 'adminListing',
            'section':  'Users',
            'dir': 'adminPanel',
            'slug': 'admin-copy',
            'title':  'User Copy Page',
            'seoTitle':   'Copy Page',
            'seoKeywords':   'Copy Page, MPS, myplumbingshowroom.com, bravo, business, media',
            'seoRobots': 'noindex, nofollow',
            'security': 255,
            'userSecurity': [ 250 ],
            'withoutRightsCanView': true,
            'allowedSites': [ 284 ],
            'text': [
                {
                    
                }
            ]

        }

        local.metaData.Users.AdminRemove = {

            'alias': 'adminRemove',
            'pageButtons': [], 
            'isPage': true,
            'isParent': false,
            'hasParent': true,
            'inNav':    false,
            'atRoot':   false,
            'hasChildren': [],
            'pageParent': 'adminListing',
            'section':  'Users',
            'dir': 'adminPanel',
            'slug': 'admin-remove',
            'title':  'User Remove Page',
            'seoTitle':   'Remove Page',
            'seoKeywords':   'Remove Page, MPS, myplumbingshowroom.com, bravo, business, media',
            'seoRobots': 'noindex, nofollow',
            'security': 255,
            'userSecurity': [ 250 ],
            'withoutRightsCanView': true,
            'allowedSites': [ 284 ],
            'text': [
                {
                    
                }
            ]

        }


        local.metaData.Users.AllListing = {

            'alias': 'allListing',
            'pageButtons': [], 
            'isPage': true,
            'isParent': true,
            'hasParent': false,
            'inNav':    true,
            'atRoot':   true,
            'hasChildren': [ 'allEditing', 'allCreate', 'allCopy','allRemove' ],
            'pageParent': '',
            'section':  'Users',
            'dir': 'adminPanel',
            'slug': 'all-listing',
            'title': 'All Users',
            'seoTitle':   'Listing Page',
            'seoKeywords':   'Listing Page, MPS, myplumbingshowroom.com, bravo, business, media',
            'seoRobots': 'noindex, nofollow',
            'security': 200,
            'userSecurity': [ 250 ],
            'withoutRightsCanView': true,
            'allowedSites': [ 0 ],
            'text': [
                {
                    
                }
            ]

        }

        local.metaData.Users.AllEdit = {

            'alias': 'allEditing',
            'pageButtons': [], 
            'isPage': true,
            'isParent': false,
            'hasParent': true,
            'inNav':    false,
            'atRoot':   false,
            'hasChildren': [],
            'pageParent': 'allListing',
            'section':  'Users',
            'dir': 'adminPanel',
            'slug': 'all-edit',
            'title':  'User Edit Page',
            'seoTitle':   'Edit Page',
            'seoKeywords':   'Edit Page, MPS, myplumbingshowroom.com, bravo, business, media',
            'seoRobots': 'noindex, nofollow',
            'security': 200,
            'userSecurity': [ 250 ],
            'withoutRightsCanView': true,
            'allowedSites': [ 0 ],
            'text': [
                {
                    
                }
            ]

        }

        local.metaData.Users.AllCreate = {

            'alias': 'allCreate',
            'pageButtons': [], 
            'isPage': true,
            'isParent': false,
            'hasParent': true,
            'inNav':    false,
            'atRoot':   false,
            'hasChildren': [],
            'pageParent': 'allListing',
            'section':  'Users',
            'dir': 'adminPanel',
            'slug': 'all-create',
            'title':  'User Create Page',
            'seoTitle':   'Create Page',
            'seoKeywords':   'Create Page, MPS, myplumbingshowroom.com, bravo, business, media',
            'seoRobots': 'noindex, nofollow',
            'security': 200,
            'userSecurity': [ 250 ],
            'withoutRightsCanView': true,
            'allowedSites': [ 0 ],
            'text': [
                {
                    
                }
            ]

        }

        local.metaData.Users.AllCopy = {

            'alias': 'allCopy',
            'pageButtons': [], 
            'isPage': true,
            'isParent': false,
            'hasParent': true,
            'inNav':    false,
            'atRoot':   false,
            'hasChildren': [],
            'pageParent': 'allListing',
            'section':  'Users',
            'dir': 'adminPanel',
            'slug': 'all-copy',
            'title':  'User Copy Page',
            'seoTitle':   'Copy Page',
            'seoKeywords':   'Copy Page, MPS, myplumbingshowroom.com, bravo, business, media',
            'seoRobots': 'noindex, nofollow',
            'security': 200,
            'userSecurity': [ 250 ],
            'withoutRightsCanView': true,
            'allowedSites': [ 0 ],
            'text': [
                {
                    
                }
            ]

        }

        local.metaData.Users.AllRemove = {

            'alias': 'allRemove',
            'pageButtons': [], 
            'isPage': true,
            'isParent': false,
            'hasParent': true,
            'inNav':    false,
            'atRoot':   false,
            'hasChildren': [],
            'pageParent': 'allListing',
            'section':  'Users',
            'dir': 'adminPanel',
            'slug': 'all-remove',
            'title':  'User Remove Page',
            'seoTitle':   'Remove Page',
            'seoKeywords':   'Remove Page, MPS, myplumbingshowroom.com, bravo, business, media',
            'seoRobots': 'noindex, nofollow',
            'security': 200,
            'userSecurity': [ 250 ],
            'withoutRightsCanView': true,
            'allowedSites': [ 0 ],
            'text': [
                {
                    
                }
            ]

        }

        local.metaData.Users.Check = {

            'alias': 'userCheck',
            'pageButtons': [], 
            'isPage': true,
            'isParent': false,
            'hasParent': false,
            'inNav':    false,
            'atRoot':   true,
            'hasChildren': [],
            'pageParent': '',
            'section':  'Users',
            'dir': 'adminPanel',
            'slug': 'check',
            'title': 'User Check',
            'seoTitle':   'User Check',
            'seoKeywords':   'User Check, MPS, myplumbingshowroom.com, bravo, business, media',
            'seoRobots': 'noindex, nofollow',
            'security': 200,
            'userSecurity': [ 0 ],
            'withoutRightsCanView': false,
            'allowedSites': [ 0 ],
            'text': [
                {
                    
                }
            ]

        }

        local.metaData.Users.GetInfo = {
            'alias': 'userGetInfo',
            'pageButtons': [], 
            'isPage': true,
            'isParent': false,
            'hasParent': false,
            'inNav':    false,
            'atRoot':   true,
            'hasChildren': [],
            'pageParent': '',
            'section':  'Users',
            'dir': 'adminPanel',
            'slug': 'get-info',
            'title': 'Get User Info',
            'seoTitle':   'Get User Info',
            'seoKeywords':   'Get User Info, MPS, myplumbingshowroom.com, bravo, business, media',
            'seoRobots': 'noindex, nofollow',
            'security': 200,
            'allowedSites': [ 0 ],
            'text': [
                {
                    
                }
            ]
        }

        local.metaData.Users.GetInfoByEmail = {
            'alias': 'userGetInfoByEmail',
            'pageButtons': [], 
            'isPage': true,
            'isParent': false,
            'hasParent': false,
            'inNav':    false,
            'atRoot':   true,
            'hasChildren': [],
            'pageParent': '',
            'section':  'Users',
            'dir': 'adminPanel',
            'slug': 'get-info-by-email',
            'title': 'Get User Info By Email',
            'seoTitle':   'Get User Info By Email',
            'seoKeywords':   'Get User Info By Email, MPS, myplumbingshowroom.com, bravo, business, media',
            'seoRobots': 'noindex, nofollow',
            'security': 200,
            'allowedSites': [ 0 ],
            'text': [
                {
                    
                }
            ]
        }

        local.metaData.Users.Export = {
            'alias': 'userExport',
            'pageButtons': [], 
            'isPage': true,
            'isParent': false,
            'hasParent': false,
            'inNav':    false,
            'atRoot':   true,
            'hasChildren': [],
            'pageParent': '',
            'section':  'Users',
            'dir': 'adminPanel',
            'slug': 'export',
            'title': 'Export',
            'seoTitle':   'Export',
            'seoKeywords':   'ail, MPS, myplumbingshowroom.com, bravo, business, media',
            'seoRobots': 'noindex, nofollow',
            'security': 200,
            'allowedSites': [ 0 ],
            'text': [
                {
                    
                }
            ]
        } 

    /*************************************************************************/
    /*  Auth Pages
    /*************************************************************************/

        local.metaData.Auth.Login = {
            'alias': 'authLogin',
            'pageButtons': [], 
            'isPage': true,
            'isParent': false,
            'hasParent': false,
            'inNav':    false,
            'atRoot':   true,
            'hasChildren': [],
            'pageParent': '',
            'section':  'Auth',
            'dir': 'adminPanel',
            'slug': 'login',
            'title': 'Auth - Login',
            'seoTitle':   'Auth',
            'seoKeywords':   'Auth, Login, MPS, myplumbingshowroom.com, bravo, business, media',
            'seoRobots': 'noindex, nofollow',
            'security': 200,
            'allowedSites': [ 0 ],
            'text': [
                {
                    
                }
            ]
        }

</cfscript>