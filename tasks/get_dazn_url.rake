# dazn の url を取得する
require 'selenium-webdriver'
require 'nokogiri'
require_relative '../app/static/data'

namespace :get_highlight do
  desc "Get highlight url from google"
  task :main do |task, args|
    # ===
    # ===
    # Selenium WebDriverの設定
    options = Selenium::WebDriver::Chrome::Options.new
    options.add_argument('--headless') # ヘッドレスモード（GUIなし）で実行する場合

    # Selenium WebDriverの初期化
    driver = Selenium::WebDriver.for :chrome, options: options

    # ブラウザを開いて指定したURLにアクセス
    driver.get(J1SHOW_URL)

    # JavaScript が動くのを待つ
    sleep 10

    html = driver.page_source
    # ===
    # ===

    doc = Nokogiri::HTML.parse(html)

    # homeチーム見つける
    target_text = "第 #{GAME_WEEK_NUM} 日（全 38 日）"

    target_element = doc.css(".GVj7ae:contains('#{target_text}')")[0].parent.parent
    this_tbody = target_element.at('tbody')

    # <tr> = 2試合が入っている行 | <td> = 1試合が入っている列
    # this_tbodyの子要素である<tr>要素の中の<td>要素すべてを選択します
    td_arr = this_tbody.css('> tr > td')

    args.extras.each do |team|
      td_arr.each do |td|
        div_under_td = td.css('div').find { |div| div.text.include?(team) }

        next if div_under_td.nil?

        dazn_url = div_under_td.at('a').attribute('href').value
        puts team
        puts dazn_url
        break
      end
    end

    driver.quit
  end


end