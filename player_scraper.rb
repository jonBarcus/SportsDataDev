require 'open-uri'
require 'nokogiri'
require 'csv'
require 'pry'

#url = "https://pro-football-reference.com/players/B/BledDr00.htm"
url = "https://pro-football-reference.com/players/J/JohnBe21.htm"
html = open(url)


doc = Nokogiri::HTML(open(html)) do |config|
	config.noblanks.nononet
end

pre = doc.xpath('//pre')
xml = "<root>" + pre.text + "</root>"
contents = Nokogiri::XML(xml)
binding.pry
# player info from top of page
# playerInfoRaw = doc.at('#info').children[1].children[3]

playerName = playerInfoRaw.children[1].text

playerInfo = []

playerInfoRaw = playerInfoRaw.children[5] # narrows scope
binding.pry
playerInfo.push(
	name: "Name",
	position: playerInfoRaw.children[1].text,
	throws: playerInfoRaw.children[3].text,
	height: playerInfoRaw.children[7].text
	)

binding.pry
