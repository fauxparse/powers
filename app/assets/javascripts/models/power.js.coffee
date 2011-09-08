Power = Spine.Model.setup "Power", [ "_type", "name", "description", "range", "level", "action_type", "rolls", "effects" ]

Power.include {
  init: (attrs) ->
    Spine.Model::init.apply this, [attrs]
    this.rolls = (this.rolls or []).map((r) -> Roll.init(r))
    this.uses or= 1
    
  type: ->
    this._type.replace(/Power$/, "").replace(/([a-z])([A-Z])/g, "$1-$2")
    
  action: ->
    this.action_type.replace(/^(.)/, (a) -> a.toUpperCase()) + " Action"
}

this.Power = Power