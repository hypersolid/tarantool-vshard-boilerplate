local box = require('box')
local clock = require('clock')

local module = {}
local NAME = ''
    --
    -- CREATE TABLE (id, acount_id)
function module.init(name)
    local tokens = box.schema.space.create('tokens', {if_not_exists=true})
    NAME = name
    tokens:format({
        {'user_id', 'unsigned'},
        {'bucket_id', 'unsigned'},
        {'timestamp', 'unsigned'},
        {'count', 'unsigned'},
    })
    tokens:create_index('user_id', {parts = {'user_id'}, type='TREE', if_not_exists=true})
    tokens:create_index('bucket_id', {parts = {'bucket_id'}, unique = false , if_not_exists=true})
end

function module.use_token(bucket_id, user_id)
    -- create if not exists
    local tokens = box.space.tokens
    local token = tokens:get{ user_id }
    if token == nil then
        tokens:insert({user_id, bucket_id, clock.time64(), 1})
    else
        if token[3] >= 3 then
            return 'token is used'
        end

        token = tokens:update(user_id, {{'=', 2, clock.time64() }, {'+', 3, 1}})
    end

    return 'token is ok'
end

function module.get(user_id)
    return box.space.tokens:get{ user_id }
end

function module.get_all()
    -- select all
    return box.space.tokens:select({}, { limit=100 })
end

return module