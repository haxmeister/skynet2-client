--[[
Author:  Joshua S. Day (haxmeister)
Purpose: A place to capture game events and how we will interact with
         each of them
]]--


Skynet2.events = {}
Skynet2.events.last_roid_id = 0
Skynet2.events.last_sector_id = 0

function Skynet2.events:UNLOAD_INTERFACE(event, data)
    Skynet2.coms.disconnect()
end

function Skynet2.events:PLAYER_LOGGED_OUT(event, data)
    Skynet2.coms.disconnect()
end

function Skynet2.events:PLAYER_ENTERED_GAME(event, data)
    Skynet2.LoadSettings()
    Skynet2.printHUD("Skynet loaded...")
    Skynet2.coms.connect()
    Skynet2.playerlist:report()
end

function Skynet2.events:PLAYER_ENTERED_SECTOR(event, id)
    Skynet2.playerlist:report()
end

function Skynet2.events:PLAYER_LEFT_SECTOR(event, id)
    Skynet2.playerlist:report()
end

function Skynet2.events:SECTOR_CHANGED(event, sectorID)
    --print("sector changed event")
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

function Skynet2.events:TARGET_SCANNED(event, data, nodeid, objectid)
    if (string.find(data, "Object too far"))then return end
    if (string.find(data, "Cargo"))then return end
    if (string.find(data, "Temperature"))then
    --print("sending roid")
        -- lets keep track of the scan from the last event trigger
        -- so we don't continuously send scan data when mining and such
        local sectorid = GetCurrentSectorid()
        if (objectid == Skynet2.events.last_roid_id)then
            if (sectorid == Skynet2.events.last_sector_id)then
                return
            end
        end
        Skynet2.events.last_sector_id = sectorid
        Skynet2.events.last_roid_id = objectid
        --Skynet2.print("Roid scan success")
        local msg = {}
        msg.data = data
        msg.objectid = objectid
        Skynet2.coms.scan(msg)
    end
end

function Skynet2.events:SKYNET2_SKYNETMSG(event, data)
    --Skynet2.print("skynet message received")
    Skynet2.print(data.text)
end

function Skynet2.events:SKYNET2_SKYNETERRORMSG(event, data)
    Skynet2.printerror(data.text)
end

function Skynet2.events:SKYNET2_PLAYERSEEN_UPDATE(event, data)
    --Skynet2.print("playerseen update event")
    Skynet2.playerlist:update(data)
end

function Skynet2.events:SKYNET2_CHAT_RECEIVED(event,data)
    if data.text ~= nil then
        print("\12737c8ab("..data.channel..") "..data.sender.sectorfactioncolor.."<"..data.sender.sectorabbr..">[ "..data.sender.guildabbr.."]"..data.sender.factioncolor..data.sender.charname.."\12737c8ab " .. data.text)
    end
end

function Skynet2.events:SKYNET2_ROIDLIST_RECEIVED(event, data)
    Skynet2.print("roidlist recieved")
end

function Skynet2.events:SKYNET2_CHANNEL_CHANGE(event, data)
    Skynet2.Current_Channel = data.channel
    Skynet2.print("Changed channel to "..data.channel)
end

RegisterEvent(Skynet2.events, 'SKYNET2_PLAYERSEEN_UPDATE')
RegisterEvent(Skynet2.events, 'SKYNET2_CHAT_RECEIVED')
RegisterEvent(Skynet2.events, 'SKYNET2_ROIDLIST_RECEIVED')
RegisterEvent(Skynet2.events, 'SKYNET2_SKYNETMSG')
RegisterEvent(Skynet2.events, 'SKYNET2_SKYNETERRORMSG')
RegisterEvent(Skynet2.events, 'SKYNET2_CHANNEL_CHANGE')
RegisterEvent(Skynet2.events, 'TARGET_CHANGED')
RegisterEvent(Skynet2.events, "PLAYER_ENTERED_GAME")
RegisterEvent(Skynet2.events, "UNLOAD_INTERFACE")
RegisterEvent(Skynet2.events, "PLAYER_LOGGED_OUT")
RegisterEvent(Skynet2.events, "SECTOR_CHANGED")
RegisterEvent(Skynet2.events, "PLAYER_ENTERED_SECTOR")
RegisterEvent(Skynet2.events, "PLAYER_LEFT_SECTOR")
RegisterEvent(Skynet2.events, "TARGET_SCANNED")
