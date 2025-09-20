--[[
HogerHub Key System GUI

This script creates a simple key-submission interface for Roblox. It displays
a central panel with a title, a text box where users can type a key,
and two buttons: one to check the key and one to get a key. When the
"Get Key" button is clicked it copies your website link to the clipboard
and, if supported by the executor, makes an HTTP request to the site.

You can replace `validKey` with your own logic to verify keys or call
another script when the key is correct.

Usage: You can either paste this entire code into your executor or
wrap it in a loadstring. For example:

```lua
loadstring(game:HttpGet('https://raw.githubusercontent.com/yourname/repo/main/hogerhub_key_gui.lua'))()
```

Make sure your executor supports the APIs used (e.g. setclipboard, syn.request).
]]

local player = game:GetService('Players').LocalPlayer

-- remove existing GUI if present
local existing = player:FindFirstChildOfClass('PlayerGui'):FindFirstChild('HogerHubKeyGui')
if existing then
    existing:Destroy()
end

-- ScreenGui
local gui = Instance.new('ScreenGui')
gui.Name = 'HogerHubKeyGui'
gui.ResetOnSpawn = false
gui.Parent = player:FindFirstChildOfClass('PlayerGui')

-- Main frame
local frame = Instance.new('Frame')
frame.AnchorPoint = Vector2.new(0.5, 0.5)
frame.Position = UDim2.new(0.5, 0, 0.5, 0)
frame.Size = UDim2.new(0, 420, 0, 220)
frame.BackgroundColor3 = Color3.fromRGB(34, 34, 56)
frame.BorderSizePixel = 0
frame.Parent = gui

-- rounded corners
local corner = Instance.new('UICorner')
corner.CornerRadius = UDim.new(0, 8)
corner.Parent = frame

-- title label
local title = Instance.new('TextLabel')
title.BackgroundTransparency = 1
title.Size = UDim2.new(1, 0, 0, 40)
title.Position = UDim2.new(0, 0, 0, 0)
title.Font = Enum.Font.SourceSansBold
title.TextColor3 = Color3.fromRGB(255, 255, 255)
title.TextSize = 24
title.Text = 'HogerHub Script Key System'
title.Parent = frame

-- instruction label
local subtitle = Instance.new('TextLabel')
subtitle.BackgroundTransparency = 1
subtitle.Size = UDim2.new(1, 0, 0, 24)
subtitle.Position = UDim2.new(0, 0, 0, 35)
subtitle.Font = Enum.Font.SourceSans
subtitle.TextColor3 = Color3.fromRGB(200, 200, 220)
subtitle.TextSize = 16
subtitle.Text = 'Submit your key below or get one.'
subtitle.Parent = frame

-- text box for key input
local textbox = Instance.new('TextBox')
textbox.Size = UDim2.new(0.8, 0, 0, 30)
textbox.Position = UDim2.new(0.1, 0, 0, 70)
textbox.BackgroundColor3 = Color3.fromRGB(50, 50, 80)
textbox.TextColor3 = Color3.fromRGB(255, 255, 255)
textbox.PlaceholderText = 'Enter Key Here'
textbox.Font = Enum.Font.SourceSans
textbox.TextSize = 18
textbox.ClearTextOnFocus = false
textbox.Parent = frame

local tbCorner = Instance.new('UICorner')
tbCorner.CornerRadius = UDim.new(0, 6)
tbCorner.Parent = textbox

-- check key button
local checkBtn = Instance.new('TextButton')
checkBtn.Size = UDim2.new(0.38, 0, 0, 32)
checkBtn.Position = UDim2.new(0.1, 0, 0, 120)
checkBtn.BackgroundColor3 = Color3.fromRGB(85, 85, 130)
checkBtn.Font = Enum.Font.SourceSansBold
checkBtn.TextSize = 18
checkBtn.TextColor3 = Color3.fromRGB(255, 255, 255)
checkBtn.Text = 'Check Key'
checkBtn.Parent = frame

local chkCorner = Instance.new('UICorner')
chkCorner.CornerRadius = UDim.new(0, 6)
chkCorner.Parent = checkBtn

-- get key button
local getBtn = Instance.new('TextButton')
getBtn.Size = UDim2.new(0.38, 0, 0, 32)
getBtn.Position = UDim2.new(0.52, 0, 0, 120)
getBtn.BackgroundColor3 = Color3.fromRGB(85, 85, 130)
getBtn.Font = Enum.Font.SourceSansBold
getBtn.TextSize = 18
getBtn.TextColor3 = Color3.fromRGB(255, 255, 255)
getBtn.Text = 'Get Key'
getBtn.Parent = frame

local getCorner = Instance.new('UICorner')
getCorner.CornerRadius = UDim.new(0, 6)
getCorner.Parent = getBtn

-- message label for feedback
local msgLabel = Instance.new('TextLabel')
msgLabel.BackgroundTransparency = 1
msgLabel.Size = UDim2.new(1, -20, 0, 40)
msgLabel.Position = UDim2.new(0, 10, 0, 170)
msgLabel.Font = Enum.Font.SourceSans
msgLabel.TextSize = 16
msgLabel.TextColor3 = Color3.fromRGB(255, 255, 255)
msgLabel.Text = ''
msgLabel.Parent = frame

-- replace this with your own key check logic
local validKey = 'your-secret-key'

-- function to handle checking keys
checkBtn.MouseButton1Click:Connect(function()
    local key = textbox.Text or ''
    if key == '' then
        msgLabel.Text = 'Please enter a key.'
        return
    end
    if key == validKey then
        msgLabel.Text = 'Valid key! Running script...'
        wait(2)
        gui:Destroy()
        -- place your main script code here once the key is valid
    else
        msgLabel.Text = 'Invalid key. Try again or get a new one.'
    end
end)

-- function to handle getting a key
getBtn.MouseButton1Click:Connect(function()
    local url = 'https://hoger018.github.io/roblox-key-landing/'
    -- copy the URL to clipboard if supported
    if pcall(function() return setclipboard end) then
        setclipboard(url)
        msgLabel.Text = 'Link copied to clipboard!'
    else
        msgLabel.Text = 'Please open the website to get a key.'
    end
    -- attempt to open the website via executor (Synapse X / Krnl / ScriptWare etc.)
    pcall(function()
        if syn and syn.request then
            syn.request({Url = url, Method = 'GET'})
        elseif request then
            request({Url = url, Method = 'GET'})
        end
    end)
end)
