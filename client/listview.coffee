Template.ListView.onCreated ->
  @items = Item.find()

Template.ListView.helpers
  items: -> Template.instance().items.fetch()
  editMode: -> Session.get('editMode')