component displayName="spreadsheetsComponents" output=true hint="functions for handling spreadsheets"{

    public any function spreadsheetAddRowsForceTextFormat( required spreadsheetObject, required query data, required array columnNumbersToFormatAsText){
            
        local.columns = arguments.data.getMetaData().getColumnLabels();
        
        // Add the data: the numbers will be inserted as numeric for now
        SpreadSheetAddRows( arguments.spreadsheetObject,arguments.data );

        for( var columnNumberToFormat in arguments.columnNumbersToFormatAsText ){

            // Now we format the column as text
            SpreadSheetFormatColumn( arguments.spreadsheetObject,{ dataformat="text" },columnNumberToFormat );

            // Having formatted the column, add the column from our query again so the values correct
            while( arguments.data.next() ) {

                local.rownumber = arguments.data.currentrow;
                local.rownumber++; // start one row below to allow for header
                // Get the value of column at the current row in the loop
                local.value = arguments.data[ local.columns[ columnNumberToFormat ] ][ arguments.data.currentrow ];
                // replace the previously added numeric value which will now be treated as text
                SpreadsheetSetCellValue( arguments.spreadsheetObject,local.value,local.rownumber,columnNumberToFormat );

            }

        }

        return arguments.spreadsheetObject;

    }

}