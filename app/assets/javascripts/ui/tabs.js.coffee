TabsController = Spine.Controller.create {
  init: ->
    this.tabs = $("<div><ul/></div>").addClass("tabs").appendTo this.el

  kick: ->
    selected = window.location.hash
    selected = this.tabs.find("li a").first().attr("href") if !selected or (this.el.children(".#{selected.substring(1)}").length == 0)
    this.switchTo this.tabs.find("li.#{selected.substring(1)}-tab a").first()

  add: (id, label, controller, options) ->
    self = this
    options = $.extend { el: $("<div/>").addClass(id).addClass('tab-page').data("id", id).appendTo(this.el).hide() }, options || {}
    this[id] = controller.init(options).render()
    $("<a/>").text(label).attr("href", "#" + id).appendTo(this.$('.tabs ul')).wrap("<li class=\"#{id}-tab\" />").click (event) ->
      event.preventDefault()
      self.switchTo $(this)
      return false

  switchTo: (tab) ->
    tab.parent().addClass("active").siblings().removeClass("active")
    page = this.el.children(".#{tab.attr("href").substring(1)}").show().siblings(".tab-page").hide().end()
}

this.TabsController = TabsController