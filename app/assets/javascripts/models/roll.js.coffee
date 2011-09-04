Roll = Spine.Model.setup "Roll", [ "name", "description", "dice" ]
Roll.include {
  roll: ->
    dice = this.dice.split("+")
    total = 0
    for die in dice
      if (match = /(\d+)d(\d+)/.exec(die)) != null
        d = parseInt match[2], 10
        for i in [1..parseInt(match[1], 10)]
          total += Math.floor(Math.random() * d) + 1
      else
        total += parseInt die, 10
    total
}

this.Roll = Roll
