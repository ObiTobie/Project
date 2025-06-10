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

--// Auto Execute
if not(disable_auto_exec) then
	xpcall(function()
		local queueonteleport = queueonteleport or queue_on_teleport or (syn and syn.queue_on_teleport) or (fluxus and fluxus.queue_on_teleport)
		if queueonteleport then
			queueonteleport([[
			loadstring(game:HttpGet("https://raw.githubusercontent.com/ObiTobie/Project/refs/heads/main/Qwerty/Loader.lua"))()
			]])
		end
	end, function(err : string)
		warn("error "..err)
	end)
end

--// Load Scripts

__f = {
	['__game'] = function()
		return game["GameId"]
	end;
	['__load'] = function(url)
		local response = (http and http.request or request)({
			Url = url,
			Method = "GET"
		})

		if response and response.StatusCode == 200 then
			local code = (load or loadstring)(response.Body)
			if code then
				code()
			else
				Client:Kick("Cannot Load Body")
				return
			end
		else
			Client:Kick("ไอ้เหี้ยโง่ รันแแมพที่กูไม่ได้ทำควายชิบหาย")
		end
	end
}


__f['__load'](`https://raw.githubusercontent.com/ObiTobie/Project/refs/heads/main/Qwerty/Scripts/{__f['__game']()}.lua`)
