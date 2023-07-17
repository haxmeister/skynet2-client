--[[
Author:  Joshua S. Day (haxmeister)
Purpose: These functions are triggered when a message is received from the
         server with the same name in the action field,
         this dispatching happens in coms.lua in the onmessage event function
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

function msg.skynetmsg (data)
    ProcessEvent('SKYNET2_SKYNETMSG', data)
end

function msg.channel_change(data)
    ProcessEvent('SKYNET2_CHANNEL_CHANGE', data)
end

function msg.skyneterrormsg (data)
    ProcessEvent('SKYNET2_SKYNETERRORMSG', data)
end
