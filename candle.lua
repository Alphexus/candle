local Candle = {
    array = {},
    dict = {}
}

function Candle.array.filter(table, predicate)
    local new = {}
    for i, v in pairs(table) do
        if predicate(i, v) then
            table.insert(new, i, v)
        end
    end
    return new
end

function Candle.array.concat(table0, table1)
    return {unpack(table0), unpack(table1)}
end

function Candle.array.flat(table, depth)
    depth = depth or 1
    if depth == 0 then return table end

    local new = {}    
    for i, v in pairs(table) do
        if type(v) == "table" then
            new = self.array.concat(new, v)
        else
            table.insert(new, v)
        end
    end
    
    return Candle.array.flat(new, depth-1)
end

return Candle
