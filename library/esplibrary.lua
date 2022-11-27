local UIS = game:GetService("UserInputService");
local dwRunservice = game:GetService("RunService");
local dwLocalPlayer = game.Players.LocalPlayer;
local dwMouse = dwLocalPlayer:GetMouse();
local dwWorkspace = game:GetService("Workspace");
local dwCamera = dwWorkspace.CurrentCamera;

local module = {
    Visual = {
        Enabled = false,
        Box = false,
        Filledbox = false,
        Name = false,
        Snaplines = false,
        Distance = false,
        Healthbox = false,
        ShowTeam = true,
        FilledOpacity = 1,
        ShowDistance = 1500,
        TeamColor = Color3.new(0, 255, 0),
        EnemyColor = Color3.new(255, 0, 0),
        crosshair = {
            Show = false,
            Spin = false,
            Outline = false,
            Thickness = 3,
            Color = Color3.new(255, 0, 0),
        },
        michael = {
            Enabled = false,
            Box = false,
            Filledbox = false,
            Info = false,
            Snaplines = false,
            Distance = false,
            Healthbox = false,
            FilledOpacity = 1,
            ShowDistance = 1500,
            EnemyColor = Color3.new(255, 0, 0),
        };
        slayersnpc = {
            Enabled = false,
            Box = false,
            Filledbox = false,
            Info = false,
            Snaplines = true,
            Name = false,
            Distance = false,
            Healthbox = false,
            FilledOpacity = 1,
            ShowDistance = 1500,
            EnemyColor = Color3.new(255, 0, 0),
        };
        aottitanesp = {
            Enabled = false,
            Box = false,
            Filledbox = false,
            Info = false,
            Snaplines = true,
            Name = false,
            Distance = false,
            Healthbox = false,
            FilledOpacity = 1,
            ShowDistance = 1500,
            EnemyColor = Color3.new(255, 0, 0),
            titaninfo = false
        };
        aotevoesp = {
            Enabled = false,
            Box = false,
            Filledbox = false,
            Info = false,
            Snaplines = true,
            Name = false,
            Distance = false,
            Healthbox = false,
            FilledOpacity = 1,
            ShowDistance = 1500,
            EnemyColor = Color3.new(255, 0, 0),
        };
    },
};

local function teamcheck(targetplayer)
    if game.Players.LocalPlayer.Team == targetplayer.Team then return false
    else return true end
end

function module.playerexists(player, game)
    if game == "Universal" or "universal" then
        if player ~= nil then
            return false
        else
            return true
        end
    end
end

function module.universalvisual(v)
            local esp = {
                Box = {Filledbox = Drawing.new("Square"), Outline = Drawing.new("Square"), Main = Drawing.new("Square"), HealthboxOutline = Drawing.new("Square"), Healthbox = Drawing.new("Square")},
                Text = {Distance = Drawing.new("Text"), Name = Drawing.new("Text")},
                Line = {Snapline = Drawing.new("Line")}
            };
        
            for index, v in pairs(esp.Box) do
                v.Visible = false
                v.Position = Vector2.new(20, 20);
                v.Size = Vector2.new(20, 20); -- pixels offset from .Position
                v.Color = Color3.fromRGB(0, 0, 0);
                v.Filled = false;
                v.Transparency = 0.9;
                v.Thickness = 1
            end
        
            for index, v in pairs(esp.Line) do
                v.From = Vector2.new(20, 20); -- origin
                v.To = Vector2.new(50, 50); -- destination
                v.Color = Color3.new(0,0,0);
                v.Thickness = 1;
                v.Transparency = 0.9;
                v.Visible = false
            end
        
            esp.Box.HealthboxOutline.Thickness = 2
            esp.Box.Outline.Thickness = 2
            esp.Box.Healthbox.Filled = true
            esp.Box.HealthboxOutline.Filled = true
        
            for index, v in pairs(esp.Text) do
                v.Text = ""
                v.Color = Color3.new(1, 1, 1)
                v.OutlineColor = Color3.new(0, 0, 0)
                v.Center = true
                v.Outline = true
                v.Position = Vector2.new(100, 100)
                v.Size = 15
                v.Font = 1 -- 'UI', 'System', 'Plex', 'Monospace'
                v.Transparency = 0.9
                v.Visible = false
            end
        
            local function toggledrawing(value)
                for index, v in pairs(esp.Box) do
                    v.Visible = value
                end
                for index, v in pairs(esp.Text) do
                    v.Visible = value
                end
                for index, v in pairs(esp.Line) do
                    v.Visible = value
                end
            end
        
            local function changedrawingcolor(color)
                esp.Box["Main"].Color = color
                esp.Box["Healthbox"].Color = color
                for i,v in pairs(esp.Text) do
                    v.Color = color
                end
                for i,v in pairs(esp.Line) do
                    v.Color = color
                end
            end
        
            task.spawn(function()
                while task.wait() do
                    if v.Character ~= nil and v.Character:FindFirstChild("Humanoid") ~= nil and v.Character:FindFirstChild("Head") ~= nil and v.Character:FindFirstChild("HumanoidRootPart") ~= nil and v.Character.Humanoid.Health > 0 then --  and v.Character.Humanoid.RigType == Enum.HumanoidRigType.R6
                        local displayEsp = v.Character
                        if displayEsp then
                            local _,onscreen = dwCamera:WorldToScreenPoint(v.Character.HumanoidRootPart.Position)
                            displayEsp = onscreen
                        end
        
                        local orientation, sizee = v.Character:GetBoundingBox()
                        local width = (dwCamera.CFrame - dwCamera.CFrame.p) * Vector3.new((math.clamp(sizee.X, 1, 10) + 0.5) / 2, 0, 0)
                        local height = (dwCamera.CFrame - dwCamera.CFrame.p) * Vector3.new(0, (math.clamp(sizee.X, 1, 10) + 2) / 2, 0)
                        width = math.abs(dwCamera:WorldToViewportPoint(orientation.Position + width).X - dwCamera:WorldToViewportPoint(orientation.Position - width).X)
                        height = math.abs(dwCamera:WorldToViewportPoint(orientation.Position + height).Y - dwCamera:WorldToViewportPoint(orientation.Position - height).Y)
                        local size = Vector2.new(math.floor(width), math.floor(height))
                        size = Vector2.new(size.X % 2 == 0 and size.X or size.X + 1, size.Y % 2 == 0 and size.Y or size.Y + 1)
                        local rootPos = dwCamera:WorldToViewportPoint(v.Character.HumanoidRootPart.Position)
                        local magnitude = (v.Character.HumanoidRootPart.Position - dwCamera.CFrame.p).Magnitude
        
                        local TL = dwCamera:WorldToViewportPoint(v.Character.HumanoidRootPart.CFrame * CFrame.new(-3,3,0).p)
                        local TR = dwCamera:WorldToViewportPoint(v.Character.HumanoidRootPart.CFrame * CFrame.new(3,3,0).p)
                        local BL = dwCamera:WorldToViewportPoint(v.Character.HumanoidRootPart.CFrame * CFrame.new(-3,-3,0).p)
                        local BR = dwCamera:WorldToViewportPoint(v.Character.HumanoidRootPart.CFrame * CFrame.new(3,-3,0).p)
        
                        if module.Visual.Enabled and displayEsp and magnitude < module.Visual.ShowDistance then
                            if teamcheck(v) == false then
                                --Filledbox
                                esp.Box["Filledbox"].Visible = module.Visual.Filledbox and module.Visual.ShowTeam and module.Visual.Box
                                esp.Box["Filledbox"].Size = size
                                esp.Box["Filledbox"].Filled = module.Visual.Filledbox
                                esp.Box["Filledbox"].Transparency = module.Visual.FilledOpacity
                                esp.Box["Filledbox"].Position = Vector2.new(math.floor(rootPos.X), math.floor(rootPos.Y)) - (esp.Box["Main"].Size / 2)
        
                                --Box
                                esp.Box["Outline"].Visible = module.Visual.Box and module.Visual.ShowTeam
                                esp.Box["Outline"].Size = size
                                esp.Box["Outline"].Position = Vector2.new(math.floor(rootPos.X), math.floor(rootPos.Y)) - (esp.Box["Outline"].Size / 2)
                                esp.Box["Main"].Visible = module.Visual.Box and module.Visual.ShowTeam
                                esp.Box["Main"].Size = size
                                esp.Box["Main"].Position = Vector2.new(math.floor(rootPos.X), math.floor(rootPos.Y)) - (esp.Box["Main"].Size / 2)
        
                                --Healthbox
                                esp.Box["HealthboxOutline"].Visible = module.Visual.Healthbox and module.Visual.ShowTeam
                                esp.Box["HealthboxOutline"].Size = Vector2.new(1, size.Y * (1-((v.Character.Humanoid.MaxHealth - v.Character.Humanoid.Health) / v.Character.Humanoid.MaxHealth)))
                                esp.Box["HealthboxOutline"].Position = Vector2.new(math.floor(rootPos.X) - 5, math.floor(rootPos.Y) + (size.Y - math.floor(esp.Box["HealthboxOutline"].Size.Y))) - size / 2
                                esp.Box["Healthbox"].Visible = module.Visual.Healthbox and module.Visual.ShowTeam
                                esp.Box["Healthbox"].Size = Vector2.new(1, size.Y * (1-((v.Character.Humanoid.MaxHealth - v.Character.Humanoid.Health) / v.Character.Humanoid.MaxHealth)))
                                esp.Box["Healthbox"].Position = Vector2.new(math.floor(rootPos.X) - 5, math.floor(rootPos.Y) + (size.Y - math.floor(esp.Box["Healthbox"].Size.Y))) - size / 2
        
                                --Name
                                esp.Text["Name"].Visible = module.Visual.Name and module.Visual.ShowTeam
                                esp.Text["Name"].Position = Vector2.new(math.floor(rootPos.X), math.floor(rootPos.Y) - size.Y / 2 - 16)
                                esp.Text["Name"].Text = v.Name
        
                                --Distance
                                esp.Text["Distance"].Visible = module.Visual.Distance and module.Visual.ShowTeam
                                esp.Text["Distance"].Position = Vector2.new(math.floor(rootPos.X),math.floor(rootPos.Y + height * 0.5))
                                esp.Text["Distance"].Text = tostring(math.ceil(magnitude)).." studs"
        
                                --Snapline
                                esp.Line["Snapline"].Visible = module.Visual.Snaplines and module.Visual.ShowTeam
                                esp.Line["Snapline"].From = Vector2.new(dwCamera.ViewportSize.X/2, 120)
                                esp.Line["Snapline"].To = Vector2.new(math.floor(rootPos.X), math.floor(rootPos.Y))
                                changedrawingcolor(module.Visual.TeamColor)
                            else
                                --Filledbox
                                esp.Box["Filledbox"].Visible = module.Visual.Filledbox and module.Visual.Box
                                esp.Box["Filledbox"].Size = size
                                esp.Box["Filledbox"].Filled = module.Visual.Filledbox
                                esp.Box["Filledbox"].Transparency = module.Visual.FilledOpacity
                                esp.Box["Filledbox"].Position = Vector2.new(math.floor(rootPos.X), math.floor(rootPos.Y)) - (esp.Box["Main"].Size / 2)
        
                                --Box
                                esp.Box["Outline"].Visible = module.Visual.Box
                                esp.Box["Outline"].Size = size
                                esp.Box["Outline"].Position = Vector2.new(math.floor(rootPos.X), math.floor(rootPos.Y)) - (esp.Box["Outline"].Size / 2)
                                esp.Box["Main"].Visible = module.Visual.Box
                                esp.Box["Main"].Size = size
                                esp.Box["Main"].Position = Vector2.new(math.floor(rootPos.X), math.floor(rootPos.Y)) - (esp.Box["Main"].Size / 2)
        
                                --Healthbox
                                esp.Box["HealthboxOutline"].Visible = module.Visual.Healthbox
                                esp.Box["HealthboxOutline"].Size = Vector2.new(1, size.Y * (1-((v.Character.Humanoid.MaxHealth - v.Character.Humanoid.Health) / v.Character.Humanoid.MaxHealth)))
                                esp.Box["HealthboxOutline"].Position = Vector2.new(math.floor(rootPos.X) - 5, math.floor(rootPos.Y) + (size.Y - math.floor(esp.Box["HealthboxOutline"].Size.Y))) - size / 2
                                esp.Box["Healthbox"].Visible = module.Visual.Healthbox
                                esp.Box["Healthbox"].Size = Vector2.new(1, size.Y * (1-((v.Character.Humanoid.MaxHealth - v.Character.Humanoid.Health) / v.Character.Humanoid.MaxHealth)))
                                esp.Box["Healthbox"].Position = Vector2.new(math.floor(rootPos.X) - 5, math.floor(rootPos.Y) + (size.Y - math.floor(esp.Box["Healthbox"].Size.Y))) - size / 2
        
                                --Name
                                esp.Text["Name"].Visible = module.Visual.Name
                                esp.Text["Name"].Position = Vector2.new(math.floor(rootPos.X), math.floor(rootPos.Y) - size.Y / 2 - 16)
                                esp.Text["Name"].Text = v.Name
        
                                --Distance
                                esp.Text["Distance"].Visible = module.Visual.Distance
                                esp.Text["Distance"].Position = Vector2.new(math.floor(rootPos.X),math.floor(rootPos.Y + height * 0.5))
                                esp.Text["Distance"].Text = tostring(math.ceil(magnitude)).." studs"
        
                                --Snapline
                                esp.Line["Snapline"].Visible = module.Visual.Snaplines
                                esp.Line["Snapline"].From = Vector2.new(dwCamera.ViewportSize.X/2, 120)
                                esp.Line["Snapline"].To = Vector2.new(math.floor(rootPos.X), math.floor(rootPos.Y))
                                changedrawingcolor(module.Visual.EnemyColor)
                            end
                        else
                            toggledrawing(false)
                        end
                    else
                        toggledrawing(false)
                        if module.playerexists(v, "universal") == false then
                            --break
                        end
                    end
                end
            end)
