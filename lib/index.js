// Generated by CoffeeScript 1.9.2
var debounce, lsqueue, store;

require('json-fallback');

debounce = require('debounce');

store = require('store.js');


/**
 * a queue backed by localStorage
 * new queue("name")
 */

lsqueue = (function() {
  function lsqueue(name) {
    var self;
    self = this;
    self.qn = name || "queue";
    self.items = [];
    self.persist = debounce(function() {
      if (!store.enabled) {
        return self;
      }
      try {
        store.set(self.qn, self.items);
      } catch (_error) {

      }
      return self;
    }, 111);
    return self;
  }

  lsqueue.prototype.push = function(v) {
    var self;
    self = this;
    self.items.push(v);
    self.persist();
    return self;
  };

  lsqueue.prototype.pop = function() {
    var rst, self;
    self = this;
    if (self.items.length > 0) {
      rst = self.items.shift();
      self.persist();
      return rst;
    }
  };

  lsqueue.prototype.clear = function() {
    var self;
    self = this;
    self.items = [];
    self.persist();
    return self;
  };

  return lsqueue;

})();

module.exports = lsqueue;
