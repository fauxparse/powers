Jaml.register("result", function(roll) {
  div({ cls: "result" },
    div({ cls: "roll" }, ""),
    div({ cls: "explanation" }, roll.dice)
  );
});

