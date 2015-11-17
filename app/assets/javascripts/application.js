// This is a manifest file that'll be compiled into application.js, which will include all the files
// listed below.
//
// Any JavaScript/Coffee file within this directory, lib/assets/javascripts, vendor/assets/javascripts,
// or any plugin's vendor/assets/javascripts directory can be referenced here using a relative path.
//
// It's not advisable to add code directly here, but if you do, it'll appear at the bottom of the
// compiled file.
//
// Read Sprockets README (https://github.com/rails/sprockets#sprockets-directives) for details
// about supported directives.
//
//= require jquery
//= require flexisel/js/jquery.flexisel
//= require bootstrap/dist/js/bootstrap.min
//= require jquery_ujs
//= require turbolinks
//= require memenu
//= require flexslider/jquery.flexslider-min
//= require jquery-ui/jquery-ui.min
//= require simpleCart.min
//= require home
//= require products


function addToCartBinding() {
  $(".numbers-row").before('<div class="dec button">-</div>')
  $(".numbers-row").after('<div class="inc button">+</div>')
    $(".add-to-cart .button").on("click", function() {

      var $button = $(this);
      var oldValue = $button.parent().find("input").val();

      if ($button.text() == "+") {
        var newVal = parseFloat(oldValue) + 1;
      } else {
       // Don't allow decrementing below zero
        if (oldValue > 0) {
          var newVal = parseFloat(oldValue) - 1;
        } else {
          newVal = 0;
        }
      }

      $button.parent().find("input").val(newVal);

    });
}

$(function() {
  addToCartBinding();
})