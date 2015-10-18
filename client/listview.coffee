Template.ListView.onCreated ->
  @items = Item.find({}, {sort: {name: 1}})
  @edit = new ReactiveVar(false)

Template.ListView.onRendered ->
  @edit.set $('.toggle input').prop( "checked" )

Template.ListView.helpers
  items: -> Template.instance().items.fetch()
  editMode: -> Template.instance().edit.get()
  collection: -> Item

Template.ListView.events
  'click .closeChangeMode': -> Template.instance().edit.set false
  'click [data-action=showActionSheet]': (e, t) ->
    IonActionSheet.show
      buttons: [
        { text: 'Mass Edit' }
      ]
      destructiveText: 'Remove all checked'
      buttonClicked: (index) ->
        if index == 0
          t.edit.set true
          IonActionSheet.close()
      destructiveButtonClicked: -> 
        t.items.forEach (doc) -> Item.remove(doc._id) if doc.done
        IonActionSheet.close()

Template.ListViewShopItem.onRendered ->
  @$('.checkbox input').prop( "checked", @data.done ) if _.isBoolean @data.done

Template.ListViewShopItem.events
  'change': (e, t) -> Item.update @_id, $set: done: t.$(e.target).prop( "checked" )

Template.ListViewEditItem.events
  'blur .name': (e, t) -> 
    name = $(e.target).val()
    Item.update @_id, $set: name: name if name
  'blur .notes': (e, t) -> Item.update @_id, $set: notes: t.$(e.target).val()
  'blur .count': (e, t) -> Item.update @_id, $set: count: t.$(e.target).val()
  'click .remove': () -> Item.remove @_id

Template._ListViewNewModal.events
  'click .add': (e, t) ->
    data = {
      name: t.$('.name').val()
      notes: t.$('.notes').val()
      count: t.$('.count').val()
    }
    Item.insert data