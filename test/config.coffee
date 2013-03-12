
'use strict'

_ = require 'underscore'
Config = require 'config'

baseConfig = ->
  new Config
    a0: 1
    a:
      b0: 2
      b:
        c0: 3
        c: 123
        c2: 4
      b2: 5
    a2: 6

describe 'Config', ->
  describe 'Config.get', ->
    it 'must work', ->
      expect(baseConfig().get('a.b.c')).toEqual(123)
      expect(baseConfig().get('a.b.c0')).toEqual(3)
      expect(baseConfig().get('a.b')).toEqual(
        c0: 3
        c: 123
        c2: 4
      )
      expect(baseConfig().get('a.b0')).toEqual(2)
      expect(baseConfig().get('a')).toEqual(
        b0: 2
        b:
          c0: 3
          c: 123
          c2: 4
        b2: 5
      )
      expect(baseConfig().get('a0')).toEqual(1)

  describe 'Config.set', ->
    it 'must work', ->
      expect(baseConfig().set('a.b.c', 234).data).toEqual(
        a0: 1
        a:
          b0: 2
          b:
            c0: 3
            c: 234
            c2: 4
          b2: 5
        a2: 6
      )
      expect(baseConfig().set('a.b', 234).data).toEqual(
        a0: 1
        a:
          b0: 2
          b: 234
          b2: 5
        a2: 6
      )
      expect(baseConfig().set('a', 234).data).toEqual(
        a0: 1
        a: 234
        a2: 6
      )
