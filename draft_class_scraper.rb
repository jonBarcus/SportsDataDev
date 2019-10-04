require 'open-uri'
require 'nokogiri'
require 'csv'
require 'pry'

def draft_class_scraper(start_year)

	@year = start_year

	while true
		url = "https://www.pro-football-reference.com/years/#{@year}/draft.htm"

		draft_class_parser(open(url))
		puts "********#{@year} COMPLETE********"
		@year += 1
	end

end		


def draft_class_parser(html)

	doc = Nokogiri::HTML.parse(html)
	drafted_players=[]
	table = doc.at('table')

	count = table.search('tr').count

	table = table.search('tr')

	table.shift

	table.each do |tr|
		
		if tr.children[0].text == "\n         "  && drafted_players.count == 0 && @year <= 1993 # 1994 hasa slightly different table format

                	drafted_players.push(
                	year: "Year",
			round: tr.children[1].text,
                	pick: tr.children[3].text,
               		team: tr.children[5].text,
                	player_name: tr.children[7].text,
                	position: tr.children[9].text,
                	age: tr.children[11].text,
                	college: tr.children[53]
                	)

                	puts drafted_players

		elsif tr.children[0].text != "\n         " && @year <= 1993 # 1994 has a slightly different table format

	                drafted_players.push(
	                year: @year,
			round: tr.children[0].text,
	                pick:  tr.children[1].text,
	                team: tr.children[2].text,
	                player_name: tr.children[3].text,
	                position: tr.children[4].text,
	                age: tr.children[5].text,
	                college: tr.children[26].text
	                )

	                puts drafted_players
        	
		elsif tr.children[0].text == "\n         "  && drafted_players.count == 0 # should kick in for 1994 and beyond

                        drafted_players.push(
                        year: "Year",
                        round: tr.children[1].text,
                        pick: tr.children[3].text,
                        team: tr.children[5].text,
                        player_name: tr.children[7].text,
                        position: tr.children[9].text,
                        age: tr.children[11].text,
                        college: tr.children[55]
                        )

		elsif tr.children[0].text != "\n         "

			drafted_players.push(
                        year: @year,
                        round: tr.children[0].text,
                        pick:  tr.children[1].text,
                        team: tr.children[2].text,
                        player_name: tr.children[3].text,
                        position: tr.children[4].text,
                        age: tr.children[5].text,
                        college: tr.children[27].text
                        )

                        puts drafted_players

		end

        	puts drafted_players

	end

	CSV.open("#{@year}_drafted_players.csv", 'wb') do |csv|
		drafted_players.each do |hash|
			csv << hash.values
		end
	end
end
