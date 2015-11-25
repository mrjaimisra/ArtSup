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
//= require jquery_ujs
//= require turbolinks
//= require bootstrap-sprockets
//= require_tree .

$(document).ready(function () {
});

$(document).on('page:change', function () {
  $('.wishlistItems').delegate('#amazonButton', 'click', function () {
    var amazonButton = $(this);
    var title = $(this).closest('.wishlistItemData').find('.wishlistItemTitle').text().trim();
    var price = $(this).closest('.wishlistItemData').find('.wishlistItemPrice').text().split(": ")[1].trim();
    var quantity = $(this).closest('.wishlistItemData').find('.wishlistItemQuantity').text().split(": ")[1].trim();
    var image = $(this).closest(".wishlistItem").find(".wishlistItemImage").find('img').attr('src');

    var url = window.location.pathname.split('/')[2];
    var asin = $(this).attr('data-asin');

    var data = {
      url: url,
      asin: asin,
      title: title,
      price: price,
      quantity: quantity,
      image: image
    };

    $.ajax({
      type: 'post',
      url: '/confirm/' + asin,
      data: data,
      success: function () {
        window.location = "/confirm/" + asin
          + "?asin=" + asin
          + '&title=' + title
          + '&price=' + price
          + '&quantity=' + quantity
          + '&image=' + image
          + '&url=' + url;
      }
    });
  });
});
