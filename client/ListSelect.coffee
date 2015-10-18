Template.ListSelect.onCreated ->
  @autorun =>
    @user = Meteor.user()
    @lists = List.find _id: $in: @user.lists if @user and @user.lists

Template.ListSelect.helpers
  lists: -> Template.instance().lists if Template.instance().user


Template._ListNewModal.events
  'click .add': (e, t) ->
    data = {
      name: t.$('.name').val()
    }
    id = List.insert data
    Meteor.users.update Meteor.usersId(), $push: lists: id if id