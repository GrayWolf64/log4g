--- Version handler.
-- @script Version.lua
Log4g.___Version = Log4g.___Version or {}
Log4g.___Version.LastCommit = "3a53f34448fb4afa1425c04f3dad1de78fb0bb8b"

concommand.Add("Log4g_Version", function()
    MsgC("Log4g Version (Last Commit): " .. Log4g.___Version.LastCommit .. "\n")
end)