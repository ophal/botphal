config = {}
-- MitchIRC bot written by Mitchell Monahan
-- You may want to uncomment the stuff. And edit it. That may be good also.
--[[
  * config.serverPort
  * This is the port that is used to connect to the remote IRC server. Usually 6667. This bot does not yet support SSL.
  * ]]--
--config.serverPort = 6667



--[[
  * config.server
  * This is the remote IRC server's address, like irc.freenode.net
  * ]]--
--config.server = "localhost"


--[[
  * config.autorun
  * An array (in lua terms, table) containing strings of text to send to the IRC server when the bot connects.
  * You can identify to NS here.
  * ]]--
--config.autorun = {
--    "PRIVMSG NickServ :IDENTIFY TheBotPassword",
--    "PRIVMSG BotOwner :I'm connected!"
--}


--[[
  * config.channels
  * A table containing strings of text containing the names of channels to autojoin.
  * ]]--
--config.channels = {
--    "#channel1",
--    "#channel2",
--    "#channel3"
--}


--[[
  * config.enabledCommands  (Planned, but not implemented yet. All commands are currently available, depending on the perms.)
  * A table of commands to enable on the IRC bot.
  * Possible commands:
  * lua say quit run reload help list php api
  * ]]--
-- config.enabledCommands = {
--     "lua",
--     "say",
--     "quit",
--     "run",
--     "reload",
--     "help",
--     "php",
--     "api"
-- }


--[[
  * config.nick
  * The nick the bot uses.
  * ]]--
-- config.nick = "MitchBot"


--[[
  * config.username
  * The username the bot uses.
  * The username is the part before the '@' in a hostname. In blar@blar.blar.com, blar is the username.
  * ]]--
-- config.username = "MitchBot"


--[[
  * config.realname
  * The realname the bot uses. This usually shows up in whois. This can have spaces, usually.
  * ]]--
-- config.realname = "MitchBot"

--[[
  * config.factoids
  * The factoids configuration block.
  * ]]--
-- config.factoids = {
    --[[
	  * config.factoids.enabled
	  * Enables or disables factoids.
	  * ]]--
    -- enabled = true,


    --[[
      * config.factoids.db
	  * A table of factoids the bot can use.
	  * ]]--
	-- db = {
	   -- factoid1 = "This is a sample factoid.",
	   -- factoid2 = "This is another sample factoid."
	-- }
-- }

--[[
  * config.modules
  * A table for modules in the modules/ folder. Put your module in a folder, with the script to run being 'init.lua'. Modules are ran in order of the table after we load commands.lua.
  * ]]--
-- config.modules = {
    -- "example"
-- }

--[[
  * Remove the config.die :3 (it's value does not matter ;)
  * ]]--
config.die = "asdf"
