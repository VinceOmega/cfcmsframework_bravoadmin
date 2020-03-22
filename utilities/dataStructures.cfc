component displayName='dataStructuresComponents' output='true' hint=''{

    /**
     * @name: dataStructuresComponents
     * @hint: a component set that returns basic shapes for common data structures used through the application
     * 
     */

    //  **********************************************************************  
    //  *  Data Structure Functions - START                                      
    //  **********************************************************************

        public struct function DataStructure_JSONStruct_GENERATE(){

            /**
             * 
             * @name: DataStructures_JSONStruct_CREATE
             * @hint: A model for the basic shape of the jsonStruct
             * 
             */

            //structs
            var result = {}

            result = {

                'onSuccess': {

                    'message': [],
                    'status': [],
                    'growl': {
                        'message': '',
                        'status': ''
                    },

                    'location': ''

                },

                'onFailure':{

                    'message': [],
                    'status': [],
                    'growl': {
                        'message': '',
                        'status': ''
                    },
                    
                    'location': ''

                }

            };

            return result;
        }

        public array function DataStructure_BooleanArray_GENERATE(){

            /**
             * @name: DataStructure_BooleanArray_GENERATE
             * @hint: returns the basic shape needed for the booleanArray
             */

             var result = [];

             result = [
                {

                    'validateBoolean' : 'success',
                    'locationOnSuccess': '',
                    'locationOnFailure': ''

                }

             ];

             return result;

        }

    //  **********************************************************************  
    //  *  Data Structure Functions - END                                      
    //  **********************************************************************

}