-- Roblox Mobile Hack GUI Script by Colin
-- Optimized for mobile, small UI, with anti-tamper measures

local Player = game:GetService("Players").LocalPlayer
local Mouse = Player:GetMouse()
local UIS = game:GetService("UserInputService")
local CoreGui = game:GetService("CoreGui")

-- Anti-ban obfuscation and stability measures
local function SafeCheck()
    for i, v in pairs(getconnections(game:GetService("ScriptContext").Error)) do
        v:Disable()
    end
    if not game:IsLoaded() then
        game.Loaded:Wait()
    end
end
SafeCheck()

-- Create main GUI
local ScreenGui = Instance.new("ScreenGui")
ScreenGui.Name = "SATWARE CHEATS 2.0"
ScreenGui.Parent = CoreGui
ScreenGui.ResetOnSpawn = false
ScreenGui.ZIndexBehavior = Enum.ZIndexBehavior.Sibling

-- Main Frame (Small for mobile)
local MainFrame = Instance.new("Frame")
MainFrame.Name = "MainFrame"
MainFrame.Size = UDim2.new(0, 200, 0, 30)
MainFrame.Position = UDim2.new(0.5, -100, 0, 10)
MainFrame.BackgroundColor3 = Color3.fromRGB(40, 40, 40)
MainFrame.BorderSizePixel = 0
MainFrame.Active = true
MainFrame.Draggable = true
MainFrame.Parent = ScreenGui

-- Open/Close Button
local ToggleButton = Instance.new("TextButton")
ToggleButton.Name = "ToggleButton"
ToggleButton.Size = UDim2.new(1, 0, 1, 0)
ToggleButton.Position = UDim2.new(0, 0, 0, 0)
ToggleButton.BackgroundColor3 = Color3.fromRGB(30, 30, 30)
ToggleButton.BorderSizePixel = 0
ToggleButton.Text = "Open GUI"
ToggleButton.TextColor3 = Color3.fromRGB(255, 255, 255)
ToggleButton.TextSize = 14
ToggleButton.Parent = MainFrame

-- Function Frame (Hidden initially)
local FunctionFrame = Instance.new("Frame")
FunctionFrame.Name = "FunctionFrame"
FunctionFrame.Size = UDim2.new(1, 0, 0, 150)
FunctionFrame.Position = UDim2.new(0, 0, 1, 0)
FunctionFrame.BackgroundColor3 = Color3.fromRGB(50, 50, 50)
FunctionFrame.BorderSizePixel = 0
FunctionFrame.ClipsDescendants = true
FunctionFrame.Visible = false
FunctionFrame.Parent = MainFrame

-- UIListLayout for functions
local UIListLayout = Instance.new("UIListLayout")
UIListLayout.Parent = FunctionFrame
UIListLayout.HorizontalAlignment = Enum.HorizontalAlignment.Center
UIListLayout.Padding = UDim.new(0, 5)

-- Toggle GUI visibility
ToggleButton.MouseButton1Click:Connect(function()
    FunctionFrame.Visible = not FunctionFrame.Visible
    if FunctionFrame.Visible then
        ToggleButton.Text = "Close GUI"
        MainFrame.Size = UDim2.new(0, 200, 0, 180)
    else
        ToggleButton.Text = "Open GUI"
        MainFrame.Size = UDim2.new(0, 200, 0, 30)
    end
end)

-- Function 1: ESP
local ESPButton = Instance.new("TextButton")
ESPButton.Name = "ESPButton"
ESPButton.Size = UDim2.new(0.9, 0, 0, 30)
ESPButton.BackgroundColor3 = Color3.fromRGB(70, 70, 70)
ESPButton.BorderSizePixel = 0
ESPButton.Text = "ESP: OFF"
ESPButton.TextColor3 = Color3.fromRGB(255, 100, 100)
ESPButton.TextSize = 14
ESPButton.Parent = FunctionFrame

local ESPEnabled = false
local ESPBoxes = {}

