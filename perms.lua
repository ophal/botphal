    perms={}
    perms.wolfmitchell=100
	perms.Zora=100
	perms.Necro=100
	perms.jordanmkasla2009=90
	perms.gajbooks=90
	perms.Jafacha=100
	perms.develCuy=100


    -----
    local commands = {
            "lua:90", -- 1
            "quit:75", -- 2
            "kill:99", -- 3
            "reload:80", -- 4
			"run:0", -- 5
			"php:90" -- 6
    }


    function permscheck(nick,cmd)
            lvl2=getlvl(cmd)
			if(perms[nick]) then
                log_write("[Command] "..nick.." "..lvl2.." "..perms[nick].." "..cmd)
                return (perms[nick] or 0) >= lvl2
			else
			    return false
			end
			--if(perms[nick] == lvl2) then return true else return false end
    end
    --[[
    function permscheck2(nick,cmd)
    	for i=1,#commands do
		    splitinfo=splitString(commands[i],":")
			if splitinfo[2]==perms[nick] then
				state=true
			elseif splitinfo == nil then
				state=true
			elseif splitinfo[2]==0 then
			    state=true
			end
		end
		state=state or false
	    return state
	end]]

	function permscheck2(nick,cmd)
    for i=1,#commands do
        local splitinfo=splitString(commands[i],":")
        if not splitinfo or splitinfo[2]==perms[nick] or splitinfo[2] == 0 then
	    return true
	end
    end
    return false
end

    function getlvl(command)
            for i=1,#commands do
                    cmd_, lvl = commands[i]:match("(%w+):(%d+)");
                    if cmd_ == command then
                            return tonumber(lvl)
                    end
            end
    end
    --local bool = permscheck("wolfmitchell","lua");

