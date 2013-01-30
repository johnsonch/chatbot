require 'net/http'
require "uri"

module OverAchiever
  def self.generate_badge(points, msg)
    email = "m8r-pgofgf@mailinator.com"
    
    uri = URI.parse("http://www.justachieveit.com/jai/code.jsp")
    response = Net::HTTP.post_form(uri, { type: 1, email: email, text: msg, score: points })
    
    if response.is_a?(Net::HTTPRedirection) && response['location']
      badge_response = Net::HTTP.get_response(URI.parse(response['location']))
      if badge_response.is_a?(Net::HTTPOK) && matches = badge_response.body.match(/src="(http:\/\/cdn\.justachieveit\.com\/[^"]+)"/)
        matches[1]
      else
        "Sorry {{user}} I can't find the badge's URL"
      end
    else
      "Sorry {{user}} I couldn't figure out where to get the badge's URL"
    end
  end
end
