
'use strict'

_ = require 'underscore'
ast = require 'ast'
parser = require 'parser'

smallData = a: b: c: 123
bigData =
  a0: 1
  a:
    b0: 2
    b:
      c0: 3
      c: 123
      c2: 4
    b2: 5
  a2: 6

describe 'Field', ->
  describe 'Field.path', ->
    it 'must work on a.b.c', ->
      expect(parser.parse("a.b.c").path()).
        toEqual("a.b.c")

  describe 'Field.get', ->
    it 'must work on smallData', ->
      expect(parser.parse("a.b.c").get(smallData)).
        toEqual(123)

    it 'must work on bigData', ->
      expect(parser.parse("a.b.c").get(bigData)).
        toEqual(123)

  describe 'Field.set', ->
    it 'must leave original value unmodified', ->
      parser.parse("a.b.c").set(smallData, 234)
      expect(smallData).
        toEqual(a: b: c: 123)

    it 'must work on smallData', ->
      expect(parser.parse("a.b.c").set(smallData, 234)).
        toEqual(a: b: c: 234)

    it 'must work on bigData', ->
      modifiedBigData =
        a0: 1
        a:
          b0: 2
          b:
            c0: 3
            c: 234
            c2: 4
          b2: 5
        a2: 6
      expect(parser.parse("a.b.c").set(_.clone(bigData), 234)).
        toEqual(modifiedBigData)
