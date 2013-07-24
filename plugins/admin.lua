function reload(usr,chan,nick,args)
	dofile"load.lua"
	if chan:sub(1,1)=="#" then target="chan" else target="usr" end
	return target,string.format("%s, done!",usr.nick)
end
addcommand("reload",reload)
