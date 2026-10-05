--[[
    NF HUB - Interface Base
    Tema: Preto / Cinza / Branco
    Compatível com Roblox Lua / executores que suportem CoreGui.

    Esta versão cria somente a interface e os controles visuais.
    As funções específicas de cada botão podem ser conectadas depois.
]]

local Players = game:GetService("Players")
local UIS = game:GetService("UserInputService")

local player = Players.LocalPlayer
local guiParent = (gethui and gethui()) or game:GetService("CoreGui")

local Theme = {
    Background = Color3.fromRGB(8, 8, 10),
    Panel = Color3.fromRGB(13, 14, 17),
    Surface = Color3.fromRGB(18, 19, 23),
    Surface2 = Color3.fromRGB(24, 25, 30),
    Border = Color3.fromRGB(42, 43, 49),
    Text = Color3.fromRGB(245, 245, 245),
    SubText = Color3.fromRGB(150, 151, 158),
    Accent = Color3.fromRGB(235, 235, 235),
    ToggleOff = Color3.fromRGB(45, 46, 53),
    ToggleOn = Color3.fromRGB(235, 235, 235),
}

local old = guiParent:FindFirstChild("NF_HUB")
if old then
    old:Destroy()
end

local function New(class, props, parent)
    local obj = Instance.new(class)
    for k, v in pairs(props or {}) do
        obj[k] = v
    end
    obj.Parent = parent
    return obj
end

local function Corner(parent, radius)
    return New("UICorner", {
        CornerRadius = UDim.new(0, radius or 8)
    }, parent)
end

local function Stroke(parent, color, transparency)
    return New("UIStroke", {
        Color = color or Theme.Border,
        Transparency = transparency or 0,
        Thickness = 1
    }, parent)
end

local function Padding(parent, value)
    return New("UIPadding", {
        PaddingTop = UDim.new(0, value),
        PaddingBottom = UDim.new(0, value),
        PaddingLeft = UDim.new(0, value),
        PaddingRight = UDim.new(0, value)
    }, parent)
end

local Screen = New("ScreenGui", {
    Name = "NF_HUB",
    ResetOnSpawn = false,
    ZIndexBehavior = Enum.ZIndexBehavior.Sibling
}, guiParent)

-- Floating open button
local OpenButton = New("TextButton", {
    Name = "OpenButton",
    Size = UDim2.fromOffset(48, 48),
    Position = UDim2.new(0, 18, 0.5, -24),
    BackgroundColor3 = Theme.Panel,
    Text = "NF",
    TextColor3 = Theme.Text,
    TextSize = 16,
    Font = Enum.Font.GothamBold,
    AutoButtonColor = false
}, Screen)
Corner(OpenButton, 14)
Stroke(OpenButton)

-- Main window
local Main = New("Frame", {
    Name = "Main",
    Size = UDim2.new(0, 865, 0, 575),
    Position = UDim2.new(0.5, -432, 0.5, -287),
    BackgroundColor3 = Theme.Background,
    BorderSizePixel = 0
}, Screen)
Corner(Main, 14)
Stroke(Main, Theme.Border)

-- Make mobile-friendly if screen is small
local camera = workspace.CurrentCamera
if camera and camera.ViewportSize.X < 900 then
    Main.Size = UDim2.new(0, math.max(320, camera.ViewportSize.X - 24), 0, math.min(575, camera.ViewportSize.Y - 30))
    Main.Position = UDim2.new(0.5, -Main.Size.X.Offset/2, 0.5, -Main.Size.Y.Offset/2)
end

local Sidebar = New("Frame", {
    Name = "Sidebar",
    Size = UDim2.new(0, 220, 1, 0),
    BackgroundColor3 = Theme.Panel,
    BorderSizePixel = 0
}, Main)

local Divider = New("Frame", {
    Size = UDim2.new(0, 1, 1, -24),
    Position = UDim2.new(1, 0, 0, 12),
    BackgroundColor3 = Theme.Border,
    BorderSizePixel = 0
}, Sidebar)

-- Header
local Brand = New("TextLabel", {
    Size = UDim2.new(1, -32, 0, 28),
    Position = UDim2.new(0, 16, 0, 16),
    BackgroundTransparency = 1,
    Text = "NF HUB",
    TextColor3 = Theme.Text,
    TextSize = 19,
    Font = Enum.Font.GothamBold,
    TextXAlignment = Enum.TextXAlignment.Left
}, Sidebar)

