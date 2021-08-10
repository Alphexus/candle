local Candle = {
    array = {},
    dict = {}
}

function Candle.array.filter(tbl, predicate)
    local new = {}
    for i, v in pairs(tbl) do
        if predicate(i, v) then
            tbl.insert(new, i, v)
        end
    end
    return new
end

function Candle.array.concat(tbl0, tbl1)
    local new = {}
    for _,v in ipairs(tbl0) do
        table.insert(new, v)
    end
    for _,v in ipairs(tbl1) do
        table.insert(new, v)
    end
    return new
end

function Candle.array.flat(tbl, depth)
    depth = depth or math.huge
    if depth == 0 then return tbl end

    local new = {}    
    for i, v in pairs(tbl) do
        if type(v) == "table" then
            new = Candle.array.concat(new, Candle.array.flat(v, depth-1))
        else
            table.insert(new, v)
        end
    end
    
    return new
end

function Candle.array.new(size, value)
    local new = {}
    for i = 1, size do
        table.insert(new, value)
    end
    return new
end

function Candle.array.print(tbl)
    local function aux(outputString, value, indent)
        indent = indent + 1
        local indents = table.concat(Candle.array.new(indent*3, " "))
        if type(value) == "table" then
            outputString = outputString .. indents .. "{"
            for _,v in pairs(value) do
                outputString = outputString .. aux("\n", v, indent)
            end
            outputString = outputString .. "\n" .. indents .. "}"
        else
            outputString = outputString .. indents .. value
        end

        return outputString
    end
    
    print(aux("", tbl, -1))
end

return Candle
