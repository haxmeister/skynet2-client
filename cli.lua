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

Skynet2.cli = Skynet2.cli or {}

Skynet2.cli.Dispatch = function(_, args)
    if (args~=nil) then
        if (Skynet2.cli[args[1]]) then
            Skynet2.cli[args[1]](args)
        else
            Skynet2.printerror("Invalid command "..args[1])
        end
    end
end

----done
Skynet2.cli["connect"] = function(args)
    Skynet2.coms.connect()
end

----done
Skynet2.cli["disconnect"] = function(args)
    Skynet2.coms.disconnect()
end

-- accepts username and password
Skynet2.cli["register"] = function(args)
    if args[2] and args[3] then
        Skynet2.coms.register(args[2], args[3])
    else
        Skynet2.printerror("missing arguments in register command")
    end
end

Skynet2.cli["invite"] = function(args)
    if args[2] then
        Skynet2.coms.invite(args[2])
    else
        Skynet2.printerror("missing arguments in invite command")
    end
end

Skynet2.cli["join"] = function(args)
    if args[2] then
        Skynet2.coms.join(args[2])
    else
        Skynet2.printerror("missing argument in join command")
    end
end

Skynet2.cli["login"] = function(args)
    if args[2] and args[3] then
        Skynet2.print(args[2].." : "..args[3])
        Skynet2.coms.login(args[2], args[3])
        Skynet2.Settings.username = args[2]
        Skynet2.Settings.password = args[3]
        Skynet2.SaveSettings()
    else
        Skynet2.printerror("missing arguments in login command")
    end
end

Skynet2.cli["newalliance"] = function(args)
        if args[2] then
        Skynet2.coms.newalliance(args[2])
    else
        Skynet2.printerror("missing argument in newalliance command")
    end
end

Skynet2.cli["invite"] = function(args)
        if args[2] then
        Skynet2.coms.invite(args[2])
    else
        Skynet2.printerror("missing player name to invite")
    end
end

Skynet2.cli["uninvite"] = function(args)
        if args[2] then
        Skynet2.coms.uninvite(args[2])
    else
        Skynet2.printerror("missing player name to uninvite")
    end
end

Skynet2.cli["join"] = function(args)
        if args[2] then
        Skynet2.coms.join(args[2])
    else
        Skynet2.printerror("missing alliance name to join")
    end
end

Skynet2.cli["promote"] = function(args)
        if args[2] then
        Skynet2.coms.promote(args[2])
    else
        Skynet2.printerror("missing player name to promote");
    end
end

Skynet2.cli["online"] = function(args)
        Skynet2.coms.online()
end

Skynet2.cli["help"] = function()
    print("\127ffff00connect\n\t\127eeffFFConnect to Skynet server")
    print("\127ffff00disconnect\n\t\127eeffFFDisconnect from Skynet server")
    print("\127ffff00register \12700ffFF<username> \12700ffFF<password>\n\t\127eeffFFRegister on Skynet")
    print("\127ffff00login \12700ffFF<username> \12700ffFF<password>\n\t\127eeffFF Log in to Skynet")
    print("\127ffff00newalliance \12700ffFF<alliance name>\n\t\127eeffFFStart a new alliance")
    print("\127ffff00invite \12700ffFF<player name>\n\t\127eeffFFInvite a player to your alliance")
    print("\127ffff00uninvite \12700ffFF<player name>\n\t\127eeffFFRevoke a player's invitation to the alliance")
    print("\127ffff00join \12700ffFF<alliance name>\n\t\127eeffFFJoin an alliance you have been invited too")
    print("\127ffff00promote \12700ffFF<player name>\n\t\127eeffFFPromote another player to commander of the alliance -- you will no longer be in charge")
    print("\127ffff00online \n\t\127eeffFF List online alliance members")
end

RegisterUserCommand('Skynet2', Skynet2.cli.Dispatch)
