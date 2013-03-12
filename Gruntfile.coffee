'use strict'

module.exports = (grunt) ->

  mainCoffeeDir = 'src/'
  testCoffeeDir = 'test/'

  mainJsDir = 'build/src/'
  testJsDir = 'build/test/'
  vendorJsDir = 'vendor/'

  mainModuleDir = 'build/modules/main/'
  vendorModuleDir = 'build/modules/vendor/'

  grunt.initConfig(
    pkg: grunt.file.readJSON('package.json')
    banner:
      """
      /*! <%= pkg.name %> v<%= pkg.version %> - <%= pkg.homepage %>
       * Copyright (c) <%= grunt.template.today("yyyy") %> <%= pkg.author.name %>
       * Licensed <%= _.pluck(pkg.licenses, "type").join(", ") %>
       */
      """
    coffee:
      options:
        bare: true
      main:
        expand: true
        cwd: mainCoffeeDir
        src: ['**/*.coffee']
        dest: mainJsDir
        ext: '.js'
      test:
        expand: true
        cwd: testCoffeeDir
        src: ['**/*.coffee']
        dest: testJsDir
        ext: '.js'
    commonjs:
      main:
        cwd: mainJsDir
        src: ['**/*.js']
        dest: mainModuleDir
      vendor:
        cwd: vendorJsDir
        src: ['**/*.js']
        dest: vendorModuleDir
    jasmine:
      main:
        src: [
          "#{mainModuleDir}/**/*.js"
        ]
        options:
          verbose: true
          specs: [
            "#{testJsDir}/**/*.js"
          ]
          vendor: [
            "lib/**/*.js"
            "#{vendorModuleDir}/**/*.js"
          ]
    uglify:
      unminified:
        src: [
          "#{mainModuleDir}**/*.js"
        ]
        dest: 'dist/<%= pkg.name %>.js'
        options:
          mangle: false
          compress: false
          beautify: true
          sourceMap: '<%= uglify.unminified.dest %>.map'
      minified:
        src: ["#{mainModuleDir}/**/*.js"]
        dest: 'dist/<%= pkg.name %>.min.js'
        options:
          sourceMap: '<%= uglify.minified.dest %>.map'
    watch:
      main:
        files: ["#{mainCoffeeDir}/**/*.coffee", "#{testCoffeeDir}/**/*.coffee"]
        tasks: ['coffee', 'commonjs', 'jasmine']
  )

  grunt.loadNpmTasks 'grunt-commonjs'
  grunt.loadNpmTasks 'grunt-contrib-coffee'
  grunt.loadNpmTasks 'grunt-contrib-uglify'
  grunt.loadNpmTasks 'grunt-contrib-jasmine'
  grunt.loadNpmTasks 'grunt-contrib-jshint'
  grunt.loadNpmTasks 'grunt-contrib-watch'

  grunt.registerTask 'default', ['coffee', 'commonjs', 'jasmine', 'uglify']
