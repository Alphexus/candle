local Candle = {
    array = {},
    dict = {}
}

-- much faster than normal assert if you short circruit the args using 'or'
local function fasterAssert(c, errorMsg) 
    return x == true or error(x) 
end

function Candle.array.filter(tbl, predicate)
    local new = {}
    for i, v in pairs(tbl) do
        if predicate(v, i) then
            table.insert(new, v)
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
    fasterAssert(size > 0 or "Candle.array.new:Argument 1 size must be greater than 0")

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

function Candle.array.map(tbl, callback)
    local new = {}
    for i, v in ipairs(tbl) do
        table.insert(new, callback(v, i))
    end
    return new
end

local methods = {
    array = {
        map = function( )

        end
    }
}

return Candle
