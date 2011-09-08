class Character
  include MongoMapper::Document
  
  key :name, String
  key :slug, String
  many :powers
  one :hp, :class => Gauge
  one :surges, :class => Surges
end