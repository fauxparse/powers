class Roll
  include MongoMapper::EmbeddedDocument

  key :name, String
  key :dice, String
  key :effect, String
end