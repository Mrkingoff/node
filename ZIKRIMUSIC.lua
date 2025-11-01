--// GUI Music Controller
local ScreenGui = Instance.new("ScreenGui")
ScreenGui.Name = "MusicControl"
ScreenGui.ResetOnSpawn = false
ScreenGui.Parent = game.Players.LocalPlayer:WaitForChild("PlayerGui")

--// FRAME UTAMA
local Frame = Instance.new("Frame")
Frame.Size = UDim2.new(0, 250, 0, 250)
Frame.Position = UDim2.new(0.35, 0, 0.35, 0)
Frame.BackgroundColor3 = Color3.fromRGB(40, 40, 40)
Frame.BorderSizePixel = 0
Frame.Active = true
Frame.Draggable = true
Frame.Parent = ScreenGui

--// TITLE
local Title = Instance.new("TextLabel")
Title.Text = "🎵 MUSIC CONTROL ALL PLAYER BY ZIKRI"
Title.Size = UDim2.new(1, 0, 0, 35)
Title.BackgroundColor3 = Color3.fromRGB(60, 60, 60)
Title.TextColor3 = Color3.fromRGB(255, 255, 255)
Title.Font = Enum.Font.GothamBold
Title.TextSize = 14
Title.Parent = Frame

--// INPUT TEXT (MASUKKAN ID MUSIK)
local MusicBox = Instance.new("TextBox")
MusicBox.PlaceholderText = "Masukkan ID Musik..."
MusicBox.Size = UDim2.new(0.8, 0, 0, 35)
MusicBox.Position = UDim2.new(0.1, 0, 0.18, 0)
MusicBox.BackgroundColor3 = Color3.fromRGB(70, 70, 70)
MusicBox.TextColor3 = Color3.fromRGB(255, 255, 255)
MusicBox.ClearTextOnFocus = false
MusicBox.Font = Enum.Font.Gotham
MusicBox.TextSize = 14
MusicBox.Parent = Frame

--// BUTTON PLAY MUSIC
local PlayButton = Instance.new("TextButton")
PlayButton.Size = UDim2.new(0.8, 0, 0, 35)
PlayButton.Position = UDim2.new(0.1, 0, 0.35, 0)
PlayButton.BackgroundColor3 = Color3.fromRGB(0, 200, 100)
PlayButton.Text = "▶️ PLAY MUSIC ALL"
PlayButton.TextColor3 = Color3.fromRGB(255, 255, 255)
PlayButton.Font = Enum.Font.GothamBold
PlayButton.TextSize = 14
PlayButton.Parent = Frame

--// BUTTON STOP MUSIC LOOP
local StopButton = Instance.new("TextButton")
StopButton.Size = UDim2.new(0.8, 0, 0, 35)
StopButton.Position = UDim2.new(0.1, 0, 0.55, 0)
StopButton.BackgroundColor3 = Color3.fromRGB(200, 50, 50)
StopButton.Text = "🛑 STOP MUSIC (OFF)"
StopButton.TextColor3 = Color3.fromRGB(255, 255, 255)
StopButton.Font = Enum.Font.GothamBold
StopButton.TextSize = 14
StopButton.Parent = Frame

--// BUTTON SLOW MUSIC
local SlowButton = Instance.new("TextButton")
SlowButton.Size = UDim2.new(0.8, 0, 0, 35)
SlowButton.Position = UDim2.new(0.1, 0, 0.73, 0)
SlowButton.BackgroundColor3 = Color3.fromRGB(255, 170, 0)
SlowButton.Text = "PLAY THEME MUSIC ZIKRI "
SlowButton.TextColor3 = Color3.fromRGB(255, 255, 255)
SlowButton.Font = Enum.Font.GothamBold
SlowButton.TextSize = 14
SlowButton.Parent = Frame

--// NOTIFIKASI
local notif = Instance.new("TextLabel")
notif.Size = UDim2.new(1, 0, 0, 20)
notif.Position = UDim2.new(0, 0, 0.92, 0)
notif.BackgroundTransparency = 1
notif.TextColor3 = Color3.fromRGB(0, 255, 0)
notif.Text = ""
notif.Font = Enum.Font.Gotham
notif.TextSize = 12
notif.Parent = Frame

--------------------------------------------------------
--// FUNGSI UNTUK FIRE KE SEMUA PLAYER
local function fireMusicCommand(cmd)
	for _, player in pairs(game.Players:GetPlayers()) do
		local function fireInFolder(folder)
			for _, item in pairs(folder:GetDescendants()) do
				if item:IsA("RemoteEvent") and item.Name == "NewSong" then
					item:FireServer(cmd)
				end
			end
		end
		if player:FindFirstChild("Backpack") then fireInFolder(player.Backpack) end
		if player.Character then fireInFolder(player.Character) end
	end
end

--------------------------------------------------------
--// STOP LOOP MUSIC
local looping = false

StopButton.MouseButton1Click:Connect(function()
	if looping then
		looping = false
		StopButton.BackgroundColor3 = Color3.fromRGB(200, 50, 50)
		StopButton.Text = "🛑 STOP MUSIC (OFF)"
		notif.Text = "⛔ Loop dimatikan!"
	else
		looping = true
		StopButton.BackgroundColor3 = Color3.fromRGB(0, 180, 255)
		StopButton.Text = "✅ STOP MUSIC (ON)"
		notif.Text = "🔁 Loop aktif! Musik dihentikan terus!"
		task.spawn(function()
			while looping do
				fireMusicCommand("Stop")
				task.wait(0)
			end
		end)
	end
end)

--------------------------------------------------------
--// PLAY MUSIC DARI ID
PlayButton.MouseButton1Click:Connect(function()
	local id = MusicBox.Text
	if id == "" then
		notif.Text = "⚠️ Masukkan ID Music dulu!"
		return
	end
	notif.Text = "▶️ Memutar musik semua player..."
	fireMusicCommand(id)
	task.wait(1)
	notif.Text = "🎶 Musik diputar: " .. id
end)

--------------------------------------------------------
--// SLOW MUSIC
SlowButton.MouseButton1Click:Connect(function()
	notif.Text = "Memutar Music"
	fireMusicCommand("121945793147563")
	task.wait(1)
	notif.Text = ""
end)
