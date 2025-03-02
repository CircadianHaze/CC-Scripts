local usefulFunctions = require("usefulFunctions")

local function mineSegment()
    usefulFunctions.forward()
    turtle.digUp()
    usefulFunctions.down()
    turtle.digDown()
end

while true do
    mineSegment()
end
