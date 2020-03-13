require 'rspec'
require 'nokogiri'
require 'open-uri'
require 'pry'


#url = "https://www.pro-football-reference.com/schools/high_schools.cgi"

hs_url = "/schools/high_schools.cgi"

@doc = Nokogiri::HTML(open(url))

class SeedDB

	def initialize

		@doc = Nokogiri::HTML(open("https://www.pro-football-reference.com" + hs_url))
		


	end

	def seed_high_schools

		web_page = []		

		@doc.css("div").each do |webpage|

			web_page << webpage

		end

		second_layer = web_page[18].children[2].children[1].children[5].content

		parsed_data = Nokogiri::HTML.parse(second_layer)

		new_xml = parsed_data.children[1].children[0].children[0].children[1].children[1].children[6].children

		# removes first node
		new_xml.shift

		state_array = []

		new_xml.xpath("//a").each do |state|
		
			state_array << state
		end

		state_string_array = []

		state_array.each do |state|

			state_string_array << state
		
		end	

		state_string_array.each do |state_string|

			temp_string = state_string.scan(/[^*]+=|\W+|.(?!\<\/a\>)*.$/)

			temp_array = temp_string.insert(2, ",").split(",")

			temp_hash = {state_for_url: temp_array[0], state_name: temp_array[1]}
		
		end

		

			

	end



end

