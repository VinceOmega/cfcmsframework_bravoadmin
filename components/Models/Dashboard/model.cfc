component displayName='DashboardModel' output=true hint=""{

    /**
     * 
     * 
     */


    public struct function Dashboard_Reports_READ( required string query, required struct paramStruct, required struct connectionStruct ){


        return application.errorPanel.components.utility.queryContainers.QueryContainers_SIMPLE_TASK( query, paramStruct, connectionStruct );

    }

}