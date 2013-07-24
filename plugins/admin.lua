function reload(usr,chan,msg,args)
	dofile"load.lua"
	if chan:sub(1,1)=="#" then target="chan" else target="usr" end
	return target,string.format("%s, done!",usr.nick)
end
function lua(usr,chan,msg,args)
	if chan:sub(1,1)=="#" then target="chan" else target="usr" end
	local code=table.concat(args," ")
	local func,err=loadstring(code)
	if err then return target,usr.nick..": "..err end
	local asdf,ret=pcall(func) asdf=nil
	ret = tostring(ret) or "No output"
	return target,usr.nick..": "..ret
end
function shutdown(usr,chan,msg,args)
	irc:send("QUIT :My owner told me to quit!")
end
addcommand("shutdown",shutdown,"owner")
addcommand("lua",config.cmdchar,"trusted")
addcommand("reload",reload)
