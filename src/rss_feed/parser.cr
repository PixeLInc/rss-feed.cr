require "xml"

module RSSFeeder
  struct Item
    getter data : Hash(String, String)

    def initialize(@data : Hash(String, String))
    end

    def title
      @data["title"]
    end

    def guid
      @data["guid"]
    end

    def description
      @data["description"]
    end

    def link
      @data["link"]
    end
  end

  class Parser
    def get_items(body : String)
      data = get_data(body)

      parse(data)
    end

    def get_data(xml_data : String)
      XML.parse xml_data
    end

    def parse(xml : XML::Node)
      items = xml.xpath("//rss/channel/item").as(XML::NodeSet)
      data = {} of String => String
      items.map do |node|
        node.children.each do |child|
          data[child.name] = child.text
        end

        Item.new(data)
      end
    end
  end
end
