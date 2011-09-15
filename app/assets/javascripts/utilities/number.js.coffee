Number::modifier = ->
  Math.floor((this.valueOf() - 10) / 2)

Number::toSignedString = ->
  "#{if this.valueOf() >= 0 then "+" else ""}#{this.toString()}"