end

function module.demonslayer(v)
    local esp = {
        Box = {Filledbox = Drawing.new("Square"), Outline = Drawing.new("Square"), Main = Drawing.new("Square"), HealthboxOutline = Drawing.new("Square"), Healthbox = Drawing.new("Square")},
        Text = {Distance = Drawing.new("Text"), Name = Drawing.new("Text"), NewText = Drawing.new("Text")},
        Line = {Snapline = Drawing.new("Line")}
    };

    for index, v in pairs(esp.Box) do
        v.Visible = false
        v.Position = Vector2.new(20, 20);
        v.Size = Vector2.new(20, 20); -- pixels offset from .Position
        v.Color = Color3.fromRGB(0, 0, 0);
        v.Filled = false;
        v.Transparency = 0.9;
        v.Thickness = 1
    end

    for index, v in pairs(esp.Line) do
        v.From = Vector2.new(20, 20); -- origin
        v.To = Vector2.new(50, 50); -- destination
        v.Color = Color3.new(0,0,0);
        v.Thickness = 1;
        v.Transparency = 0.9;
        v.Visible = false
    end

    esp.Box.HealthboxOutline.Thickness = 2
    esp.Box.Outline.Thickness = 2
    esp.Box.Healthbox.Filled = true
    esp.Box.HealthboxOutline.Filled = true

    for index, v in pairs(esp.Text) do
        v.Text = ""
        v.Color = Color3.new(1, 1, 1)
        v.OutlineColor = Color3.new(0, 0, 0)
        v.Center = true
        v.Outline = true
        v.Position = Vector2.new(100, 100)
        v.Size = 15
        v.Font = 1 -- 'UI', 'System', 'Plex', 'Monospace'
        v.Transparency = 0.9
        v.Visible = false
    end

    local function toggledrawing(value)
        for index, v in pairs(esp.Box) do
            v.Visible = value
        end
        for index, v in pairs(esp.Text) do
            v.Visible = value
        end
        for index, v in pairs(esp.Line) do
            v.Visible = value
        end
    end

    local function changedrawingcolor(color)
        esp.Box["Main"].Color = color
        esp.Box["Healthbox"].Color = color
        for i,v in pairs(esp.Text) do
            v.Color = color
        end
        for i,v in pairs(esp.Line) do
            v.Color = color
        end
    end

    task.spawn(function()
        while task.wait() do
            if v.Character ~= nil and v.Character:FindFirstChild("Humanoid") ~= nil and v.Character:FindFirstChild("Head") ~= nil and v.Character:FindFirstChild("HumanoidRootPart") ~= nil and v.Character.Humanoid.Health > 0 then --  and v.Character.Humanoid.RigType == Enum.HumanoidRigType.R6
                local displayEsp = v.Character
                if displayEsp then
                    local _,onscreen = dwCamera:WorldToScreenPoint(v.Character.HumanoidRootPart.Position)
                    displayEsp = onscreen
                end

                local orientation, sizee = v.Character:GetBoundingBox()
                local width = (dwCamera.CFrame - dwCamera.CFrame.p) * Vector3.new((math.clamp(sizee.X, 1, 10) + 0.5) / 2, 0, 0)
                local height = (dwCamera.CFrame - dwCamera.CFrame.p) * Vector3.new(0, (math.clamp(sizee.X, 1, 10) + 2) / 2, 0)
                width = math.abs(dwCamera:WorldToViewportPoint(orientation.Position + width).X - dwCamera:WorldToViewportPoint(orientation.Position - width).X)
                height = math.abs(dwCamera:WorldToViewportPoint(orientation.Position + height).Y - dwCamera:WorldToViewportPoint(orientation.Position - height).Y)
                local size = Vector2.new(math.floor(width), math.floor(height))
                size = Vector2.new(size.X % 2 == 0 and size.X or size.X + 1, size.Y % 2 == 0 and size.Y or size.Y + 1)
                local rootPos = dwCamera:WorldToViewportPoint(v.Character.HumanoidRootPart.Position)
                local magnitude = (v.Character.HumanoidRootPart.Position - dwCamera.CFrame.p).Magnitude

                local TL = dwCamera:WorldToViewportPoint(v.Character.HumanoidRootPart.CFrame * CFrame.new(-3,3,0).p)
                local TR = dwCamera:WorldToViewportPoint(v.Character.HumanoidRootPart.CFrame * CFrame.new(3,3,0).p)
                local BL = dwCamera:WorldToViewportPoint(v.Character.HumanoidRootPart.CFrame * CFrame.new(-3,-3,0).p)
                local BR = dwCamera:WorldToViewportPoint(v.Character.HumanoidRootPart.CFrame * CFrame.new(3,-3,0).p)

                if module.Visual.Enabled and displayEsp and magnitude < module.Visual.ShowDistance then
                    if teamcheck(v) == false then
                        --Filledbox
                        esp.Box["Filledbox"].Visible = module.Visual.Filledbox and module.Visual.ShowTeam and module.Visual.Box
                        esp.Box["Filledbox"].Size = size
                        esp.Box["Filledbox"].Filled = module.Visual.Filledbox
                        esp.Box["Filledbox"].Transparency = module.Visual.FilledOpacity
                        esp.Box["Filledbox"].Position = Vector2.new(math.floor(rootPos.X), math.floor(rootPos.Y)) - (esp.Box["Main"].Size / 2)

                        --Box
                        esp.Box["Outline"].Visible = module.Visual.Box and module.Visual.ShowTeam
                        esp.Box["Outline"].Size = size
                        esp.Box["Outline"].Position = Vector2.new(math.floor(rootPos.X), math.floor(rootPos.Y)) - (esp.Box["Outline"].Size / 2)
                        esp.Box["Main"].Visible = module.Visual.Box and module.Visual.ShowTeam
                        esp.Box["Main"].Size = size
                        esp.Box["Main"].Position = Vector2.new(math.floor(rootPos.X), math.floor(rootPos.Y)) - (esp.Box["Main"].Size / 2)

                        --Healthbox
                        esp.Box["HealthboxOutline"].Visible = module.Visual.Healthbox and module.Visual.ShowTeam
                        esp.Box["HealthboxOutline"].Size = Vector2.new(1, size.Y * (1-((v.Character.Humanoid.MaxHealth - v.Character.Humanoid.Health) / v.Character.Humanoid.MaxHealth)))
                        esp.Box["HealthboxOutline"].Position = Vector2.new(math.floor(rootPos.X) - 5, math.floor(rootPos.Y) + (size.Y - math.floor(esp.Box["HealthboxOutline"].Size.Y))) - size / 2
                        esp.Box["Healthbox"].Visible = module.Visual.Healthbox and module.Visual.ShowTeam
                        esp.Box["Healthbox"].Size = Vector2.new(1, size.Y * (1-((v.Character.Humanoid.MaxHealth - v.Character.Humanoid.Health) / v.Character.Humanoid.MaxHealth)))
                        esp.Box["Healthbox"].Position = Vector2.new(math.floor(rootPos.X) - 5, math.floor(rootPos.Y) + (size.Y - math.floor(esp.Box["Healthbox"].Size.Y))) - size / 2

                        --Nameds
                        esp.Text["Name"].Visible = module.Visual.Name and module.Visual.ShowTeam
                        esp.Text["Name"].Position = Vector2.new(math.floor(rootPos.X), math.floor(rootPos.Y) - size.Y / 2 - 16)
                        esp.Text["Name"].Text = v.Name.." | "..math.floor(v.Character.Humanoid.Health).."/"..math.floor(v.Character.Humanoid.MaxHealth)

                        --Distance
                        esp.Text["Distance"].Visible = module.Visual.Distance and module.Visual.ShowTeam
                        esp.Text["Distance"].Position = Vector2.new(math.floor(rootPos.X),math.floor(rootPos.Y + height * 0.5))
                        esp.Text["Distance"].Text = tostring(math.ceil(magnitude)).." studs"

                        --NewText
                        esp.Text["NewText"].Visible = module.Visual.NewText and module.Visual.ShowTeam
                        esp.Text["NewText"].Position = esp.Text["Distance"].Position + Vector2.new(0, 12) -- it copies the distance pos and the vector2 is me adding pos so it can be either under or above
                        esp.Text["NewText"].Text = "Clan: "..game:GetService("ReplicatedStorage")["Player_Data"][v.Name].Clan.Value.."\nDemon Art: "..game:GetService("ReplicatedStorage")["Player_Data"][v.Name]["Demon_Art"].Value.."\nPower: "..tostring(game:GetService("ReplicatedStorage")["Player_Data"][v.Name].Power.Value).."\nYen/Money: "..game:GetService("ReplicatedStorage")["Player_Data"][v.Name].Yen.Value.."\nWinstreak: "..game:GetService("ReplicatedStorage")["Player_Data"][v.Name].winstreak.Value.."\nSlot: "..game:GetService("Players")[v.Name].Slot.Value

                        --its fine since your gonna replace it each time u update.
                        --Snapline
                        esp.Line["Snapline"].Visible = module.Visual.Snaplines and module.Visual.ShowTeam
                        esp.Line["Snapline"].From = Vector2.new(dwCamera.ViewportSize.X/2, 120)
                        esp.Line["Snapline"].To = Vector2.new(math.floor(rootPos.X), math.floor(rootPos.Y))
                        changedrawingcolor(module.Visual.TeamColor)
                    else
                        --Filledbox
                        esp.Box["Filledbox"].Visible = module.Visual.Filledbox and module.Visual.Box
                        esp.Box["Filledbox"].Size = size
                        esp.Box["Filledbox"].Filled = module.Visual.Filledbox
                        esp.Box["Filledbox"].Transparency = module.Visual.FilledOpacity
                        esp.Box["Filledbox"].Position = Vector2.new(math.floor(rootPos.X), math.floor(rootPos.Y)) - (esp.Box["Main"].Size / 2)

                        --Box
                        esp.Box["Outline"].Visible = module.Visual.Box
                        esp.Box["Outline"].Size = size
                        esp.Box["Outline"].Position = Vector2.new(math.floor(rootPos.X), math.floor(rootPos.Y)) - (esp.Box["Outline"].Size / 2)
                        esp.Box["Main"].Visible = module.Visual.Box
                        esp.Box["Main"].Size = size
                        esp.Box["Main"].Position = Vector2.new(math.floor(rootPos.X), math.floor(rootPos.Y)) - (esp.Box["Main"].Size / 2)

                        --Healthbox
                        esp.Box["HealthboxOutline"].Visible = module.Visual.Healthbox
                        esp.Box["HealthboxOutline"].Size = Vector2.new(1, size.Y * (1-((v.Character.Humanoid.MaxHealth - v.Character.Humanoid.Health) / v.Character.Humanoid.MaxHealth)))
                        esp.Box["HealthboxOutline"].Position = Vector2.new(math.floor(rootPos.X) - 5, math.floor(rootPos.Y) + (size.Y - math.floor(esp.Box["HealthboxOutline"].Size.Y))) - size / 2
                        esp.Box["Healthbox"].Visible = module.Visual.Healthbox
                        esp.Box["Healthbox"].Size = Vector2.new(1, size.Y * (1-((v.Character.Humanoid.MaxHealth - v.Character.Humanoid.Health) / v.Character.Humanoid.MaxHealth)))
                        esp.Box["Healthbox"].Position = Vector2.new(math.floor(rootPos.X) - 5, math.floor(rootPos.Y) + (size.Y - math.floor(esp.Box["Healthbox"].Size.Y))) - size / 2

                        --Nameds
                        esp.Text["Name"].Visible = module.Visual.Name
                        esp.Text["Name"].Position = Vector2.new(math.floor(rootPos.X), math.floor(rootPos.Y) - size.Y / 2 - 16)
                        esp.Text["Name"].Text = v.Name.." | "..math.floor(v.Character.Humanoid.Health).."/"..math.floor(v.Character.Humanoid.MaxHealth)

                        --Distance
                        esp.Text["Distance"].Visible = module.Visual.Distance
                        esp.Text["Distance"].Position = Vector2.new(math.floor(rootPos.X),math.floor(rootPos.Y + height * 0.5))
                        esp.Text["Distance"].Text = tostring(math.ceil(magnitude)).." studs"

                        --NewText
                        esp.Text["NewText"].Visible = module.Visual.NewText
                        esp.Text["NewText"].Position = esp.Text["Distance"].Position + Vector2.new(0, 12) -- it copies the distance pos and the vector2 is me adding pos so it can be either under or above
                        esp.Text["NewText"].Text = "Clan: "..game:GetService("ReplicatedStorage")["Player_Data"][v.Name].Clan.Value.."\nDemon Art: "..game:GetService("ReplicatedStorage")["Player_Data"][v.Name]["Demon_Art"].Value.."\nPower: "..game:GetService("ReplicatedStorage")["Player_Data"][v.Name].Power.Value.."\nYen/Money: "..game:GetService("ReplicatedStorage")["Player_Data"][v.Name].Yen.Value.."\nWinstreak: "..game:GetService("ReplicatedStorage")["Player_Data"][v.Name].winstreak.Value.."\nSlot: "..game:GetService("Players")[v.Name].Slot.Value

                        --Snapline
                        esp.Line["Snapline"].Visible = module.Visual.Snaplines
                        esp.Line["Snapline"].From = Vector2.new(dwCamera.ViewportSize.X/2, 120)
                        esp.Line["Snapline"].To = Vector2.new(math.floor(rootPos.X), math.floor(rootPos.Y))
                        changedrawingcolor(module.Visual.EnemyColor)
                    end
                else
                    toggledrawing(false)
                end
            else
                toggledrawing(false)
                if module.playerexists(v, "universal") == false then
                    --break
                end
            end
        end
    end)
