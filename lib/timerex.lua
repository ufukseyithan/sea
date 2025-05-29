-- timerEx 2025 by MikuAuahDark
-- A rewrite of my timerEx 2020 using CS2D 1.0.1.6 `frame` hook.
-- The old can be found here:
-- * https://gist.github.com/MikuAuahDark/3cf5daf77901d2b8370c30e010e0f092 (timerEx 2020)
-- * https://www.unrealsoftware.de/files_show.php?file=13759 (timerEx 4.0, before timerEx 2020)
--[[---------------------------------------------------------------------------
-- Copyright (c) 2025 Miku AuahDark
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

if game("version") < "1.0.1.6" then
	error("please use timerEx 2020 for CS2D < 1.0.1.6")
end

local debug_traceback = debug.traceback
local math_max = math.max
local math_floor = math.floor
local pairs = pairs
local print = print
local tostring = tostring
local type = type
local unpack = _G.unpack

local modulename = ... -- just used to test if it's loaded through `require`.

if _G.timerEx and _G.freetimerEx then
	if modulename then
		print("\169255000000Warning: Using global `timerEx` for timerEx module \""..modulename.."\", this is may not what you want!")
	else
		print("\169255000000Warning: Another `timerEx` has been loaded, this is may not what you want!")
	end

	local tex, ftex = timerEx, freetimerEx
	local module = setmetatable({
		new = tex,
		free = ftex
	}, {
		__call = function(...)
			return tex(select(2, ...))
		end
	})
	if false then
		---@diagnostic disable-next-line: cast-local-type
		module = tex
	end
	return module
end

---@type table<string,timerEx._info>
local timers = {} -- Yes, this also contains the reverse mapping of id <-> integers.

-- Some xpcall hack to allow passing arguments to the target function.
local myxpcall
if jit then
	-- LuaJIT has this built-in.
	myxpcall = xpcall
else
	local xpcallargs = {}
	local function xpcallhandler()
		return xpcallargs[1](unpack(xpcallargs, 2))
	end

	function myxpcall(f, msgh, ...)
		xpcallargs = {f, ...}
		return xpcall(xpcallhandler, msgh)
	end
end

local function resolveFunction(func)
	local chunk = loadstring("return "..tostring(func))
	local result = nil

	if chunk then
		local a, b = pcall(chunk)
		if a and type(b) == "function" then
			result = b
		end
	end

	return result
end



---Delay an execution of a function `func` by specified amount of milliseconds.
---
---**Note**: This function does not check if equal timers already exist. It always create new timer whenever you call this function. This can lead to multiple exactly equal timers.
---@param t number Delay of the timer, in milliseconds.
---@param func function|string Function to call with delay.
---@param count integer? How many times the timer should be executed? If left out, defaults to 1. 0 or negative means run the function with delay infinitely until removed with `freetimerEx`.
---@param ... any Additional arguments to pass to `func` when it's called.
---@return any @Identifier of the timer, can be used with `freetimerEx` to cancel the timer. The type of the identifier is implementation-detail but this always returns a truth value.
local function timerEx(t, func, count, ...)
	local target = nil
	if type(func) == "function" then
		target = func
	else
		target = resolveFunction(func)
	end
	assert(target, "bad argument #1 to 'timerEx' (expected function)")

	---@class timerEx._info
	local tinfo = {
		elapsed = 0,
		delay = t / 1000,
		func = target,
		args = {...},
		count = math_floor(count or 1)
	}
	local id = tostring(tinfo)
	timers[id] = tinfo
	return id
end

---Cancels a time with specified identifier.
---
---Identifier are intentionally annotated as `any` type as the type of the identifier is considered implementation-detail.
---@param id any Identifier of the timer returned by `timerEx` function.
---@return boolean @`true` if the timer exist and freed, `false` otherwise.
local function freetimerEx(id)
	local exist = not not timers[id]
	timers[id] = nil
	return exist
end

if not modulename then
	-- Set global variables if loaded with e.g. `dofile("sys/lua/timerEx.lua")` or placed in `sys/lua/autorun`.
	_G.timerEx = timerEx
	_G.freetimerEx = freetimerEx
end



local globalFrameHandler = string.format("__timerEx_%04x_%04x_%04x_%04x__",
	math.random(0, 65535),
	math.random(0, 65535),
	math.random(0, 65535),
	math.random(0, 65535)
)
addhook("frame", globalFrameHandler)
---@param dt number
rawset(_G, globalFrameHandler, function(dt)
	for tid, tinfo in pairs(timers) do
		tinfo.elapsed = tinfo.elapsed + dt

		while tinfo.elapsed >= tinfo.delay do
			local result, msg = myxpcall(tinfo.func, debug_traceback, unpack(tinfo.args))
			if not result then
				print("\169255000000"..msg)
			end

			tinfo.elapsed = tinfo.elapsed - tinfo.delay
			tinfo.count = math_max(tinfo.count - 1, -1)
			if tinfo.count == 0 then
				freetimerEx(tid)
				break
			end
		end
	end
end)



-- For you "require" users:
-- It will return table with these fields:
-- * `new`: new timer, argument same as old `timerEx` function
-- * `free`: free timer, argument same as `freetimerEx` function
local module = setmetatable({
	new = timerEx,
	free = freetimerEx
}, {
	__call = function(...)
		return timerEx(select(2, ...))
	end
})
if false then
	---@diagnostic disable-next-line: cast-local-type
	module = timerEx
end
return module