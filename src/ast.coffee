'use strict'

_ = require 'underscore'

class Path
  constructor: (next = null) ->
    @next = next

class Root extends Path
  constructor: (next) ->
    super(next)

  path: () =>
    @next.path().substring(1)

  get: (data) =>
    @next.get(data)

  set: (data, value) =>
    @next.set(data, value)

class Field extends Path
  constructor: (next, name) ->
    super(next)
    @name = name

  path: () =>
    ".#{@name}#{@next.path()}"

  get: (data) =>
    @next.get(data[@name])

  set: (data, value) =>
    ans = _.clone(data)
    ans[@name] = @next.set(ans[@name], value)
    ans

class Nil extends Path
  constructor: () ->
    super(null)

  path: () =>
    ""

  get: (data) =>
    data

  set: (data, value) =>
    value

module.exports = { Path, Root, Field, nil: new Nil() }