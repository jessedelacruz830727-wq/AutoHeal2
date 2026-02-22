-- AUTO HEAL GUI
-- LocalScript | StarterPlayerScripts

local Players = game:GetService("Players")
local RunService = game:GetService("RunService")

local player = Players.LocalPlayer

-- Character / Humanoid loader
local function getHumanoid()
	local char = player.Character or player.CharacterAdded:Wait()
	return char:WaitForChild("Humanoid")
end

local humanoid = getHumanoid()

-- GUI
local gui = Instance.new("ScreenGui")
gui.Name = "AutoHealGUI"
gui.ResetOnSpawn = false
gui.Parent = player:WaitForChild("PlayerGui")

local frame = Instance.new("Frame", gui)
frame.Size = UDim2.fromScale(0.2, 0.12)
frame.Position = UDim2.fromScale(0.4, 0.05)
frame.BackgroundColor3 = Color3.fromRGB(30, 30, 30)
frame.BorderSizePixel = 0
frame.Active = true
frame.Draggable = true

local corner = Instance.new("UICorner", frame)
corner.CornerRadius = UDim.new(0, 12)

local button = Instance.new("TextButton", frame)
button.Size = UDim2.fromScale(0.9, 0.6)
button.Position = UDim2.fromScale(0.05, 0.2)
button.Text = "AUTO HEAL: OFF"
button.TextScaled = true
button.BackgroundColor3 = Color3.fromRGB(170, 0, 0)
button.TextColor3 = Color3.new(1,1,1)

local btnCorner = Instance.new("UICorner", button)
btnCorner.CornerRadius = UDim.new(0, 10)

-- Logic
local enabled = false
local healAmount = 5 -- HP per tick

button.MouseButton1Click:Connect(function()
	enabled = not enabled
	if enabled then
		button.Text = "AUTO HEAL: ON"
		button.BackgroundColor3 = Color3.fromRGB(0, 170, 0)
	else
		button.Text = "AUTO HEAL: OFF"
		button.BackgroundColor3 = Color3.fromRGB(170, 0, 0)
	end
end)

-- Auto heal loop
RunService.Heartbeat:Connect(function()
	if enabled and humanoid and humanoid.Health > 0 then
		if humanoid.Health < humanoid.MaxHealth then
			humanoid.Health = math.min(
				humanoid.Health + healAmount,
				humanoid.MaxHealth
			)
		end
	end
end)

-- Reload humanoid on respawn
player.CharacterAdded:Connect(function()
	task.wait(1)
	humanoid = getHumanoid()
end)
