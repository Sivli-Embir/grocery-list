Router.configure layoutTemplate: 'layout'

Router.route '/lists', -> this.render 'ListSelect'
Router.route '/lists/:_id', -> 
  this.name = 'ListView'
  this.render 'ListView'



AccountsTemplates.configure
  defaultLayout: 'layoutNoop'
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

Router.plugin('ensureSignedIn')