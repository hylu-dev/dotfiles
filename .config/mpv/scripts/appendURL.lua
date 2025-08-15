-- Set a global variable to store the detected clipboard tool
local clipboard_tool = nil
local utils = require("mp.utils")
local msg = require("mp.msg")

-- Function to check for a command's existence
local function command_exists(cmd)
	local res = utils.subprocess({ args = { "which", cmd }, capture_stdout = true })
	return res.status == 0 and res.stdout and res.stdout:match(".%S+")
end

-- Function to detect the appropriate clipboard tool
local function detect_clipboard_tool()
	if command_exists("wl-paste") then
		return "wl-paste"
	elseif command_exists("xclip") then
		return "xclip"
	elseif command_exists("pbpaste") then
		return "pbpaste"
	elseif command_exists("powershell") then
		return "powershell"
	else
		return nil
	end
end

-- Initialize the clipboard_tool once
clipboard_tool = detect_clipboard_tool()

-- Main function to paste and append the URL
function paste_and_append()
	local clipboard_content = get_clipboard_content()
	if clipboard_content and clipboard_content ~= "" then
		mp.commandv("loadfile", clipboard_content, "append-play")
		mp.osd_message("URL appended: " .. clipboard_content)
		msg.info("URL appended: " .. clipboard_content)
	else
		mp.osd_message("Clipboard is empty or not a valid URL")
		msg.warn("Clipboard is empty or could not be read.")
	end
end

-- Handles the subprocess response table and returns the clipboard content if successful
local function handle_response(res, args)
	if not res.error and res.status == 0 then
		-- Remove any leading/trailing whitespace
		local content = res.stdout:match("^%s*(.-)%s*$")
		return content
	else
		msg.error("Failed to get clipboard content.")
		msg.error("  Status: " .. (res.status or "nil"))
		msg.error("  Error: " .. (res.error or "nil"))
		msg.error("  stdout: " .. (res.stdout or "nil"))
		msg.error("  Args: " .. utils.to_string(args))
		return nil
	end
end

-- Function to get the clipboard content based on the detected tool
local function get_clipboard_content()
	if not clipboard_tool then
		msg.error("No compatible clipboard tool found (wl-paste, xclip, pbpaste, or powershell).")
		return nil
	end

	if clipboard_tool == "wl-paste" then
		local args = { "wl-paste", "--no-newline" }
		return handle_response(utils.subprocess({ args = args }), args)
	elseif clipboard_tool == "xclip" then
		local args = { "xclip", "-selection", "clipboard", "-out" }
		return handle_response(utils.subprocess({ args = args }), args)
	elseif clipboard_tool == "pbpaste" then
		local args = { "pbpaste" }
		return handle_response(utils.subprocess({ args = args }), args)
	elseif clipboard_tool == "powershell" then
		local args = {
			"powershell",
			"-NoProfile",
			"-Command",
			[[& {
                Trap { Write-Error -ErrorRecord $_; Exit 1 }
                $clip = "";
                if (Get-Command "Get-Clipboard" -errorAction SilentlyContinue) {
                    $clip = Get-Clipboard -Raw -Format Text -TextFormatType UnicodeText
                } else {
                    Add-Type -AssemblyName PresentationCore;
                    $clip = [Windows.Clipboard]::GetText()
                }
                $clip = $clip -Replace "`r","";
                $u8clip = [System.Text.Encoding]::UTF8.GetBytes($clip);
                [Console]::OpenStandardOutput().Write($u8clip, 0, $u8clip.Length);
            }]],
		}
		return handle_response(utils.subprocess({ args = args }), args)
	end
	return nil
end

-- Binds Ctrl+v to the paste_and_append function
mp.add_key_binding("Ctrl+v", "paste-and-append", paste_and_append)
