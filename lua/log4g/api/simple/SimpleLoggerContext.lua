--- A simple LoggerContext implementation.
-- @classmod SimpleLoggerContext
Log4g.API.Simple.SimpleLoggerContext = Log4g.API.Simple.SimpleLoggerContext or {}
local LoggerContext = Log4g.Core.LoggerContext.GetClass()
local SimpleLoggerContext = LoggerContext:subclass("SimpleLoggerContext")
local GetCDICT = Log4g.Core.LoggerContext.GetAll
local isstring = isstring
local pcall = pcall

function SimpleLoggerContext:Initialize(name)
    LoggerContext.Initialize(self, name)
end

function SimpleLoggerContext:IsSimpleLoggerContext()
    return true
end

function SimpleLoggerContext:__tostring()
    return "SimpleLoggerContext: [name:" .. self:GetName() .. "]"
end

--- Get the SimpleLoggerContext with the right name.
-- @param name string name
-- @return object SimpleLoggerContext
function Log4g.API.Simple.SimpleLoggerContext.Get(name)
    if not isstring(name) then return end
    local ctx = GetCDICT()[name]

    if ctx and pcall(function()
        ctx:IsSimpleLoggerContext()
    end) then
        return ctx
    end
end

--- Register a SimpleLoggerContext.
-- @param name The name of the SimpleLoggerContext
function Log4g.API.Simple.SimpleLoggerContext.Register(name)
    local cdict = GetCDICT()
    local ctx = cdict[name]

    if ctx and pcall(function()
        ctx:IsSimpleLoggerContext()
    end) then
        return ctx
    end

    ctx = SimpleLoggerContext(name)
    cdict[name] = ctx

    return ctx
end