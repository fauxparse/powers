Character = Spine.Model.setup "Character", [ "name", "slug", "abilities", "defenses", "powers", "hp", "surges" ]
Character.extend Spine.Model.Ajax
Character.ajaxPrefix = "character"

Character.include {
  load: (attrs) ->
    Spine.Model::load.apply this, [attrs]
    this.powers = (this.powers || []).map((p) => Power.init(p))
    this.hp = Gauge.init(this.hp or {})
    this.surges = Gauge.init(this.surges or {})
    
  surge: ->
    if this.surges.current > 0
      this.surges.subtract 1
      this.hp.add this.surges.value
      
  shortRest: ->
    for power in this.powers
      power.reset() if power._type == "EncounterPower"
    this.hp.temp = 0
    while this.surges.current > 0 and this.hp.current + this.surges.value <= this.hp.max
      this.surge()
    
  extendedRest: ->
    power.reset() for power in this.powers
    this.hp.reset()
    this.surges.reset()
}

this.Character = Character