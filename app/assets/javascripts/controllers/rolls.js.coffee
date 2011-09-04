RollController = Spine.Controller.create {
  proxied: [ "render", "remove", "click" ]
  
  events: {
    "tap a": "click"
  }
  
  init: ->
    this.roll.bind "update", this.render
    this.roll.bind "remove", this.remove
    unless $.os.ios
      this.$("a").click this.click
    
  render: (roll) ->
    this.roll = roll if roll?
    this.el.html Jaml.render("roll", this.roll)
    this
    
  remove: ->
    this.el.remove()
    
  click: (event) ->
    event.preventDefault()
    event.stopPropagation()
    result = this.roll.roll()
    overlay = $(Jaml.render("result", this.roll)).appendTo(this.el.closest("#container")).first()
    overlay.find(".result").text result
    overlay.one "click", (event) =>
      overlay.anim { scale: "100", opacity: 0 }, 0.5, "ease", => overlay.remove()
      
}

this.RollController = RollController