end

function module.demonslayernpc(v)
    local esp = {
        Box = {Filledbox = Drawing.new("Square"), Outline = Drawing.new("Square"), Main = Drawing.new("Square"), HealthboxOutline = Drawing.new("Square"), Healthbox = Drawing.new("Square")},
        Text = {Distance = Drawing.new("Text"), Name = Drawing.new("Text")},
        Line = {Snapline = Drawing.new("Line")}
    };

    for index, v in pairs(esp.Box) do
        v.Visible = false
        v.Position = Vector2.new(20, 20);
        v.Size = Vector2.new(20, 20); -- pixels offset from .Position
        v.Color = Color3.fromRGB(0, 0, 0);
        v.Filled = false;
        v.Transparency = 0.9;
        v.Thickness = 1
    end

    for index, v in pairs(esp.Line) do
        v.From = Vector2.new(20, 20); -- origin
        v.To = Vector2.new(50, 50); -- destination
        v.Color = Color3.new(0,0,0);
        v.Thickness = 1;
        v.Transparency = 0.9;
        v.Visible = false
    end

    esp.Box.HealthboxOutline.Thickness = 2
    esp.Box.Outline.Thickness = 2
    esp.Box.Healthbox.Filled = true
    esp.Box.HealthboxOutline.Filled = true

    for index, v in pairs(esp.Text) do
        v.Text = ""
        v.Color = Color3.new(1, 1, 1)
        v.OutlineColor = Color3.new(0, 0, 0)
        v.Center = true
        v.Outline = true
        v.Position = Vector2.new(100, 100)
        v.Size = 15
        v.Font = 1 -- 'UI', 'System', 'Plex', 'Monospace'
        v.Transparency = 0.9
        v.Visible = false
    end

    local function toggledrawing(value)
        for index, v in pairs(esp.Box) do
            v.Visible = value
        end
        for index, v in pairs(esp.Text) do
            v.Visible = value
        end
        for index, v in pairs(esp.Line) do
            v.Visible = value
        end
    end

    local function changedrawingcolor(color)
        esp.Box["Main"].Color = color
        esp.Box["Healthbox"].Color = color
        for i,v in pairs(esp.Text) do
            v.Color = color
        end
        for i,v in pairs(esp.Line) do
            v.Color = color
        end
    end

    task.spawn(function()
        while task.wait() do
            if v ~= nil and v:FindFirstChild("Humanoid") ~= nil and v:FindFirstChild("Head") ~= nil and v:FindFirstChild("HumanoidRootPart") ~= nil and v.Humanoid.Health > 0 then --  and v.Humanoid.RigType == Enum.HumanoidRigType.R6
                local displayEsp = v
                if displayEsp then
                    local _,onscreen = dwCamera:WorldToScreenPoint(v.HumanoidRootPart.Position)
                    displayEsp = onscreen
                end

                local orientation, sizee = v:GetBoundingBox()
                local width = (dwCamera.CFrame - dwCamera.CFrame.p) * Vector3.new((math.clamp(sizee.X, 1, 10) + 0.5) / 2, 0, 0)
                local height = (dwCamera.CFrame - dwCamera.CFrame.p) * Vector3.new(0, (math.clamp(sizee.X, 1, 10) + 2) / 2, 0)
                width = math.abs(dwCamera:WorldToViewportPoint(orientation.Position + width).X - dwCamera:WorldToViewportPoint(orientation.Position - width).X)
                height = math.abs(dwCamera:WorldToViewportPoint(orientation.Position + height).Y - dwCamera:WorldToViewportPoint(orientation.Position - height).Y)
                local size = Vector2.new(math.floor(width), math.floor(height))
                size = Vector2.new(size.X % 2 == 0 and size.X or size.X + 1, size.Y % 2 == 0 and size.Y or size.Y + 1)
                local rootPos = dwCamera:WorldToViewportPoint(v.HumanoidRootPart.Position)
                local magnitude = (v.HumanoidRootPart.Position - dwCamera.CFrame.p).Magnitude

                local TL = dwCamera:WorldToViewportPoint(v.HumanoidRootPart.CFrame * CFrame.new(-3,3,0).p)
                local TR = dwCamera:WorldToViewportPoint(v.HumanoidRootPart.CFrame * CFrame.new(3,3,0).p)
                local BL = dwCamera:WorldToViewportPoint(v.HumanoidRootPart.CFrame * CFrame.new(-3,-3,0).p)
                local BR = dwCamera:WorldToViewportPoint(v.HumanoidRootPart.CFrame * CFrame.new(3,-3,0).p)

                if module.Visual.slayersnpc.Enabled and displayEsp and magnitude < module.Visual.slayersnpc.ShowDistance then
                    --Filledbox
                    esp.Box["Filledbox"].Visible = module.Visual.slayersnpc.Filledbox and module.Visual.slayersnpc.Box
                    esp.Box["Filledbox"].Size = size
                    esp.Box["Filledbox"].Filled = module.Visual.slayersnpc.Filledbox
                    esp.Box["Filledbox"].Transparency = module.Visual.slayersnpc.FilledOpacity
                    esp.Box["Filledbox"].Position = Vector2.new(math.floor(rootPos.X), math.floor(rootPos.Y)) - (esp.Box["Main"].Size / 2)

                    --Box
                    esp.Box["Outline"].Visible = module.Visual.slayersnpc.Box
                    esp.Box["Outline"].Size = size
                    esp.Box["Outline"].Position = Vector2.new(math.floor(rootPos.X), math.floor(rootPos.Y)) - (esp.Box["Outline"].Size / 2)
                    esp.Box["Main"].Visible = module.Visual.slayersnpc.Box
                    esp.Box["Main"].Size = size
                    esp.Box["Main"].Position = Vector2.new(math.floor(rootPos.X), math.floor(rootPos.Y)) - (esp.Box["Main"].Size / 2)

                    --Healthbox
                    esp.Box["HealthboxOutline"].Visible = module.Visual.slayersnpc.Healthbox
                    esp.Box["HealthboxOutline"].Size = Vector2.new(1, size.Y * (1-((v.Humanoid.MaxHealth - v.Humanoid.Health) / v.Humanoid.MaxHealth)))
                    esp.Box["HealthboxOutline"].Position = Vector2.new(math.floor(rootPos.X) - 5, math.floor(rootPos.Y) + (size.Y - math.floor(esp.Box["HealthboxOutline"].Size.Y))) - size / 2
                    esp.Box["Healthbox"].Visible = module.Visual.slayersnpc.Healthbox
                    esp.Box["Healthbox"].Size = Vector2.new(1, size.Y * (1-((v.Humanoid.MaxHealth - v.Humanoid.Health) / v.Humanoid.MaxHealth)))
                    esp.Box["Healthbox"].Position = Vector2.new(math.floor(rootPos.X) - 5, math.floor(rootPos.Y) + (size.Y - math.floor(esp.Box["Healthbox"].Size.Y))) - size / 2

                    --Nameds
                    esp.Text["Name"].Visible = module.Visual.slayersnpc.Name
                    esp.Text["Name"].Position = Vector2.new(math.floor(rootPos.X), math.floor(rootPos.Y) - size.Y / 2 - 16)
                    esp.Text["Name"].Text = v.Name.." | "..math.floor(v.Humanoid.Health).."/"..math.floor(v.Humanoid.MaxHealth)

                    --Distance
                    esp.Text["Distance"].Visible = module.Visual.slayersnpc.Distance
                    esp.Text["Distance"].Position = Vector2.new(math.floor(rootPos.X),math.floor(rootPos.Y + height * 0.5))
                    esp.Text["Distance"].Text = tostring(math.ceil(magnitude)).." studs"

                    --Snapline
                    esp.Line["Snapline"].Visible = module.Visual.slayersnpc.Snaplines
                    esp.Line["Snapline"].From = Vector2.new(dwCamera.ViewportSize.X/2, 120)
                    esp.Line["Snapline"].To = Vector2.new(math.floor(rootPos.X), math.floor(rootPos.Y))
                    changedrawingcolor(module.Visual.slayersnpc.EnemyColor)
                else
                    toggledrawing(false)
                end
            else
                toggledrawing(false)
                if module.playerexists(v, "universal") == false then
                    --break
                end
            end
        end
    end)
