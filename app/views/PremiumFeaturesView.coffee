require('app/styles/premium-features-view.sass')
RootView = require 'views/core/RootView'
SubscribeModal = require 'views/core/SubscribeModal'
template = require 'templates/premium-features-view'
utils = require 'core/utils'
storage = require 'core/storage'

module.exports = class PremiumFeaturesView extends RootView
  id: 'premium-features-view'
  template: template

  i18nData: utils.premiumContent

  events:
    'click .buy': 'onClickBuy'
  
  subscriptions:
    'subscribe-modal:subscribed': 'onSubscribed'

  constructor: (options={}) ->
    super(options)
    
  afterInsert: () ->
    if utils.getQueryVariable('pop')? and not storage.load('sub-modal-continue')
      @openSubscriptionModal()
    super()

  openSubscriptionModal: ->
    @openModalView new SubscribeModal()

  onClickBuy: (e) ->
    @openSubscriptionModal()
    buttonLocation = $(e.currentTarget).data('button-location')
    window.tracker?.trackEvent 'Show subscription modal', category: 'Subscription', label: "get premium view #{buttonLocation}"

  onSubscribed: ->
    @render()
