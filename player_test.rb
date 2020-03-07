require 'rspec'
require 'nokogiri'
require 'open-uri'

class Player

	def initialize(url)

		@doc = Nokogiri::HTML(open(url))
	end

	def self.get_player_name
	
		playerInfo = []
		#doc = Nokogiri::HTML(open(url))

		@doc.css('strong').each do |x|
			playerInfo << x.content.strip
		end
		
		playerInfo[0]
	end

	def self.get_player_position
	
		playerInfo = []
		
		@doc.css('p').each do |x|
			playerInfo << x
			
			positions = playerInfo[1].content.gsub(/W|(Position)/, "")
		end

		positions
		
	end

end

RSpec.describe Player do
	before(:all) do
		@url_bert_johnson = "https://pro-football-reference.com/players/J/JohnBe21.htm"
		@url_joe_namath = "https://www.pro-football-reference.com/players/N/NamaJo00.htm"
		@url_lawrence_taylor = "https://www.pro-football-reference.com/players/T/TaylLa00.htm"
		@url_drew_bledsoe = "https://www.pro-football-reference.com/players/B/BledDr00.htm"
		@url_josh_allen = "https://www.pro-football-reference.com/players/A/AlleJo02.htm"
	end
	
	context 'Bert Johnson' do
		
		before(:each) do
		
			Player.new(@url_bert_johnson)

		end

		describe '#get_player_name' do
		
			it 'returns the name "Bert Johnson"' do
				expect(Player.get_player_name(@url_bert_johnson)).to eq("Bert Johnson")
			end
		
		describe '#get_player_positions' do
			
			it 'returns the positions "FBBBHB"' do
				expect(bert.get_player_positions).to eq("FBBBHB")
			end

		end

	end

	context 'Joe Namath' do
	
		before(:each) do
			
			joe = Player.new(@url_joe_namath)
		end

		describe '#get_player_name' do

			it 'returns the name "Joe Namath"' do
                        	expect(joe.get_player_name).to eq("Joe Namath")
                	end
		end

                describe '#get_player_positions' do
                        
                        it 'returns the positions "QB"' do
                                expect(joe.get_player_positions).to eq("QB")
			end
                end
	end

	context 'Lawrence Taylor' do

                before(:each) do

                        lt = Player.new(@url_lawrence_taylor)
                end

                describe '#get_player_name' do

                        it 'returns the name "Lawrence Taylor"' do
                                expect(lt.get_player_name).to eq("Lawrence Taylor")
                        end
                end

                describe '#get_player_positions' do

                        it 'returns the positions "LB"' do
                                expect(lt.get_player_positions).to eq("LB")
                        end
                end
        end


	context 'Drew Bledsoe' do

                before(:each) do

                        drew = Player.new(@url_drew_bledsoe)
                end

                describe '#get_player_name' do

                        it 'returns the name "Drew Bledsoe"' do
                                expect(drew.get_player_name).to eq("Drew Bledsoe")
                        end
                end

                describe '#get_player_positions' do

                        it 'returns the positions "QB"' do
                                expect(drew.get_player_positions).to eq("QB")
                        end
                end
        end

	context 'Josh Allen' do

                before(:each) do

                        josh = Player.new(@url_josh_allen)
                end

                describe '#get_player_name' do

                        it 'returns the name "Josh Allen"' do
                                expect(josh.get_player_name).to eq("Josh Allen")
                        end
                end

                describe '#get_player_positions' do

                        it 'returns the positions "QB"' do
                                expect(josh.get_player_positions).to eq("QB")
                        end
                end
        end

end

