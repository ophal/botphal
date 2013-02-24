-- make environment
local coroutine={create=coroutine.create,resume=coroutine.resume,running=coroutine.running,status=coroutine.status,wrap=coroutine.wrap,yeild=coroutine.yield}
local string={byte=string.byte,char=string.char,find=string.find,format=string.format,gmatch=string.gmatch,gsub=string.gsub,len=string.len,lower=string.lower,match=string.match,rep=string.rep,reverse=string.reverse,sub=string.sub,upper=string.upper}
local table={insert=table.insert,maxn=table.maxn,remove=table.remove,sort=table.sort}
local math={abs=math.abs,acos=math.acos,sin=math.sin,atan=math.atan,atan2=math.atan2,ceil=math.ceil,cos=math.cos,cosh=math.cosh,deg=math.deg,exp=math.exp,floor=math.floor,fmod=math.fmod,frexp=math.frexp,huge=math.huge,ldexp=math.ldexp,log=math.log,log10=math.log10,max=math.max,min=math.min,modf=math.modf,pi=math.pi,pow=math.pow,rad=math.rad,random=math.random,sin=math.sin,sinh=math.sinh,sqrt=math.sqrt,tan=math.tan,tanh=math.tanh}
local io={type=io.type}
local os={clock=os.clock,difftime=os.difftime,time=os.time}
local env = {coroutine=coroutine,string=string,table=table,math=math,io=io,os=os,assert=assert,error=error,ipairs=ipairs,next=next,pairs=pairs,pcall=pcall,select=select,tonumber=tonumber,tostring=tostring,type=type,unpack=unpack,_VERSION=_VERSION,xpcall=xpcall} -- add functions you know are safe here.

-- run code under environment [Lua 5.1]
function sandbox_do(code)
    exec=loadstring(code)
    if exec then
        setfenv(exec,env)
        status,returned = pcall(exec)
        return returned
    end
end
