-- Desync Script
local Players = game:GetService("Players")
local LocalPlayer = Players.LocalPlayer
local RunService = game:GetService("RunService")

local desynced = false
local fakePosition = Vector3.new(0, 50, 0) -- Change to where you want to appear

-- GUI button
local screenGui = Instance.new("ScreenGui", game.CoreGui)
screenGui.Name = "DesyncGui"

local button = Instance.new("TextButton", screenGui)
button.Size = UDim2.new(0, 150, 0, 50)
button.Position = UDim2.new(0.5, -75, 0, 50)
button.Text = "Toggle Desync"
button.BackgroundColor3 = Color3.fromRGB(50, 50, 50)
button.TextColor3 = Color3.fromRGB(255, 255, 255)
button.Font = Enum.Font.GothamBold
button.TextSize = 18

local originalPosition
local connection

button.MouseButton1Click:Connect(function()
    desynced = not desynced
    
    if desynced then
        originalPosition = LocalPlayer.Character.HumanoidRootPart.Position
        
        -- Fake position loop
        connection = RunService.RenderStepped:Connect(function()
            -- Move your HumanoidRootPart somewhere fake for others
            -- Actual movement is subtle, your camera stays here
            LocalPlayer.Character.HumanoidRootPart.CFrame = CFrame.new(fakePosition)
        end)
        button.Text = "Undesync"
    else
        -- Stop faking
        if connection then connection:Disconnect() end
        LocalPlayer.Character.HumanoidRootPart.CFrame = CFrame.new(originalPosition)
        button.Text = "Toggle Desync"
    end
end)
