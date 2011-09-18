HealthController = Spine.Controller.create {
  proxied: [ "render", "adjustHP", "surge", "rest", "update", "action_point" ]

  events: {
    "click .hp a": "adjustHP"
    "click .surges a": "surge"
    "click .rest": "rest",
    "click .action-points a": "action_point"
  }

  init: ->
    this.character.bind "update", this.update

  render: ->
    this.el.html Jaml.render("health", this.character)
    this.renderHealthGauge()
    dots = this.$(".surges .dots")
    for i in [1..this.character.surges.max]
      $("<div/>").addClass("dot").appendTo(dots)
    this.update()

  update: ->
    this.renderHealthGauge()
    this.renderSurges()
    this.$(".action-points .current").text this.character.action_points
    this

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
      this.character.heal amount
    else if button.hasClass "temp"
      this.character.tempHP amount
    else if button.hasClass "minus"
      this.character.damage amount
    this.update()
    false

  surge: (event) ->
    if this.character.hp.total() < this.character.hp.max
      this.character.surge()
      this.update()
    false

  rest: (event) ->
    event.preventDefault()
    if $(event.target).hasClass("extended")
      this.character.extendedRest()
    else
      this.character.shortRest()
    this.update()
    false

  action_point: (event) ->
    event.preventDefault()
    if $(event.target).hasClass("minus")
      this.character.useActionPoint()
    else
      this.character.gainActionPoint()
    this.update()
    false
}

this.HealthController = HealthController
