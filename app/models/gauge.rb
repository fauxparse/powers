class Gauge
  include MongoMapper::EmbeddedDocument
  
  key :current, Integer
  key :max, Integer
  key :temp, Integer
  
  def current
    super or max
  end
  
  def temp
    super or 0
  end
  
  def to_i
    current + temp
  end
end