-- language: Lua, executor: Delta X Mobile, target: Arise Crossover
-- v6.4 Fixed: clean ASCII spaces, fixed Toggle arguments, fixed ESP Color3, thread safety

local Players = game:GetService("Players")
local LP = Players.LocalPlayer
local TweenService = game:GetService("TweenService")
local UIS = game:GetService("UserInputService")
local RS = game:GetService("ReplicatedStorage")
local WS = workspace
local VirtualUser = game:GetService("VirtualUser")

local pg = LP:FindFirstChild("PlayerGui")
if not pg then
    pcall(function()
        pg = LP:WaitForChild("PlayerGui")
    end)
end

if not pg then 
    warn("[ARISE] no PlayerGui"); 
    return 
end


pcall(function()
    local old = pg:FindFirstChild("AriseVipV6")
    if old then old:Destroy() end
end)

local SG = Instance.new("ScreenGui")
SG.Name = "AriseVipV6"
SG.ResetOnSpawn = false
SG.IgnoreGuiInset = true
SG.DisplayOrder = 999
SG.Parent = pg

-- ================================================================
-- SPLASH
-- ================================================================
local Splash = Instance.new("Frame", SG)
Splash.Size = UDim2.new(1, 0, 1, 0)
Splash.BackgroundColor3 = Color3.new(0, 0, 0)
Splash.BorderSizePixel = 0
Splash.ZIndex = 200

local SplashGlow = Instance.new("Frame", Splash)
SplashGlow.Size = UDim2.new(0, 400, 0, 100)
SplashGlow.Position = UDim2.new(0.5, -200, 0.5, -50)
SplashGlow.BackgroundColor3 = Color3.fromRGB(180, 80, 255)
SplashGlow.BackgroundTransparency = 0.85
SplashGlow.BorderSizePixel = 0
SplashGlow.ZIndex = 201
Instance.new("UICorner", SplashGlow).CornerRadius = UDim.new(0, 20)

local SplashLabel = Instance.new("TextLabel", Splash)
SplashLabel.Size = UDim2.new(0, 500, 0, 60)
SplashLabel.Position = UDim2.new(0.5, -250, 0.5, -35)
SplashLabel.BackgroundTransparency = 1
SplashLabel.Text = "Code By Nguyen Phuc"
SplashLabel.TextColor3 = Color3.new(1, 1, 1)
SplashLabel.TextSize = 30
SplashLabel.Font = Enum.Font.GothamBold
SplashLabel.TextStrokeTransparency = 0
SplashLabel.TextStrokeColor3 = Color3.fromRGB(180, 80, 255)
SplashLabel.ZIndex = 202

local SplashSub = Instance.new("TextLabel", Splash)
SplashSub.Size = UDim2.new(0, 500, 0, 30)
SplashSub.Position = UDim2.new(0.5, -250, 0.5, 20)
SplashSub.BackgroundTransparency = 1
SplashSub.Text = "ARISE VIP v6"
SplashSub.TextColor3 = Color3.fromRGB(180, 80, 255)
SplashSub.TextSize = 14
SplashSub.Font = Enum.Font.GothamSemibold
SplashSub.TextStrokeTransparency = 0.4
SplashSub.TextStrokeColor3 = Color3.fromRGB(100, 45, 160)
SplashSub.ZIndex = 202

local GlowStroke = Instance.new("UIStroke", SplashLabel)
GlowStroke.Color = Color3.fromRGB(180, 80, 255)
GlowStroke.Thickness = 2
GlowStroke.Transparency = 0.2

task.spawn(function()
    while SplashLabel and SplashLabel.Parent do
        pcall(function()
            TweenService:Create(GlowStroke, TweenInfo.new(0.6), {Thickness = 4, Transparency = 0.6}):Play()
            TweenService:Create(SplashGlow, TweenInfo.new(0.6), {BackgroundTransparency = 0.6}):Play()
        end)
        task.wait(0.6)
        if not (SplashLabel and SplashLabel.Parent) then break end
        pcall(function()
            TweenService:Create(GlowStroke, TweenInfo.new(0.6), {Thickness = 2, Transparency = 0.1}):Play()
            TweenService:Create(SplashGlow, TweenInfo.new(0.6), {BackgroundTransparency = 0.85}):Play()
        end)
        task.wait(0.6)
    end
end)

print("[ARISE v6.4] splash shown")

-- ================================================================
-- MAIN WINDOW
-- ================================================================
local Main = Instance.new("Frame", SG)
Main.Size = UDim2.new(0, 320, 0, 440)
Main.Position = UDim2.new(0.5, -160, 0.5, -220)
Main.BackgroundColor3 = Color3.fromRGB(8, 8, 14)
Main.BorderSizePixel = 0
Main.ClipsDescendants = true
Main.ZIndex = 2
Main.Visible = false
Main.BackgroundTransparency = 1
Instance.new("UICorner", Main).CornerRadius = UDim.new(0, 14)

local MS = Instance.new("UIStroke", Main)
MS.Color = Color3.fromRGB(180, 80, 255)
MS.Transparency = 1
MS.Thickness = 2

local TBar = Instance.new("Frame", Main)
TBar.Size = UDim2.new(1, 0, 0, 52)
TBar.BackgroundColor3 = Color3.fromRGB(14, 14, 24)
TBar.BorderSizePixel = 0
TBar.ZIndex = 4
Instance.new("UICorner", TBar).CornerRadius = UDim.new(0, 14)

local Title = Instance.new("TextLabel", TBar)
Title.Size = UDim2.new(1, -100, 0, 28)
Title.Position = UDim2.new(0, 14, 0, 12)
Title.BackgroundTransparency = 1
Title.Text = "ARISE VIP v6"
Title.TextColor3 = Color3.fromRGB(220, 140, 255)
Title.TextSize = 16
Title.Font = Enum.Font.GothamBold
Title.TextXAlignment = Enum.TextXAlignment.Left
Title.ZIndex = 5

local Sub = Instance.new("TextLabel", TBar)
Sub.Size = UDim2.new(1, -100, 0, 14)
Sub.Position = UDim2.new(0, 14, 0, 32)
Sub.BackgroundTransparency = 1
Sub.Text = "Code By Nguyen Phuc"
Sub.TextColor3 = Color3.fromRGB(110, 110, 150)
Sub.TextSize = 10
Sub.Font = Enum.Font.Gotham
Sub.TextXAlignment = Enum.TextXAlignment.Left
Sub.ZIndex = 5

local CloseBtn = Instance.new("TextButton", TBar)
CloseBtn.Size = UDim2.new(0, 28, 0, 28)
CloseBtn.Position = UDim2.new(1, -36, 0.5, -14)
CloseBtn.BackgroundColor3 = Color3.fromRGB(220, 65, 65)
CloseBtn.Text = "✕"
CloseBtn.TextColor3 = Color3.new(1, 1, 1)
CloseBtn.TextSize = 12
CloseBtn.Font = Enum.Font.GothamBold
CloseBtn.BorderSizePixel = 0
CloseBtn.ZIndex = 6
Instance.new("UICorner", CloseBtn).CornerRadius = UDim.new(1, 0)
CloseBtn.MouseButton1Click:Connect(function() SG:Destroy() end)

local dragging, dragStart, startPos = false, nil, nil
TBar.InputBegan:Connect(function(i)
    if i.UserInputType == Enum.UserInputType.Touch or i.UserInputType == Enum.UserInputType.MouseButton1 then
        dragging = true
        dragStart = i.Position
        startPos = Main.Position
    end
end)
UIS.InputChanged:Connect(function(i)
    if dragging and (i.UserInputType == Enum.UserInputType.Touch or i.UserInputType == Enum.UserInputType.MouseMovement) then
        local d = i.Position - dragStart
        Main.Position = UDim2.new(startPos.X.Scale, startPos.X.Offset + d.X, startPos.Y.Scale, startPos.Y.Offset + d.Y)
    end
end)
UIS.InputEnded:Connect(function(i)
    if i.UserInputType == Enum.UserInputType.Touch or i.UserInputType == Enum.UserInputType.MouseButton1 then
        dragging = false
    end
end)

