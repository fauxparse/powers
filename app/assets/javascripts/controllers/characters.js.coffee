CharactersController = Spine.Controller.create {
  proxied: [ "addOne", "addAll" ]
  
  init: ->
    Character.bind "create",  this.addOne
    Character.bind "refresh", this.addAll
    Character.fetch()
    
  addOne: (character) ->
    this.characters or= {}
    (this.characters[character.id] or= CharacterController.init {
      el:        $("<div/>").addClass("character").appendTo(this.el)
      character: character
    }).render()
    
  addAll: ->
    Character.each this.addOne
}

CharacterController = Spine.Controller.create {
  proxied: [ "render", "remove" ]
  
  init: ->
    this.character.bind "update", this.render
    this.character.bind "destroy", this.remove
    this.el.html Jaml.render("character", this.character)
    this.powers = PowersController.init({
      el:     $("<div/>").addClass("powers").appendTo(this.el)
      powers: this.character.powers
    })
    
  render: (character) ->
    this.character = character if character?
    this
    
  remove: ->
    this.el.remove()
}

$(->
  CharactersController.init {
    el: $("<div/>").attr("id", "characters").appendTo("#container")
  }
)

this.CharactersController = CharactersController