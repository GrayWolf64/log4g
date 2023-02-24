--- The Util Library (Module).
-- @module Util
-- @license Apache License 2.0
-- @copyright GrayWolf64
Log4g.Util = Log4g.Util or {}
local Util = Log4g.Util

--- Add all the string keys in a table to network string table.
-- @param tbl The table of network strings to add
function Util.AddNetworkStrsViaTbl(tbl)
    local AddNetworkString = util.AddNetworkString

    for _, v in pairs(tbl) do
        AddNetworkString(v)
    end
end

--- Get the current FQSN according to the function provided.
-- Notice that the result will be the same across the same file where this function is called.
-- Something may go wrong if used on a C function.
-- @param func The name of the function where GetCurrentFQSN is called
-- @return string fqsn
function Util.GetCurrentFQSN(func)
    return string.StripExtension(debug.getinfo(func, "S").source:gsub("%/", "."):gsub("%@", ""))
end