-- ================================================================
-- TABS
-- ================================================================
local C = {
    bg = Color3.fromRGB(8, 8, 14),
    surface = Color3.fromRGB(14, 14, 24),
    surface2 = Color3.fromRGB(20, 20, 32),
    surface3 = Color3.fromRGB(28, 28, 44),
    neon = Color3.fromRGB(180, 80, 255),
    neonHi = Color3.fromRGB(220, 140, 255),
    neonDim = Color3.fromRGB(100, 45, 160),
    cyan = Color3.fromRGB(80, 220, 255),
    text = Color3.fromRGB(230, 230, 250),
    textDim = Color3.fromRGB(110, 110, 150),
    textMuted = Color3.fromRGB(60, 60, 95),
    success = Color3.fromRGB(80, 255, 160),
    danger = Color3.fromRGB(255, 80, 100),
    warn = Color3.fromRGB(255, 200, 60),
    info = Color3.fromRGB(80, 180, 255),
    white = Color3.new(1, 1, 1),
}

local Pages, TabBtns, ActiveTab = {}, {}, nil
local TABS = {
    {key = "farm",     label = "Farm"},
    {key = "quest",    label = "Quest"},
    {key = "instance", label = "Inst"},
    {key = "boss",     label = "Boss"},
    {key = "util",     label = "Util"},
    {key = "esp",      label = "ESP"},
    {key = "auto",     label = "Auto"},
    {key = "settings", label = "Set"},
}
local TW = 320 / #TABS

local TabBar = Instance.new("Frame", Main)
TabBar.Size = UDim2.new(1, 0, 0, 40)
TabBar.Position = UDim2.new(0, 0, 0, 52)
TabBar.BackgroundColor3 = C.surface
TabBar.BorderSizePixel = 0
TabBar.ZIndex = 3

local TL = Instance.new("UIListLayout", TabBar)
TL.FillDirection = Enum.FillDirection.Horizontal
TL.SortOrder = Enum.SortOrder.LayoutOrder
TL.VerticalAlignment = Enum.VerticalAlignment.Center

local TabInd = Instance.new("Frame", TabBar)
TabInd.Size = UDim2.new(0, TW - 6, 0, 3)
TabInd.Position = UDim2.new(0, 3, 1, -3)
TabInd.BackgroundColor3 = C.neonHi
TabInd.BorderSizePixel = 0
TabInd.ZIndex = 6
Instance.new("UICorner", TabInd).CornerRadius = UDim.new(1, 0)

local Content = Instance.new("Frame", Main)
Content.Size = UDim2.new(1, 0, 1, -119)
Content.Position = UDim2.new(0, 0, 0, 92)
Content.BackgroundTransparency = 1
Content.ClipsDescendants = true
Content.ZIndex = 2

local SBar = Instance.new("Frame", Main)
SBar.Size = UDim2.new(1, 0, 0, 27)
SBar.Position = UDim2.new(0, 0, 1, -27)
SBar.BackgroundColor3 = C.surface
SBar.BorderSizePixel = 0
SBar.ZIndex = 4
Instance.new("UICorner", SBar).CornerRadius = UDim.new(0, 14)

local SDot = Instance.new("Frame", SBar)
SDot.Size = UDim2.new(0, 7, 0, 7)
SDot.Position = UDim2.new(0, 12, 0.5, -3.5)
SDot.BackgroundColor3 = C.textMuted
SDot.BorderSizePixel = 0
SDot.ZIndex = 5
Instance.new("UICorner", SDot).CornerRadius = UDim.new(1, 0)

local SLbl = Instance.new("TextLabel", SBar)
SLbl.Size = UDim2.new(1, -30, 1, 0)
SLbl.Position = UDim2.new(0, 26, 0, 0)
SLbl.BackgroundTransparency = 1
SLbl.Text = "Loading..."
SLbl.TextColor3 = C.textDim
SLbl.TextSize = 10
SLbl.Font = Enum.Font.Gotham
SLbl.TextXAlignment = Enum.TextXAlignment.Left
SLbl.ZIndex = 5

local function SetStatus(msg, col)
    SLbl.Text = msg or "ready"
    SLbl.TextColor3 = col or C.textDim
    SDot.BackgroundColor3 = col or C.textMuted
end

local function SwitchTab(key)
    if ActiveTab == key then return end
    ActiveTab = key
    for i, def in ipairs(TABS) do
        local btn, page = TabBtns[def.key], Pages[def.key]
        if def.key == key then
            btn.TextColor3 = C.neonHi
            TweenService:Create(TabInd, TweenInfo.new(0.15), {Position = UDim2.new(0, (i - 1) * TW + 3, 1, -3)}):Play()
            page.Visible = true
        else
            btn.TextColor3 = C.textDim
            page.Visible = false
        end
    end
end

for i, def in ipairs(TABS) do
    local Btn = Instance.new("TextButton", TabBar)
    Btn.Size = UDim2.new(0, TW, 1, 0)
    Btn.BackgroundTransparency = 1
    Btn.Text = def.label
    Btn.TextColor3 = C.textDim
    Btn.TextSize = 10
    Btn.Font = Enum.Font.GothamSemibold
    Btn.ZIndex = 4
    Btn.LayoutOrder = i
    TabBtns[def.key] = Btn

    local Page = Instance.new("ScrollingFrame", Content)
    Page.Name = def.key
    Page.Size = UDim2.new(1, 0, 1, 0)
    Page.BackgroundTransparency = 1
    Page.BorderSizePixel = 0
    Page.ScrollBarThickness = 3
    Page.ScrollBarImageColor3 = C.neonDim
    Page.AutomaticCanvasSize = Enum.AutomaticSize.Y
    Page.CanvasSize = UDim2.new(0, 0, 0, 0)
    Page.Visible = false
    Page.ZIndex = 2
    Pages[def.key] = Page

    local PL = Instance.new("UIListLayout", Page)
    PL.SortOrder = Enum.SortOrder.LayoutOrder
    PL.Padding = UDim.new(0, 6)

    local PP = Instance.new("UIPadding", Page)
    PP.PaddingLeft = UDim.new(0, 10)
    PP.PaddingRight = UDim.new(0, 10)
    PP.PaddingTop = UDim.new(0, 8)
    PP.PaddingBottom = UDim.new(0, 8)

    Btn.MouseButton1Click:Connect(function() SwitchTab(def.key) end)
end

-- ================================================================
-- WIDGETS
-- ================================================================
local function Section(parent, text, order)
    local F = Instance.new("Frame", parent)
    F.Size = UDim2.new(1, 0, 0, 20)
    F.BackgroundTransparency = 1
    F.LayoutOrder = order or 0
    local lbl = Instance.new("TextLabel", F)
    lbl.Size = UDim2.new(1, 0, 1, 0)
    lbl.BackgroundTransparency = 1
    lbl.Text = text
    lbl.TextColor3 = C.neonHi
    lbl.TextSize = 10
    lbl.Font = Enum.Font.GothamBold
    lbl.TextXAlignment = Enum.TextXAlignment.Left
end

local S = {
    AutoExecute = false, AutoFarm = false, AutoFarmNear = false, AutoFarmSelect = false,
    SelectedMobs = {}, AutoQuest = false, AutoTimeTrials = false, AutoBossRush = false,
    AutoUpRank = false, AutoDungeon = false, AutoInfernal = false, AutoDesert = false,
    AutoKeyBoss = false, SelectedKeyBoss = "",
    FPSBoost = false, ESPMob = false, ESPMount = false, ESPPlayer = false,
    FarmRadius = 800, SelectRadius = 500, NearRadius = 50,
    _antiAFK = false, _autoSell = false, _autoStat = false,
    Language = "vi",
}