ESPButton.MouseButton1Click:Connect(function()
    ESPEnabled = not ESPEnabled
    if ESPEnabled then
        ESPButton.Text = "ESP: ON"
        ESPButton.TextColor3 = Color3.fromRGB(100, 255, 100)
        for i, player in ipairs(game:GetService("Players"):GetPlayers()) do
            if player ~= Player and player.Character and player.Character:FindFirstChild("HumanoidRootPart") then
                local Box = Instance.new("BoxHandleAdornment")
                Box.Name = "ESP_" .. player.Name
                Box.Adornee = player.Character.HumanoidRootPart
                Box.AlwaysOnTop = true
                Box.ZIndex = 10
                Box.Size = Vector3.new(3, 6, 3)
                Box.Color3 = Color3.fromRGB(255, 0, 0)
                Box.Transparency = 0.5
                Box.Parent = player.Character.HumanoidRootPart
                ESPBoxes[player.Name] = Box
            end
        end
    else
        ESPButton.Text = "ESP: OFF"
        ESPButton.TextColor3 = Color3.fromRGB(255, 100, 100)
        for name, box in pairs(ESPBoxes) do
            box:Destroy()
        end
        ESPBoxes = {}
    end
end)

-- Function 2: HighSpeed
local SpeedButton = Instance.new("TextButton")
SpeedButton.Name = "SpeedButton"
SpeedButton.Size = UDim2.new(0.9, 0, 0, 30)
SpeedButton.BackgroundColor3 = Color3.fromRGB(70, 70, 70)
SpeedButton.BorderSizePixel = 0
SpeedButton.Text = "HighSpeed: OFF"
SpeedButton.TextColor3 = Color3.fromRGB(255, 100, 100)
SpeedButton.TextSize = 14
SpeedButton.Parent = FunctionFrame

local SpeedEnabled = false
SpeedButton.MouseButton1Click:Connect(function()
    SpeedEnabled = not SpeedEnabled
    if SpeedEnabled then
        SpeedButton.Text = "HighSpeed: ON"
        SpeedButton.TextColor3 = Color3.fromRGB(100, 255, 100)
        if Player.Character and Player.Character:FindFirstChild("Humanoid") then
            Player.Character.Humanoid.WalkSpeed = 50
        end
    else
        SpeedButton.Text = "HighSpeed: OFF"
        SpeedButton.TextColor3 = Color3.fromRGB(255, 100, 100)
        if Player.Character and Player.Character:FindFirstChild("Humanoid") then
            Player.Character.Humanoid.WalkSpeed = 16
        end
    end
end)

-- Function 3: HighJump
local JumpButton = Instance.new("TextButton")
JumpButton.Name = "JumpButton"
JumpButton.Size = UDim2.new(0.9, 0, 0, 30)
JumpButton.BackgroundColor3 = Color3.fromRGB(70, 70, 70)
JumpButton.BorderSizePixel = 0
JumpButton.Text = "HighJump: OFF"
JumpButton.TextColor3 = Color3.fromRGB(255, 100, 100)
JumpButton.TextSize = 14
JumpButton.Parent = FunctionFrame

local JumpEnabled = false
JumpButton.MouseButton1Click:Connect(function()
    JumpEnabled = not JumpEnabled
    if JumpEnabled then
        JumpButton.Text = "HighJump: ON"
        JumpButton.TextColor3 = Color3.fromRGB(100, 255, 100)
        if Player.Character and Player.Character:FindFirstChild("Humanoid") then
            Player.Character.Humanoid.JumpPower = 100
        end
    else
        JumpButton.Text = "HighJump: OFF"
        JumpButton.TextColor3 = Color3.fromRGB(255, 100, 100)
        if Player.Character and Player.Character:FindFirstChild("Humanoid") then
            Player.Character.Humanoid.JumpPower = 50
        end
    end
end)

-- Mobile optimization: Prevent full-screen takeover
UIS.TouchTap:Connect(function(input, processed)
    if not processed then
        -- Keep GUI on top
        ScreenGui:SetTopmostCoreGui(true)
    end
end)

print("SATWARE CHEATS 2.0")
