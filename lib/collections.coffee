@Item = new ShadowModel
  collection: new Mongo.Collection('items')
  schema:
    name: (value) ->
      return @invalid 'must be a alphanumeric' unless _.isString value
      return @invalid 'must be not be empty' unless value.length
      @valid 'is valid'
    notes: (value) ->
      return @valid 'can be empty' if value is undefined
      return @valid 'is normal text' if _.isString value
      return @invalid 'not sure what this is'
    count: (value) ->
      return @valid 'can be empty' if value is undefined
      return @invalid 'must be a number' unless _.isNumber value
      return @invalid 'must be a non negative number' unless value >= 0
      @valid 'is valid'

  helpers: {}

@List = new ShadowModel
  collection: new Mongo.Collection('lists')
  schema: {}
  helpers: {}