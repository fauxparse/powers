Character = Spine.Model.setup "Character", [ "name", "slug", "level", "abilities", "defenses", "powers", "hp", "surges", "action_points" ]
Character.extend Spine.Model.Ajax
Character.ajaxPrefix = "character"

Character.include {
  load: (attrs) ->
    Spine.Model::load.apply this, [attrs]
    this.powers = (this.powers || []).map((p) => Power.init(p))
    this.hp = Gauge.init(this.hp or {})
    this.surges = Gauge.init(this.surges or {})

  scheduleSave: ->
    if this.saveTimer
      clearTimeout this.saveTimer
    this.saveTimer = setTimeout((=> this.save()), 500)

  surge: (doSave) ->
    if this.surges.current > 0
      this.surges.subtract 1
      this.hp.add this.surges.value
      if doSave != false
        this.scheduleSave()

  shortRest: ->
    for power in this.powers
      power.reset() if power._type == "EncounterPower"
    this.hp.temp = 0
    while this.surges.current > 0 and this.hp.current + this.surges.value <= this.hp.max
      this.surge(false)
    this.scheduleSave()

  extendedRest: ->
    power.reset() for power in this.powers
    this.hp.reset()
    this.surges.reset()
    this.action_points = 1
    this.scheduleSave()

  heal: (amount) ->
    this.hp.add amount
    this.scheduleSave()

  tempHP: (amount) ->
    this.hp.addTemp amount
    this.scheduleSave()

  damage: (amount) ->
    this.hp.subtract amount
    this.scheduleSave()

  useActionPoint: ->
    if this.action_points > 0
      this.action_points--
      this.scheduleSave()

  gainActionPoint: ->
    this.action_points++
    this.scheduleSave()

  halfLevel: ->
    Math.floor(this.level / 2)
}

this.Character = Character