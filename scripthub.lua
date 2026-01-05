-- Chili Hub-style Desync Script
local Players = game:GetService("Players")
local RunService = game:GetService("RunService")
local LocalPlayer = Players.LocalPlayer

local desynced = false
local originalPosition
local fakePosition = Vector3.new(0, 50, 0) -- Change this to where you want others to see you
local connection

-- Create UI
local screenGui = Instance.new("ScreenGui", game.CoreGui)
screenGui.Name = "ChiliHubDesync"

local frame = Instance.new("Frame", screenGui)
frame.Size = UDim2.new(0, 300, 0, 150)
frame.Position = UDim2.new(0.5, -150, 0.5, -75)
frame.BackgroundColor3 = Color3.fromRGB(30, 30, 30)
frame.BorderSizePixel = 0
frame.Active = true
frame.Draggable = true

-- Title
local title = Instance.new("TextLabel", frame)
title.Size = UDim2.new(1, 0, 0, 40)
title.Position = UDim2.new(0,0,0,0)
title.Text = "Chili Hub - Desync"
title.BackgroundColor3 = Color3.fromRGB(20, 20, 20)
title.TextColor3 = Color3.fromRGB(255,255,255)
title.Font = Enum.Font.GothamBold
title.TextSize = 20
title.BorderSizePixel = 0

-- Close button
local closeBtn = Instance.new("TextButton", frame)
closeBtn.Size = UDim2.new(0,30,0,30)
closeBtn.Position = UDim2.new(1,-35,0,5)
closeBtn.Text = "X"
closeBtn.BackgroundColor3 = Color3.fromRGB(50,50,50)
closeBtn.TextColor3 = Color3.fromRGB(255,0,0)
closeBtn.Font = Enum.Font.GothamBold
closeBtn.TextSize = 18
closeBtn.BorderSizePixel = 0
closeBtn.MouseButton1Click:Connect(function()
    frame.Visible = false
end)

-- Toggle Button
local toggleBtn = Instance.new("TextButton", frame)
toggleBtn.Size = UDim2.new(1, -20, 0, 50)
toggleBtn.Position = UDim2.new(0, 10, 0, 60)
toggleBtn.Text = "Toggle Desync"
toggleBtn.BackgroundColor3 = Color3.fromRGB(180, 50, 50)
toggleBtn.TextColor3 = Color3.fromRGB(255,255,255)
toggleBtn.Font = Enum.Font.GothamBold
toggleBtn.TextSize = 18
toggleBtn.BorderSizePixel = 0

toggleBtn.MouseButton1Click:Connect(function()
    desynced = not desynced
    local character = LocalPlayer.Character
    if not character then return end

    local hrp = character:FindFirstChild("HumanoidRootPart")
    if not hrp then return end

    if desynced then
        originalPosition = hrp.Position
        connection = RunService.RenderStepped:Connect(function()
            -- Keep HumanoidRootPart at fake position for others
            hrp.CFrame = CFrame.new(fakePosition)
        end)
        toggleBtn.Text = "Undesync"
    else
        if connection then connection:Disconnect() end
        hrp.CFrame = CFrame.new(originalPosition)
        toggleBtn.Text = "Toggle Desync"
    end
end)

