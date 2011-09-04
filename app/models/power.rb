class Power
  include MongoMapper::EmbeddedDocument
  
  key :name, String
  key :description, String
  key :range, Integer
  key :level, Integer
  key :action_type, Symbol
  many :rolls
  many :effects
end