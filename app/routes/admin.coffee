request = require('request')
config = require("../config")
cheerio = require("cheerio")
_ = require("underscore")

getOptions = (name) ->
  config.sites[name]

exports.index = (req, res) ->
  res.render "admin/index",
    title: "helo"

exports.site = (req, res) ->
  options = getOptions req.params.name

  request "#{options.host}#{options.path}", (e, r, b) ->
    if not e
      $ = cheerio.load b, normalizeWhitespace: true
      out = []
      $("#{options.listClass}").each () ->
        item = $(this)
        out.push {
          id: item.find('h3 a').attr('href').match(/(\d+)\.html$/)[1]
          title: item.find('h3').text()
        }
      console.log out
      res.render "admin/site",
        name: req.params.name
        items: out

exports.item = (req, res) ->
  name = req.params.name
  id = req.params.id
  options = getOptions name

  request "#{options.itemPath}#{options.item.replace(/{id}/, id)}", (e, r, b) ->
    if not e
      item = {}
      $ = cheerio.load b, normalizeWhitespace: true
      item.title = $('h1').text()
      item.content = $('#description').text()
      item.price = $('#priceDiv').text().match(/(\d+\s*)+/)[0].replace(/\s/g, '')
      console.log item
      res.render "admin/item",
        name: req.params.name
        id: req.params.id
        item: item

