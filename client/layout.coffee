Template.layout.onCreated ->  Session.set('hasHeader', true)
Template.layout.onDestroyed ->  Session.set('hasHeader', false)
Template.layout.helpers
  platform: -> if Platform.isAndroid() then 'android' else 'ios'