dofile("irc/init.lua")
dofile("functions.lua")
if exists("config.lua") then dofile("config.lua") else error "I don't think you got the config.lua (Or I was not able to find it)" end
if not config then error "Did you just create a blank config.lua?!?!?! We have it in the git repo." end
if config.die then error "You might want to edit config.lua..." end
if not config.serverPort then error "Edit the config file" end
if not config.server then error "Edit the config.lua." end
if not config.autorun then error "Edit the config.lua." end
if not config.channels then error "Edit the config.lua." end
if not config.enabledCommands then error "Edit the config.lua." end
if not config.nick then error "Edit the config.lua." end
if not config.username then error "Edit the config.lua" end
if not config.realname then error "Edit the config.lua" end
if not config.factoids then error "Edit the config.lua"
elseif config.factoids.enabled == "true" then
    if not config.factoids.db then
	   error "You are missing a config.factoids.db config option. (Block: factoids)"
	end
end

user = {}
user.nick = config.nick
user.username = config.username
user.realname = config.realname
irc=irc.new(user)
irc:connect(config.server,config.serverPort,config.server)
local sleep=require "socket".sleep
irc:send("NOTICE wolfmitchell :Connected!")
print("Connected to "..config.serverPort)

for i=1,50 do
    irc:think()
end
---
sleep(5)

for i=1,#config.autorun do
    if config.autorun[i] then
	    irc:send(config.autorun[i])
		sleep(0.2)
	end
end

for i=1,#config.channels do
    if config.channels[i] then
        irc:join(config.channels[i]
    end
end

---
irc:think()
dofile("perms.lua")
dofile("sandbox.lua")

-- --[[
dofile("commands.lua")
-- ]]--


while true do
irc:think()
irc:send("PING irc.freenode.net MitchAnnouncer")
irc:hook("OnChat","Called whan player chats",chat)
sleep(2.5)
end
