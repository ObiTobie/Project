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

	--// Variables
	
	Client = Players.LocalPlayer
end

repeat task.wait() until game:IsLoaded()
repeat task.wait() until Client

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
			if script_key then
				queueonteleport([[
				script_key="]] .. script_key .. [[";
				loadstring(game:HttpGet("https://api.luarmor.net/files/v3/loaders/c483c3ff2b3f40d2943b9d5e0a94368f.lua"))()
				]])
			else
				queueonteleport([[
				loadstring(game:HttpGet("https://api.luarmor.net/files/v3/loaders/c483c3ff2b3f40d2943b9d5e0a94368f.lua"))()
				]])
			end
		end
	end, function(err : string)
		warn("error "..err)
	end)
end
