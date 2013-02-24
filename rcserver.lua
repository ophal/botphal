function rcserver()
   serverActive = true
   while serverActive do
   rcsocket=require "socket"
   rcserver2=rcsocket.bind("*",65534)

        coroutine.yield()
        rcserver2:settimeout(1)
		rcclient=rcserver2:accept()
		rcclient:settimeout(1)
		if rcclient then
		    coroutine.yield()
	        remoteip=rcclient:getpeername()
	        if(remoteip == "94.249.210.90" or remoteip == "127.0.0.1") then
			    rcclient:send("IPAUTH OK\n")
    			data=rcclient:receive()
    			exec,err=loadstring(data)
	        	if err then
	        	    rcclient:send(err)
                elseif not exec then
	        	    rcclient:send("Unexpected error.\n")
		        else
		        	returned=""
			        s,r=pcall(exec)
			        if r==nil then
			        	returned=returned.."RETURNED NIL\n"
        			elseif not type(r)== "string" then
		        		returned=returned.."RETURNED VARTYPE "..type(r).."\n"
        			else
		        		returned=returned..r.."\n"
			        end
        		    rcclient:send(returned)
		        end
        		coroutine.yield()
			else
			    rcclient:send("Invalid address for remote control of the bot. Your IP: "..remoteip..". \n")
				for i=1,100 do
				    coroutine.yield()
					sleep(1)
				end
				rcclient:close()
			end
    	end
    end
	rcserver2=nil
	rcclient=nil
	rcsocket=nil
end
