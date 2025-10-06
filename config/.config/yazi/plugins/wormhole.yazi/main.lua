-- ~/.config/yazi/plugins/wormhole.yazi/init.lua

-- Configure your terminal emulator here.
-- The command should keep the window open after the command finishes.
-- Examples:
-- local term_cmd = "kitty -o hold=on"
-- local term_cmd = "alacritty --hold"
-- local term_cmd = "wezterm start --always-new-process"
-- local term_cmd = "gnome-terminal --wait --"
--local term_cmd = "foot"
local term_cmd = "kitty -o hold=on"

function Wormhole:send(cx)
  local file = cx.active.current.hovered
  if not file then
    return ya.notify_warn("No file selected")
  end

  if file.is_dir then
    return ya.notify_warn("Cannot send a directory (zip it first!)")
  end

  local file_path = tostring(file.path)

  -- This is a self-contained shell script that does everything.
  -- It's passed to `bash -c` as a single string.
  --
  -- How it works:
  -- 1. `stdbuf -o0 wormhole send "${1}" 2>&1`: Runs wormhole, ensuring its
  --    output isn't buffered (`stdbuf`), and merges stderr into stdout (`2>&1`).
  --    `"${1}"` will be our file path.
  --
  -- 2. `tee >(...)`: The output is sent to two places at once:
  --    a) `>(...)`: A process substitution that pipes the output to our `awk` script.
  --    b) The main stdout: This ensures the normal wormhole progress is still
  --       printed to the new terminal for the user to see.
  --
  -- 3. `awk '/Wormhole code is:/ { ... }'`: `awk` processes the stream.
  --    - It looks for a line containing "Wormhole code is:".
  --    - When found, it executes the block:
  --      - `code = $NF`: It grabs the last field on the line, which is the code.
  --      - `cmd = "qrencode -t UTF8 \"" code "\"`: It constructs the qrencode command.
  --      - `print "\n\n--- QR Code ---"; system(cmd); print "---------------"`: It prints
  --        a header, executes the `qrencode` command, and prints a footer.
  --
  -- 4. `echo ...; read -r`: After the wormhole process finishes, this keeps
  --    the terminal window open until the user presses Enter.
  local shell_script = [[
    (stdbuf -o0 wormhole send "${1}" 2>&1 | tee >(awk '
      /Wormhole code is:/ {
        code = $NF
        cmd = "qrencode -t UTF8 \"" code "\""
        print "\n\n--- QR Code ---"
        system(cmd)
        print "---------------"
        fflush()
      }
    ')) && (echo -e "\nTransfer complete or aborted. Press Enter to close." && read -r)
  ]]

  -- We construct the final command for the terminal.
  -- `bash -c script_string` tells bash to execute the script.
  -- `_` is a placeholder for the script name ($0).
  -- `ya.quote(file_path)` safely passes the filename as the first argument ($1).
  local full_command = string.format(
    "%s bash -c %s _ %s",
    term_cmd,
    ya.quote(shell_script),
    ya.quote(file_path)
  )

  ya.process.run_globally(full_command, function()
    ya.notify_info(string.format("Magic Wormhole started for %s", file.name))
  end)
end
