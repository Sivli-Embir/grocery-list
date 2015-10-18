Meteor.users.allow 
  update: (userId, user, fields) ->
    return false unless userId is user._id
    return true if fields.length is 1 and fields[0] is 'lists'
    return false

    