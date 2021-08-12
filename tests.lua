local luaunit = require("luaunit")
local candle = require("candle")

function testArrayFilter()
    -- it should filter out numbers less than or equal to 10
    luaunit.assertEquals(candle.filter({ 
        21, 57, 102, 3, 9, 20, 5, 8, 1, 10
    }, function(v)
        return v > 10
    end), {
        21, 57, 102, 20
    })
end

function testArrayFlat()
    local t = { 1, 2, 3, { 4, 5, 6, { 7, 8, 9 } } }

    -- it should flatten the entire table 
    luaunit.assertEquals(candle.flat(t), {
        1, 2, 3, 4, 5, 6, 7, 8, 9 
    })

    -- it should flatten 1 layer
    luaunit.assertEquals(candle.flat(t, 1), {
        1, 2, 3, 4, 5, 6, { 7, 8, 9 }
    })

    -- it should flatten 2 layers
    luaunit.assertEquals(candle.flat(t, 2), {
        1, 2, 3, 4, 5, 6, 7, 8, 9
    })

    -- it should flatten entire table and not error even if depth is greater than table layers
    luaunit.assertEquals(candle.flat(t, 3), {
        1, 2, 3, 4, 5, 6, 7, 8, 9
    })
end

function testArrayNew()
    -- it should error when size argument is less than or equal to 0
    luaunit.assertError(candle.new(0))
    luaunit.assertError(candle.new(-1))

    -- it should create a table of size 5 and all elements are 'true'
    luaunit.assertEquals(candle.new(5, true), {
        true, true, true, true, true
    })

    -- it should create a 2d array with 5 rows of elements '{ true, true, true, true, true }'
    luaunit.assertEquals(candle.new(5, candle.new(5, true)), {
        { true, true, true, true, true },
        { true, true, true, true, true },
        { true, true, true, true, true },
        { true, true, true, true, true },
        { true, true, true, true, true },
    })
end


os.exit(luaunit.LuaUnit.run())