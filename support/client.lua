RegisterNetEvent("support:openMenu")
AddEventHandler("support:openMenu", function()
    local input = exports.ox_lib:inputDialog('Support Request', {
        { type = 'input', label = 'Reason for Support', placeholder = 'Describe your issue...', required = true }
    })

    if input then
        local reason = input[1]
        if reason and reason ~= '' then
            TriggerServerEvent("support:createTicket", GetPlayerServerId(PlayerId()), reason)
        else
            exports.ox_lib:notify({
                title = "Error",
                description = Config.Messages.errorInputReason,
                type = "error"
            })
        end
    else
        exports.ox_lib:notify({
            title = "Cancelled",
            description = Config.Messages.cancelSupportRequest,
            type = "error"
        })
    end
end)
