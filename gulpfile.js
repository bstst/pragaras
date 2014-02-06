var server = require('tiny-lr')();
var gulp = require('gulp');
var coffee = require('gulp-coffee');
var uglify = require('gulp-uglify');
var browserify = require('gulp-browserify');
var concat = require('gulp-concat');
var styl = require('gulp-styl');
var livereload = require('gulp-livereload');
var Q = require('q');

gulp.task('scripts', ['listen'], function() {
  gulp.src(['src/coffee/**/*.coffee'])
    .pipe(coffee({bare: true}).on('error', function(err){ console.log(err); }))
    .pipe(uglify())
    .pipe(concat('all.min.js'))
    .pipe(gulp.dest('build/js'))
    .pipe(livereload(server))
});

gulp.task('styles', ['listen'], function() {
  gulp.src(['src/css/**/*.css'])
    .pipe(styl({compress : true}))
    .pipe(gulp.dest('build/css'))
    .pipe(livereload(server))
});

gulp.task('listen', function(next) {
  server.listen(35729, function(err) {
    if(err) return console.log(err);
    next();
  });
});

gulp.task('default', ['listen', 'scripts', 'styles'], function() {
  gulp.watch('src/**', ['scripts']);
  gulp.watch('css/**', ['styles']);
});