require 'open-uri'
require 'nokogiri'

url = 'https://qiita.com/'

# urlにアクセスしてhtmlを取得する
html = URI.open(url).read

# 取得したhtmlをNokogiriでパースする
doc = Nokogiri::HTML.parse(html)

# htmlのtitleを取得して出力する
html = URI.open(url).read
puts html