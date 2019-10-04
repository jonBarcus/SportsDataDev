require 'open-uri'
require 'nokogiri'
require 'pry'
require 'json'
require 'csv'
load 'get_scope.rb'

url = 'https://www.pro-football-reference.com/years/1936/draft.htm'
html = open(url)

doc = Nokogiri::HTML.parse(html)
drafted_players = []
table = doc.at('table')

count = table.search('tr').count

table = table.search('tr')

table.shift
#table.shift

table.each do |tr|

	if tr.children[0].text == "\n         "  && drafted_players.count == 0

		drafted_players.push(
		round: tr.children[1].text,
		pick: tr.children[3].text,
		team: tr.children[5].text,
		player_name: tr.children[7].text,
		position: tr.children[9].text,
		age: tr.children[11].text,
		college: tr.children[53]
		)

		puts drafted_players
	#elsif tr.content[0] != "\n" && drafted_players[0] == "Rnd"
	#elsif drafted_players[0] == "Rnd" && tr.children[0].text != "\n         "
	elsif tr.children[0].text != "\n         " && 

		drafted_players.push(
		round: tr.children[0].text,
		pick:  tr.children[1].text,
		team: tr.children[2].text,
		player_name: tr.children[3].text,
		position: tr.children[4].text,
		age: tr.children[5].text,		
		college: tr.children[26].text
		)
		
		puts drafted_players
	end
	puts drafted_players

end

#json = JSON.pretty_generate(drafted_players)
#File.open("drafted_players.json", 'w') { |file| file.write(json) }

CSV.open("drafted_players.csv", 'wb') do |csv|
	drafted_players.each do |hash|
		csv << hash.values
	end
end


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

