-- Loads Surface 2.
-- Change this path to wherever the Surface 2 file is.
local surface = dofile("surface") 
local monitor = peripheral.find("monitor")
local detector = peripheral.find("playerDetector")

monitor.clear()
monitor.setTextScale(0.5)
local surf = surface.create(monitor.getSize())


-- Coordinates of desired world Origin
local modifiedOriginX = 994
local modifiedOriginZ = 636
local scale = 150 
-- scale 2 experimental 
local scale2 = 4   

--surf:drawLine(60, 0, 60, 81, colors.white)
--surf:drawLine(0, 40, 121, 40, colors.white)
--surf:drawPixel(60, 40, colors.red) -- Origin
--surf:drawPixel(120, 80, colors.red)

local function drawFromCoords(x, z, name)

    local inX = math.floor(((math.floor(x)) - modifiedOriginX) / scale) + 60
    local inZ = math.floor(((math.floor(z)) - modifiedOriginZ) / scale) + 40

    surf:drawPixel(inX, inZ + 1, colors.blue)
    surf:drawString(name .. " x= " .. x .. " z= " .. z, inX + 2, inZ + 1)


end




while true do

    --monitor.setTextScale(0.5)
    
    local players = detector.getOnlinePlayers()
    local playerCoords = {}
    
    
    --surf:drawLine(60, 0, 60, 81, colors.white)
    --surf:drawLine(0, 40, 121, 40, colors.white)
    --surf:drawPixel(60, 40, colors.red) -- Origin
    
    

    
    surf:output(monitor)
    surf:clear(colors.black)

    

     -- Loop to fill table with player information
    --for i = 1, #players do
    --    playerCoords[i] = detector.getPlayerPos(players[i])
    --end  
    for i = 1, #players do
        local pos = detector.getPlayerPos(players[i])
        if pos and pos.x and pos.y and pos.z and pos.dimension then  -- Ensure all required fields are present
            playerCoords[i] = pos
        else
            playerCoords[i] = nil  -- Mark as invalid or incomplete data
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
            
            --if stament might go here
                --Draw map information 
                
                --surf:drawPixel(120, 80, colors.red)
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
