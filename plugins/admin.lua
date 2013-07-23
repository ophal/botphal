function reload(usr,chan,nick,args)
	dofile"load.lua"
	return "chan",string.format("%s, done!",usr.nick)
end
addcommand("reload",reload)