local function Toggle(parent, label, desc, sKey, onOn, onOff, order)
    if type(onOff) == "number" then
        order = onOff
        onOff = nil
    end

    local Card = Instance.new("Frame", parent)
    Card.Size = UDim2.new(1, 0, 0, 52)
    Card.BackgroundColor3 = C.surface
    Card.BorderSizePixel = 0
    Card.LayoutOrder = order or 1
    Instance.new("UICorner", Card).CornerRadius = UDim.new(0, 10)

    local LM = Instance.new("TextLabel", Card)
    LM.Size = UDim2.new(1, -70, 0, 20)
    LM.Position = UDim2.new(0, 12, 0, 7)
    LM.BackgroundTransparency = 1
    LM.Text = label
    LM.TextColor3 = C.text
    LM.TextSize = 12
    LM.Font = Enum.Font.GothamSemibold
    LM.TextXAlignment = Enum.TextXAlignment.Left

    local LS = Instance.new("TextLabel", Card)
    LS.Size = UDim2.new(1, -70, 0, 14)
    LS.Position = UDim2.new(0, 12, 0, 30)
    LS.BackgroundTransparency = 1
    LS.Text = desc or ""
    LS.TextColor3 = C.textDim
    LS.TextSize = 9
    LS.Font = Enum.Font.Gotham
    LS.TextXAlignment = Enum.TextXAlignment.Left

    local Pill = Instance.new("Frame", Card)
    Pill.Size = UDim2.new(0, 46, 0, 24)
    Pill.Position = UDim2.new(1, -56, 0.5, -12)
    Pill.BackgroundColor3 = C.surface3
    Pill.BorderSizePixel = 0
    Instance.new("UICorner", Pill).CornerRadius = UDim.new(1, 0)

    local Knob = Instance.new("Frame", Pill)
    Knob.Size = UDim2.new(0, 18, 0, 18)
    Knob.Position = UDim2.new(0, 3, 0.5, -9)
    Knob.BackgroundColor3 = C.textMuted
    Knob.BorderSizePixel = 0
    Instance.new("UICorner", Knob).CornerRadius = UDim.new(1, 0)

    local isOn = false
    local function Apply(state)
        isOn = state
        if sKey then S[sKey] = state end
        if state then
            TweenService:Create(Pill, TweenInfo.new(0.1), {BackgroundColor3 = C.neon}):Play()
            TweenService:Create(Knob, TweenInfo.new(0.1), {Position = UDim2.new(0, 25, 0.5, -9), BackgroundColor3 = C.white}):Play()
            LM.TextColor3 = C.white
            if onOn then onOn() end
            SetStatus(label .. " ON", C.success)
        else
            TweenService:Create(Pill, TweenInfo.new(0.1), {BackgroundColor3 = C.surface3}):Play()
            TweenService:Create(Knob, TweenInfo.new(0.1), {Position = UDim2.new(0, 3, 0.5, -9), BackgroundColor3 = C.textMuted}):Play()
            LM.TextColor3 = C.text
            if onOff then onOff() end
            SetStatus("Idle")
        end
    end

    local Click = Instance.new("TextButton", Card)
    Click.Size = UDim2.new(1, 0, 1, 0)
    Click.BackgroundTransparency = 1
    Click.Text = ""
    Click.MouseButton1Click:Connect(function() Apply(not isOn) end)
end

local function Button(parent, label, col, cb, order)
    local B = Instance.new("TextButton", parent)
    B.Size = UDim2.new(1, 0, 0, 38)
    B.BackgroundColor3 = col or C.neonDim
    B.Text = label
    B.TextColor3 = C.white
    B.TextSize = 12
    B.Font = Enum.Font.GothamSemibold
    B.BorderSizePixel = 0
    B.LayoutOrder = order or 1
    Instance.new("UICorner", B).CornerRadius = UDim.new(0, 9)
    B.MouseButton1Click:Connect(function()
        if cb then cb() end
    end)
end

local function StatRow(parent, label, sKey, minV, maxV, step, order)
    local Card = Instance.new("Frame", parent)
    Card.Size = UDim2.new(1, 0, 0, 42)
    Card.BackgroundColor3 = C.surface
    Card.BorderSizePixel = 0
    Card.LayoutOrder = order or 1
    Instance.new("UICorner", Card).CornerRadius = UDim.new(0, 10)

    local LM = Instance.new("TextLabel", Card)
    LM.Size = UDim2.new(0.45, 0, 1, 0)
    LM.Position = UDim2.new(0, 10, 0, 0)
    LM.BackgroundTransparency = 1
    LM.Text = label
    LM.TextColor3 = C.text
    LM.TextSize = 11
    LM.Font = Enum.Font.GothamSemibold
    LM.TextXAlignment = Enum.TextXAlignment.Left

    local ValF = Instance.new("Frame", Card)
    ValF.Size = UDim2.new(0, 40, 0, 26)
    ValF.Position = UDim2.new(1, -96, 0.5, -13)
    ValF.BackgroundColor3 = C.surface2
    ValF.BorderSizePixel = 0
    Instance.new("UICorner", ValF).CornerRadius = UDim.new(0, 6)

    local ValLbl = Instance.new("TextLabel", ValF)
    ValLbl.Size = UDim2.new(1, 0, 1, 0)
    ValLbl.BackgroundTransparency = 1
    ValLbl.Text = tostring(S[sKey])
    ValLbl.TextColor3 = C.neonHi
    ValLbl.TextSize = 12
    ValLbl.Font = Enum.Font.GothamBold

    local function mk(txt, x, d)
        local B = Instance.new("TextButton", Card)
        B.Size = UDim2.new(0, 26, 0, 26)
        B.Position = UDim2.new(1, x, 0.5, -13)
        B.BackgroundColor3 = C.surface3
        B.Text = txt
        B.TextColor3 = C.neonHi
        B.TextSize = 15
        B.Font = Enum.Font.GothamBold
        B.BorderSizePixel = 0
        Instance.new("UICorner", B).CornerRadius = UDim.new(0, 6)
        B.MouseButton1Click:Connect(function()
            S[sKey] = math.clamp(S[sKey] + d, minV, maxV)
            ValLbl.Text = tostring(S[sKey])
        end)
    end
    mk("−", -126, -step)
    mk("+", -28, step)
end

local function CreatePopup(width, height)
    local old = SG:FindFirstChild("ArisePopup")
    if old then old:Destroy() end

    local dd = Instance.new("ScrollingFrame", SG)
    dd.Name = "ArisePopup"
    dd.Size = UDim2.new(0, width, 0, height)
    dd.Position = UDim2.new(0.5, -width / 2, 0.5, -height / 2)
    dd.BackgroundColor3 = C.surface2
    dd.BorderSizePixel = 0
    dd.ScrollBarThickness = 3
    dd.AutomaticCanvasSize = Enum.AutomaticSize.Y
    dd.CanvasSize = UDim2.new(0, 0, 0, 0)
    dd.ZIndex = 60
    Instance.new("UICorner", dd).CornerRadius = UDim.new(0, 10)

    local st = Instance.new("UIStroke", dd)
    st.Color = C.neon
    st.Thickness = 2
    st.Transparency = 0.3

    local lay = Instance.new("UIListLayout", dd)
    lay.SortOrder = Enum.SortOrder.LayoutOrder
    lay.Padding = UDim.new(0, 3)

    local pad = Instance.new("UIPadding", dd)
    pad.PaddingLeft = UDim.new(0, 6)
    pad.PaddingRight = UDim.new(0, 6)
    pad.PaddingTop = UDim.new(0, 6)
    pad.PaddingBottom = UDim.new(0, 6)

    return dd
end

-- ================================================================
-- FEATURE LOGIC
-- ================================================================
local Char, HRP, Hum
local function RefreshChar(c)
    if not c then return end
    Char = c
    HRP = c:WaitForChild("HumanoidRootPart", 10)
    Hum = c:WaitForChild("Humanoid", 10)
end
if LP.Character then RefreshChar(LP.Character) end

local RC = nil
local function GetRemotes()
    if RC then return RC end
    RC = {events = {}, funcs = {}}
    local count = 0
    for _, root in ipairs({RS, WS}) do
        for _, v in ipairs(root:GetDescendants()) do
            local ok, cls = pcall(function() return v.ClassName end)
            if ok then
                if cls == "RemoteEvent" then RC.events[v.Name] = v
                elseif cls == "RemoteFunction" then RC.funcs[v.Name] = v end
            end
            count = count + 1
            if count % 1000 == 0 then task.wait() end
        end
    end
    return RC
end

local function FindRemote(names)
    local rc = GetRemotes()
    for _, n in ipairs(names) do
        if rc.events[n] then return rc.events[n] end
        if rc.funcs[n] then return rc.funcs[n] end
        local low = n:lower()
        for name, obj in pairs(rc.events) do
            if name:lower() == low then return obj end
        end
        for name, obj in pairs(rc.funcs) do
            if name:lower() == low then return obj end
        end
    end
end

local function Fire(names, ...)
    local r = FindRemote(names)
    if not r then return false end
    return pcall(function()
        if r:IsA("RemoteEvent") then r:FireServer(...)
        elseif r:IsA("RemoteFunction") then r:InvokeServer(...) end
    end)
end

local function Attack(mob)
    if not mob or not mob.R then return end
    Fire({"Attack", "BasicAttack", "DealDamage", "Hit", "PlayerAttack"}, mob.M, mob.R.Position)
    local tool = Char and Char:FindFirstChildOfClass("Tool")
    if tool then pcall(function() tool:Activate() end) end
end

local function TP(cf)
    if HRP and HRP.Parent then HRP.CFrame = cf * CFrame.new(0, 0, 3.5) end
end

local function GetMobFolder()
    for _, n in ipairs({"Mobs", "Enemies", "Monsters", "NPC", "Enemy", "Units", "Boss", "Shadows"}) do
        local f = WS:FindFirstChild(n)
        if f then return f end
    end
    return WS
