--- Interface that must be implemented to create a Configuration.
-- Subclassing `LifeCycle`, mixin-ing `SetContext()` and `GetContext()`.
-- @classmod Configuration
-- @license Apache License 2.0
-- @copyright GrayWolf64
local LifeCycle = Log4g.GetPkgClsFuncs("log4g-core", "LifeCycle").getClass()
local IsAppender = Log4g.GetPkgClsFuncs("log4g-core", "TypeUtil").IsAppender
local PropertiesPlugin = Log4g.GetPkgClsFuncs("log4g-core", "PropertiesPlugin")
local Configuration = LifeCycle:subclass"Configuration"
Configuration:include(Log4g.GetPkgClsFuncs("log4g-core", "Object").contextualMixins)
local SysTime = SysTime

function Configuration:Initialize(name)
    LifeCycle.Initialize(self)
    self:SetPrivateField("ap", {})
    self:SetPrivateField("lc", {})
    self:SetPrivateField("start", SysTime())
    self:SetName(name)
end

function Configuration:__tostring()
    return "Configuration: [name:" .. self:GetName() .. "]"
end

function Configuration:IsConfiguration()
    return true
end

--- Adds a Appender to the Configuration.
-- @param appender The Appender to add
-- @bool ifsuccessfullyadded
function Configuration:AddAppender(ap)
    if not IsAppender(ap) then return end
    if self:GetPrivateField"ap"[ap:GetName()] then return false end
    self:GetPrivateField"ap"[ap:GetName()] = ap

    return true
end

function Configuration:RemoveAppender(name)
    self:GetPrivateField"ap"[name] = nil
end

--- Gets all the Appenders in the Configuration.
-- Keys are the names of Appenders and values are the Appenders themselves.
-- @return table appenders
function Configuration:GetAppenders()
    return self:GetPrivateField"ap"
end

function Configuration:AddLogger(name, lc)
    self:GetPrivateField"lc"[name] = lc
end

--- Locates the appropriate LoggerConfig name for a Logger name.
-- @param name The Logger name
-- @return object loggerconfig
function Configuration:GetLoggerConfig(name)
    return self:GetPrivateField"lc"[name]
end

function Configuration:GetLoggerConfigs()
    return self:GetPrivateField"lc"
end

function Configuration:GetRootLogger()
    return self:GetPrivateField"lc"[PropertiesPlugin.getProperty("rootLoggerName", true)]
end

--- Gets how long since this Configuration initialized.
-- @return int uptime
function Configuration:GetUpTime()
    return SysTime() - self:GetPrivateField"start"
end

--- Create a Configuration.
-- @param name The name of the Configuration
-- @return object configuration
local function Create(name)
    if type(name) ~= "string" then return end

    return Configuration(name)
end

local function GetClass()
    return Configuration
end

--- The default configuration writes all output to the console using the default logging level.
local DefaultConfiguration = Configuration:subclass"DefaultConfiguration"
local CreateConsoleAppender, CreatePatternLayout = Log4g.GetPkgClsFuncs("log4g-core", "ConsoleAppender").createConsoleAppender, Log4g.GetPkgClsFuncs("log4g-core", "PatternLayout").createDefaultLayout
CreateConVar("log4g_configuration_default_name", "default", FCVAR_NOTIFY):GetString()
CreateConVar("log4g_configuration_default_level", "DEBUG", FCVAR_NOTIFY):GetString()

function DefaultConfiguration:Initialize(name)
    Configuration.Initialize(self, name)
    self:SetPrivateField("defaultlevel", GetConVar"log4g_configuration_default_level":GetString())
end

local function GetDefaultConfiguration()
    local name = GetConVar"log4g_configuration_default_name":GetString()
    local configuration = DefaultConfiguration(name)
    configuration:AddAppender(CreateConsoleAppender(name .. "Appender", CreatePatternLayout(name .. "Layout")))

    return configuration
end

Log4g.RegisterPackageClass("log4g-core", "Configuration", {
    getClass = GetClass,
    create = Create,
    getDefaultConfiguration = GetDefaultConfiguration
})