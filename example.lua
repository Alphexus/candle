local candle = require("candle")

candle.flat({1, { 2 , 3, { 5, 6 } }, 4}, 1).flat().filter(function(v) return v <= 3 end).print()

