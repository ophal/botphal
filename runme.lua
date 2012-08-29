dofile("irc/init.lua")
user = {}
user.nick = "MitchAnnouncer"
user.username = "MitchAnnouncer"
user.realname = "Announce bot written by Mitchell Monahan"
irc=irc.new(user)
irc:connect("irc.ircforcpu.co.cc",6667,"irc.ircforcpu.co.cc")
local sleep=require "socket".sleep
irc:send("NOTICE wolfmitchell :Connected!")
print("Note that MitchAnnouncer was designed for use by BotServ,")
print("which is in the Anope services package.")
print("Connected to irc.ircforcpu.co.cc")
for i=1,25 do
irc:think()
end
irc:join("#irc4cpu")



dofile("functions.lua")

---
irc:think()
dofile("perms.lua")
dofile("sandbox.lua")
for i=1,10 do
irc:send("samode #irc4cpu +v "..user.nick)
end

-- --[[
dofile("commands.lua")
-- ]]--
while true do
irc:think()
irc:send("PING irc.ircforcpu.co.cc MitchAnnouncer")
irc:hook("OnChat","Called whan player chats",chat)
sleep(0.5)
end
