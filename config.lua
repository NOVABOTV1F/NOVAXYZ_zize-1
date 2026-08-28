--============================================================
-- ✨ XYX_YYF SPEED HUB — EDISI JUARA
-- FILE: config.lua — Pengaturan & Tema Warna
--============================================================

local CONFIG = {
    HubName = "✨ XYX_YYF Speed Hub — EDISI JUARA ✨",
    Version = "Ultimate V5.0",
    Key = "20262021",
    PanelWidth = 380,
    PanelHeight = 580,
    PanelPosition = UDim2.new(0.05, 0, 0.5, -290),
    AnimationTime = 0.25,
    WalkSpeed = 16,
    FlySpeed = 60,
    JumpPower = 50,
    NoclipSpeed = 2,
}

local COLORS = {
    MAIN = Color3.fromRGB(0, 136, 255),
    MAIN_HOVER = Color3.fromRGB(0, 163, 255),
    DARK = Color3.fromRGB(0, 102, 204),
    DARK2 = Color3.fromRGB(0, 76, 153),
    BRIGHT = Color3.fromRGB(51, 187, 255),
    BACKGROUND = Color3.fromRGB(15, 23, 42),
    BACKGROUND2 = Color3.fromRGB(30, 41, 59),
    TEXT = Color3.fromRGB(255, 255, 255),
    SECONDARY = Color3.fromRGB(191, 215, 255),
    BORDER = Color3.fromRGB(0, 153, 255),
    ON = Color3.fromRGB(0, 204, 102),
    OFF = Color3.fromRGB(51, 65, 85),
    SLIDER = Color3.fromRGB(255, 204, 0),
}

local State = {
    KeyVerified = false, MenuOpen = false,
    Noclip = false, Invisible = false, Fly = false,
    AntiGravity = false, NoFallDamage = false, FastSwim = false,
    NoStumble = false, AutoClimb = false, TeleportCursor = false, SpeedWalk = false,
    WalkSpeed = CONFIG.WalkSpeed, FlySpeed = CONFIG.FlySpeed, JumpPower = CONFIG.JumpPower,
    SpeedBoost = false, JumpBoost = false, HighFriction = false, LowFriction = false, InstantTurn = false,
    GodMode = false, AutoHeal = false, AutoCollect = false, AutoPlant = false, AutoWater = false,
    AutoHarvest = false, AutoSell = false, AutoRebirth = false, AutoQuest = false, AutoCollectDrop = false,
    ESPPlayer = false, ESPItem = false, ESPNPC = false,
    NightMode = false, DayMode = false, FPSBoost = false, FogRemover = false, FullBright = false,
    PlayerInfo = false, AimAssist = false, AutoRespawn = false, StatsDisplay = false,
}

local OriginalLighting = {
    Brightness = game:GetService("Lighting").Brightness,
    Ambient = game:GetService("Lighting").Ambient,
    OutdoorAmbient = game:GetService("Lighting").OutdoorAmbient,
    FogEnd = game:GetService("Lighting").FogEnd,
}

return {
    CONFIG = CONFIG,
    COLORS = COLORS,
    State = State,
    OriginalLighting = OriginalLighting,
}
