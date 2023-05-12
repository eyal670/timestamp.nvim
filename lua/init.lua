-- timestamp.lua

print('timestamp installed');
local timestamp = {}

function timestamp.setup()
    if not vim.fn.executable('xclip') then
        vim.api.nvim_echo({
            "xclip is not installed!",
            "You can install xclip with: `sudo apt install xclip` (Ubuntu)"
        }, true, {})
        return
    end

    vim.api.nvim_create_user_command("TimestampCopy", function()
        local timestamp = os.time(os.date("*t"))
        vim.fn.system('echo "' .. timestamp .. '" | xclip -selection clipboard')
        vim.notify("timestamp copied to clipboard")
    end, {})

    vim.api.nvim_create_user_command("TimestampAppend", function()
        local timestamp = os.time(os.date("*t"))
        vim.api.nvim_command("s:\\%#\\w\\+\\zs:_" .. timestamp .. ":")
    end, {})
end

return timestamp
