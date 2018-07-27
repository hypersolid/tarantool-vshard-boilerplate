local api = require('storage_api')
local cfg = require('vshard_config')
local os = require ('os')
local schema = require('storage_schema')

vshard = require('vshard') -- must be required globally

local name = 'storage_1_a'

-- create data dir
local data_dir = string.format('data/%s', name)
os.execute(string.format('mkdir -p %s', data_dir))

-- server settings
cfg.listen = 33001
cfg.wal_dir = data_dir
cfg.memtx_dir = data_dir
vshard.storage.cfg(cfg, '8a274925-a26d-47fc-9e1b-af88ce939412')

schema.bootstrap()

-- declaration of module with stored procedures
-- api.say_hello2
rawset(_G, 'api', api)
