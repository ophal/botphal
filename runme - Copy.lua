dofile("irc/init.lua")
user = {}
user.nick = "OphalBot_"
user.username = "LuaBot"
user.realname = "Announce bot written by Mitchell Monahan"
irc=irc.new(user)
irc:connect("irc.freenode.net",6667,"irc.freenode.net")
local sleep=require "socket".sleep
irc:send("NOTICE wolfmitchell :Connected!")
print("Note that MitchAnnouncer was designed for use by BotServ,")
print("which is in the Anope services package.")
print("Connected to irc.freenode.net")

irc:think()
irc:think()
irc:think()
irc:think()
irc:think()
irc:think()
irc:think()
irc:think()
irc:think()
irc:think()
irc:think()
irc:think()
irc:think()
irc:think()
irc:think()
irc:think()
irc:think()
irc:think()
irc:think()
irc:think()
irc:think()
irc:think()
irc:think()
irc:think()
irc:think()
irc:think()
irc:think()
irc:think()
irc:think()
irc:think()
irc:think()
irc:think()
irc:think()
irc:think()
irc:think()
irc:think()
irc:think()
irc:think()
irc:think()
irc:think()
irc:think()
irc:think()
irc:think()
---
sleep(5)
irc:join("#Ophal")
dofile("functions.lua")
---
irc:think()
dofile("perms.lua")
dofile("sandbox.lua")

-- --[[
dofile("commands.lua")
-- ]]--


coroutine_rcserver=coroutine.create(rcserver) --Not tested fully.
while true do
irc:think()
irc:send("PING irc.freenode.net MitchAnnouncer")
irc:hook("OnChat","Called whan player chats",chat)
sleep(2.5)
coroutine.resume(coroutine_rcserver)
end
