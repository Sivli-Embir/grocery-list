Router.configure layoutTemplate: 'layout'

Router.route '/', -> this.render 'ListView'
Router.route '/item/:_id', -> this.render 'ItemView'

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
    homeRoutePath: '/'
    redirectTimeout: 4000

AccountsTemplates.configureRoute('signIn')
AccountsTemplates.configureRoute('enrollAccount')

Router.plugin('ensureSignedIn')