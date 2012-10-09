$(document).ready(function () {
  $('.alert-box .close').click(function(event) {
    $(this).parent('div').fadeOut(500);
  });

  setTimeout(function() {
    $('.alert-box .close').parent('div').fadeOut(500);
  }, 5000);
});
