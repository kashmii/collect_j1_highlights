require 'selenium-webdriver'
require 'nokogiri'

# 「日程・結果」画面
j1show_url = "https://www.google.co.jp/search?q=%E6%97%A5%E7%A8%8B+j1&sca_esv=179241790b8982d2&sxsrf=ACQVn08z1EoU9KSJjzRTmf-r3o8QQ7Vl1w%3A1709476060305&source=hp&ei=3IjkZc3eD46A2roPvcOckA8&iflsig=ANes7DEAAAAAZeSW7MN-oJHH9NMiuPpngp5nYAE0Kdnf&oq=&gs_lp=Egdnd3Mtd2l6IgAqAggAMgcQIxjqAhgnMgcQIxjqAhgnMgcQIxjqAhgnMgcQIxjqAhgnMgcQIxjqAhgnMgcQIxjqAhgnMgcQIxjqAhgnMgcQIxjqAhgnMgcQIxjqAhgnMgcQIxjqAhgnSP4RUABYAHABeACQAQCYAQCgAQCqAQC4AQHIAQCYAgGgAgeoAgqYAweSBwExoAcA&sclient=gws-wiz#sie=lg;/g/11vkhnk7dx;2;/m/0bs1n73;mt;fp;1;;;"

# Selenium WebDriverの設定
options = Selenium::WebDriver::Chrome::Options.new
options.add_argument('--headless') # ヘッドレスモード（GUIなし）で実行する場合

# Selenium WebDriverの初期化
driver = Selenium::WebDriver.for :chrome, options: options

# ブラウザを開いて指定したURLにアクセス
driver.get(j1show_url)

# ページのHTMLを取得
html = driver.page_source

# ここでNokogiriなどを使ってHTMLを解析する
doc = Nokogiri::HTML.parse(html)
puts doc

# ブラウザを閉じる
driver.quit
