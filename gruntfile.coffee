module.exports = (grunt) ->
  # Project configuration.
  grunt.initConfig
    pkg: grunt.file.readJSON('package.json'),
    coffee:
      compile:
        files:
          'lib/SpeakNoEvil.js': 'src/SpeakNoEvil.coffee', # 1:1 compile
          # 'spec/spec.js': 'spec/spec.coffee', # 1:1 compile
    gitcommit:
      module:
        options:
          message: "Grunt built lib from src."
          verbose: true
        files:
          src: [
            'lib/SpeakNoEvil.js', 'src/SpeakNoEvil.coffee',
          ]
      gruntfile:
        options:
          message: "Gruntfile updated."
        files:
          src: 'gruntfile.coffee'
      package:
        options:
          message: "package.json updated."
        files:
          src: 'package.json'
    gitpush:
      module:
        options: {}
    mochaTest:
      test:
        options:
          reporter: 'spec'
          require: ['coffee-script/register']
        
        src: ['test/**/*.coffee']
    
  grunt.loadNpmTasks 'grunt-mocha-test'

  # Load the plugin that provides the "coffee" task.
  grunt.loadNpmTasks 'grunt-contrib-coffee'
  grunt.loadNpmTasks 'grunt-git'

  # Default task(s).
  grunt.registerTask 'default', ['coffee', 'mochaTest']
  grunt.registerTask 'commit', ['gitcommit:module', 'gitcommit:gruntfile', 'gitcommit:package']
  grunt.registerTask 'push', ['gitpush']
  grunt.registerTask 'build', ['coffee', 'gitcommit:module', 'gitpush']
