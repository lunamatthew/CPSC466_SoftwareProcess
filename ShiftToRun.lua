-- Author: Josue Liu (Joshua)
-- Script Name: ShiftToRun
-- Script for ShiftToRun feature.

local player = game.Players.LocalPlayer
local character = player.Character or player.CharacterAdded:Wait()
local humanoid = character:WaitForChild("Humanoid")

local camera = game.Workspace.CurrentCamera

local UIS = game:GetService("UserInputService")
local TweenService = game:GetService("TweenService")

local ShiftToRun_Config = require(game.ReplicatedStorage:WaitForChild("ShiftToRun_Config"))

if ShiftToRun_Config.WalkAnimationId ~= nil then
	character.Animate.walk.WalkAnim.AnimationId = "rbxassetid://"..ShiftToRun_Config.WalkAnimationId
end

if ShiftToRun_Config.RunAnimationId ~= nil then
	character.Animate.run.RunAnim.AnimationId = "rbxassetid://"..ShiftToRun_Config.RunAnimationId
end


function IsWalking()
	if humanoid.MoveDirection.Magnitude > 0 then
		return true
	else
		return false
	end
end


function Walk()
	TweenService:Create(humanoid, TweenInfo.new(ShiftToRun_Config.Duration, Enum.EasingStyle.Linear, Enum.EasingDirection.InOut), {WalkSpeed = ShiftToRun_Config.WalkSpeed}):Play()
	TweenService:Create(camera, TweenInfo.new(ShiftToRun_Config.Duration, Enum.EasingStyle.Linear, Enum.EasingDirection.InOut), {FieldOfView = ShiftToRun_Config.WalkFov}):Play()
end

function Run()
	TweenService:Create(humanoid, TweenInfo.new(ShiftToRun_Config.Duration, Enum.EasingStyle.Linear, Enum.EasingDirection.InOut), {WalkSpeed = ShiftToRun_Config.RunSpeed}):Play()
	TweenService:Create(camera, TweenInfo.new(ShiftToRun_Config.Duration, Enum.EasingStyle.Linear, Enum.EasingDirection.InOut), {FieldOfView = ShiftToRun_Config.RunFov}):Play()
end


UIS.InputBegan:Connect(function(key, proccess)
	if key.KeyCode == ShiftToRun_Config.RunKey then
		if IsWalking() then
			Run()
		end
	end
end)

UIS.InputEnded:Connect(function(key, proccess)
	if key.KeyCode == ShiftToRun_Config.RunKey then
		Walk()
	end
end)

game:GetService("RunService").RenderStepped:Connect(function()
	if IsWalking() == false then
		Walk()
	end
end)
