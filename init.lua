--============================================================
-- ✨ XYX_YYF SPEED HUB — EDISI JUARA
-- FILE: init.lua — Inisialisasi & Eksekusi Utama
--============================================================

local Config = require(script.config)
local CONFIG, COLORS, State = Config.CONFIG, Config.COLORS, Config.State
local UI = require(script.ui)
local Loops = require(script.loops)

-- === KEY VERIFICATION LOGIC ===
local function KeyErrorAnimation()
    UI.KeyStatus.Text = "❌ Key Salah! Coba Lagi..."
    UI.KeyStatus.TextColor3 = Color3.fromRGB(255, 100, 100)
    local original = UI.KeyPanel.Position
    for i = 1, 4 do
        local dir = i % 2 == 0 and 8 or -8
        task.wait(0.04)
        UI.KeyPanel.Position = UDim2.new(0.5, -180 + dir * (i%2==0 and 1 or -1), 0.5, -115)
    end
    UI.KeyPanel.Position = original
    task.delay(1, function()
        UI.KeyStatus.Text = "Key belum diverifikasi."
        UI.KeyStatus.TextColor3 = COLORS.SECONDARY
    end)
end

local function VerifyKey()
    if UI.KeyInput.Text == CONFIG.Key then
        State.KeyVerified = true
        UI.KeyStatus.Text = "✅ Key benar! Membuka hub..."
        UI.KeyStatus.TextColor3 = COLORS.ON
        task.wait(0.35)
        UI.KeyPanel.Visible = false
        UI.MainPanel.Visible = true
        UI.ToggleButton.Text = "◀"
        State.MenuOpen = true
    else
        UI.KeyInput.Text = ""
        KeyErrorAnimation()
    end
end

UI.VerifyButton.Activated:Connect(VerifyKey)
UI.KeyInput.FocusLost:Connect(function(enter) if enter then VerifyKey() end end)

-- === DRAG SYSTEM ===
local dragging = false
local startPos, startPanel
UI.Header.InputBegan:Connect(function(input)
    if input.UserInputType == Enum.UserInputType.MouseButton1 then
        dragging = true
        startPos = input.Position
        startPanel = UI.MainPanel.Position
    end
end)
game:GetService("UserInputService").InputChanged:Connect(function(input)
    if dragging and input.UserInputType == Enum.UserInputType.MouseMovement then
        local delta = input.Position - startPos
        UI.MainPanel.Position = UDim2.new(
            startPanel.X.Scale, startPanel.X.Offset + delta.X,
            startPanel.Y.Scale, startPanel.Y.Offset + delta.Y
        )
    end
end)
game:GetService("UserInputService").InputEnded:Connect(function() dragging = false end)

-- === MENU TOGGLE ===
UI.ToggleButton.Activated:Connect(function()
    if not State.KeyVerified then return end
    State.MenuOpen = not State.MenuOpen
    UI.MainPanel.Visible = State.MenuOpen
    UI.ToggleButton.Text = State.MenuOpen and "◀" or "▶"
end)
UI.CloseButton.Activated:Connect(function()
    State.MenuOpen = false
    UI.MainPanel.Visible = false
    UI.ToggleButton.Text = "▶"
end)

-- === FITUR LIST ===
UI.CreateCategory("🔵 GERAKAN & PERGERAKAN")
UI.CreateToggle("NoClip — Tembus Segalanya", "Noclip")
UI.CreateToggle("Invisible — Tak Terlihat", "Invisible")
UI.CreateToggle("Fly — Terbang Bebas", "Fly")
UI.CreateToggle("Anti Gravity — Melayang", "AntiGravity")
UI.CreateToggle("No Fall Damage", "NoFallDamage")
UI.CreateToggle("Fast Swim", "FastSwim")
UI.CreateToggle("No Stumble", "NoStumble")
UI.CreateToggle("Auto Climb", "AutoClimb")
UI.CreateToggle("Teleport ke Kursor", "TeleportCursor")
UI.CreateToggle("Speed Walk", "SpeedWalk")

UI.CreateCategory("🟩 KECEPATAN & KEKUATAN")
UI.CreateSlider("Kecepatan Berjalan", "WalkSpeed", 16, 300, 16)
UI.CreateSlider("Kecepatan Terbang", "FlySpeed", 20, 500, 60)
UI.CreateSlider("Kekuatan Lompatan", "JumpPower", 20, 250, 50)
UI.CreateToggle("Speed Boost", "SpeedBoost")
UI.CreateToggle("Jump Boost", "JumpBoost")
UI.CreateToggle("High Friction", "HighFriction")
UI.CreateToggle("Low Friction", "LowFriction")
UI.CreateToggle("Instant Turn", "InstantTurn")

UI.CreateCategory("🛡️ PERLINDUNGAN & OTOMATIS")
UI.CreateToggle("God Mode", "GodMode")
UI.CreateToggle("Auto Heal", "AutoHeal")
UI.CreateToggle("Auto Ambil Barang", "AutoCollect")
UI.CreateToggle("Auto Tanam", "AutoPlant")
UI.CreateToggle("Auto Siram", "AutoWater")
UI.CreateToggle("Auto Panen", "AutoHarvest")
UI.CreateToggle("Auto Jual", "AutoSell")
UI.CreateToggle("Auto Rebirth", "AutoRebirth")
UI.CreateToggle("Auto Quest", "AutoQuest")
UI.CreateToggle("Auto Collect Drop", "AutoCollectDrop")

UI.CreateCategory("🟪 VISUAL")
UI.CreateToggle("ESP Pemain", "ESPPlayer")
UI.CreateToggle("ESP Item", "ESPItem")
UI.CreateToggle("ESP NPC", "ESPNPC")
UI.CreateToggle("Night Mode", "NightMode")
UI.CreateToggle("Day Mode", "DayMode")
UI.CreateToggle("FPS Boost", "FPSBoost")
UI.CreateToggle("Fog Remover", "FogRemover")
UI.CreateToggle("Full Bright", "FullBright")

UI.CreateCategory("🎯 TAMBAHAN")
UI.CreateToggle("Player Info", "PlayerInfo")
UI.CreateToggle("Aim Assist", "AimAssist")
UI.CreateToggle("Auto Respawn", "AutoRespawn")
UI.CreateToggle("Stats Display", "StatsDisplay")

-- === STARTUP MESSAGE ===
print("━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━")
print("✨ XYX_YYF Speed Hub — EDISI JUARA")
print("🚀 Ultimate V5.0")
print("🔐 Key System: ACTIVE")
print("🔑 Key: 20262021")
print("▶ Tekan INSERT untuk membuka/menutup menu")
print("━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━")