end

local function AllMobs(radius)
    local list, origin = {}, HRP and HRP.Position or Vector3.new()
    for _, obj in ipairs(GetMobFolder():GetDescendants()) do
        if obj:IsA("Model") and obj ~= Char then
            local hum = obj:FindFirstChildOfClass("Humanoid")
            local root = obj:FindFirstChild("HumanoidRootPart") or obj.PrimaryPart
            if hum and root and hum.Health > 0 then
                local d = (origin - root.Position).Magnitude
                if d <= radius then table.insert(list, {M = obj, R = root, H = hum, Dist = d}) end
            end
        end
    end
    table.sort(list, function(a, b) return a.Dist < b.Dist end)
    return list
end

local MobNameCache, MobCacheTime = nil, 0
local function GetMobNames(force)
    if MobNameCache and not force and os.time() - MobCacheTime < 30 then
        return MobNameCache
    end
    local names, seen = {}, {}
    for _, obj in ipairs(GetMobFolder():GetDescendants()) do
        if obj:IsA("Model") and obj ~= Char and obj:FindFirstChildOfClass("Humanoid") and not seen[obj.Name] then
            seen[obj.Name] = true
            table.insert(names, obj.Name)
        end
    end
    table.sort(names)
    MobNameCache = names
    MobCacheTime = os.time()
    return names
end

local function FindTrialNPC()
    for _, tag in ipairs({"TimeTrial", "TrialNPC", "TrialGiver", "TimeTrialNPC"}) do
        for _, obj in ipairs(WS:GetDescendants()) do
            if obj:IsA("Model") and obj.Name:lower():find(tag:lower()) then
                local root = obj:FindFirstChild("HumanoidRootPart") or obj.PrimaryPart
                if root then return root end
            end
        end
    end
end

local Threads = {}
local function StartThread(key, fn)
    if Threads[key] then
        pcall(task.cancel, Threads[key])
    end
    Threads[key] = task.spawn(fn)
end

local function RunFarm()
    while S.AutoFarm do
        if Hum and Hum.Health > 0 then
            local m = AllMobs(S.FarmRadius)
            if #m > 0 then
                SetStatus("Farm → " .. m[1].M.Name, C.success)
                TP(m[1].R.CFrame)
                Attack(m[1])
            end
        end
        task.wait(0.15)
    end
end

local function RunFarmNear()
    while S.AutoFarmNear do
        if Hum and Hum.Health > 0 then
            for _, mob in ipairs(AllMobs(S.NearRadius)) do
                if not S.AutoFarmNear then break end
                Attack(mob)
                task.wait(0.05)
            end
        end
        task.wait(0.1)
    end
end

local function RunFarmSelect()
    while S.AutoFarmSelect do
        if Hum and Hum.Health > 0 then
            local origin = HRP and HRP.Position or Vector3.new()
            local list = {}
            for _, obj in ipairs(GetMobFolder():GetDescendants()) do
                if obj:IsA("Model") and S.SelectedMobs[obj.Name] then
                    local hum = obj:FindFirstChildOfClass("Humanoid")
                    local root = obj:FindFirstChild("HumanoidRootPart") or obj.PrimaryPart
                    if hum and root and hum.Health > 0 then
                        local d = (origin - root.Position).Magnitude
                        if d <= S.SelectRadius then table.insert(list, {M = obj, R = root, H = hum, Dist = d}) end
                    end
                end
            end
            table.sort(list, function(a, b) return a.Dist < b.Dist end)
            if #list > 0 then
                SetStatus("Select → " .. list[1].M.Name, C.success)
                TP(list[1].R.CFrame)
                Attack(list[1])
            end
        end
        task.wait(0.15)
    end
end

local function RunQuest()
    while S.AutoQuest do
        Fire({"AcceptQuest", "StartQuest", "ClaimQuest", "CompleteQuest", "FinishQuest"})
        local m = AllMobs(S.FarmRadius)
        if #m > 0 then TP(m[1].R.CFrame); Attack(m[1]) end
        task.wait(1.5)
    end
end

local function RunTrial()
    while S.AutoTimeTrials do
        Fire({"StartTimeTrial", "BeginTrial", "EnterTimeTrial"})
        task.wait(1)
        local m = AllMobs(2000)
        if #m > 0 then TP(m[1].R.CFrame); Attack(m[1]) end
        Fire({"ClaimTimeTrial", "FinishTrial"})
        task.wait(2)
    end
end

local function RunBossRush()
    while S.AutoBossRush do
        Fire({"BossRush", "StartBossRush", "EnterBossRush", "CemeteryRush"})
        task.wait(1)
        local m = AllMobs(2000)
        if #m > 0 then TP(m[1].R.CFrame); Attack(m[1]) end
        task.wait(2)
    end
end

local function InstanceLoop(flag, enter, claim)
    return function()
        while S[flag] do
            if not S.AutoExecute then
                SetStatus("⚠ Bật Auto Execute!", C.danger)
                task.wait(1)
            else
                Fire(enter)
                task.wait(1.5)
                local m = AllMobs(2000)
                if #m > 0 then
                    TP(m[1].R.CFrame)
                    Attack(m[1])
                else
                    Fire(claim)
                    task.wait(2)
                end
            end
            task.wait(1)
        end
    end
end

local RunUpRank = InstanceLoop("AutoUpRank",
    {"EnterRankDungeon", "StartRankDungeon", "JoinRankDungeon"},
    {"ClaimRankReward", "FinishRankDungeon"})
local RunDungeon = InstanceLoop("AutoDungeon",
    {"EnterDungeon", "StartDungeon", "JoinDungeon"},
    {"ClaimReward", "FinishDungeon", "CompleteDungeon"})
local RunInfernal = InstanceLoop("AutoInfernal",
    {"EnterInfernal", "StartInfernal", "CastleEnter"},
    {"ClaimInfernal", "CastleReward", "FloorReward"})
local RunDesert = InstanceLoop("AutoDesert",
    {"EnterDesert", "DesertEnter", "StartDesert"},
    {"ClaimDesert", "DesertReward"})

local function RunKeyBoss()
    while S.AutoKeyBoss do
        if not S.AutoExecute then
            SetStatus("⚠ Bật Auto Execute!", C.danger)
            task.wait(1)
        elseif S.SelectedKeyBoss == "" then
            SetStatus("⚠ Chọn Key Boss!", C.warn)
            task.wait(1)
        else
            Fire({"EnterKeyBoss", "StartKeyBoss", "JoinKeyBoss"}, S.SelectedKeyBoss)
            task.wait(1.5)
            local m = AllMobs(3000)
            if #m > 0 then
                TP(m[1].R.CFrame)
                Attack(m[1])
            else
                Fire({"ClaimKeyBoss", "KeyBossReward"})
                task.wait(2)
            end
        end
        task.wait(1)
    end
end

-- FPS BOOST
local FPSBackup = nil
local function ApplyFPS()
    if FPSBackup then return end
    FPSBackup = {effects = {}, decals = {}, shadows = nil, fog = nil}
    pcall(function()
        local lighting = game:GetService("Lighting")
        FPSBackup.shadows = lighting.GlobalShadows
        FPSBackup.fog = lighting.FogEnd
        lighting.GlobalShadows = false
        lighting.FogEnd = 100000
        for _, v in ipairs(lighting:GetChildren()) do
            if v:IsA("PostEffect") or v:IsA("Atmosphere") or v:IsA("Clouds") or v:IsA("Sky") then
                FPSBackup.effects[v] = v.Enabled
                v.Enabled = false
            end
        end
    end)
    pcall(function()
        for _, v in ipairs(WS:GetDescendants()) do
            if v:IsA("ParticleEmitter") or v:IsA("Trail") or v:IsA("Smoke")
                or v:IsA("Fire") or v:IsA("Sparkles") or v:IsA("Beam") then
                FPSBackup.effects[v] = v.Enabled
                v.Enabled = false
            elseif v:IsA("Decal") or v:IsA("Texture") then
                FPSBackup.decals[v] = v.Transparency
                v.Transparency = 1
            end
        end
    end)
    SetStatus("FPS Boost ON", C.success)
end

