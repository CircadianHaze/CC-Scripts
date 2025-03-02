local mon = peripheral.find("monitor")
local tank = peripheral.find("fluidTank")

mon.clear()
mon.setBackgroundColor(colors.black)
local myText = "Diff is the average change in mb per second."
local count = 0
local result = "calculating..."
local numbers = {}
local STARTING_AMOUNT = tank.getInfo()
local AMOUNT1 = STARTING_AMOUNT.amount

function wrapText(text, maxWidth)
    local lines = {}
    local line = ""
    for word in text:gmatch("%S+") do
        if #line + #word + 1 > maxWidth then
            table.insert(lines, line)
            line = word
        else
            line = (line == "" and word or line .. " " .. word)
        end
    end
    table.insert(lines, line)
    return lines
end

function writeToMonitor(text)
    mon.setTextColor(colors.green)
    local width, height = mon.getSize()
    local lines = wrapText(text, width)
    --mon.clear()
    for i, line in ipairs(lines) do
        if i > height then break end -- avoid writing beyond the monitor's height
        mon.setCursorPos(1, i + 4)
        mon.write(line)
    end
    mon.setTextColor(colors.white)
end
local function getStats()

    local info = tank.getInfo()
    return info

end

local function getPercentage()

    local theInfo = getStats()
    local theTotal = theInfo.capacity
        
    if theTotal ~= 0 then
        local theAmount = theInfo.amount   
        local percentage = (theAmount / theTotal) * 100
        local formatted = string.format( "%.1f%%", percentage)
        return formatted
    else
        return 0
    end
       
end

local function display(title, value, x, y)
    --mon.clear()
    mon.setCursorPos(x, y)
    mon.setTextColor(colors.blue)
    mon.write(title .. ": ")
    
    mon.setTextColor(colors.green)
    mon.write(value)

end

local function calculateLevel()

    local stats  = getStats()
    local total = stats.amount
    local level = 0

    if total > 1507 then
        level = (325 / 18) + math.sqrt((2 / 9) * (total - (54215 / 72)))
        local formatted = string.format( "%.1f", level)
        return formatted

    elseif total > 352 then
        level = (81 / 10) + math.sqrt((2 / 5) * (total - (7839 / 40)))
        local formatted = string.format( "%.1f", level)
        return formatted
    elseif total > 0 then
        level = math.sqrt(total + 9) - 3
        local formatted = string.format( "%.1f", level)
        return formatted
    else
        return level
    end

end

local function calculateRate(theList)
    local sum  = 0
    print("Here in calculateRate")
    for i = 1, #theList do
        sum = sum + theList[i]
    end
    
    local average = sum / #theList
    local formatted = string.format( "%.1f", average)
    
    
    numbers = {}
    return formatted
end

while true do 
      
    if #numbers > 20 then
        result = calculateRate(numbers)
    end
    
    local percentageLoop = getPercentage()
    local levelLoop = calculateLevel()
    local count = count + 1
    local difference = 0
    local infoLoop = getStats()
    local amount2 = infoLoop.amount
    
    sleep(1)
    local theInfo = getStats()
    amount1 = theInfo.amount
    difference = amount1 - amount2

    mon.clear()
    
    display("Average Diff", result, 1, 3)
    display("percentage", percentageLoop, 1, 1)
    display("levels stored", levelLoop, 1, 2)
    writeToMonitor(myText)
    table.insert(numbers, difference)

end
