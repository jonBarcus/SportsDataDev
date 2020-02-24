require 'open-uri'
require 'nokogiri'
require 'reverse_markdown'
require 'pry'

url = "https://pro-football-reference.com/players/J/JohnBe21.htm"

html = open(url)


#doc = Nokogiri::HTML.parse(html)

result = ReverseMarkdown.convert(html)
binding.pry

