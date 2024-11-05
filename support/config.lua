Config = {}

-- Webhook URL for Discord logging
Config.WebhookURL = "DISCORD_WEBHOOK_URL"

-- Message configurations
Config.Messages = {
    supportRequestTitle = "Support Request",
    supportRequestDescription = "Player %s [%d] needs help with: %s\nSupport ID: %d",
    claimNotificationTitle = "Support Claimed",
    claimNotificationDescription = "%s has claimed the support ticket with ID %d.",
    playerClaimNotification = "Your support ticket is now being handled by %s.",
    errorSupportNotFound = "Support ticket not found or already claimed.",
    errorMissingSupportID = "Please provide a support ID.",
    errorInputReason = "Please provide a reason for support.",
    cancelSupportRequest = "Support request has been cancelled."
}

-- Permission groups for team members
Config.PermissionGroups = { "admin", "superadmin", "mod", "supporter" }
