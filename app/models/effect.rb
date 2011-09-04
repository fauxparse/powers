class Effect
  include MongoMapper::EmbeddedDocument
  
  key :name, String
  key :description, String
end
