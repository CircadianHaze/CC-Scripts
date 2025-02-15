local url = "http://worldtimeapi.org/api/timezone/America/Denver"
local response = http.get(url)


function formatDateTime(isoString)
    -- Pattern to extract date and time parts
    local year, month, day, hour, minute, second = isoString:match("(%d+)-(%d+)-(%d+)T(%d+):(%d+):(%d+)")

    -- Format the string in a more readable form
    return string.format("%s-%s-%s %s:%s:%s", year, month, day, hour, minute, second)
end


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
    print(formatDateTime(datetime))
else
    print("Failed to get the date and time.")
end

