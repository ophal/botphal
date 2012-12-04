--
dofile("help.lua")
dofile("ignore.lua")
dofile("identify.lua") --Erase if you don't want the bot to identify.
if factoids then facts = config.factoids.db end
function chat(usr,channel,msg)
   --if checkIgnore(usr.nick) == nil then
   --if msg:sub(1,1)=="+" then --Thank mniip from IRC for telling me about this :D
    if msg:sub(1,1)=="+" then
	if checkIgnore(usr.nick) == nil then
        if msg:sub(1,4) == "+say" then
		    announcement = splitString(msg," ")
			textannounce = ""
            for i=2, #announcement do
		        textannounce=textannounce .. " " .. announcement[i]
            end
            textannounce1="["..usr.nick.."] "..textannounce
		    irc:sendChat(channel,textannounce1)
			--irc:sendChat(channel,"Now to kick Zora.")
            --irc:send("KICK #irc4cpu zora@*")
		elseif msg:sub(1,5) == "+quit" then
		    run=permscheck(usr.nick,"quit")
			if run == true then
				irc:send("QUIT :Ordered by [".. usr.nick .."]")
            elseif not run then
                irc:sendChat(channel,"You do not have the required permissions!")
            end
--[[	    elseif msg:sub(1,5) == "+kill" then
		    killparams=splitString(msg," ")
            run=permscheck(usr.nick,"kill")
            if run == true then
                irc:send("KILL "..killparams[2].." " ..killparams[3] )
            elseif not run then
				irc:sendChat(channel,"You do not have the required permissions!")
            end]]
		elseif msg:sub(1,4) == "+lua" then
			codea = splitString(msg," ")
            codeb = ""
			if codea[2] == nil then
			    irc:sendChat(channel,"["..usr.nick.."] Runs lua code. Requires user level 90.")
			else
  			    for i=2, #codea do
                    codeb=codeb .. " " .. codea[i]
	  		    end
		            exec,err = loadstring(codeb)
    		        run = permscheck(usr.nick,"lua")
	    		if run==true then
                    returned="["..usr.nick.."] "
			            if not exec then
                            returned=returned..err
                        else
                            s,r=pcall(exec)
                            if r==nil then
		    					returned=returned.."[Nothing returned!]"
                            elseif not type(r)== "string" then
							    returned=returned.."[Script returned a "..type(r).."]"
							else
						    if r then
							returned=returned..r
							else
							returned=returned.."[Nothing returned!]"
					    	end
							end
                        end
                    irc:sendChat(channel,returned)
                elseif not run then
		    		irc:sendChat(channel,"You do not have the required permissions!")
			    end
		    end
    		elseif msg:sub(1,4) == "+run" then
                codea = splitString(msg," ")
                codeb = ""
                for i=2, #codea do
                    codeb=codeb .. " " .. codea[i]
                end
                run = permscheck(usr.nick,"run")
				if run==true then
				    returned="["..usr.nick.."] "
					if exec then
						s=sandbox_do(exec)
						if e == nil then
					        if s==nil then
						        returned=returned.."[Nothing returned!]"
						    elseif type(s)=="string" then
						        returned=returned..s
							else
							    returned=returned.."Your code returned a "..type(s)
							end
						end
					end
                irc:sendChat(channel,returned)
            elseif not run then
                irc:sendChat(channel,"You do not have the required permissions!")
            end
		elseif msg:sub(1,7) == "+reload" then
		    data=splitString(msg," ")
			if data[2] == nil then
			    irc:sendChat(channel,"["..usr.nick.."] Reloads a part of the bot. Requires permission level 80. Syntax: +reload <file>")
			else
			    run = permscheck(usr.nick,"reload")
				if run == true then
				    fileExists=exists(data[2]..".lua")
					if fileExists == true then
					    dofile(data[2]..".lua")
						irc:sendChat(channel,"["..usr.nick.."] The file "..data[2]..".lua has been reloaded.")
					else
					    irc:sendChat(channel,"["..usr.nick.."] That file does not exist!")
					end
			    else
				    irc:sendChat(channel,"You do not have the required permissions!")
				end
			end
		elseif msg:sub(1,5) == "+help" then
		    params=splitString(msg," ")
			if params[2] == nil then
			    irc:sendChat(channel,"["..usr.nick.."] Usage: +help <command>. Use +list for a command list.")
			else
			    help=getHelpTable(params[2])
		        if help == nil then
				    irc:sendChat(channel,"["..usr.nick.."] Sorry, that is not a valid command.")
				else
					irc:sendChat(channel,"["..usr.nick.."] "..help[1]..": "..help[2].."|| Syntax: "..help[3].."|| Requires user level "..help[4]..".")
				end
			end
	    elseif msg:sub(1,5) == "+list" then
		    status=true
			while status do
			    helpTable=getCompleteTable()
				if helpTable ~=nil then
				    status = false
				end
			end
			list=""
			for i=1,#helpTable do
				    data=splitString(helpTable[i],":")
					list = list .. " " .. data[1]
			end
			irc:sendChat(channel,"["..usr.nick.."] "..list)
		elseif msg:sub(1,4) == "+php" then
			    params=splitString(msg," ")
				if params[2] == nil then
				    irc:sendChat(channel,"["..usr.nick.."] Runs PHP code. Requires permsission level 90.")
				else
				    run=permscheck(usr.nick,"php")
					if run ~= true then
					    irc:sendChat(channel,"You do not have the required permissions!")
					else
					    params2=""
						for i=2,#params do
						    params2=params2..params[i]
						end
						returned=runProgram("php -r "..params2)
						for i=1,#returned do
						    irc:send("NOTICE "..usr.nick.." :"..returned[i].."")
						end
					end
				end
		elseif msg:sub(1,4) == "+api" then
		    irc:sendChat(channel,"API is currently not implemented. Sorry D:")
			irc:sendChat(channel,"Planned commands for +api are addroster, remroster, genkey, rmkey, docs, listroster, getaddr, status")
			irc:sendChat(channel,"The API is going to be XMPP based and the server SHOULD be running on the same machine as the bot.")
			irc:sendChat(channel,"The bot should also be in the user mitchbotapi@[server address] by default.")
			irc:sendChat(channel,"API Progress: 0%")
		else
            irc:sendChat(channel,"Sorry, that is not a valid command.")
        end
    end
	end
	if factoids then
	if msg:sub(1,1) == "&" then
	    for k,v in pairs(facts) do
		    if msg:sub(2,#msg) == k then
                sendText = v
			end
		end
		if not sendText then
		    irc:send("NOTICE "..usr.nick.." :Unknown fact.")
		else
		    irc:sendChat(channel,sendText)
		end
	end
	end
    log_write("["..channel.."] <"..usr.nick.."> "..msg)
end
function ctcp(usr, chan, msg)
  local response, command, ts
  local ctcpresponses = {
    VERSION = "MitchBot v0.20",
    CREDITS = "Started development by wolfmitchell (on freenode IRC), develCuy and mniip helped with alot of it also :D (Thank develCuy for helping with ctcp :D)",
    OWNER = "wolfmitchell", --Change depending on who the owner of the bot is :P
    FINGER = "He thought his life was going to take a turn for the better, but I knew the only turns one makes in life are the ones that take you the wrong way down a one-way street to nowhere, where U-turns aren't permitted before 8PM except for city buses.",
    TIME = os.date([[%a %b %d %H:%M:%S %Y]], os.time()),
    PING = nil, -- gets calculated below
    CLIENTINFO = [[VERSION CREDITS OWNER FINGER TIME PING CLIENTINFO]],
  }

  if msg:byte(1,1) == 1 or msg:sub(1,1) == string.char(0x01) then
    if msg:byte(#msg, #msg) == 1 or msg:sub(#msg, #msg) == string.char(0x01) then
      command = msg:sub(2, #msg - 1)
      if ctcpresponses[command] then
        response = ":\1".. command .. " " .. ctcpresponses[command] .. "\1"
      elseif command:sub(1, 4) == [[PING]] then
        response = ":\1PING " .. command:sub(6, #command) .."\1"
  --      response = ":\1PING " .. os.time() .."\1"
      end
      if response then
        irc:send("NOTICE " .. usr.nick .. " " .. response)
      end
    end
  end
end
