require 'open-uri'

def draft_class_scope(start_year)

	year = start_year

	while true	

		url = "https://www.pro-football-reference.com/years/#{year}/draft.htm"
		
		open(url)
		puts year
		year += 1
	end
end

	
	
