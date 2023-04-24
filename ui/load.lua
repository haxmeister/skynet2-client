Skynet2.ui = Skynet2.ui or {}


--Skynet2.ui.spotbox = iup.hbox{}

Skynet2.ui.container = iup.vbox{}

Skynet2.ui.bottom = iup.vbox {
    visible="YES",
    iup.fill { size="%80" },
    iup.hbox {
        iup.fill {},
            Skynet2.ui.container,
        iup.fill {},
    },
    iup.fill {},
    alignment="ACENTER",
    gap=2
}

iup.Append(HUD.pluginlayer, Skynet2.ui.bottom)
iup.Map(Skynet2.ui.bottom)
iup.Refresh(Skynet2.ui.bottom)
Skynet2.ui.bottom:show()

