require 'rspec'
require 'nokogiri'
require 'open-uri'

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
      end

end

