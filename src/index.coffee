require('json-fallback')
debounce = require('debounce')
store = require('store.js')

###*
 * a queue backed by localStorage
 * new queue("name")
###
class lsqueue
  constructor: (name) ->
    self = @
    self.qn = name or "queue"
    self.items = []
    self.persist = (debounce ->
      if !store.enabled
        return self

      try
        store.set(self.qn, self.items)
      catch
        # ignore localStorage error
      return self
    , 111)

    return self

  push: (v) ->
    self = @
    self.items.push(v)
    self.persist()
    return self

  pop: () ->
    self = @
    if (self.items.length > 0)
      rst = self.items.shift()
      self.persist()
      return rst

    # return empty
    return
  clear: () ->
    self = @
    self.items = []
    self.persist()
    return self

module.exports = lsqueue