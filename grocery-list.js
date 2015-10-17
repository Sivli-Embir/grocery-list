Router.route('/', function () {
  this.render('ListView', {
    // data: function () { return Items.findOne({_id: this.params._id}); }
  });
});