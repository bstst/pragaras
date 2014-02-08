exports.list = (db) ->
  (req, res) ->
    collection = db.get("adcollection")
    collection.find {}, {}, (e, docs) ->
      res.render "list",
        list: docs

      return

    return
