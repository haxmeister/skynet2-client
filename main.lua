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

Skynet2 = Skynet2 or {
    SettingsId = 81818181,
    Settings   = {},
    Server     = {
        idstring = "232323",
        host     = "0.0.0.0",
        port     = 8181
    },
}

-- Load necessary library files
dofile("support_funcs.lua")  -- functions to make programming easier
dofile("json.lua")           -- functions for converting to and from json
dofile("sounds.lua")         -- provides Skynet2.LoadSounds() and file loading for it
dofile("cli.lua")            -- command line commands
dofile("chat.lua")           -- functions related to private chat channel
dofile("coms.lua")           -- communication msg obect and structure
dofile("ui/load.lua")        -- ui elements
dofile("players/load.lua")   -- player objects and lists management
dofile("events.lua")    -- game event reactions
dofile("server_messages.lua")-- react to messages from the skynet server

function Skynet2.alliancetarget()
    if GetTargetInfo() ~= nil then
        local name, health, distance, factionid, guild, ship = GetTargetInfo()
        local ladata = ""
        if health ~= nil then
            ladata = 'Targeting: '..name ..', piloting '..Article(ship)..' with '.. math.floor(GetPlayerHealth(GetCharacterIDByName(name))) ..'% armor ' .. 'at ' .. round(distance, 0) .. 'm.'
        else ladata = 'Targeting: '..name.. ' at ' .. round(distance, 0) .. 'm.'
        end
        local datatable = {ladata}
        Skyne2.AllianceChannel("target",datatable)
    end
end

Skynet2.PlayerEnteredGame = function()
    Skynet2.print("Skynet loaded...")
    Skynet2.LoadSettings()

    -- wait ten seconds before trying to send login credentials
    --local timer1 = Timer()
    --Skynet2.coms.login()


end

RegisterEvent(Skynet2.PlayerEnteredGame, "PLAYER_ENTERED_GAME")

-- create a command to send data about target to alliance chat
RegisterUserCommand('alliancetarget', Skynet2.alliancetarget)



