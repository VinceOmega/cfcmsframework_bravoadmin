<!--- Delete any code under this line before push to production. --->

<cfset queryStr = urlEncodedFormat("company_id:'11000116479'")>


<cfhttp url='https://bravo.freshdesk.com/api/v2/tickets' method='GET' result='results'>
    <cfhttpparam name='Content-Type'            type='header'   value='Content-Type:application/json'>
    <cfhttpparam name='Authorization'           type='header'   value='#toBase64( '5LHJSeZSxQ2OFnjs23:X' )#'>
    <cfhttpparam name='company_id'              type='url'      value="11000116479">
</cfhttp>

<cfdump var="#results#">


<cfabort>

<cfprocessingdirective suppresswhitespace="yes">

    <cfscript>

        formData        = FORM; 

        public struct function Login_Signin_READ( required struct formData ){

            try{

                //Queries
                var result          = queryNew( '' );
                var count           = queryNew( '' );

                //Structs
                var metaData        = {};
                var resultStruct    = {};

                //Booleans
                var success         = false;

                //arrays
                var queryArray      = [];

                //strings
                var query           = '';

                //list
                var columnList      = '';

                count = queryExecute(
                    "
                                    SELECT DISTINCT COUNT( e.entrypointCode ) as num
                                    FROM entrypoints e
                                        JOIN establishments eep ON eep.establishmentEntryPoint = e.entrypointCode
                                    WHERE eep.establishmentType = 'L'
                                        AND eep.establishmentKey = 0
                                    UNION
                                        SELECT ep.* as columns
                                        FROM entrypoints ep
                                        LIMIT 1;                                    
                    ",
                    {
                        

                    },
                    {

                        datasource  = application.mainDatabase

                    }

                );

                arrayAppend(
                    queryArray,  "
                                    SELECT DISTINCT  EstablishmentFullName, EstablishmentCity, EstablishmentState
                                    FROM entrypoints e
                                        JOIN establishments eep ON eep.establishmentEntryPoint = e.entrypointCode
                                    WHERE eep.establishmentType = 'L'
                                        AND eep.establishmentKey = 0            
        
                "
                );

                for( columns in  count.columns.columnList ){
                    columnList = " AND " & columns " LIKE " & formData.search.value;
                }

                if( len( formData.search[ 'value' ] ) ){
        
                    arrayAppend(
                        queryArray, columnList
                    )
                }

                arrayAppend(
                    queryArray,  "

                                        AND eep.establishmentKey = 0
                                        ORDER BY e.EntryPointCode ASC
                                        LIMIT   :limit
                                        OFFSET  :offset           
        
                "
                );

                query = arrayToList( queryArray, '' );

                formData.length = ( formData.length == 'all' )? count.num :formData.length;

                result = queryExecute(
                    "
                                        ORDER BY e.EntryPointCode ASC
                                        LIMIT   :limit
                                        OFFSET  :offset

                    ",
                    {
                       
                        offset  = { value=formData.start?:0,    cfsqltype="cf_sql_integer" },
                        limit   = { value=formData.length?:10,  cfsqltype='cf_sql_integer' }

                    },
                    {

                        datasource  = application.mainDatabase,
                        result      = "metaData"

                    }

                );

                success = true;

            } catch( any e ){

                var errorStruct             = structNew();
                errorStruct[ 'cfcatch' ]    = e;
                errorStruct[ 'metaData' ]   = metaData?:structNew('');
                errorStruct[ 'arguments' ]  = arguments;
                errorStruct[ 'success' ]    = success?:false;

                writeDump( errorStruct );

            }

            resultStruct[ 'success' ]       = success?: false;
            resultStruct[ 'result' ]        = result?: queryNew( '' );
            resultStruct[ 'count' ]         = count?: queryNew( 'num' );
            resultStruct[ 'errors' ]        = errorStruct?: {};

            return resultStruct;

        }

        resultStruct = Login_Signin_READ( formData );

        data =  [];
        sets =  [];

        
        for( i = 1; i < resultStruct.result.recordCount; i++ ){

            sets = [];

            for( column in resultStruct.result.columnList ){

                arrayAppend( sets, resultStruct.result[ column ][ i ] );

            }

            arrayAppend( data, sets );

        }

        obj = {};

        structInsert( obj, 'draw', formData.draw?:1 );
        structInsert( obj, "recordsTotal", resultStruct.count.num );
        structInsert( obj, "recordsFiltered", resultStruct.count.num );
        structInsert( obj, 'data', data );

        writeOutput( serializeJSON( obj ) );

    </cfscript>

</cfprocessingdirective>

<cfabort>

<cfscript>
    try{

        writeDump( application );
        writeDump( arguments );
        writeDump( local );
        writeDump( request ); 
        writeDump( cgi );
        writeDump( server );

        public struct function createMVCComponents(){

            //structs
            directoryStruct         = {};
            returnStruct            = {};

            //strings
            path                    = '';
            subpath                 = '';
            topLevelKeys            = '';
            subLevelKeys            = '';
            componentKeys           = '';
            componentsPath          = '';
            validTLKeys             = 'Controllers,Models,Views';

            //array
            pathArray               = [];
            subPathArray            = [];

            //boolean
            debug                   = true;
    
            directoryStruct = directoryList( expandPath( './components' ) );

            for( path in directoryStruct ){

                pathArray = listToArray( path, '\' );

                if( listFind( validTLKeys, pathArray[ arrayLen( pathArray ) ] ) ){

                    structInsert( returnStruct, pathArray[ arrayLen( pathArray ) ], structNew() );

                    for( subpath in directoryList( path ) ){

                        subPathArray    = listToArray( subpath, '\' );
                        componentsPath  = 'components' & '.' & pathArray[ arrayLen( pathArray ) ] & '.' & subpathArray[ arrayLen( subpathArray ) ] & '.' & lCase( removeChars( pathArray[ arrayLen( pathArray ) ] , len( pathArray[ arrayLen( pathArray ) ] ) , 1 ) );
                        
                        if( debug ){
                            writeDump( componentsPath );
                        }

                        structInsert( returnStruct[ pathArray[ arrayLen( pathArray ) ] ], subpathArray[ arrayLen( subpathArray ) ], createObject( 'component', componentsPath ) );

                    }

                }

            }

            if( debug ){
                writeDump( returnStruct );
            }

            return returnStruct;
    
        }

        //createMVCComponents();

        public struct function createUtilityComponents(){

            //structs
            directoryStruct         = {};
            returnStruct            = {};

            //strings
            path                    = '';
            topLevelKeys            = '';
            componentKeys           = '';
            componentsPath          = '';

            //array
            pathArray               = [];

            //boolean               
            debug                   = true;
    
            directoryStruct = directoryList( expandPath( './utilities' ) );

            for( path in directoryStruct ){

                pathArray = listToArray( path, '\' );

                componentsPath  = 'utilities' & '.' & removeChars( pathArray[ arrayLen( pathArray ) ] , len( pathArray[ arrayLen( pathArray ) ] ) -3 , 4 );

                if( debug ){
                    writeDump( componentsPath );
                }

                structInsert( returnStruct, lCase( removeChars( pathArray[ arrayLen( pathArray ) ] , len( pathArray[ arrayLen( pathArray ) ] ) -3 , 4 ) ), createObject( 'component', componentsPath ) );


            }

            if( debug ){
                writeDump( returnStruct );
            }

            return returnStruct;

        }

        //createUtilityComponents();


    } catch( any e ){

        writeDump( e );
        writeOutput( 'failed' );

    }



</cfscript>