local function RestoreFPS()
    if not FPSBackup then return end
    pcall(function()
        local lighting = game:GetService("Lighting")
        if FPSBackup.shadows ~= nil then lighting.GlobalShadows = FPSBackup.shadows end
        if FPSBackup.fog then lighting.FogEnd = FPSBackup.fog end
    end)
    for obj, val in pairs(FPSBackup.effects or {}) do
        pcall(function() if obj.Parent then obj.Enabled = val end end)
    end
    for obj, val in pairs(FPSBackup.decals or {}) do
        pcall(function() if obj.Parent then obj.Transparency = val end end)
    end
    FPSBackup = nil
    SetStatus("FPS Boost OFF", C.danger)
end

-- ANTI-AFK
local AntiAFKConn = nil
local function StartAntiAFK()
    if AntiAFKConn then return end
    AntiAFKConn = LP.Idled:Connect(function()
        pcall(function()
            VirtualUser:CaptureController()
            VirtualUser:ClickButton2(Vector2.new())
        end)
    end)
    SetStatus("Anti-AFK ON", C.success)
end

local function StopAntiAFK()
    if AntiAFKConn then
        AntiAFKConn:Disconnect()
        AntiAFKConn = nil
    end
    SetStatus("Anti-AFK OFF", C.danger)
end

-- AUTO SELL
local AutoSell = {minRarity = "Common", keepLocked = true}
local RARITY_ORDER = {common = 1, uncommon = 2, rare = 3, epic = 4, legendary = 5, mythic = 6, godly = 7, divine = 8}

local function GetInventory()
    for _, name in ipairs({"Inventory", "Backpack", "Items", "Storage", "Bag", "PlayerInventory"}) do
        local inv = LP:FindFirstChild(name)
        if inv then return inv end
    end
    return LP:FindFirstChildOfClass("Backpack")
end

local function GetItemRarity(item)
    local attr = item:GetAttribute("Rarity") or item:GetAttribute("rarity")
    if attr then return tostring(attr):lower() end
    for _, child in ipairs(item:GetChildren()) do
        if child:IsA("StringValue") and (child.Name == "Rarity" or child.Name == "rarity") then
            return child.Value:lower()
        end
    end
    local n = item.Name:lower()
    for rarity, _ in pairs(RARITY_ORDER) do
        if n:find(rarity) then return rarity end
    end
    return "common"
end

local function IsItemLocked(item)
    local locked = item:GetAttribute("Locked") or item:GetAttribute("locked")
    if locked ~= nil then return locked end
    for _, child in ipairs(item:GetChildren()) do
        if child.Name:lower() == "locked" then
            if child:IsA("BoolValue") then return child.Value end
            if child:IsA("StringValue") then return child.Value == "true" end
        end
    end
    return false
end

local function SellItem(item)
    local itemId = item:GetAttribute("Id") or item:GetAttribute("UID") or item.Name
    Fire({"SellItem", "Sell", "SellInventory", "SellItemRemote", "RemoveItem", "DiscardItem"}, item)
    Fire({"SellById", "SellItemById", "SellItemUID"}, itemId)
end

local function CountSellable()
    local inv = GetInventory()
    if not inv then return 0, {} end
    local minVal = RARITY_ORDER[AutoSell.minRarity:lower()] or 1
    local count, list = 0, {}
    for _, item in ipairs(inv:GetDescendants()) do
        if item:IsA("Tool") or item:IsA("Model") or item:IsA("Folder") then
            local rar = GetItemRarity(item)
            local rarVal = RARITY_ORDER[rar] or 1
            local locked = IsItemLocked(item)
            if rarVal < minVal and (not AutoSell.keepLocked or not locked) then
                count = count + 1
                table.insert(list, item.Name)
            end
        end
    end
    return count, list
end

local function RunAutoSell()
    while S._autoSell do
        local inv = GetInventory()
        if inv then
            local minVal = RARITY_ORDER[AutoSell.minRarity:lower()] or 1
            local sold = 0
            for _, item in ipairs(inv:GetDescendants()) do
                if not S._autoSell then break end
                if item:IsA("Tool") or item:IsA("Model") or item:IsA("Folder") then
                    local rar = GetItemRarity(item)
                    local rarVal = RARITY_ORDER[rar] or 1
                    local locked = IsItemLocked(item)
                    if rarVal < minVal and (not AutoSell.keepLocked or not locked) then
                        SellItem(item)
                        sold = sold + 1
                        task.wait(0.15)
                    end
                end
            end
            if sold > 0 then SetStatus("Đã bán " .. sold .. " item", C.success) end
        end
        task.wait(3)
    end
end

-- AUTO STAT
local AutoStat = {
    priority = {"Strength", "Agility", "Vitality", "Intelligence"},
    weights = {Strength = 1, Agility = 1, Vitality = 1, Intelligence = 1},
}

local function GetStatStore()
    for _, name in ipairs({"leaderstats", "Stats", "PlayerStats", "Stat", "Attributes", "Data"}) do
        local s = LP:FindFirstChild(name)
        if s then return s end
    end
end

local function GetPointsStore()
    local store = GetStatStore()
    if store then
        for _, v in ipairs(store:GetDescendants()) do
            if v:IsA("NumberValue") or v:IsA("IntValue") then
                local n = v.Name:lower()
                if n:find("point") or n:find("stat_point") or n:find("attributepoint")
                    or n:find("skillpoint") or n:find("remaining") then
                    return v
                end
            end
        end
    end
    for _, attr in ipairs({"StatPoints", "Points", "AttributePoints"}) do
        local v = LP:GetAttribute(attr)
        if v and type(v) == "number" then return {Value = v, Name = attr, _attr = true} end
    end
end

local function AllocPoint(statName)
    local fired = Fire({"AllocateStat", "AddStat", "UpgradeStat", "SpendPoint", "AddPoint", "StatAllocate", "AllocatePoint"}, statName)
    if not fired then
        fired = Fire({"AllocateStat", "AddStat", "UpgradeStat"}, statName, 1)
    end
    return fired
end

local function RunAutoStat()
    while S._autoStat do
        local pts = GetPointsStore()
        if pts and pts.Value and pts.Value > 0 then
            local chosen = nil
            for _, name in ipairs(AutoStat.priority) do
                if (AutoStat.weights[name] or 0) > 0 then
                    chosen = name
                    break
                end
            end
            if chosen then
                if AllocPoint(chosen) then
                    SetStatus("Phân bổ: " .. chosen, C.success)
                    task.wait(0.3)
                else
                    SetStatus("Remote alloc fail", C.warn)
                    task.wait(2)
                end
            else
                task.wait(2)
            end
        else
            task.wait(1)
        end
    end
end

-- ================================================================
-- PAGES
-- ================================================================

-- FARM
task.spawn(function()
    local p = Pages["farm"]
    Section(p, "FARM", 1)
    Toggle(p, "Auto Farm", "Teleport đến quái", "AutoFarm",
        function() StartThread("farm", RunFarm) end, nil, 2)
    Toggle(p, "Farm Near", "Đánh quái gần", "AutoFarmNear",
        function() StartThread("near", RunFarmNear) end, nil, 3)
    Toggle(p, "Farm Select", "Chỉ farm quái chọn", "AutoFarmSelect",
        function() StartThread("sel", RunFarmSelect) end, nil, 4)
    Button(p, "⊕ Scan Mobs", C.neonDim, function()
        local names = GetMobNames(true)
        if #names == 0 then SetStatus("Không có mob", C.warn); return end
        local dd = CreatePopup(260, 320)

        local header = Instance.new("TextLabel", dd)
        header.Size = UDim2.new(1, 0, 0, 24)
        header.BackgroundTransparency = 1
        header.Text = "Chọn mob (" .. #names .. ")"
        header.TextColor3 = C.neonHi
        header.TextSize = 11
        header.Font = Enum.Font.GothamBold

        local closeB = Instance.new("TextButton", dd)
        closeB.Size = UDim2.new(1, 0, 0, 28)
        closeB.BackgroundColor3 = C.danger
        closeB.Text = "✕ Đóng"
        closeB.TextColor3 = C.white
        closeB.TextSize = 12
        closeB.Font = Enum.Font.GothamBold
        closeB.BorderSizePixel = 0
        closeB.ZIndex = 61
        Instance.new("UICorner", closeB).CornerRadius = UDim.new(0, 6)
        closeB.MouseButton1Click:Connect(function() dd:Destroy() end)

        for _, name in ipairs(names) do
            local opt = Instance.new("TextButton", dd)
            opt.Size = UDim2.new(1, 0, 0, 30)
            opt.BackgroundColor3 = S.SelectedMobs[name] and C.neonDim or C.surface3
            opt.Text = (S.SelectedMobs[name] and "✓ " or "") .. name
            opt.TextColor3 = S.SelectedMobs[name] and C.neonHi or C.text
            opt.TextSize = 11
            opt.Font = Enum.Font.GothamSemibold
            opt.BorderSizePixel = 0
            opt.ZIndex = 61
            Instance.new("UICorner", opt).CornerRadius = UDim.new(0, 6)
            opt.MouseButton1Click:Connect(function()
                if S.SelectedMobs[name] then
                    S.SelectedMobs[name] = nil
                    opt.BackgroundColor3 = C.surface3
                    opt.TextColor3 = C.text
                    opt.Text = name
                else
                    S.SelectedMobs[name] = true
                    opt.BackgroundColor3 = C.neonDim
                    opt.TextColor3 = C.neonHi
                    opt.Text = "✓ " .. name
                end
            end)
        end
    end, 5)
    StatRow(p, "Farm Radius", "FarmRadius", 50, 5000, 100, 6)
    StatRow(p, "Select Radius", "SelectRadius", 50, 3000, 50, 7)
    StatRow(p, "Near Radius", "NearRadius", 10, 300, 10, 8)
end)

