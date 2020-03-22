<cfcomponent displayName="DashboardView" output=true>

    <!---   **********************************************************************  --->
    <!---   *  Dashboard aka At A Glance Page - START                               --->
    <!---   **********************************************************************  --->


        <cffunction name="Dashboard_Dashboard_VIEW" access="PUBLIC" returntype="void" output=true hint="">
            <cfargument name="urlData"      type="struct"   required=true>
            <cfargument name="queryData"    type="query"    required=false default="#queryNew( '' )#">
            <cfargument name="dataPayload"  type="struct"   required=false default="#{}#">

            <cfoutput>

                <div class="card-page card-dashboard-analytics card-outline-info">

                    <div class="card-header">

                        <h4 class="m-b-0t">#application.adminPanel.metaData.navigation[ urlData[ 'route' ] ][ urlData[ 'page' ] ].title#</h4>

                    </div>


                    <div class="card-body"> 
                        
                        <cfif len( session.adminPanel.user.site ) && session.adminPanel.user.ownedSites>
                            <cfset variables.Dashboard_Dashboard_VIEW___Intro( urlData )>
                            <!--- <cfset variables.Dashboard_Dashboard_VIEW___AnalyticsPreview( urlData )> --->
                        <cfelse>
                            <cfset variables.Dashboard_Dashboard_VIEW___SelectSites( urlData, queryData )>                            
                        </cfif>
            
                    </div>

                </div>       

                <cfif len( session.adminPanel.user.site ) && session.adminPanel.user.ownedSites>

                    <div class="row">

                        <cfset variables.Dashboard_Dashbarod_VIEW___SupportTicketsWidget( urlData, dataPayload )>

                        <cfset variables.Dashboard_Dashboard_VIEW___AdvertWidget( urlData )>

                        <cfset variables.Dashboard_Dashboard_VIEW___ProjectsWishListsDisplayWidget( urlData )>

                        <cfset variables.Dashboard_Dashboard_VIEW___BrandsList( urlData )>

                    </div>


                </cfif>

            </cfoutput>

        </cffunction>

        <cffunction name="Dashboard_Dashboard_VIEW___Intro" access="PRIVATE" returntype="void" output=true hint="">
            <cfargument name="urlData" type="struct" required=true>

            <cfoutput>

                <p>

                    Welcome to your control panel!

                </p>

            </cfoutput>

        </cffunction>

        <cffunction name="Dashboard_Dashboard_VIEW___SelectSites" access="PRIVATE" returntype="void" output=true hint="">
            <cfargument name="urlData"          type="struct"   required=true>
            <cfargument name="userQueryData"    type="query"    required=true>
            <cfargument name="debug"            type="boolean"  required=false default=false>

            <cfoutput>
                
                <table id="renderDataTable" class="display compact dataTable" cellspacing="0" width="100%">

                    <thead class="dataTable___TableHead">
                        <tr class="dataTable___TableHead___QueryRow">
                            <th class="dataTable___TableHead___QueryRow___QueryHeader">
                                Site
                            </th>
                            <th class="dataTable___TableHead___QueryRow___QueryHeader">
                                City
                            </th>
                            <th class="dataTable___TableHead___QueryRow___QueryHeader">
                                State
                            </th>
                        </tr>
                    </thead>

                    <tbody class="dataTable___TableBody">
                        <cfloop query="userQueryData">
                            <tr class="dataTable___TableBody___QueryRow">
                                <td class="dataTable___TableBody___QueryRow___QueryCell">
                                    <a href="javascript:void(0)" data-id="#userQueryData.EntryPointCode#" data-count="#userQueryData.recordCount#" class="dataTable___TableBody___QueryRow___QueryCell___Href">#userQueryData.EstablishmentFullName#</a>
                                </td>
                                <td class="dataTable___TableBody___QueryRow___QueryCell">
                                    <a href="javascript:void(0)" data-id="#userQueryData.EntryPointCode#" data-count="#userQueryData.recordCount#" class="dataTable___TableBody___QueryRow___QueryCell___Href">#userQueryData.EstablishmentCity#</a>
                                </td>
                                <td class="dataTable___TableBody___QueryRow___QueryCell">
                                    <a href="javascript:void(0)" data-id="#userQueryData.EntryPointCode#" data-count="#userQueryData.recordCount#" class="dataTable___TableBody___QueryRow___QueryCell___Href">#userQueryData.EstablishmentState#</a>
                                </td>
                            </th>
                            
                        </cfloop>
                    </tbody>

                </table>

            </cfoutput>

        </cffunction>

        <cffunction name="Dashboard_Dashboard_VIEW___AnalyticsPreview" access="PRIVATE" returntype="void" output=true hint="">
            <cfargument name="urlData"  type="struct" required=true>

            <cfoutput>

                <div class="row">

                    <div class="col text-center mt-4">
                        <h6>Analytics Preview</h6>
                        <hr>
                    </div>

                </div>
    
                <div class="row">

                    <div class="col-xl-4 col-lg-4 col-md-6 col-sm-12 grid-margin stretch-card">

                        <div class="card card-statistics card-outline-danger">

                            <div class="card-header">
                                <h4 class="m-b-0 ">Unique Visitors</h4>
                            </div>

                            <div class="card-body">

                                <div class="clearfix">

                                    <div class="text-center"> 
                                        <i class="mdi mdi-poll-box text-danger icon-lg"></i> 
                                    </div>

                                    <div class="text-center">

                                        <div class="fluid-container">
                                            <h3 class="font-weight-medium mb-0">5,310</h3>
                                        </div>

                                    </div>

                                </div>

                                <p class="text-muted mt-3 mb-0 text-left">
                                    <!--<i class="mdi mdi-alert-octagon mr-1" aria-hidden="true">&nbsp;</i>-->"Unique visitors" refers to the number of distinct individuals requesting pages from the website during a given period, regardless of how often they visit.
                                </p>

                            </div>

                        </div>

                    </div>

                    <div class="col-xl-4 col-lg-4 col-md-6 col-sm-12 grid-margin stretch-card">

                        <div class="card card-statistics card-outline-warning">

                            <div class="card-header">
                                <h4 class="m-b-0">Organic Traffic</h4>
                            </div>

                            <div class="card-body">

                                <div class="clearfix">

                                    <div class="text-center"> 
                                        <i class="mdi mdi-receipt text-warning icon-lg"></i> 
                                    </div>

                                    <div class="text-center">

                                        <div class="fluid-container">
                                            <h3 class="font-weight-medium mb-0">2,890</h3>
                                        </div>

                                    </div>

                                </div>

                                <p class="text-muted mt-3 mb-0">
                                    <!--<i class="mdi mdi-bookmark-outline mr-1 text-left" aria-hidden="true"></i>-->
                                    The term "Organic Traffic" is used for referring to the visitors that land on your website as a result of unpaid ("organic") search results.&nbsp;...&nbsp;
                                    Visitors who are considered organic find your website after using a search engine like Google or Bing, so they are not "referred" by any other website.
                                </p>

                            </div>

                        </div>

                    </div>

                    <div class="col-xl-4 col-lg-4 col-md-6 col-sm-12 grid-margin stretch-card">

                        <div class="card card-statistics card-outline-success">

                            <div class="card-header">
                                <h4 class="m-b-0">Paid Media</h4>
                            </div>

                            <div class="card-body">

                                <div class="clearfix">

                                    <div class="text-center"> 
                                        <i class="mdi mdi-currency-usd text-success icon-lg"></i> 
                                    </div>

                                    <div class="text-center">

                                        <div class="fluid-container">

                                            <h3 class="font-weight-medium mb-0">375</h3>

                                        </div>

                                    </div>

                                </div>

                                <p class="text-muted mt-3 mb-0 text-left">
                                    "Paid Media" refers to external marketing efforts that involve a paid placement. Paid media includes PPC advertising, branded content, and display ads.
                                </p>
                                
                            </div>

                        </div>

                    </div>

                    <div class="col-lg-4 col-md-4 col-sm-12 col-xs-12"></div>

                    <div class="col-lg-4 col-md-12 col-sm-12 col-xs-12">
                        <button type="button" class="btn btn-block btn-lg btn-theme">View Analytics</button>
                    </div>

                    <div class="col-lg-4 hidden-md-down"></div>

                </div>

            </cfoutput>

        </cffunction>

        <cffunction name="Dashboard_Dashbarod_VIEW___SupportTicketsWidget" access="PRIVATE" returntype='void' hint=''>
            <cfargument name="urlData"          type="struct"   required=true>
            <cfargument name="dataPayload"      type="struct"   required=true>

            <cfoutput>

                <!--- numerics --->
                <cfset i = 1>

                <!--- structs --->
                <cfset idx = {}>
                  
                <!-- column -->
                <div id="support-requests" class="col-xl-6 col-lg-6 col-md-6 col-xs-3 widget-style--list">
                    <!-- Card -->
                    <div class="card">

                        <div class="card-img-holder">
                            <img class="card-img-top img-fluid" src="/img/common/support.jpg" alt="Card image cap">
                            <h4 class="card-img-holder__title">Support Requests</h4>
                        </div>

                        <div class="card-body">

                            <ul>


                                <cfif structCount( dataPayload[ 'supporTickets' ] ) AND NOT structKeyExists( dataPayload[ 'supporTickets' ], 'errors' )>
                                    <cfloop array="#dataPayload[ 'supporTickets' ]#" index='idx'>
                                        <li class="card-text" data-id='#idx[ 'id' ]#'>
                                            <a href='http://support.bravobusinessmedia.com/a/tickets/#idx[ 'id' ]#' target='_blank'>
                                                <div class="card-support">
                                                    <span class="fa-stack fa-lg"><i class="fa fa-square fa-stack-2x"></i><i class="fa fa-clipboard fa-stack-1x fa-inverse"></i></span> #idx[ 'subject' ]# <br>
                                                    <hr> <br>
                                                    <p>#idx[ 'custom_fields' ][ 'issuerequestdescription' ]#</p>
                                                    <div class="card-support-details">
                                                        <cfif len( idx[ 'type' ] ) > <span class="info-tabs info-tabs-type" ><span class="info-tabs__icons"><i class="far fa-question-circle"></i></span>Type&nbsp;:&nbsp;#idx[ 'type' ]#&nbsp;&nbsp;</span> </cfif>
                                                        <cfif len( APPLICATION[ 'supportTicketsAttributes' ][ 'Source' ][ idx[ 'source' ] ] )><span class="info-tabs info-tabs-source"><span class="info-tabs__icons"><i class="fas fa-broadcast-tower"></i></span>Source&nbsp;:&nbsp;#APPLICATION[ 'supportTicketsAttributes' ][ 'Source' ][ idx[ 'source' ] ]#&nbsp;&nbsp;</span></cfif>
                                                        <cfif len( APPLICATION[ 'supportTicketsAttributes' ][ 'Status' ][ idx[ 'status' ] ] )> <span class="info-tabs info-tabs-status"><span class="info-tabs__icons"><i class="far fa-bell"></i></span>Status&nbsp;:&nbsp;#APPLICATION[ 'supportTicketsAttributes' ][ 'Status' ][ idx[ 'status' ] ]#&nbsp;&nbsp;</span></cfif>
                                                        <cfif len( APPLICATION[ 'supportTicketsAttributes' ][ 'Priority' ][ idx[ 'priority' ] ] )><span class="info-tabs info-tabs-priority"><span class="info-tabs__icons"><i class="fas fa-bullhorn"></i></span>Priority&nbsp;:&nbsp;#APPLICATION[ 'supportTicketsAttributes' ][ 'Priority' ][ idx[ 'priority' ] ]#&nbsp;&nbsp;</span></cfif>
                                                    </div>
                                                </div>
                                            </a>
                                        </li>
                                        <cfset i++>
                                        <cfif i gte 6> <cfbreak> </cfif>
                                    </cfloop>

                                <cfelse>


                                    <li class="card-text">
                                        <a href="javascript:void(0)">
                                            <div class="card-support">
                                                <span class="fa-stack fa-lg"><i class="fa fa-square fa-stack-2x"></i><i class="fa fa-clipboard fa-stack-1x fa-inverse"></i></span> No Support Request Tickets <br>
                                                <hr> <br>
                                                <p>You currently have no support tickets open</p>
                                            </div>
                                        </a>
                                    </li>

                                </cfif>

                            </ul>
                            <a href="http://support.bravobusinessmedia.com/" class="btn btn-theme">Login To The Support Channel</a>
                        </div>

                    </div>
                    <!-- Card -->
                </div>
                <!-- column -->

            </cfoutput>

        </cffunction>

        <cffunction name="Dashboard_Dashboard_VIEW___AdvertWidget" access="PRIVATE" returntype="void" hint=''>
            <cfargument name="urlData"      type="struct"   required=true>
            
            <cfoutput>

                <div id="promo-widget" class="col-xl-6 col-lg-6 col-md-6 col-xs-3 widget-style--single-image">

                    <img src="/img/common/ad_placeholder.jpg">

                </div>

            </cfoutput>

        </cffunction>

        <cffunction name="Dashboard_Dashboard_VIEW___ProjectsWishListsDisplayWidget" access="PRIVATE" returntype="void" hint=''>
            <cfargument name="urlData"      type="struct"      required=true>

            <cfoutput>

                <div id="projects-wish-list" class="col-xl-12 col-lg-12 col-md-12 col-xs-12 widget-style--ticker">

                        <div class="card">

                            <div class="card-img-holder">

                                <img class="card-img-top img-fluid" src="/img/common/money.jpg" alt="Card image cap">
                                <h4 class="card-img-holder__title">Projects &amp; Wish Lists</h4>

                            </div>

                            <div class="card-display">

                                <div class="card-display___items row">

                                    <div class="card-display___items___filter col-xl-12 col-lg-12 col-md-12 col-xs-12">
                                        

                                        <button type="Button" class="btn btn-secondary"><i class="fa fa-lg fa-filter">&nbsp;&nbsp;</i>Filter</button>
                                        <button type="button" class="btn btn-secondary dropdown-toggle dropdown-toggle-split" data-toggle='dropdown' aria-haspopup="true" aria-expanded="false">
                                            <span><i class="fas fa-chevron-down"></i></span>
                                        </button>
        
                                        <div class="dropdown-menu">
                                                                                                                                                                    
                                            <a href="javascript:void(0)" data-href="##" class="dropdown-item" data-toggle="tooltip" title="This will allow you to edit your user (Note: Admin Users can only edit their users on the admin site)">
                                                Past 30 Days
                                            </a>

                                            <a href="javascript:void(0)" class="dropdown-item" data-toggle="tooltip" title="This will log you out of the application">
                                                Past 90 Days
                                            </a>

                                            <a href="javascript:void(0)" class="dropdown-item" data-toggle="tooltip" title="This will log you out of the application">
                                                Past 180 Days
                                            </a>

                                            <a href="javascript:void(0)" class="dropdown-item" data-toggle="tooltip" title="This will log you out of the application">
                                                Past 360 Days
                                            </a>

                                        </div>

                                    </div>

                                    <div class="card-display___items___box-holder col-xl-12 col-lg-12 col-md-12 col-xs-12 row">

                                        <div class="card-display___items___box col-xl-3 col-lg-3 col-md-3 col-xs-3">

                                            <div class="card">

                                                <div class="card-body">

                                                    <div class="row">

                                                        <div class="card-display___items___box___header col-12">
                                                            <h6>Wish Lists</h6>
                                                        </div>

                                                        <div class="col-8">
                                                            <span class="display-12 counter" data-count="#trim(999)#">0<i class="ti-angle-down font-14 text-danger"></i></span>
                                                        </div>
                                                        <div class="col-4 align-self-center text-right  pl-0">
                                                            <div id="sparklinedash3" class="sp-charts"><canvas width="51" height="50" style="display: inline-block; width: 51px; height: 50px; vertical-align: top;"></canvas></div>
                                                        </div>

                                                    </div>

                                                </div>

                                            </div>

                                        </div>
                                        
                                        <div class="card-display___items___box col-xl-3 col-lg-3 col-md-3 col-xs-3">
                                            
                                            <div class="card">

                                                <div class="card-body">

                                                    <div class="row">

                                                        <div class="card-display___items___box___header col-12">
                                                            <h6>Value of Wish Lists</h6>
                                                        </div>

                                                        <div class="col-8">
                                                            $<span class="display-12 counter" data-count="#trim(999999999)#">0<i class="ti-angle-down font-14 text-danger"></i></span>
                                                        </div>

                                                        <div class="col-4 align-self-center text-right  pl-0">
                                                            <div id="sparklinedash2" class="sp-charts"><canvas width="51" height="50" ></canvas></div>
                                                        </div>

                                                    </div>

                                                </div>

                                            </div>

                                        </div>
                                        
                                        <div class="card-display___items___box col-xl-3 col-lg-3 col-md-3 col-xs-3">

                                            <div class="card">

                                                <div class="card-body">

                                                    <div class="row">

                                                        <div class="card-display___items___box___header col-12">
                                                            <h6>SPEX Builder Created</h6>
                                                        </div>

                                                        <div class="col-8">
                                                            <span class="display-12 counter" data-count="#trim(666)#">0<i class="ti-angle-down font-14 text-danger"></i></span>
                                                        </div>
                                                        <div class="col-4 align-self-center text-right  pl-0">
                                                            <div id="sparklinedash4" class="sp-charts"><canvas width="51" height="50" ></canvas></div>
                                                        </div>

                                                    </div>

                                                </div>

                                            </div>

                                        </div>

                                    </div>

                                </div>

                            </div>

                        </div>

                </div>

            </cfoutput>

        </cffunction>

        <cffunction name="Dashboard_Dashboard_VIEW___WishlistAssiociates" access="PRIVATE" returntype="void" output=true hint="">

            <cfoutput>
                
                <div class="row">

                    <div class="col text-center mt-4">

                        <h6>Wish List Associates</h6>
                        <hr>

                    </div>

                </div>
    
                <div class="row el-element-overlay">

                    <div class="col-lg-3 col-md-6">

                        <div class="card">

                            <div class="el-card-item">

                                <div class="el-card-avatar el-overlay-1">
                                    
                                    <img src="/img/users/1.jpg" alt="user">

                                    <div class="el-overlay">

                                        <ul class="el-info">
                                            <li><a class="btn default btn-outline image-popup-vertical-fit" href="/img/users/1.jpg"><i class="icon-magnifier"></i></a></li>
                                            <li><a class="btn default btn-outline" href="javascript:void(0);"><i class="icon-link"></i></a></li>
                                        </ul>

                                    </div>

                                </div>

                                <div class="el-card-content">
                                    <h3 class="box-title">Genelia Deshmukh</h3> <small>Managing Director</small>
                                    <br> 
                                </div>

                            </div>
                            
                        </div>

                    </div>

                    <div class="col-lg-3 col-md-6">

                        <div class="card">

                            <div class="el-card-item">

                                <div class="el-card-avatar el-overlay-1">

                                    <img src="/img/users/2.jpg" alt="user">

                                    <div class="el-overlay">

                                        <ul class="el-info">
                                            <li><a class="btn default btn-outline image-popup-vertical-fit" href="/img/users/2.jpg"><i class="icon-magnifier"></i></a></li>
                                            <li><a class="btn default btn-outline" href="javascript:void(0);"><i class="icon-link"></i></a></li>
                                        </ul>

                                    </div>

                                </div>

                                <div class="el-card-content">
                                    <h3 class="box-title">Genelia Deshmukh</h3> <small>Managing Director</small>
                                    <br> 
                                </div>

                            </div>

                        </div>

                    </div>

                    <div class="col-lg-3 col-md-6">

                        <div class="card">

                            <div class="el-card-item">

                                <div class="el-card-avatar el-overlay-1"> 

                                    <img src="/img/users/3.jpg" alt="user">

                                    <div class="el-overlay">

                                        <ul class="el-info">
                                            <li><a class="btn default btn-outline image-popup-vertical-fit" href="/img/users/3.jpg"><i class="icon-magnifier"></i></a></li>
                                            <li><a class="btn default btn-outline" href="javascript:void(0);"><i class="icon-link"></i></a></li>
                                        </ul>

                                    </div>

                                </div>

                                <div class="el-card-content">
                                    <h3 class="box-title">Genelia Deshmukh</h3> <small>Managing Director</small>
                                    <br> 
                                </div>

                            </div>

                        </div>

                    </div>

                    <div class="col-lg-3 col-md-6">

                        <div class="card">

                            <div class="el-card-item">

                                <div class="el-card-avatar el-overlay-1">
                                    
                                    <img src="/img/users/4.jpg" alt="user">

                                    <div class="el-overlay">

                                        <ul class="el-info">
                                            <li><a class="btn default btn-outline image-popup-vertical-fit" href="/img/users/4.jpg"><i class="icon-magnifier"></i></a></li>
                                            <li><a class="btn default btn-outline" href="javascript:void(0);"><i class="icon-link"></i></a></li>
                                        </ul>
                                        
                                    </div>

                                </div>

                                <div class="el-card-content">
                                    <h3 class="box-title">Genelia Deshmukh</h3> <small>Managing Director</small>
                                    <br> 
                                </div>

                            </div>

                        </div>

                    </div>

                </div>

            </cfoutput>
            
        </cffunction>

        <cffunction name="Dashboard_Dashboard_VIEW___BrandsList" access="PRIVATE" returntype="void" output=true hint="">
            <cfargument name="urlData" type="struct" required=true>

            <cfoutput>

                <div id="brands-display" class="col-12 widget-style widget-style--carousel">

                    <div class="card brands">

                        <div class="card-img-holder">

                            <img class="card-img-top img-fluid" src="/img/dashboard/brand_banner.png" alt="Card image cap">
                            <h4 class="card-img-holder__title">Brands</h4>

                        </div>

                        <div class="card-display">

                            <div id="brand-carousel" class="carousel slide" data-ride="carousel">

                                <ol class="carousel-indicators">
    
                                    <li data-target="brand-carousel" data-slide-to='0' class="active"></li>
                                    <li data-target="brand-carousel" data-slide-to="1"></li>
                                    <li data-target="brand-carousel" data-slide-to="2"></li>
    
                                </ol>
    
                                <div class="carousel-inner">
    
                                  <div class="carousel-item active">
    
                                    <ul class="brand-carousel___container">
    
                                        <li>
                                            <a href="https://placeholder.com"><img src="https://via.placeholder.com/150.png/"></a>
                                        </li>
    
                                        <li>
                                            <a href="https://placeholder.com"><img src="https://via.placeholder.com/150.png/"></a>
                                        </li>
    
                                        <li>
                                            <a href="https://placeholder.com"><img src="https://via.placeholder.com/150.png/"></a>
                                        </li>
    
                                        <li>
                                            <a href="https://placeholder.com"><img src="https://via.placeholder.com/150.png/"></a>
                                        </li>
    
                                        <li>
                                            <a href="https://placeholder.com"><img src="https://via.placeholder.com/150.png/"></a>
                                        </li>
    
                                        <li>
                                            <a href="https://placeholder.com"><img src="https://via.placeholder.com/150.png/"></a>
                                        </li>
    
                                        <li>
                                            <a href="https://placeholder.com"><img src="https://via.placeholder.com/150.png/"></a>
                                        </li>
    
                                        <li>
                                            <a href="https://placeholder.com"><img src="https://via.placeholder.com/150.png/"></a>
                                        </li>
    
                                        <li>
                                            <a href="https://placeholder.com"><img src="https://via.placeholder.com/150.png/"></a>
                                        </li>

                                        <li>
                                            <a href="https://placeholder.com"><img src="https://via.placeholder.com/150.png/"></a>
                                        </li>
    
                                    </ul>
    
                                  </div>
    
                                  <div class="carousel-item">
    
                                    <ul class="brand-carousel___container">
    
                                        <li>
                                            <a href="https://placeholder.com"><img src="https://via.placeholder.com/150.png/"></a>
                                        </li>
    
                                        <li>
                                            <a href="https://placeholder.com"><img src="https://via.placeholder.com/150.png/"></a>
                                        </li>
    
                                        <li>
                                            <a href="https://placeholder.com"><img src="https://via.placeholder.com/150.png/"></a>
                                        </li>
    
                                        <li>
                                            <a href="https://placeholder.com"><img src="https://via.placeholder.com/150.png/"></a>
                                        </li>
    
                                        <li>
                                            <a href="https://placeholder.com"><img src="https://via.placeholder.com/150.png/"></a>
                                        </li>
    
                                        <li>
                                            <a href="https://placeholder.com"><img src="https://via.placeholder.com/150.png/"></a>
                                        </li>
    
                                        <li>
                                            <a href="https://placeholder.com"><img src="https://via.placeholder.com/150.png/"></a>
                                        </li>
    
                                        <li>
                                            <a href="https://placeholder.com"><img src="https://via.placeholder.com/150.png/"></a>
                                        </li>
    
                                        <li>
                                            <a href="https://placeholder.com"><img src="https://via.placeholder.com/150.png/"></a>
                                        </li>

                                        <li>
                                            <a href="https://placeholder.com"><img src="https://via.placeholder.com/150.png/"></a>
                                        </li>
    
                                    </ul>
    
                                  </div>
    
                                  <div class="carousel-item">
    
                                    <ul class="brand-carousel___container">
    
                                        <li>
                                            <a href="https://placeholder.com"><img src="https://via.placeholder.com/150.png/"></a>
                                        </li>
    
                                        <li>
                                            <a href="https://placeholder.com"><img src="https://via.placeholder.com/150.png/"></a>
                                        </li>
    
                                        <li>
                                            <a href="https://placeholder.com"><img src="https://via.placeholder.com/150.png/"></a>
                                        </li>
    
                                        <li>
                                            <a href="https://placeholder.com"><img src="https://via.placeholder.com/150.png/"></a>
                                        </li>
    
                                        <li>
                                            <a href="https://placeholder.com"><img src="https://via.placeholder.com/150.png/"></a>
                                        </li>
    
                                        <li>
                                            <a href="https://placeholder.com"><img src="https://via.placeholder.com/150.png/"></a>
                                        </li>
    
                                        <li>
                                            <a href="https://placeholder.com"><img src="https://via.placeholder.com/150.png/"></a>
                                        </li>
    
                                        <li>
                                            <a href="https://placeholder.com"><img src="https://via.placeholder.com/150.png/"></a>
                                        </li>
    
                                        <li>
                                            <a href="https://placeholder.com"><img src="https://via.placeholder.com/150.png/"></a>
                                        </li>

                                        <li>
                                            <a href="https://placeholder.com"><img src="https://via.placeholder.com/150.png/"></a>
                                        </li>
    
                                    </ul>
    
                                  </div>
    
                                </div>
    
                                <a class="carousel-control-prev" href="##brand-carousel" role="button" data-slide="prev">
                                    <span class="carousel-control-prev-icon" aria-hidden="true"></span>
                                    <span class="sr-only">Previous</span>
                                </a>
    
                                <a class="carousel-control-next" href="##brand-carousel" role="button" data-slide="next">
                                    <span class="carousel-control-next-icon" aria-hidden="true"></span>
                                    <span class="sr-only">Next</span>
                                </a>
    
                            </div>

                        </div>

                    </div>

                </div>

            </cfoutput>

        </cffunction>


    <!---   **********************************************************************  --->
    <!---   *  Dashboard aka At A Glance Page - END                                 --->
    <!---   **********************************************************************  --->


    <!---   **********************************************************************  --->
    <!---   *   Dashboard Users Sites View For Right Sidebar - START                --->
    <!---   **********************************************************************  --->

        <cffunction name="Dashboard_UserSites_VIEW" access="PUBLIC" returntype="void" output=true hint="">
            <cfargument name="urlData"          type="struct"   required=true>
            <cfargument name="userQueryData"    type="query"    required=true>
            <cfargument name="debug"            type="boolean"  required=false default=false>

            <cfoutput>

                <table id="renderDataTable" class="display compact dataTable" cellspacing="0" width="100%">

                    <thead class="dataTable___TableHead">
                        <tr class="dataTable___TableHead___QueryRow">
                            <th class="dataTable___TableHead___QueryRow___QueryHeader">
                                Site
                            </th>
                            <th class="dataTable___TableHead___QueryRow___QueryHeader">
                                City
                            </th>
                            <th class="dataTable___TableHead___QueryRow___QueryHeader">
                                State
                            </th>
                        </tr>
                    </thead>

                    <tbody class="dataTable___TableBody">
                        <cfloop query="userQueryData">
                            <tr class="dataTable___TableBody___QueryRow">
                                <td class="dataTable___TableBody___QueryRow___QueryCell">
                                    <a href="javascript:void(0)" data-id="#userQueryData.EntryPointCode#" data-count="#userQueryData.recordCount#" class="dataTable___TableBody___QueryRow___QueryCell___Href">#userQueryData.EstablishmentFullName#</a>
                                </td>
                                <td class="dataTable___TableBody___QueryRow___QueryCell">
                                    <a href="javascript:void(0)" data-id="#userQueryData.EntryPointCode#" data-count="#userQueryData.recordCount#" class="dataTable___TableBody___QueryRow___QueryCell___Href">#userQueryData.EstablishmentCity#</a>
                                </td>
                                <td class="dataTable___TableBody___QueryRow___QueryCell">
                                    <a href="javascript:void(0)" data-id="#userQueryData.EntryPointCode#" data-count="#userQueryData.recordCount#" class="dataTable___TableBody___QueryRow___QueryCell___Href">#userQueryData.EstablishmentState#</a>
                                </td>
                            </th>
                            
                        </cfloop>
                    </tbody>

                </table>

            </cfoutput>

        </cffunction>

    <!---   **********************************************************************  --->
    <!---   *   Dashboard Users Sites View For Right Sidebar - END                  --->
    <!---   **********************************************************************  --->

    
    <!---   ************************************************************************  --->
    <!---   *   Dashboard RightSideBar - START                                        --->
    <!---   ************************************************************************  --->

        <cffunction name="Dashboard_RightSideBarPage_VIEW" acess="PUBLIC" returntype="void" output=true hint="">
            <cfargument name="urlData"      type="struct"   required=true>

            <cfoutput>

                
                <div class="card-page card-outline-info">

                    <div class="card-header">
                        <input form='userForm' class='btn btn-theme waves-effect waves-light m-r-10 js-submit' type='submit' value='Save' data-form='userForm'>
                        <button class='btn btn-theme js-close-sidebar'>
                            Cancel
                        </button>
                        <h4 class='m-b-0t' id="rightSideBarTitle">{title}</h4>
                    </div>

                    <div class="card-body">
                    </div>

                </div>

            </cfoutput>

        </cffunction>

    <!---   ************************************************************************  --->
    <!---   *   Dashboard RightSideBar - END                                          --->
    <!---   ************************************************************************  --->

        <cffunction name="Dashboard_Hello_World_VIEW" access="PUBLIC" returntype="void" output=true hint="">
            <cfargument name="urlData"          type="struct"   required=true>
            <cfargument name="debug"            type="boolean"  required=false default=false>

            <cfoutput>

                Hello World!

            </cfoutput>

        </cffunction>

</cfcomponent>