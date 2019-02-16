# RSS Feed Emitter

An rss feed aggregator based on/rewritten of https://github.com/ga2mer/rss-feed-emitter.cr

## Installation

Add this to your application's `shard.yml`:

```yaml
dependencies:
  rss_feed:
    github: pixelinc/rss-feed.cr
```

## Usage

```crystal
require "rss_feed"

# refresh_interval is a Timespan
# This means you can use something like 5.seconds, 5.minutes, etc.

RSSFeeder::Feed.listen("url", refresh_interval: 5.seconds) do |item|
  puts item.title
end
```

## Contributing

1. Fork it ( https://github.com/pixelinc/rss-feed.cr/fork )
2. Create your feature branch (git checkout -b my-new-feature)
3. Commit your changes (git commit -am 'Add some feature')
4. Push to the branch (git push origin my-new-feature)
5. Create a new Pull Request

## Contributors

- [PixeLInc](https://github.com/pixelinc) PixeLInc - maintainer
- [ga2mer](https://github.com/ga2mer) Nikita Savyolov - original creator
