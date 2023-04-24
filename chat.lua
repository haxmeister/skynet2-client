--[[
Skynet2
Version 2.0

Author:   haxmeister (Joshua S. Day)
Purpose:  A universally useable plugin for guilds
Required: This plugin must connect to the associated server software.

License:  free for use/copy/modification/and redistribution
          with latest MIT license 2022 https://mit-license.org/
]]

function Skynet2.AllianceChannel(_, data)
    if data ~= nil then
        local message = table.concat(data, " ") or ""
        Skynet2.coms.chat(message)
    end
end

-- to make alliance chat channel provide a prompt via hotkey that appears
-- like it is part of the game's regular chat service
-- first we create a command, the name of which will unfortunately contain
-- the color number of the prompt.. it's dumb but that's what they provided
RegisterUserCommand("\12737c8abAlliance:", Skynet2.AllianceChannel)

-- next we create an alias to the "prompt" command
gkinterface.GKProcessCommand("alias alliancechat 'prompt \12737c8abAlliance: '") -- make an alias to bring up a prompt dialog of the CommandThing command

-- now we bind a key to the alias we created
gkinterface.GKProcessCommand("bind Y alliancechat") -- make an alias to bring up a prompt dialog of the CommandThing command
