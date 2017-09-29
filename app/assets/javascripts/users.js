/* global $ */
/* global Stripe */

// Document Ready
$(document).on('turbolinks:load', function() {
  
  var theForm = $('#pro_form');
  var submitButton = $('#form-submit-btn');
  
  // Set Stripe public key
  Stripe.setPublishableKey( $('meta[name="stripe-key"]').attr('content') );
  
  // When user clicks form submit button, prevent default submit behaviour
  submitButton.click( function(event) {
    // prevent default action
    event.preventDefault();
    
    // Collect credit card fields.
    var ccNum = $('#card_number').val(),
        cvcNum = $('#card_code').val(),
        expMonth = $('#card_month').val(),
        expYear = $('#card_year').val();
    
    // Send Card info to stripe.
    Stripe.createToken( {
      number: ccNum,
      cvc: cvcNum,
      exp_month: expMonth,
      exp_year: expYear
    }, StripeResponseHandler );
    
  });
  
  // Stripe returns card token.
  // Inject card token as hidden field into form.
  // THen submit form to our rails app.
});