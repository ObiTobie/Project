--[[

   ____                     __           __  __      __  
  / __ \_      _____  _____/ /___  __   / / / /_  __/ /_ 
 / / / / | /| / / _ \/ ___/ __/ / / /  / /_/ / / / / __ \
/ /_/ /| |/ |/ /  __/ /  / /_/ /_/ /  / __  / /_/ / /_/ /
\___\_\|__/|__/\___/_/   \__/\__, /  /_/ /_/\__,_/_.___/ 
                            /____/                       
.gg/qwertyhub
.gg/kbjmDpJnbE

]]

do
	--// Services

	Players = game:GetService("Players")
	VirtualUser = game:GetService("VirtualUser")
	HttpService = game:GetService("HttpService")

	--// Variables

	Client = Players.LocalPlayer

	--// Script Variables
	Collection = {} Collection.__index = Collection
	__bl = {
		"solara",
		"xeno",
	}
	loading = loadstring(game:HttpGet("https://github.com/ObiTobie/File/blob/main/Library/Loading.lua?raw=true"))()
end

repeat task.wait() until game:IsLoaded()
repeat task.wait() until Client

--// Request
if http then
	Request_Var = http.request
else
	Request_Var = request
end

--// Blacklist Executor

if getexecutorname then
	for _, value in __bl do
		if getexecutorname():lower():find(value) then
			Client:Kick("Shitty Executor")
			return
		end
	end
end

--// Anti Away From Keyboard

task.spawn(function(InitializeService)
	if getconnections then
		for i,v in pairs(getconnections(Client.Idled)) do
			v:Disable() 
		end
	else
		Client.Idled:connect(function()
			VirtualUser:Button2Down(Vector2.new(0,0),workspace.CurrentCamera.CFrame)
			task.wait(1)
			VirtualUser:Button2Up(Vector2.new(0,0),workspace.CurrentCamera.CFrame)
		end)
	end
end)

--// Key Saved
if not isfolder or not readfile or not makefolder then
	Client:Kick("Shitty Executor [2]")
	return
end

if not isfolder("Qwerty") then
	makefolder("Qwerty")
end

local Config
if isfile("Qwerty/KeySaved.json") then
	local rawData = readfile("Qwerty/KeySaved.json")
	local success, result = pcall(function()
		return HttpService:JSONDecode(rawData)
	end)
	if success and typeof(result) == "table" then
		Config = result
	else
		warn("Error:", result)
		Config = {}
	end
else
	Config = {}
end

Collection.__Save = function(Data)
	writefile("Qwerty/KeySaved.json", HttpService:JSONEncode(Data))
end

--// Auto Execute
if not(disable_auto_exec) then
	xpcall(function()
		local queueonteleport = queueonteleport or queue_on_teleport or (syn and syn.queue_on_teleport) or (fluxus and fluxus.queue_on_teleport)
		if queueonteleport then
			if script_key then
				queueonteleport([[
				script_key="]] .. script_key .. [[";
				lloadstring(game:HttpGet("https://raw.githubusercontent.com/ObiTobie/Project/refs/heads/main/Qwerty/Loader.lua"))()
				]])
			elseif Config.Key then
				queueonteleport([[
				script_key="]] .. Config.Key .. [[";
				loadstring(game:HttpGet("https://raw.githubusercontent.com/ObiTobie/Project/refs/heads/main/Qwerty/Loader.lua"))()
				]])
			else
				queueonteleport([[
				loadstring(game:HttpGet("https://raw.githubusercontent.com/ObiTobie/Project/refs/heads/main/Qwerty/Loader.lua"))()
				]])
			end
		end
	end, function(err : string)
		warn("error "..err)
	end)
end

--// Jojn Discord
Request_Var({
	Url = "http://127.0.0.1:6463/rpc?v=1",
	Method = "POST",
	Headers = {
		["Content-Type"] = "application/json",
		["origin"] = "https://discord.com",
	},
	Body = HttpService:JSONEncode(
		{
			["args"] = {
				["code"] = "v5CJQneD9g",
			},
			["cmd"] = "INVITE_BROWSER",
			["nonce"] = "."
		})
})

--// Load Scripts
__f = {
	['__game'] = function()
		local g = game.GameId
		if g == 7074860883 then return "44c769a5dbb2c26b95c95478d4efdc41" -- Arise Crossoever
		elseif g == 6331902150 then return "f3bacaad8713105f9bce4aeff0139eb3" -- Forsaken
		elseif g == 6884266247 then return "8f2e6dc56108f1b65e447fb84232e70c" -- Anime Ranger X
		elseif g == 6115988515 then return "0c3c8d7f78bcaf0438c9945eb9a46c11" -- Anime Saga
		end
	end;
	['__load'] = function(s : string) (load or loadstring)(game:HttpGet(s))() end;
}

local api = loadstring(game:HttpGet("https://sdkapi-public.luarmor.net/library.lua"))()

if __f['__game']() then
	api.script_id = __f['__game']();
else
	Client:Kick("ไอ้เหี้ยโง่ รันแแมพที่กูไม่ได้ทำควายชิบหาย")
	return
end

if script_key then
	if (api.check_key(script_key).code == "KEY_VALID") then 
		script_key = script_key;
		Collection.__Save({Key = script_key})
		loading.Init(3)
		api.load_script();
		return
	end
elseif Config.Key then
	if (api.check_key(Config.Key).code == "KEY_VALID") then 
		script_key = Config.Key;
		loading.Init(3)
		api.load_script();
		return
	end
else
	__f['__load']("https://raw.githubusercontent.com/ObiTobie/Project/refs/heads/main/Qwerty/KeySystem/Key.lua")
end
