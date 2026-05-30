--------------------------------------------------------------------------------
--- SQLite3 database support
--- LuaSTG Retro built-in module
--------------------------------------------------------------------------------

---@diagnostic disable: missing-return

---@alias sqlite.openmode '"r"' | '"readonly"' | '"rw"' | '"readwrite"' | '"rwc"' | '"create"' | '"readwrite_create"'
---@alias sqlite.value nil | boolean | number | string | sqlite.null
---@alias sqlite.params sqlite.value[]
---@alias sqlite.row table<string, sqlite.value>

---@class sqlite.null : userdata

---@class sqlite.database
local database = {}

--- Close the database handle.
---
--- Calling close more than once is valid. Methods other than isOpen will raise an error
--- after the database is closed.
function database:close()
end

--- Returns whether the database handle is still open.
---@return boolean
function database:isOpen()
end

--- Execute a SQL statement and return true when it succeeds.
---
--- Parameters are positional and are bound to '?' placeholders. Use sqlite.null
--- when a parameter should be SQL NULL.
---@param sql string
---@param params sqlite.params
---@return boolean
---@overload fun(self:sqlite.database, sql:string):boolean
function database:exec(sql, params)
end

--- Execute a SQL query and return all rows.
---
--- Each row is a table keyed by column name. SQL NULL values are returned as
--- sqlite.null because Lua table fields cannot store nil.
---@param sql string
---@param params sqlite.params
---@return sqlite.row[]
---@overload fun(self:sqlite.database, sql:string):sqlite.row[]
function database:query(sql, params)
end

--- Run a function inside a transaction.
---
--- The transaction commits when the callback returns normally. If the callback
--- raises an error, the transaction rolls back and the error is re-raised.
---@generic T...
---@param callback fun(db:sqlite.database):T...
---@return T...
function database:transaction(callback)
end

---@class sqlite
local M = {}
sqlite = M

--- SQL NULL sentinel used for parameter binding and query results.
---@type sqlite.null
M.null = nil

--- SQLite library version string.
---@type string
M.version = ""

--- SQLite numeric version.
---@type integer
M.versionNumber = 0

--- Open a SQLite database.
---
--- Default mode is read/write/create. The path is a normal operating-system
--- filesystem path, not a LuaSTG resource package path.
---@param path string
---@param mode sqlite.openmode
---@return sqlite.database
---@overload fun(path:string):sqlite.database
function M.open(path, mode)
end

--------------------------------------------------------------------------------
--- Sample

--[[

local sqlite = require("sqlite")

local db = sqlite.open("save/player.db")
db:exec("CREATE TABLE IF NOT EXISTS scores(name TEXT, score INTEGER, note TEXT)")
db:exec("INSERT INTO scores VALUES (?, ?, ?)", { "player", 100, sqlite.null })

local rows = db:query("SELECT name, score, note FROM scores")
for _, row in ipairs(rows) do
    if row.note == sqlite.null then
        print(row.name, row.score, "no note")
    end
end

db:transaction(function(tx)
    tx:exec("UPDATE scores SET score = ? WHERE name = ?", { 200, "player" })
end)

db:close()

--]]

return M
