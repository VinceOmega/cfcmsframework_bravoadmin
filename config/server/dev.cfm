
<cfscript>

    lock scope="server" type="exclusive" timeout="5"{
    
        server.cfhttptimeout        = 3;
        server.numbersToWords       = createObject('component','/customScriptsBravo/Components/numberToWords');
        server.zIndexPrefix         = "zIndex";
        server.brandMarketingFlag   = "Price Upd. 2018";
        /***********************************************************************/
        server.search.solrMaster        = "http://v.search1.myplumbingshowroom.com:8983/solr/" ;
        server.search.solrSlave1        = "http://v.search3.myplumbingshowroom.com:8983/solr/" ;
        server.search.solrSlave2        = "http://v.search4.myplumbingshowroom.com:8983/solr/" ;
        server.search.solrActiveServer  = "";
        server.solrServers              = this.configComponentsForServerVars.getSolrServers();
        
        /*********************************************************************/
        this.configComponentsForServerVars.updateServer();
        /*********************************************************************/
        server.brands                   = this.configComponentsForServerVars.getBrands();
        /*********************************************************************/
        server.DNSPList                 = valuelist( this.configComponentsForServerVars.getPriceToNotShow().brandCode );
        /*********************************************************************/
        server.sites                    = this.configComponentsForServerVars.getSites();
        server.listEntryPoints          = valuelist( server.sites.siteID );
        server.listCores                = valuelist( server.sites.appName );
        server.adminSC_Password         = this.configComponentsForServerVars.getAdminInfo.scPassword;
        server.serverVariables          = this.configComponentsForServerVars.getServerVars( server.serverVariables );
        server.useragents               = this.configComponentsForServerVars.createUserAgentDirectoryObject();
   
    }

</cfscript>