local players = game:GetService("Players")
local tweenService = game:GetService("TweenService")
local runService = game:GetService("RunService")
local coreGui = game:GetService("CoreGui")
local userInputService = game:GetService("UserInputService")

local Library = {}
Library.Tree = {}

function Library:CreateAstolfoUI()
	Library.Tree["1"] = Instance.new("ScreenGui", players.LocalPlayer:WaitForChild("PlayerGui"))
	Library.Tree["1"]["Name"] = [[astolfo]]
	Library.Tree["1"]["ZIndexBehavior"] = Enum.ZIndexBehavior.Sibling

	local closeButton = Instance.new("TextButton", Library.Tree["1"])
	closeButton.BorderSizePixel = 0
	closeButton.TextSize = 14
	closeButton.BackgroundColor3 = Color3.fromRGB(41, 41, 41)
	closeButton.TextColor3 = Color3.fromRGB(255, 255, 255)
	closeButton.Size = UDim2.new(0.1, 0, 0.05, 0)
	closeButton.Position = UDim2.new(0.9, 0, 0, 0)
	closeButton.Text = "Close"
	closeButton.Font = Enum.Font.Ubuntu

	local isOpen = true

	local function toggleGuiElements()
		isOpen = not isOpen
		for _, child in pairs(Library.Tree["1"]:GetChildren()) do
			if child ~= closeButton then
				if child:IsA("GuiObject") then
					child.Visible = isOpen
				end
			end
		end
		if isOpen then
			closeButton.Text = "Close"
		else
			closeButton.Text = "Open"
		end
	end

	closeButton.MouseButton1Click:Connect(toggleGuiElements)
end

function Library:NewTab(name, position)
	local tab = Instance.new("Frame", Library.Tree["1"])
	tab.BorderSizePixel = 0
	tab.BackgroundColor3 = Color3.fromRGB(41, 41, 41)
	tab.Size = UDim2.new(0, 163, 0, 368)
	tab.BorderColor3 = Color3.fromRGB(0, 0, 0)
	tab.Position = position or UDim2.new(0.023, 0, 0.03, 0)
	tab.Name = [[tab]]

	local dropShadowHolder = Instance.new("Frame", tab)
	dropShadowHolder.ZIndex = 0
	dropShadowHolder.BorderSizePixel = 0
	dropShadowHolder.BackgroundTransparency = 1
	dropShadowHolder.Size = UDim2.new(1, 0, 1, 0)
	dropShadowHolder.Name = [[DropShadowHolder]]

	local dropShadow = Instance.new("ImageLabel", dropShadowHolder)
	dropShadow.ZIndex = 0
	dropShadow.BorderSizePixel = 0
	dropShadow.SliceCenter = Rect.new(49, 49, 450, 450)
	dropShadow.ScaleType = Enum.ScaleType.Slice
	dropShadow.ImageColor3 = Color3.fromRGB(0, 0, 0)
	dropShadow.ImageTransparency = 0.5
	dropShadow.AnchorPoint = Vector2.new(0.5, 0.5)
	dropShadow.Image = [[rbxassetid://6014261993]]
	dropShadow.Size = UDim2.new(1, 47, 1, 47)
	dropShadow.Name = [[DropShadow]]
	dropShadow.BackgroundTransparency = 1
	dropShadow.Position = UDim2.new(0.5, 0, 0.5, 0)

	local buttonshere = Instance.new("ScrollingFrame", tab)
	buttonshere.Active = true
	buttonshere.BorderSizePixel = 0
	buttonshere.BackgroundColor3 = Color3.fromRGB(41, 41, 41)
	buttonshere.Size = UDim2.new(0, 147, 0, 318)
	buttonshere.ScrollBarImageColor3 = Color3.fromRGB(0, 0, 0)
	buttonshere.ScrollBarThickness = 1
	buttonshere.BorderColor3 = Color3.fromRGB(0, 0, 0)
	buttonshere.Position = UDim2.new(0.043, 0, 0.112, 0)
	buttonshere.Name = [[buttonshere]]

	local uiListLayout = Instance.new("UIListLayout", buttonshere)
	uiListLayout.Padding = UDim.new(0, 5)
	uiListLayout.SortOrder = Enum.SortOrder.LayoutOrder

	local tabLabel = Instance.new("TextLabel", tab)
	tabLabel.BorderSizePixel = 0
	tabLabel.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
	tabLabel.TextSize = 14
	tabLabel.TextColor3 = Color3.fromRGB(255, 255, 255)
	tabLabel.Size = UDim2.new(0, 115, 0, 35)
	tabLabel.BorderColor3 = Color3.fromRGB(0, 0, 0)
	tabLabel.Text = name
	tabLabel.Font = Enum.Font.Unknown
	tabLabel.BackgroundTransparency = 1
	tabLabel.Position = UDim2.new(0.14, 0, 0, 0)

	local uiStroke = Instance.new("UIStroke", tab)
	uiStroke.Color = Color3.fromRGB(255, 0, 0)

	local panel = Instance.new("Frame", tab)
	panel.BorderSizePixel = 0
	panel.BackgroundColor3 = Color3.fromRGB(255, 0, 0)
	panel.Size = UDim2.new(0, 163, 0, 1)
	panel.BorderColor3 = Color3.fromRGB(0, 0, 0)
	panel.Position = UDim2.new(0, 0, 0.089, 0)
	panel.Name = [[panel]]

	Library.Tree[name] = tab
end

function Library:AddButton(tabName, name, clicked)
	local tab = Library.Tree[tabName]
	if not tab then
		error("Tab " .. tabName .. " does not exist")
	end

	local button = Instance.new("TextButton", tab:FindFirstChild("buttonshere"))
	button.BorderSizePixel = 0
	button.TextSize = 14
	button.BackgroundColor3 = Color3.fromRGB(51, 51, 51)
	button.TextColor3 = Color3.fromRGB(255, 255, 255)
	button.Size = UDim2.new(0, 147, 0, 28)
	button.Name = name
	button.Text = name
	button.BorderColor3 = Color3.fromRGB(0, 0, 0)
	button.Font = Enum.Font.Ubuntu

	button.MouseButton1Click:Connect(function()
		clicked()
	end)
end

function Library:AddToggleButton(tabName, name, initialState, callback)
	local tab = Library.Tree[tabName]
	if not tab then
		error("Tab " .. tabName .. " does not exist")
	end

	local button = Instance.new("TextButton", tab:FindFirstChild("buttonshere"))
	button.BorderSizePixel = 0
	button.TextSize = 14
	button.BackgroundColor3 = Color3.fromRGB(51, 51, 51)
	button.TextColor3 = Color3.fromRGB(255, 255, 255)
	button.Size = UDim2.new(0, 147, 0, 28)
	button.Name = name
	button.Text = name
	button.BorderColor3 = Color3.fromRGB(0, 0, 0)
	button.Font = Enum.Font.Ubuntu

	local state = initialState or false

	local function updateButton()
		if state then
			button.BackgroundColor3 = Color3.fromRGB(139, 0, 0)
		else
			button.BackgroundColor3 = Color3.fromRGB(51, 51, 51)
		end
	end

	button.MouseButton1Click:Connect(function()
		state = not state
		updateButton()
		callback(state)
	end)

	updateButton()
end

return Library
