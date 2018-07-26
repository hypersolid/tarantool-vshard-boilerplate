local box = require('box')
vshard = require('vshard')
local data_api = require('data-api')

local cfg = require('vshard-config')
local os = require ('os')
local name = 'storage_1_a'

os.execute(string.format('mkdir -p %s', name))

cfg.listen = 33001
cfg.wal_dir = name
cfg.memtx_dir = name

vshard.storage.cfg(cfg, '8a274925-a26d-47fc-9e1b-af88ce939412')

box.once('init', function()
    box.schema.user.grant('guest', 'read,write,execute', 'universe')
    box.schema.user.grant('storage', 'read,write,execute', 'universe')
    box.schema.user.passwd('storage', 'storage')
end)

data_api.init(name)

-- declaration of module with stored procedures
-- api.my_api.say_hello2
rawset(_G, 'api', {
    data_api = data_api
})