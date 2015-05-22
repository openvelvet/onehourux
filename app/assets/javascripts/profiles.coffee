jQuery ->
  Stripe.setPublishableKey($('meta[name="stripe-key"]').attr('content'))
  profile.setupForm()

profile =
  setupForm: ->
    $('#bank_account').submit ->
        $('input[type=submit]').attr('disabled', true)
        Stripe.bankAccount.createToken($('#bank_account'), profile.handleStripeResponse)
        false

  handleStripeResponse: (status, response) ->
    if status == 200
      $('#bank_account').append($('<input type="hidden" name="stripeToken" />').val(response.id))
      $('#bank_account')[0].submit()
    else
      alert(response.error.message)
      $('input[type=submit]').attr('disabled', false)