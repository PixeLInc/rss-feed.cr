# rss_feed_emitter

RSS feed aggregator. Crystal implementation of [filipedeschamps/rss-feed-emitter](https://github.com/filipedeschamps/rss-feed-emitter)

## Installation

Add this to your application's `shard.yml`:

```yaml
dependencies:
  rss_feed_emitter:
    github: ga2mer/rss_feed_emitter.cr
```

## Usage

```crystal
require "rss_feed_emitter"

# create feeder
feeder = RSSFeedEmitter::Feeder.new

# add rss feed
feeder.add "http://127.0.0.1:9998"

# listening new items
feeder.new_item do |item|
    puts item
end

# Not necessary if your app does not closing
feeder.start
```

TODO: Write usage instructions here

## Development

TODO: Write development instructions here

## Contributing

1. Fork it ( https://github.com/ga2mer/rss_feed_emitter/fork )
2. Create your feature branch (git checkout -b my-new-feature)
3. Commit your changes (git commit -am 'Add some feature')
4. Push to the branch (git push origin my-new-feature)
5. Create a new Pull Request

## Contributors

- [ga2mer](https://github.com/ga2mer) Nikita Savyolov - creator, maintainer
