local Candle = {}
local MethodReferences = {
    map = function(tbl, ...) return Candle.map(tbl, ...) end,
    filter = function(tbl, ...) return Candle.filter(tbl, ...) end,
    concat = function(tbl, ...) return Candle.concat(tbl, ...) end,
    flat = function(tbl, ...) return Candle.flat(tbl, ...) end,
    print = function(tbl, ...) return Candle.print(tbl, ...) end
}

-- much faster than normal assert if you short circruit the args using 'or'
local function fasterAssert(c, errorMsg) 
    return c == true or error(errorMsg) 
end

local function getMethodMetatable()
    return {
        __index = function(tbl, key)
            return MethodReferences[key] and function(...)
                return MethodReferences[key](tbl, ...)
            end
        end
    }
end

function Candle.filter(tbl, predicate)
    local new = {}
    for i, v in pairs(tbl) do
        if predicate(v, i) then
            table.insert(new, v)
        end
    end

    setmetatable(new, getMethodMetatable())
    return new
end

function Candle.concat(tbl0, tbl1)
    local new = {}
    for _,v in ipairs(tbl0) do
        table.insert(new, v)
    end
    for _,v in ipairs(tbl1) do
        table.insert(new, v)
    end

    setmetatable(new, getMethodMetatable())
    return new
end

function Candle.flat(tbl, depth)
    depth = depth or math.huge
    if depth == 0 then return tbl end

    local new = {}    
    for i, v in pairs(tbl) do
        if type(v) == "table" then
            new = Candle.concat(new, Candle.flat(v, depth-1))
        else
            table.insert(new, v)
        end
    end
    
    setmetatable(new, getMethodMetatable())
    return new
end

function Candle.new(size, value)
    fasterAssert(size >= 0 or "Candle.array.new:Argument 1 size must be greater than 0")

    local new = {}
    for i = 1, size do
        table.insert(new, value)
    end

    setmetatable(new, getMethodMetatable())
    return new
end

function Candle.print(tbl)
    local function aux(outputString, value, indent)
        indent = indent + 1
        local indents = table.concat(Candle.new(indent*3, " "))
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
    
    setmetatable(tbl, getMethodMetatable())
    return tbl
end

function Candle.map(tbl, callback)
    local new = {}
    for i, v in ipairs(tbl) do
        table.insert(new, callback(v, i))
    end

    setmetatable(new, getMethodMetatable())
    return new
end

return Candle
