Character = Spine.Model.setup "Character", [ "name", "powers", "hp", "surges" ]
Character.extend Spine.Model.Ajax
Character.ajaxPrefix = "character"

Character.include {
  load: (attrs) ->
    Spine.Model::load.apply this, [attrs]
    this.powers = (this.powers || []).map((p) => Power.init(p))
    this.hp = Gauge.init(this.hp or {})
}

this.Character = Character