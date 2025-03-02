-- File meant to keep track of turtles position in 3-dimensions 
-- The turtles position is not relative to it's actual position in the game
local origin = {x = 0, y = 0, z = 0}
local position = {x = 0, y = 0, z = 0}
local orientation = "north"

local userLength = 0
local userWidth = 0
local userDepth = 0

local squareTable = { 0, 0, 0 }

local function moveUp()
   
    while not turtle.up() do
        turtle.digUp()
    end
    position.y = position.y + 1--position.z = position.z + 1

end

local function moveDown() 

    while not turtle.down() do 
        turtle.digDown()
    end
    position.y = position.y - 1--position.z = position.z - 1

end

local function moveForward()

    if orientation == "north" then
        position.z = position.z + 1--position.y = position.y + 1
    elseif orientation == "south" then
        position.z = position.z - 1--position.y = position.y - 1
    elseif orientation == "east" then
        position.x = position.x - 1
    elseif orientation =="west" then
        position.x = position.x + 1
    end

    while not turtle.forward() do
        turtle.dig()
    end

end

local function turnLeft()

    if orientation == "north" then
        orientation = "west"
    elseif orientation == "west" then
        orientation = "south"
    elseif orientation == "south" then
        orientation = "east"
    elseif orientation == "east" then
        orientation = "north"
    end
    turtle.turnLeft()
end

local function turnRight()

    if orientation == "north" then
        orientation = "east"
    elseif orientation == "east" then
        orientation = "south"
    elseif orientation == "south" then
        orientation = "west"
    else
        orientation = "north"
    end
    turtle.turnRight()
end


local function currentPosition()
    return {x = position.x, y = position.y, z = position.z}
end

local function faceNorth()
    while (orientation ~= "north") do
        turnLeft()
    end
end

--moveTo takes a table off coordinates and moves turtle where specified

local function moveTo(coordinates)

    local xDiff = coordinates.x - position.x
    local yDiff = coordinates.y - position.y
    local zDiff = coordinates.z - position.z 

    --If the difference in x is negative, move east
    if xDiff < 0 then
        while orientation ~= "east" do
            turnLeft()
        end
    
        for i = 1, math.abs(xDiff) do
            moveForward()
        end

    --If the difference in x is positive, move west
    elseif xDiff > 0 then
        while orientation ~= "west" do
            turnLeft()
        end
        for i = 1, xDiff do 
            moveForward()
        end
    end

    --if the difference in z is negative, move south 
    if zDiff < 0 then
        while orientation ~= "south" do
            turnLeft()
        end
        for i = 1, math.abs(zDiff) do
            moveForward()
        end
    --If the difference in z is positive, move north 
    elseif zDiff > 0 then
        while orientation ~= "north" do
            turnLeft()
        end
        for i = 1, zDiff do
            moveForward()
        end
    end

    --If the difference in y is negative, move down
    if yDiff < 0 then
        for i = 1, math.abs(yDiff) do
            moveDown()
        end


    --If the difference in y is posative, move up
    elseif yDiff > 0 then
        for i = 1, yDiff do 
            moveUp()
        end
    end

    faceNorth()

end

local function returnTo()
    moveTo(origin)
    faceNorth()
end

return {

    moveUp = moveUp,
    moveDown = moveDown,
    moveForward = moveForward,
    turnLeft = turnLeft,
    turnRight = turnRight,
    moveTo = moveTo,
    currentPosition = currentPosition,
    faceCardinal = faceCardinal,
    returnTo = returnTo
    
}