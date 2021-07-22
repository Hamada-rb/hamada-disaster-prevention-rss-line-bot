load_paths = Dir["/vendor/bundle/ruby/2.7.0/gems/**/lib"]
$LOAD_PATH.unshift(*load_paths)

require 'rss'
require 'date'
require 'line/bot'
require 'dotenv'

Dotenv.load

def lambda_handler(event:, context:)
    rss = RSS::Parser.parse("https://www.city.hamada.shimane.jp/www/rss/bousai.rdf", false)

    now = Time.now

    duration_start = now - 600
    duration_end = now

    client = Line::Bot::Client.new { |config|
        config.channel_secret = ENV["LINE_CHANNEL_SECRET"]
        config.channel_token = ENV["LINE_CHANNEL_TOKEN"]
    }

    rss.items.each{|item|
        rss_date = item.date
        puts rss_date
        if  rss_date > duration_start && duration_end > rss_date 
            message = {
                type: 'text',
                text: "件名: #{item.title}\n\nリンク: #{item.link}\n\n作成日時: #{item.date.strftime("%Y-%m-%d")}"
            }
            puts message
            client.broadcast(message)
        end
    }
end
