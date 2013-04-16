-- plugin/users.lua
function register(usr,chan,msg,args)
	if not chan==usr.nick then return string.format("%s: Are you kidding me? You just sent your password in a channel! Try again in PM.") end
	if not args[3] then
		return string.format("%s: Arguments for command 'register': %s <username> <password>",usr.nick,args[1])
	else
		userdbfile=io.open("users.json","rw")
		userdb=json:decode(userdbfile:read'*a')
		userdb[args[2]]={}
		userdb[args[2]].password,userdb[args[2]].salt=hash(args[3])
		userdb[args[2]].perms={}
		userdb[args[2]].perms[""]=true
		userdbjson=json:encode(userdb)
		userdbfile:write(userdbjson)
		userdbfile:close()
		return "Done!"
	end
end
function login(usr,chan,msg,args)
	if not chan==usr.nick then return string.format("%s: Are you kidding me? You just sent your password in a channel! Try again in PM.") end
	if not args[3] then
		return string.format("%s: Arguments for command 'login': %s <username> <password>",usr.nick,args[1])
	else
		userdbfile=io.open("users.json","r")
		userdb=json:decode(userdbfile:read'*a')
		if not userdb[args[2]] then return string.format("%s: The account %q does not exist!",usr.nick,args[2]) end
		hashpwd=hashnosalt(args[3]..userdb[args[2].salt])
		if hashpwd==userdb[args[2]].password then
			users[usr.host]=userdb[args[2]]
			return string.format("%s: Login success!",usr.nick)
		else
			return "%s: Wrong password for the account %q!"
		end
	end
end
addcommand("login",login)
addcommand("register",register)
