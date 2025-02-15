local geoScanner = peripheral.find("geoScanner")
local three_d_space = require("three_d_space")

local blocks = {
    ["minecraft:ancient_debris"] = true,
    ["minecraft:emerald_ore"] = true,
    ["minecraft:deepslate_emerald_ore"] = true,
    ["minecraft:diamond_ore"] = true,
    ["minecraft:deepslate_diamond_ore"] = true,
    ["minecraft:gold_ore"] = true,
    ["minecraft:deepslate_gold_ore"] = true,
    ["minecraft:iron_ore"] = true,
    ["minecraft:deepslate_iron_ore"] = true,
    ["minecraft:coal_ore"] = true,
    ["minecraft:deepslate_coal_ore"] = true,
    ["minecraft:deepslate_redstone_ore"] = true,
    ["minecraft:redstone_ore"] = true,
    ["minecraft:copper_ore"] = true,
    ["minecraft:deepslate_copper_ore"] = true,
    ["create:zinc_ore"] = true,
    ["create:deepslate_zinc_ore"] = true,
    ["minecraft:deepslate_lapis_ore"] = true,
    ["minecraft:lapis_ore"] = true

}

local ITEM_DATA = {
    ["minecraft:ancient_debris"] = true,
    ["minecraft:emerald"] = true,
    ["minecraft:diamond"] = true,
    ["minecraft:gold_ore"] = true,
    ["minecraft:raw_gold"] = true,
    ["minecraft:raw_iron"] = true,
    ["minecraft:coal"] = true,
    ["minecraft:redstone"] = true,
    ["minecraft:raw_copper"] = true,
    ["create:raw_zinc"] = true,
    ["minecraft:lapis_lazuli"] = true

}

local scanData, err = geoScanner.scan(16)
local outerTable = {}




for i, block in ipairs(scanData) do
    if blocks[block.name] then
        -- Create a new table for each block's coordinates
        local blockCoords = { x = block.x, y = block.y, z = block.z }
        table.insert(outerTable, blockCoords)
    end
end


function printTable(t)
    for k, v in ipairs(t) do
        local line = ""
        for i, j in pairs(v) do
            line = line .. i .. " = " .. tostring(j) .. ", "
        end
        print("Table " .. k .. ": {" .. line .. "}")
    end
end

printTable(outerTable)

--[[
function garbageDisposal()
    
    turtle.select(1)

    for i = 1, 16 do
        turtle.select(i)
        local data = turtle.getItemDetail()
        if data then
            if blocks[data.name] then
                -- we don't want to do anything here
            end
        else
            -- if item is not in blocks then get rid of it
            turtle.drop()

        end
        
    end

end
]]--
function garbageDisposal()
    for i = 1, 16 do
        turtle.select(i)
        local itemCount = turtle.getItemCount()  -- Check the number of items in the slot
        if itemCount > 0 then
            local data = turtle.getItemDetail()
            if data and not ITEM_DATA[data.name] then
                -- If item is not in blocks, get rid of it
                turtle.drop()
            end
        end
    end
end


function goMine(outerTable)

    for k, v in ipairs(outerTable) do
        if three_d_space.get_step_count() > 128 then
            garbageDisposal()
            three_d_space.reset_step_count()
        end 
        three_d_space.moveTo(v)
    end

end

print(scanData)
print(err)
goMine(outerTable)

three_d_space.returnTo()

