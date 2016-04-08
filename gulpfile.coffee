gulp = require 'gulp'
nodemon = require 'nodemon'
webpack = require 'gulp-webpack'
stylus = require 'gulp-stylus'


gulp.task 'webpack',->
  gulp.src './server/js/'
  .pipe webpack require './webpack.config.coffee'
  .pipe gulp.dest './public/js/'

gulp.task 'stylus',->
  gulp.src ['server/css/**/*.styl','!server/css/**/_*.styl']
  .pipe stylus()
  .pipe gulp.dest 'public/css/'

gulp.task 'watch',->
  gulp.watch './server/js/**/*.coffee',['webpack']
  gulp.watch ['./server/css/**/*.styl','!./server/css/**/_*.styl'], ['stylus']

gulp.task 'nodemon',->
  nodemon
    script: './server/app.coffee'

gulp.task 'default',['nodemon','watch']