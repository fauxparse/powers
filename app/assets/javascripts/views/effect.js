Jaml.register("effect", function(effect) {
  p({ cls: "effect" },
    strong(effect.name + ":"), " " + effect.description.split("\n").join("</p><p class=\"effect\">")
  )
});

