-- language: Lua, executor: Delta X Mobile, target: Arise Crossover
-- v6.5 Fixed: pure ASCII spaces, gethui() support, fixed TabBar UIListLayout, mobile Toggle Button

if not game:IsLoaded() then
    game.Loaded:Wait()
end

local Players = game:GetService("Players")
local TweenService = game:GetService("TweenService")
local UIS = game:GetService("UserInputService")
local RS = game:GetService("ReplicatedStorage")
local WS = workspace
local VirtualUser = game:GetService("VirtualUser")

local LP = Players.LocalPlayer
if not LP then
    Players:GetPropertyChangedSignal("LocalPlayer"):Wait()
    LP = Players.LocalPlayer
end

local function GetGuiParent()
    local ok, hui = pcall(function()
        if gethui then return gethui() end
        return game:GetService("CoreGui")
    end)
    if ok and hui then return hui end
    return LP:WaitForChild("PlayerGui", 10)
end

local guiParent = GetGuiParent()
if not guiParent then
    warn("[ARISE] no GuiParent found")
    return
end

pcall(function()
    local old = guiParent:FindFirstChild("AriseVipV6")
    if old then old:Destroy() end
    local pg = LP:FindFirstChild("PlayerGui")
    if pg and pg:FindFirstChild("AriseVipV6") then
        pg.AriseVipV6:Destroy()
    end
end)

local SG = Instance.new("ScreenGui")
SG.Name = "AriseVipV6"
SG.ResetOnSpawn = false
SG.IgnoreGuiInset = true
SG.DisplayOrder = 999
SG.Parent = guiParent

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

-- ================================================================
-- MAIN WINDOW
-- ================================================================
local Main = Instance.new("Frame", SG)
Main.Size = UDim2.new(0, 320, 0, 440)
Main.Position = UDim2.new(0.5, -160, 0.5, -220)
Main.BackgroundColor3 = Color3.fromRGB(8, 8, 14)
Main.BorderSizePixel = 0
Main.ClipsDescendants = true
Main.Active = true
Main.ZIndex = 2
Main.Visible = false
Main.BackgroundTransparency = 1
Instance.new("UICorner", Main).CornerRadius = UDim.new(0, 14)

local MS = Instance.new("UIStroke", Main)
MS.Color = Color3.fromRGB(180, 80, 255)
MS.Transparency = 1
MS.Thickness = 2

-- Плавающая кнопка для телефона (свернуть/развернуть меню)
local FloatBtn = Instance.new("TextButton", SG)
FloatBtn.Size = UDim2.new(0, 42, 0, 42)
FloatBtn.Position = UDim2.new(0, 16, 0.5, -21)
FloatBtn.BackgroundColor3 = Color3.fromRGB(20, 20, 32)
FloatBtn.Text = "⚡"
FloatBtn.TextColor3 = Color3.fromRGB(220, 140, 255)
FloatBtn.TextSize = 20
FloatBtn.Font = Enum.Font.GothamBold
FloatBtn.BorderSizePixel = 0
FloatBtn.Visible = false
FloatBtn.ZIndex = 100
Instance.new("UICorner", FloatBtn).CornerRadius = UDim.new(1, 0)
local FloatStroke = Instance.new("UIStroke", FloatBtn)
FloatStroke.Color = Color3.fromRGB(180, 80, 255)
FloatStroke.Thickness = 2
FloatBtn.MouseButton1Click:Connect(function()
    Main.Visible = not Main.Visible
end)

local TBar = Instance.new("Frame", Main)
TBar.Size = UDim2.new(1, 0, 0, 52)
TBar.BackgroundColor3 = Color3.fromRGB(14, 14, 24)
TBar.BorderSizePixel = 0
TBar.Active = true
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

local MinBtn = Instance.new("TextButton", TBar)
MinBtn.Size = UDim2.new(0, 28, 0, 28)
MinBtn.Position = UDim2.new(1, -70, 0.5, -14)
MinBtn.BackgroundColor3 = Color3.fromRGB(45, 45, 70)
MinBtn.Text = "—"
MinBtn.TextColor3 = Color3.new(1, 1, 1)
MinBtn.TextSize = 12
MinBtn.Font = Enum.Font.GothamBold
MinBtn.BorderSizePixel = 0
MinBtn.ZIndex = 6
Instance.new("UICorner", MinBtn).CornerRadius = UDim.new(1, 0)
MinBtn.MouseButton1Click:Connect(function()
    Main.Visible = false
end)

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

-- Folder изолирует TabInd от UIListLayout
local IndFolder = Instance.new("Folder", TabBar)
local TabInd = Instance.new("Frame", IndFolder)
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

local Threads = {}
local function StartThread(key, fn)
    if Threads[key] then
        pcall(task.cancel, Threads[key])
    end
    Threads[key] = task.spawn(fn)
end

CloseBtn.MouseButton1Click:Connect(function()
    for k, _ in pairs(S) do
        if type(S[k]) == "boolean" then S[k] = false end
    end
    for _, th in pairs(Threads) do
        pcall(task.cancel, th)
    end
    SG:Destroy()
end)

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
if LP.Character then task.spawn(RefreshChar, LP.Character) end

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
    return pcall(function(...)
        if r:IsA("RemoteEvent") then r:FireServer(...)
        elseif r:IsA("RemoteFunction") then r:InvokeServer(...) end
    end, ...)
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
            Fire({"EnterKeyBoss", "StartKeyBoss", "JoinKeyBoss"}, S.SelectedKeyBoss
