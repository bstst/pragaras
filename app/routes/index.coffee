exports.index = (req, res) ->
  console.log 1234
  res.render "index",
    title: "helo"

  return
