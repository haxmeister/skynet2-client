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
--Skynet2.cli["connect"] = function(args)
    --Skynet2.TCPConn.connect()
--end

----done
--Skynet2.cli["disconnect"] = function(args)
    --Skynet2.TCPConn.Disconnect()
--end

--Skynet2.cli["config"] = function(args)
    --ShowDialog(Skynet2.UI.SettingsWindow)
--end

----done
--Skynet2.cli["listpayment"] = function(args)
    --Skynet2.TCPConn.SendData({ action='listpayment'})
--end

----done
--Skynet2.cli["listkos"] = function(args)
    --Skynet2.TCPConn.SendData({ action='listkos'})
--end

----done
--Skynet2.cli["listallies"] = function(args)
    --Skynet2.TCPConn.SendData({ action='listallies'})
--end

----done
--Skynet2.cli["list"] = function(args)
    --Skynet2.TCPConn.SendData({ action='list'})
--end

----done
--Skynet2.cli["addpayment"] = function(args)
    --if (args[2]==nil or args[3]==nil) then
        --Skynet2.printerror("Missing parameters for command - " .. args[1])
        --return
    --end
    --local name = substitute_vars(args[2])
    --Skynet2.TCPConn.SendData({ action='addpayment', name=name, length=args[3] })
--end

----done
--Skynet2.cli["removepayment"] = function(args)
    --if (args[2]==nil) then
        --Skynet2.printerror("Missing parameters for command - " .. args[1])
        --return
    --end
    --local name = substitute_vars(args[2])
    --Skynet2.TCPConn.SendData({ action='removepayment', name=name})
--end

----done
--Skynet2.cli["addkos"] = function(args)
    --if (args[2]==nil) then
        --Skynet2.printerror("Missing parameters for command - " .. args[1])
        --return
    --end
    --local name = substitute_vars(args[2])
    --local len = args[3] or "0"
    --local note = args[4] or ""
    --Skynet2.TCPConn.SendData({ action='addkos', name=name, length=len, notes=note})
--end

----done
--Skynet2.cli["removekos"] = function(args)
    --if (args[2]==nil) then
        --Skynet2.printerror("Missing parameters for command - " .. args[1])
        --return
    --end
    --local name = substitute_vars(args[2])
    --Skynet2.TCPConn.SendData({ action='removekos', name=name})
--end

----done
--Skynet2.cli["addally"] = function(args)
    --if (args[2]==nil) then
        --Skynet2.printerror("Missing parameters for command - " .. args[1])
        --return
    --end
    --local name = substitute_vars(args[2])
    --Skynet2.TCPConn.SendData({ action='addally', name=name})
--end

----done
--Skynet2.cli["removeally"] = function(args)
    --if (args[2]==nil) then
        --Skynet2.printerror("Missing parameters for command - " .. args[1])
        --return
    --end
    --local name = substitute_vars(args[2])
    --Skynet2.TCPConn.SendData({ action='removeally', name=name })
--end

----done
--Skynet2.cli["adduser"] = function(args)
    --Skynet2.UI.adduser.dialog:show()
--end

--Skynet2.cli["removeuser"] = function(args)
    --if (args[2]==nil) then
        --Skynet2.printerror("Adduser command need 1 parameters: username")
    --else
        --Skynet2.TCPConn.SendData({ action='removeuser', username=args[2] })
    --end
--end

--Skynet2.cli["clearspots"] = function(args)
    --Skynet2.ClearSpots()
--end

--Skynet2.cli["help"] = function(args)
    --Skynet2.ShowHelp()
--end

--RegisterUsercli('Skynet2', Skynet2.cli.Dispatch)
