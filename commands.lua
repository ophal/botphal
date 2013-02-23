dofile("help.lua")
dofile("ignore.lua")
dofile("perms.lua")

----------------------------------------------------------------------------
function factoids(usr,channel,msg)
    if config.factoids.enabled == true then
        if msg:sub(1,1) == "&" then
            for k,v in pairs(config.factoids.db) do
                if msg:sub(2,#msg) == k then
                    sendText = v
                end
            end
            if not sendText then
                irc:send("NOTICE "..usr.nick.." :Unknown fact.")
            else
                if channel:sub(1,1)=="#" then irc:sendChat(channel,sendText) else irc:sendChat(usr.nick,sendText) end
            end
        end
    end
end


----------------------------------------------------------------------------
function say(usr,channel,msg)
    announcement = splitString(msg," ")
    textannounce = ""
    textannounce=table.concat(announcement," ",2)
    textannounce1=textannounce
    if channel:sub(1,1)=="#" then irc:sendChat(channel,textannounce1) else irc:sendChat(usr.nick,textannounce1) end
end
table.insert(permscommands,"op:70")
table.insert(permscommands,"deop:70")
table.insert(permscommands,"voice:50")
table.insert(permscommands,"devoice:50")
function op(user,channel,msg)
    if permscheck(user.host,"op") then
        if msg:sub(5,#msg) == nil or msg:sub(5,#msg) == "" then
            irc:send("MODE "..channel.." +o "..user.nick)
        else
            irc:send("MODE "..channel.." +o "..msg:sub(5,#msg))
        end
        if channel:sub(1,1)=="#" then irc:sendChat(channel,"Done.") else irc:sendChat(user.nick,"Done.") end
    else
        if channel:sub(1,1)=="#" then irc:sendChat(channel,"You do not have the required permissions.") else irc:sendChat(user.nick,"You do not have the required permissions.") end
    end
end
function deop(user,channel,msg)
    if permscheck(usr.host,"deop") then
        if msg:sub(5,#msg) == nil or msg:sub(5,#msg) == "" then
            irc:send("MODE "..channel.." -o "..usr.nick)
        else
            irc:send("MODE "..channel.." -o "..msg:sub(5,#msg))
        end
        if channel:sub(1,1)=="#" then irc:sendChat(channel,"Done.") else irc:sendChat(usr.nick,"Done.") end
    else
        if channel:sub(1,1)=="#" then irc:sendChat(channel,"You do not have the required permissions.") else irc:sendChat(usr.nick,"You do not have the required permissions.") end
    end
end
function voice(user,channel,msg)
    if permscheck(usr.host,"voice") then
        if msg:sub(5,#msg) == nil or msg:sub(5,#msg) == "" then
            irc:send("MODE "..channel.." +v "..usr.nick)
        else
            irc:send("MODE "..channel.." +v "..msg:sub(5,#msg))
        end
        if channel:sub(1,1)=="#" then irc:sendChat(channel,"Done.") else irc:sendChat(usr.nick,"Done.") end
    else
        if channel:sub(1,1)=="#" then irc:sendChat(channel,"You do not have the required permissions.") else irc:sendChat(usr.nick,"You do not have the required permissions.") end
    end
end
function devoice(user,channel,msg)
    if permscheck(usr.host,"devoice") then
        if msg:sub(5,#msg) == nil or msg:sub(5,#msg) == "" then
            irc:send("MODE "..channel.." -v "..usr.nick)
        else
            irc:send("MODE "..channel.." -v "..msg:sub(5,#msg))
        end
        if channel:sub(1,1)=="#" then irc:sendChat(channel,"Done.") else irc:sendChat(usr.nick,"Done.") end
    else
        if channel:sub(1,1)=="#" then irc:sendChat(channel,"You do not have the required permissions.") else irc:sendChat(usr.nick,"You do not have the required permissions.") end
    end
end
function quit(usr,channel,msg)
    run=permscheck(usr.host,"quit")
    if run == true then
        irc:send("QUIT :Ordered by [".. usr.nick .."]")
    elseif not run then
        if channel:sub(1,1)=="#" then irc:sendChat(channel,"You do not have the required permissions!") else irc:sendChat(usr.nick,"You do not have the required permissions.") end
    end
end
function lua(usr,channel,msg)
    codea = splitString(msg," ")
    codeb = ""
    if codea[2] == nil then
        if channel:sub(1,1)=="#" then irc:sendChat(channel,"["..usr.nick.."] Runs lua code. Requires user level 90.") else irc:sendChat(usr.nick,"Runs lua code. Requires user level 90.") end
    else
          for i=2, #codea do
            codeb=codeb .. " " .. codea[i]
        end
            exec,err = loadstring(codeb)
        run = permscheck(usr.host,"lua")
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
                        r=string.gsub(r,"[\r\n]","|NEWLINE|")
                        returned=returned..r
                        r = nil
                        else
                            returned=returned.."[Nothing returned!]"
                           end
                    end
                end
                if channel:sub(1,1)=="#" then irc:sendChat(channel,returned) else irc:sendChat(usr.nick,returned) end
            elseif not run then
                if channel:sub(1,1)=="#" then irc:sendChat(channel,"You do not have the required permissions!") else irc:sendChat(usr.nick,"You do not have the required permission.") end
    end end
end
function run(usr,channel,msg)
    codea = splitString(msg," ")
    codeb = ""
    for i=2, #codea do
        codeb=codeb .. " " .. codea[i]
    end
    run = permscheck(usr.host,"run")
    if run==true then
        returned="["..usr.nick.."] "
        exec=string.match(exec,"+run (.*)")
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
        if channel:sub(1,1)=="#" then irc:sendChat(channel,returned) else irc:sendChat(usr.nick,returned) end
    elseif not run then
        if channel:sub(1,1)=="#" then irc:sendChat(channel,"You do not have the required permissions!") else irc:sendChat(usr.nick,"You do not have the required permissions!") end
    end
end
function reload(usr,channel,msg)
    data=splitString(msg," ")
    if data[2] == nil then
        if channel:sub(1,1)=="#" then irc:sendChat(channel,"["..usr.nick.."] Reloads a part of the bot. Requires permission level 80. Syntax: +reload <file>") else irc:sendChat(usr.nick,"Reloads a part of the bot. Requires permission level 80. Syntax: +reload <file>") end
    else
        run = permscheck(usr.host,"reload")
        if run == true then
            fileExists=exists(data[2]..".lua")
            if fileExists == true then
                dofile(data[2]..".lua")
                if channel:sub(1,1)=="#" then irc:sendChat(channel,"["..usr.nick.."] The file "..data[2]..".lua has been reloaded.") else irc:sendChat(usr.nick,"["..usr.nick.."] The file "..data[2]..".lua has been reloaded.") end
            else
                if channel:sub(1,1)=="#" then irc:sendChat(channel,"["..usr.nick.."] That file does not exist!") else irc:sendChat(usr.nick,"["..usr.nick.."] That file does not exist") end
            end
        else
            if channel:sub(1,1)=="#" then irc:sendChat(channel,"You do not have the required permissions!") else irc:sendChat("You do not have the required permissions.") end
        end
    end
end
function chelp(usr,channel,msg)
    params=splitString(msg," ")
    if params[2] == nil then
        if channel:sub(1,1)=="#" then irc:sendChat(channel,"["..usr.nick.."] Usage: +help <command>. Use +list for a command list.") else irc:sendChat(usr.nick,"["..usr.nick.."] Usage: +help <command>. Use +list for a command list.") end
    else
        helpl=getHelpTable(params[2])
        if helpl == nil then
            if channel:sub(1,1)=="#" then irc:sendChat(channel,"["..usr.nick.."] Sorry, no help documents were found on that command.") else irc:sendChat(usr.nick,"["..usr.nick.."] Sorry, no help documents were found on that command.") end
        else
            if channel:sub(1,1)=="#" then irc:sendChat(channel,"["..usr.nick.."] "..helpl[1]..": "..helpl[2].."|| Syntax: "..helpl[3].."|| Requires user level "..helpl[4]..".") else irc:sendChat(usr.nick,"["..usr.nick.."] "..helpl[1]..": "..helpl[2].."|| Syntax: "..helpl[3].."|| Requires user level "..helpl[4]..".") end
        end
    end
end
function list(usr,channel,msg)
    if msg:sub(7,#msg) == (nil or "") then
        if channel:sub(1,1)=="#" then irc:sendChat(channel,"["..usr.nick.."] To list commands in a module, do +list <modulename>.   Modules: ".. table.concat(registered_modules," ")) else irc:sendChat(usr.nick,"["..usr.nick.."] To list commands in a module, do +list <modulename> .".. table.concat(registered_modules," ")) end
    else
        local modulecmdlist = table.concat(module_commands[msg:sub(7,#msg)]," ")
        if channel:sub(1,1)=="#" then irc:sendChat(channel,"["..usr.nick.."] Commands in "..msg:sub(7,#msg)..": "..modulecmdlist) else irc:sendChat(usr.nick,"["..usr.nick.."] Commands in "..msg:sub(7,#msg)..": "..modulecmdlist)  end
    end
end
function php(usr,channel,msg)
    params=splitString(msg," ")
    if params[2] == nil then
        if channel:sub(1,1)=="#" then irc:sendChat(channel,"["..usr.nick.."] Runs PHP code. Requires permsission level 90.") else  irc:sendChat(usr.nick,"["..usr.nick.."] Runs PHP code. Requires permsission level 90.") end
    else
        run=permscheck(usr.host,"php")
        if run ~= true then
            if channel:sub(1,1)=="#" then irc:sendChat(channel,"You do not have the required permissions!") else irc:sendChat(usr.nick,"You do not have the required permissions!") end
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
end
function modlist(usr,channel,msg)
    modulelist=table.concat(registered_modules," ")
    if channel:sub(1,1)=="#" then irc:sendChat(channel,modulelist) else irc:sendChat(usr.nick,modulelist) end
end

enabled_commands = {}
function chat(usr,channel,msg)
    if msg:sub(1,1)=="+" and checkIgnore(usr.nick) == nil then
        message=splitString(msg," ")
        for k,v in pairs(enabled_commands) do
            if message[1] == k then v(usr,channel,msg) validcmd = true end
        end
        if validcmd == false or validcmd == nil then if channel:sub(1,1)=="#" then irc:sendChat(channel,"Sorry, that is not a valid command.") else irc:sendChat(usr.nick,"Sorry, that is not a valid command.") end end
        validcmd = nil
    end
    log_write("["..channel.."] {"..os.date().."} <"..usr.nick.."> "..msg)
end

function addbotcommand(cmd,callfunc,enabledByDefault)
    if enabledByDefault then
        enabled_commands[cmd]=callfunc
        print("[ADDCMD] "..cmd)
    else
        if not config.enabledCommands[cmd] == nil then enabled_commands[cmd]=callfunc print("[ADDCMD] "..cmd) end
    end
end
module_register("core")
add_module_command("core","+say",say)
add_module_command("core","+quit",quit)
add_module_command("core","+lua",lua)
add_module_command("core","+run",run)
add_module_command("core","+reload",reload)
add_module_command("core","+help",chelp)
add_module_command("core","+list",list)
add_module_command("core","+php",php)
add_module_command("core","+modlist",modlist)
add_module_command("core","+op",op)
add_module_command("core","+deop",deop)
add_module_command("core","+voice",voice)
add_module_command("core","+devoice",devoice)
function ctcp(usr, chan, msg)
    local response, command, ts
    local ctcpresponses = {
        VERSION = "MitchBot v0.50",
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
                -- response = ":\1PING " .. os.time() .."\1"
            end
            if response then
                irc:send("NOTICE " .. usr.nick .. " " .. response)
            end
        end
    end
end
