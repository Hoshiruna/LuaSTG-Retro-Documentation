--------------------------------------------------------------------------------
--- LuaSQL SQLite3 support
--- LuaSTG Retro built-in module
--------------------------------------------------------------------------------

---@diagnostic disable: missing-return, duplicate-set-field

---@class luasql.sqlite3.driver
local M = {}

---@class luasql.sqlite3.environment
local environment = {}

---@class luasql.sqlite3.connection
local connection = {}

---@class luasql.sqlite3.cursor
local cursor = {}

--------------------------------------------------------------------------------
--- Driver

--- Create a SQLite3 environment.
---@return luasql.sqlite3.environment
function M.sqlite3()
end

--------------------------------------------------------------------------------
--- Environment

--- Open a SQLite3 database connection.
---
--- The path is a normal operating-system filesystem path, not a LuaSTG
--- resource package path. When `read_only` is true, the database is opened
--- read-only. `lock_timeout` is in milliseconds.
---@param path string
---@param lock_timeout number?
---@param read_only boolean?
---@return luasql.sqlite3.connection|nil
---@return string|nil
function environment:connect(path, lock_timeout, read_only)
end

--- Close the environment.
---@return boolean
---@return string|nil
function environment:close()
end

--------------------------------------------------------------------------------
--- Connection

--- Execute a SQL statement.
---
--- For statements that produce rows, returns a cursor. For statements that do
--- not produce rows, returns the number of changed rows.
---@param statement string
---@return luasql.sqlite3.cursor|number|nil
---@return string|nil
function connection:execute(statement)
end

--- Execute a SQL statement with positional parameters.
---@param statement string
---@vararg nil|boolean|number|string
---@return luasql.sqlite3.cursor|number|nil
---@return string|nil
function connection:execute(statement, ...)
end

--- Execute a SQL statement with parameters from a table.
---
--- Table keys may be positional integer indexes or SQLite named parameter
--- names, such as `":name"`.
---@param statement string
---@param parameters table<integer|string, nil|boolean|number|string>
---@return luasql.sqlite3.cursor|number|nil
---@return string|nil
function connection:execute(statement, parameters)
end

--- Close the connection.
---@return boolean
---@return string|nil
function connection:close()
end

--- Commit the current transaction.
---@return boolean|nil
---@return string|nil
function connection:commit()
end

--- Roll back the current transaction.
---@return boolean|nil
---@return string|nil
function connection:rollback()
end

--- Enable or disable auto-commit.
---@param enabled boolean
---@return boolean
function connection:setautocommit(enabled)
end

--- Escape a string for direct SQL text construction.
---@param value string
---@return string|nil
function connection:escape(value)
end

--- Return the last inserted row id.
---@return number
function connection:getlastautoid()
end

--------------------------------------------------------------------------------
--- Cursor

--- Fetch the next row.
---
--- Without a table argument, returns one value per column. With a table
--- argument, copies values into that table and returns it. `mode` controls
--- numeric keys (`"n"`), column-name keys (`"a"`), or both (`"an"`).
---@param row table?
---@param mode '"n"'|'"a"'|'"an"'?
---@return table|any|nil
function cursor:fetch(row, mode)
end

--- Close the cursor.
---@return boolean
---@return string|nil
function cursor:close()
end

--- Return column names.
---@return string[]
function cursor:getcolnames()
end

--- Return column types.
---@return string[]
function cursor:getcoltypes()
end

--------------------------------------------------------------------------------
--- Sample

--[[

local driver = require("luasql.sqlite3")

local env = assert(driver.sqlite3())
local conn = assert(env:connect("save/player.db"))

assert(conn:execute("CREATE TABLE IF NOT EXISTS scores(name TEXT, score INTEGER, note TEXT)"))
assert(conn:execute("INSERT INTO scores VALUES (?, ?, ?)", "player", 100, nil))

local cur = assert(conn:execute("SELECT name, score, note FROM scores"))
local row = {}
while cur:fetch(row, "a") do
    print(row.name, row.score, row.note)
end

cur:close()
conn:close()
env:close()

--]]

return M
