Template.ListView.onCreated ->
  listId = FlowRouter.getParam('_id')
  @subscribe 'items', listId
  @items = Item.find({listId: listId}, {sort: {name: [["name", "asc"]]}})
  @edit = new ReactiveVar(false)

Template.ListView.onRendered ->
  @edit.set $('.toggle input').prop( "checked" )

Template.ListView.helpers
  items: -> Template.instance().items.fetch()
  editMode: -> Template.instance().edit.get()
  url: -> '/lists'

Template.ListView.events
  'click .closeChangeMode': -> Template.instance().edit.set false
  'click [data-action=showActionSheet]': (e, t) ->
    IonActionSheet.show
      buttons: [
        { text: 'Edit All Items' }
      ]
      destructiveText: 'Delete All Checked Items'
      buttonClicked: (index) ->
        if index == 0
          t.edit.set true
          IonActionSheet.close()
      destructiveButtonClicked: -> 
        t.items.forEach (doc) -> Item.remove(doc._id) if doc.done
        IonActionSheet.close()

Template.ListViewShopItem.onRendered ->
  @$('.checkbox input').prop( "checked", @data.done ) if @data

Template.ListViewShopItem.helpers
  watchDoneState: () -> 
    t = Template.instance()
    if _.isBoolean(@done) and t.firstNode
      t.$('.checkbox input').prop( "checked", @done )
    null

Template.ListViewShopItem.events
  'change': (e, t) -> Item.update @_id, $set: done: t.$(e.target).prop( "checked" )

Template.ListViewEditItem.events
  'blur .name': (e, t) -> 
    name = $(e.target).val()
    Item.update @_id, $set: name: name.toUpperCase() if name
  'blur .notes': (e, t) -> Item.update @_id, $set: notes: t.$(e.target).val()
  'blur .count': (e, t) -> Item.update @_id, $set: count: parseFloat t.$(e.target).val()
  'click .remove': () -> Item.remove @_id

Template._ListViewNewModal.events
  'click .add': (e, t) ->
    data = {
      name: t.$('.name').val().toUpperCase()
      notes: t.$('.notes').val()
      count: parseFloat t.$('.count').val() if t.$('.count').val()
      listId: FlowRouter.getParam('_id')
    }
    Item.insert data