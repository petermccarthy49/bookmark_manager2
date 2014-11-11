env = ENV["RACK_ENV"] || "development"
# we're telling datamapper to use a postgres database on localhost
# the name will be "bookmark_manager2_test" or "bookmark_manager2_development" depending on the environment
# DataMapper::Logger.new(STDOUT, :debug)
DataMapper.setup(:default, "postgres://localhost/bookmark_manager2_#{env}")

# After declaring your models, you should finalise them
DataMapper.finalize

# However, the database tables don't exist yet. Let's tell datamapper to create them
DataMapper.auto_upgrade!