Meteor.publish 'user', () -> Meteor.users.find @userId, {limit: 1, fields: lists: 1} if @userId

Meteor.publish 'lists', () -> 
  return unless @userId
  user = Meteor.users.findOne(@userId, {fields: lists: 1}) 
  List.find _id: $in: user.lists

Meteor.publish 'items', (listId) -> 
  return unless @userId
  user = Meteor.users.findOne(@userId, {fields: lists: 1}) 
  if user and _.contains user.lists, listId
    return [
      Item.find listId: listId
      List.find listId #items will need this for validations
    ]