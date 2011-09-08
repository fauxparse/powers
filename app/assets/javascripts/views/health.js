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
      span({ cls: "current"}, character.hp.value().toString()),
      span('/'),
      span({ cls: "max"}, character.hp.max.toString())
    )
  )
});

