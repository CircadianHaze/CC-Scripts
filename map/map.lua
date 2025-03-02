local surface = dofile("surface") 
local monitor = peripheral.find("monitor")
local detector = peripheral.find("playerDetector")

monitor.clear()
monitor.setTextScale(0.5)
local surf = surface.create(monitor.getSize())

-- Coordinates of desired world Origin
local modifiedOriginX = 994
local modifiedOriginZ = 636
-- adjust as needed (higher values increase scope, lower values decrese scope)
local scale = 150 

-- scale 2 experimental 
local scale2 = 4   

local function drawFromCoords(x, z, name)

    local inX = math.floor(((math.floor(x)) - modifiedOriginX) / scale) + 60
    local inZ = math.floor(((math.floor(z)) - modifiedOriginZ) / scale) + 40

    surf:drawPixel(inX, inZ + 1, colors.blue)
    surf:drawString(name .. " x= " .. x .. " z= " .. z, inX + 2, inZ + 1)

end

while true do
    
    local players = detector.getOnlinePlayers()
    local playerCoords = {}
        
    surf:output(monitor)
    surf:clear(colors.black)

    for i = 1, #players do
        local pos = detector.getPlayerPos(players[i])
        if pos and pos.x and pos.y and pos.z and pos.dimension then
            playerCoords[i] = pos
        else
            playerCoords[i] = nil 
        end
    end
    
    -- Loop to get player information and draw to Monitor
    for i = 1, #players do    
        if playerCoords[i] then
            local theY = math.floor(playerCoords[i]['y'])
            
            -- working modifier 
            local theX = math.floor(((math.floor(playerCoords[i]['x'])) - modifiedOriginX) / scale) + 60
            local theZ = math.floor(((math.floor(playerCoords[i]['z'])) - modifiedOriginZ) / scale) + 40

            local realX =  math.floor(playerCoords[i]['x'])
            local realY =  math.floor(playerCoords[i]['y'])
            local realZ =  math.floor(playerCoords[i]['z'])
           
            local theDimension = playerCoords[i]['dimension'] 
            local _, position = string.find(theDimension, ":")
            local newDimension = string.sub(theDimension, position + 1)
            print(theX .. " z: ".. theZ)

            surf:drawPixel(theX, theZ, colors.red)
            surf:drawString(players[i] .. " y= " .. theY, theX + 2, theZ)

            drawFromCoords(4198, 119, "Justin's House")
            drawFromCoords(993, 639, "Spawn")
            drawFromCoords(-399, 2449, "Tea's House")
            drawFromCoords(3239, 888, "Kiddin's House")
            drawFromCoords(156, 947, "Mob Grinder")

            --Draw static player information
            surf:drawString(players[i] .. ": " .. "x:" .. realX .. " y:" .. realY .. " z:" .. realZ .. " " .. newDimension, 1, i)
        end
    end
end

os.pullEvent("mouse_click")
