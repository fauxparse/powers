class Character
  include MongoMapper::Document
  
  key :name, String
  key :slug, String
  one :abilities
  one :defenses
  many :powers
  one :hp, :class => Gauge
  one :surges
end