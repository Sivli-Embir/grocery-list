Template.ListSelect.onCreated ->
  @listIds = new ReactiveVar([])
  @autorun =>
    user = Meteor.user()
    @listIds.set user.lists if user and user.lists

Template.ListSelect.helpers
  lists: -> List.find _id: $in: Template.instance().listIds.get()


Template._ListNewModal.events
  'click .add': (e, t) ->
    data = {
      name: t.$('.name').val()
    }
    id = List.insert data
    Meteor.users.update Meteor.userId(), $push: lists: id if id