-- QUEST
task.spawn(function()
    local p = Pages["quest"]
    Section(p, "QUEST & TRIAL", 1)
    Toggle(p, "Auto Quest", "Làm quest hiện có", "AutoQuest",
        function() StartThread("q", RunQuest) end, nil, 2)
    Toggle(p, "Auto Time Trials", "Đi time trials", "AutoTimeTrials",
        function()
            StartThread("t", function()
                local npc = FindTrialNPC()
                if npc then TP(npc.CFrame); task.wait(1) end
                RunTrial()
            end)
        end, nil, 3)
    Toggle(p, "Auto Boss Rush", "Đi boss rush", "AutoBossRush",
        function() StartThread("br", RunBossRush) end, nil, 4)
    Button(p, "⊕ Teleport Trial NPC", C.neonDim, function()
        local npc = FindTrialNPC()
        if npc then TP(npc.CFrame); SetStatus("TP trial NPC", C.success)
        else SetStatus("Không tìm thấy trial NPC", C.warn) end
    end, 5)
end)

-- INSTANCE
task.spawn(function()
    local p = Pages["instance"]
    Section(p, "AUTO EXECUTE", 1)
    Toggle(p, "Auto Execute", "Giữ tính năng trong instance", "AutoExecute", nil, nil, 2)
    Section(p, "INSTANCE", 3)
    Toggle(p, "Auto Up Rank", "Dungeon up rank", "AutoUpRank",
        function() StartThread("ur", RunUpRank) end, nil, 4)
    Toggle(p, "Auto Dungeon", "Dungeon hiện có", "AutoDungeon",
        function() StartThread("dg", RunDungeon) end, nil, 5)
    Toggle(p, "Auto Infernal", "Infernal Castle", "AutoInfernal",
        function() StartThread("inf", RunInfernal) end, nil, 6)
    Toggle(p, "Auto Desert", "Desert", "AutoDesert",
        function() StartThread("ds", RunDesert) end, nil, 7)
end)

-- BOSS
task.spawn(function()
    local p = Pages["boss"]
    Section(p, "KEY BOSS", 1)
    Toggle(p, "Auto Key Boss", "Đi key boss đã chọn", "AutoKeyBoss",
        function() StartThread("kb", RunKeyBoss) end, nil, 2)
    Button(p, "⊕ Scan Key Boss", C.neonDim, function()
        local keys, seen = {}, {}
        for _, root in ipairs({WS, RS}) do
            for _, obj in ipairs(root:GetDescendants()) do
                if obj:IsA("Model") then
                    local n = obj.Name
                    if (n:lower():find("boss") or n:lower():find("monarch")) and not seen[n] then
                        seen[n] = true
                        table.insert(keys, n)
                    end
                end
            end
        end
        if #keys == 0 then SetStatus("Không tìm thấy boss", C.warn); return end
        table.sort(keys)
        local dd = CreatePopup(260, 300)

        local closeB = Instance.new("TextButton", dd)
        closeB.Size = UDim2.new(1, 0, 0, 28)
        closeB.BackgroundColor3 = C.danger
        closeB.Text = "✕ Đóng"
        closeB.TextColor3 = C.white
        closeB.TextSize = 12
        closeB.Font = Enum.Font.GothamBold
        closeB.BorderSizePixel = 0
        closeB.ZIndex = 61
        Instance.new("UICorner", closeB).CornerRadius = UDim.new(0, 6)
        closeB.MouseButton1Click:Connect(function() dd:Destroy() end)

        for _, name in ipairs(keys) do
            local opt = Instance.new("TextButton", dd)
            opt.Size = UDim2.new(1, 0, 0, 30)
            opt.BackgroundColor3 = S.SelectedKeyBoss == name and C.neonDim or C.surface3
            opt.Text = name
            opt.TextColor3 = S.SelectedKeyBoss == name and C.neonHi or C.text
            opt.TextSize = 11
            opt.Font = Enum.Font.GothamSemibold
            opt.BorderSizePixel = 0
            opt.ZIndex = 61
            Instance.new("UICorner", opt).CornerRadius = UDim.new(0, 6)
            opt.MouseButton1Click:Connect(function()
                S.SelectedKeyBoss = name
                SetStatus("Chọn: " .. name, C.success)
                dd:Destroy()
            end)
        end
    end, 3)
end)

-- UTIL
task.spawn(function()
    local p = Pages["util"]
    Section(p, "PERFORMANCE", 1)
    Toggle(p, "FPS Boost", "Xóa effect giảm lag", "FPSBoost",
        function() ApplyFPS() end,
        function() RestoreFPS() end, 2)
    Button(p, "↺ Restore Graphics", C.neonDim, function()
        RestoreFPS()
        S.FPSBoost = false
    end, 3)
    Section(p, "SERVER", 4)
    Button(p, "↻ Server Hop", C.neonDim, function()
        pcall(function()
            local h = game:GetService("HttpService")
            local url = "https://games.roblox.com/v1/games/" .. game.PlaceId .. "/servers/Public?sortOrder=Asc&limit=100"
            local data = h:JSONDecode(game:HttpGet(url))
            if data and data.data then
                for _, s in ipairs(data.data) do
                    if s.playing < s.maxPlayers * 0.5 and s.id ~= game.JobId then
                        game:GetService("TeleportService"):TeleportToPlaceInstance(game.PlaceId, s.id, LP)
                        return
                    end
                end
            end
            SetStatus("Không có server trống", C.warn)
        end)
    end, 5)
    Button(p, "↺ Rejoin", C.neonDim, function()
        game:GetService("TeleportService"):Teleport(game.PlaceId, LP)
    end, 6)
end)

-- ESP
task.spawn(function()
    local p = Pages["esp"]
    local ESPT = {mob = {}, mount = {}, player = {}}

    local function addESP(category, obj, color, prefix)
        if ESPT[category][obj] then return end
        local root = obj:FindFirstChild("HumanoidRootPart") or obj.PrimaryPart
        if not root then return end

        local hl = Instance.new("SelectionBox")
        hl.Adornee = obj
        hl.Color3 = color
        hl.SurfaceColor3 = color
        hl.LineThickness = 0.05
        hl.SurfaceTransparency = 0.85
        hl.Parent = SG

        local bb = Instance.new("BillboardGui")
        bb.Adornee = root
        bb.Size = UDim2.new(0, 100, 0, 22)
        bb.StudsOffset = Vector3.new(0, 3.5, 0)
        bb.AlwaysOnTop = true
        bb.Parent = SG

        local lbl = Instance.new("TextLabel", bb)
        lbl.Size = UDim2.new(1, 0, 1, 0)
        lbl.BackgroundColor3 = Color3.new(0, 0, 0)
        lbl.BackgroundTransparency = 0.4
        lbl.Text = prefix .. obj.Name
        lbl.TextColor3 = color
        lbl.TextSize = 10
        lbl.Font = Enum.Font.GothamBold
        Instance.new("UICorner", lbl).CornerRadius = UDim.new(0, 4)

        ESPT[category][obj] = {hl, bb}
    end

    local function clearESP(category)
        if not ESPT[category] then return end
        for _, objs in pairs(ESPT[category]) do
            for _, o in ipairs(objs) do pcall(function() o:Destroy() end) end
        end
        ESPT[category] = {}
    end

    Section(p, "ESP", 1)
    Toggle(p, "ESP Mob", "Thấy mob", "ESPMob", function()
        StartThread("esp_mob", function()
            while S.ESPMob do
                for _, obj in ipairs(GetMobFolder():GetDescendants()) do
                    if obj:IsA("Model") and obj ~= Char and obj:FindFirstChildOfClass("Humanoid") and not ESPT.mob[obj] then
                        pcall(addESP, "mob", obj, C.neon, "⚔ ")
                    end
                end
                task.wait(1)
            end
            clearESP("mob")
        end)
    end, function() clearESP("mob") end, 2)

    Toggle(p, "ESP Mount", "Thấy thú cưỡi", "ESPMount", function()
        StartThread("esp_mount", function()
            while S.ESPMount do
                for _, obj in ipairs(WS:GetDescendants()) do
                    if obj:IsA("Model") and (obj.Name:lower():find("mount") or obj.Name:lower():find("horse") or obj.Name:lower():find("pet")) and not ESPT.mount[obj] then
                        pcall(addESP, "mount", obj, C.success, "🐎 ")
                    end
                end
                task.wait(1.5)
            end
            clearESP("mount")
        end)
    end, function() clearESP("mount") end, 3)

    Toggle(p, "ESP Player", "Thấy player", "ESPPlayer", function()
        StartThread("esp_player", function()
            while S.ESPPlayer do
                for _, plr in ipairs(Players:GetPlayers()) do
                    if plr ~= LP and plr.Character and not ESPT.player[plr.Character] then
                        pcall(addESP, "player", plr.Character, C.cyan, "👤 ")
                    end
                end
                task.wait(1.5)
            end
            clearESP("player")
        end)
    end, function() clearESP("player") end, 4)
end)

