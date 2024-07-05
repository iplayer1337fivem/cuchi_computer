Config = {}

-- JOIN MY DISCORD: https://discord.gg/qvFmwj2a2T

-- Shared
Config.Framework = "qbcore" -- esx/qbcore
Config.FrameworkResourceName = "qb-core" -- the framework resource name (e.g.: "es_extended" or "qb-core")
Config.FrameworkOptionalExportName = "" -- if you changed the function's name to get the object, place the new here

Config.Locale = "DA" -- EN/FR/ES/DA/DE

Config.UseItem = "laptop" -- set the item that will be used to display the interface (to disable it, let it empty)

Config.DataHeists = {
    Enabled = true,
    DisplayArea = true, -- display area on the map
    Reward = { 10000, 20000 }, -- random between [1] and [2]
    TypeOfDelay = "each", -- "each": one delay for each area OR "all": one delay for all areas
    Delay = 60, -- in minutes
    JobsToCall = { "police", "sheriff" }, -- jobs to send call when a heist is triggered
    Areas = {
        --[coords as vector3] = areaRadius in meters
        -- fleeca
        [vector3(149.9, -1040.46, 29.37)] = 14,
        [vector3(314.23, -278.83, 54.17)] = 14,
        [vector3(-350.8, -49.57, 49.04)] = 14,
        [vector3(-1213.0, -330.39, 37.79)] = 14,
        [vector3(246.64, 223.2, 106.29)] = 14,

        -- arcadius tower (area in parking)
        [vector3(-160.274, -606.16, 32.424)] = 50
    }
}

if IsDuplicityVersion() then
    Config.Functions = {
        ---Function that will return an identifier for the specified player
        ---@param src string
        ---@param playerObj table equals xPlayer for ESX and Player for QBCore
        ---@return string
        GetIdentifier = function(src, playerObj)
            local license, _ = string.gsub(GetPlayerIdentifierByType(src, "license"), "license:", "")
            return license

            -- example using multichar on QBCore (identifier based on the charid)
            -- return playerObj.PlayerData.citizenid
        end
    }
else
    Config.LaptopInVehicle = true -- make laptop usable or not in vehicles

    Config.UseProps = { -- list of props (empty to disable props)
        -- joaat("prop_laptop_01a")
    }
    Config.TargetSystem = true -- if true then you must have ox_target, if false prop interactions will be based on a zone check

    Config.UsablePositions = { -- positions where players can open a computer free to use
        vec3(1275.5, -1710.7, 54.8),
        vec3(1272.3, -1711.6, 54.8),
        vec3(2542.75, 2579.81, 38.5),
    }

    CustomDrawMarker = function(coords)
        DrawMarker(20, coords.x, coords.y, coords.z, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.25, 0.25, 0.25, 20, 20, 200, 100, true, true, 2, false, nil, nil, false)
    end

    CustomHelpNotification = function(text)
        AddTextEntry("computers:notif", text)
        BeginTextCommandDisplayHelp("computers:notif")
        EndTextCommandDisplayHelp(0, false, true, -1)
    end

    CustomNotification = function(text)
        BeginTextCommandThefeedPost("STRING")
        AddTextComponentSubstringPlayerName(text)
        EndTextCommandThefeedPostTicker(false, true)
    end
end
