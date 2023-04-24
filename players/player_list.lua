--[[
Author:  Joshua S. Day (haxmeister)
Purpose: Manages a list of players seen
]]--

Skynet2.playerlist = {
    ['need_ui_update'] = false,
    ['ui_list']= {}, -- to contain remote player objects keyed by sector shortname
    ['local_list'] = {}, -- player objects from this sector keyed by sector
    ['timer']      = Timer(),
    ['ui_update_timer']   = Timer(),
    ['sendDelay']  = 2000,   -- milliseconds to wait between sends
    ['sector_timers'] = {}  -- timers for each sector keyed by sector shortname
}


function Skynet2.playerlist:update(data)
    -- we clear every time and let the server manage it
    self.ui_list = {}

    -- get the sector we are in for skipping later
    local current_sector = AbbrLocationStr(GetCurrentSectorid())

    -- if we received a blank playerseen report then update ours in case it expired
    if not next(data.playerlist) then
        --print ("empty playerseen recieved")
        Skynet2.playerlist:report()

    end

    -- we build a lists for each sector
    for sector in pairs(data.playerlist) do
        if sector ~= current_sector then
            self.ui_list[sector] = data.playerlist[sector]
            self.need_ui_update = true
        end
    end

    Skynet2.playerlist:ui_update()
    self.need_ui_update = false

end

function Skynet2.playerlist:send_list()
    Skynet2.coms.playerseen( self.local_list )
    self.local_list = {} -- reset after sending
end

function Skynet2.playerlist:report()

    -- here we skip if the timer is already running
    -- this allows us to use the same function for the player_entered_sector
    -- event as well as the sector_changed event without sending too frequently
    if Skynet2.playerlist.timer:IsActive() then
        return
    end

    Skynet2.playerlist.timer:SetTimeout(
        Skynet2.playerlist.sendDelay,
        function()
            -- we make a key for our current sector
            local current_sector = AbbrLocationStr(GetCurrentSectorid())
            Skynet2.playerlist.local_list[current_sector] = {}

            ForEachPlayer(
                function(id)
                    -- skip ourselves
                    --if id == GetCharacterID() then return end

                    local player = Skynet2.player.new(id)

                    -- skip NPCs
                    if player.name:match("^\*") then return end

                    Skynet2.playerlist.local_list[player.locAbrev] = Skynet2.playerlist.local_list[player.locAbrev] or {}
                    table.insert(Skynet2.playerlist.local_list[player.locAbrev], player)
                end
            )


            if Skynet2.playerlist.local_list[current_sector][1] then
                Skynet2.playerlist:send_list()
            else
                return
            end
        end
    )
end

function Skynet2.playerlist:ui_update()

    --print("playerlist ui update")
    iup.Destroy(Skynet2.ui.spotbox)

    Skynet2.ui.spotbox = iup.hbox{}
    --print(json.encode(self.ui_list))

    Skynet2.ui.spotbox:append(iup.fill{})

    for sector in pairs(self.ui_list) do
        if next(self.ui_list[sector]) == nil then
            self.ui_list[sector] = nil
        else

            local list_box = iup.vbox{
                iup.label { title = sector }
            }

            for _,player in ipairs(self.ui_list[sector]) do
                --print(sector..": "..player.name)
                list_box:append(iup.label { title = player.factionColor.."["..player.guild.."]"..player.name.." \127666666"..player.ship })
            end

            Skynet2.ui.spotbox:append(list_box)
        end
    end

    --iup.refresh(Skynet2.ui.spotbox)
    Skynet2.ui.container:append(Skynet2.ui.spotbox)
    Skynet2.ui.spotbox:append(iup.fill{})
end



