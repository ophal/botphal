env = {
	assert=assert,
	error=error,
	ipairs=ipairs,
	next=next,
	pairs=pairs,
	pcall=pcall,
	select=select,
	tonumber=tonumber,
	tostring=tostring,
	type=type,
	unpack=unpack,
	_VERSION=_VERSION,
	xpcall=xpcall,
	coroutine=coroutine,
	string={
		byte=string.byte,
		char=string.char,
		find=string.find,
		format=string.format,
		gmatch=string.gmatch,
		gsub=string.gsub,
		len=string.len,
		reverse=string.reverse,
		sub=string.sub,
		upper=string.upper,
	},
	table=table,
	math=math,
	io={
		type=type,
	},
	os={
		clock=clock,
		time=time,
		date=date,
	}
}
env["_G"]=env
steps=0
function infhook() -- Based off cracker64's debug hook for catching infinite loops.
	debug.sethook()
	error"Fuck, infinite loops."
end
local sandboxRunning=false
function sandbox(code)
	if code:sub(1,1)=="\27" then return "no bytecode for you." end
	local f,err=loadstring(code)
	if err then return err end
	setfenv(f,env)
	debug.sethook(infhook,"",100001)
	local asdf,ret=pcall(f)
	if not ret then return "No data." else return ret end
end
function sandboxcmd(usr,chan,msg,args)
	if chan:sub(1,1)=="#" then target="chan" else target="usr" end
	return target,sandbox(table.concat(args," "))
end
addcommand("lua",sandboxcmd)
