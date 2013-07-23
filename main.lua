require"irc.init"

config={}
dofile("config.lua")
json=dofile("json.lua")
--[[
--Options:
--	config.server: IRC server to connect to
--	config.port: Port on the IRC server to connect to
-- 	config.servername: Friendly name for the IRC server.
--	config.nickname: Nickname to use on the IRC server. Must be one word.
--	config.username: Username to use on the IRC server. Must be one word.
--	config.realname: Realname to use on the IRC server. Can be multiple words.
--  config.autorun: *RAW* commands to send to the IRC server before joining channels. If this is :::SLEEP:::(sec)::: then we will wait <sec> seconds before continuing.
--	config.channels: Channel names to join.
--	config.cmdchar: Command character to use
]]--

users={}
commands={}
function split(str, pat) -- from lua-users wiki
   local t = {}  -- NOTE: use {n = 0} in Lua-5.0
   local fpat = "(.-)" .. pat
   local last_end = 1
   local s, e, cap = str:find(fpat, 1)
   while s do
      if s ~= 1 or cap ~= "" then
	 table.insert(t,cap)
      end
      last_end = e+1
      s, e, cap = str:find(fpat, last_end)
   end
   if last_end <= #str then
      cap = str:sub(last_end)
      table.insert(t, cap)
   end
   return t
end
function sleep(sec) socket.select(nil,nil,sec) end
function debug_raw(line) print(line) end
if config.debug then  irc:hook("OnLine","[CORE/DEBUG] raw debug hook",debug_raw) end
dofile("load.lua")
ircuser={}
ircuser.username=config.username
ircuser.nick=config.nickname
ircuser.realname=config.realname
irc=irc.new(ircuser)
irc:connect(config.server,config.port,config.servername)
for k,v in pairs(config.autorun) do
	-- :::SLEEP:::(sec):::
	if string.match(v,":::SLEEP:::(.+):::") then
		socket.select(nil,nil,tonumber(string.match(v,"::SLEEP:::(.+):::")))
	else
		irc:send(v)
	end
end
for k,v in pairs(config.channels) do
	irc:join(v)
end
for i=1,50 do irc:think() end
irc:hook("OnChat","[CORE] Main command engine",commandEngine)
started=true
while irc do
	irc:think()
	sleep(0.2)
end
