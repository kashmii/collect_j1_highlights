require 'nokogiri'
require 'date'

require_relative '../static/data'

# 文字列の日付と時刻をDateTimeオブジェクトに変換
def parse_datetime(date_part, time_part)
  if date_part == '今日'
    date_part = DateTime.now.strftime('%m/%d')
  elsif date_part == '明日'
    date_part = (DateTime.now + 1).strftime('%m/%d')
  else
    date_part = date_part.split('(').first if date_part.include?('(')
  end

  date_format = "%m/%d"

  date_str = "#{date_part}/#{DateTime.now.year}"  # 年は現在の年を使用
  parsed_date = DateTime.strptime(date_str, date_format)

  time_format = "%H:%M"
  parsed_time = DateTime.strptime(time_part, time_format)

  # 日付と時刻を合成して返す
  parsed_date + Rational(parsed_time.hour, 24) + Rational(parsed_time.minute, 24 * 60)
end

def read_local_data
  # ===================================
  # 変数定義など
  game_attrs = []
  target_text = "第 #{GAME_WEEK_NUM} 日（全 38 日）"
  # ===================================

  html = File.read(HTML_FILE_PATH)
  doc = Nokogiri::HTML(html)

  # 節テーブル(class OcbAbf)を取得している
  target_element = doc.css(".GVj7ae:contains('#{target_text}')")[0].parent.parent
  this_tbody = target_element.at('tbody')

  # <tr> = 2試合が入っている行 | <td> = 1試合が入っている列
  # this_tbodyの子要素である<tr>要素の中の<td>要素すべてを選択します
  td_arr = this_tbody.css('> tr > td')

  # puts
  # puts "td_arr: #{td_arr.length}"
  # puts

  td_arr.each do |td|
    # tr 3つ目 日時
    third_tr = td&.at('tr:nth-child(3)')

    date_div = third_tr&.at('.imspo_mt__date')
    time_div = date_div&.next_element

    date_str = date_div&.text
    time_str = time_div&.text

    # tr 5つ目 ホーム
    # tr 6つ目 アウェイ
    fifth_tr = td&.at('tr:nth-child(5)')
    sixth_tr = td&.at('tr:nth-child(6)')

    home = fifth_tr&.at('.liveresults-sports-immersive__hide-element')
    away = sixth_tr&.at('.liveresults-sports-immersive__hide-element')

    # if home && away
    #   puts "home_team: #{home.text}, away_team: #{away.text}"
    #   puts
    # end

    # 出力する配列にpush
    if home && away && date_str && time_str
      game_attrs << [GAME_WEEK_NUM, parse_datetime(date_div&.text, time_div&.text), home.text, away.text]
    end
  end

  game_attrs
end

