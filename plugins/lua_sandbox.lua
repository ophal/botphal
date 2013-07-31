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
	coroutine={
		create=coroutine.create,
		resume=coroutine.resume,
		running=coroutine.running,
		status=coroutine.running,
		wrap=coroutine.wrap,
		yield=coroutine.yield
	},
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
	table={
		insert=table.insert,
		maxn=table.maxn,
		remove=table.remove,
		sort=table.sort
	},
	math={
		abs=math.abs,
		acos=math.acos,
		asin=math.asin,
		atan=math.atan,
		atan2=math.atan2,
		ceil=math.ceil,
		cos=math.cos,
		cosh=math.cosh,
		deg=math.deg,
		exp=math.exp,
		floor=math.floor,
		fmod=math.fmod,
		frexp=math.frexp,
		huge=math.huge,
		ldexp=math.ldexp,
		log=math.log,
		log10=math.log10,
		max=math.max,
		min=math.min,
		modf=math.modf,
		pi=math.pi,
		pow=math.pow,
		rad=math.rad,	
		random=math.random,
		randomseed=math.randomseed,
		sin=math.sin,
		sinh=math.sinh,
		sqrt=math.sqrt,
		tan=math.tan,
		tanh=math.tanh
	},
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
	debug.sethook(infhook,"",10001)
	local asdf,ret=pcall(f)
	debug.sethook()
	if not ret then return "No data." else return ret end
end
function sandboxcmd(usr,chan,msg,args)
	if chan:sub(1,1)=="#" then target="chan" else target="usr" end
	return target,usr.nick..": "..tostring(sandbox(table.concat(args," "))):gsub("\n","\\n"):gsub("\r","\\r")
end
addcommand("lua",sandboxcmd)
