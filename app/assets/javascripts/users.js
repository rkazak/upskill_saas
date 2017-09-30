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
    submitBtn.val("Processing").prop('disabled', true);
    // Collect credit card fields.
    var ccNum = $('#card_number').val(),
        cvcNum = $('#card_code').val(),
        expMonth = $('#card_month').val(),
        expYear = $('#card_year').val();
        
    // Use Stripe JS library to verify data entered.

    var error = false;

    // Validate credit card number.
    if (!Stripe.card.validateCardNumber(ccNum)) {
      error = true;
      alert('The credit card number appears to be invalid');
    };
    
    // Validate CVC number.
    if (!Stripe.card.validateCVC(cvcNum)) {
      error = true;
      alert('The credit card CVC number appears to be invalid');
    };
    
    // Validate expiration date.
    if (!Stripe.card.validateExpiry(expMonth, expYear)) {
      error = true;
      alert('The credit card expiry date appears to be invalid');
    };
    
    if (error) {
      // We don't send any data to Stripe
      submitBtn.val("Sign Up").prop('disabled', false);
   
    } else
      // Send Card info to stripe.
      Stripe.createToken( {
        number: ccNum,
        cvc: cvcNum,
        exp_month: expMonth,
        exp_year: expYear
      }, StripeResponseHandler );
    }
    return false;
    
  });
  
  // Stripe returns card token.
  function StripeResponseHandler(status, response) {
    // extract token from response
    var token = response.id;
    // Inject the card token into a hidden field.
    theForm.append($('<input type="hidden" name="user[stripe_card_token]" />').val(token) );

    // Then submit form to our rails app.
    theForm.get(0).submit();
  }
  
});