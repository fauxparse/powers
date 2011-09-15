class Defenses
  include MongoMapper::EmbeddedDocument
  
  DEFENSES = %w(ac fortitude reflex will)
  DEFENSES.each do |defense|
    key :"#{defense}", Integer
  end
end