help = {
    "say:Makes the bot say something.:+say <text>:0",
    "quit:Makes the bot quit.:+quit:75",
    "lua:Runs lua code.:+lua <code>:90",
    "run:Lua sandbox. Return not returning yet.:+run <code>:10",
    "kill:Kills a person on the server. Only works on irc.mini-irc.uni.me:+kill <user> <reason>:99",
    "reload:Reloads a file:+reload <file, no .lua extension>:80",
    "help:Shows the bot's help.:+help <command>:0",
    "php:Runs PHP code.:+php <code>:90"
}
function getCompleteTable()
    help2 = help
    return help2
end
function getHelpTable(topic)
    help2 = help
    for i=1,#help2 do
        data=splitString(help2[i],":")
	if data[1] == topic then
             return data
        end
    end
end
