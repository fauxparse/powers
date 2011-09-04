$.proxy = (fn, context) ->
  ->
    fn.apply context, Array.prototype.slice.call(arguments)
