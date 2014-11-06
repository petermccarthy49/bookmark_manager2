env = ENV["RACK_ENV"]  || "development"
# we're telling datamapper to use a postgres db on localhost
# the name will be "bookmark_manager2_test" or "bookmark_manager2_development"
# depending on the environment
DataMapper.setup(:default, "postgres://localhost/bookmark_manager2_#{env}")

# this needs to be done after datamapper is initialized
require 'sinatra'
require 'data_mapper'
require './lib/link'




# after declaring models you should finalise them
DataMapper.finalize
# however, the db tables don't exist yet, so let's tell datamapper to create them
DataMapper.auto_upgrade!
# auto_upgrade makes non-destructive changes. It your tables don't exist, they will be created
# but if they do and you changed your schema (e.g. changed the type of one of the properties)
# they will not be upgraded because that'd lead to data loss.
# To force the creation of all tables as they are described in your models, even if this
# leads to data loss, use auto_migrate:
# DataMapper.auto_migrate!