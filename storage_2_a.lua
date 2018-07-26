local box = require('box')
vshard = require('vshard')
local data_api = require('data-api')

local cfg = require('vshard-config')
local os = require ('os')
local name = 'storage_2_a'

os.execute(string.format('mkdir -p %s', name))

cfg.listen = 33002
cfg.wal_dir = name
cfg.memtx_dir = name

vshard.storage.cfg(cfg, '1e02ae8a-afc0-4e91-ba34-843a356b8ed7')

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


