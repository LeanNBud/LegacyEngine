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
        Color = Color3.fromRGB(0,0,0)
    },
    Target = nil
}

function module.aimteamcheck(player)
    if module.Aimbot.Teamcheck then
        if game.Players.LocalPlayer.TeamColor == player.TeamColor then return false
        else return true end
    else
        return true
    end
end

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

function module.GetClosestPlayer(fov)
    local Target, Closest = nil, fov or math.huge
    for i,v in pairs(dwPlayers:GetPlayers()) do
        if v ~= nil and v.Character ~= nil and v.Character:FindFirstChild("Head") ~= nil and module.aimvisibilitycheck(v.Character:FindFirstChild(module.Aimbot.TargetPart).Position or v.Character:FindFirstChild("Head").Position ,{dwLocalPlayer.Character, v.Character}) and v ~= dwLocalPlayer and module.aimteamcheck(v) then
            local Position, OnScreen = dwCamera:WorldToScreenPoint(v.Character:FindFirstChild(module.Aimbot.TargetPart).Position)
            local Distance = (Vector2.new(Position.X, Position.Y) - Vector2.new(dwMouse.X, dwMouse.Y)).Magnitude
            if (Distance < Closest) then
                Closest = Distance
                Target = v
            end
        end
    end
    return Target, Closest
end

function module.GetClosestPart(player)
    local Target
    if player ~= nil then
        for index, v in pairs(player.Character:GetChildren()) do
            if v:IsA("Part") or v:IsA("MeshPart") then
                local Position, OnScreen = dwCamera:WorldToScreenPoint(v.Position)
                if (Vector2.new(Position.X, Position.Y)).Magnitude < (Vector2.new(dwMouse.X, dwMouse.Y)).Magnitude then
                    --Closest = Distance
                    Target = v
                end
            end
        end
    end
    return Target
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
                closest = module.GetClosestPlayer(math.huge)
                module.Target = closest
            else
                closest = module.GetClosestPlayer(module.Aimbot.FovSize * ((80 - dwCamera.FieldOfView )/100 + 1))
                module.Target = closest
            end
            if closest ~= nil and module.Aimbot.Enabled and module.Aimbot.ButtonPressed then
                module.moveCursor(closest.Character[module.Aimbot.TargetPart], module.Aimbot.Smoothness)
            end
        end)
    end)
end
return module
