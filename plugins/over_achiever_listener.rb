require_relative './over_achiever'

class OverAchieverListener
  include Cinch::Plugin

  $help_messages << "achieve: <number> <message>   Generate an achievement with <number> points"

  listen_to :channel

  def listen(m)
    if matches = m.message.match(/^achieve: (\d*)(\D.*)/)
      points = matches[1].empty? 5 : matches[1]
      msg = matches[2].strip
      if badge = OverAchiever.generate_badge(points, msg)
        m.reply badge.gsub('{{user}}', m.user.nick)
      end
    end
  end
end
