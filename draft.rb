require 'open-uri'
require 'nokogiri'
require 'pry'
require 'json'

url = 'https://www.pro-football-reference.com/years/1936/draft.htm'
html = open(url)

doc = Nokogiri::HTML.parse(html)
team_names = []
table = doc.at('table')
binding.pry

count = table.search('tr').count
#table.search('tr').each do |tr|

#	row = tr.search('th, td')
#binding.pry
#	cells.each do |cell|
		
#		binding.pry
#	end
	table.search('//tr[@data-row]={count}/..').each do |tr|
	
		binding.pry
		count -=
	end

#end

