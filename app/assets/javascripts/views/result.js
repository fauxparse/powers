Jaml.register("result", function(roll) {
  div({ cls: "overlay" },
    div({ cls: "result" }, ""),
    div({ cls: "explanation" }, roll.dice)
  );
});

