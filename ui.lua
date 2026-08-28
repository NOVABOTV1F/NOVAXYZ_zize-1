--============================================================
-- ✨ XYX_YYF SPEED HUB — EDISI JUARA
-- FILE: ui.lua — Tampilan, Tombol, Panel, Animasi
--============================================================

local Services = {
    Players = game:GetService("Players"),
    UserInputService = game:GetService("UserInputService"),
    RunService = game:GetService("RunService"),
    TweenService = game:GetService("TweenService"),
    Lighting = game:GetService("Lighting"),
}
local LocalPlayer = Services.Players.LocalPlayer
local Config = require(script.Parent.config)
local CONFIG, COLORS, State = Config.CONFIG, Config.COLORS, Config.State

-- GUI ROOT
local ScreenGui = Instance.new("ScreenGui")
ScreenGui.Name = "XYX_YYF_SpeedHub"
ScreenGui.ResetOnSpawn = false
ScreenGui.IgnoreGuiInset = true
ScreenGui.ZIndexBehavior = Enum.ZIndexBehavior.Sibling
ScreenGui.Parent = LocalPlayer:WaitForChild("PlayerGui")

-- HELPER FUNGSI
local function AddCorner(parent, radius)
    local corner = Instance.new("UICorner")
    corner.CornerRadius = UDim.new(0, radius)
    corner.Parent = parent
end
local function AddGradient(parent, rotation)
    local gradient = Instance.new("UIGradient")
    gradient.Rotation = rotation or 45
    gradient.Color = ColorSequence.new{
        ColorSequenceKeypoint.new(0, COLORS.DARK2),
        ColorSequenceKeypoint.new(0.5, COLORS.DARK),
        ColorSequenceKeypoint.new(1, COLORS.MAIN),
    }
    gradient.Parent = parent
end
local function AddStroke(parent)
    local stroke = Instance.new("UIStroke")
    stroke.Color = COLORS.BORDER
    stroke.Thickness = 2
    stroke.Transparency = 0.1
    stroke.Parent = parent
end

-- TOMBOL BUKA/TUTUP
local ToggleButton = Instance.new("TextButton")
ToggleButton.Name = "ToggleButton"
ToggleButton.Size = UDim2.fromOffset(70, 70)
ToggleButton.Position = UDim2.new(0.012, 0, 0.5, -35)
ToggleButton.BackgroundColor3 = COLORS.MAIN
ToggleButton.Text = "▶"
ToggleButton.TextColor3 = COLORS.TEXT
ToggleButton.TextSize = 30
ToggleButton.Font = Enum.Font.GothamBold
ToggleButton.AutoButtonColor = false
ToggleButton.ZIndex = 100
ToggleButton.Parent = ScreenGui
AddCorner(ToggleButton, 50)
AddStroke(ToggleButton)

-- KEY PANEL
local KeyPanel = Instance.new("Frame")
KeyPanel.Name = "KeyPanel"
KeyPanel.Size = UDim2.fromOffset(360, 230)
KeyPanel.Position = UDim2.new(0.5, -180, 0.5, -115)
KeyPanel.BackgroundColor3 = COLORS.BACKGROUND
KeyPanel.Parent = ScreenGui
AddCorner(KeyPanel, 24)
AddStroke(KeyPanel)
AddGradient(KeyPanel, 45)

local KeyTitle = Instance.new("TextLabel")
KeyTitle.Size = UDim2.new(1, -30, 0, 50)
KeyTitle.Position = UDim2.fromOffset(15, 12)
KeyTitle.BackgroundTransparency = 1
KeyTitle.Text = "🔐 XYX_YYF KEY SYSTEM"
KeyTitle.TextColor3 = COLORS.TEXT
KeyTitle.TextSize = 20
KeyTitle.Font = Enum.Font.GothamBold
KeyTitle.Parent = KeyPanel

local KeyInput = Instance.new("TextBox")
KeyInput.Size = UDim2.new(1, -40, 0, 48)
KeyInput.Position = UDim2.fromOffset(20, 75)
KeyInput.BackgroundColor3 = COLORS.BACKGROUND2
KeyInput.PlaceholderText = "Masukkan License Key"
KeyInput.TextColor3 = COLORS.TEXT
KeyInput.TextSize = 16
KeyInput.Font = Enum.Font.GothamBold
KeyInput.ClearTextOnFocus = false
KeyInput.Parent = KeyPanel
AddCorner(KeyInput, 14)

