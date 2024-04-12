local UIS = game:GetService("UserInputService");
local dwRunservice = game:GetService("RunService");
local dwLocalPlayer = game.Players.LocalPlayer;
local dwMouse = dwLocalPlayer:GetMouse();
local dwWorkspace = game:GetService("Workspace");
local dwCamera = dwWorkspace.CurrentCamera;
local dwPlayers = game:GetService("Players");

local module = {
    Aimbot = {
        Enabled = false,
        ButtonPressed = false,
        ShowFov = false,
        FovFill = false,
        FovSize = 45,
        Wallcheck = false,
        IgnoreFOV = false,
        Teamcheck = false,
        TargetPart = "Head",
        Smoothness = 3,
        FovOpacity = .5,
        AutoShoot = false,
        Color = Color3.fromRGB(0,0,0)
    },
    Target = nil
}

function module.aimvisibilitycheck(target, ignore)
    if module.Aimbot.Wallcheck then
        local Origin = dwCamera.CFrame.p
        local CheckRay = Ray.new(Origin, target- Origin)
        local Hit = workspace:FindPartOnRayWithIgnoreList(CheckRay, ignore)
        return Hit == nil
    else
        return true
    end
end

function module.moveCursor(Part, smoothing)
    local Position, OnScreen = dwCamera:WorldToScreenPoint(Part.Position)
    if OnScreen then
        mousemoverel(((Position.X) - dwMouse.X) / smoothing, ((Position.Y) - dwMouse.Y) / smoothing)
    end
end

function module.GetClosestZombieTWR(fov)
    local Target, Closest = nil, fov or math.huge
    for i,v in pairs(workspace.Entities.Infected:GetChildren()) do
        if v ~= nil and v ~= nil and v:FindFirstChild("Head") ~= nil and module.aimvisibilitycheck(v:FindFirstChild(module.Aimbot.TargetPart).Position or v:FindFirstChild("Head").Position ,{dwLocalPlayer.Character, v}) then
            local Position, OnScreen = dwCamera:WorldToScreenPoint(v:FindFirstChild(module.Aimbot.TargetPart).Position)
            local Distance = (Vector2.new(Position.X, Position.Y) - Vector2.new(dwMouse.X, dwMouse.Y)).Magnitude
            if (Distance < Closest) then
                Closest = Distance
                Target = v
            end
        end
    end
    return Target, Closest
end

function module.AimbotInit()
    local fovcircle = Drawing.new('Circle');
    local closest
    --local closestpart
    task.spawn(function()
        dwRunservice.RenderStepped:Connect(function()
            if UIS:IsMouseButtonPressed(Enum.UserInputType.MouseButton2) then
                module.Aimbot.ButtonPressed = true
            else
                module.Aimbot.ButtonPressed = false
            end
            fovcircle.Visible = module.Aimbot.ShowFov;
            fovcircle.Radius = module.Aimbot.FovSize * ((80 - dwCamera.FieldOfView )/100 + 1)
            fovcircle.Thickness = 0;
            fovcircle.Color = module.Aimbot.Color;
            fovcircle.Filled = module.Aimbot.FovFill;
            fovcircle.NumSides = 36;
            fovcircle.Position = Vector2.new(dwMouse.X, dwMouse.Y + 36);
            fovcircle.Transparency = module.Aimbot.FovOpacity;

            if module.Aimbot.IgnoreFOV then
                closest = module.GetClosestZombieTWR(math.huge)
                module.Target = closest
            else
                closest = module.GetClosestZombieTWR(module.Aimbot.FovSize * ((80 - dwCamera.FieldOfView )/100 + 1))
                module.Target = closest
            end
            if closest ~= nil and module.Aimbot.Enabled and module.Aimbot.ButtonPressed then
                module.moveCursor(closest[module.Aimbot.TargetPart], module.Aimbot.Smoothness)
            end
            if AutoShoot and module.Aimbot.ButtonPressed and module.GetClosestZombieTWR(module.Aimbot.FovSize * ((80 - dwCamera.FieldOfView )/100 + 1)) then
                keypress(0x45)
                wait(0.1)
                keyrelease(0x45)
            end
        end)
    end)
end
return module
