local supportTickets = {}
local ticketCounter = 0

RegisterCommand("support", function(source)
    local playerId = source
    TriggerClientEvent("support:openMenu", playerId)
end)

RegisterNetEvent("support:createTicket")
AddEventHandler("support:createTicket", function(playerId, reason)
    local playerName = GetPlayerName(playerId)
    ticketCounter = ticketCounter + 1
    local supportId = ticketCounter
    supportTickets[supportId] = { playerId = playerId, reason = reason, claimed = false }

    for _, teamPlayerId in ipairs(GetPlayers()) do
        if IsPlayerAceAllowed(teamPlayerId, "support.notify") then
            TriggerClientEvent("ox_lib:notify", teamPlayerId, {
                title = Config.Messages.supportRequestTitle,
                description = Config.Messages.supportRequestDescription:format(playerName, playerId, reason, supportId),
                type = "info",
                duration = 20000,
                position = "center-right"
            })
        end
    end

    sendDiscordLog("New Support Request", ("%s [%d] needs assistance with: %s\nSupport ID: %d"):format(playerName, playerId, reason, supportId))
end)

RegisterCommand("claim", function(source, args)
    local playerId = source
    if not args[1] then
        TriggerClientEvent("ox_lib:notify", playerId, {
            title = "Error",
            description = Config.Messages.errorMissingSupportID,
            type = "error",
            duration = 6500,
            position = "center-right"
        })
        return
    end

    local supportId = tonumber(args[1])
    if supportTickets[supportId] and not supportTickets[supportId].claimed then
        supportTickets[supportId].claimed = true
        local teamMemberName = GetPlayerName(playerId)
        local ticketPlayerId = supportTickets[supportId].playerId

        for _, teamPlayerId in ipairs(GetPlayers()) do
            if IsPlayerAceAllowed(teamPlayerId, "support.notify") then
                TriggerClientEvent("ox_lib:notify", teamPlayerId, {
                    title = Config.Messages.claimNotificationTitle,
                    description = Config.Messages.claimNotificationDescription:format(teamMemberName, supportId),
                    type = "success",
                    duration = 10000,
                    position = "center-right"
                })
            end
        end

        TriggerClientEvent("support:ticketClaimed", ticketPlayerId, teamMemberName)
        sendDiscordLog("Support Claimed", ("Support ID %d has been claimed by %s."):format(supportId, teamMemberName))
    else
        TriggerClientEvent("ox_lib:notify", playerId, {
            title = "Error",
            description = Config.Messages.errorSupportNotFound,
            type = "error",
            duration = 6500,
            position = "center-right"
        })
    end
end, true)

AddEventHandler("onResourceStart", function(resourceName)
    if GetCurrentResourceName() == resourceName then
        for _, group in ipairs(Config.PermissionGroups) do
            ExecuteCommand("add_ace group." .. group .. " support.notify allow")
        end
    end
end)

function sendDiscordLog(title, description)
    local embed = {
        {
            ["title"] = title,
            ["description"] = description,
            ["color"] = 3447003,
            ["footer"] = { ["text"] = "Support System" },
            ["timestamp"] = os.date("!%Y-%m-%dT%H:%M:%SZ")
        }
    }
    PerformHttpRequest(Config.WebhookURL, function(err, text, headers) end, "POST", json.encode({ embeds = embed }), { ["Content-Type"] = "application/json" })
end
