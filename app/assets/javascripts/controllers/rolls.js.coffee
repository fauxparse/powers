RollController = Spine.Controller.create {
  proxied: [ "render", "remove", "click" ]

  events: {
    "tap a": "click"
  }

  init: ->
    this.roll.bind "update", this.render
    this.roll.bind "remove", this.remove

  render: (roll) ->
    this.roll = roll if roll?
    this.el.html Jaml.render("roll", this.roll)
    unless $.os.ios
      this.$("a").click this.click
    this

  remove: ->
    this.el.remove()

  click: (event) ->
    event.preventDefault()
    event.stopPropagation()
    result = this.roll.roll()
    overlay = $("<div/>").addClass("overlay").html(Jaml.render("result", this.roll)).appendTo("#container")
    overlay.find(".roll").text result
    overlay.find(".result").toggleClass("critical", result == this.roll.critical()).toggleClass("fumble", result == this.roll.fumble())
    overlay.one((if $.os.ios then "tap" else "click"), (event) =>
      $(".result", overlay).anim { scale: "100", opacity: 0 }, 0.5, "ease", => overlay.remove()
    )
}

this.RollController = RollController