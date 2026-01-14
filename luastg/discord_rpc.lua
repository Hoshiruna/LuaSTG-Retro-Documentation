---@diagnostic disable: missing-return, duplicate-set-field

--------------------------------------------------------------------------------
--- Discord Rich Presence (discord-rpc)
--------------------------------------------------------------------------------
--- usage
--------------------------------------------------------------------------------

--- 1. Set LUASTG_DISCORD_RPC_ENABLE=ON and LUASTG_DISCORD_RPC_APP_ID.
--- 2. Require the module and pick the table:
---    local rpc = lstg.DiscordPRC or lstg.DiscordRPC
--- 3. Call rpc.IsEnabled() before sending presence data.
--- 4. Build a presence table and call rpc.UpdatePresence(presence).
--- 5. Call rpc.ClearPresence() when the game exits.

--------------------------------------------------------------------------------
--- supported interfaces
--------------------------------------------------------------------------------

--- - lstg.DiscordRPC
--- - lstg.DiscordPRC (alias)
--- - lstg.DiscordRPC.UpdatePresence(presence)
--- - lstg.DiscordRPC.ClearPresence()
--- - lstg.DiscordRPC.IsEnabled()
--- - lstg.DiscordRPC.RichPresence fields:
---   state, details, startTimestamp, endTimestamp, largeImageKey, largeImageText,
---   smallImageKey, smallImageText, partyId, partySize, partyMax, partyPrivacy,
---   matchSecret, joinSecret, spectateSecret, instance

--------------------------------------------------------------------------------
--- lstg.DiscordRPC
--------------------------------------------------------------------------------

---@class lstg.DiscordRPC
local M = {}

---@class lstg.DiscordRPC.RichPresence
---@field state string|nil
---@field details string|nil
---@field startTimestamp integer|nil
---@field endTimestamp integer|nil
---@field largeImageKey string|nil
---@field largeImageText string|nil
---@field smallImageKey string|nil
---@field smallImageText string|nil
---@field partyId string|nil
---@field partySize integer|nil
---@field partyMax integer|nil
---@field partyPrivacy integer|nil
---@field matchSecret string|nil
---@field joinSecret string|nil
---@field spectateSecret string|nil
---@field instance integer|nil

--- Update the current Discord Rich Presence payload.
---@param presence lstg.DiscordRPC.RichPresence
function M.UpdatePresence(presence)
end

--- Clear any existing Rich Presence.
function M.ClearPresence()
end

--- Whether Discord RPC support is compiled into this build.
---@return boolean
function M.IsEnabled()
end

return M
