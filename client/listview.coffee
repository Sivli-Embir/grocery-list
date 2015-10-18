Template.ListView.onCreated ->
  @items = Item.find()
  @edit = new ReactiveVar(false)

Template.ListView.onRendered ->
  @edit.set $('.toggle input').prop( "checked" )

Template.ListView.helpers
  items: -> Template.instance().items.fetch()
  editMode: -> Template.instance().edit.get()

Template.ListView.events
  'change .toggle': (e, t) -> Template.instance().edit.set $(e.target).prop( "checked" )