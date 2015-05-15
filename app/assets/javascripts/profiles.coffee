jQuery ->
  Stripe.setPublishableKey($('meta[name="stripe-key"]').attr('content'))
  profile.setupForm()

profile =
  setupForm: ->
    $('#new_profile').submit ->
        $('input[type=submit]').attr('disabled', true)
        Stripe.bankAccount.createToken($('#new_profile'), profile.handleStripeResponse)
        false

  handleStripeResponse: (status, response) ->
    if status == 200
      $('#new_profile').append($('<input type="hidden" name="stripeToken" />').val(response.id))
      $('#new_profile')[0].submit()
    else
      alert(response.error.message)
      $('input[type=submit]').attr('disabled', false)