local Subtitle = New("TextLabel", {
    Size = UDim2.new(1, -32, 0, 18),
    Position = UDim2.new(0, 16, 0, 43),
    BackgroundTransparency = 1,
    Text = "Black • Gray • White",
    TextColor3 = Theme.SubText,
    TextSize = 11,
    Font = Enum.Font.Gotham,
    TextXAlignment = Enum.TextXAlignment.Left
}, Sidebar)

local AccentLine = New("Frame", {
    Size = UDim2.fromOffset(28, 2),
    Position = UDim2.new(0, 16, 0, 67),
    BackgroundColor3 = Theme.Text,
    BorderSizePixel = 0
}, Sidebar)
Corner(AccentLine, 2)

-- Search
local SearchBox = New("TextBox", {
    Size = UDim2.new(1, -28, 0, 38),
    Position = UDim2.new(0, 14, 0, 84),
    BackgroundColor3 = Theme.Surface,
    BorderSizePixel = 0,
    PlaceholderText = "Search...",
    PlaceholderColor3 = Theme.SubText,
    Text = "",
    TextColor3 = Theme.Text,
    TextSize = 12,
    Font = Enum.Font.Gotham,
    ClearTextOnFocus = false
}, Sidebar)
Corner(SearchBox, 9)
Stroke(SearchBox)

-- Navigation
local Nav = New("ScrollingFrame", {
    Size = UDim2.new(1, -20, 1, -140),
    Position = UDim2.new(0, 10, 0, 132),
    BackgroundTransparency = 1,
    BorderSizePixel = 0,
    ScrollBarThickness = 2,
    ScrollBarImageColor3 = Theme.Border,
    CanvasSize = UDim2.new()
}, Sidebar)

local navLayout = New("UIListLayout", {
    Padding = UDim.new(0, 5),
    SortOrder = Enum.SortOrder.LayoutOrder
}, Nav)

local Content = New("Frame", {
    Name = "Content",
    Size = UDim2.new(1, -220, 1, 0),
    Position = UDim2.new(0, 220, 0, 0),
    BackgroundTransparency = 1
}, Main)

local Top = New("Frame", {
    Size = UDim2.new(1, -24, 0, 64),
    Position = UDim2.new(0, 12, 0, 12),
    BackgroundColor3 = Theme.Panel,
    BorderSizePixel = 0
}, Content)
Corner(Top, 11)
Stroke(Top)

local PageTitle = New("TextLabel", {
    Size = UDim2.new(1, -100, 0, 25),
    Position = UDim2.new(0, 18, 0, 10),
    BackgroundTransparency = 1,
    Text = "Farm",
    TextColor3 = Theme.Text,
    TextSize = 17,
    Font = Enum.Font.GothamBold,
    TextXAlignment = Enum.TextXAlignment.Left
}, Top)

local PageDesc = New("TextLabel", {
    Size = UDim2.new(1, -100, 0, 18),
    Position = UDim2.new(0, 18, 0, 34),
    BackgroundTransparency = 1,
    Text = "Auto farm e opções principais.",
    TextColor3 = Theme.SubText,
    TextSize = 10,
    Font = Enum.Font.Gotham,
    TextXAlignment = Enum.TextXAlignment.Left
}, Top)

local Minimize = New("TextButton", {
    Size = UDim2.fromOffset(34, 34),
    Position = UDim2.new(1, -78, 0, 15),
    BackgroundColor3 = Theme.Surface,
    Text = "−",
    TextColor3 = Theme.SubText,
    TextSize = 18,
    Font = Enum.Font.GothamBold,
    AutoButtonColor = false
}, Top)
Corner(Minimize, 9)

local Close = New("TextButton", {
    Size = UDim2.fromOffset(34, 34),
    Position = UDim2.new(1, -40, 0, 15),
    BackgroundColor3 = Theme.Surface,
    Text = "×",
    TextColor3 = Theme.SubText,
    TextSize = 18,
    Font = Enum.Font.GothamBold,
    AutoButtonColor = false
}, Top)
Corner(Close, 9)

local Pages = New("ScrollingFrame", {
    Size = UDim2.new(1, -24, 1, -88),
    Position = UDim2.new(0, 12, 0, 76),
    BackgroundTransparency = 1,
    BorderSizePixel = 0,
    ScrollBarThickness = 3,
    ScrollBarImageColor3 = Theme.Border,
    CanvasSize = UDim2.new()
}, Content)

