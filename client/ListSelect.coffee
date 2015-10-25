Template.ListSelect.onCreated ->
  @subscribe 'lists'
  @listIds = new ReactiveVar([])
  @autorun =>
    user = Meteor.user()
    @listIds.set user.lists if user and user.lists

Template.ListSelect.helpers
  lists: -> List.find _id: $in: Template.instance().listIds.get()
  editMode: -> FlowRouter.getQueryParam('edit')
  # templateGestures:
  #   'swiperight .item': (e,t) -> e.target.style.transform = "translateX(#{e.deltaX}px)"
  #   'doubletap .item': (e,t) -> e.target.style.transform = "translateX(#{e.deltaX}px)"

Template._ListNewModal.events
  'click .add': (e, t) ->
    data = {
      name: t.$('.name').val()
    }
    id = List.insert data
    Meteor.users.update Meteor.userId(), $push: lists: id if id

Template.ListSelectShopItem.helpers
  url: -> "/lists/#{@_id}"


Template.ListSelectEditItem.events
  'click .remove': -> 
    Item.find(listId: @_id).forEach (doc) -> Item.remove doc._id
    List.remove @_id

Template.ListSelectHeaderLeft.helpers
  editMode: -> FlowRouter.getQueryParam('edit')

Template.ListSelectHeaderLeft.events
  'click .button': ->
    FlowRouter.setQueryParams edit: unless FlowRouter.getQueryParam('edit') then 'active' else null