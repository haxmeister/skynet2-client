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

Skynet2.LoadSounds = function()
    --Load sounds
    gksound.GKLoadSound{soundname='humil',    filename="plugins/skynet2-client/sounds/humil.ogg"}
    gksound.GKLoadSound{soundname='massa',    filename="plugins/skynet2-client/sounds/massacre.ogg"}
    gksound.GKLoadSound{soundname='smack',    filename="plugins/skynet2-client/sounds/smackdown.ogg"}
    gksound.GKLoadSound{soundname='domin',    filename="plugins/skynet2-client/sounds/dominate.ogg"}
    gksound.GKLoadSound{soundname='game',     filename="plugins/skynet2-client/sounds/gameover.ogg"}
    gksound.GKLoadSound{soundname='sweet',    filename="plugins/skynet2-client/sounds/sweetvengence.ogg"}
    gksound.GKLoadSound{soundname='waste',    filename="plugins/skynet2-client/sounds/waste.ogg"}
    gksound.GKLoadSound{soundname='poor',     filename="plugins/skynet2-client/sounds/poorbaby.ogg"}
    gksound.GKLoadSound{soundname='tooez',    filename="plugins/skynet2-client/sounds/tooeasy.ogg"}
    gksound.GKLoadSound{soundname='bow',      filename="plugins/skynet2-client/sounds/bow.ogg"}
    gksound.GKLoadSound{soundname='nocha',    filename="plugins/skynet2-client/sounds/nochance.ogg"}
    gksound.GKLoadSound{soundname='yoda',     filename="plugins/skynet2-client/sounds/sizemattersnot.ogg"}
    gksound.GKLoadSound{soundname='headshot', filename="plugins/skynet2-client/sounds/headshot.ogg"}
    gksound.GKLoadSound{soundname='3kills',   filename="plugins/skynet2-client/sounds/3_kills.ogg"}
    gksound.GKLoadSound{soundname='4kills',   filename="plugins/skynet2-client/sounds/4_kills.ogg"}
    gksound.GKLoadSound{soundname='5kills',   filename="plugins/skynet2-client/sounds/5_kills.ogg"}
    gksound.GKLoadSound{soundname='6kills',   filename="plugins/skynet2-client/sounds/6_kills.ogg"}
    gksound.GKLoadSound{soundname='7kills',   filename="plugins/skynet2-client/sounds/7_kills.ogg"}
    gksound.GKLoadSound{soundname='8kills',   filename="plugins/skynet2-client/sounds/8_kills.ogg"}
    gksound.GKLoadSound{soundname='9kills',   filename="plugins/skynet2-client/sounds/9_kills.ogg"}
    gksound.GKLoadSound{soundname='10kills',  filename="plugins/skynet2-client/sounds/10_kills.ogg"}
    gksound.GKLoadSound{soundname='godlike',  filename="plugins/skynet2-client/sounds/godlike.ogg"}
    gksound.GKLoadSound{soundname='immortal', filename="plugins/skynet2-client/sounds/immortal.ogg"}
    gksound.GKLoadSound{soundname='double',   filename="plugins/skynet2-client/sounds/double_kill.ogg"}
    gksound.GKLoadSound{soundname='triple',   filename="plugins/skynet2-client/sounds/triple_kill.ogg"}
    gksound.GKLoadSound{soundname='quad',     filename="plugins/skynet2-client/sounds/quad_kill.ogg"}
    gksound.GKLoadSound{soundname='annihilation', filename="plugins/skynet2-client/sounds/annihilation.ogg"}
    gksound.GKLoadSound{soundname='genocide', filename="plugins/skynet2-client/sounds/genocide.ogg"}
end
