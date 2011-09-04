Character = Spine.Model.setup "Character", [ "name", "powers" ]
Character.extend Spine.Model.Ajax
Character.ajaxPrefix = "character"

Character.include {
  init: (attrs) ->
    Spine.Model::init.apply this, [attrs]
    this.powers = (this.powers || []).map((p) => Power.init(p))
}

this.Character = Character