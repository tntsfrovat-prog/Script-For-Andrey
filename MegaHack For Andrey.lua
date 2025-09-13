-- SATWARE CHEATS 2.0
local Player = game:GetService("Players").LocalPlayer
local Mouse = Player:GetMouse()
local UIS = game:GetService("UserInputService")
local CoreGui = game:GetService("CoreGui")
local RunService = game:GetService("RunService")

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
ScreenGui.Name = "SATWARE_CHEATS_2.0"
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
ToggleButton.Text = "SATWARE CHEATS 2.0"
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

-- Make GUI draggable on mobile
local dragInput, dragStart, startPos
local function update(input)
    local delta = input.Position - dragStart
    MainFrame.Position = UDim2.new(startPos.X.Scale, startPos.X.Offset + delta.X, startPos.Y.Scale, startPos.Y.Offset + delta.Y)
end

ToggleButton.InputBegan:Connect(function(input)
    if input.UserInputType == Enum.UserInputType.Touch or input.UserInputType == Enum.UserInputType.MouseButton1 then
        dragStart = input.Position
        startPos = MainFrame.Position
        input.Changed:Connect(function()
            if input.UserInputState == Enum.UserInputState.End then
                dragStart = nil
            end
        end)
    end
end)

ToggleButton.InputChanged:Connect(function(input)
    if input.UserInputType == Enum.UserInputType.Touch or input.UserInputType == Enum.UserInputType.MouseMovement then
        dragInput = input
    end
end)

UIS.InputChanged:Connect(function(input)
    if input == dragInput and dragStart then
        update(input)
    end
end)

-- Toggle GUI visibility
ToggleButton.MouseButton1Click:Connect(function()
    FunctionFrame.Visible = not FunctionFrame.Visible
    if FunctionFrame.Visible then
        ToggleButton.Text = "CLOSE SATWARE CHEATS 2.0"
        MainFrame.Size = UDim2.new(0, 200, 0, 180)
    else
        ToggleButton.Text = "SATWARE CHEATS 2.0"
        MainFrame.Size = UDim2.new(0, 200, 0, 30)
    end
end)

-- Global variables to maintain state after death
local ESPEnabled = false
local SpeedEnabled = false
local JumpEnabled = false
local ESPBoxes = {}

-- Function to apply cheats to new character
local function ApplyCheatsToCharacter(character)
    if character and character:FindFirstChild("Humanoid") then
        if SpeedEnabled then
            character.Humanoid.WalkSpeed = 50
        end
        if JumpEnabled then
            character.Humanoid.JumpPower = 100
            character.Humanoid.JumpHeight = 100
        end
    end
end

-- Monitor for character respawn
Player.CharacterAdded:Connect(function(character)
    ApplyCheatsToCharacter(character)
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

JumpButton.MouseButton1Click:Connect(function()
    JumpEnabled = not JumpEnabled
    if JumpEnabled then
        JumpButton.Text = "HighJump: ON"
        JumpButton.TextColor3 = Color3.fromRGB(100, 255, 100)
        if Player.Character and Player.Character:FindFirstChild("Humanoid") then
            Player.Character.Humanoid.JumpPower = 100
            Player.Character.Humanoid.JumpHeight = 100
        end
    else
        JumpButton.Text = "HighJump: OFF"
        JumpButton.TextColor3 = Color3.fromRGB(255, 100, 100)
        if Player.Character and Player.Character:FindFirstChild("Humanoid") then
            Player.Character.Humanoid.JumpPower = 50
            Player.Character.Humanoid.JumpHeight = 50
        end
    end
end)

-- Apply cheats to current character if already spawned
if Player.Character then
    ApplyCheatsToCharacter(Player.Character)
end

print("SATWARE CHEATS 2.0")
