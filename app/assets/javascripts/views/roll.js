Jaml.register("roll", function(roll) {
  a({ "data-dice": roll.dice, href: "#" },
    strong(roll.name + ":"), " " + roll.description
  )
});

