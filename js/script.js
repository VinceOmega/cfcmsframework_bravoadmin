//This file will be re-written later - Larry S.

//global url variable
var urlGlobal = '';

// namescape-routes object
var pagesStruct = '';
$.ajax({
    url: '/config/metaData/pages.json',
    method: 'GET',
    dataType: 'json',
    async: false,
    success: function( data ){

        pagesStruct = data;

    }
})

console.log( pagesStruct );

toastr.options = {
    "closeButton": true,
    "debug": false,
    "newestOnTop": true,
    "progressBar": false,
    "positionClass": "toast-top-right",
    "preventDuplicates": false,
    "onclick": null,
    "showDuration": "300",
    "hideDuration": "1000",
    "timeOut": "5000",
    "extendedTimeOut": "1000",
    "showEasing": "swing",
    "hideEasing": "linear",
    "showMethod": "fadeIn",
    "hideMethod": "fadeOut"
  }

var callDataTableFn = function() {

    
    $('.dataTable').each( function(){

        if ( ! $.fn.DataTable.isDataTable( '#' + $( this ).attr( 'id' ) ) ) {

            $( "#" + $(this).prop( 'id' ) ).DataTable({
                responsive: true
            });

        }
    });

}

var ajaxCallForSiteSelectionFn = function() {

    $.when(
        $('.dataTable___TableBody___QueryRow___QueryCell___Href').bind('click', function() {

            event.preventDefault();
            event.stopPropagation();

            $.ajax({
                type: "post",
                url: "adminpanel/dashboard/userSites",
                data: {
                    processInvoke: 'Dashboard_UserSites_PROCESS',
                    siteID: $(this).data('id'),
                    recordCount: $(this).data('count'),
                    ajax: true
                },
                dataType: "json",
                success: function(response) {
                    if (response.location != 'noredirect') {
                        window.location.assign(response.location);
                    }

                }

            })

        })
    ).then(
        $('.paginate_button').delay(500).bind('click', ajaxCallForSiteSelectionFn)
    )

}

var ajaxCallForSiteSelectionUsersFn = function() {

    $.when(
        $('.dataTable___Actions a').on('click', function() {

            var self = $(this);

            processInvoke   = ( self.get( 'action' ) == ( 'create' || 'copy' ) ) ? 'Users_All_' + self.get( 'action' ) + '_PROCESS' : 'Users_All_Edit_PROCESS';
            processInvoke   = ( self.get( 'action' ) == 'delete' ) ? 'Users_All_Remove_PROCESS' : processInvoke;

            event.preventDefault();
            event.stopPropagation();

            $.ajax({
                type: "get",
                url: self.data( 'href' ),
                data: {
                    processInvoke: processInvoke,
                    userID: self.data('user-id'),
                    ajax: false,
                    chromeless: true
                },
                dataType: "json",
                success: function(response) {
                    
                    console.log( response );

                }

            })

        })
    ).then(
        $('.paginate_button').delay(500).bind('click', ajaxCallForSiteSelectionUsersFn)
    )

}

function enableEventsOnSearchAndFilter() {

        $("input[type='search']").bind('keyup', function() {

            ajaxCallForSiteSelectionFn();

        });

        $("input[aria-controls='DTUsers']").bind( 'keyup', function() {
            hooksForUserDataTables();

        });

    $("select[name='renderDataTable_length']").bind('change', function() {

        ajaxCallForSiteSelectionFn();

    });

    $("select[name='DTUsers_length']").bind( 'change', function(){

        hooksForUserDataTables();

    });

}

var callAnyDataTableFn = function(cssSelector) {


    console.log( cssSelector );

    console.log(  $( this ).prop( 'id' ) );

    if( cssSelector.substring( 0,1 ) === '#' ){

        $(cssSelector).DataTable({
            responsive: true
        });

     } else {

        $( cssSelector ).each( function(){

            console.log( $( this ).prop( 'id' ) )

            if ( ! $.fn.DataTable.isDataTable( '#' + $( this ).attr( 'id' ) ) ) {


                $( "#" + $( this ).prop( 'id' ) ).DataTable({

                    responsive: true

                });

            }

        });

    }

}

