---------------------
---- MY PROGRAMS ----
---------------------

-- Set programs that you use
local terminal    = "foot"
local fileManager = "nautilus"
local runmenu     =
"tofi-run --font /home/ky/.local/share/fonts/OperatorMono-Book.otf --corner-radius=24 --width=800 --height=300 --border-width=0 --hint-font false --drun-launch=true"
local drunmenu    =
"tofi-drun --font /home/ky/.local/share/fonts/OperatorMono-Book.otf --corner-radius=24 --width=800 --height=300 --border-width=0 --hint-font false --drun-launch=true"

---------------------
---- KEYBINDINGS ----
---------------------

local mainMod = "SUPER" -- Sets "Windows" key as main modifier

-- Example binds, see https://wiki.hypr.land/Configuring/Basics/Binds/ for more
hl.bind(mainMod .. " + t", hl.dsp.exec_cmd(terminal))
local closeWindowBind = hl.bind(mainMod .. " + q", hl.dsp.window.close())
-- closeWindowBind:set_enabled(false)
-- hl.bind(mainMod .. " + M",
--     hl.dsp.exec_cmd("command -v hyprshutdown >/dev/null 2>&1 && hyprshutdown || hyprctl dispatch 'hl.dsp.exit()'"))
hl.bind(mainMod .. " + E", hl.dsp.exec_cmd(fileManager))
hl.bind(mainMod .. " + V", hl.dsp.window.float({ action = "toggle" }))
hl.bind(mainMod .. " + space", hl.dsp.exec_cmd(drunmenu))
--hl.bind(mainMod .. " + P", hl.dsp.window.pseudo())
hl.bind(mainMod .. " + J", hl.dsp.layout("togglesplit")) -- dwindle only

-- Move focus with mainMod + arrow keys
hl.bind(mainMod .. " + h", hl.dsp.focus({ direction = "left" }))
hl.bind(mainMod .. " + l", hl.dsp.focus({ direction = "right" }))
hl.bind(mainMod .. " + k", hl.dsp.focus({ direction = "up" }))
hl.bind(mainMod .. " + j", hl.dsp.focus({ direction = "down" }))

-- Switch workspaces with mainMod + [0-9]
-- Move active window to a workspace with mainMod + SHIFT + [0-9]
hl.bind(mainMod .. " + a", hl.dsp.focus({ workspace = "-1" }))
hl.bind(mainMod .. " + s", hl.dsp.layout("swapsplit"))
hl.bind(mainMod .. " + d", hl.dsp.focus({ workspace = "+1" }))

hl.bind(mainMod .. " + SHIFT +q", hl.dsp.focus({ workspace = "1" }))
hl.bind(mainMod .. " + SHIFT + a", hl.dsp.window.move({ workspace = "1" }))
hl.bind(mainMod .. " + SHIFT +w", hl.dsp.focus({ workspace = "2" }))
hl.bind(mainMod .. " + SHIFT + s", hl.dsp.window.move({ workspace = "2" }))
hl.bind(mainMod .. " + SHIFT +e", hl.dsp.focus({ workspace = "3" }))
hl.bind(mainMod .. " + SHIFT + d", hl.dsp.window.move({ workspace = "3" }))
hl.bind(mainMod .. " + SHIFT +r", hl.dsp.focus({ workspace = "4" }))
hl.bind(mainMod .. " + SHIFT + f", hl.dsp.window.move({ workspace = "4" }))
hl.bind(mainMod .. " + SHIFT +t", hl.dsp.focus({ workspace = "5" }))
hl.bind(mainMod .. " + SHIFT + g", hl.dsp.window.move({ workspace = "5" }))

-- Example special workspace (scratchpad)
hl.bind(mainMod .. " + y", hl.dsp.workspace.toggle_special("magic"))
hl.bind(mainMod .. " + SHIFT + y", hl.dsp.window.move({ workspace = "special:magic" }))

-- Scroll through existing workspaces with mainMod + scroll
hl.bind(mainMod .. " + mouse_down", hl.dsp.focus({ workspace = "e+1" }))
hl.bind(mainMod .. " + mouse_up", hl.dsp.focus({ workspace = "e-1" }))

-- Move/resize windows with mainMod + LMB/RMB and dragging
hl.bind(mainMod .. " + mouse:272", hl.dsp.window.drag(), { mouse = true })
hl.bind(mainMod .. " + mouse:273", hl.dsp.window.resize(), { mouse = true })


-- misc
hl.bind(mainMod .. " + SHIFT + L", hl.dsp.exec_cmd("hyprlock"))
hl.bind(mainMod .. " + N", hl.dsp.exec_cmd("swaync-client -t"))
hl.bind(mainMod .. " + x", hl.dsp.exec_cmd("bash ~/.config/tofi/scripts/powermenu.sh"))
hl.bind(mainMod .. " + f", hl.dsp.window.fullscreen({ fullscreen, toggle, true, activewindow }))
hl.bind(mainMod .. " + p", hl.dsp.window.pin({ toggle, activewindow }))

hl.bind(mainMod .. " + f11", hl.dsp.exec_cmd("light -U 5"))
hl.bind(mainMod .. " + f12", hl.dsp.exec_cmd("light -A 5"))

-- Screenshots
hl.bind(mainMod .. " + SHIFT + H", hl.dsp.exec_cmd('grim -g "$(slurp)" - | satty -f -'))
hl.bind(mainMod .. " + SHIFT + J", hl.dsp.exec_cmd("grim - | satty -f -"))

-- Laptop multimedia keys for volume and LCD brightness
-- hl.bind("XF86AudioRaiseVolume", hl.dsp.exec_cmd("wpctl set-volume -l 1 @DEFAULT_AUDIO_SINK@ 5%+"),
--     { locked = true, repeating = true })
-- hl.bind("XF86AudioLowerVolume", hl.dsp.exec_cmd("wpctl set-volume @DEFAULT_AUDIO_SINK@ 5%-"),
--     { locked = true, repeating = true })
-- hl.bind("XF86AudioMute", hl.dsp.exec_cmd("wpctl set-mute @DEFAULT_AUDIO_SINK@ toggle"),
--     { locked = true, repeating = true })
-- hl.bind("XF86AudioMicMute", hl.dsp.exec_cmd("wpctl set-mute @DEFAULT_AUDIO_SOURCE@ toggle"),
--     { locked = true, repeating = true })
-- hl.bind("XF86MonBrightnessUp", hl.dsp.exec_cmd("brightnessctl -e4 -n2 set 5%+"), { locked = true, repeating = true })
-- hl.bind("XF86MonBrightnessDown", hl.dsp.exec_cmd("brightnessctl -e4 -n2 set 5%-"), { locked = true, repeating = true })

-- Requires playerctl
-- hl.bind("XF86AudioNext", hl.dsp.exec_cmd("playerctl next"), { locked = true })
-- hl.bind("XF86AudioPause", hl.dsp.exec_cmd("playerctl play-pause"), { locked = true })
-- hl.bind("XF86AudioPlay", hl.dsp.exec_cmd("playerctl play-pause"), { locked = true })
-- hl.bind("XF86AudioPrev", hl.dsp.exec_cmd("playerctl previous"), { locked = true })
