dofile("irc/init.lua")
user = {}
user.nick = "MitchBot_"
user.username = "MitchBot"
user.realname = "Some random bot written by Mitchell Monahan"
irc=irc.new(user)
irc:connect("irc.esper.net",6667,"irc.esper.net")
local sleep=require "socket".sleep
irc:send("NOTICE wolfmitchell :Connected!")
print("Note that MitchAnnouncer was designed for use by BotServ,")
print("which is in the Anope services package.")
print("Connected to irc.esper.net")
for i=1,25 do
irc:think()
end
--irc:send("OPER LuaBot fusebox1")
irc:join("#ccbots")


dofile("functions.lua")

---
irc:think()
dofile("perms.lua")
dofile("sandbox.lua")
for i=1,10 do
-- irc:send("samode #irc4cpu +v "..user.nick)
end

-- --[[
dofile("commands.lua")
-- ]]--

coroutine_rcserver=coroutine.create(rcserver) --Not tested fully.
while true do
irc:think()
irc:send("PING irc.esper.net MitchAnnouncer")
irc:hook("OnChat","Called whan a person chats",chat)
irc:hook("OnCtcp","Called when a person sends a CTCP message",ctcp)
sleep(2.5)
coroutine.resume(coroutine_rcserver)
end