local PageContainer = New("Frame", {
    Size = UDim2.new(1, -8, 0, 0),
    BackgroundTransparency = 1
}, Pages)

local pageLayout = New("UIListLayout", {
    Padding = UDim.new(0, 10),
    SortOrder = Enum.SortOrder.LayoutOrder
}, PageContainer)

local function MakeSection(title)
    local section = New("Frame", {
        Size = UDim2.new(1, 0, 0, 24),
        BackgroundTransparency = 1
    }, PageContainer)

    local bar = New("Frame", {
        Size = UDim2.fromOffset(3, 16),
        Position = UDim2.new(0, 2, 0, 4),
        BackgroundColor3 = Theme.Text,
        BorderSizePixel = 0
    }, section)
    Corner(bar, 2)

    New("TextLabel", {
        Size = UDim2.new(1, -20, 1, 0),
        Position = UDim2.new(0, 14, 0, 0),
        BackgroundTransparency = 1,
        Text = title:upper(),
        TextColor3 = Theme.SubText,
        TextSize = 10,
        Font = Enum.Font.GothamMedium,
        TextXAlignment = Enum.TextXAlignment.Left
    }, section)

    return section
end

local function MakeToggle(title, description, default, callback)
    local row = New("Frame", {
        Size = UDim2.new(1, 0, 0, 68),
        BackgroundColor3 = Theme.Surface,
        BorderSizePixel = 0
    }, PageContainer)
    Corner(row, 11)
    Stroke(row)

    New("TextLabel", {
        Size = UDim2.new(1, -95, 0, 22),
        Position = UDim2.new(0, 18, 0, 11),
        BackgroundTransparency = 1,
        Text = title,
        TextColor3 = Theme.Text,
        TextSize = 13,
        Font = Enum.Font.GothamMedium,
        TextXAlignment = Enum.TextXAlignment.Left
    }, row)

    New("TextLabel", {
        Size = UDim2.new(1, -95, 0, 27),
        Position = UDim2.new(0, 18, 0, 33),
        BackgroundTransparency = 1,
        Text = description or "",
        TextColor3 = Theme.SubText,
        TextSize = 10,
        Font = Enum.Font.Gotham,
        TextWrapped = true,
        TextXAlignment = Enum.TextXAlignment.Left
    }, row)

    local toggle = New("TextButton", {
        Size = UDim2.fromOffset(46, 25),
        Position = UDim2.new(1, -64, 0.5, -12),
        BackgroundColor3 = default and Theme.ToggleOn or Theme.ToggleOff,
        Text = "",
        AutoButtonColor = false
    }, row)
    Corner(toggle, 13)

    local knob = New("Frame", {
        Size = UDim2.fromOffset(19, 19),
        Position = default and UDim2.new(1, -22, 0.5, -9) or UDim2.new(0, 3, 0.5, -9),
        BackgroundColor3 = default and Theme.Background or Color3.fromRGB(175, 176, 184),
        BorderSizePixel = 0
    }, toggle)
    Corner(knob, 10)

    local state = default
    local function Set(v)
        state = v
        toggle.BackgroundColor3 = v and Theme.ToggleOn or Theme.ToggleOff
        knob.Position = v and UDim2.new(1, -22, 0.5, -9) or UDim2.new(0, 3, 0.5, -9)
        knob.BackgroundColor3 = v and Theme.Background or Color3.fromRGB(175, 176, 184)
        if callback then
            task.spawn(callback, v)
        end
    end

    toggle.MouseButton1Click:Connect(function()
        Set(not state)
    end)

    return Set
end

