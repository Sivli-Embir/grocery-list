Template.ListSelect.onCreated ->
  @subscribe 'lists'
  @listIds = new ReactiveVar([])

Template.ListSelect.helpers
  lists: -> List.find()
  editMode: -> FlowRouter.getQueryParam('edit')
  # templateGestures:
  #   'swiperight .item': (e,t) -> e.target.style.transform = "translateX(#{e.deltaX}px)"
  #   'doubletap .item': (e,t) -> e.target.style.transform = "translateX(#{e.deltaX}px)"

Template._ListNewModal.events
  'click .add': (e, t) ->
    data = {
      name: t.$('.name').val().toUpperCase()
    }
    id = List.insert data
    Meteor.users.update Meteor.userId(), $push: lists: id if id

Template.ListSelectShopItem.helpers
  url: -> "/lists/#{@_id}"


Template.ListSelectEditItem.events
  'click .remove': -> 
    Item.find(listId: @_id).forEach (doc) -> Item.remove doc._id
    List.remove @_id
  'blur .name': (e,t) -> List.update @_id, $set: name: $(e.target).val().toUpperCase()

Template.ListSelectHeaderLeft.helpers
  editMode: -> FlowRouter.getQueryParam('edit')

Template.ListSelectHeaderLeft.events
  'click .button': ->
    FlowRouter.setQueryParams edit: unless FlowRouter.getQueryParam('edit') then 'active' else null