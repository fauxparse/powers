Power = Spine.Model.setup "Power", [ "_type", "name", "description", "range", "level", "action_type", "rolls", "effects", "uses" ]

Power.include {
  init: (attrs) ->
    Spine.Model::init.apply this, [attrs]
    this.rolls = (this.rolls or []).map((r) -> Roll.init(r))
    this.uses = Gauge.init(this.uses or { current: 1, max: 1 })

  type: ->
    this._type.replace(/Power$/, "").replace(/([a-z])([A-Z])/g, "$1-$2")

  action: ->
    a = (this.action_type || "standard_action").replace(/^(.)/, (a) -> a.toUpperCase())
    a += " Action" unless /interrupt$/i.test(this.action_type)
    a

  use: ->
    this.uses.subtract 1

  used: -> this.uses.current == 0

  reset: ->
    this.uses.reset()
    this.trigger "reset", this
}

this.Power = Power