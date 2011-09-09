Power = Spine.Model.setup "Power", [ "_type", "name", "description", "range", "level", "action_type", "rolls", "effects" ]

Power.include {
  init: (attrs) ->
    Spine.Model::init.apply this, [attrs]
    this.rolls = (this.rolls or []).map((r) -> Roll.init(r))
    this.uses or= 1
    this._uses = Gauge.init { current: this.uses, max: this.uses  }
    
  type: ->
    this._type.replace(/Power$/, "").replace(/([a-z])([A-Z])/g, "$1-$2")
    
  action: ->
    this.action_type.replace(/^(.)/, (a) -> a.toUpperCase()) + " Action"
    
  use: ->
    this._uses.subtract 1

  used: -> this._uses.current == 0
    
  reset: ->
    this._uses.reset()
    this.trigger "reset", this
}

this.Power = Power