--[[
 💀 Brainrot Invis GUI for Executors 💀
 Draggable GUI with invis button & trail
]]--

local player = game:GetService("Players").LocalPlayer
local UIS = game:GetService("UserInputService")

-- ScreenGui
local gui = Instance.new("ScreenGui")
gui.Name = "BrainrotGui_" .. tostring(math.random(1000,9999))
gui.ResetOnSpawn = false
gui.Parent = player:WaitForChild("PlayerGui")

-- Frame
local frame = Instance.new("Frame")
frame.Size = UDim2.new(0, 250, 0, 120)
frame.Position = UDim2.new(0.5, -125, 0.5, -60)
frame.BackgroundColor3 = Color3.fromRGB(40, 40, 40)
frame.BorderSizePixel = 0
frame.Parent = gui

-- Corners & Stroke
Instance.new("UICorner", frame).CornerRadius = UDim.new(0, 10)
local frameStroke = Instance.new("UIStroke", frame)
frameStroke.Color = Color3.fromRGB(255, 255, 255)
frameStroke.Thickness = 1.5
frameStroke.Transparency = 0.3

-- Label
local label = Instance.new("TextLabel", frame)
label.Size = UDim2.new(1, 0, 0, 30)
label.Position = UDim2.new(0, 0, 0, 0)
label.BackgroundTransparency = 1
label.Text = "Steal A Brainrot Invis"
label.TextColor3 = Color3.fromRGB(255, 255, 255)
label.Font = Enum.Font.GothamBold
label.TextSize = 16

-- Button
local button = Instance.new("TextButton", frame)
button.Size = UDim2.new(0.6, 0, 0, 35)
button.Position = UDim2.new(0.2, 0, 0.5, -17)
button.BackgroundColor3 = Color3.fromRGB(60, 60, 60)
button.Text = "Invisible"
button.TextColor3 = Color3.fromRGB(255, 255, 255)
button.Font = Enum.Font.Gotham
button.TextSize = 14

-- Button corners & outline
Instance.new("UICorner", button).CornerRadius = UDim.new(0, 8)
local buttonStroke = Instance.new("UIStroke", button)
buttonStroke.Color = Color3.fromRGB(255, 255, 255)
buttonStroke.Thickness = 1.2
buttonStroke.Transparency = 0.25

-- Dragging (smooth)
local dragging, dragInput, dragStart, startPos = false

local function update(input)
	if dragging then
		local delta = input.Position - dragStart
		frame.Position = UDim2.new(startPos.X.Scale, startPos.X.Offset + delta.X,
								   startPos.Y.Scale, startPos.Y.Offset + delta.Y)
	end
end

frame.InputBegan:Connect(function(input)
	if input.UserInputType == Enum.UserInputType.MouseButton1 then
		dragging = true
		dragStart = input.Position
		startPos = frame.Position
		input.Changed:Connect(function()
			if input.UserInputState == Enum.UserInputState.End then
				dragging = false
			end
		end)
	end
end)

frame.InputChanged:Connect(function(input)
	if input.UserInputType == Enum.UserInputType.MouseMovement then
		dragInput = input
	end
end)

UIS.InputChanged:Connect(function(input)
	if input == dragInput then
		update(input)
	end
end)

-- Invisibility logic
button.MouseButton1Click:Connect(function()
	local character = player.Character or player.CharacterAdded:Wait()

	for _, part in ipairs(character:GetDescendants()) do
		if part:IsA("BasePart") or part:IsA("Decal") then
			part.Transparency = 1
		elseif part:IsA("ParticleEmitter") or part:IsA("Trail") then
			part.Enabled = false
		end
	end

	-- Add transparent trail
	if not character:FindFirstChild("BrainrotTrail") then
		local root = character:FindFirstChild("HumanoidRootPart")
		if root then
			local att0 = Instance.new("Attachment", root)
			att0.Name = "TrailAtt0"

			local att1 = Instance.new("Attachment", root)
			att1.Name = "TrailAtt1"
			att1.Position = Vector3.new(0, 2, 0)

			local trail = Instance.new("Trail")
			trail.Name = "BrainrotTrail"
			trail.Attachment0 = att0
			trail.Attachment1 = att1
			trail.Lifetime = 0.5
			trail.Color = ColorSequence.new(Color3.new(1, 1, 1))
			trail.Transparency = NumberSequence.new{
				NumberSequenceKeypoint.new(0, 0.8),
				NumberSequenceKeypoint.new(1, 1)
			}
			trail.LightEmission = 1
			trail.WidthScale = NumberSequence.new(1)
			trail.Enabled = true
			trail.Parent = root
		end
	end

	print("[Brainrot GUI] You are now invisible with a trail.")
end)
