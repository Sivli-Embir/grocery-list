AccountsTemplates.configure
  defaultLayout: 'layoutNoop'
  defaultLayoutRegions: {}
  defaultContentRegion: 'main'

  confirmPassword: true
  enablePasswordChange: true
  overrideLoginErrors: true
  focusFirstInput: true
  showForgotPasswordLink: true
  showLabels: true
  showPlaceholders: true
  negativeValidation: true
  positiveValidation: true
  positiveFeedback: true
  showValidating: true
  homeRoutePath: '/lists'
  redirectTimeout: 4000

AccountsTemplates.configureRoute 'signIn', path: '/'

AccountsTemplates.configureRoute('enrollAccount')

FlowRouter.route '/lists', 
  name: 'Lists'
  action: -> 
    BlazeLayout.render 'layout', 
      headerButtonLeft: 'ListSelectHeaderLeft'
      headerTitle: 'ListSelectHeader' 
      headerButtonRight: 'ListSelectHeaderRight'
      main: "ListSelect"
      
FlowRouter.route '/lists/:_id', 
  name: 'test'
  action: ->  
    BlazeLayout.render 'layout', 
      main: "ListView"
      headerButtonLeft: 'ListViewHeaderLeft'
      headerTitle: 'ListViewHeader' 

Meteor.methods
  'addUser': (id, email) ->
    Meteor.users.update {'emails.address': "cmtoups@me.com"}, $push: lists: id if id
