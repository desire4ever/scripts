local ws    = game:GetService("Workspace")
local rs    = game:GetService("RunService")
local rstor = game:GetService("ReplicatedStorage")
local plrs  = game:GetService("Players")
local plr   = plrs.LocalPlayer
local farms = ws.Farms

local weaponRemote = rstor.Events.Weapon

local weapon_args = {
    a1 = "self",
    a2 = "219629d5067eddcdce55ed7968e9b53f"
}

local function farmExists()
    for i,v in pairs(farms:GetChildren()) do
        if tostring(v.Sign.Gui.Owner.Text) == tostring(plr.Name) then
            return true
        end
    end
end

local function notify(msg)
    local notif = Instance.new("Hint", ws)
    notif.Text = tostring(msg)
    wait(5)
    notif:Destroy()
end

-- anti-afk (credits to the original creator(s))
local VirtualUser=game:service'VirtualUser'
game:service'Players'.LocalPlayer.Idled:connect(function()
VirtualUser:CaptureController()
VirtualUser:ClickButton2(Vector2.new())
end)

for i,v in pairs(farms:GetChildren()) do
    if farmExists() == nil then
        notify("You don't have a farm, go claim one!")
    elseif farmExists() == true then
        if tostring(v.Owner.Value) == tostring(plr.Name) then
            rs.RenderStepped:Connect(function()
                plr.Character.HumanoidRootPart.CFrame = v.Chicken.CFrame
                weaponRemote:FireServer(weapon_args.a1, weapon_args.a2)
            end)
        end
    end
end
