# This class corresponds to a table in the database
# it is used to manipulate the data

class Link

  # this make sthe instances of this class Datamapper resources
  include DataMapper::Resource

  property :id, Serial # Serial means that it will be auto-incremented for every record
  property :title, String
  property :url, String

end