end

function module.aotesp(v)
    local esp = {
        Box = {Filledbox = Drawing.new("Square"), Outline = Drawing.new("Square"), Main = Drawing.new("Square"), HealthboxOutline = Drawing.new("Square"), Healthbox = Drawing.new("Square")},
        Text = {Distance = Drawing.new("Text"), Name = Drawing.new("Text"), titaninfo = Drawing.new("Text")},
        Line = {Snapline = Drawing.new("Line")}
    };

    for index, v in pairs(esp.Box) do
        v.Visible = false
        v.Position = Vector2.new(20, 20);
        v.Size = Vector2.new(20, 20); -- pixels offset from .Position
        v.Color = Color3.fromRGB(0, 0, 0);
        v.Filled = false;
        v.Transparency = 0.9;
        v.Thickness = 1
    end

    for index, v in pairs(esp.Line) do
        v.From = Vector2.new(20, 20); -- origin
        v.To = Vector2.new(50, 50); -- destination
        v.Color = Color3.new(0,0,0);
        v.Thickness = 1;
        v.Transparency = 0.9;
        v.Visible = false
    end

    esp.Box.HealthboxOutline.Thickness = 2
    esp.Box.Outline.Thickness = 2
    esp.Box.Healthbox.Filled = true
    esp.Box.HealthboxOutline.Filled = true

    for index, v in pairs(esp.Text) do
        v.Text = ""
        v.Color = Color3.new(1, 1, 1)
        v.OutlineColor = Color3.new(0, 0, 0)
        v.Center = true
        v.Outline = true
        v.Position = Vector2.new(100, 100)
        v.Size = 15
        v.Font = 1 -- 'UI', 'System', 'Plex', 'Monospace'
        v.Transparency = 0.9
        v.Visible = false
    end

    local function toggledrawing(value)
        for index, v in pairs(esp.Box) do
            v.Visible = value
        end
        for index, v in pairs(esp.Text) do
            v.Visible = value
        end
        for index, v in pairs(esp.Line) do
            v.Visible = value
        end
    end

    local function changedrawingcolor(color)
        esp.Box["Main"].Color = color
        esp.Box["Healthbox"].Color = color
        for i,v in pairs(esp.Text) do
            v.Color = color
        end
        for i,v in pairs(esp.Line) do
            v.Color = color
        end
    end

    task.spawn(function()
        while task.wait() do
            if v ~= nil and v:FindFirstChild("Titan") ~= nil and v:FindFirstChild("Head") ~= nil and v:FindFirstChild("HumanoidRootPart") ~= nil and v.Titan.Health > 0 then --  and v.Titan.RigType == Enum.HumanoidRigType.R6
                local displayEsp = v
                if displayEsp then
                    local _,onscreen = dwCamera:WorldToScreenPoint(v.HumanoidRootPart.Position)
                    displayEsp = onscreen
                end

                local orientation, sizee = v:GetBoundingBox()
                local width = (dwCamera.CFrame - dwCamera.CFrame.p) * Vector3.new((math.clamp(sizee.X, 1, 10) + 0.5) / 2, 0, 0)
                local height = (dwCamera.CFrame - dwCamera.CFrame.p) * Vector3.new(0, (math.clamp(sizee.X, 1, 10) + 2) / 2, 0)
                width = math.abs(dwCamera:WorldToViewportPoint(orientation.Position + width).X - dwCamera:WorldToViewportPoint(orientation.Position - width).X)
                height = math.abs(dwCamera:WorldToViewportPoint(orientation.Position + height).Y - dwCamera:WorldToViewportPoint(orientation.Position - height).Y)
                local size = Vector2.new(math.floor(width), math.floor(height))
                size = Vector2.new(size.X % 2 == 0 and size.X or size.X + 1, size.Y % 2 == 0 and size.Y or size.Y + 1)
                local rootPos = dwCamera:WorldToViewportPoint(v.HumanoidRootPart.Position)
                local magnitude = (v.HumanoidRootPart.Position - dwCamera.CFrame.p).Magnitude

                local TL = dwCamera:WorldToViewportPoint(v.HumanoidRootPart.CFrame * CFrame.new(-3,3,0).p)
                local TR = dwCamera:WorldToViewportPoint(v.HumanoidRootPart.CFrame * CFrame.new(3,3,0).p)
                local BL = dwCamera:WorldToViewportPoint(v.HumanoidRootPart.CFrame * CFrame.new(-3,-3,0).p)
                local BR = dwCamera:WorldToViewportPoint(v.HumanoidRootPart.CFrame * CFrame.new(3,-3,0).p)

                if module.Visual.aottitanesp.Enabled and displayEsp and magnitude < module.Visual.aottitanesp.ShowDistance then
                    --Filledbox
                    esp.Box["Filledbox"].Visible = module.Visual.aottitanesp.Filledbox and module.Visual.aottitanesp.Box
                    esp.Box["Filledbox"].Size = size
                    esp.Box["Filledbox"].Filled = module.Visual.aottitanesp.Filledbox
                    esp.Box["Filledbox"].Transparency = module.Visual.aottitanesp.FilledOpacity
                    esp.Box["Filledbox"].Position = Vector2.new(math.floor(rootPos.X), math.floor(rootPos.Y)) - (esp.Box["Main"].Size / 2)

                    --Box
                    esp.Box["Outline"].Visible = module.Visual.aottitanesp.Box
                    esp.Box["Outline"].Size = size
                    esp.Box["Outline"].Position = Vector2.new(math.floor(rootPos.X), math.floor(rootPos.Y)) - (esp.Box["Outline"].Size / 2)
                    esp.Box["Main"].Visible = module.Visual.aottitanesp.Box
                    esp.Box["Main"].Size = size
                    esp.Box["Main"].Position = Vector2.new(math.floor(rootPos.X), math.floor(rootPos.Y)) - (esp.Box["Main"].Size / 2)

                    --Healthbox
                    esp.Box["HealthboxOutline"].Visible = module.Visual.aottitanesp.Healthbox
                    esp.Box["HealthboxOutline"].Size = Vector2.new(1, size.Y * (1-((v.Titan.MaxHealth - v.Titan.Health) / v.Titan.MaxHealth)))
                    esp.Box["HealthboxOutline"].Position = Vector2.new(math.floor(rootPos.X) - 5, math.floor(rootPos.Y) + (size.Y - math.floor(esp.Box["HealthboxOutline"].Size.Y))) - size / 2
                    esp.Box["Healthbox"].Visible = module.Visual.aottitanesp.Healthbox
                    esp.Box["Healthbox"].Size = Vector2.new(1, size.Y * (1-((v.Titan.MaxHealth - v.Titan.Health) / v.Titan.MaxHealth)))
                    esp.Box["Healthbox"].Position = Vector2.new(math.floor(rootPos.X) - 5, math.floor(rootPos.Y) + (size.Y - math.floor(esp.Box["Healthbox"].Size.Y))) - size / 2

                    --Nameds
                    esp.Text["Name"].Visible = module.Visual.aottitanesp.Name
                    esp.Text["Name"].Position = Vector2.new(math.floor(rootPos.X), math.floor(rootPos.Y) - size.Y / 2 - 16)
                    esp.Text["Name"].Text = v.Name.." | "..math.floor(v.Titan.Health).."/"..math.floor(v.Titan.MaxHealth)

                    --titaninfo
                    esp.Text["titaninfo"].Visible = module.Visual.aottitanesp.titaninfo and module.Visual.ShowTeam
                    esp.Text["titaninfo"].Position = esp.Text["Distance"].Position + Vector2.new(0, 12) -- it copies the distance pos and the vector2 is me adding pos so it can be either under or above
                    esp.Text["titaninfo"].Text = "Titan Size: "..v.Sizev.Value.."\nEnergy: "..v.Energy.Value

                    --Distance
                    esp.Text["Distance"].Visible = module.Visual.aottitanesp.Distance
                    esp.Text["Distance"].Position = Vector2.new(math.floor(rootPos.X),math.floor(rootPos.Y + height * 0.5))
                    esp.Text["Distance"].Text = tostring(math.ceil(magnitude)).." studs"

                    --Snapline
                    esp.Line["Snapline"].Visible = module.Visual.aottitanesp.Snaplines
                    esp.Line["Snapline"].From = Vector2.new(dwCamera.ViewportSize.X/2, 120)
                    esp.Line["Snapline"].To = Vector2.new(math.floor(rootPos.X), math.floor(rootPos.Y))
                    changedrawingcolor(module.Visual.aottitanesp.EnemyColor)
                else
                    toggledrawing(false)
                end
            else
                toggledrawing(false)
                if module.playerexists(v, "universal") == false then
                    --break
                end
            end
        end
    end)
end

