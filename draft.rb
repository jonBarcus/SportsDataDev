require 'open-uri'
require 'nokogiri'
require 'pry'
require 'json'

url = 'https://www.pro-football-reference.com/years/1936/draft.htm'
html = open(url)

doc = Nokogiri::HTML.parse(html)
drafted_players = []
table = doc.at('table')

count = table.search('tr').count

table = table.search('tr')

table.shift
table.shift

table.each do |tr|
	
	drafted_players.push(
	round: tr.children[0].text,
	pick:  tr.children[1].text,
	team: tr.children[2].text,
	player_name: tr.children[3].text,
	position: tr.children[4].text,
	college: tr.children[26].text
	)
	
	puts drafted_players

end

json = JSON.pretty_generate(drafted_players)
File.open("drafted_players.json", 'w') { |file| file.write(json) }
#table.search('tr').each do |tr|

#	row = tr.search('th, td')
#binding.pry
#	cells.each do |cell|
		
#		binding.pry
#	end
#

#	table.at_xpath('//@*[/(data-row=)+(${count})+"]').each do |tr|
	#table.search("tr", ["/(data)(-)(row)/"]).each do |tr|
			
#		binding.pry
#		tr.at_xpath('//@*[/data-row=)+(${count})+"]')
#		count = count - 1
#	end

#end

