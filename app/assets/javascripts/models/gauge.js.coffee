Gauge = Spine.Model.setup "Gauge", [ "current", "max", "temp", "value" ]
Gauge.include {
  value: ->
    (this.current ? this.max) + (this.temp ? 0)
    
  add: (amount) ->
    this.current = Math.min this.max, this.current + amount
    
  subtract: (amount) ->
    if this.temp > 0
      if amount > this.temp
        amount -= this.temp
        this.temp = 0
      else
        this.temp -= amount
        amount = 0
    this.current = Math.max 0, this.current - amount
    
  addTemp: (amount) ->
    this.temp += amount
    
  reset: ->
    this.temp = 0
    this.current = this.max
}

this.Gauge = Gauge
