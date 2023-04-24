--[[
Author:  Joshua S. Day (haxmeister)
Purpose: A place to capture game events and how we will interact with
         each of them
]]--


Skynet2.events = {}

function Skynet2.events:UNLOAD_INTERFACE(event, data)
    Skynet2.coms.disconnect()
end

function Skynet2.events:PLAYER_LOGGED_OUT(event, data)
    Skynet2.coms.disconnect()
end

function Skynet2.events:PLAYER_ENTERED_GAME(event, data)
    Skynet2.LoadSettings()
    Skynet2.coms.connect()
    Skynet2.playerlist:report()
end

function Skynet2.events:PLAYER_ENTERED_SECTOR(event, id)
    Skynet2.playerlist:report()
end

function Skynet2.events:SECTOR_CHANGED(event, sectorID)
    print("sector changed event")
    Skynet2.playerlist:report()
end

function Skynet2.events:TARGET_CHANGED(event,data)
    local playerID = RequestTargetStats()
    -- skip non-characters
    if playerID == 0 then return end
    -- skip ourselves
    if (playerID == GetCharacterID()) then return end
    -- skip NPCs
    local name = GetPlayerName(playerID)
    if name:sub(1,1) == "*" then return end

    -- craft and send the message
    --local player = ONE.Assets.Player.New(playerID)
    --local msg = ONE.Coms.StatusReq(player)
    --ONE.ConManager.SendData (msg)
end

function Skynet2.events:SKYNET2_PLAYERSEEN_UPDATE(event, data)
    Skynet2.print("playerseen update event")
    Skynet2.playerlist:update(data)
end

function Skynet2.events:SKYNET2_CHAT_RECEIVED(event,data)
    if data.message ~= nil then
        print("\12737c8ab("..data.skynet_guild..") "..data.sender.sectorfactioncolor.."["..data.sender.sectorabbr.."] "..data.sender.factioncolor..data.sender.charname.."\12737c8ab " .. data.message)
    end
end

function Skynet2.events:SKYNET2_ROIDLIST_RECEIVED(event, data)
    Skynet2.print("roidlist recieved")
end


RegisterEvent(Skynet2.events, 'SKYNET2_PLAYERSEEN_UPDATE')
RegisterEvent(Skynet2.events, 'SKYNET2_CHAT_RECEIVED')
RegisterEvent(Skynet2.events, 'SKYNET2_ROIDLIST_RECEIVED')
RegisterEvent(Skynet2.events, 'TARGET_CHANGED')
RegisterEvent(Skynet2.events, "PLAYER_ENTERED_GAME")
RegisterEvent(Skynet2.events, "UNLOAD_INTERFACE")
RegisterEvent(Skynet2.events, "PLAYER_LOGGED_OUT")
RegisterEvent(Skynet2.events, "SECTOR_CHANGED")
RegisterEvent(Skynet2.events, "PLAYER_ENTERED_SECTOR")
