--[[
Author:  Joshua S. Day (haxmeister)
Purpose: These functions are triggered when a message is received from the
         server with the same title, this happens in coms.lua in the
         onmessage event function
]]--

Skynet2.server_messages = Skynet2.server_messages or {}

local msg = Skynet2.server_messages

function msg.playerseen (data)
    if data == nil then return end
    ProcessEvent('SKYNET2_PLAYERSEEN_UPDATE', data)
end

function msg.chat (data)
    ProcessEvent('SKYNET2_CHAT_RECEIVED', data)
end
