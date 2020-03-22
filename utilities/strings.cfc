component displayName="utilitiesStrings" output=true hint=""{


    /**
        *
        * @name : Strings_TrimInput_TASK
        * @hint : 'Used for Structs and Arrays only, trims all input within'
        * @object: Must be a struct or an array, for single strings use trim()
        * 
        *
    **/

    public any function Strings_TrimInput_TASK( required any object ){

        //strings
        var key = '';

        try{

            if( isStruct( object ) || isArray( object ) ){

                for( key in object ){

                    key = VARIABLES.Strings_TrimInput_TASK( key );

                }

            } else {

                object = lTrim( object );
                object = rTrim( object );
                object = trim( object );

            }
                
            return object;

        } catch( any e ){

            writeDump( e ); //Dump errors

        }

    }
    
    /**
     * 
     * @name: Strings_CleanPageSlug_TASK
     * @hint: cleans the format of the page slug for readability or for searching for its RETRIEVE function
     * @page: The page slug to pass in to convert
     * @type: Type of conversion you want to perform: Right now there are two types, display and file. Either convert for human readability (display) or for ease of use in file formats (file)
     */

     public string function Strings_CleanPageSlug_TASK( required string page, string type ){

        //string
        var result = '';
        var replacementStr = '';


        local.type = ( structKeyExists( arguments, 'type' ) ) ? arguments.type : '';

        try{
                switch( local.type ){

                    case 'display':

                        replacementStr = ' ';

                        break;

                    case 'file':

                        replacementStr = '_';

                        break;

                    case 'url':

                        replacementStr = '-';

                        break;

                    default:

                        replacementStr = ' ';

                        break;

                }

                result = reReplaceNoCase( page, '-', replacementStr, 'all' );

        } catch( any e ){

            writeDump( e ); //Dump errors

        }

        return result;

     }

    /**
    * 
    *
    *
    */
    
      public string function Strings_GeneratePageHref_TASK( required string alias, string query ){

       /**
       * @hint:
       */

        //struct
        var resultStruct    = {};
        var homePageStruct  = {};

        //arrays
        var stringArray     = [];

        //strings
        var hrefString      = '';

            for( page in application.errorPanel.metaData.pages ){

                try{
                    
                    resultStruct = structFindValue( application.errorPanel.metaData.pages[ page ], alias );

                    if( arrayLen( resultStruct ) && resultStruct[ 1 ][ 'owner' ][ 'alias' ] != alias ){

                        resultStruct = {};

                    }

                    if( isArray( resultStruct ) && arrayLen( resultStruct ) ){

                        stringArray[ 1 ] = resultStruct[ 1 ][ 'owner' ][ 'dir' ];
                        stringArray[ 2 ] = resultStruct[ 1 ][ 'owner' ][ 'section' ];
                        stringArray[ 3 ] = resultStruct[ 1 ][ 'owner' ][ 'slug' ];

                        //if the section and page don't share the same dir, then we will just print out a hash, else print the correct link
                        if( lcase( trim( stringArray[ 1 ] ) ) == lcase( trim( application.errorPanel.metaData.navigation[ stringArray[ 2 ] ].dir ) ) ){

                            hrefString = '/' & listAppend( hrefString, arrayToList( stringArray, '/' ), '/' );
                            hrefString = ( structKeyExists( arguments, 'query' ) &&  query != '' )? hrefString & '?' & query : hrefString;

                            break;

                        } else {

                            hrefString = '##';

                        }

                    } 

                }catch( any e ){

                    //writeDump( e );
                    //throw( 'error generating link' );

                    //hrefString = '##';

                }

            }

            hrefString = ( len(hrefString) )? hrefString : '##';

        return lcase( hrefString );

      }



       public string function Strings_GeneratePassword_TASK(){

            /**
            * @hint: generate random password
            */

            //strings
            var lowerCaseAlpha  = '';
            var upperCaseAlpha  = '';
            var numbers         = '';
            var otherChars      = '';
            var allValidChars   = '';
            var newPassword     = '';

            //arrays
            var passwordArray   = [];

            //numerics
            var i               = 1;
        
            lowerCaseAlpha = "abcdefghkmnpqrstuvwxyz";
            upperCaseAlpha = UCase( lowerCaseAlpha );
            numbers = "23456789";
            otherChars = "!@$%&";
            allValidChars = (lowerCaseAlpha & upperCaseAlpha & numbers & otherChars);

            //8 characters in length, at least 1 number, at least 1 uppercase letter and at least 1 lower case letter

            passwordArray[1] = Mid(numbers,RandRange(1,Len(numbers)),1);
            passwordArray[2] = Mid(lowerCaseAlpha,RandRange(1,Len(lowerCaseAlpha)),1);
            passwordArray[3] = Mid(upperCaseAlpha,RandRange(1,Len(upperCaseAlpha)),1);

            i = arrayLen( passwordArray ) + 1;

            while( i <= 8 ){

                passwordArray[ i ] = Mid( allValidChars, RandRange( 1, Len( allValidChars ) ), 1 );
                i++;

            }

            createObject("java","java.util.Collections").Shuffle( passwordArray );
            newPassword = arrayToList( passwordArray,"" ); 
            
            return newPassword;

       }

}