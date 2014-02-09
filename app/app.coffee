express = require("express")
ect = require("ect")
routes = require("./routes")
ads = require("./routes/ads")
http = require("http")
path = require("path")
mongo = require("mongodb")
monk = require("monk")
db = monk("localhost:27017/pragaras")
app = express()

es = require('elasticsearch')
client = new es.Client
  host: 'localhost:9200'
  log: 'trace'

app.set "port", process.env.PORT or 3000

app.set "views", path.join(__dirname, "views")
app.set "view engine", "ect"
ectr = ect(
  watch: true
  root: __dirname + "/views"
)
app.engine ".ect", ectr.render

app.use express.favicon()
app.use express.logger("dev")
app.use express.json()
app.use express.urlencoded()
app.use express.methodOverride()
app.use express.cookieParser("pppragarass")
app.use express.session()
app.use app.router
app.use express.static(path.join(__dirname, "public"))

app.use express.errorHandler() if "development" is app.get("env")

app.get "/", routes.index
app.get "/ads", ads.list(db)

http.createServer(app).listen app.get("port"), ->
  console.log "Express server listening on port " + app.get("port")