var hooksForUserDataTables = function() {

    $('.dataTable___Actions a, .js-user-customer-new, .js-edit-user, .js-export-users').off( 'click' ).on('click', function() {

        var dataStruct = {};
        var dataType = '';
        var fnObj = {};

        console.log($(this).data('action'));

        if ($(this).data('action') === 'edit' || $(this).data('action') === 'copy') {

            var id = 0;

            if( $(this).data('userid') ) {

                id = $(this).data( 'userid' );

            } else {

                id = $(this).find( '#userid' ).val();

            }

            dataStruct = {

                ajax: false,
                chromeless: true,
                userID: id

            };

            dataType = 'html';

            fnObj = {

                success: function(response, url) {

                    $.when(
                        appendHTMLToRightSidebar(response, url)
                    ).then(
                        attachEventToForms()
                    ).then(
                        attachEventToUserType()
                    ).then(
                        btButtonsFn()
                    ).then(
                        closeSideBar()
                    );

                }

            }

            sendToServer('get', $(this).data('href'), dataStruct, dataType, fnObj);

        } else if ($(this).data('action') === 'delete') {

            var self = $(this);

            swal({
                    title: 'Are you sure you want to deactive this?',
                    type: 'warning',
                    showCancelButton: true,
                    cancelButtonColor: '##00aae7',
                    confirmButtonColor: '##002d5b',
                    cancelButtonText: "Don't deactive",
                    confirmButtonText: "Yes, deactive"

            }).then(

                function(obj){

                console.log(obj)


                swal(
                    "We're working on it!",
                    "We are currently processing your request!",
                    "info"
                )

                dataStruct = {

                    ajax: true,
                    chromeless: false,
                    userID: self.data('userid'),
                    processInvoke: self.attr('processInvoke'),

                };

                dataType = 'json';

                fnObj = {

                    success: function(response, url) {

                        if (response.location.trim() != 'noredirect') {

                            window.location.assign(response.location);
    
    
                        } else if (response.location == '') {
    
                             window.location.assign(window.location.pathname);
    
                        } else {
    
                           window.location.assign(window.location.pathname);
    
                        }         
                        
                    }

                }

                sendToServer('post', self.data('href'), dataStruct, dataType, fnObj);                                   

            });

        } else if ($(this).data('action') === 'new') {


            console.log( $( '.card-prompt' ).css( 'height' )  );

            //manual toggle
            if( !$( '.card-prompt' ).hasClass( 'card-prompt--display' ) ){ 
                
                $('.card-prompt').addClass('card-prompt--display');

            } else {

                if( $( '.card-prompt' ).css( 'height' ) == '1px' ){

                    $( '.card-prompt' ).css( 'height', '30px' ); 

                } else {

                    $( '.card-prompt' ).css( 'height', '0px' ); 

                }

                //$('.card-prompt').removeClass('card-prompt--display');

            }

            $('#checkEmail').bind('submit', function() {

                event.preventDefault();

                console.log( $(this).find("input[name='email']").val() );

                dataStruct = {

                    ajax: true,
                    chromeless: false,
                    email: $(this).find("input[name='email']").val(),
                    processInvoke: $(this).find("input[name='processInvoke']").val(),
                    userType: $(this).find("input[name='userType']").val(),
                    formInvokeMethod: $(this).find("input[name='formInvokeMethod']").val()

                };

                dataType = 'html';

                fnObj = {

                    success: function(response, url) {

                        $.when(
                            jsonResponseCallbacks(response, url)
                        ).then(
                            closeSideBar()
                        ).then(
                            attachEventToForms()
                        ).then(
                            attachEventToUserType()
                        );

                    }

                }

                sendToServer('post', $(this).find( 'button' ).data('href'), dataStruct, dataType, fnObj);

            });

        } else if ( $(this).data('action').toLowerCase() === 'exportuser'){


            $( '#loadExport' ).attr( 'src', $(this).data('href') + '?chromeless=true&userType=' + $(this).attr( 'userType' ) )

            
        }

    });

}

