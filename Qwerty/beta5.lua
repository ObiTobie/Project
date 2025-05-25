if __f and Client and Config then
	local __api = __f['__load']("https://sdkapi-public.luarmor.net/library.lua")
	local script_id = __f['__game']()
	print(script_id)
	if script_id then
		__api.script_id = script_id;
	else
		Client:Kick("ไอ้เหี้ยโง่ รันแแมพที่กูไม่ได้ทำควายชิบหาย")
		return
	end

	if script_key then
		if (__api.check_key(script_key).code == "KEY_VALID") then 
			script_key = script_key;
			__api.load_script();
			return
		end
	elseif Config.Key then
		if (__api.check_key(Config.Key).code == "KEY_VALID") then 
			script_key = Config.Key;
			__api.load_script();
			return
		end
	end
else
	print(Config)
	warn(__f)
	print(Client)
end
