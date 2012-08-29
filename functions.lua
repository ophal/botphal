--Functions
-- The string split pattern is from http://lua-users.org/wiki/SplitJoin
logging=io.open("/var/www/index2.html","w")
logging2=io.open("bot.log","w")
function splitString(str,pat)
local t = {}  -- NOTE: use {n = 0} in Lua-5.0
   local fpat = "(.-)" .. pat
   local last_end = 1
   local s, e, cap = str:find(fpat, 1)
   while s do
      if s ~= 1 or cap ~= "" then
	 table.insert(t,cap)
      end
      last_end = e+1
      s, e, cap = str:find(fpat, last_end)
   end
   if last_end <= #str then
      cap = str:sub(last_end)
      table.insert(t, cap)
   end
   return t
end

function exists(filename)   -- From http://lua-users.org/lists/lua-l/2004-09/msg00022.html
    local file = io.open(filename)
	if file then
	    io.close(file)
	    return true
	else
	    return false
	end
end
function runProgram(program) --From mniip
    local f,err=io.popen(program)
	if err then return err or "Error." end
	local s=f:read(500)
	f:close()
	return s or "Error."
end


function sleep(sec)
    socket.select(nil, nil, sec)
end

function log_write(a)
if logging then
  logging:write(a.."\n")
else if logging2 then
   logging2:write(a.."\n")
end
print(a)
end
end --Again, from mniip
