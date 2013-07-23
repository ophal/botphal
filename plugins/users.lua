-- plugin/users.lua
function register(usr,chan,msg,args)
	if chan:sub(1,1)=="#" then return "chan",string.format("%s: Are you kidding me? You just sent your password (or were about to send it) in a channel! Try again in PM.",usr.nick) end
	if not args[3] then
		return "usr",string.format("%s: Arguments for command 'register': %s <username> <password>",usr.nick,args[1])
	else
		userdbfile=io.open("users.json","r")
		userdb=json:decode(userdbfile:read'*a')
		userdb[args[2]]={}
		userdb[args[2]].password,userdb[args[2]].salt=hash(args[3])
		userdb[args[2]].perms={}
		userdb[args[2]].perms[""]=true
		userdbjson=json:encode(userdb)
		userdbfile=io.open("users.json","w")
		userdbfile:write(userdbjson)
		userdbfile:close()
		return "usr","Done!"
	end
end
function login(usr,chan,msg,args)
	if not chan==usr.nick then return "chan",string.format("%s: Are you kidding me? You just sent your password in a channel! Try again in PM.") end
	if not args[3] then
		return "chan",string.format("%s: Arguments for command 'login': %s <username> <password>",usr.nick,args[1])
	else
		userdbfile=io.open("users.json","r")
		userdb=json:decode(userdbfile:read'*a')
		if not userdb[args[2]] then return "usr",string.format("%s: The account %q does not exist!",usr.nick,args[2]) end
		hashpwd=hashnosalt(args[3]..userdb[args[2].salt])
		if hashpwd==userdb[args[2]].password then
			users[usr.host]=userdb[args[2]]
			return "usr",string.format("%s: Login success!",usr.nick)
		else
			return "usr","%s: Wrong password for the account %q!"
		end
	end
end
addcommand("login",login)
addcommand("register",register)
addcommand("crash",function() error"hi" end)
