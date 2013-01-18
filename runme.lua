dofile("irc/init.lua")
dofile("functions.lua")
if exists("config.lua") then dofile("config.lua") else error "I don't think you got the config.lua (Or I was not able to find it)" end
if not (config or config.serverPort or config.server or config.autorun or config.channels or config.enabledCommands or config.nick or config.username or config.realname or config.factoids) then error "Edit config.lua" end
if config.factoids.enabled == "true" then
    if not config.factoids.db then
	   error "You are missing a config.factoids.db config option. (Block: factoids)"
	end
end
if not config.modules then print("No modules are being loaded. If you want to add a module add it's folder name in the table.") end

user = {}
user.nick = config.nick
user.username = config.username
user.realname = config.realname
irc=irc.new(user)
irc:connect(config.server,config.serverPort,config.server)
local sleep=require "socket".sleep
print("[CONNECT] "..config.server..":"..config.serverPort)

for i=1,50 do
    irc:think()
end
---
sleep(5)

for i=1,#config.autorun do
	    irc:send(config.autorun[i])
		sleep(0.2)
end

for i=1,#config.channels do
    if config.channels[i] then
        irc:join(config.channels[i])
		sleep(0.2)
    end
end
-- --[[
dofile("commands.lua")
irc:hook("OnChat","ctcp",ctcp)
-- ]]--
---
irc:think()
dofile("perms.lua")
dofile("sandbox.lua")


registered_modules = {}
module_commands = {}
function module_register(modulename)
    local exists=false
    for i=1,#registered_modules do
    	 if registered_modules[i] == modulename then
    	 	exists=true
    	 end
    end
    if exists==false then
        table.insert(registered_modules,modulename)
    end
    module_commands[modulename] = {}
end
function add_module_command(modulename,command,callback)
    addbotcommand(command,callback,true)
	table.insert(module_commands[modulename],command)
end

for i=1,#config.modules do
    if exists("modules/"..config.modules[i].."/init.lua") then
	    s,r=pcall(function() dofile("modules/"..config.modules[i].."/init.lua") end)
		if s==false then
		    print("[ERROR] Module "..config.modules[i].." not loaded. Reason: failed execution. Lua error: "..r)
		else
		    print("[MODLOAD] Module "..config.modules[i].." has been successfully loaded.")
		end
	else
	    print("[ERROR]: Module "..config.modules[i].." not loaded. Reason: not found.")
	end
end
function chatpcalled(usr,channel,msg)
    s,r = pcall(function() chat(usr,channel,msg) end)
	if s == false then
	    if channel:sub(1,1)=="#" then
		    irc:sendChat(channel,"Error logged in console.")
		else
		    irc:sendChat(usr.nick,"Error logged in console.")
		end
	    print("[ERROR] "..r)
	end
end
while true do
irc:think()
irc:send("PING irc.freenode.net MitchAnnouncer")
irc:hook("OnChat","Called whan a person chats",chatpcalled)
irc:hook("OnChat","Called when a person chats",factoids)
irc:hook("OnChat","ctcp",ctcp)
sleep(2.5)
end