local function MakeSlider(title, description, min, max, default, callback)
    local row = New("Frame", {
        Size = UDim2.new(1, 0, 0, 78),
        BackgroundColor3 = Theme.Surface,
        BorderSizePixel = 0
    }, PageContainer)
    Corner(row, 11)
    Stroke(row)

    New("TextLabel", {
        Size = UDim2.new(1, -90, 0, 22),
        Position = UDim2.new(0, 18, 0, 10),
        BackgroundTransparency = 1,
        Text = title,
        TextColor3 = Theme.Text,
        TextSize = 13,
        Font = Enum.Font.GothamMedium,
        TextXAlignment = Enum.TextXAlignment.Left
    }, row)

    local valueLabel = New("TextLabel", {
        Size = UDim2.fromOffset(70, 20),
        Position = UDim2.new(1, -88, 0, 10),
        BackgroundTransparency = 1,
        Text = tostring(default),
        TextColor3 = Theme.SubText,
        TextSize = 10,
        Font = Enum.Font.Gotham,
        TextXAlignment = Enum.TextXAlignment.Right
    }, row)

    New("TextLabel", {
        Size = UDim2.new(1, -36, 0, 17),
        Position = UDim2.new(0, 18, 0, 31),
        BackgroundTransparency = 1,
        Text = description or "",
        TextColor3 = Theme.SubText,
        TextSize = 9,
        Font = Enum.Font.Gotham,
        TextXAlignment = Enum.TextXAlignment.Left
    }, row)

    local bar = New("Frame", {
        Size = UDim2.new(1, -36, 0, 5),
        Position = UDim2.new(0, 18, 1, -14),
        BackgroundColor3 = Theme.ToggleOff,
        BorderSizePixel = 0
    }, row)
    Corner(bar, 3)

    local fill = New("Frame", {
        Size = UDim2.new((default-min)/(max-min), 0, 1, 0),
        BackgroundColor3 = Theme.Text,
        BorderSizePixel = 0
    }, bar)
    Corner(fill, 3)

    local dragging = false
    local function Update(x)
        local pct = math.clamp((x - bar.AbsolutePosition.X) / bar.AbsoluteSize.X, 0, 1)
        local value = math.floor(min + (max-min)*pct + 0.5)
        fill.Size = UDim2.new(pct, 0, 1, 0)
        valueLabel.Text = tostring(value)
        if callback then callback(value) end
    end

    bar.InputBegan:Connect(function(input)
        if input.UserInputType == Enum.UserInputType.MouseButton1 or input.UserInputType == Enum.UserInputType.Touch then
            dragging = true
            Update(input.Position.X)
        end
    end)
    UIS.InputChanged:Connect(function(input)
        if dragging and (input.UserInputType == Enum.UserInputType.MouseMovement or input.UserInputType == Enum.UserInputType.Touch) then
            Update(input.Position.X)
        end
    end)
    UIS.InputEnded:Connect(function(input)
        if input.UserInputType == Enum.UserInputType.MouseButton1 or input.UserInputType == Enum.UserInputType.Touch then
            dragging = false
        end
    end)
end

local function MakeSelect(title, description, options, defaultIndex, callback)
    local row = New("Frame", {
        Size = UDim2.new(1, 0, 0, 70),
        BackgroundColor3 = Theme.Surface,
        BorderSizePixel = 0
    }, PageContainer)
    Corner(row, 11)
    Stroke(row)

    New("TextLabel", {
        Size = UDim2.new(1, -210, 0, 22),
        Position = UDim2.new(0, 18, 0, 10),
        BackgroundTransparency = 1,
        Text = title,
        TextColor3 = Theme.Text,
        TextSize = 13,
        Font = Enum.Font.GothamMedium,
        TextXAlignment = Enum.TextXAlignment.Left
    }, row)

    New("TextLabel", {
        Size = UDim2.new(1, -210, 0, 25),
        Position = UDim2.new(0, 18, 0, 33),
        BackgroundTransparency = 1,
        Text = description or "",
        TextColor3 = Theme.SubText,
        TextSize = 9,
        Font = Enum.Font.Gotham,
        TextWrapped = true,
        TextXAlignment = Enum.TextXAlignment.Left
    }, row)

    local button = New("TextButton", {
        Size = UDim2.fromOffset(180, 38),
        Position = UDim2.new(1, -198, 0.5, -19),
        BackgroundColor3 = Theme.Surface2,
        Text = tostring(options[defaultIndex or 1] or "None"),
        TextColor3 = Theme.SubText,
        TextSize = 11,
        Font = Enum.Font.Gotham,
        AutoButtonColor = false
    }, row)
    Corner(button, 9)

    local index = defaultIndex or 1
    button.MouseButton1Click:Connect(function()
        index += 1
        if index > #options then index = 1 end
        button.Text = tostring(options[index])
        if callback then callback(options[index], index) end
    end)
end

