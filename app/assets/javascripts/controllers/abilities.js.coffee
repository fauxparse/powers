AbilitiesController = Spine.Controller.create {
  proxied: [ "render" ]
  
  init: ->
    this.character.bind "update", this.render
    
  render: ->
    this.el.html Jaml.render("abilities", this.character)
    this
    
}

this.AbilitiesController = AbilitiesController