function module.aotevo(v)
    local esp = {
        Box = {Filledbox = Drawing.new("Square"), Outline = Drawing.new("Square"), Main = Drawing.new("Square"), HealthboxOutline = Drawing.new("Square"), Healthbox = Drawing.new("Square")},
        Text = {Distance = Drawing.new("Text"), Name = Drawing.new("Text")},
        Line = {Snapline = Drawing.new("Line")}
    };

    for index, v in pairs(esp.Box) do
        v.Visible = false
        v.Position = Vector2.new(20, 20);
        v.Size = Vector2.new(20, 20); -- pixels offset from .Position
        v.Color = Color3.fromRGB(0, 0, 0);
        v.Filled = false;
        v.Transparency = 0.9;
        v.Thickness = 1
    end

    for index, v in pairs(esp.Line) do
        v.From = Vector2.new(20, 20); -- origin
        v.To = Vector2.new(50, 50); -- destination
        v.Color = Color3.new(0,0,0);
        v.Thickness = 1;
        v.Transparency = 0.9;
        v.Visible = false
    end

    esp.Box.HealthboxOutline.Thickness = 2
    esp.Box.Outline.Thickness = 2
    esp.Box.Healthbox.Filled = true
    esp.Box.HealthboxOutline.Filled = true

    for index, v in pairs(esp.Text) do
        v.Text = ""
        v.Color = Color3.new(1, 1, 1)
        v.OutlineColor = Color3.new(0, 0, 0)
        v.Center = true
        v.Outline = true
        v.Position = Vector2.new(100, 100)
        v.Size = 15
        v.Font = 1 -- 'UI', 'System', 'Plex', 'Monospace'
        v.Transparency = 0.9
        v.Visible = false
    end

    local function toggledrawing(value)
        for index, v in pairs(esp.Box) do
            v.Visible = value
        end
        for index, v in pairs(esp.Text) do
            v.Visible = value
        end
        for index, v in pairs(esp.Line) do
            v.Visible = value
        end
    end

    local function changedrawingcolor(color)
        esp.Box["Main"].Color = color
        esp.Box["Healthbox"].Color = color
        for i,v in pairs(esp.Text) do
            v.Color = color
        end
        for i,v in pairs(esp.Line) do
            v.Color = color
        end
    end

    task.spawn(function()
        while task.wait() do
            if v ~= nil and v:FindFirstChild("Humanoid") ~= nil and v:FindFirstChild("Head") ~= nil and v:FindFirstChild("HumanoidRootPart") ~= nil and v.Humanoid.Health > 0 then --  and v.Humanoid.RigType == Enum.HumanoidRigType.R6
                local displayEsp = v
                if displayEsp then
                    local _,onscreen = dwCamera:WorldToScreenPoint(v.HumanoidRootPart.Position)
                    displayEsp = onscreen
                end

                local orientation, sizee = v:GetBoundingBox()
                local width = (dwCamera.CFrame - dwCamera.CFrame.p) * Vector3.new((math.clamp(sizee.X, 1, 10) + 0.5) / 2, 0, 0)
                local height = (dwCamera.CFrame - dwCamera.CFrame.p) * Vector3.new(0, (math.clamp(sizee.X, 1, 10) + 2) / 2, 0)
                width = math.abs(dwCamera:WorldToViewportPoint(orientation.Position + width).X - dwCamera:WorldToViewportPoint(orientation.Position - width).X)
                height = math.abs(dwCamera:WorldToViewportPoint(orientation.Position + height).Y - dwCamera:WorldToViewportPoint(orientation.Position - height).Y)
                local size = Vector2.new(math.floor(width), math.floor(height))
                size = Vector2.new(size.X % 2 == 0 and size.X or size.X + 1, size.Y % 2 == 0 and size.Y or size.Y + 1)
                local rootPos = dwCamera:WorldToViewportPoint(v.HumanoidRootPart.Position)
                local magnitude = (v.HumanoidRootPart.Position - dwCamera.CFrame.p).Magnitude

                local TL = dwCamera:WorldToViewportPoint(v.HumanoidRootPart.CFrame * CFrame.new(-3,3,0).p)
                local TR = dwCamera:WorldToViewportPoint(v.HumanoidRootPart.CFrame * CFrame.new(3,3,0).p)
                local BL = dwCamera:WorldToViewportPoint(v.HumanoidRootPart.CFrame * CFrame.new(-3,-3,0).p)
                local BR = dwCamera:WorldToViewportPoint(v.HumanoidRootPart.CFrame * CFrame.new(3,-3,0).p)

                if module.Visual.aotevoesp.Enabled and displayEsp and magnitude < module.Visual.aotevoesp.ShowDistance then
                    --Filledbox
                    esp.Box["Filledbox"].Visible = module.Visual.aotevoesp.Filledbox and module.Visual.aotevoesp.Box
                    esp.Box["Filledbox"].Size = size
                    esp.Box["Filledbox"].Filled = module.Visual.aotevoesp.Filledbox
                    esp.Box["Filledbox"].Transparency = module.Visual.aotevoesp.FilledOpacity
                    esp.Box["Filledbox"].Position = Vector2.new(math.floor(rootPos.X), math.floor(rootPos.Y)) - (esp.Box["Main"].Size / 2)

                    --Box
                    esp.Box["Outline"].Visible = module.Visual.aotevoesp.Box
                    esp.Box["Outline"].Size = size
                    esp.Box["Outline"].Position = Vector2.new(math.floor(rootPos.X), math.floor(rootPos.Y)) - (esp.Box["Outline"].Size / 2)
                    esp.Box["Main"].Visible = module.Visual.aotevoesp.Box
                    esp.Box["Main"].Size = size
                    esp.Box["Main"].Position = Vector2.new(math.floor(rootPos.X), math.floor(rootPos.Y)) - (esp.Box["Main"].Size / 2)

                    --Healthbox
                    esp.Box["HealthboxOutline"].Visible = module.Visual.aotevoesp.Healthbox
                    esp.Box["HealthboxOutline"].Size = Vector2.new(1, size.Y * (1-((v.Humanoid.MaxHealth - v.Humanoid.Health) / v.Humanoid.MaxHealth)))
                    esp.Box["HealthboxOutline"].Position = Vector2.new(math.floor(rootPos.X) - 5, math.floor(rootPos.Y) + (size.Y - math.floor(esp.Box["HealthboxOutline"].Size.Y))) - size / 2
                    esp.Box["Healthbox"].Visible = module.Visual.aotevoesp.Healthbox
                    esp.Box["Healthbox"].Size = Vector2.new(1, size.Y * (1-((v.Humanoid.MaxHealth - v.Humanoid.Health) / v.Humanoid.MaxHealth)))
                    esp.Box["Healthbox"].Position = Vector2.new(math.floor(rootPos.X) - 5, math.floor(rootPos.Y) + (size.Y - math.floor(esp.Box["Healthbox"].Size.Y))) - size / 2

                    --Nameds
                    esp.Text["Name"].Visible = module.Visual.aotevoesp.Name
                    esp.Text["Name"].Position = Vector2.new(math.floor(rootPos.X), math.floor(rootPos.Y) - size.Y / 2 - 16)
                    esp.Text["Name"].Text = v.Name.." | "..math.floor(v.Humanoid.Health).."/"..math.floor(v.Humanoid.MaxHealth)

                    --Distance
                    esp.Text["Distance"].Visible = module.Visual.aotevoesp.Distance
                    esp.Text["Distance"].Position = Vector2.new(math.floor(rootPos.X),math.floor(rootPos.Y + height * 0.5))
                    esp.Text["Distance"].Text = tostring(math.ceil(magnitude)).." studs"

                    --Snapline
                    esp.Line["Snapline"].Visible = module.Visual.aotevoesp.Snaplines
                    esp.Line["Snapline"].From = Vector2.new(dwCamera.ViewportSize.X/2, 120)
                    esp.Line["Snapline"].To = Vector2.new(math.floor(rootPos.X), math.floor(rootPos.Y))
                    changedrawingcolor(module.Visual.aotevoesp.EnemyColor)
                else
                    toggledrawing(false)
                end
            else
                toggledrawing(false)
                if module.playerexists(v, "universal") == false then
                    --break
                end
            end
        end
    end)
end

