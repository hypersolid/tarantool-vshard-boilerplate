local box = require('box')
vshard = require('vshard')
local data_api = require('data-api')

local cfg = require('vshard-config')
local os = require ('os')
local name = 'router'

os.execute(string.format('mkdir -p %s', name))

cfg.listen = 3001
cfg.wal_dir = name
cfg.memtx_dir = name

vshard.router.cfg(cfg)
vshard.router.bootstrap()

box.once('init', function()
    box.schema.user.grant('guest', 'read,write,execute', 'universe')
end)

function use_token(user_id, ...)
    local bucket_id = vshard.router.bucket_id(user_id)
    
    -- call function on storage
    return vshard.router.callrw(bucket_id, 'api.data_api.use_token', { bucket_id, user_id, ...}, {})
end

function get(key)
    user_id = tonumber(key)
    local bucket_id = vshard.router.bucket_id(user_id)
    
    -- call function on storage
    return vshard.router.callrw(bucket_id, 'api.data_api.get', { user_id}, {})
end

function get_all()
    local data = {}
    for uuid, replicaset in pairs(vshard.router.routeall()) do
        local res = replicaset:callrw('api.data_api.get_all', nil)
        if res == nil then
            return "res i nil!"
        end

        for i, entry in ipairs(res) do
            if entry ~= nil then
                table.insert(data, {uid = uuid, entry = entry})
            end
        end
    end

    return data
end


