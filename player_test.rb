require 'rspec'
require 'nokogiri'
require 'open-uri'
require 'pry'

class Player

	def initialize(url)
		
		@playerInfo = []
		$playerDetails = []		
		
		$playerHeight = ""
		$playerWeight = ""

		@doc = Nokogiri::HTML(open(url))
	
		# this loop provides the @playerInfo variable
		# for the name
		@doc.css('strong').each do |x|
			@playerInfo << x.content.strip
		end

		@doc.css('p').each do |x|
			$playerDetails << x
		end

		$playerName = @playerInfo[0]

		$playerName
		$playerDetails
	end

	def get_player_name
		
		$playerName
	end

	def get_player_positions
		
		# $playerInfo array [1] provides player position info
		# takes the whitespace and non-position abbrevs &
		# other non-QB related info out
		positions = $playerDetails[1].content.gsub(/\W|(Position)/,"")
		
		# creates array via the Ruby .scan grabbing the Left
		# and/or Right throwing arms
		$throws = positions.scan(/(?:Left|Right)/)

		positions = positions.gsub(/(Throws|Left|Right)/, "")
		# outputs a string of positions
		# TODO allow for multiple positions - likely a DB thing
		positions
		
	end

	def get_throwing_arm

		throwing_arm = $throws[0]

		throwing_arm
	end

	# TODO create new function get_player_vitals
	# This fuction, if not expanding to include everything it should
	# will at least include player height and weight

	def get_player_height
		
		$height_weight = $playerDetails[2].children[3].content

		height = $height_weight.split(",")[0]
		weight = $height_weight.split(",")[1]	

		height = height.gsub(/\W|cm/,"")
		$weight = weight.gsub(/\W|kg/,"")

		$playerHeight = height
		# outputs height in cm
		$playerHeight
	end

	def get_player_weight

		$playerWeight = $weight
		# outputs weight in kg
		$playerWeight
	end

	def get_player_dob
		# Josh Allen DOB located at $playerDetails[4]
		# TODO need to figure out first year that DOB template changes
		$playerDOB = $playerDetails[3].children[3].attributes["data-birth"].value
	end

	def get_player_birthplace
		
		playerBirthplace = $playerDetails[3].children[5].content
	#	playerBirthCity = playerBirthplace.split(",")[0].gsub(/\W|in\b/, "")
		playerBirthCity = playerBirthplace.split(",")[0].gsub(/\W+(in)+\W|\W+$/, "")
		playerBirthState = playerBirthplace.split(",")[1].gsub(/\W/, "")
		# returns hash with birth City and State
		{city: playerBirthCity, state: playerBirthState}
	end

	def get_player_school

		if $playerDetails[4].content.include?("College:") == true
			player_school = $playerDetails[4].content.gsub(/(College:)\W+\t\b|\W+$|\W+\b(College Stats)/, "")
		else
			player_school = $playerDetails[5].content.gsub(/(College:)\W+\t\b|\W+$/, "")
		end
		
		player_school
	end
end

