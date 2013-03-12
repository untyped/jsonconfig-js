'use strict'

parser = require 'parser'

module.exports = class Config

  constructor: (data) ->
    @data = data

  get: (path) =>
    parser.parse(path).get(@data)

  set: (path, value) =>
    @data = parser.parse(path).set(@data, value)
    this
