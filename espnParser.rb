=begin
  = NAME
    ESPN fantasy football projections parser script.
  
  = AUTHOR
    Cameron M. Webb <cwebb02 (at) gmail (DoT) com>
    
  = DESCRIPTION
    This application rocks your world by utilizing the power of xpath and Nokogiri
    to collection ESPN's projection data from their website for further analysis. WOW!    
=end

require 'open-uri'
require 'rubygems'
require 'nokogiri'

#Ok, so we need to get the web page and then get our elements. Shibby!
doc = Nokogiri::HTML(open("http://games.espn.go.com/ffl/tools/projections?&
    scoringPeriodId=1&seasonId=2010&leagueId=521760&startIndex=0"))
players = doc.xpath('//tr/td[@class="playertablePlayerName"]')
projection = doc.xpath('//tr/td[@class="playertableStat appliedPoints sortedCell"]')
stats = doc.xpath('//tr/td[@class="playertableStat "]')

#For now, let's output the collected data to the console.
players.each do |node|
  playerIndex = players.index(node)
  player = node.text.split(%r{[\s*|,|/\302\240/]}).delete_if {|x| x == ""}
  
  puts(player)
  #puts(projection[players.index(node)].text)
  #puts(stats[playerIndex*10].text + " " + stats[playerIndex*10+1].text) 
end
