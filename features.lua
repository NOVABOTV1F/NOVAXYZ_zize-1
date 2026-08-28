--============================================================
-- ✨ XYX_YYF SPEED HUB — EDISI JUARA
-- FILE: features.lua — Semua Fungsi Fitur
--============================================================

local Services = {
    Players = game:GetService("Players"),
    UserInputService = game:GetService("UserInputService"),
    RunService = game:GetService("RunService"),
    TweenService = game:GetService("TweenService"),
    Lighting = game:GetService("Lighting"),
}
local LocalPlayer = Services.Players.LocalPlayer
local Mouse = LocalPlayer:GetMouse()
local Config = require(script.Parent.config)
local CONFIG, COLORS, State, OriginalLighting = Config.CONFIG, Config.COLORS, Config.State, Config.OriginalLighting

local Character, Humanoid, RootPart

local function UpdateCharacter(char)
    Character = char
    Humanoid = char:FindFirstChild("Humanoid")
    RootPart = char:FindFirstChild("HumanoidRootPart")
end
if LocalPlayer.Character then UpdateCharacter(LocalPlayer.Character) end
LocalPlayer.CharacterAdded:Connect(UpdateCharacter)

-- === NOCLIP ===
local function ApplyNoclip()
    if not Character then return end
    for _, v in pairs(Character:GetDescendants()) do
        if v:IsA("BasePart") then v.CanCollide = false end
    end
end

-- === INVISIBLE ===
local function ApplyInvisible()
    if not Character then return end
    for _, v in pairs(Character:GetDescendants()) do
        if v:IsA("BasePart") or v:IsA("Decal") then v.LocalTransparencyModifier = 1 end
    end
end
local function RemoveInvisible()
    if not Character then return end
    for _, v in pairs(Character:GetDescendants()) do
        if v:IsA("BasePart") or v:IsA("Decal") then v.LocalTransparencyModifier = 0 end
    end
end

-- === MOVEMENT ===
local function ApplyMovement()
    if not Humanoid then return end
    local speed = State.WalkSpeed
    if State.SpeedBoost then speed *= 1.5 end
    Humanoid.WalkSpeed = math.clamp(speed, 0, 300)
    local jump = State.JumpPower
    if State.JumpBoost then jump *= 1.5 end
    Humanoid.JumpPower = math.clamp(jump, 0, 250)
end

-- === FLY ===
local FlyConn
local function StartFly()
    if FlyConn then FlyConn:Disconnect() end
    FlyConn = Services.RunService.RenderStepped:Connect(function()
        if not State.Fly or not Character or not Humanoid or not RootPart then return end
        local cam = workspace.CurrentCamera
        Humanoid.PlatformStand = true
        local dir = Vector3.zero
        if Services.UserInputService:IsKeyDown(Enum.KeyCode.W) then dir += cam.CFrame.LookVector end
        if Services.UserInputService:IsKeyDown(Enum.KeyCode.S) then dir -= cam.CFrame.LookVector end
        if Services.UserInputService:IsKeyDown(Enum.KeyCode.A) then dir -= cam.CFrame.RightVector end
        if Services.UserInputService:IsKeyDown(Enum.KeyCode.D) then dir += cam.CFrame.RightVector end
        if Services.UserInputService:IsKeyDown(Enum.KeyCode.Space) then dir += Vector3.yAxis end
        if Services.UserInputService:IsKeyDown(Enum.KeyCode.LeftControl) then dir -= Vector3.yAxis end
        if dir.Magnitude > 0 then dir = dir.Unit end
        RootPart.AssemblyLinearVelocity = dir * State.FlySpeed
    end)
end

-- === ANTI GRAVITY ===
local AntiGravConn
local function StartAntiGravity()
    if AntiGravConn then AntiGravConn:Disconnect() end
    AntiGravConn = Services.RunService.Heartbeat:Connect(function()
        if not State.AntiGravity or not RootPart then return end
        local vel = RootPart.AssemblyLinearVelocity
        RootPart.AssemblyLinearVelocity = Vector3.new(vel.X, math.max(vel.Y, -5), vel.Z)
    end)
end

-- === GOD MODE / AUTO HEAL ===
local ProtectConn
local function StartProtection()
    if ProtectConn then ProtectConn:Disconnect() end
    ProtectConn = Services.RunService.Heartbeat:Connect(function()
        if not Humanoid then return end
        if State.GodMode then Humanoid.Health = Humanoid.MaxHealth
        elseif State.AutoHeal and Humanoid.Health > 0 then
            Humanoid.Health = math.min(Humanoid.MaxHealth, Humanoid.Health + 0.5)
        end
    end)
end

-- === LIGHTING ===
local function ApplyLighting()
    if State.FullBright then
        Services.Lighting.Brightness = 4
        Services.Lighting.Ambient = Color3.fromRGB(255,255,255)
    elseif State.NightMode then
        Services.Lighting.Brightness = 0.3
        Services.Lighting.Ambient = COLORS.DARK2
    elseif State.DayMode then
        Services.Lighting.Brightness = OriginalLighting.Brightness
        Services.Lighting.Ambient = OriginalLighting.Ambient
    end
    Services.Lighting.FogEnd = State.FogRemover and 10000 or OriginalLighting.FogEnd
end

-- === TELEPORT ===
Mouse.Button2Down:Connect(function()
    if not State.TeleportCursor or not RootPart then return end
    local target = Mouse.Hit.Position
    if (target - RootPart.Position).Magnitude <= 100 then
        RootPart.CFrame = CFrame.new(target + Vector3.new(0,3,0))
    end
end)

-- === AUTO RESPAWN ===
LocalPlayer.CharacterAdded:Connect(function(char)
    task.wait(0.5)
    Humanoid = char:FindFirstChild("Humanoid")
    if Humanoid then
        Humanoid.Died:Connect(function()
            if State.AutoRespawn then
                task.wait(1)
                LocalPlayer:LoadCharacter()
            end
        end)
    end
end)

-- STARTUP
StartFly()
StartAntiGravity()
StartProtection()

-- EXPORT
return {
    UpdateCharacter = UpdateCharacter,
    ApplyNoclip = ApplyNoclip,
    ApplyInvisible = ApplyInvisible,
    RemoveInvisible = RemoveInvisible,
    ApplyMovement = ApplyMovement,
    ApplyLighting = ApplyLighting,
}
