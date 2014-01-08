###
  Auto generated task by Gake
  Please visit http://gruntjs.com/ to learn more about how to work with grunt tasks
###
path = require('path')

module.exports = (grunt, done) ->
  grunt.registerTask('migration:statusTask', 'checks the status of the migrations', ()->
    done = @async()
    @requires('migration:loadConfig')
    #@requiresConfig('migration.config')

    config = grunt.config.get('migration.config')
    SchemaMigration = require("#{grunt.config.get('migration.config.migrationLibPath')}/schema_migration")(config.defaultAdapterName)

    options = {adapters:{}}
    options.adapters[config.defaultAdapterName] = config.defaultAdapter

    new SchemaMigration(options, (err, Model)->
      console.log Model.define(Model.attributes, ->
        result = Model.create(version: 1).done( (err, result)->
          console.log err, result
          done()
        )
      )
    )
  )

  grunt.registerTask('migration:status', ['migration:loadConfig', 'migration:statusTask'])