function module.aotevoplrs(v)
    local esp = {
        Box = {Filledbox = Drawing.new("Square"), Outline = Drawing.new("Square"), Main = Drawing.new("Square"), HealthboxOutline = Drawing.new("Square"), Healthbox = Drawing.new("Square")},
        Text = {Distance = Drawing.new("Text"), Name = Drawing.new("Text"), plrinfo = Drawing.new("Text")},
        Line = {Snapline = Drawing.new("Line")}
    };

    for index, v in pairs(esp.Box) do
        v.Visible = false
        v.Position = Vector2.new(20, 20);
        v.Size = Vector2.new(20, 20); -- pixels offset from .Position
        v.Color = Color3.fromRGB(0, 0, 0);
        v.Filled = false;
        v.Transparency = 0.9;
        v.Thickness = 1
    end

    for index, v in pairs(esp.Line) do
        v.From = Vector2.new(20, 20); -- origin
        v.To = Vector2.new(50, 50); -- destination
        v.Color = Color3.new(0,0,0);
        v.Thickness = 1;
        v.Transparency = 0.9;
        v.Visible = false
    end

    esp.Box.HealthboxOutline.Thickness = 2
    esp.Box.Outline.Thickness = 2
    esp.Box.Healthbox.Filled = true
    esp.Box.HealthboxOutline.Filled = true

    for index, v in pairs(esp.Text) do
        v.Text = ""
        v.Color = Color3.new(1, 1, 1)
        v.OutlineColor = Color3.new(0, 0, 0)
        v.Center = true
        v.Outline = true
        v.Position = Vector2.new(100, 100)
        v.Size = 15
        v.Font = 1 -- 'UI', 'System', 'Plex', 'Monospace'
        v.Transparency = 0.9
        v.Visible = false
    end

    local function toggledrawing(value)
        for index, v in pairs(esp.Box) do
            v.Visible = value
        end
        for index, v in pairs(esp.Text) do
            v.Visible = value
        end
        for index, v in pairs(esp.Line) do
            v.Visible = value
        end
    end

    local function changedrawingcolor(color)
        esp.Box["Main"].Color = color
        esp.Box["Healthbox"].Color = color
        for i,v in pairs(esp.Text) do
            v.Color = color
        end
        for i,v in pairs(esp.Line) do
            v.Color = color
        end
    end

    task.spawn(function()
        while task.wait() do
            if v.Character ~= nil and v.Character:FindFirstChild("Humanoid") ~= nil and v.Character:FindFirstChild("Head") ~= nil and v.Character:FindFirstChild("HumanoidRootPart") ~= nil and v.Character.Humanoid.Health > 0 then --  and v.Character.Humanoid.RigType == Enum.HumanoidRigType.R6
                local displayEsp = v.Character
                if displayEsp then
                    local _,onscreen = dwCamera:WorldToScreenPoint(v.Character.HumanoidRootPart.Position)
                    displayEsp = onscreen
                end

                local orientation, sizee = v.Character:GetBoundingBox()
                local width = (dwCamera.CFrame - dwCamera.CFrame.p) * Vector3.new((math.clamp(sizee.X, 1, 10) + 0.5) / 2, 0, 0)
                local height = (dwCamera.CFrame - dwCamera.CFrame.p) * Vector3.new(0, (math.clamp(sizee.X, 1, 10) + 2) / 2, 0)
                width = math.abs(dwCamera:WorldToViewportPoint(orientation.Position + width).X - dwCamera:WorldToViewportPoint(orientation.Position - width).X)
                height = math.abs(dwCamera:WorldToViewportPoint(orientation.Position + height).Y - dwCamera:WorldToViewportPoint(orientation.Position - height).Y)
                local size = Vector2.new(math.floor(width), math.floor(height))
                size = Vector2.new(size.X % 2 == 0 and size.X or size.X + 1, size.Y % 2 == 0 and size.Y or size.Y + 1)
                local rootPos = dwCamera:WorldToViewportPoint(v.Character.HumanoidRootPart.Position)
                local magnitude = (v.Character.HumanoidRootPart.Position - dwCamera.CFrame.p).Magnitude

                local TL = dwCamera:WorldToViewportPoint(v.Character.HumanoidRootPart.CFrame * CFrame.new(-3,3,0).p)
                local TR = dwCamera:WorldToViewportPoint(v.Character.HumanoidRootPart.CFrame * CFrame.new(3,3,0).p)
                local BL = dwCamera:WorldToViewportPoint(v.Character.HumanoidRootPart.CFrame * CFrame.new(-3,-3,0).p)
                local BR = dwCamera:WorldToViewportPoint(v.Character.HumanoidRootPart.CFrame * CFrame.new(3,-3,0).p)

                if module.Visual.Enabled and displayEsp and magnitude < module.Visual.ShowDistance then
                    if teamcheck(v) == false then
                        --Filledbox
                        esp.Box["Filledbox"].Visible = module.Visual.Filledbox and module.Visual.ShowTeam and module.Visual.Box
                        esp.Box["Filledbox"].Size = size
                        esp.Box["Filledbox"].Filled = module.Visual.Filledbox
                        esp.Box["Filledbox"].Transparency = module.Visual.FilledOpacity
                        esp.Box["Filledbox"].Position = Vector2.new(math.floor(rootPos.X), math.floor(rootPos.Y)) - (esp.Box["Main"].Size / 2)

                        --Box
                        esp.Box["Outline"].Visible = module.Visual.Box and module.Visual.ShowTeam
                        esp.Box["Outline"].Size = size
                        esp.Box["Outline"].Position = Vector2.new(math.floor(rootPos.X), math.floor(rootPos.Y)) - (esp.Box["Outline"].Size / 2)
                        esp.Box["Main"].Visible = module.Visual.Box and module.Visual.ShowTeam
                        esp.Box["Main"].Size = size
                        esp.Box["Main"].Position = Vector2.new(math.floor(rootPos.X), math.floor(rootPos.Y)) - (esp.Box["Main"].Size / 2)

                        --Healthbox
                        esp.Box["HealthboxOutline"].Visible = module.Visual.Healthbox and module.Visual.ShowTeam
                        esp.Box["HealthboxOutline"].Size = Vector2.new(1, size.Y * (1-((v.Character.Humanoid.MaxHealth - v.Character.Humanoid.Health) / v.Character.Humanoid.MaxHealth)))
                        esp.Box["HealthboxOutline"].Position = Vector2.new(math.floor(rootPos.X) - 5, math.floor(rootPos.Y) + (size.Y - math.floor(esp.Box["HealthboxOutline"].Size.Y))) - size / 2
                        esp.Box["Healthbox"].Visible = module.Visual.Healthbox and module.Visual.ShowTeam
                        esp.Box["Healthbox"].Size = Vector2.new(1, size.Y * (1-((v.Character.Humanoid.MaxHealth - v.Character.Humanoid.Health) / v.Character.Humanoid.MaxHealth)))
                        esp.Box["Healthbox"].Position = Vector2.new(math.floor(rootPos.X) - 5, math.floor(rootPos.Y) + (size.Y - math.floor(esp.Box["Healthbox"].Size.Y))) - size / 2

                        --Nameds
                        esp.Text["Name"].Visible = module.Visual.Name and module.Visual.ShowTeam
                        esp.Text["Name"].Position = Vector2.new(math.floor(rootPos.X), math.floor(rootPos.Y) - size.Y / 2 - 16)
                        esp.Text["Name"].Text = v.Name.." | "..math.floor(v.Character.Humanoid.Health).."/"..math.floor(v.Character.Humanoid.MaxHealth)
    
                        --extra plr info
                        esp.Text["plrinfo"].Visible = module.Visual.plrinfo
                        esp.Text["plrinfo"].Position = Vector2.new(math.floor(rootPos.X), math.floor(rootPos.Y) - size.Y / 2 - 16)
                        esp.Text["plrinfo"].Text = "Level: "..v.Progression.Level.Value.." | ".."Prestige: "..v.Progression.Prestige.Value

                        --Distance
                        esp.Text["Distance"].Visible = module.Visual.Distance and module.Visual.ShowTeam
                        esp.Text["Distance"].Position = Vector2.new(math.floor(rootPos.X),math.floor(rootPos.Y + height * 0.5))
                        esp.Text["Distance"].Text = tostring(math.ceil(magnitude)).." studs"

                        --its fine since your gonna replace it each time u update.
                        --Snapline
                        esp.Line["Snapline"].Visible = module.Visual.Snaplines and module.Visual.ShowTeam
                        esp.Line["Snapline"].From = Vector2.new(dwCamera.ViewportSize.X/2, 120)
                        esp.Line["Snapline"].To = Vector2.new(math.floor(rootPos.X), math.floor(rootPos.Y))
                        changedrawingcolor(module.Visual.TeamColor)
                    else
                        --Filledbox
                        esp.Box["Filledbox"].Visible = module.Visual.Filledbox and module.Visual.Box
                        esp.Box["Filledbox"].Size = size
                        esp.Box["Filledbox"].Filled = module.Visual.Filledbox
                        esp.Box["Filledbox"].Transparency = module.Visual.FilledOpacity
                        esp.Box["Filledbox"].Position = Vector2.new(math.floor(rootPos.X), math.floor(rootPos.Y)) - (esp.Box["Main"].Size / 2)

                        --Box
                        esp.Box["Outline"].Visible = module.Visual.Box
                        esp.Box["Outline"].Size = size
                        esp.Box["Outline"].Position = Vector2.new(math.floor(rootPos.X), math.floor(rootPos.Y)) - (esp.Box["Outline"].Size / 2)
                        esp.Box["Main"].Visible = module.Visual.Box
                        esp.Box["Main"].Size = size
                        esp.Box["Main"].Position = Vector2.new(math.floor(rootPos.X), math.floor(rootPos.Y)) - (esp.Box["Main"].Size / 2)

                        --Healthbox
                        esp.Box["HealthboxOutline"].Visible = module.Visual.Healthbox
                        esp.Box["HealthboxOutline"].Size = Vector2.new(1, size.Y * (1-((v.Character.Humanoid.MaxHealth - v.Character.Humanoid.Health) / v.Character.Humanoid.MaxHealth)))
                        esp.Box["HealthboxOutline"].Position = Vector2.new(math.floor(rootPos.X) - 5, math.floor(rootPos.Y) + (size.Y - math.floor(esp.Box["HealthboxOutline"].Size.Y))) - size / 2
                        esp.Box["Healthbox"].Visible = module.Visual.Healthbox
                        esp.Box["Healthbox"].Size = Vector2.new(1, size.Y * (1-((v.Character.Humanoid.MaxHealth - v.Character.Humanoid.Health) / v.Character.Humanoid.MaxHealth)))
                        esp.Box["Healthbox"].Position = Vector2.new(math.floor(rootPos.X) - 5, math.floor(rootPos.Y) + (size.Y - math.floor(esp.Box["Healthbox"].Size.Y))) - size / 2

                        --Nameds
                        esp.Text["Name"].Visible = module.Visual.Name
                        esp.Text["Name"].Position = Vector2.new(math.floor(rootPos.X), math.floor(rootPos.Y) - size.Y / 2 - 16)
                        esp.Text["Name"].Text = v.Name.." | "..math.floor(v.Character.Humanoid.Health).."/"..math.floor(v.Character.Humanoid.MaxHealth)
    
                        --extra plr info
                        esp.Text["plrinfo"].Visible = module.Visual.plrinfo
                        esp.Text["plrinfo"].Position = Vector2.new(math.floor(rootPos.X), math.floor(rootPos.Y) - size.Y / 2 - 16)
                        esp.Text["plrinfo"].Text = "Level: "..v.Progression.Level.Value.." | ".."Prestige: "..v.Progression.Prestige.Value

                        --Distance
                        esp.Text["Distance"].Visible = module.Visual.Distance
                        esp.Text["Distance"].Position = Vector2.new(math.floor(rootPos.X),math.floor(rootPos.Y + height * 0.5))
                        esp.Text["Distance"].Text = tostring(math.ceil(magnitude)).." studs"

                        --Snapline
                        esp.Line["Snapline"].Visible = module.Visual.Snaplines
                        esp.Line["Snapline"].From = Vector2.new(dwCamera.ViewportSize.X/2, 120)
                        esp.Line["Snapline"].To = Vector2.new(math.floor(rootPos.X), math.floor(rootPos.Y))
                        changedrawingcolor(module.Visual.EnemyColor)
                    end
                else
                    toggledrawing(false)
                end
            else
                toggledrawing(false)
                if module.playerexists(v, "universal") == false then
                    --break
                end
            end
        end
    end)
end

