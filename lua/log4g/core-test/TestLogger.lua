local CreateLogger = Log4g.Core.Logger.Create
local GetContext = Log4g.API.LoggerContextFactory.GetContext
local GetLevel = Log4g.Level.GetLevel
local CreateLoggerConfig = Log4g.Core.Config.LoggerConfig.Create
local print = print

local function PrintLoggerInfo(...)
    print("Logger", "Assigned LC", "LC Parent", "Level")

    for _, v in pairs({...}) do
        print(v:GetName(), v:GetLoggerConfig():GetName(), tostring(v:GetLoggerConfig():GetParent()), v:GetLevel():GetName())
    end
end

concommand.Add("Log4g_CoreTest_LoggerConfig_Inheritance_Example1", function()
    local ctx = GetContext("TestLoggerConfigInheritanceExample1Context", true)
    PrintLoggerInfo(CreateLogger("X", ctx), CreateLogger("X.Y", ctx), CreateLogger("X.Y.Z", ctx))
end)

concommand.Add("Log4g_CoreTest_LoggerConfig_Inheritance_Example2", function()
    local ctx = GetContext("TestLoggerConfigInheritanceExample2Context", true)
    PrintLoggerInfo(CreateLogger("X", ctx, CreateLoggerConfig("X", ctx:GetConfiguration(), GetLevel("ERROR"))), CreateLogger("X.Y", ctx, CreateLoggerConfig("X.Y", ctx:GetConfiguration(), GetLevel("INFO"))), CreateLogger("X.Y.Z", ctx, CreateLoggerConfig("X.Y.Z", ctx:GetConfiguration(), GetLevel("WARN"))))
end)

concommand.Add("Log4g_CoreTest_LoggerConfig_Inheritance_Example3", function()
    local ctx = GetContext("TestLoggerConfigInheritanceExample3Context", true)
    PrintLoggerInfo(CreateLogger("X", ctx, CreateLoggerConfig("X", ctx:GetConfiguration(), GetLevel("ERROR"))), CreateLogger("X.Y", ctx), CreateLogger("X.Y.Z", ctx, CreateLoggerConfig("X.Y.Z", ctx:GetConfiguration(), GetLevel("WARN"))))
end)

concommand.Add("Log4g_CoreTest_LoggerConfig_Inheritance_Example4", function()
    local ctx = GetContext("TestLoggerConfigInheritanceExample4Context", true)
    PrintLoggerInfo(CreateLogger("X", ctx, CreateLoggerConfig("X", ctx:GetConfiguration(), GetLevel("ERROR"))), CreateLogger("X.Y", ctx), CreateLogger("X.Y.Z", ctx))
end)

concommand.Add("Log4g_CoreTest_LoggerConfig_Inheritance_Example5", function()
    local ctx = GetContext("TestLoggerConfigInheritanceExample5Context", true)
    PrintLoggerInfo(CreateLogger("X", ctx, CreateLoggerConfig("X", ctx:GetConfiguration(), GetLevel("ERROR"))), CreateLogger("X.Y", ctx, CreateLoggerConfig("X.Y", ctx:GetConfiguration(), GetLevel("INFO"))), CreateLogger("X.YZ", ctx))
end)

concommand.Add("Log4g_CoreTest_LoggerConfig_Inheritance_Example6", function()
    local ctx = GetContext("TestLoggerConfigInheritanceExample6Context", true)
    PrintLoggerInfo(CreateLogger("X", ctx, CreateLoggerConfig("X", ctx:GetConfiguration(), GetLevel("ERROR"))), CreateLogger("X.Y", ctx, CreateLoggerConfig("X.Y", ctx:GetConfiguration())), CreateLogger("X.Y.Z", ctx))
end)