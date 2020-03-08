require 'rspec'
require 'nokogiri'
require 'open-uri'

class Player

	def initialize(url)

		@doc = Nokogiri::HTML(open(url))

	end

	def get_player_name
		playerInfo = []
		#doc = Nokogiri::HTML(open(url))

		@doc.css('strong').each do |x|
			playerInfo << x.content.strip
		end
		
		playerInfo[0]
	end

	def get_player_positions
	
		playerInfo = []

		@doc.css('p').each do |x|

			playerInfo << x
		
		end
		
		# takes the whitespace and non-position abbrevs &
		# other non-QB related info out
		positions = playerInfo[1].content.gsub(/\W|(Position)/, "")
		
		# creates array via the Ruby .scan grabbing the Left
		# and/or Right throwing arms
		$throws = positions.scan(/(?:Left|Right)/)

		positions = positions.gsub(/(Throws|Left|Right)/, "")
		#if positions == "QB" && throws[0] != nil
		#
		#	throws[0]
		#	
		#	positions

		#else
		#
		#	positions
		#
		#end
		positions
		
	end

	def get_throwing_arm

		throwing_arm = $throws[0]

		throwing_arm
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
      end

end

