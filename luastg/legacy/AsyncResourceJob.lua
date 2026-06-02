--------------------------------------------------------------------------------
--- LuaSTG Retro 异步资源任务
--- Hoshiruna
--------------------------------------------------------------------------------

---@diagnostic disable: missing-return

---@alias lstg.AsyncResourceJobStatus '"queued"' | '"running"' | '"ready"' | '"done"' | '"failed"' | '"cancelled"'

---@class lstg.AsyncResourceJob
local M = {}

---返回任务状态
---@return lstg.AsyncResourceJobStatus
function M:status()
end

---任务是否已经结束
---@return boolean
function M:isDone()
end

---返回错误信息；任务没有错误时返回 nil
---@return string|nil
function M:error()
end

---读取任务结果
---文件读取任务成功时返回二进制字符串
---资源加载任务成功时返回 true
---未完成时返回 nil, "pending"
---失败或取消时返回 nil 和错误信息
---@return string|true|nil
---@return string|nil
function M:read()
end

---请求取消任务
---@return boolean
function M:cancel()
end

return M
