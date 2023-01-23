local AddNetworkStrsViaTbl = Log4g.Util.AddNetworkStrsViaTbl

AddNetworkStrsViaTbl({
    ["Log4g_CLReq_SVSummaryData"] = true,
    ["Log4g_CLRcv_SVSummaryData"] = true
})

net.Receive("Log4g_CLReq_SVSummaryData", function(len, ply)
    net.Start("Log4g_CLRcv_SVSummaryData")
    net.WriteFloat(collectgarbage("count"))
    net.WriteUInt(ents.GetCount(), 14)
    net.WriteUInt(ents.GetEdictCount(), 13)
    net.WriteUInt(table.Count(net.Receivers), 12)
    net.WriteUInt(table.Count(debug.getregistry()), 32)
    local ConstraintCount = 0

    for _, v in pairs(ents.GetAll()) do
        ConstraintCount = ConstraintCount + table.Count(constraint.GetTable(v))
    end

    net.WriteUInt(ConstraintCount / 2, 16)
    net.Send(ply)
end)