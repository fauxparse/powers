Jaml.register("power", function(power) {
  div({ cls: "front" },
    div({ cls: "header" },
      h3(power.name),
      div({ cls: "type" }, power.type()),
      div({ cls: "action" }, power.action())
    ),
    div({ cls: "body" },
      p({ cls: "range" }, (power.range || '').replace(/^([^\s]+)/, "<strong>$1</strong>")),
      // p({ cls: "description" }, power.description),
      ul({ cls: "rolls" }),
      Jaml.render("effect", power.effects)
    ),
    ol({ cls: "uses" })
  ),
  div({ cls: "back" },
    div({ cls: "header" },
      h3(power.name),
      div({ cls: "type" }, power.type()),
      div({ cls: "action" }, power.action())
    ),
    a({ rel: "reset", href: "#" }, "Reset")
  )
});

