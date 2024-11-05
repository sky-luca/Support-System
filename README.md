# Support Ticket System for FiveM

## Overview
The Support Ticket System is a robust script designed for FiveM, allowing players to submit support requests and team members to manage these tickets efficiently. This system integrates with Discord for logging support requests and notifications.

## Features
- Players can open support tickets with a specified reason.
- Team members can claim support tickets and notify other team members.
- Integration with Discord to log support requests and ticket claims.
- Easy-to-use client-side menu for submitting support tickets.

## Requirements
- FiveM server
- `ox_lib` library for input dialogs and notifications
- A Discord webhook URL for logging messages

## Installation
1. **Download the Script:**
   - Clone or download this repository to your FiveM resources folder.

2. **Add the Resource:**
   - In your `server.cfg`, add the following line:
     ```
     start your_script_name
     ```

3. **Configure the Webhook URL:**
   - Open `config.lua` and replace `DISCORD_WEBHOOK_URL` with your actual Discord webhook URL.

4. **Set Up Permissions:**
   - Modify the `Config.PermissionGroups` in `config.lua` to fit your server's permission structure.
   - Ensure team members have the necessary ACE permissions to use the support system.

## How to Use
### For Players
1. **Open Support Menu:**
   - Use the command `/support` in-game to open the support request menu.
  
2. **Submit a Ticket:**
   - Provide a reason for your support request in the dialog box that appears.

### For Team Members
1. **Claim a Ticket:**
   - Use the command `/claim <SupportID>` to claim an open support ticket.
  
2. **Notifications:**
   - Team members will receive notifications about new support requests and claims.

## Code Explanation
### Server-side (`server.lua`)
- **Support Command:** Allows players to open the support menu.
- **Ticket Creation:** Listens for ticket creation requests, logs them to Discord, and notifies team members.
- **Claim Command:** Allows team members to claim tickets and notifies relevant parties.

### Client-side (`client.lua`)
- **Menu Handling:** Opens a dialog for players to input their support reason and sends it to the server.

### Configuration (`config.lua`)
- Contains all configurable parameters, including webhook URL and message templates.

## Important Messages
The following messages can be customized in the `config.lua`:
- `supportRequestTitle`: Title for support requests.
- `supportRequestDescription`: Description format for the support request notification.
- `claimNotificationTitle`: Title for ticket claim notifications.
- `claimNotificationDescription`: Description format for the ticket claim notification.
- `errorSupportNotFound`: Error message when a ticket is not found.
- `errorMissingSupportID`: Error message when no support ID is provided.
- `errorInputReason`: Error message when the support reason is missing.
- `cancelSupportRequest`: Message shown when a support request is cancelled.
