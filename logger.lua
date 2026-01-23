--req: writefile(), appendfile(), makefolder()
task.defer(function()
	if getgenv().ChatLoggerRunning then return end
	getgenv().ChatLoggerRunning=true

	local tcs=game:GetService("TextChatService")
	local plrs=game:GetService("Players")
	local mp=game:GetService("MarketplaceService")

	local function clean(s)return tostring(s):gsub('[\\/:*?"<>|]',"_")end

	local g="unknown-game"
	pcall(function()g=mp:GetProductInfo(game.PlaceId).Name end)
	g=clean(g)
	--folder setup
	if not isfolder("logs") then makefolder("logs") end
	local gdir="logs/"..g
	if not isfolder(gdir) then makefolder(gdir) end

	local d=os.date("%d-%m-%Y")
	local t=os.date("%H-%M-%S")
	local f=gdir.."/"..d.." "..t..".txt"

	pcall(function()
		writefile(f,table.concat({
			"started - "..os.date("%d-%m-%Y %H:%M:%S"),
			"game - "..g,
			"",
      "",
		},"\n"))
	end)

	local function ts()return os.date("[%H:%M:%S]")end
	tcs.OnIncomingMessage=function(m)
		if not m.Text or m.Status~=Enum.TextChatMessageStatus.Success then return end
		local n="[system]"
		local s=m.TextSource
		if s then
			local p=plrs:GetPlayerByUserId(s.UserId)
			if p then n=p.Name end
		end
		pcall(function()
			appendfile(f,ts().." "..n..": "..m.Text:gsub("\n","\\n").."\n")
		end)
	end
	print("writing to",f)
end)
