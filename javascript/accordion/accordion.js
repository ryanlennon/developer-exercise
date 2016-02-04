var testThis = true;

$(document).ready(function($) {
    $('.accordion-wrapper').find('.accordion-header').click(function() {

      $(this).next().slideToggle();

      $(".accordion-content").not($(this).next()).slideUp();

    });
});