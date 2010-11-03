=begin
  = NAME
    ESPN fantasy football projections parser script.
  
  = AUTHOR
    Cameron M. Webb <cwebb02 (at) gmail (DoT) com>
    
  = DESCRIPTION
    This application rocks your world by utilizing the power of xpath and Nokogiri
    to collect ESPN's projection data from their website for further analysis. WOW!    
=end

require 'open-uri'
require 'rubygems'
require 'nokogiri'

#Ok, so we need to get the web page and then get our elements. Shibby!
for i in (1..30)
    i = i * 40
	url = "http://games.espn.go.com/ffl/tools/projections?&scoringPeriodId=1&seasonId=2010&startIndex="+ i.to_s
	#url = "http://games.espn.go.com/ffl/leaders?scoringPeriodId=1"
	puts url
	doc = Nokogiri::HTML(open(url))
	players = doc.xpath('//tr/td[@class="playertablePlayerName"]')
	projection = doc.xpath('//tr/td[@class="playertableStat appliedPoints sortedCell"]')
	stats = doc.xpath('//tr/td[@class="playertableStat "]')

	#For now, let's output the collected data to the console.
	#Note: There's some missing stuff here that I need to come back and 
	#re add later (um yeah, the PROJECTIONS!!!)
	players.each do |node|

	  playerIndex = players.index(node)
	  playerRegEx = Regexp.new '[\s*|,|/\302\240/]', nil, 'n'
	  playerID = node.xpath('.//a').attribute('playerid')
	  puts playerID
	  if RUBY_VERSION.delete('.').to_i > 190
		  #we enforce ASCII-8Bit to make this happy for ruby 1.9...
		  player = node.text.force_encoding("ASCII-8Bit").split(playerRegEx).delete_if {|x| x == ""}
	  else
		  player = node.text.split(playerRegEx).delete_if {|x| x == ""}
	  end
	  #puts(projection[players.index(node)].text)
	  #puts(stats[playerIndex*10].text + " " + stats[playerIndex*10+1].text) 
	end
end
