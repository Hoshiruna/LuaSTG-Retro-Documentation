---@diagnostic disable: missing-return

--------------------------------------------------------------------------------
--- Discord Rich Presence
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

--- Update Discord Rich Presence
---@param presence lstg.DiscordRPC.RichPresence
function M.UpdatePresence(presence)
end

--- Clear Discord Rich Presence
function M.ClearPresence()
end

--- Discord Rich Presence status
---@return boolean
function M.IsEnabled()
end

return M
