commands={}
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
	print(string.format("[MESSAGE]\t[%s][%s]<%s> %s",os.date(),chan,usr.nick,msg))
	called=false
	if msg:sub(1,#config.cmdchar)==config.cmdchar then
		pre,cmd,rest = msg:match("^("..config.cmdchar..")([^%s]+)%s?(.*)$") -- thanks to cracker64
		args=split(rest," ")
		print(string.format("[COMMAND]\t[%s][%s][%s]",usr.nick,cmd,rest))
		if commands[cmd] then
			if users[usr.host].perms[commands[cmd].level]==true or users[usr.host].perms["owner"]==true then
				status,target,send=pcall(commands[cmd].func,usr,chan,msg,args)
				if not status then 
					print(string.format("[ERROR]\t%s",split(target,"\n")[1]))
					if chan:sub(1,1)=="#" then irc:sendChat(chan,split(target,"\n")[1]) else irc:sendChat(usr.nick,split(target,"\n")[1]) end
				else
					if target=="usr" then irc:sendChat(usr.nick,send) elseif target=="chan" then irc:sendChat(chan,send) end
				end
			else
				irc:sendChat(chan,string.format("%s, you do not have the required permissions for the command %q. You need the %q capability to use this.",usr.nick,cmd,commands[cmd].level))
			end
		else
				irc:sendChat(chan,string.format("%s, the command %q does not exist.",usr.nick,cmd))
		end
	end
end
