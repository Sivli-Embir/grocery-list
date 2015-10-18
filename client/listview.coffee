Template.ListView.onCreated ->
  @items = Item.find()
  @edit = new ReactiveVar()

Template.ListView.helpers
  items: -> Template.instance().items.fetch()
  editMode: -> Template.instance().edit.get()

Template.ListView.events
  'click .changeMode': () -> console.log 'click'