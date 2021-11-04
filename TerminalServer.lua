local TerminalSystem = game:GetService("ReplicatedStorage").TerminalSystem
local TerminalModule = require(TerminalSystem.Modules.TerminalModule)
local ZoneModule = require(TerminalSystem.Modules.Zone)

local A_Zone = ZoneModule.new(game.Workspace.Rays.IgnoreItems.ATerm.A_Zone)
local B_Zone = ZoneModule.new(game.Workspace.Rays.IgnoreItems.BTerm.B_Zone)
local C_Zone = ZoneModule.new(game.Workspace.Rays.IgnoreItems.CTerm.C_Zone)

game.Players.PlayerAdded:Connect(function(player)
	player.Chatted:Connect(function(message)
		local Command = string.lower(message)
		if Command == TerminalModule.Config.StartCommand then
			TerminalModule:OnCommand(player)
		end
	end)
end)

A_Zone.playerEntered:Connect(function(player)
	TerminalModule:CapPointA(player.Team, player)
end)

B_Zone.playerEntered:Connect(function(player)
	TerminalModule:CapPointB(player.Team, player)
end)

C_Zone.playerEntered:Connect(function(player)
	TerminalModule:CapPointC(player.Team, player)
end)