local VerifyButton = Instance.new("TextButton")
VerifyButton.Size = UDim2.new(1, -40, 0, 45)
VerifyButton.Position = UDim2.fromOffset(20, 135)
VerifyButton.BackgroundColor3 = COLORS.MAIN
VerifyButton.Text = "🔓 VERIFIKASI KEY"
VerifyButton.TextColor3 = COLORS.TEXT
VerifyButton.TextSize = 14
VerifyButton.Font = Enum.Font.GothamBold
VerifyButton.AutoButtonColor = false
VerifyButton.Parent = KeyPanel
AddCorner(VerifyButton, 14)

local KeyStatus = Instance.new("TextLabel")
KeyStatus.Size = UDim2.new(1, -40, 0, 30)
KeyStatus.Position = UDim2.fromOffset(20, 183)
KeyStatus.BackgroundTransparency = 1
KeyStatus.Text = "Key belum diverifikasi."
KeyStatus.TextColor3 = COLORS.SECONDARY
KeyStatus.TextSize = 12
KeyStatus.Font = Enum.Font.Gotham
KeyStatus.Parent = KeyPanel

-- MAIN PANEL
local MainPanel = Instance.new("Frame")
MainPanel.Name = "MainPanel"
MainPanel.Size = UDim2.fromOffset(CONFIG.PanelWidth, CONFIG.PanelHeight)
MainPanel.Position = CONFIG.PanelPosition
MainPanel.BackgroundColor3 = COLORS.BACKGROUND
MainPanel.Visible = false
MainPanel.ClipsDescendants = true
MainPanel.Parent = ScreenGui
AddCorner(MainPanel, 24)
AddStroke(MainPanel)
AddGradient(MainPanel, 45)

-- HEADER
local Header = Instance.new("Frame")
Header.Name = "Header"
Header.Size = UDim2.new(1, 0, 0, 60)
Header.BackgroundColor3 = COLORS.DARK
Header.Parent = MainPanel
AddCorner(Header, 24)
AddGradient(Header, 45)

local HeaderTitle = Instance.new("TextLabel")
HeaderTitle.Size = UDim2.new(1, -70, 1, 0)
HeaderTitle.Position = UDim2.fromOffset(15, 0)
HeaderTitle.BackgroundTransparency = 1
HeaderTitle.Text = "✨ XYX_YYF SPEED HUB"
HeaderTitle.TextColor3 = COLORS.TEXT
HeaderTitle.TextSize = 17
HeaderTitle.Font = Enum.Font.GothamBold
HeaderTitle.TextXAlignment = Enum.TextXAlignment.Left
HeaderTitle.Parent = Header

local CloseButton = Instance.new("TextButton")
CloseButton.Size = UDim2.fromOffset(42, 42)
CloseButton.Position = UDim2.new(1, -51, 0, 9)
CloseButton.BackgroundColor3 = COLORS.DARK2
CloseButton.Text = "✕"
CloseButton.TextColor3 = COLORS.TEXT
CloseButton.TextSize = 20
CloseButton.Font = Enum.Font.GothamBold
CloseButton.AutoButtonColor = false
CloseButton.Parent = Header
AddCorner(CloseButton, 14)

-- SCROLL FRAME
local Scroll = Instance.new("ScrollingFrame")
Scroll.Name = "FeatureList"
Scroll.Size = UDim2.new(1, -20, 1, -70)
Scroll.Position = UDim2.fromOffset(10, 65)
Scroll.BackgroundTransparency = 1
Scroll.ScrollBarThickness = 6
Scroll.ScrollBarImageColor3 = COLORS.MAIN
Scroll.CanvasSize = UDim2.new()
Scroll.AutomaticCanvasSize = Enum.AutomaticSize.Y
Scroll.Parent = MainPanel

local ListLayout = Instance.new("UIListLayout")
ListLayout.Padding = UDim.new(0, 10)
ListLayout.Parent = Scroll

local ToggleObjects = {}
local function SetToggleVisual(button, enabled, name)
    if enabled then
        button.BackgroundColor3 = COLORS.MAIN
        button.Text = "✅ " .. name .. " — ON"
    else
        button.BackgroundColor3 = COLORS.OFF
        button.Text = "⬜ " .. name .. " — OFF"
    end