var getPageTemplate  = function(html){

    var dom;

   $.ajax({
        type: "get",
        url: "/adminPanel/dashboard/rightsidebarpage",
        data: {
            ajax: false,
            chromeless: true
        },
        dataType: "html",
        async: false,
        success: function (response) {

            dom = $( '<body></body>' ).append( response );

            dom.find( '.card-body' ).first().empty().append( html );

            //console.log(  dom.find( '.card-body' ).first().empty().append( html )  );

            //console.log( dom );

            //console.log( dom.html() )

        }
    });
    
    return dom.html();

}

var appendHTMLToRightSidebar = function(response, url) {

    $('.right-sidebar').slideDown(50);
    $('.right-sidebar').toggleClass('shw-rside');

        var html = getPageTemplate( response );

        var pathArray = [];

        console.log( url )
        console.log( url.split( '/' ) );

        pathArray = url.split( '/' )[ 3 ].split( "?" );

        
        html =  html.replace( "{title}", pagesStruct[ pathArray[ 0 ].toLowerCase() ].title );

       //console.log( html );
        //console.log( $( html ).find( '#rightSideBarTitle' ).text() );

        $('#right-hand-sidebar')
        .find('.slimscrollright')
        .first()
        .empty()
        .append( html )
        .delay(500); 

}

var appendHTMLToOpenRightSidebar = function(response, url) {

    var html = getPageTemplate( response );

    console.log( url.split( '/' ) );

    pathArray =  url.split( '/' )[ 3 ].split( "?" );

    html = html.replace( "{title}", pagesStruct[ pathArray[ 0 ].toLowerCase() ].title )

    console.log( html );

    $('#right-hand-sidebar')
    .find('.slimscrollright')
    .first()
    .empty()
    .append( html )
    .delay(500); 


}


var closeSideBar = function(response) {

    console.log('closeSideBar fn fired');

   $( 'body' ).off( 'click' ).on( 'click' , function(){

        console.log( $( event.target ) );
        console.log( $( event.target ).parents( '#right-hand-sidebar'  ) );

        
        if( !$( event.target ).parents( '#right-hand-sidebar'  ).length ){
            $( '.right-sidebar' ).removeClass( 'shw-rside' );
        } 

    } );

    $('.js-close-sidebar').bind('click', function() {

        $('.right-sidebar').slideUp(50);
        $('.right-sidebar').toggleClass('shw-rside');

    });


}

var callbacks = $.Callbacks();
callbacks.add(callDataTableFn);

var sendToServer = function(method, path, dataStruct, dataType, fnObject) {

    $.ajax({

        type: method,
        url: path,
        data: dataStruct,
        dataType: dataType,
        success: function(response) {

            console.log('success method called');
            fnObject.success(response, this.url);

        }

    });

}

var jsonResponseCallbacks = function(response, url) {

    var response = JSON.parse(response);
    var i = 1;
    console.log(response);
    for (callback in response.js.callback) {

        if( response.js.argsOptions[ i ].isJson !== 'undefined' && response.js.argsOptions[ i ].isJson ){
            window[response.js.callback[callback]]( JSON.parse( response.js.args[i] ), url ).then(
                function( obj ){

                    console.log( response );

                    if( obj.value !== 'undefined' && obj.value ){
                        
                        console.log( 'confirm fired' );
    
                        dataStruct = {
    
                            ajax: true,
                            chromeless: false,
                            email: $(response.js.argsOptions[ i - 1 ].targetId).find("input[name='email']").val(),
                            processInvoke: 'Users_Get_Info_PROCESS',
                            userType: $(response.js.argsOptions[ i - 1 ].targetId).find("input[name='userType']").val(),
                            formInvokeMethod: 'Users_Edit_RETRIEVE'
    
                        };
    
                        dataType = 'html';
    
                        fnObj = {
    
                            success: function(response, url) {
    
                                $.when(
                                    appendHTMLToRightSidebar(response, url)
                                ).then(
                                    closeSideBar()
                                ).then(
                                    attachEventToForms()
                                ).then(
                                    attachEventToUserType()
                                );
    
                            }
    
                        }

                        console.log( $(response.js.argsOptions[ i - 1 ].targetId).find( 'button' ).data('onconfirm') );
    
                        sendToServer('post', $(response.js.argsOptions[ i - 1 ].targetId).find( 'button' ).data('onconfirm'), dataStruct, dataType, fnObj);
                    }
                }
            );
        } else {
            window[response.js.callback[callback]](response.js.args[i], url);
        }
        i++
    }

}


