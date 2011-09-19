PowersController = Spine.Controller.create {
  proxied: [ "addOne", "render", "arrangeCards", "touchStart", "touchMove", "touchEnd", "mouseDown", "mouseMove", "mouseUp" ]

  events: {
    "touchstart": "touchStart"
    "touchmove":  "touchMove"
    "touchend":   "touchEnd"
  }

  init: ->
    this.nPowers = 0
    this.addOne(power) for power in this.powers
    this.translate = 0
    this.arrangeCards 0
    unless $.os.ios
      this.el.bind "mousedown", this.mouseDown
      this.el.bind "mousemove", this.mouseMove
      this.el.bind "mouseup",   this.mouseUp

  render: ->
    this

  addOne: (power) ->
    (this.powerControllers or= {})[power.id] or= PowerController.init {
      index:     index = this.nPowers++
      el:        $("<div/>").addClass("power").appendTo(this.el)
      power:     power
      character: this.character
    }
    this.powerControllers[power.id].render()

  arrangeCards: (index) ->
    this.index = index if index?
    n = this.powers.length
    for i in [-1..(n - 2)]
      p = (i + n - this.index) % n
      while p < 0
        p += n
      power = this.powers[p]
      this.powerControllers[power.id].el.css { "-webkit-transform": "translateX(#{(i - this.translate) * 100}%)" }

  touchStart: (event) ->
    this.dragStart = event.touches[0].pageX
    this.displacement = 0

  touchMove: (event) ->
    width = this.el.width()
    this.displacement = (event.touches[0].pageX - this.dragStart) * 1.0 / width
    this.el.css { "-webkit-transform": "translateX(#{(this.translate + this.displacement) * 100}%)" }

  touchEnd: (event) ->
    d = if this.displacement < -0.1 then -1 else if this.displacement > 0.1 then 1 else 0
    this.el.anim { translateX: "#{(this.translate + d) * 100}%" }, 0.5, "ease-out", =>
      this.translate += d
      this.arrangeCards(this.index + d)
    this.dragStart = false

  mouseDown: (event) ->
    this.touchStart { touches: [ { pageX: event.x } ] }

  mouseMove: (event) ->
    if this.dragStart
      this.touchMove { touches: [ { pageX: event.x } ] }

  mouseUp: (event) ->
    this.touchEnd()
}

PowerController = Spine.Controller.create {
  proxied: [ "render", "remove", "use", "reset", "resetClicked" ]

  events: {
    "click .uses *": "use"
    "click [rel=reset]": "resetClicked"
  }

  init: ->
    this.power.bind "update", this.render
    this.power.bind "reset", this.reset

  render: (power) ->
    this.power = power if power?
    this.el.addClass this.power.type().toLowerCase()
    this.el.html Jaml.render("power", this.power)
    this.rolls = {}
    for roll in this.power.rolls
      this.rolls[roll.id] = (RollController.init {
        roll: roll
        el: $("<li/>").appendTo(this.$(".rolls"))
      }).render()
    for i in [1..this.power.uses.max]
      $("<li/>").appendTo(this.$(".uses")).toggleClass("used", this.power.uses.current < i)
    this.el.toggleClass "used", this.power.used()
    this

  remove: ->
    this.el.remove()

  use: (event) ->
    event.preventDefault()
    $(event.target).toggleClass("used")
    this.power.use()
    this.el.toggleClass "used", this.power.used()
    this.character.scheduleSave()
    false

  resetClicked: (event) ->
    event.preventDefault()
    this.power.reset()
    this.character.scheduleSave()
    false

  reset: ->
    this.el.removeClass("used").find(".uses *").removeClass("used").end()

}

this.PowersController = PowersController