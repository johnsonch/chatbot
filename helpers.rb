require 'active_support'

def include_plugins(plugin_list = {})
  plugin_list ||= {}
  
  plugins = plugin_list.inject({}) do |plugin_classes, plugin|
    plugin_name, plugin_options = plugin
    underscored_name  = ActiveSupport::Inflector.underscore(plugin_name)
    if plugin_options && path = plugin_options.delete('require')
      require path
    else
      require "./plugins/#{underscored_name}"
    end
    plugin_class = ActiveSupport::Inflector.constantize(plugin_name)
    plugin_classes[plugin_class] = (plugin_options || {})
    
    plugin_classes
  end
  
  return plugins
end

def initialize_globals!
  $settings = YAML.load(File.read("bot.yml"))
  $help_messages = []
end
