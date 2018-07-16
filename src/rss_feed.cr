require "./rss_feed/*"
require "http/client"

module RSSFeeder
  class Feed
    @read_posts = [] of String
    @parser = Parser.new

    def initialize(@url : String, @refresh_interval : Time::Span = 60.seconds)
    end

    def self.listen(url : String, refresh_interval : Time::Span, &block : Item ->)
      new(url, refresh_interval).listen(&block)
    end

    def listen(&block : Item ->)
      loop do
        posts = refresh
        next if posts.nil? || posts.empty?

        posts.each { |item| block.call item unless @read_posts.includes? item.guid }
        @read_posts = posts.map &.guid
        sleep @refresh_interval
      end
    end

    def refresh
      response = HTTP::Client.get @url
      raise Exception.new("Error grabbing feed: #{response.status_code} #{response.status_message}") unless response.success?

      @parser.get_items response.body
    end
  end
end
