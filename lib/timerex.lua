-- timerEx 2020 by MikuAuahDark
-- A rewrite of my 7-year-old timerEx 4.0
-- The old can be found here
-- https://www.unrealsoftware.de/files_show.php?file=13759
--[[---------------------------------------------------------------------------
-- Copyright (c) 2020 Miku AuahDark
--
-- Permission is hereby granted, free of charge, to any person obtaining a
-- copy of this software and associated documentation files (the "Software"),
-- to deal in the Software without restriction, including without limitation
-- the rights to use, copy, modify, merge, publish, distribute, sublicense,
-- and/or sell copies of the Software, and to permit persons to whom the
-- Software is furnished to do so, subject to the following conditions:
--
-- The above copyright notice and this permission notice shall be included in
-- all copies or substantial portions of the Software.
--
-- THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS
-- OR IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
-- FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE
-- AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
-- LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING
-- FROM, OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER
-- DEALINGS IN THE SOFTWARE.
--]]---------------------------------------------------------------------------

local random, concat, traceback = math.random, table.concat, debug.traceback
local xpcall, unpack, select, loadstring = xpcall, unpack, select, loadstring
local assert, print, timer, freetimer = assert, print, _G.timer, _G.freetimer

local active = {}
local xpcallArg = nil
local validChars = "_0123456789"..
	"ABCDEFGHIJKLMNOPQRSTUVWXYZ"..
	"abcdefghijklmnopqrstuvwxyz"

-- Helper function to generate random function
local function genTempFuncName()
	local tmpfunc = {"_timerEx_"}
	for _ = 1, 8 do
		local i = random(1, #validChars)
		tmpfunc[#tmpfunc + 1] = validChars:sub(i, i)
	end

	return concat(tmpfunc)
end

local function resolveFunction(func)
	local result = loadstring("return "..func)

	if result then
		return result()
	end

	return nil
end

local function handleXpcall()
	return xpcallArg[1](unpack(xpcallArg[2]))
end

local function handle(id)
	-- Retrieve data
	local data = assert(active[id], id)

	-- Call handler
	xpcallArg = data
	local result, msg = xpcall(handleXpcall, traceback)

	if result == false then
		-- Print error message
		-- FIXME: Should we stop the timer in this case?
		print("\169255000000"..msg)
	end

	-- Decrease counter
	data[3] = data[3] - 1
	if data[3] == 0 then
		-- Cleanup
		active[id] = nil
	end
end

local function timerEx(ms, func, count, ...)
	-- Check if this function is called by the actual "timer" function
	if type(ms) == "string" and func == nil and ms:sub(1, 9) == "_timerEx_" then
		-- Call handle function
		return handle(ms)
	end

	-- "count" defaults to 1
	count = count or 1
	-- "count" < 0 means infinite times
	if count == 0 then count = -1 end

	-- Resolve function
	if type(func) == "string" then
		-- Function is in global table namespace
		func = assert(resolveFunction(func), "unable to access function")
	end

	-- Generate random function name
	local id = genTempFuncName()

	-- Add to active timer
	-- active[id] = {
	--     [1] = function
	--     [2] = table of function arguments
	--     [3] = timer count
	-- }
	active[id] = {func, {...}, count}

	timer(ms, "timerEx", id, count)
	return id
end

local function freetimerEx(id)
	if active[id] then
		-- Abort timer and clean up
		freetimer("timerEx", id)
		active[id] = nil
		return true
	end

	-- Not found
	return false
end

-- Because backward compatibility is nice
_G.timerEx = timerEx
_G.freetimerEx = freetimerEx

-- For you "require" users:
-- It will return table with these fields
-- new: new timer, argument same as old timerEx function
-- free: free timer, argument same as freetimerEx function
return setmetatable({
	new = timerEx,
	free = freetimerEx
}, {
	__call = function(...)
		return timerEx(select(2, ...))
	end
})