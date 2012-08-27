--Functions
-- The string split pattern is from http://lua-users.org/wiki/SplitJoin
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

function runProgram(program)
    file=io.popen(program)
	i=1
	repeat
	    local x=file:read()
		data[i]=x
	until not x
	file:close()
	return data
end


function sleep(sec)
    socket.select(nil, nil, sec)
end
