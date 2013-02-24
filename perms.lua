perms={}
perms["botters/wolfmitchell"]=100
perms["178.219.36.155"]=100

permscommands = {
    "lua:90", -- 1
    "quit:75", -- 2
    "kill:99", -- 3
    "reload:80", -- 4
    "run:0", -- 5
    "php:90" -- 6
}

function permscheck(host,cmd)
    lvl2=getlvl(cmd)
    if perms[host] then
        if perms[host]>= lvl2 then
            return true
        else
            return false
        end
    else
        return false
    end
end
function getlvl(command)
    for i=1,#permscommands do
        cmd_, lvl = permscommands[i]:match("(%w+):(%d+)");
        if cmd_ == command then
            return tonumber(lvl)
        end
    end
end
