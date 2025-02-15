local Turtle = require("turtle")

local blocks_to_mine = {
    [ 'minecraft:iron_ore'          ] = true,
    [ 'minecraft:diamond_ore' ] = true,
    [ 'minecraft:coal_ore'         ] = true,
    [ 'minecraft:gold_ore' ] = true, 
    [ 'minecraft:deepslate_gold_ore' ] = true,
    [ 'minecraft:deepslate_diamond_ore' ] = true,
    [ 'minecraft:deepslate_emerald_ore' ] = true,
    [ 'minecraft:deepslate_iron_ore' ] = true,
    [ 'minecraft:deepslate_coal_ore' ] = true,
    [ 'minecraft:emerald_ore' ] = true,
    [ 'minecraft:deepslate_redstone_ore' ] = true,
    [ 'minecraft:redstone_ore' ] = true, 
}

local function up()
    while not turtle.up() do
        turtle.digUp()
    end   
    Turtle.dig_vein(blocks_to_mine)
end

local function forward() 
    while not turtle.forward() do
        turtle.dig()        
    end
    Turtle.dig_vein(blocks_to_mine)
end

local function down()
    while not turtle.down() do 
        turtle.digDown()
    end
    Turtle.dig_vein(blocks_to_mine)
end

--turn 180
local function turnAround()
    turtle.turnLeft()
    turtle.turnLeft()
end

local function fuel()
    turtle.refuel() 
    print(turtle.getFuelLevel())
end
   
local function onlyForward()
    while not turtle.forward() do
        turtle.dig()
    end
end

return { forward = forward, up = up, down = down, turnAround = turnAround, fuel = fuel, onlyForward = onlyForward }

