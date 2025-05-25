if __f and Client then
	local api = __f['__load']("https://sdkapi-public.luarmor.net/library.lua")
	local script_id = __f['__game']()
	print(script_id)
	if script_id then
		api.script_id = script_id;
	else
		Client:Kick("ไอ้เหี้ยโง่ รันแแมพที่กูไม่ได้ทำควายชิบหาย")
		return
	end

	if script_key then
		if (api.check_key(script_key).code == "KEY_VALID") then 
			script_key = script_key;
			api.load_script();
			return
		end
	elseif Config.Key then
		if (api.check_key(Config.Key).code == "KEY_VALID") then 
			script_key = Config.Key;
			api.load_script();
			return
		end
	end
else
	warn(__f)
	print(Client)
end
