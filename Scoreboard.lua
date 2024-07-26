-- Scoreboard.lua
-- Author: Matthew Luna

local player = game.Players.LocalPlayer
local playerGui = player:WaitForChild("PlayerGui")
local screenGui = playerGui:WaitForChild("ScreenGui")
local scoreboardFrame = screenGui:WaitForChild("Frame")
local playerNameTemplate = scoreboardFrame:WaitForChild("PlayerNameTemplate")

scoreboardFrame.Visible = false

local function toggleScoreboard()
    scoreboardFrame.Visible = not scoreboardFrame.Visible
    if scoreboardFrame.Visible then
        updateScoreboard()
    end
end

local function updateScoreboard()
    for _, child in pairs(scoreboardFrame:GetChildren()) do
        if child:IsA("TextLabel") and child.Name ~= "PlayerNameTemplate" then
            child:Destroy()
        end
    end

    local players = game.Players:GetPlayers()
    for i, player in ipairs(players) do
        local playerNameLabel = playerNameTemplate:Clone()
        playerNameLabel.Name = player.Name
        playerNameLabel.Text = player.Name
        playerNameLabel.Visible = true
        playerNameLabel.Parent = scoreboardFrame
        playerNameLabel.Position = UDim2.new(0, 0, 0, (i - 1) * playerNameLabel.Size.Y.Offset)
    end
end

local UserInputService = game:GetService("UserInputService")

UserInputService.InputBegan:Connect(function(input, gameProcessed)
    if gameProcessed then return end

    if input.KeyCode == Enum.KeyCode.P then
        toggleScoreboard()
    end
end)
