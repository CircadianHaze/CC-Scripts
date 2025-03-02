local mon = peripheral.find("monitor")
local accumulator = peripheral.find("modular_accumulator")

local secondEnergy = accumulator.getEnergy()
local counter = 0

mon.clear()
mon.setBackgroundColor(colors.black)

local myText = "Diff is the current FE change by second. Energy is the current stored FE amount."

local function writeColoredText(text, color)
    if color == "red" then
        mon.setTextColor(colors.red)
    elseif color == "green" then
        mon.setTextColor(colors.green)
    elseif color == "blue" then
        mon.setTextColor(colors.blue)
    else
        mon.setTextColor(colors.white)
    end
    mon.write(text)
    mon.setTextColor(colors.white)
end

local function thePercent()
    local percent = accumulator.getPercent()
    local formatted = string.format( "%.2f %%", percent)
    return formatted
end

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
    for i, line in ipairs(lines) do
        if i > height then break end -- Avoid writing beyond the monitor's height
        mon.setCursorPos(1, i + 4)
        mon.write(line)
    end
    mon.setTextColor(colors.white)
end

while true do
    
    local energyLoop = accumulator.getEnergy()
    local percentLoop = thePercent()
    sleep(3)
    secondEnergy = accumulator.getEnergy()

    -- Calculate the difference based on the previous energy reading
    local difference = 0
    difference = secondEnergy - energyLoop

    mon.clear()
    
    mon.setCursorPos(1, 1)
    writeColoredText("Electrical System Data", "red")
    
    mon.setCursorPos(1, 2)
    writeColoredText("Diff: ", "blue")
    writeColoredText(tostring(difference), "white")
    
    mon.setCursorPos(1, 3)
    writeColoredText("Energy: ", "blue")
    writeColoredText(tostring(energyLoop), "white")

    mon.setCursorPos(1, 4)
    writeColoredText("Percent: ", "blue")
    writeColoredText(tostring(percentLoop), "white")
    
    writeToMonitor(myText)
end