local PagesData = {
    {
        name = "Farm",
        icon = "●",
        desc = "Alvo e campo.",
        build = function()
            MakeSection("Farm")
            MakeToggle("Farm automático", "Ativa a rotina principal de farm.", false)
            MakeSlider("Velocidade da volta", "Controla a velocidade da rotina.", 50, 800, 400)
            MakeSelect("Filtro do Farm", "Escolha como selecionar os alvos.", {"Por raridade", "Por valor", "Manual"}, 1)
            MakeSelect("Raridades", "Define quais raridades serão priorizadas.", {"Nenhuma", "3 selecionadas", "Todas"}, 2)
            MakeSection("Auto Attack")
            MakeToggle("Auto Attack", "Ativa o controle automático de ataque.", false)
            MakeToggle("Trocar de Bat", "Troca automaticamente para o melhor item disponível.", false)
        end
    },
    {
        name = "ESP",
        icon = "●",
        desc = "Visualização de objetos.",
        build = function()
            MakeSection("ESP")
            MakeToggle("ESP de ovos", "Exibe informações dos ovos selecionados.", false)
            MakeToggle("ESP do melhor ovo", "Destaca o alvo principal do farm.", false)
            MakeToggle("ESP de áreas", "Mostra informações das áreas.", false)
            MakeToggle("ESP de players", "Mostra jogadores e distância.", false)
            MakeToggle("Ovos do plot", "Exibe informações dos ovos do seu plot.", false)
        end
    },
    {
        name = "Personagem",
        icon = "♟",
        desc = "Movimento e proteção.",
        build = function()
            MakeSection("Personagem")
            MakeToggle("Anti-knockback", "Reduz efeitos de empurrão.", false)
            MakeToggle("Sempre equipar melhor item", "Mantém o melhor item selecionado.", false)
            MakeToggle("Proteção", "Espaço reservado para opções de movimento.", false)
        end
    },
    {
        name = "Índice",
        icon = "■",
        desc = "Controle do índice.",
        build = function()
            MakeSection("Caçada")
            MakeToggle("Caçar pets que faltam", "Ativa a rotina de procura de itens do índice.", false)
            MakeToggle("Trocar de servidor", "Alterna de servidor quando necessário.", false)
            MakeSection("Recompensas")
            MakeToggle("Resgatar recompensas", "Ativa o controle visual de recompensas.", false)
        end
    },
    {
        name = "Dr Scramble",
        icon = "◆",
        desc = "Evento e opções.",
        build = function()
            MakeSection("Evento")
            MakeToggle("Auto Boss Fight", "Controle visual do evento.", false)
            MakeToggle("Resgatar Boss Mastery", "Controle visual de recompensas.", false)
            MakeToggle("Mutação Automática", "Controle visual de mutações.", false)
            MakeSection("Loja")
            MakeToggle("Auto Comprar", "Controle visual de compras do evento.", false)
        end
    },
    {
        name = "Admin Abuse",
        icon = "■",
        desc = "Eventos temporários.",
        build = function()
            MakeSection("Evento")
            MakeToggle("Auto Evento", "Controle visual do evento.", false)
        end
    },
    {
        name = "Terreno",
        icon = "⌂",
        desc = "Seu terreno e servidor.",
        build = function()
            MakeSection("Terreno")
            MakeToggle("Plantar automaticamente", "Controle visual para plantio.", false)
            MakeToggle("Abrir ovos automaticamente", "Controle visual para abertura de ovos.", false)
            MakeToggle("Somente ovos mutados", "Filtra ovos mutados.", false)
            MakeSection("Pets")
            MakeToggle("Auto equipar melhores pets", "Controle visual para equipar pets.", false)
            MakeToggle("Auto vender pets ruins", "Controle visual para venda.", false)
        end
    },
    {
        name = "Interface",
        icon = "⚙",
        desc = "Tema, desempenho e configs.",
        build = function()
            MakeSection("Desempenho")
            MakeToggle("Turbo FPS", "Opção visual de desempenho.", false)
            MakeToggle("Mostrar marca d'água", "Exibe ou oculta a marca do hub.", false)
            MakeSection("Tema")
            MakeSelect("Tema", "Tema atual da interface.", {"NF Dark", "NF Gray", "NF Light"}, 1)
            MakeSection("Configurações")
            MakeToggle("Salvar configurações", "Mantém suas preferências.", true)
        end
    }
}

local currentPage

local function ClearPage()
    for _, child in ipairs(PageContainer:GetChildren()) do
        if not child:IsA("UIListLayout") then
            child:Destroy()
        end
    end
end

local function ShowPage(data)
    ClearPage()
    PageTitle.Text = data.name
    PageDesc.Text = data.desc
    data.build()
    task.defer(function()
        Pages.CanvasSize = UDim2.new(0, 0, 0, pageLayout.AbsoluteContentSize.Y + 12)
    end)