end
local function CreateToggle(name, key)
    local button = Instance.new("TextButton")
    button.Size = UDim2.new(1, 0, 0, 52)
    button.BackgroundColor3 = COLORS.OFF
    button.Text = "⬜ " .. name .. " — OFF"
    button.TextColor3 = COLORS.TEXT
    button.TextSize = 13
    button.Font = Enum.Font.GothamSemibold
    button.TextXAlignment = Enum.TextXAlignment.Left
    button.AutoButtonColor = false
    Instance.new("UIPadding", button).PaddingLeft = UDim.new(0, 15)
    AddCorner(button, 14)
    button.Parent = Scroll
    ToggleObjects[key] = button
    button.Activated:Connect(function()
        if not State.KeyVerified then return end
        State[key] = not State[key]
        SetToggleVisual(button, State[key], name)
    end)
end
local function CreateSlider(name, key, minValue, maxValue, defaultValue)
    local holder = Instance.new("Frame")
    holder.Size = UDim2.new(1, 0, 0, 80)
    holder.BackgroundColor3 = COLORS.BACKGROUND2
    AddCorner(holder, 14)
    holder.Parent = Scroll
    local label = Instance.new("TextLabel")
    label.Size = UDim2.new(1, -20, 0, 30)
    label.Position = UDim2.fromOffset(10, 5)
    label.BackgroundTransparency = 1
    label.Text = name .. ": " .. defaultValue
    label.TextColor3 = COLORS.BRIGHT
    label.TextSize = 12
    label.Font = Enum.Font.GothamBold
    label.TextXAlignment = Enum.TextXAlignment.Left
    label.Parent = holder
    local bar = Instance.new("Frame")
    bar.Size = UDim2.new(1, -30, 0, 16)
    bar.Position = UDim2.fromOffset(15, 47)
    bar.BackgroundColor3 = COLORS.DARK2
    AddCorner(bar, 8)
    bar.Parent = holder
    local fill = Instance.new("Frame")
    fill.BackgroundColor3 = COLORS.MAIN
    AddCorner(fill, 8)
    fill.Parent = bar
    local function SetValue(val)
        val = math.clamp(val, minValue, maxValue)
        State[key] = val
        local pct = (val - minValue) / (maxValue - minValue)
        fill.Size = UDim2.new(pct, 0, 1, 0)
        label.Text = name .. ": " .. tostring(val)
    end
    SetValue(defaultValue)
    bar.InputBegan:Connect(function(input)
        if input.UserInputType == Enum.UserInputType.MouseButton1 then
            local startX = bar.AbsolutePosition.X
            local width = bar.AbsoluteSize.X
            local function Update(pos)
                local pct = math.clamp((pos.X - startX) / width, 0, 1)
                SetValue(minValue + (maxValue - minValue) * pct)
            end
            Update(input.Position)
            local conn
            conn = Services.UserInputService.InputChanged:Connect(function(i)
                if i.UserInputType == Enum.UserInputType.MouseMovement then Update(i.Position) end
            end)
            input.Changed:Connect(function() conn:Disconnect() end)
        end
    end)
end
local function CreateCategory(title)
    local label = Instance.new("TextLabel")
    label.Size = UDim2.new(1, 0, 0, 32)
    label.BackgroundTransparency = 1
    label.Text = title
    label.TextColor3 = COLORS.BRIGHT
    label.TextSize = 14
    label.Font = Enum.Font.GothamBold
    label.TextXAlignment = Enum.TextXAlignment.Left
    label.Parent = Scroll
end

-- EXPORT
return {
    ScreenGui = ScreenGui,
    ToggleButton = ToggleButton,
    KeyPanel = KeyPanel,
    KeyInput = KeyInput,
    VerifyButton = VerifyButton,
    KeyStatus = KeyStatus,
    MainPanel = MainPanel,
    Header = Header,
    CloseButton = CloseButton,
    CreateCategory = CreateCategory,
    CreateToggle = CreateToggle,
    CreateSlider = CreateSlider,
    ToggleObjects = ToggleObjects,
    SetToggleVisual = SetToggleVisual,
}
