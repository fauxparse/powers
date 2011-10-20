class Skill
  include MongoMapper::EmbeddedDocument

  embedded_in :character

  ALL = {
    "Acrobatics"    => :dexterity,
    "Arcana"        => :intelligence,
    "Athletics"     => :strength,
    "Bluff"         => :charisma,
    "Diplomacy"     => :charisma,
    "Dungeoneering" => :wisdom,
    "Endurance"     => :constitution,
    "Heal"          => :wisdom,
    "History"       => :intelligence,
    "Insight"       => :wisdom,
    "Intimidate"    => :charisma,
    "Nature"        => :wisdom,
    "Perception"    => :wisdom,
    "Religion"      => :intelligence,
    "Stealth"       => :dexterity,
    "Streetwise"    => :charisma,
    "Thievery"      => :dexterity
  }.freeze

  key :name, String
  key :ability, Symbol
  key :trained, Boolean, :default => false
  key :penalty, Integer, :default => 0
  key :misc, Integer, :default => 0

  def bonus
    mod + training + penalty + misc
  end

  def mod
    character.abilities.send(:"#{ability}_modifier") + character.level / 2
  end

  def training
    if trained
      5
    else
      0
    end
  end

  def train!
    self.trained = true
  end
end