-- https://devforum.roblox.com/t/1883509/14

local CollectionService = game:GetService("CollectionService")
local TS = game:GetService("TextService")
local PS = game:GetService("Players")

local id = "editText"

local function DoFilter(speaker, message, channel)
	local convert = string.lower(message.Message)
	local filtered
	local player = PS:FindFirstChild(speaker)
	
	if CollectionService:HasTag(player, "pink") then
		local randomthings = {" :З", " UωU"}
		convert ..= randomthings[math.random(#randomthings)] -- uses the Cyrillic Ze since some fonts makes the 3 distinguishable from the cyrillic ze
		convert = convert:gsub("l", "w")
		convert = convert:gsub("r", "w")
	end

	local success, err = pcall(function()
		filtered = TS:FilterStringAsync(convert, player.UserId):GetNonChatStringForBroadcastAsync() -- filtered so roblox doesn't ban me
	end)

	if success and filtered then
		message.Message = filtered
	else
		warn(err)
	end
end

local function RunModule(CTS)
	CTS:RegisterFilterMessageFunction(id, DoFilter)
end

return RunModule
