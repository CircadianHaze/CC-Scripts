local d = peripheral.find("playerDetector")

local cachedPlayers = {}


function formatDateTime(isoString)
    -- Pattern to extract date and time parts
    local year, month, day, hour, minute, second = isoString:match("(%d+)-(%d+)-(%d+)T(%d+):(%d+):(%d+)")

    -- Format the string in a more readable form
    return string.format("%s-%s-%s %s:%s:%s", year, month, day, hour, minute, second)
end


local function getTime()
    
    local url = "http://worldtimeapi.org/api/timezone/America/Denver"
    local response = http.get(url)

    if response then
        local timeData = response.readAll()
        response.close()
        
        -- Parsing the JSON response (assuming the API returns JSON data)
        -- You might need a JSON parsing library if working with complex data
        local timeTable = textutils.unserializeJSON(timeData)
        
        -- Extracting date and time
        local datetime = timeTable.datetime
        return formatDateTime(datetime)
    else
        print("Failed to get the date and time.")
    end
end


local function getPlayers(range)

    local players = d.getPlayersInRange(range)
    return players

end


local function getPlayers(range)
    local players = d.getPlayersInRange(range)
    return players
end


while true do 
    local playerList = getPlayers(16)

    for _, player in ipairs(playerList) do
        local playerFound = false

        for _, cachedPlayer in ipairs(cachedPlayers) do     
            if player == cachedPlayer then
                playerFound = true                        -- we already have a player we found in the cache
                --print("Found Match: " .. player)
                break
            end
        end

        if not playerFound then
            table.insert(cachedPlayers, player)            -- we found a new player and added it to the cache
            --print("Added to cache: " .. player) 
            
            if player ~= "Echo_Hawk" then
                local file = fs.open("log.txt", "a")
                file.write(player .. " " .. getTime() .. "\n")  
                file.close()
            end
        end
    end

    if #cachedPlayers > #playerList then     -- check if the lists match
                
        local playerDict = {}
        for _, player in ipairs(playerList) do
            playerDict[player] = true
        end

        
        local z = 1
        while z <= #cachedPlayers do
            local cachedPlayer = cachedPlayers[z]
            if not playerDict[cachedPlayer] then
                table.remove(cachedPlayers, z)
                --print("Removed from cache: " .. cachedPlayer)
            else
                z = z + 1
            end
        end

    end
    
    sleep(1)  
end


