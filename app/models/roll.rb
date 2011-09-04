class Roll
  include MongoMapper::EmbeddedDocument
  
  key :name, String
  key :description, String
  key :dice, String
end