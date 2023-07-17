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

function round(num, idp)
  local mult = 10^(idp or 0)
  return math.floor(num * mult + 0.5) / mult
end

Skynet2.SaveSettings = function()
    SaveSystemNotes(spickle(Skynet2.Settings), Skynet2.SettingsId)
end

Skynet2.LoadSettings = function()
    Skynet2.Settings = unspickle(LoadSystemNotes(Skynet2.SettingsId))
end

Skynet2.printerror = function(str)
    print("\127FF7E00Skynet\1270080FF | \127FF0001" .. str)
end

Skynet2.print = function(str)
    print("\127FF7E00Skynet\1270080FF | \127dddddd" .. str)
end

Skynet2.printHUD = function(str)
    pcall(function() HUD:PrintSecondaryMsg("\127FF7E00Skynet\1270080FF | \127dddddd" .. str) end)
end

Skynet2.printerrorHUD = function(str)
    pcall(function() HUD:PrintSecondaryMsg("\127FF7E00Skynet\1270080FF | \127FF0001" .. str) end)
end

