CharactersController = Spine.Controller.create {
  proxied: [ "addOne", "addAll", "flip", "select" ]

  events: {
    "click .character>.header": "flip"
    "click .list a": "select"
  }

  init: ->
    Character.bind "create",  this.addOne
    Character.bind "refresh", this.addAll
    this.container = $("<div/>").addClass("characters").appendTo(this.el)
    this.list = $("<div><ul/></div>").addClass("list").appendTo(this.el).children("ul");
    Character.fetch()

  addOne: (character) ->
    this.characters or= {}
    $("<li><a href=\"#character_#{character.id}\">#{character.name}</a></li>").appendTo(this.list);
    (this.characters[character.id] or= CharacterController.init {
      el:        $("<div/>").addClass("character").attr("id", "character_#{character.id}").appendTo(this.container).hide()
      character: character
    }).render()

  addAll: ->
    this.characters = {}
    this.$(".character").remove()
    this.$(".list li").remove();
    Character.each this.addOne
    this.characters[Character.first().id].el.show()

  flip: ->
    this.el.toggleClass("selecting")

  select: (event) ->
    event.preventDefault()
    console.log($(event.target).attr("href"));
    this.$($(event.target).attr("href")).show().siblings().hide()
    this.el.toggleClass("selecting")
    return false
}

CharacterController = Spine.Controller.create {
  proxied: [ "render", "remove" ]

  init: ->
    this.character.bind "update", this.render
    this.character.bind "destroy", this.remove
    this.el.html Jaml.render("character", this.character)
    this.tabs = TabsController.init {
      el: this.el
    }
    this.tabs.add "abilities", "Abilities", AbilitiesController, { character: this.character }
    this.tabs.add "health", "Health", HealthController, { character: this.character }
    this.tabs.add "powers", "Powers", PowersController, { character: this.character, powers: this.character.powers }
    this.tabs.kick()

  render: (character) ->
    this.character = character if character?
    this

  remove: ->
    this.el.remove()
}

$(->
  CharactersController.init {
    el: $("<div/>").attr("id", "characters").appendTo("#container").addClass("selecting")
  }
)

this.CharactersController = CharactersController