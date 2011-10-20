class Character
  include MongoMapper::Document

  key :name, String
  key :slug, String
  key :level, Integer
  one :abilities
  one :defenses
  many :powers
  one :hp, :class => Gauge
  one :surges
  key :action_points, Integer, :default => 1
end