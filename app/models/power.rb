class Power
  include MongoMapper::EmbeddedDocument

  key :name, String
  key :description, String
  key :range, String
  key :level, Integer
  key :action_type, Symbol
  one :uses, :class => Gauge
  many :rolls
  many :effects
end