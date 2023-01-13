getgenv().test = true--true/false
while task.wait() do
    if not getgenv().test then return end
    game:GetService("ReplicatedStorage").Remotes.PlaceBlock:FireServer()
end