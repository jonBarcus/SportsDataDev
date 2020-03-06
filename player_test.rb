require 'rspec'
require 'nokogiri'
require 'open-uri'

module Player

	def self.get_player_info(url)
	
		playerInfo = []
		doc = Nokogiri::HTML(open(url))

		doc.css('strong').each do |x|
			playerInfo << x.content.strip
		end
		
		playerInfo[0]
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
	
	describe '#get_player_info' do
		
		it 'returns the name "Bert Johnson"' do
			expect(Player.get_player_info(@url_bert_johnson)).to eq("Bert Johnson")
		end
		it 'returns the name "Joe Namath"' do
                        expect(Player.get_player_info(@url_joe_namath)).to eq("Joe Namath")
                end
		it 'returns the name "Lawrence Taylor"' do
                        expect(Player.get_player_info(@url_lawrence_taylor)).to eq("Lawrence Taylor")
                end
		it 'returns the name "Drew Bledsoe"' do
                        expect(Player.get_player_info(@url_drew_bledsoe)).to eq("Drew Bledsoe")
                end
		it 'returns the name "Josh Allen"' do
                        expect(Player.get_player_info(@url_josh_allen)).to eq("Josh Allen")
                end
	end
end

