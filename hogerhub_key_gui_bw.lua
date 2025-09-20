--[[ HogerHub Key System GUI (Black/White Theme) ]]

local player = game:GetService('Players').LocalPlayer

-- Remove existing key GUI
local existing = player:FindFirstChildOfClass('PlayerGui'):FindFirstChild('HogerHubKeyGui')
if existing then existing:Destroy() end

-- ScreenGui
local gui = Instance.new('ScreenGui')
gui.Name = 'HogerHubKeyGui'
gui.ResetOnSpawn = false
gui.Parent = player:FindFirstChildOfClass('PlayerGui')

-- Main panel
local frame = Instance.new('Frame')
frame.AnchorPoint = Vector2.new(0.5, 0.5)
frame.Position = UDim2.new(0.5, 0, 0.5, 0)
frame.Size = UDim2.new(0, 420, 0, 220)
frame.BackgroundColor3 = Color3.fromRGB(25, 25, 25)
frame.BorderSizePixel = 0
frame.Parent = gui
local frameCorner = Instance.new('UICorner')
frameCorner.CornerRadius = UDim.new(0, 8)
frameCorner.Parent = frame

-- Title
local title = Instance.new('TextLabel')
title.BackgroundTransparency = 1
title.Size = UDim2.new(1, 0, 0, 40)
title.Font = Enum.Font.SourceSansBold
title.TextColor3 = Color3.fromRGB(255, 255, 255)
title.TextSize = 24
title.Text = 'HogerHub Script Key System'
title.Parent = frame

-- Subtitle
local subtitle = Instance.new('TextLabel')
subtitle.BackgroundTransparency = 1
subtitle.Position = UDim2.new(0, 0, 0, 35)
subtitle.Size = UDim2.new(1, 0, 0, 24)
subtitle.Font = Enum.Font.SourceSans
subtitle.TextColor3 = Color3.fromRGB(200, 200, 200)
subtitle.TextSize = 16
subtitle.Text = 'Submit your key below or get one.'
subtitle.Parent = frame

-- TextBox for key input
local textbox = Instance.new('TextBox')
textbox.Size = UDim2.new(0.8, 0, 0, 30)
textbox.Position = UDim2.new(0.1, 0, 0, 70)
textbox.BackgroundColor3 = Color3.fromRGB(40, 40, 40)
textbox.TextColor3 = Color3.fromRGB(255, 255, 255)
textbox.PlaceholderText = 'Enter Key Here'
textbox.Font = Enum.Font.SourceSans
textbox.TextSize = 18
textbox.ClearTextOnFocus = false
textbox.Parent = frame
local tbCorner = Instance.new('UICorner')
tbCorner.CornerRadius = UDim.new(0, 6)
tbCorner.Parent = textbox

-- Check Key button
local checkBtn = Instance.new('TextButton')
checkBtn.Size = UDim2.new(0.38, 0, 0, 32)
checkBtn.Position = UDim2.new(0.1, 0, 0, 120)
checkBtn.BackgroundColor3 = Color3.fromRGB(60, 60, 60)
checkBtn.Font = Enum.Font.SourceSansBold
checkBtn.TextSize = 18
checkBtn.TextColor3 = Color3.fromRGB(255, 255, 255)
checkBtn.Text = 'Check Key'
checkBtn.Parent = frame
local chkCorner = Instance.new('UICorner')
chkCorner.CornerRadius = UDim.new(0, 6)
chkCorner.Parent = checkBtn

-- Get Key button
local getBtn = Instance.new('TextButton')
getBtn.Size = UDim2.new(0.38, 0, 0, 32)
getBtn.Position = UDim2.new(0.52, 0, 0, 120)
getBtn.BackgroundColor3 = Color3.fromRGB(60, 60, 60)
getBtn.Font = Enum.Font.SourceSansBold
getBtn.TextSize = 18
getBtn.TextColor3 = Color3.fromRGB(255, 255, 255)
getBtn.Text = 'Get Key'
getBtn.Parent = frame
local getCorner = Instance.new('UICorner')
getCorner.CornerRadius = UDim.new(0, 6)
getCorner.Parent = getBtn

-- Feedback label
local msgLabel = Instance.new('TextLabel')
msgLabel.BackgroundTransparency = 1
msgLabel.Position = UDim2.new(0, 10, 0, 170)
msgLabel.Size = UDim2.new(1, -20, 0, 40)
msgLabel.Font = Enum.Font.SourceSans
msgLabel.TextSize = 16
msgLabel.TextColor3 = Color3.fromRGB(255, 255, 255)
msgLabel.Text = ''
msgLabel.Parent = frame

-- Replace this with your key validation logic
local validKey = 'your-secret-key'

checkBtn.MouseButton1Click:Connect(function()
    local key = textbox.Text or ''
    if key == '' then
        msgLabel.Text = 'Please enter a key.'
    elseif key == validKey then
        msgLabel.Text = 'Valid key! Running script...'
        wait(2)
        gui:Destroy()
        -- Place your main script here (e.g., the rest of your hub code)
    else
        msgLabel.Text = 'Invalid key. Try again or get a new one.'
    end
end)

getBtn.MouseButton1Click:Connect(function()
    local url = 'https://hoger018.github.io/roblox-key-landing/'
    if pcall(function() return setclipboard end) then
        setclipboard(url)
        msgLabel.Text = 'Link copied to clipboard!'
    else
        msgLabel.Text = 'Please open the website to get a key.'
    end
    pcall(function()
        if syn and syn.request then
            syn.request({Url = url, Method = 'GET'})
        elseif request then
            request({Url = url, Method = 'GET'})
        end
    end)
end)
