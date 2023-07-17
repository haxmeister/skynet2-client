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


RegisterUserCommand('Skynet2', Skynet2.cli.Dispatch)
