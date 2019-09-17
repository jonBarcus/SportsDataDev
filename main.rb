require 'open-uri'
require 'nokogiri'
require 'pry'

url = 'https://www.pro-football-reference.com/years/1970/'
html = open(url)

doc = Nokogiri::HTML(html)
team_names = []
table = doc.at('table')

table.search('tr').each do |tr|
	cells = tr.search('th, td')
binding.pry
	cells[0].css('a').each do |team|
binding.pry
		team_names << team.children[0].text
	end

	puts team_names


#	stats.push(
#		team_name: team_names)
	
#	puts stats
end

json = JSON.pretty_generate(stats)

File.open("stats.json", 'w') { |file| file.write(json) }

