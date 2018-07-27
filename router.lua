local cfg = require('vshard_config')
local os = require('os')

vshard = require('vshard') -- must be required globally

local name = 'router'

-- create data dir
local data_dir = string.format('data/%s', name)
os.execute(string.format('mkdir -p %s', data_dir))

cfg.listen = 33000
cfg.wal_dir = data_dir
cfg.memtx_dir = data_dir

vshard.router.cfg(cfg)
vshard.router.bootstrap()

box.once('init', function()
  box.schema.user.grant('guest', 'read,write,execute', 'universe')
end)

-- call function on replicaset master
function call(key, function_name, ...)
  local bucket_id = vshard.router.bucket_id(key)
  return vshard.router.callrw(
    bucket_id,
    function_name,
    {bucket_id, ...},
    {}
  )
end

-- call read_only function on any replicaset member
function callro(key, function_name, ...)
  local bucket_id = vshard.router.bucket_id(key)
  return vshard.router.callro(
    bucket_id,
    function_name,
    {bucket_id, ...},
    {}
  )
end
