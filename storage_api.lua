local M = {}

function M.say_hello()
  return 'hello from storage'
end

function M.echo(...)
  return {...}
end

function M.create_fruit(bucket_id, id, name)
  return box.space.first_space:insert({bucket_id, id, name})
end

function M.select_fruit(_, id)
  return box.space.first_space:get(id)
end

return M