function module.michaelvisual(v)
    local esp = {
        Box = {Filledbox = Drawing.new("Square"), Outline = Drawing.new("Square"), Main = Drawing.new("Square"), HealthboxOutline = Drawing.new("Square"), Healthbox = Drawing.new("Square")},
        Text = {Distance = Drawing.new("Text"), Name = Drawing.new("Text")},
        Line = {Snapline = Drawing.new("Line")}
    };

    for index, v in pairs(esp.Box) do
        v.Visible = false
        v.Position = Vector2.new(20, 20);
        v.Size = Vector2.new(20, 20); -- pixels offset from .Position
        v.Color = Color3.fromRGB(0, 0, 0);
        v.Filled = false;
        v.Transparency = 0.9;
        v.Thickness = 1
    end

    for index, v in pairs(esp.Line) do
        v.From = Vector2.new(20, 20); -- origin
        v.To = Vector2.new(50, 50); -- destination
        v.Color = Color3.new(0,0,0);
        v.Thickness = 1;
        v.Transparency = 0.9;
        v.Visible = false
    end

    esp.Box.HealthboxOutline.Thickness = 2
    esp.Box.Outline.Thickness = 2
    esp.Box.Healthbox.Filled = true
    esp.Box.HealthboxOutline.Filled = true

    for index, v in pairs(esp.Text) do
        v.Text = ""
        v.Color = Color3.new(1, 1, 1)
        v.OutlineColor = Color3.new(0, 0, 0)
        v.Center = true
        v.Outline = true
        v.Position = Vector2.new(100, 100)
        v.Size = 15
        v.Font = 1 -- 'UI', 'System', 'Plex', 'Monospace'
        v.Transparency = 0.9
        v.Visible = false
    end

    local function toggledrawing(value)
        for index, v in pairs(esp.Box) do
            v.Visible = value
        end
        for index, v in pairs(esp.Text) do
            v.Visible = value
        end
        for index, v in pairs(esp.Line) do
            v.Visible = value
        end
    end

    local function changedrawingcolor(color)
        esp.Box["Main"].Color = color
        esp.Box["Healthbox"].Color = color
        for i,v in pairs(esp.Text) do
            v.Color = color
        end
        for i,v in pairs(esp.Line) do
            v.Color = color
        end
    end

    task.spawn(function()
        while task.wait() do
            if v ~= nil and v:FindFirstChild("Humanoid") ~= nil and v:FindFirstChild("Head") ~= nil and v:FindFirstChild("HumanoidRootPart") ~= nil and v.Humanoid.Health > 0 then --  and v.Humanoid.RigType == Enum.HumanoidRigType.R6
                local displayEsp = v
                if displayEsp then
                    local _,onscreen = dwCamera:WorldToScreenPoint(v.HumanoidRootPart.Position)
                    displayEsp = onscreen
                end

                local orientation, sizee = v:GetBoundingBox()
                local width = (dwCamera.CFrame - dwCamera.CFrame.p) * Vector3.new((math.clamp(sizee.X, 1, 10) + 0.5) / 2, 0, 0)
                local height = (dwCamera.CFrame - dwCamera.CFrame.p) * Vector3.new(0, (math.clamp(sizee.X, 1, 10) + 2) / 2, 0)
                width = math.abs(dwCamera:WorldToViewportPoint(orientation.Position + width).X - dwCamera:WorldToViewportPoint(orientation.Position - width).X)
                height = math.abs(dwCamera:WorldToViewportPoint(orientation.Position + height).Y - dwCamera:WorldToViewportPoint(orientation.Position - height).Y)
                local size = Vector2.new(math.floor(width), math.floor(height))
                size = Vector2.new(size.X % 2 == 0 and size.X or size.X + 1, size.Y % 2 == 0 and size.Y or size.Y + 1)
                local rootPos = dwCamera:WorldToViewportPoint(v.HumanoidRootPart.Position)
                local magnitude = (v.HumanoidRootPart.Position - dwCamera.CFrame.p).Magnitude

                local TL = dwCamera:WorldToViewportPoint(v.HumanoidRootPart.CFrame * CFrame.new(-3,3,0).p)
                local TR = dwCamera:WorldToViewportPoint(v.HumanoidRootPart.CFrame * CFrame.new(3,3,0).p)
                local BL = dwCamera:WorldToViewportPoint(v.HumanoidRootPart.CFrame * CFrame.new(-3,-3,0).p)
                local BR = dwCamera:WorldToViewportPoint(v.HumanoidRootPart.CFrame * CFrame.new(3,-3,0).p)

                if module.Visual.michael.Enabled and displayEsp and magnitude < module.Visual.michael.ShowDistance then
                    --Filledbox
                    esp.Box["Filledbox"].Visible = module.Visual.michael.Filledbox
                    esp.Box["Filledbox"].Size = size
                    esp.Box["Filledbox"].Filled = module.Visual.michael.Filledbox
                    esp.Box["Filledbox"].Transparency = module.Visual.michael.FilledOpacity
                    esp.Box["Filledbox"].Position = Vector2.new(math.floor(rootPos.X), math.floor(rootPos.Y)) - (esp.Box["Main"].Size / 2)

                    --Box
                    esp.Box["Outline"].Visible = module.Visual.michael.Box
                    esp.Box["Outline"].Size = size
                    esp.Box["Outline"].Position = Vector2.new(math.floor(rootPos.X), math.floor(rootPos.Y)) - (esp.Box["Outline"].Size / 2)
                    esp.Box["Main"].Visible = module.Visual.michael.Box
                    esp.Box["Main"].Size = size
                    esp.Box["Main"].Position = Vector2.new(math.floor(rootPos.X), math.floor(rootPos.Y)) - (esp.Box["Main"].Size / 2)

                    --Healthbox
                    esp.Box["HealthboxOutline"].Visible = module.Visual.michael.Healthbox
                    esp.Box["HealthboxOutline"].Size = Vector2.new(1, size.Y * (1-((v.Humanoid.MaxHealth - v.Humanoid.Health) / v.Humanoid.MaxHealth)))
                    esp.Box["HealthboxOutline"].Position = Vector2.new(math.floor(rootPos.X) - 5, math.floor(rootPos.Y) + (size.Y - math.floor(esp.Box["HealthboxOutline"].Size.Y))) - size / 2
                    esp.Box["Healthbox"].Visible = module.Visual.michael.Healthbox
                    esp.Box["Healthbox"].Size = Vector2.new(1, size.Y * (1-((v.Humanoid.MaxHealth - v.Humanoid.Health) / v.Humanoid.MaxHealth)))
                    esp.Box["Healthbox"].Position = Vector2.new(math.floor(rootPos.X) - 5, math.floor(rootPos.Y) + (size.Y - math.floor(esp.Box["Healthbox"].Size.Y))) - size / 2

                    --Name
                    esp.Text["Name"].Visible = module.Visual.michael.Info
                    esp.Text["Name"].Position = Vector2.new(math.floor(rootPos.X), math.floor(rootPos.Y) - size.Y / 2 - 16)
                    esp.Text["Name"].Text = v.Name

                    --Distance
                    esp.Text["Distance"].Visible = module.Visual.michael.Distance
                    esp.Text["Distance"].Position = Vector2.new(math.floor(rootPos.X),math.floor(rootPos.Y + height * 0.5))
                    esp.Text["Distance"].Text = tostring(math.ceil(magnitude)).." studs"

                    --Snapline
                    esp.Line["Snapline"].Visible = module.Visual.michael.Snaplines
                    esp.Line["Snapline"].From = Vector2.new(dwCamera.ViewportSize.X/2, 120)
                    esp.Line["Snapline"].To = Vector2.new(math.floor(rootPos.X), math.floor(rootPos.Y))
                    changedrawingcolor(module.Visual.michael.EnemyColor)
                else
                    toggledrawing(false)
                end
            else
                toggledrawing(false)
                if module.playerexists(v, "universal") == false then
                    --break
                end
            end
        end
    end)
end

function module.arsenalvisual(v)
    local esp = {
        Box = {Filledbox = Drawing.new("Square"), Outline = Drawing.new("Square"), Main = Drawing.new("Square"), HealthboxOutline = Drawing.new("Square"), Healthbox = Drawing.new("Square")},
        Text = {Distance = Drawing.new("Text"), Name = Drawing.new("Text")},
        Line = {Snapline = Drawing.new("Line")}
    };

    for index, v in pairs(esp.Box) do
        v.Visible = false
        v.Position = Vector2.new(20, 20);
        v.Size = Vector2.new(20, 20); -- pixels offset from .Position
        v.Color = Color3.fromRGB(0, 0, 0);
        v.Filled = false;
        v.Transparency = 0.9;
        v.Thickness = 1
    end

    for index, v in pairs(esp.Line) do
        v.From = Vector2.new(20, 20); -- origin
        v.To = Vector2.new(50, 50); -- destination
        v.Color = Color3.new(0,0,0);
        v.Thickness = 1;
        v.Transparency = 0.9;
        v.Visible = false
    end

    esp.Box.HealthboxOutline.Thickness = 2
    esp.Box.Outline.Thickness = 2
    esp.Box.Healthbox.Filled = true
    esp.Box.HealthboxOutline.Filled = true

    for index, v in pairs(esp.Text) do
        v.Text = ""
        v.Color = Color3.new(1, 1, 1)
        v.OutlineColor = Color3.new(0, 0, 0)
        v.Center = true
        v.Outline = true
        v.Position = Vector2.new(100, 100)
        v.Size = 15
        v.Font = 1 -- 'UI', 'System', 'Plex', 'Monospace'
        v.Transparency = 0.9
        v.Visible = false
    end

    local function toggledrawing(value)
        for index, v in pairs(esp.Box) do
            v.Visible = value
        end
        for index, v in pairs(esp.Text) do
            v.Visible = value
        end
        for index, v in pairs(esp.Line) do
            v.Visible = value
        end
    end

    local function changedrawingcolor(color)
        esp.Box["Main"].Color = color
        esp.Box["Healthbox"].Color = color
        for i,v in pairs(esp.Text) do
            v.Color = color
        end
        for i,v in pairs(esp.Line) do
            v.Color = color
        end
    end

    task.spawn(function()
        while task.wait() do
            if v.Character ~= nil and v.Character:FindFirstChild("Humanoid") ~= nil and v.Character:FindFirstChild("Head") ~= nil and v.Character:FindFirstChild("HumanoidRootPart") ~= nil and v.NRPBS.Health.Value > 0 then --  and v.Character.Humanoid.RigType == Enum.HumanoidRigType.R6
                local displayEsp = v.Character
                if displayEsp then
                    local _,onscreen = dwCamera:WorldToScreenPoint(v.Character.HumanoidRootPart.Position)
                    displayEsp = onscreen
                end

                local orientation, sizee = v.Character:GetBoundingBox()
                local width = (dwCamera.CFrame - dwCamera.CFrame.p) * Vector3.new((math.clamp(sizee.X, 1, 10) + 0.5) / 2, 0, 0)
                local height = (dwCamera.CFrame - dwCamera.CFrame.p) * Vector3.new(0, (math.clamp(sizee.X, 1, 10) + 2) / 2, 0)
                width = math.abs(dwCamera:WorldToViewportPoint(orientation.Position + width).X - dwCamera:WorldToViewportPoint(orientation.Position - width).X)
                height = math.abs(dwCamera:WorldToViewportPoint(orientation.Position + height).Y - dwCamera:WorldToViewportPoint(orientation.Position - height).Y)
                local size = Vector2.new(math.floor(width), math.floor(height))
                size = Vector2.new(size.X % 2 == 0 and size.X or size.X + 1, size.Y % 2 == 0 and size.Y or size.Y + 1)
                local rootPos = dwCamera:WorldToViewportPoint(v.Character.HumanoidRootPart.Position)
                local magnitude = (v.Character.HumanoidRootPart.Position - dwCamera.CFrame.p).Magnitude

                if module.Visual.Enabled and displayEsp and magnitude < module.Visual.ShowDistance then
                    if teamcheck(v) == false then
                        --Filledbox
                        esp.Box["Filledbox"].Visible = module.Visual.Filledbox and module.Visual.ShowTeam
                        esp.Box["Filledbox"].Size = size
                        esp.Box["Filledbox"].Filled = module.Visual.Filledbox
                        esp.Box["Filledbox"].Transparency = module.Visual.FilledOpacity
                        esp.Box["Filledbox"].Position = Vector2.new(math.floor(rootPos.X), math.floor(rootPos.Y)) - (esp.Box["Main"].Size / 2)

                        --Box
                        esp.Box["Outline"].Visible = module.Visual.Box and module.Visual.ShowTeam
                        esp.Box["Outline"].Size = size
                        esp.Box["Outline"].Position = Vector2.new(math.floor(rootPos.X), math.floor(rootPos.Y)) - (esp.Box["Outline"].Size / 2)
                        esp.Box["Main"].Visible = module.Visual.Box and module.Visual.ShowTeam
                        esp.Box["Main"].Size = size
                        esp.Box["Main"].Position = Vector2.new(math.floor(rootPos.X), math.floor(rootPos.Y)) - (esp.Box["Main"].Size / 2)

                        --Healthbox
                        esp.Box["HealthboxOutline"].Visible = module.Visual.Healthbox and module.Visual.ShowTeam
                        esp.Box["HealthboxOutline"].Size = Vector2.new(1, size.Y * (1-((v.NRPBS.MaxHealth.Value - v.NRPBS.Health.Value) / v.NRPBS.MaxHealth.Value)))
                        esp.Box["HealthboxOutline"].Position = Vector2.new(math.floor(rootPos.X) - 5, math.floor(rootPos.Y) + (size.Y - math.floor(esp.Box["HealthboxOutline"].Size.Y))) - size / 2
                        esp.Box["Healthbox"].Visible = module.Visual.Healthbox and module.Visual.ShowTeam
                        esp.Box["Healthbox"].Size = Vector2.new(1, size.Y * (1-((v.NRPBS.MaxHealth.Value - v.NRPBS.Health.Value) / v.NRPBS.MaxHealth.Value)))
                        esp.Box["Healthbox"].Position = Vector2.new(math.floor(rootPos.X) - 5, math.floor(rootPos.Y) + (size.Y - math.floor(esp.Box["Healthbox"].Size.Y))) - size / 2

                        --Name
                        esp.Text["Name"].Visible = module.Visual.Name and module.Visual.ShowTeam
                        esp.Text["Name"].Position = Vector2.new(math.floor(rootPos.X), math.floor(rootPos.Y) - size.Y / 2 - 16)
                        esp.Text["Name"].Text = v.Name

                        --Distance
                        esp.Text["Distance"].Visible = module.Visual.Distance and module.Visual.ShowTeam
                        esp.Text["Distance"].Position = Vector2.new(math.floor(rootPos.X),math.floor(rootPos.Y + height * 0.5))
                        esp.Text["Distance"].Text = tostring(math.ceil(magnitude)).." studs"

                        --Snapline
                        esp.Line["Snapline"].Visible = module.Visual.Snaplines and module.Visual.ShowTeam
                        esp.Line["Snapline"].From = Vector2.new(dwCamera.ViewportSize.X/2, 120)
                        esp.Line["Snapline"].To = Vector2.new(math.floor(rootPos.X), math.floor(rootPos.Y))
                        changedrawingcolor(module.Visual.TeamColor)
                    else
                        --Filledbox
                        esp.Box["Filledbox"].Visible = module.Visual.Filledbox
                        esp.Box["Filledbox"].Size = size
                        esp.Box["Filledbox"].Filled = module.Visual.Filledbox
                        esp.Box["Filledbox"].Transparency = module.Visual.FilledOpacity
                        esp.Box["Filledbox"].Position = Vector2.new(math.floor(rootPos.X), math.floor(rootPos.Y)) - (esp.Box["Main"].Size / 2)

                        --Box
                        esp.Box["Outline"].Visible = module.Visual.Box
                        esp.Box["Outline"].Size = size
                        esp.Box["Outline"].Position = Vector2.new(math.floor(rootPos.X), math.floor(rootPos.Y)) - (esp.Box["Outline"].Size / 2)
                        esp.Box["Main"].Visible = module.Visual.Box
                        esp.Box["Main"].Size = size
                        esp.Box["Main"].Position = Vector2.new(math.floor(rootPos.X), math.floor(rootPos.Y)) - (esp.Box["Main"].Size / 2)

                        --Healthbox
                        esp.Box["HealthboxOutline"].Visible = module.Visual.Healthbox
                        esp.Box["HealthboxOutline"].Size = Vector2.new(1, size.Y * (1-((v.NRPBS.MaxHealth.Value - v.NRPBS.Health.Value) / v.NRPBS.MaxHealth.Value)))
                        esp.Box["HealthboxOutline"].Position = Vector2.new(math.floor(rootPos.X) - 5, math.floor(rootPos.Y) + (size.Y - math.floor(esp.Box["HealthboxOutline"].Size.Y))) - size / 2
                        esp.Box["Healthbox"].Visible = module.Visual.Healthbox
                        esp.Box["Healthbox"].Size = Vector2.new(1, size.Y * (1-((v.NRPBS.MaxHealth.Value - v.NRPBS.Health.Value) / v.NRPBS.MaxHealth.Value)))
                        esp.Box["Healthbox"].Position = Vector2.new(math.floor(rootPos.X) - 5, math.floor(rootPos.Y) + (size.Y - math.floor(esp.Box["Healthbox"].Size.Y))) - size / 2

                        --Name
                        esp.Text["Name"].Visible = module.Visual.Name
                        esp.Text["Name"].Position = Vector2.new(math.floor(rootPos.X), math.floor(rootPos.Y) - size.Y / 2 - 16)
                        esp.Text["Name"].Text = v.Name

                        --Distance
                        esp.Text["Distance"].Visible = module.Visual.Distance
                        esp.Text["Distance"].Position = Vector2.new(math.floor(rootPos.X),math.floor(rootPos.Y + height * 0.5))
                        esp.Text["Distance"].Text = tostring(math.ceil(magnitude)).." studs"

                        --Snapline
                        esp.Line["Snapline"].Visible = module.Visual.Snaplines
                        esp.Line["Snapline"].From = Vector2.new(dwCamera.ViewportSize.X/2, 120)
                        esp.Line["Snapline"].To = Vector2.new(math.floor(rootPos.X), math.floor(rootPos.Y))
                        changedrawingcolor(module.Visual.EnemyColor)
                    end
                else
                    toggledrawing(false)
                end
            else
                toggledrawing(false)
                if module.playerexists(v, "universal") == false then
                    --break
                end
            end
        end
    end)
