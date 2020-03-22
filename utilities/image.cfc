component displayName='imageComponents' output=true hint=""{


    /**
     * Undocumented unknown
     */

     // ****************************************************
     // * Image Components - START
     // ****************************************************

        public string function Image_GenerateDefaultUserAvatar_RENDER( required string first, required string last, numeric fileSize, boolean base64String ){

            //numerics
            var r   = 1;
            var g   = 1;
            var b   = 1;
            var lum = 0;
            local.fileSize = ( structKeyExists( ARGUMENTS, 'fileSize' ) ) ? arguments.fileSize : 50;

            //strings
            var r2              = '';
            var g2              = '';
            var b2              = '';
            var hexValue        = '';
            var textCoor        = '';
            var userInitals     = '';

            //booleans
            local.base64String = arguments.base64String?: true;

            // rand gen number 1-255 for rgb colors
            r = randRange(1, 255, 'CFMX_COMPAT');
            g = randRange(1, 255, 'CFMX_COMPAT');
            b = randRange(1, 255, 'CFMX_COMPAT');
        
            //convert rgb from base10 to base16 for hex values
            r2 = formatBaseN( r, 16 );
            g2 = formatBaseN( g, 16 );
            b2 = formatBaseN( b, 16 );
        
            //if single digits, add a 0 in front of number
            r2 = ( len( r2 ) < 2 ) ? "0" & r2 : r2 ;
            g2 = ( len( g2 ) < 2 ) ? "0" & g2 : g2 ;
            b2 = ( len( b2 ) < 2 ) ? "0" & b2 : b2 ;
        
            //concat together for hexValue
            hexValue = r2 & g2 & b2;
            //find lum value
            lum = .21266 * r + .7152 * g + .0722 * b;
            //if lum is under 100 then make the text black, else make it white
            textColor = ( lum < 100 ) ? "FFF" : "000";
            //get user initals
            userInitals = left( first, 1 ) & left( last, 1 );
            
            //read from ui-avatars to get a base image with the bgcolor, color, userInitals, and fileSize
            cfimage( source='https://ui-avatars.com/api/?name=#userInitals#&background=#hexValue#&color=#textColor#&size=#local.fileSize#', action='read', name='uiAvatars', format='png' );

            //in the future have a fallback if ui-avatars fails to load

            //return the image as a base64 string
            return ( local.base64String ) ? "data:image/*;base64,#ToBase64(uiAvatars)#" : "https://ui-avatars.com/api/?name=#userInitals#&background=#hexValue#&color=#textColor#&size=#local.fileSize#";

        }

        public string function Image_UploadUserProfile_RENDER( required struct formData, required numeric userID ){

            try{

                if(  structKeyExists( formData, 'profileUpload' ) && len( formData[ 'profileUpload' ] ) ){
                    cffile( action="upload", destination=expandPath( APPLICATION[ 'UserAvatarsPath' ]) & userID & '.jpg', fileField="profileUpload", accept="image/jpeg", nameConflict = "Overwrite");
                }

            }catch( any e ){

                errorStruct = {

                    'ARGUMENTS': ARGUMENTS,
                    'VARIABLES': VARIABLES,
                    'cfcatch': e

                };

                writeDump( errorStruct );
                abort;
            

            }

        }

        
        public string function Image_GetUserProfile_RENDER( required string first, required string last, required numeric userID, boolean returnBase64Str ){
            
            //Boolean
            local.returnBase64Str = arguments.returnBase64Str?: false;

            //string
            var image = '';

            try{

                if( !fileExists( expandPath( "#APPLICATION[ 'UserAvatarsPath' ]##userId#.png" ) ) ){

                    image = cfimage( source='https://ui-avatars.com/api/?name=#userInitals#&background=#hexValue#&color=#textColor#&size=#local.fileSize#', action='read', name='uiAvatars', format='png' );
                    

                } else {

                    image = THIS.Image_GenerateDefaultUserAvatar_RENDER(  );

                }

            } catch( any e ) {

                var errorStruct = {

                    'cfcatch': e,
                    'ARGUMENTS': ARGUMENTS,
                    'VARIABLES': VARIABLES

                };

                writeDump( errorStruct );

            }

            return image;

        }

     // ****************************************************
     // * Image Components - END
     // ****************************************************

}