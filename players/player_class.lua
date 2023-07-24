--[[
Author:  Joshua S. Day (haxmeister)
Purpose: Provides an Object that represents a player in the game
         loads most relevant information when instantiated
]]--

local Player = Player or {}

-- accepts a player ID and returns a table that is a player object
function Player.new(id)
    assert(type(id) == 'number', "player object expects a number but received "..type(id))
    local shipAbbr = {
        ['Corvus Marauder Mercenary'] = 'Cormaud',
        ['Ragnarok MkIII']            = 'Rag3',
        ['Ragnarok MkII']             = 'Rag2',
        ['Corvus Vulturis']           = 'Corvult',
        ['Corvus Greyhound']          = 'Hound',
        ['Warthog Mineral Extractor'] = 'HogME',
        ['Warthog MkIV']              = 'Hog4',
        ['Warthog MkIII']             = 'Hog3',
        ['Warthog MkII']              = 'Hog2',
        ['Revenant MkIII']            = 'Rev3',
        ['Revenant MkII']             = 'Rev2',
        ['TPG Raptor UDV']            = 'UDV',
        ['Centurion']                 = 'Cent',
        ['Centurion MkIII']           = 'Cent3',
        ['Centurion MkII']            = 'Cent2',
        ['Behemoth']                  = 'Moth',
        ['Behemoth XC']               = 'MothXC'

    }

    local object = {
        ['id']          = id,
        ['name']         = GetPlayerName(id),
        ['health']       = GetPlayerHealth(id),
        ['ship']         = GetPrimaryShipNameOfPlayer(id) or 'Station',
        ['shipAbbr']     = '',
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

    object['shipAbbr'] = shipAbbr[object['ship']] or object['ship']
    return object
end

return Player
