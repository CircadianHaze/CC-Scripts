local usefulFunctions = require("usefulFunctions")

local howLong = 0
local howWide = 0
local theCount = 0
local wideCount = 0

local function mine_up_down()
    turtle.digUp()
    turtle.digDown()
end

local function turnCornerRight()
    turtle.turnRight()
    usefulFunctions.onlyForward()
    turtle.turnRight()
end

local function turnCornerLeft()
    turtle.turnLeft()
    usefulFunctions.onlyForward()
    turtle.turnLeft()
end

local function mineIt()
    mine_up_down()
    for i = 1, howWide do
        for j = 1, howLong - 1 do
            usefulFunctions.onlyForward()
            mine_up_down()
        end
        
        wideCount = wideCount + 1

        if theCount == 1 and wideCount < howWide then
            turnCornerLeft()
            mine_up_down()
            theCount = theCount - 1        
        else if theCount == 0 and wideCount < howWide then
            turnCornerRight()
            mine_up_down()
            theCount = theCount + 1
        else  
            print("error ")
        end

    end
end
end

print("How long? ")
howLong = tonumber(read())
print("how Wide? ")
howWide = tonumber(read())

mineIt()




