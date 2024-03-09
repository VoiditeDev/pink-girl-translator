local Chat = game:GetService("Chat")
local CollectionService = game:GetService("CollectionService")
local Players = game:GetService("Players")
local isAdmin = require(script.isAdmin)
local Chance = require(script.Chance)

local pink_girls = {}

for _, pink_girl in script.Models.PinkGirls:GetChildren() do
	pink_girls[pink_girl] = 1
end

local pinkgirlrandom = Chance.fromResult(pink_girls)

Players.PlayerAdded:Connect(function(player)
	player.CharacterAdded:Connect(function(char)
		local humanoid = char.Humanoid
		
		humanoid.Died:Connect(function()
			CollectionService:RemoveTag(player, "pink")
		end)
	end)
	
	player.Chatted:Connect(function(message)
		local params = message:split(" ")
		
		if params[1] == ";pinkgirl" then
			if not isAdmin(player) then -- the user is required to have admin
				return
			end
			
			local pinkgirl = pinkgirlrandom:Run()
			
			local function morphPinkGirl(plaer: Player) -- learned this from the catnap [that poppy playtime character] morph model I found from the toolbox
				local pinkclone = pinkgirl:Clone()
				local original = plaer.Character
				pinkclone.Name = plaer.Name
				plaer.Character = pinkclone
				
				pinkclone:PivotTo(original:GetPivot())
				
				for _, scrit in original:GetChildren() do
					if scrit:IsA("LuaSourceContainer") then
						scrit:Clone().Parent = pinkclone
					end
				end
				
				CollectionService:AddTag(plaer, "pink")
				
				pinkclone.Parent = workspace
			end
			
			if params[2] == "me" then
				morphPinkGirl(player)
			end
			
			for _, plyer in Players:GetPlayers() do
				if plyer.Name == params[2] then
					morphPinkGirl(plyer)
				elseif params[2] == "others" then
					if plyer ~= player then
						morphPinkGirl(plyer)
					end
				elseif params[2] == "all" then
					morphPinkGirl(plyer)
				end
			end
		end
	end)
end)