var attachEventToUserType = function() {

    $('#userType').on('change', function(event) {

        var id  = 0;
        var email = '';

            var dataStruct = {};
            $.each($('#userForm').serializeArray(), function(i, field) {
                dataStruct[ field.name ] = field.value;
            });

            dataStruct.ajax = false;
            dataStruct.chromeless = true;
            dataStruct.email = $('#userForm').find( "input[name='Email']" ).val();


        dataType = 'html';

        fnObj = {

            success: function(response, url) {

                $.when(
                    appendHTMLToOpenRightSidebar(response, url)
                ).then(
                    attachEventToForms()
                ).then(
                    attachEventToUserType()
                ).then(
                    closeSideBar()
                );



            }

        }

        console.log($(this));
        console.log($(this).find('option:selected').data('callback'));
        console.log($(this).find(':selected').attr('callback'));
        console.log($(':selected', $(this)).data('callback'));
        console.log( $(':selected', $(this)).val() );



        sendToServer('get', $(this).find(':selected').data('callback'), dataStruct, dataType, fnObj);

    });

}

var attachEventToForms = function() {

    $('form.js-form, js-submit').each(function() {

        $(this).bind('submit', function(event) {

            event.preventDefault();

            console.log( 'submit form' );

            var filesData   = $( this ).find( "input[type='file']" );
            var formData    = new FormData();
            $.each($(this).serializeArray(), function(i, field) {
                console.log(field);
                formData.append(field.name, field.value);
            });

            filesData.each(function(){
                var self = $( this );
                $.each( $( this ), function( index, value ){
                    console.log( $( this )[ index ].files );
                   $.each( $( this )[ index ].files, function( idx, val ){
                       console.log( self.prop( 'name' ) );
                       console.log( val );
                        formData.append( self.prop( 'name' ), val );
                    });
                });
            });

            formData.set( 'ajax', true );
            formData.set( 'chromeless', false );

            if( !formData.has( 'Email' ) && formData.get( 'Email' ) != '' ){
                formData.set( 'Email', $(this).find( "input[name='Email']" ) .val() );
            }

            console.log(window.location.pathname);

            path = ( typeof $(this).attr( 'action' ) !== 'undefined' || $(this).attr( 'action' ) !== '' ) ? $(this).attr( 'action' ).trim() : window.location.pathname;

            console.log( path );

            $.ajax({
                type: "post",
                url: path,
                data: formData,
                processData: false,
                contentType: false,
                dataType: "json",
                success: function(response) {

                    if (response.location.trim() != 'noredirect') {

                        window.location.assign(response.location);


                    } else if (response.location == '') {

                         window.location.assign(window.location.pathname);

                    } else {

                       window.location.assign(window.location.pathname);

                    }

                }
            });

        });

    });

    checkEmail();

    $( "input[type='checkbox']" ).bootstrapToggle();
    $( ".input-group select, .form-group select" ).selectpicker();
    $.when( $( '.dropify' ).dropify() ).then(
        $( '.dropify' ).each(function(){
            if( $(this).data( 'default-file' ) === '' && $(this).data( 'base64-image' ) !== '' ){
                $(this).parent( '.dropify-wrapper' ).find( '.dropify-preview' ).first().find( '.dropify-render' ).first().html( $( '<img>', { src: $(this).data( 'base64-image' ) } ) );
                $(this).parent( '.dropify-wrapper' ).find( '.dropify-preview' ).first().css( 'display', 'block' );
            }
       })
    );


}

var btButtonsFn = function(){


//nothing
    

}

