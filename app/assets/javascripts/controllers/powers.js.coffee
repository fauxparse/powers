PowersController = Spine.Controller.create {
  proxied: [ "addOne", "render", "arrangeCards", "startDrag", "stopDrag", "drag", "next", "previous", "touchstart", "touchmove", "touchend", "noDrag" ]
  
  events: {
    "touchstart": "touchstart"
    "touchmove":  "touchmove"
    "touchend":   "touchend"
    "mousedown .powers .uses *": "noDrag"
    "mouseup .powers .uses *": "noDrag"
    "mousedown [rel=reset]": "noDrag"
    "mouseup [rel=reset]": "noDrag"
    "touchstart .powers .uses *": "noDrag"
    "touchend .powers .uses *": "noDrag"
    "touchstart [rel=reset]": "noDrag"
    "touchend [rel=reset]": "noDrag"
  }
  
  init: ->
    this.nPowers = 0
    this.addOne(power) for power in this.powers
    this.index = 0
    this.arrangeCards()
    unless $.os.ios
      this.el.bind "mousedown", this.startDrag
      this.el.bind "mousemove", this.drag
    
  render: ->
    $(window).mousemove this.drag
    this
  
  addOne: (power) ->
    (this.powerControllers or= {})[power.id] or= PowerController.init {
      index: index = this.nPowers++
      el:    $("<div/>").addClass("power").appendTo(this.el)
      power: power
    }
    this.powerControllers[power.id].render()
    
  arrangeCards: (index) ->
    this.index = index if index?
    this.$(".power").css { "-webkit-transform": "translateX(0)" }
    i = 0
    for power in this.powers
      card = this.powerControllers[power.id].el
      card.css { left: ((i - this.index + this.powers.length + 1) % this.powers.length - 1) * 100 + "%" }
      i++
      
  startDrag: (event) ->
    this.dragStart = event.x
    $(window).one("mouseup", (event) => this.stopDrag())
    
  stopDrag: (event) ->
    if this.dragStart
      width = this.el.width()
      if this.displacement < width / -4
        this.$(".power").anim { translateX: "-#{width}px" }, 0.5, "ease-out"
        setTimeout this.next, 550
      else if this.displacement > width / 4
        this.$(".power").anim { translateX: "#{width}px" }, 0.5, "ease-out"
        setTimeout this.previous, 550
      else
        this.$(".power").anim { translateX: "0px" }
    this.dragStart = false
    
  drag: (event) ->
    if this.dragStart
      this.displacement = event.x - this.dragStart
      this.$(".power").css { "-webkit-transform": "translateX(#{this.displacement}px)" }
      
  next: ->
    this.arrangeCards (this.index + 1) % this.powers.length

  previous: ->
    this.arrangeCards (this.index - 1) % this.powers.length

  touchstart: (event) ->
    this.startDrag { x: event.touches[0].pageX }

  touchmove: (event) ->
    this.drag { x: event.touches[0].pageX }

  touchend: (event) ->
    this.stopDrag {}

  noDrag: (event) ->
    event.stopPropagation()
    this.dragStart = false

}

PowerController = Spine.Controller.create {
  proxied: [ "render", "remove", "use", "reset" ]
  
  events: {
    "click .uses *": "use"
    "click [rel=reset]": "reset"
  }
  
  init: ->
    this.power.bind "update", this.render
    
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
    for i in [1..this.power.uses]
      $("<li/>").appendTo this.$(".uses")
    this
    
  remove: ->
    this.el.remove()
    
  use: (event) ->
    event.preventDefault()
    $(event.target).toggleClass("used")
    if this.$(".uses :not(.used)").length == 0
      this.el.addClass "used"
    false
  
  reset: (event) ->
    event.preventDefault()
    this.el.removeClass("used").find(".uses *").removeClass("used").end()
    false
    
}

this.PowersController = PowersController