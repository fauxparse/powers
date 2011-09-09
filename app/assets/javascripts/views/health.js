Jaml.register("health", function(character) {
  div({ cls: "hp" },
    a({ cls: "minus five", href: "#" }, "-5"),
    a({ cls: "minus one", href: "#" }, "-1"),
    a({ cls: "temp one", href: "#" }, "+1"),
    a({ cls: "temp five", href: "#" }, "+5"),
    a({ cls: "plus one", href: "#" }, "+1"),
    a({ cls: "plus five", href: "#" }, "+5"),
    div({ cls: "gauge" },
      span({ cls: "current bar" }, character.hp.current.toString()),
      span({ cls: "temp bar" }, character.hp.temp.toString())
    ),
    div({ cls: "values" },
      span({ cls: "current"}, character.hp.total().toString()),
      span("/"),
      span({ cls: "max"}, character.hp.max.toString())
    )
  ),
  div({ cls: "surges" },
    div({ cls: "values" },
      span({ cls: "current"}, character.surges.current.toString()),
      span("×"),
      span({ cls: "value"}, character.surges.value.toString())
    ),
    a({ cls: "use", href: "#" }, "+"),
    div({ cls: "dots" }, "")
  ),
  div({ cls: "rests" },
    a({ cls: "short rest", href: "#" }, "Short rest"),
    a({ cls: "extended rest", href: "#" }, "Extended rest")
  )
});