end

function module.drawcrosshair()
    local LegacyElements = Instance.new("ScreenGui")
    LegacyElements.Name = "LegacyElements"
    LegacyElements.ZIndexBehavior = Enum.ZIndexBehavior.Sibling
    LegacyElements.Parent = game:GetService("CoreGui")

    local Crosshair = Instance.new("Frame")
    Crosshair.Name = "Crosshair"
    Crosshair.Size = UDim2.new(0, 48, 0, 48)
    Crosshair.BackgroundTransparency = 1
    Crosshair.Position = UDim2.new(0.5, -24,0.5, -40)
    --Crosshair.Rotation = 0

    task.spawn(function()
        while task.wait() do
            Crosshair.Visible = module.Visual.crosshair.Show
            for index, v in pairs(Crosshair:GetChildren()) do
                v.BackgroundColor3 = module.Visual.crosshair.Color
                if module.Visual.crosshair.Outline then
                    v.BorderSizePixel = 1
                else
                    v.BorderSizePixel = 0
                end
                if v.Name == "1" or v.Name == "2" then
                    v.Size = UDim2.new(0, 19, 0, module.Visual.crosshair.Thickness);
                elseif v.Name == "3" or v.Name == "4" then
                    v.Size = UDim2.new(0, module.Visual.crosshair.Thickness, 0, 19);
                end
            end
            if module.Visual.crosshair.Spin then
                Crosshair.Rotation = Crosshair.Rotation + 1
            else
                Crosshair.Rotation = 0
            end
        end
    end);

    Crosshair.BackgroundColor3 = Color3.fromRGB(255, 255,    255)
    Crosshair.Parent = LegacyElements

    local Frame = Instance.new("Frame")
    Frame.Name = "1"
    Frame.Size = UDim2.new(0, 19, 0, 3)
    Frame.Position = UDim2.new(0, 0, 0.5, -1)
    Frame.BackgroundColor3 = module.Visual.crosshair.Color
    Frame.Parent = Crosshair

    local Frame1 = Instance.new("Frame")
    Frame1.Name = "2"
    Frame1.Size = UDim2.new(0, 19, 0, 3)
    Frame1.Position = UDim2.new(1, -19, 0.5, -1)
    Frame1.BackgroundColor3 = module.Visual.crosshair.Color
    Frame1.Parent = Crosshair

    local Frame2 = Instance.new("Frame")
    Frame2.Name = "3"
    Frame2.Size = UDim2.new(0, 3, 0, 19)
    Frame2.Position = UDim2.new(0.5, 0, 0, 0)
    Frame2.BackgroundColor3 = module.Visual.crosshair.Color
    Frame2.Parent = Crosshair

    local Frame3 = Instance.new("Frame")
    Frame3.Name = "4"
    Frame3.Size = UDim2.new(0, 3, 0, 19)
    Frame3.Position = UDim2.new(0.5, 0, 1, -19)
    Frame3.BackgroundColor3 = module.Visual.crosshair.Color
    Frame3.Parent = Crosshair
end

function module.getboundingbox(folder) --ghetto boundingbox func for classes that arent models
    local model = Instance.new("Model", nil)
    folder.Parent = model
    return model:GetBoundingBox()
end

function module.itemvisual(model, name, table, debug)
    debug = debug or false
    table = {
        Enabled = table.Enabled,
        Name = table.Name,
        Snaplines = table.Snaplines,
        Distance = table.Distance,
        ShowDistance = table.ShowDistance,
        Color = table.Color,
    };
    local esp = {
        Text = {Distance = Drawing.new("Text"), Name = Drawing.new("Text")},
        Line = {Snapline = Drawing.new("Line")}
    };

    for index, v in pairs(esp.Line) do
        v.From = Vector2.new(20, 20); -- origin
        v.To = Vector2.new(50, 50); -- destination
        v.Color = Color3.new(0,0,0);
        v.Thickness = 1;
        v.Transparency = 0.9;
        v.Visible = false
    end

    for index, v in pairs(esp.Text) do
        v.Text = ""
        v.Color = Color3.new(1, 1, 1)
        v.OutlineColor = Color3.new(0, 0, 0)
        v.Center = true
        v.Outline = true
        v.Position = Vector2.new(100, 100)
        v.Size = 15
        v.Font = 1 -- 'UI', 'System', 'Plex', 'Monospace'
        v.Transparency = 0.9
        v.Visible = false
    end

    local function toggledrawing(value)
        for index, v in pairs(esp.Text) do
            v.Visible = value
        end
        for index, v in pairs(esp.Line) do
            v.Visible = value
        end
    end

    local function changedrawingcolor(color)
        for i,v in pairs(esp.Text) do
            v.Color = color
        end
        for i,v in pairs(esp.Line) do
            v.Color = color
        end
    end

    if debug then
        print("DEBUG: Loaded")
    end

    task.spawn(function()
        if debug then
            print("DEBUG: Loop created")
        end
        while task.wait() do
            if model ~= nil and model ~= nil then
                local displayEsp = model
                if displayEsp then
                    local _,onscreen = dwCamera:WorldToScreenPoint(model.Position)
                    displayEsp = onscreen
                end

                local rootPos = dwCamera:WorldToViewportPoint(model.Position)
                local magnitude = (model.Position - dwCamera.CFrame.p).Magnitude

                if table.Enabled and displayEsp and magnitude < table.ShowDistance then
                    --Name
                    esp.Text["Name"].Visible = table.Name
                    esp.Text["Name"].Position = Vector2.new(math.floor(rootPos.X), math.floor(rootPos.Y) - 16)
                    esp.Text["Name"].Text = name

                    if debug then
                        print("DEBUG: Position"..tostring(esp.Text["Name"].Position))
                    end

                    --Distance
                    esp.Text["Distance"].Visible = table.Distance
                    esp.Text["Distance"].Position = Vector2.new(math.floor(rootPos.X),math.floor(rootPos.Y + 0.5))
                    esp.Text["Distance"].Text = tostring(math.ceil(magnitude)).." studs"

                    --Snapline
                    esp.Line["Snapline"].Visible = table.Snaplines
                    esp.Line["Snapline"].From = Vector2.new(dwCamera.ViewportSize.X/2, 120)
                    esp.Line["Snapline"].To = Vector2.new(math.floor(rootPos.X), math.floor(rootPos.Y))
                    changedrawingcolor(table.Color)
                else
                    toggledrawing(false)
                end
            else
                toggledrawing(false)
            end
        end
    end)
end
return module;