var checkEmail = function(){

    $('.js-check-email').keyup(function(){

        var self    = $(this);


        console.log( 'keyup event' );

        dataStruct = {
        
            ajax: true,
            chromeless: false,
            email: $(this).val(),
            processInvoke: $(this).attr( 'processInvoke' )

        };

        dataType = 'json';

        fnObj = {

            success: function(response, url) {

                console.log( response );

                toastr[ response.growl.status ]( response.growl.message, response.growl.status );

                var formID      = [];
                var inputSubmit = {};
                
                self.parents().find( 'form' ).each( function(){
                   formID.push( $(this).attr( 'id' ) );
                });

                console.log( formID );

                if( response.formActions.disabled ){

                    self.parents().find( 'form' ).find( "input[type='submit']" ).attr( 'disabled', true );

                    $( "input[type='submit']" ).each(function(){

                        inputSubmit = $(this);

                        for( id in formID ){

                            console.log( inputSubmit.attr( 'form' ) );
                            console.log( formID[ id ] );

                            if( inputSubmit.attr( 'form' ) && $(this).attr( 'form' ).trim() === formID[ id ] ){
                            
                                inputSubmit.attr( 'disabled', true );

                            }
                        }
                    });

                }else{

                    self.parents().find( 'form' ).find( "input[type='submit']" ).attr( 'disabled', false );
                    $( "input[type='submit']" ).each(function(){

                        inputSubmit = $(this);


                        for( id in formID ){

                            console.log( inputSubmit.attr( 'form' ) );
                            console.log( formID[ id ] );


                            if( inputSubmit.attr( 'form' ) && $(this).attr( 'form' ).trim() === formID[ id ] ){
                            
                                inputSubmit.attr( 'disabled', false );

                            }
                        }
                    });

                }

            }

        }

        sendToServer('post', $(this).find( "input[type='Email']" ).data('validation'), dataStruct, dataType, fnObj);

    });

}

var callbackForPagination = function(){

    $( '.paginate_button' ).bind( 'click', function() {

        hooksForUserDataTables();
        callbackForPagination();

    });

}

//prototype
$(document).ready(function() {

    $('.js-rsb-selectSites').each(function() {

        $(this).on('click', function() {

            event.preventDefault();

            console.log($('#right-hand-sidebar')
                .find('.slimscrollright')
                .first());

            $.ajax({
                type: "get",
                url: "/adminpanel/dashboard/userSites",
                data: {
                    ajax: false,
                    chromeless: true
                },
                dataType: "html",
                success: function(response) {

                    $.when(appendHTMLToRightSidebar(response, this.url))
                        .then(
                            callbacks.fire()
                        ).then(
                            ajaxCallForSiteSelectionFn()
                        ).then(
                            enableEventsOnSearchAndFilter()
                        ).then(
                            closeSideBar()
                        );
                }
            });

        });

    });


    attachEventToForms();
    ajaxCallForSiteSelectionFn();
    enableEventsOnSearchAndFilter();
    hooksForUserDataTables();
    callbackForPagination();

    $( ' .navbar-brand .flip-card' )
        .mouseout(
            function(){
               $(this).removeClass( '.is-flipped' );
            }
        )
        .mouseover(
            function(){
                $(this).addClass( '.is-flipped' );
            }
        )

        //credits to Simon Shahriveri
        //https://codepen.io/hi-im-si/pen/uhxFn
        // modified with a promose to replace with a localeString by Larry Stanfield
        $('.counter').each(function() {
            var $this = $(this),
                countTo = $this.attr('data-count');
            
            $.when(
                $({ countNum: $this.text()}).animate({
                    countNum: countTo
                },
            
                {
            
                duration: 8000,
                easing:'linear',
                step: function() {
                    $this.text(Math.floor(this.countNum));
                },
                complete: function() {
                    $this.text(this.countNum);
                    //alert('finished');
                }
            
                })
            ).done(function(obj){
                console.log( obj );
               for( arrays in obj ){
                    console.log( obj[ arrays ][ 'countNum' ].toLocaleString( 'en' ) );
                    $this.text( obj[ arrays ][ 'countNum' ].toLocaleString( 'en' ) );

                   
               }
            })
            
            
          
        });

        $('#brand-carousel').carousel();

        $( '.sp-charts' ).sparkline();
        //$("#spark4").sparkline([5,6,7,2,3,9,4,2], {
        //    type: 'bar'});



});