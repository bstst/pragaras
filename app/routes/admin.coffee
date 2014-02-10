request = require('request')
config = require("../config")
cheerio = require("cheerio")
_ = require("underscore")

exports.index = (req, res) ->
  res.render "admin/index",
    title: "helo"

exports.site = (req, res) ->

  options = config.sites[req.params.name]

  request "#{options.host}#{options.path}", (e, r, b) ->
    if not e
      $ = cheerio.load b, normalizeWhitespace: true
      out = []
      $("#{options.listClass}").each () ->
        item = $(this)
        out.push {
          title: item.find('h3').text()
        }
      console.log out
      res.render "admin/site",
        name: req.params.name
        items: out
