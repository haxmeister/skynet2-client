--[[
Skynet2
Version 2.0

Author:   haxmeister (Joshua S. Day)
Purpose:  A universally useable plugin for guilds
Required: This plugin must connect to the associated server software.

License:  free for use/copy/modification/and redistribution
          with latest MIT license 2022 https://mit-license.org/
Addendum: nerd cred required, please mention the name of the authors
          who's code you have modified if you make your own mod
]]
dofile("TCP/tcpsock.lua")

Skynet2.coms = Skynet2.coms or {
    ['isconnected']      = false,
    ['isloggedin']       = false,
    ['reconnect_timer']  = Timer(),
    ['connect_attempts'] = 0
}

-- callback function for when a message is received
function Skynet2.coms.onMessage( sock, msg )
    local data = json.decode(msg)
    local action = data.action
    if (Skynet2.server_messages[action]) then
        Skynet2.server_messages[action](data)
    else
        Skynet2.printerror("Recieved bad message from server")
    end
end

-- callback function for when the connection has been made
function Skynet2.coms.onConnect( sock, errmsg )
    local connOk = false
    if (sock) then
        if (sock.tcp:GetPeerName()~=nil) then -- We are connected
            Skynet2.coms.socket = sock
            --Skynet2.coms.send   = sock.Send
            connOk = true
        else
            connOk = false
        end
    end

    if (connOk) then -- We are connected OK
        Skynet2.coms.isconnected = true
        Skynet2.coms.isloggedin = false
        Skynet2.coms.connect_attempts = 0
        Skynet2.print("Connected to server ok.")
        Skynet2.coms.login()
    else
        Skynet2.coms.isconnected = false
        Skynet2.coms.isloggedin = false

        if Skynet2.coms.connect_attempts == 0 then
            if (errmsg) then
                Skynet2.printerror("Error connecting to server: " .. errmsg)
                return
            else
                Skynet2.printerror("Error connecting to server.")
                return
            end
        end
        Skynet2.printerror("failed to connect")
    end
end

-- when disconnected
function Skynet2.coms.onDisconnect( sock )
    Skynet2.coms.isconnected = false
    Skynet2.coms.isloggedin = false

    local function reconnect_cb()
        Skynet2.coms.connect_attempts = Skynet2.coms.connect_attempts + 1
        Skynet2.coms.connect()
    end

    local timeout = (Skynet2.coms.connect_attempts < 5) and 5 or 60
    Skynet2.coms.reconnect_timer:SetTimeout(timeout * 1000, reconnect_cb)

    Skynet2.printerror("Disconnected from server. Reconnecting in "..tostring(timeout).."s.")
end


-- encode to json and send the message with proper line ending
function Skynet2.coms.send(data)
    if (data == nil) then return end
    if (Skynet2.coms.isconnected) then
        Skynet2.coms.socket.tcp:Send(json.encode(data) .. "\r\n")
    end
end

-- disconnect from skynet
function Skynet2.coms.disconnect()
    Skynet2.coms.reconnect_timer:Kill()
    Skynet2.coms.connect_attempts = 0

    if (Skynet2.coms.isloggedin) then
        Skynet2.coms.logout()
    end
    Skynet2.coms.isconnected = false
    Skynet2.coms.isloggedin = false

    if Skynet2.coms.socket then
        Skynet2.coms.socket.tcp:Disconnect()
        Skynet2.coms.socket = nil
    end

    Skynet2.printerror("Disconnected from the server");
end

function Skynet2.coms.connect()
    console_print("coms.connect called")
    Skynet2.coms.reconnect_timer:Kill()

    if (Skynet2.coms.isconnected) then
        Skynet2.coms.socket.tcp:Disconnect()
    end

    if Skynet2.coms.connect_attempts == 0 then
        Skynet2.print("Trying to connect to server...")
    end

    Skynet2.coms.socket = TCP.make_client(
        Skynet2.Server.host,
        Skynet2.Server.port,
        Skynet2.coms.onConnect,
        Skynet2.coms.onMessage,
        Skynet2.coms.onDisconnect
    )

end


-- base outgoing communication structure
local com = com or {}
com.new = function (arg)
    local object  = {}

    object.action = arg
    object.sender = {}
    object.sender.charname = GetPlayerName()
    object.sender.faction = GetPlayerFaction()
    object.sender.factioncolor = rgbtohex( FactionColor_RGB[ object.sender.faction ] )
    object.sender.guildabbr = GetGuildTag() or ""
    object.sender.guildname = GetGuildName() or ""
    object.sender.charid = GetCharacterID()
    object.sender.sectorid = GetCurrentSectorid()
    object.sender.sectorabbr = ShortLocationStr(tonumber (GetCurrentSectorid()) )
    object.sender.sectorfactioncolor = rgbtohex( FactionColor_RGB[tonumber(GetSectorAlignment())] )
    return object
end

-- login message
function Skynet2.coms.login()
    local msg_ref = com.new('login')
    msg_ref.username = 'joshua'--Skynet2.settings.username or ''
    msg_ref.password = 'mypass'--Skynet2.settings.password or ''
    Skynet2.coms.send(msg_ref)
end

-- player seen message
function Skynet2.coms.playerseen(playerlist)
    local msg_ref = com.new('playerseen')
    msg_ref.playerlist = playerlist
    Skynet2.coms.send(msg_ref)
end

-- chat channel message
function Skynet2.coms.chat(msg)
    local msg_ref = com.new('chat')
    msg_ref.message = msg
    Skynet2.coms.send(msg_ref)
end


RegisterEvent(Skynet2.coms.disconnect, "UNLOAD_INTERFACE")
RegisterEvent(Skynet2.coms.disconnect, "PLAYER_LOGGED_OUT")
