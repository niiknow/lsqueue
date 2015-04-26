queue = require('../src/index.coffee')
assert = require('component-assert')
store = require('store.js')
initTime = (new Date).getTime()

describe 'when push', ->
  it 'queue should persist to localStorage', (done)->
    q = new queue("myqueue")
    q.push("hi")
    setTimeout ->
      myData = store.get('myqueue')
      assert myData[0] is 'hi', 'queue data not found in localStorage'
      q.pop()
      done()
    , 300