local api = require('storage_api')
local cfg = require('vshard_config')
local os = require ('os')
local schema = require('storage_schema')

vshard = require('vshard') -- must be required globally

local name = 'storage_2_a'

-- create data dir
local data_dir = string.format('data/%s', name)
os.execute(string.format('mkdir -p %s', data_dir))

-- server settings
cfg.listen = 33002
cfg.wal_dir = data_dir
cfg.memtx_dir = data_dir
vshard.storage.cfg(cfg, '1e02ae8a-afc0-4e91-ba34-843a356b8ed7')

schema.bootstrap()

-- declaration of module with stored procedures
-- api.say_hello2
rawset(_G, 'api', api)
