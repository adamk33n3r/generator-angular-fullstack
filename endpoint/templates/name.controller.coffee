'use strict'

_ = require('lodash')<% if (filters.mongoose) { %>
<%= classedName %> = require './<%= name %>.model'<% } %>

# Get list of <%= name %>s
exports.index = (req, res) -><% if (!filters.mongoose) { %>
  res.json([])<% } %><% if (filters.mongoose) { %>
  <%= classedName %>.find (err, <%= name %>s) ->
    if err
      return handleError(res, err)
    return res.status(200).json(<%= name %>s)
  <% } %>
<% if (filters.mongoose) { %>

# Get a single <%= name %>
exports.show = (req, res) ->
  <%= classedName %>.findById req.params.id, (err, <%= name %>) ->
    if err
      return handleError(res, err)
    if not <%= name %>
      return res.status(404).send('Not Found')
    return res.json(<%= name %>)

# Creates a new <%= name %> in the DB.
exports.create = (req, res) ->
  <%= classedName %>.create req.body, (err, <%= name %>) ->
    if err
      return handleError(res, err)
    return res.status(201).json(<%= name %>)

# Updates an existing <%= name %> in the DB.
exports.update = (req, res) ->
  if req.body._id
    delete req.body._id
  <%= classedName %>.findById req.params.id, (err, <%= name %>) ->
    if err
      return handleError(res, err)
    if not <%= name %>
      return res.status(404).send('Not Found')
    updated = _.merge <%= name %>, req.body
    updated.save (err) ->
      if err
        return handleError(res, err)
      return res.status(200).json(<%= name %>)

# Deletes a <%= name %> from the DB.
exports.destroy = (req, res) ->
  <%= classedName %>.findById req.params.id, (err, <%= name %>) ->
    if err
      return handleError(res, err)
    if not <%= name %>
      return res.status(404).send('Not Found')
    <%= name %>.remove (err) ->
      if err
        return handleError(res, err)
      return res.status(204).send('No Content')

handleError = (res, err) ->
  res.status(500).send(err)
<% } %>
