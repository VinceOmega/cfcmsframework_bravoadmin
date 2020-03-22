component displayName='securityComponents' output=true hint='component sets for the security components'{


    /**
    *
    *
    *
    *
    **/

    //  **********************************************************************  
    //  *  Security Components Functions - START                                      
    //  **********************************************************************  

    public array function Security_DisableElementsByUserSecurityLevels_RENDER( required struct scopeData, required array domData, required string domSelector ){

        //arrays
        var elements            = [];
        var newElements         = [];

        //structs
        var element             = {};

        //numerics
        var idx                 = 1;

        //booleans
        var disableFields       = false;

        for( value in application.errorPanel.metaData.pages[ reReplaceNoCase( scopeData[ 'page' ], '_', '-', 'all' ) ].userSecurity ){

            if( listFind( session.login.securitySite, value ) ){

                disableFields = true;
                break;

            }
        }


        if( !disableFields && application.errorPanel.metaData.pages[ reReplaceNoCase( scopeData[ 'page' ], '_', '-', 'all' ) ].withoutRightsCanView ){

            elements = domData.select( domSelector );

            elements.each(function( element, idx ){
                element.attr( "disabled", true );
            });

            //domData.select( '*' ).remove();
            //domData.append( newElements );
        }

        return domData;

    }

    //  **********************************************************************  
    //  *  Security Components Functions - END                                      
    //  **********************************************************************  


}
