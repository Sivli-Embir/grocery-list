Template.ListSelect.onCreated ->
  @autorun =>
    @user = Meteor.user()
    @lists = List.find @user.lists if @user

Template.ListSelect.helpers
  lists: -> Template.instance().lists if Template.instance().user