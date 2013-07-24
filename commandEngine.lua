commands={}
function checkPerms(cmdperms,usrhost)
	for k,v in pairs(cmdperms) do
		if users[usrhost].perms[k]==true then
			return true
		end
	end
	if users[usrhost].perms.owner or cmdperms[1]=="" or not cmdperms[1] then
		return true
	end
	return false
end
function addcommand(commandName,commandFunc,commandPerms)
	if not commandPerms then commandPerms={""} end
	if not commandName then error "Command name not given!" end
	if not commandFunc then error "Command function not given!" end
	commands[commandName]={}
	commands[commandName].func=commandFunc
	commands[commandName].level=commandPerms
end
function commandEngine(usr,chan,msg)
	if chan:sub(1,1)=="#" then target=chan else target=usr.nick end
	if not users[usr.host] then 
		users[usr.host]={ 
			identified=false,
			perms={}
		} 
		users[usr.host].perms[""]=true
	end
	print(string.format("[MESSAGE]\t[%s][%s]<%s> %s",os.date(),chan,usr.nick,msg))
	called=false
	if msg:sub(1,#config.cmdchar)==config.cmdchar and (users[usr.host].ignore==false or users[usr.host].ignore==nil) then
		pre,cmd,rest = msg:match("^("..config.cmdchar..")([^%s]+)%s?(.*)$") -- thanks to cracker64
		if not cmd then return end
		args=split(rest," ")
		print(string.format("[COMMAND]\t[%s][%s][%s]",usr.nick,cmd,rest))
		if commands[cmd] then
			if checkPerms(commands[cmd].level,usr.host) then
				status,target,send=pcall(commands[cmd].func,usr,chan,msg,args)
				if not status then 
					print(string.format("[ERROR]\t\t%s",split(target,"\n")[1]))
					if chan:sub(1,1)=="#" then irc:sendChat(chan,split(target,"\n")[1]) else irc:sendChat(usr.nick,split(target,"\n")[1]) end
				else
					if target=="usr" then irc:sendChat(usr.nick,send) elseif target=="chan" then irc:sendChat(chan,send) end
				end
			else
				irc:sendChat(target,string.format("%s, you do not have the required permissions for the command %q. You need one of the following capabilities to use this: %s",usr.nick,cmd,table.concat(commands[cmd].level," ")))
			end
		--[[else
				irc:sendChat(target,string.format("%s, the command %q does not exist.",usr.nick,cmd))]]
		end
	end
end
