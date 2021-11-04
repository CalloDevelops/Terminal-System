local TerminalModule = {}

--// Terminal Configuration
TerminalModule.Config = {}
TerminalModule.Config.RaiderTeam = game.Teams.Raiders -- Raider team
TerminalModule.Config.DefenderTeam = game.Teams.Defenders -- Defender team
TerminalModule.Config.MaxPoints = 500 -- The amount of point it locks at
TerminalModule.Config.StartCommand = ":start" -- Comamnd to start the terminal
TerminalModule.Config.TTI_RankToStart = 7 -- Rank in the TTI group that is able to start the terminal

--// Variables 
local ValuesFolder = game:GetService("ReplicatedStorage").TerminalSystem.Values
local MainGroupID = 12692247

--// Point A Variables
local A_PointLocked = ValuesFolder.PointA.PointLocked
local A_PointOwner = ValuesFolder.PointA.PointOwner
local A_Raiders_Points = ValuesFolder.PointA.RaiderPoints
local A_Defenders_Points = ValuesFolder.PointA.DefenderPoints

--// Point B Variables
local B_Pointlocked = ValuesFolder.PointB.PointLocked
local B_PointOwner = ValuesFolder.PointB.PointOwner
local B_Raiders_Points = ValuesFolder.PointB.RaiderPoints
local B_Defenders_Points = ValuesFolder.PointB.DefenderPoints

--// Point C Variables
local C_PointLocked = ValuesFolder.PointC.PointLocked
local C_PointOwner = ValuesFolder.PointC.PointOwner
local C_Raiders_Points = ValuesFolder.PointC.RaiderPoints
local C_Defenders_Points = ValuesFolder.PointC.DefenderPoints

--// Points Owned Variables
local D_PointsOwned = 0
local R_PointsOwned = 0

--[[
	TerminalModule:Lock()
	- Locks the Terminal, allowing no one to cap it.
]]
function TerminalModule:Lock(Point)
	if Point == "A" then
		A_PointLocked.Value = true
	elseif Point == "B" then
		B_Pointlocked.Value = true
	elseif  Point == "C" then
		C_PointLocked.Value = true
	end
end

--[[
	TerminalModule:Win()
	- Handles what happens when won
]]
function TerminalModule:Win()
	if D_PointsOwned > R_PointsOwned then
		print(self.Config.DefenderTeam.Name.." have won!")
	elseif R_PointsOwned > D_PointsOwned then
		print(self.Config.RaiderTeam.Name.." have won!")
	end
end

--[[
	TerminalModule:CapPoint()
	- Handles pretty much everything, adds points, caps, etc..
]]
function TerminalModule:CapPointA(PointOwner, player)
	if not ValuesFolder.TerminalStarted == true then
		return 
	end

	if A_PointLocked.Value == true or A_PointOwner.Value == PointOwner then 
		return 
	end

	A_PointOwner.Value = PointOwner

	if player.Team == self.Config.RaiderTeam then
		repeat
			A_Raiders_Points.Value += 1
			wait(1)
			if A_Raiders_Points.Value == self.Config.MaxPoints then
				self:Lock("A") 
				R_PointsOwned += 1 
			end
		until A_PointOwner.Value ~= PointOwner or A_Raiders_Points.Value == self.Config.MaxPoints

	elseif player.Team == self.Config.DefenderTeam then
		repeat
			A_Defenders_Points.Value += 1
			wait(1)
			if A_Defenders_Points.Value == self.Config.MaxPoints then 
				self:Lock("A") 
				D_PointsOwned += 1 
			end
		until A_PointOwner.Value ~= PointOwner or A_Defenders_Points.Value == self.Config.MaxPoints
	end

end

function TerminalModule:CapPointB(PointOwner, player)
	if not ValuesFolder.TerminalStarted == true then 
		return 
	end

	if B_Pointlocked.Value == true or B_PointOwner.Value == PointOwner then 
		return 
	end

	B_PointOwner.Value = PointOwner 

	if player.Team == self.Config.RaiderTeam then
		repeat
			B_Raiders_Points.Value += 1
			wait(1)
			if B_Raiders_Points.Value == self.Config.MaxPoints then 
				self:Lock("B") 
				R_PointsOwned += 1 
			end
		until B_PointOwner.Value ~= PointOwner or B_Raiders_Points.Value == self.Config.MaxPoints

	elseif player.Team == self.Config.DefenderTeam then
		repeat
			B_Defenders_Points.Value += 1
			wait(1)
			if B_Defenders_Points.Value == self.Config.MaxPoints then 
				self:Lock("B")
				D_PointsOwned += 1 
			end
		until B_PointOwner.Value ~= PointOwner or B_Defenders_Points.Value == self.Config.MaxPoints
	end

end

function TerminalModule:CapPointC(PointOwner, player)
	if not ValuesFolder.TerminalStarted == true then 
		return 
	end

	if C_PointLocked.Value == true or C_PointOwner.Value == PointOwner then
		return 
	end

	C_PointOwner.Value = PointOwner 

	if player.Team == self.Config.RaiderTeam then
		repeat
			C_Raiders_Points.Value += 1
			wait(1)
			if C_Raiders_Points.Value == self.Config.MaxPoints then 
				self:Lock("C") 
				R_PointsOwned += 1 
			end
		until C_PointOwner.Value ~= PointOwner or C_Raiders_Points.Value == self.Config.MaxPoints

	elseif player.Team == self.Config.DefenderTeam then
		repeat
			C_Defenders_Points.Value += 1
			wait(1)
			if C_Defenders_Points.Value == self.Config.MaxPoints then 
				self:Lock("C") 
				D_PointsOwned += 1  
			end
		until C_PointOwner.Value ~= PointOwner or C_Defenders_Points.Value == self.Config.MaxPoints
	end

end

function TerminalModule:OnCommand(player: Player)
	if player:GetRankInGroup(MainGroupID) >= self.Config.TTI_RankToStart or player.UserId == game.PrivateServerOwnerId then -- Checks if player is the right rank to start, or if they own the server
		ValuesFolder.TerminalStarted.Value = true
		print("Terminal started by: ".. player.Name)
	end
end

return TerminalModule
