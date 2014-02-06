var server = require('tiny-lr')();
var gulp = require('gulp');
var path = require('path');
var coffee = require('gulp-coffee');
var uglify = require('gulp-uglify');
var browserify = require('gulp-browserify');
var concat = require('gulp-concat');
var styl = require('gulp-styl');
var livereload = require('gulp-livereload');
var less = require('gulp-less');
var Q = require('q');
var nodemon = require('gulp-nodemon');

gulp.task('coffee', ['listen'], function(){
  gulp.src([
    'src/coffee/**/*Util*.coffee',
    'src/coffee/**/*Model*.coffee',
    'src/coffee/**/*Collection*.coffee',
    'src/coffee/**/*View*.coffee',
    'src/coffee/**/**.coffee'
  ])
    .pipe(coffee({bare: true}).on('error', function(err){ console.log(err); }))
    .pipe(uglify())
    .pipe(concat('all.js'))
    .pipe(gulp.dest('app/public/js'))
    .pipe(livereload(server))
});

gulp.task('less', function(){
  gulp.src('src/less/**/*.less')
    .pipe(less({paths: [path.join(__dirname, 'less', 'includes')]}))
    .pipe(styl({compress : true}))
    .pipe(concat('all.css'))
    .pipe(gulp.dest('app/public/css'))
    .pipe(livereload(server))
});

gulp.task('listen', function(next){
  server.listen(35729, function(err){
    if(err) return console.log(err);
    next();
  });
});

gulp.task('express', function(){
  nodemon({script: 'app/app.js', options: '-e html,js -i ignored.js'});
});

gulp.task('default', ['express', 'listen', 'coffee', 'less'], function(){
  gulp.watch('src/coffee/**', ['coffee']);
  gulp.watch('src/less/**', ['less']);
});