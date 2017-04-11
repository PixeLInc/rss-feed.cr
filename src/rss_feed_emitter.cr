require "./rss_feed_emitter/*"
require "http/client"

module RSSFeedEmitter
  class Feeder
    @feed_list = [] of Feed
    @history_length_multiplier = 3
    def add(url : String, refresh : Int32 = 60)
      @feed_list << Feed.new self, url, refresh
    end

    def new_item(&block : Hash(String, String)->)
      @new_item_callback = block
    end

    def list()
      @feed_list
    end

    def remove(url : String)
      feed = @feed_list.find {|x| x.@url == url }
      if feed
        @feed_list.delete feed
        feed.delete
      end
    end

    def destroy()
      @feed_list.each {|feed| remove feed.@url}
    end

    def start()
      sleep
    end
  end

  class Feed
    @items = [] of Hash(String, String)
    @max_history_length = 0
    @parser = Parser.new
    @deleted = false

    def initialize(@feed : Feeder, @url : String, @refresh : Int32 = 60)
        run
    end

    def delete
      @deleted = true
    end

    def find_item(items, item)
      @items.find {|x| 
        if x["guid"]?
          x["guid"]? == item["guid"]?
        elsif x["title"]? && x["link"]?
          x["title"]? == item["title"]? && x["link"]? == item["link"]?
        end
      }
    end

    def run()
      spawn do
        if !@deleted
          begin
            res = HTTP::Client.get @url
            if !res.body.empty?
              items = @parser.get_items res.body
              @max_history_length = items.size * @feed.@history_length_multiplier
              newItems = items.select {|item| 
                i = find_item items, item
                if !i
                  @items << item
                  @items = @items.last @max_history_length
                  spawn do
                  @feed.@new_item_callback.try &.call item
                  end
                end
              }
            end
          rescue
          end
          sleep @refresh
          run
        end
      end
    end
  end
end