server = require("tiny-lr")()
gulp = require("gulp")
path = require("path")
coffee = require("gulp-coffee")
uglify = require("gulp-uglify")
browserify = require("gulp-browserify")
concat = require("gulp-concat")
styl = require("gulp-styl")
livereload = require("gulp-livereload")
less = require("gulp-less")
Q = require("q")
nodemon = require("gulp-nodemon")

gulp.task "coffee", ["listen"], ->
  gulp.src([
    "src/coffee/**/*Util*.coffee"
    "src/coffee/**/*Model*.coffee"
    "src/coffee/**/*Collection*.coffee"
    "src/coffee/**/*View*.coffee"
    "src/coffee/**/**.coffee"
  ]).pipe(coffee(bare: true).on("error", (err) ->
    console.log err
    return
  )).pipe(uglify()).pipe(concat("all.js")).pipe(gulp.dest("app/public/js")).pipe livereload(server)
  return

gulp.task "less", ->
  gulp.src("src/less/**/*.less").pipe(less(paths: [path.join(__dirname, "less", "includes")])).pipe(styl(compress: true)).pipe(concat("all.css")).pipe(gulp.dest("app/public/css")).pipe livereload(server)
  return

gulp.task "listen", (next) ->
  server.listen 35729, (err) ->
    return console.log(err)  if err
    next()
    return

  return

gulp.task "express", ->
  nodemon
    script: "app/app.coffee"
    options: "-e ect,coffee -i ignored.js"

  return

gulp.task "default", [
    "express"
    "listen"
    "coffee"
    "less"
  ], ->
  gulp.watch "src/coffee/**", ["coffee"]
  gulp.watch "src/less/**", ["less"]
  return

