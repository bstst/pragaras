exports.list = function(db){
  return function(req, res){
    var collection = db.get('adcollection');
    collection.find({}, {}, function(e, docs){
      res.render('list', {list: docs})
    });
  }
};