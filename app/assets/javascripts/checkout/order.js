$(function(){
  var $container = $('.js_container');

  $container.on('click', '#showInsurance', function () {
        $('#dialogInsurance').show();
        $('#dialogInsurance').find('.weui_btn_dialog').on('click', function () {
            $('#dialogInsurance').hide();
        });
    });

})