class Abilities
  include MongoMapper::EmbeddedDocument
  
  ABILITIES = %w(strength constitution dexterity intelligence wisdom charisma)
  ABILITIES.each do |ability|
    key :"#{ability}", Integer
    define_method(:"#{ability}_modifier") { (send(ability) - 10) / 2 }
  end
end