end

for i, data in ipairs(PagesData) do
    local button = New("TextButton", {
        Name = data.name,
        Size = UDim2.new(1, -4, 0, 39),
        BackgroundColor3 = i == 1 and Theme.Surface2 or Color3.fromRGB(0,0,0),
        BackgroundTransparency = i == 1 and 0 or 1,
        Text = "",
        AutoButtonColor = false,
        LayoutOrder = i
    }, Nav)
    Corner(button, 8)

    local activeBar = New("Frame", {
        Size = UDim2.fromOffset(3, 20),
        Position = UDim2.new(0, 0, 0.5, -10),
        BackgroundColor3 = Theme.Text,
        BorderSizePixel = 0,
        Visible = i == 1
    }, button)
    Corner(activeBar, 2)

    New("TextLabel", {
        Size = UDim2.fromOffset(25, 39),
        Position = UDim2.new(0, 12, 0, 0),
        BackgroundTransparency = 1,
        Text = data.icon,
        TextColor3 = i == 1 and Theme.Text or Theme.SubText,
        TextSize = 12,
        Font = Enum.Font.GothamBold
    }, button)

    local label = New("TextLabel", {
        Size = UDim2.new(1, -45, 1, 0),
        Position = UDim2.new(0, 40, 0, 0),
        BackgroundTransparency = 1,
        Text = data.name,
        TextColor3 = i == 1 and Theme.Text or Theme.SubText,
        TextSize = 12,
        Font = Enum.Font.GothamMedium,
        TextXAlignment = Enum.TextXAlignment.Left
    }, button)

    button.MouseButton1Click:Connect(function()
        for _, other in ipairs(Nav:GetChildren()) do
            if other:IsA("TextButton") then
                other.BackgroundTransparency = 1
                local bar = other:FindFirstChildOfClass("Frame")
                if bar then bar.Visible = false end
                for _, child in ipairs(other:GetChildren()) do
                    if child:IsA("TextLabel") then
                        child.TextColor3 = Theme.SubText
                    end
                end
            end
        end

        button.BackgroundColor3 = Theme.Surface2
        button.BackgroundTransparency = 0
        activeBar.Visible = true
        label.TextColor3 = Theme.Text

        ShowPage(data)
    end)
end

navLayout:GetPropertyChangedSignal("AbsoluteContentSize"):Connect(function()
    Nav.CanvasSize = UDim2.new(0, 0, 0, navLayout.AbsoluteContentSize.Y + 8)
end)

-- Search filter
SearchBox:GetPropertyChangedSignal("Text"):Connect(function()
    local query = string.lower(SearchBox.Text)
    for _, child in ipairs(Nav:GetChildren()) do
        if child:IsA("TextButton") then
            child.Visible = query == "" or string.find(string.lower(child.Name), query, 1, true) ~= nil
        end
    end
end)

-- Minimize / close
local minimized = false
Minimize.MouseButton1Click:Connect(function()
    minimized = not minimized
    Sidebar.Visible = not minimized
    Content.Visible = not minimized
    Main.Size = minimized and UDim2.fromOffset(170, 52) or UDim2.new(0, 865, 0, 575)
end)

Close.MouseButton1Click:Connect(function()
    Screen:Destroy()
end)

OpenButton.MouseButton1Click:Connect(function()
    Main.Visible = not Main.Visible
end)

-- Dragging
local dragging, dragStart, startPos

Top.InputBegan:Connect(function(input)
    if input.UserInputType == Enum.UserInputType.MouseButton1 or input.UserInputType == Enum.UserInputType.Touch then
        dragging = true
        dragStart = input.Position
        startPos = Main.Position
    end
end)

UIS.InputChanged:Connect(function(input)
    if dragging and (input.UserInputType == Enum.UserInputType.MouseMovement or input.UserInputType == Enum.UserInputType.Touch) then
        local delta = input.Position - dragStart
        Main.Position = UDim2.new(
            startPos.X.Scale, startPos.X.Offset + delta.X,
            startPos.Y.Scale, startPos.Y.Offset + delta.Y
        )
    end
end)

UIS.InputEnded:Connect(function(input)
    if input.UserInputType == Enum.UserInputType.MouseButton1 or input.UserInputType == Enum.UserInputType.Touch then
        dragging = false
    end
end)

-- First page
ShowPage(PagesData[1])

print("[NF HUB] Interface carregada.")
