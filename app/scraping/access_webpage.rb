require 'selenium-webdriver'
require 'nokogiri'
require_relative '../static/data'

# Selenium WebDriverの設定
options = Selenium::WebDriver::Chrome::Options.new
options.add_argument('--headless') # ヘッドレスモード（GUIなし）で実行する場合

# Selenium WebDriverの初期化
driver = Selenium::WebDriver.for :chrome, options: options

# ブラウザを開いて指定したURLにアクセス
driver.get(J1SHOW_URL)

# 3/7 夜やると5秒では不十分だった
sleep 10

# # ページのHTMLを取得
html = driver.page_source

doc = Nokogiri::HTML.parse(html)

puts doc

driver.quit

