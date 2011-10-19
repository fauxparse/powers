Roll = Spine.Model.setup "Roll", [ "name", "description", "dice" ]
Roll.include {
  roll: ->
    total = 0
    for die in this.parts()
      if (match = /(\d+)d(\d+)/.exec(die)) != null
        d = parseInt match[2], 10
        for i in [1..parseInt(match[1], 10)]
          total += Math.floor(Math.random() * d) + 1
      else
        total += parseInt die, 10
    Math.floor(total * this.multiplier())

  parts: ->
    d = this.dice.split "/"
    d[0].split "+"

  multiplier: ->
    d = this.dice.split "/"
    if d.length > 1
      1.0 / parseInt(d[1], 10)
    else
      1

  critical: ->
    total = 0
    for die in this.parts()
      match = /(\d+)(d(\d+))?/.exec(die)
      total += parseInt(match[1], 10) * parseInt(match[3] || "1", 10)
    Math.floor(total * this.multiplier())

  fumble: ->
    total = 0
    for die in this.parts()
      match = /(\d+)(d(\d+))?/.exec(die)
      total += parseInt(match[1], 10)
    Math.floor(total * this.multiplier())
}

this.Roll = Roll
