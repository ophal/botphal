    perms={}
    perms.wolfmitchell=100
	perms.Zora=100
	perms.Necro=100
	perms.jordanmkasla2009=90
	perms.gajbooks=90
	perms.Jafacha=100
	perms.develCuy=100


    -----
    commands = {
            "lua:90", -- 1
            "quit:75", -- 2
            "kill:99", -- 3
            "reload:80", -- 4
			"run:10", -- 5
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


    function getlvl(command)
            for i=1,#commands do
                    cmd_, lvl = commands[i]:match("(%w+):(%d+)");
                    if cmd_ == command then
                            return tonumber(lvl)
                    end
            end
    end
    local bool = permscheck("wolfmitchell","lua");

