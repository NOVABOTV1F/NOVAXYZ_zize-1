--============================================================
-- ✨ XYX_YYF SPEED HUB — EDISI JUARA
-- FILE: loops.lua — Loop Update & Main Logic
--============================================================

local Services = {
    RunService = game:GetService("RunService"),
    UserInputService = game:GetService("UserInputService"),
}
local Config = require(script.Parent.config)
local State = Config.State
local Features = require(script.Parent.features)
local UI = require(script.Parent.ui)

-- NOCLIP LOOP
Services.RunService.Stepped:Connect(function()
    if State.Noclip then Features.ApplyNoclip() end
end)

-- MOVEMENT & INVISIBLE LOOP
Services.RunService.Heartbeat:Connect(function()
    if not State.KeyVerified then return end
    Features.ApplyMovement()
    if State.Invisible then Features.ApplyInvisible() else Features.RemoveInvisible() end
    Features.ApplyLighting()
end)

-- FPS BOOST LOOP
task.spawn(function()
    while task.wait(5) do
        if State.FPSBoost then
            for _, v in pairs(workspace:GetDescendants()) do
                if v:IsA("ParticleEmitter") or v:IsA("Trail") then v.Enabled = false end
            end
        end
    end
end)

-- KEYBOARD SHORTCUTS
Services.UserInputService.InputBegan:Connect(function(input, proc)
    if proc then return end
    if input.KeyCode == Enum.KeyCode.Insert then
        if State.KeyVerified then
            State.MenuOpen = not State.MenuOpen
            UI.MainPanel.Visible = State.MenuOpen
            UI.ToggleButton.Text = State.MenuOpen and "◀" or "▶"
        end
    end
    if input.KeyCode == Enum.KeyCode.F and State.KeyVerified then
        State.Fly = not State.Fly
        if UI.ToggleObjects.Fly then UI.SetToggleVisual(UI.ToggleObjects.Fly, State.Fly, "Fly") end
    end
    if input.KeyCode == Enum.KeyCode.N and State.KeyVerified then
        State.Noclip = not State.Noclip
        if UI.ToggleObjects.Noclip then UI.SetToggleVisual(UI.ToggleObjects.Noclip, State.Noclip, "NoClip") end
    end
end)
