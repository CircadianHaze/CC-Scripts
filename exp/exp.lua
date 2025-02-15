local tank = peripheral.find("fluidTank")

redstone.setOutput("right", false)
local number = 0
local CURRENT_LEVEL = 0
local function getAmount()
    if peripheral.isPresent("top") then
        
        if tank.getInfo() then
            local info = tank.getInfo()
        end
        
    else
        return 5000000
    end
    
    if info then
        local amount = info.amount
        return amount
    else
        --redstone.setOutput("right", false)
        --error("tank not found")
        return 5000000
    end


end

local function getCapacity()

    local info = tank.getInfo()
    local capacity = tank.capacity
    return capacity

end

--[[
local function calculateLevel()   --Calculates amount of levels in tank

    local total = info.amount
    local level = 0

    if total > 1507 then
        level = (325 / 18) + math.sqrt((2 / 9) * (total - (54215 / 72)))
        return level

    elseif total > 352 then
        level = (81 / 10) + math.sqrt((2 / 5) * (total - (7839 / 40)))
        return level
    elseif total > 0 then
        level = math.sqrt(total + 9) - 3
        return level
    else
        return level
    end

end
--]]
local function calculateFromLevel(level) --revise this
    print("Level in CFL: " .. level)
    local totalExperience = 0

    if level >= 0 and level <= 16 then
        totalExperience = level^2 + 6 * level
    elseif level >= 17 and level <= 31 then
        totalExperience = 2.5 * level^2 - 40.5 * level + 360
    elseif level >= 32 then
        totalExperience = 4.5 * level^2 - 162.5 * level + 2220
    end
    print(totalExperience)
    return totalExperience

end

local function getRemaining(desiredLevel, currentLevel)

    local desired = calculateFromLevel(desiredLevel)
    local current = calculateFromLevel(currentLevel)
    return desired - current

end

local function giveLevel(amount, level)

    local toGive = getRemaining(amount, level)  -- toGive is the amount to give in mb
    local currentAmount = getAmount()
    local leftover = currentAmount - toGive   --predicted amount that will be left after

    if currentAmount >= toGive then
        redstone.setOutput("right", true)
        
        while getAmount() > leftover do
            print(getAmount() - leftover)
            -- Loop will continue until the amount is less than or equal to leftover
        end

        redstone.setOutput("right", false)  -- Turn off the output after the loop ends
    else 
        print("Not enough in storage.")
    end
end






print("What level do you want?: ")
local desiredLevel = io.read()
number = tonumber(desiredLevel)

print("What level are you?: ")
local current_player_level = io.read()
CURRENT_LEVEL = tonumber(current_player_level)

if number then
    giveLevel(number, CURRENT_LEVEL)
    print(number)
else
    print("Invalid input...")
end

print("done")


redstone.setOutput("left", false)
