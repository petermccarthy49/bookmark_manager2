env = ENV["RACK_ENV"]  || "development"
# we're telling datamapper to use a postgres db on localhost
# the name will be "bookmerk_manager_test" or "bookmark_manager_development"
# depending on the environment
DataMapper.setup(:default, "postgres://localhost/bookmark_manager_#{env}")

# this needs to be done after datamapper is initialized
require './lib/link'

# after declaring models you should finalise them
DataMapper.finalize
# however, the db tables don't exist yet, so let's tell datamapper to create them
DataMapper.auto_upgrade!