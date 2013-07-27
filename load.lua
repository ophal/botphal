dofile("commandEngine.lua")
dofile("plugins/users.lua")
dofile("plugins/admin.lua")
sha256=dofile("sha256.lua")
dofile("plugins/lua_sandbox.lua")
if started then 
	dofile("config.lua")
--	dofile"plugins/noping.lua"
end
