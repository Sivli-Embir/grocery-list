Router.configure layoutTemplate: 'layout'

Router.route '/', -> this.render 'ListView'
Router.route '/item/:_id', -> this.render 'ItemView'