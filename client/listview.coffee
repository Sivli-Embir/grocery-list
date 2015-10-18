Template.ListView.onCreated ->
  @items = Item.find()
  @edit = new ReactiveVar(false)

Template.ListView.onRendered ->
  @edit.set $('.toggle input').prop( "checked" )

Template.ListView.helpers
  items: -> Template.instance().items.fetch()
  editMode: -> Template.instance().edit.get()

Template.ListView.events
  'change .toggle': (e, t) -> Template.instance().edit.set t.$(e.target).prop( "checked" )
  'click .new': (e, t) -> 
    Template.instance().edit.set true
    t.$('.toggle input').prop( "checked", true )
    Item.insert name: 'New Item'

Template.ListViewShopItem.onRendered ->
  @$('.checkbox input').prop( "checked", @data.done ) if _.isBoolean @data.done

Template.ListViewShopItem.events
  'change': (e, t) -> Item.update @_id, $set: done: t.$(e.target).prop( "checked" )

Template.ListViewEditItem.events
  'blur .name': (e, t) -> 
    name = $(e.target).val()
    Item.update @_id, $set: name: name if name
  'blur .notes': (e, t) -> Item.update @_id, $set: notes: t.$(e.target).val()
  'click .remove': () -> Item.remove @_id