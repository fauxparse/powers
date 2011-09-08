HealthController = Spine.Controller.create {
  proxied: [ "render", "click" ]
  
  events: {
    "click .hp a": "adjustHP"
  }
  
  init: ->
    this.character.bind "update", this.render
    
  render: ->
    this.el.html Jaml.render("health", this.character)
    this.renderHealthGauge()
    this
    
  renderHealthGauge: ->
    hp = this.character.hp
    total = hp.value()
    max = Math.max total, hp.max
    this.$(".hp").removeClass("bloodied")
    this.$(".hp").addClass("bloodied") if total < hp.max / 2
    this.$(".hp .values .current").text(total).toggleClass("has-temp-hp", hp.temp > 0)
    this.$(".hp .gauge .current").css({ width: "#{hp.current * 100 / max}%" }).text(hp.current)
    this.$(".hp .gauge .temp").css({ width: "#{total * 100 / max}%" }).text(hp.temp)
    
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
    this.renderHealthGauge()
    false
}

this.HealthController = HealthController
