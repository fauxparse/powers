HealthController = Spine.Controller.create {
  proxied: [ "render", "adjustHP", "surge", "rest" ]
  
  events: {
    "click .hp a": "adjustHP"
    "click .surges a": "surge"
    "click .rest": "rest"
  }
  
  init: ->
    this.character.bind "update", this.render
    
  render: ->
    this.el.html Jaml.render("health", this.character)
    this.renderHealthGauge()
    dots = this.$(".surges .dots")
    for i in [1..this.character.surges.max]
      $("<div/>").addClass("dot").appendTo(dots).addClass("available")
    this
    
  update: ->
    this.renderHealthGauge()
    this.renderSurges()
    
  renderHealthGauge: ->
    hp = this.character.hp
    total = hp.total()
    max = Math.max total, hp.max
    this.$(".hp").removeClass("bloodied")
    this.$(".hp").addClass("bloodied") if hp.current < hp.max / 2
    this.$(".hp .values .current").text(total).toggleClass("has-temp-hp", hp.temp > 0)
    this.$(".hp .gauge .current").css({ width: "#{hp.current * 100 / max}%" }).text(hp.current)
    this.$(".hp .gauge .temp").css({ width: "#{total * 100 / max}%" }).text(hp.temp)
    
  renderSurges: ->
    this.$(".surges .dot").removeClass("available").slice(0, this.character.surges.current).addClass("available")
    this.$(".surges .current").text(this.character.surges.current)
    
  adjustHP: (event) ->
    event.preventDefault()
    button = $(event.target)
    amount = if button.hasClass("five") then 5 else 1
    if button.hasClass "plus"
      this.character.hp.add amount
    else if button.hasClass "temp"
      this.character.hp.addTemp amount
    else if button.hasClass "minus"
      this.character.hp.subtract amount
    this.update()
    false
    
  surge: (event) ->
    if this.character.hp.total() < this.character.hp.max
      this.character.surge()
      this.update()
      
  rest: (event) ->
    event.preventDefault()
    if $(event.target).hasClass("extended")
      this.character.extendedRest()
    else
      this.character.shortRest()
    this.update()
}

this.HealthController = HealthController
