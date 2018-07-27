local M = {}

function M.init_users()
  box.schema.user.grant('guest', 'read,write,execute', 'universe')
  box.schema.user.grant('storage', 'read,write,execute', 'universe')
  box.schema.user.passwd('storage', 'storage')
end

function M.init_first_space()
  local space = box.schema.create_space('first_space')

  local format = {}
  table.insert(format, {name = 'bucket_id', type = 'unsigned'})

  table.insert(format, {name = 'id', type = 'number'})
  table.insert(format, {name = 'name', type = 'string'})
  space:format(format)

  space:create_index('primary', {parts = {2, 'number'}})
  space:create_index('bucket_id', {parts = {1, 'unsigned'}, unique = false})
end

function M.init_second_space()
  local space = box.schema.create_space('second_space')

  local format = {}
  table.insert(format, {name = 'bucket_id', type = 'unsigned'})

  table.insert(format, {name = 'id', type = 'number'})
  table.insert(format, {name = 'name', type = 'string'})
  space:format(format)

  space:create_index('id_and_name', {parts = {2, 'number', 3, 'string'}})
  space:create_index('primary', {parts = {2, 'number'}})
  space:create_index('bucket_id', {parts = {1, 'unsigned'}, unique = false})
end


function M.bootstrap()
  box.once('init_users', M.init_users)
  box.once('init_first_space', M.init_first_space)
  box.once('init_second_space', M.init_second_space)
end

return M