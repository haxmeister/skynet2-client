--[[
Author:  Joshua S. Day (haxmeister)
Purpose: Provides an Object that represents a player in the game
         loads most relevant information when instantiated
]]--

local Player = Player or {}

-- accepts a player ID and returns a table that is a player object
function Player.new(id)
    assert(type(id) == 'number', "player object expects a number but received "..type(id))
    local object = {
        ['id']          = id,
        ['name']         = GetPlayerName(id),
        ['health']       = GetPlayerHealth(id),
        ['ship']         = GetPrimaryShipNameOfPlayer(id) or 'Station',
        ['guild']        = GetGuildTag(id),
        ['faction']      = FactionName[GetPlayerFaction(id)] or '',
        ['factionID']    = GetPlayerFaction(id),
        ['sectorID']     = GetCurrentSectorid(),
        ['factionColor'] = rgbtohex(FactionColor_RGB[tonumber(GetPlayerFaction(id))]) or '127FFFFFF',
        ['locAbrev']     = '',
        ['system']       = ''
    }

    object['system']   = GetSystemID(object.sectorID)
    object['locAbrev'] = AbbrLocationStr(object.sectorID)
    return object
end

return Player