RSpec.describe Player do
	before(:all) do
		@url_bert_johnson = "https://pro-football-reference.com/players/J/JohnBe21.htm"
		@url_joe_namath = "https://www.pro-football-reference.com/players/N/NamaJo00.htm"
		@url_lawrence_taylor = "https://www.pro-football-reference.com/players/T/TaylLa00.htm"
		@url_drew_bledsoe = "https://www.pro-football-reference.com/players/B/BledDr00.htm"
		@url_tim_tebow = "https://www.pro-football-reference.com/players/T/TeboTi00.htm"
		@url_josh_allen = "https://www.pro-football-reference.com/players/A/AlleJo02.htm"
	end
	
	context 'Bert Johnson' do
		
		before(:each) do
		
			@bert = Player.new(@url_bert_johnson)

		end

		describe '#get_player_name' do
		
			it 'returns the name "Bert Johnson"' do
				expect(@bert.get_player_name).to eq("Bert Johnson")
			end
		end

		describe '#get_player_positions' do
			
			it 'returns the positions "FBBBHB"' do
				expect(@bert.get_player_positions).to eq("FBBBHB")
			end

		end

		describe '#get_player_height' do

			it 'returns the correct height of "183" in cm' do
				expect(@bert.get_player_height).to eq("183")
			end
		end

		describe '#get_player_weight' do
			
			it 'returns the correct weight of "96" in kg' do
				expect(@bert.get_player_weight).to eq("96")
			end
		end
		
		describe '#get_player_dob' do

			it 'returns the player DOB' do
				expect(@bert.get_player_dob).to eq("1912-02-18")
			end
		end

		describe '#get_player_birthplace' do

			it 'returns "Ashland" as birth City' do
				expect(@bert.get_player_birthplace[:city]).to eq("Ashland")
			end

			it 'returns "KY" as birth State' do
				expect(@bert.get_player_birthplace[:state]).to eq("KY")
			end
		end

		describe '#get_player_birthplace' do

			it 'returns "Kentucky" as school' do
				expect(@bert.get_player_school).to eq("Kentucky")
			end
		end
	end

	context 'Joe Namath' do
	
		before(:each) do
			
			@joe = Player.new(@url_joe_namath)
		end

		describe '#get_player_name' do

			it 'returns the name "Joe Namath"' do
                        	expect(@joe.get_player_name).to eq("Joe Namath")
                	end
		end

                describe '#get_player_positions' do
                        
                        it 'returns the positions "QB"' do
                                expect(@joe.get_player_positions).to eq("QB")
			end
                end

		describe '#get_throwing_arm' do

			it 'returns the "Right" throwing arm' do
				expect(@joe.get_throwing_arm).to eq("Right")
			end
		end

		describe '#get_height' do
			
			it 'returns the correct height of "188" in cm' do
				expect(@joe.get_player_height).to eq("188")
			end
		end

		describe '#get_weight' do

			it 'returns the correct weight of "90" in kg' do
				expect(@joe.get_player_weight).to eq("90")
			end
		end

		describe '#get_player_dob' do
	
			it 'returns the player DOB' do
				expect(@joe.get_player_dob).to eq("1943-05-31")
			end
		end

            describe '#get_player_birthplace' do

                  it 'returns "Beaver Falls" as birth City' do
                        expect(@joe.get_player_birthplace[:city]).to eq("Beaver Falls")
                  end

                  it 'returns "PA" as birth State' do
                        expect(@joe.get_player_birthplace[:state]).to eq("PA")
                  end
            end

		describe '#get_player_school' do
	
			it 'returns "Alabama" as the school' do
				expect(@joe.get_player_school).to eq("Alabama")
			end
		end

	end

	context 'Lawrence Taylor' do

                before(:each) do

                        @lt = Player.new(@url_lawrence_taylor)
                end

                describe '#get_player_name' do

                        it 'returns the name "Lawrence Taylor"' do
                                expect(@lt.get_player_name).to eq("Lawrence Taylor")
                        end
                end

                describe '#get_player_positions' do

                        it 'returns the positions "LB"' do
                                expect(@lt.get_player_positions).to eq("LB")
                        end
                end

		describe '#get_player_height' do
			
			it 'returns the correct height of "190" in cm' do
				expect(@lt.get_player_height).to eq("190")
			end
		end

		describe '#get_player_weight' do
	
			it 'returns the correct weights of "107" in kg' do
				expect(@lt.get_player_weight).to eq("107")
			end
		end

		describe '#get_player_dob' do

			it 'returns the player DOB' do
				expect(@lt.get_player_dob).to eq("1959-02-04")
			end
		end

            describe '#get_player_birthplace' do

                  it 'returns "Williamsburg" as birth City' do
                        expect(@lt.get_player_birthplace[:city]).to eq("Williamsburg")
                  end

                  it 'returns "VA" as birth State' do
                        expect(@lt.get_player_birthplace[:state]).to eq("VA")
                  end
            end

		describe '#get_player_school' do
		
			it 'returns "North Carolina" as the school' do
				expect(@lt.get_player_school).to eq("North Carolina")
			end
		end

        end


	context 'Drew Bledsoe' do

                before(:each) do

                        @drew = Player.new(@url_drew_bledsoe)
                end

                describe '#get_player_name' do

                        it 'returns the name "Drew Bledsoe"' do
                                expect(@drew.get_player_name).to eq("Drew Bledsoe")
                        end
                end

                describe '#get_player_positions' do

                        it 'returns the positions "QB"' do
                                expect(@drew.get_player_positions).to eq("QB")
                        end
                end

		describe '#get_throwing_arm' do

			it 'returns the "Right" throwing arm' do
				expect(@drew.get_throwing_arm).to eq("Right")
			end
		end

		describe '#get_player_height' do

			it 'returns the correct height of "196" in cm' do
				expect(@drew.get_player_height).to eq("196")
			end
		end

		describe '#get_player_weight' do
		
			it 'returns the correct weight of "107" in kg' do
				expect(@drew.get_player_weight).to eq("107")
			end
		end

		describe '#get_player_dob' do

			it 'returns the player DOB' do
				expect(@drew.get_player_dob).to eq("1972-02-14")
			end
		end

            describe '#get_player_birthplace' do

                  it 'returns "Ellensburg" as birth City' do
                        expect(@drew.get_player_birthplace[:city]).to eq("Ellensburg")
                  end

                  it 'returns "WA" as birth State' do
                        expect(@drew.get_player_birthplace[:state]).to eq("WA")
                  end
            end

		describe '#get_player_school' do

			it 'returns "Washington St" as the school' do
				expect(@drew.get_player_school).to eq("Washington St")
			end
		end

        end

	context 'Josh Allen' do

            before(:each) do

            	@josh = Player.new(@url_josh_allen)
            end

            describe '#get_player_name' do

                 it 'returns the name "Josh Allen"' do
                 		expect(@josh.get_player_name).to eq("Josh Allen")
                 end
           	end

            describe '#get_player_positions' do

                  it 'returns the positions "QB"' do
                        expect(@josh.get_player_positions).to eq("QB")  
                 end
            end

		describe '#get_throwing_arm' do

			it 'returns the "Right" throwing arm' do
				expect(@josh.get_throwing_arm).to eq("Right")
			end
		end

		describe '#get_player_height' do

			it 'returns the correct height of "196" in cm' do
				expect(@josh.get_player_height).to eq("196")
			end
		end

		describe '#get_player_weight' do

			it 'returns the correct weight of "107" in kg' do
				expect(@josh.get_player_weight).to eq("107")
			end
		end

		describe '#get_player_dob' do

			it 'returns the players DOB' do
				expect(@josh.get_player_dob).to eq("1996-05-21")
			end
		end

            describe '#get_player_birthplace' do

                  it 'returns "Firebaugh" as birth City' do
                        expect(@josh.get_player_birthplace[:city]).to eq("Firebaugh")
                  end

                  it 'returns "CA" as birth State' do
                        expect(@josh.get_player_birthplace[:state]).to eq("CA")
                  end
            end

		describe '#get_player_school' do

			it 'returns "Wyoming" as the school' do
				expect(@josh.get_player_school).to eq("Wyoming")
			end
		end

	end


      context 'Tim Tebow' do

            before(:each) do

                  @tebow = Player.new(@url_tim_tebow)
            end

            describe '#get_player_name' do

                 it 'returns the name "Tim Tebow"' do
                        expect(@tebow.get_player_name).to eq("Tim Tebow")
                 end
            end

            describe '#get_player_positions' do

                  it 'returns the positions "QB"' do
                        expect(@tebow.get_player_positions).to eq("QB")
                 end
            end

            describe '#get_throwing_arm' do

                  it 'returns the "Left" throwing arm' do
                        expect(@tebow.get_throwing_arm).to eq("Left")
                  end
            end

		describe '#get_player_height' do

			it 'returns the correct height of "188" in cm' do
				expect(@tebow.get_player_height).to eq("188")
			end
		end

		describe '#get_player_weight' do
			
			it 'returns the correct weight of "107" in kg' do
				expect(@tebow.get_player_weight).to eq("107")
			end
		end

		describe '#get_player_dob' do

			it 'returns the player DOB' do
				expect(@tebow.get_player_dob).to eq("1987-08-14")
			end
		end

            describe '#get_player_birthplace' do

                  it 'returns "Makati City" as birth City' do
                        expect(@tebow.get_player_birthplace[:city]).to eq("Makati City")
                  end

                  it 'returns "Phillipines" as birth State' do
                        expect(@tebow.get_player_birthplace[:state]).to eq("Phillipines")
                  end
            end

		describe '#get_player_school' do

			it 'returns "Florida" as the school' do
				expect(@tebow.get_player_school).to eq("Florida")
			end
		end

      end

end