-- AUTO
task.spawn(function()
    local p = Pages["auto"]
    Section(p, "ANTI-AFK", 1)
    Toggle(p, "Anti-AFK", "Chống kick khi treo máy", "_antiAFK",
        function() StartAntiAFK() end,
        function() StopAntiAFK() end, 2)

    Section(p, "AUTO SELL", 3)
    Toggle(p, "Auto Sell Junk", "Bán item dưới rarity đã chọn", "_autoSell",
        function() StartThread("sell", RunAutoSell) end, nil, 4)

    local rarCard = Instance.new("Frame", p)
    rarCard.Size = UDim2.new(1, 0, 0, 50)
    rarCard.BackgroundColor3 = C.surface
    rarCard.BorderSizePixel = 0
    rarCard.LayoutOrder = 5
    Instance.new("UICorner", rarCard).CornerRadius = UDim.new(0, 10)

    local rarLbl = Instance.new("TextLabel", rarCard)
    rarLbl.Size = UDim2.new(1, -140, 0, 20)
    rarLbl.Position = UDim2.new(0, 12, 0, 6)
    rarLbl.BackgroundTransparency = 1
    rarLbl.Text = "Bán item dưới rarity:"
    rarLbl.TextColor3 = C.text
    rarLbl.TextSize = 11
    rarLbl.Font = Enum.Font.GothamSemibold
    rarLbl.TextXAlignment = Enum.TextXAlignment.Left

    local rarValLbl = Instance.new("TextLabel", rarCard)
    rarValLbl.Size = UDim2.new(1, -140, 0, 18)
    rarValLbl.Position = UDim2.new(0, 12, 0, 26)
    rarValLbl.BackgroundTransparency = 1
    rarValLbl.Text = AutoSell.minRarity
    rarValLbl.TextColor3 = C.neonHi
    rarValLbl.TextSize = 13
    rarValLbl.Font = Enum.Font.GothamBold
    rarValLbl.TextXAlignment = Enum.TextXAlignment.Left

    local rarityList = {"Common", "Uncommon", "Rare", "Epic", "Legendary", "Mythic", "Godly"}
    local curRarIdx = 1
    local function mkRarBtn(txt, x, delta)
        local B = Instance.new("TextButton", rarCard)
        B.Size = UDim2.new(0, 30, 0, 30)
        B.Position = UDim2.new(1, x, 0.5, -15)
        B.BackgroundColor3 = C.surface3
        B.Text = txt
        B.TextColor3 = C.neonHi
        B.TextSize = 15
        B.Font = Enum.Font.GothamBold
        B.BorderSizePixel = 0
        Instance.new("UICorner", B).CornerRadius = UDim.new(0, 8)
        B.MouseButton1Click:Connect(function()
            curRarIdx = math.clamp(curRarIdx + delta, 1, #rarityList)
            AutoSell.minRarity = rarityList[curRarIdx]
            rarValLbl.Text = AutoSell.minRarity
        end)
    end
    mkRarBtn("◀", -66, -1)
    mkRarBtn("▶", -30, 1)

    local lockCard = Instance.new("Frame", p)
    lockCard.Size = UDim2.new(1, 0, 0, 42)
    lockCard.BackgroundColor3 = C.surface
    lockCard.BorderSizePixel = 0
    lockCard.LayoutOrder = 6
    Instance.new("UICorner", lockCard).CornerRadius = UDim.new(0, 10)

    local lockLbl = Instance.new("TextLabel", lockCard)
    lockLbl.Size = UDim2.new(0.6, 0, 1, 0)
    lockLbl.Position = UDim2.new(0, 12, 0, 0)
    lockLbl.BackgroundTransparency = 1
    lockLbl.Text = "Giữ item đã lock"
    lockLbl.TextColor3 = C.text
    lockLbl.TextSize = 11
    lockLbl.Font = Enum.Font.GothamSemibold
    lockLbl.TextXAlignment = Enum.TextXAlignment.Left

    local lockPill = Instance.new("Frame", lockCard)
    lockPill.Size = UDim2.new(0, 46, 0, 24)
    lockPill.Position = UDim2.new(1, -56, 0.5, -12)
    lockPill.BackgroundColor3 = C.neon
    lockPill.BorderSizePixel = 0
    Instance.new("UICorner", lockPill).CornerRadius = UDim.new(1, 0)

    local lockKnob = Instance.new("Frame", lockPill)
    lockKnob.Size = UDim2.new(0, 18, 0, 18)
    lockKnob.Position = UDim2.new(0, 25, 0.5, -9)
    lockKnob.BackgroundColor3 = C.white
    lockKnob.BorderSizePixel = 0
    Instance.new("UICorner", lockKnob).CornerRadius = UDim.new(1, 0)

    local lockClick = Instance.new("TextButton", lockCard)
    lockClick.Size = UDim2.new(1, 0, 1, 0)
    lockClick.BackgroundTransparency = 1
    lockClick.Text = ""
    lockClick.MouseButton1Click:Connect(function()
        AutoSell.keepLocked = not AutoSell.keepLocked
        if AutoSell.keepLocked then
            TweenService:Create(lockPill, TweenInfo.new(0.1), {BackgroundColor3 = C.neon}):Play()
            TweenService:Create(lockKnob, TweenInfo.new(0.1), {Position = UDim2.new(0, 25, 0.5, -9)}):Play()
        else
            TweenService:Create(lockPill, TweenInfo.new(0.1), {BackgroundColor3 = C.surface3}):Play()
            TweenService:Create(lockKnob, TweenInfo.new(0.1), {Position = UDim2.new(0, 3, 0.5, -9)}):Play()
        end
    end)

    Button(p, "👁 Xem item sẽ bán", C.neonDim, function()
        local count, list = CountSellable()
        if count == 0 then SetStatus("Không có item để bán", C.info); return end
        local dd = CreatePopup(260, 300)

        local h = Instance.new("TextLabel", dd)
        h.Size = UDim2.new(1, 0, 0, 24)
        h.BackgroundTransparency = 1
        h.Text = "Sẽ bán " .. count .. " item"
        h.TextColor3 = C.neonHi
        h.TextSize = 12
        h.Font = Enum.Font.GothamBold

        local closeB = Instance.new("TextButton", dd)
        closeB.Size = UDim2.new(1, 0, 0, 28)
        closeB.BackgroundColor3 = C.danger
        closeB.Text = "✕ Đóng"
        closeB.TextColor3 = C.white
        closeB.TextSize = 12
        closeB.Font = Enum.Font.GothamBold
        closeB.BorderSizePixel = 0
        closeB.ZIndex = 61
        Instance.new("UICorner", closeB).CornerRadius = UDim.new(0, 6)
        closeB.MouseButton1Click:Connect(function() dd:Destroy() end)

        for _, itemName in ipairs(list) do
            local lbl = Instance.new("TextLabel", dd)
            lbl.Size = UDim2.new(1, 0, 0, 22)
            lbl.BackgroundTransparency = 1
            lbl.Text = "· " .. itemName
            lbl.TextColor3 = C.text
            lbl.TextSize = 10
            lbl.Font = Enum.Font.Gotham
            lbl.TextXAlignment = Enum.TextXAlignment.Left
        end
    end, 7)

    Section(p, "AUTO STAT", 8)
    Toggle(p, "Auto Stat Allocation", "Phân bổ điểm khi level up", "_autoStat",
        function() StartThread("stat", RunAutoStat) end, nil, 9)

    for i, statName in ipairs({"Strength", "Agility", "Vitality", "Intelligence"}) do
        local card = Instance.new("Frame", p)
        card.Size = UDim2.new(1, 0, 0, 42)
        card.BackgroundColor3 = C.surface
        card.BorderSizePixel = 0
        card.LayoutOrder = 10 + i
        Instance.new("UICorner", card).CornerRadius = UDim.new(0, 10)

        local lbl = Instance.new("TextLabel", card)
        lbl.Size = UDim2.new(0.6, 0, 1, 0)
        lbl.Position = UDim2.new(0, 12, 0, 0)
        lbl.BackgroundTransparency = 1
        lbl.Text = statName
        lbl.TextColor3 = C.text
        lbl.TextSize = 11
        lbl.Font = Enum.Font.GothamSemibold
        lbl.TextXAlignment = Enum.TextXAlignment.Left

        local pill = Instance.new("Frame", card)
        pill.Size = UDim2.new(0, 46, 0, 24)
        pill.Position = UDim2.new(1, -56, 0.5, -12)
        pill.BackgroundColor3 = (AutoStat.weights[statName] or 0) > 0 and C.neon or C.surface3
        pill.BorderSizePixel = 0
        Instance.new("UICorner", pill).CornerRadius = UDim.new(1, 0)

        local knob = Instance.new("Frame", pill)
        knob.Size = UDim2.new(0, 18, 0, 18)
        knob.Position = (AutoStat.weights[statName] or 0) > 0 and UDim2.new(0, 25, 0.5, -9) or UDim2.new(0, 3, 0.5, -9)
        knob.BackgroundColor3 = (AutoStat.weights[statName] or 0) > 0 and C.white or C.textMuted
        knob.BorderSizePixel = 0
        Instance.new("UICorner", knob).CornerRadius = UDim.new(1, 0)

        local click = Instance.new("TextButton", card)
        click.Size = UDim2.new(1, 0, 1, 0)
        click.BackgroundTransparency = 1
        click.Text = ""
        click.MouseButton1Click:Connect(function()
            AutoStat.weights[statName] = (AutoStat.weights[statName] or 0) > 0 and 0 or 1
            if AutoStat.weights[statName] > 0 then
                TweenService:Create(pill, TweenInfo.new(0.1), {BackgroundColor3 = C.neon}):Play()
                TweenService:Create(knob, TweenInfo.new(0.1), {Position = UDim2.new(0, 25, 0.5, -9), BackgroundColor3 = C.white}):Play()
            else
                TweenService:Create(pill, TweenInfo.new(0.1), {BackgroundColor3 = C.surface3}):Play()
                TweenService:Create(knob, TweenInfo.new(0.1), {Position = UDim2.new(0, 3, 0.5, -9), BackgroundColor3 = C.textMuted}):Play()
            end
        end)
    end

    Button(p, "▶ Phân bổ 1 điểm ngay", C.neonDim, function()
        local pts = GetPointsStore()
        if pts and pts.Value and pts.Value > 0 then
            for _, name in ipairs(AutoStat.priority) do
                if (AutoStat.weights[name] or 0) > 0 then
                    if AllocPoint(name) then SetStatus("Phân bổ: " .. name, C.success)
                    else SetStatus("Remote alloc fail", C.danger) end
                    return
                end
            end
        end
        SetStatus("Không có điểm", C.warn)
    end, 15)
end)

-- SETTINGS
task.spawn(function()
    local p = Pages["settings"]
    Section(p, "NGÔN NGỮ", 1)
    local langCard = Instance.new("Frame", p)
    langCard.Size = UDim2.new(1, 0, 0, 52)
    langCard.BackgroundColor3 = C.surface
    langCard.BorderSizePixel = 0
    langCard.LayoutOrder = 2
    Instance.new("UICorner", langCard).CornerRadius = UDim.new(0, 10)

    local lLbl = Instance.new("TextLabel", langCard)
    lLbl.Size = UDim2.new(1, -120, 0, 20)
    lLbl.Position = UDim2.new(0, 12, 0, 8)
    lLbl.BackgroundTransparency = 1
    lLbl.Text = "Ngôn ngữ"
    lLbl.TextColor3 = C.text
    lLbl.TextSize = 12
    lLbl.Font = Enum.Font.GothamSemibold
    lLbl.TextXAlignment = Enum.TextXAlignment.Left

    local viBtn = Instance.new("TextButton", langCard)
    viBtn.Size = UDim2.new(0, 44, 0, 30)
    viBtn.Position = UDim2.new(1, -102, 0.5, -15)
    viBtn.BackgroundColor3 = S.Language == "vi" and C.neon or C.surface3
    viBtn.Text = "VI"
    viBtn.TextColor3 = C.white
    viBtn.TextSize = 12
    viBtn.Font = Enum.Font.GothamBold
    viBtn.BorderSizePixel = 0
    Instance.new("UICorner", viBtn).CornerRadius = UDim.new(0, 8)

    local enBtn = Instance.new("TextButton", langCard)
    enBtn.Size = UDim2.new(0, 44, 0, 30)
    enBtn.Position = UDim2.new(1, -54, 0.5, -15)
    enBtn.BackgroundColor3 = S.Language == "en" and C.neon or C.surface3
    enBtn.Text = "EN"
    enBtn.TextColor3 = C.white
    enBtn.TextSize = 12
    enBtn.Font = Enum.Font.GothamBold
    enBtn.BorderSizePixel = 0
    Instance.new("UICorner", enBtn).CornerRadius = UDim.new(0, 8)

    viBtn.MouseButton1Click:Connect(function()
        S.Language = "vi"
        viBtn.BackgroundColor3 = C.neon
        enBtn.BackgroundColor3 = C.surface3
        SetStatus("Tiếng Việt", C.success)
    end)
    enBtn.MouseButton1Click:Connect(function()
        S.Language = "en"
        viBtn.BackgroundColor3 = C.surface3
        enBtn.BackgroundColor3 = C.neon
        SetStatus("English", C.success)
    end)

    Section(p, "DEBUG", 3)
    Button(p, "Log Remotes", C.neonDim, function()
        local rc = GetRemotes()
        local n = 0
        for name, _ in pairs(rc.events) do print("  [E] " .. name); n = n + 1 end
        for name, _ in pairs(rc.funcs) do print("  [F] " .. name); n = n + 1 end
        print("[ARISE] Total remotes: " .. n)
        SetStatus("Log " .. n .. " remotes → F9", C.info)
    end, 4)
    Button(p, "Test Attack", C.neonDim, function()
        local m = AllMobs(S.FarmRadius)
        if #m > 0 then Attack(m[1]); SetStatus("Attack: " .. m[1].M.Name, C.info)
        else SetStatus("Không có mob", C.danger) end
    end, 5)
end)

-- ================================================================
-- RESPAWN RECOVERY
-- ================================================================
LP.CharacterAdded:Connect(function(c)
    task.wait(1.5)
    RefreshChar(c)
end)

-- ================================================================
-- SPLASH → MENU
-- ================================================================
SwitchTab("farm")
SetStatus("Loading...", C.textDim)
print("[ARISE v6.4] building pages...")

task.delay(2.5, function()
    pcall(function()
        TweenService:Create(Splash, TweenInfo.new(0.6), {BackgroundTransparency = 1}):Play()
        TweenService:Create(SplashLabel, TweenInfo.new(0.6), {TextTransparency = 1}):Play()
        TweenService:Create(SplashSub, TweenInfo.new(0.6), {TextTransparency = 1}):Play()
        TweenService:Create(SplashGlow, TweenInfo.new(0.6), {BackgroundTransparency = 1}):Play()
        TweenService:Create(GlowStroke, TweenInfo.new(0.6), {Transparency = 1}):Play()
    end)
    task.wait(0.3)
    pcall(function()
        Main.Visible = true
        TweenService:Create(Main, TweenInfo.new(0.5), {BackgroundTransparency = 0}):Play()
        TweenService:Create(MS, TweenInfo.new(0.5), {Transparency = 0.3}):Play()
    end)
    task.wait(0.7)
    pcall(function() Splash:Destroy() end)
    SetStatus("Ready — v6.4", C.success)
    print("[ARISE v6.4] menu revealed")
end)

print("[ARISE v6.4] DONE")
