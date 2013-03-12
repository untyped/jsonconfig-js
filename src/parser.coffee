'use strict'

_ = require 'underscore'
ast = require 'ast'

exports.parse = (path) =>
  new ast.Root _.reduceRight path.split("."),
    (memo, name) => new ast.Field(memo, name)
    ast.nil
