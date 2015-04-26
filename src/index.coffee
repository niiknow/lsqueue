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
    return self
  persist: () ->
    self = @
    if !store.enabled
      return self

    try
      store.set(self.qn, self.items)
    catch
      # ignore localStorage error
    return self

  push: (v) ->
    self = @
    self.items.push(v)
    (debounce ->
      self.persist()
    , 111)()
    return self

  pop: () ->
    self = @
    if (self.items.length > 0)
      (debounce ->
        self.persist()
      , 111)()
      return self.items.shift()

    # return empty
    return
  clear: () ->
    self = @
    self.items = []
    (debounce ->
      self.persist()
    , 111)()
    return self

module.exports = lsqueue