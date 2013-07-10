require"irc.init"

config={}
dofile("config.lua")
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
function explode(div,str) -- from: http://richard.warburton.it
	if (div=='') then return false end
	local pos,arr = 0,{}
	for st,sp in function() return string.find(str,div,pos,true) end do
		table.insert(arr,string.sub(str,pos,st-1))
		pos = sp + 1
	end
	table.insert(arr,string.sub(str,pos))
	return arr
end
users={}
function addcommand(commandName,commandFunc,commandPerms)
	if not commandPerms then commandPerms="" end
	if not commandName then error "Command name not given!" end
	if not commandFunc then error "Command function not given!" end
	commands[commandName]={}
	commands[commandName].func=commandFunc
	commands[commandName].level=commandPerms
end
function commandEngine(usr,chan,msg)
	if not users[usr.host] then users[usr.host]={} users[usr.host].identified=false users[usr.host].perms={} users[usr.host].perms[""]=true end
	print(string.format("[MESSAGE]\t[%s][%s]<%s> %s",os.date"%m/%d/%x %X",chan,usr.nickmsg))
	if chan==config.nickname then chan=usr.nick end
	args=explode(msg," ")
	called=false
	for k,v in pairs(commands) do
		if msg:sub(1,#config.cmdchar..k)==config.cmdchar..k then
			if users[usr.host].perms[v.level]==true or users[usr.host].perms["owner"]==true then
				send=v.func(usr,chan,msg,args)
				irc:sendChat(chan,send)
			else
				irc:sendChat(chan,string.format("%s, you do not have permissions for the command %q. You need the %q capability to use this.",usr.nick,k,v.level))
			end
			print(string.format("[COMMAND]\t[%s][%s][%s]",usr.nick,k,table.concat(args," ",2)))
			called=true
		end
	end
	if called==false then
		irc:sendChat(chan,string.format("%s, the command %q does not exist.",usr.nick,args[1]))
	end
end
function sleep(sec) socket.select(nil,nil,sec) end
function debug_raw(line) print(line) end
if config.debug then  irc:hook("OnLine","[CORE/DEBUG] raw debug hook",debug_raw) end

ircuser={}
ircuser.username=config.username
ircuser.nick=config.nickname
ircuser.realname=config.realname
irc=irc.new(ircuser)
irc:connect(config.servername,config.port,config.server)
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
while irc do
	irc:think()
	sleep(0.2)
end

