require 'rubygems'
require 'cinch'
require 'yaml'
require './helpers'

raise "create bot.yml and populate it with values. See the readme file!" unless File.exists?("bot.yml")

initialize_globals!
cinch_plugins = include_plugins($settings["settings"]['plugins'])

@irc = Cinch::Bot.new do
  configure do |c|
    c.server          = $settings["settings"]["server"]
    c.nick            = $settings["settings"]["nick"]
    c.channels        = [$settings["settings"]["channel"]]
    c.plugins.plugins = cinch_plugins.keys
    cinch_plugins.each do |plugin_class, options|
      c.plugins.options[plugin_class] = options
    end
  end
  
  on :message, /^!help/ do |m|
    $help_messages.each{ |message| m.user.send message }
  end
end

@irc.start
