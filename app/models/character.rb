class Character
  include MongoMapper::Document
  
  key :name, String
  key :slug, String
  
  many :powers
end