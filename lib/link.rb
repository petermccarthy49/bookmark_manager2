# this class corresponds to a table in the db
# it's used to manipulate the data

class Link

  # this makes the instances of this class Datamapper resources
  include DataMapper::Resource

  has n, :tags, :through => Resource

  # this block describes what resiurces the model will have
  property :id,      Serial
  property :title,   String
  property :url,     String

end