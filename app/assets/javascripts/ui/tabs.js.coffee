TabsController = Spine.Controller.create {
  init: ->
    this.tabs = $("<div><ul/></div>").addClass("tabs").appendTo this.el
    
  kick: ->
    selected = window.location.hash
    selected = this.tabs.find("li a").first().attr("href") if !selected or (this.el.children(selected).length == 0)
    this.switchTo this.tabs.find("li.#{selected.substring(1)} a").first()
    
  add: (id, label, controller) ->
    self = this
    this[id] = controller.init({
      el: $("<div/>").attr("id", id).addClass('tab-page').appendTo(this.el).hide()
    }).render()
    $("<a/>").text(label).attr("href", "#" + id).appendTo(this.$('.tabs ul')).wrap("<li class=\"#{id}\" />").click (event) ->
      self.switchTo $(this)

  switchTo: (tab) ->
    tab.parent().addClass("active").siblings().removeClass("active")
    page = this.el.children(tab.attr("href")).show().siblings(".tab-page").hide().end();
    this[page.attr("id")].refresh()
}

this.Tabs = TabsController.init {
  el: $("#container")
}