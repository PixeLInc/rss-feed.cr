require "xml"

module RSSFeedEmitter
  class Parser
    def get_items(xml : String)
      doc = XML.parse xml
      items = doc.xpath("//rss/channel/item").as(XML::NodeSet)

      items.map { |c|
        item = {} of String => String

        field = c.xpath_node("title")
        if field
          item["title"] = field.as(XML::Node).text.as(String)
        end

        field = c.xpath_node("link")
        if field
          item["link"] = field.as(XML::Node).text.as(String)
        end

        field = c.xpath_node("pubDate")
        if field
          item["pubDate"] = field.as(XML::Node).text.as(String)
        end

        field = c.xpath_node("description")
        if field
          item["description"] = field.as(XML::Node).text.as(String)
        end

        field = c.xpath_node("guid")
        if field
          item["guid"] = field.as(XML::Node).text.as(String)
        end

        field = c.xpath_node("creator")
        if field
          item["creator"] = field.as(XML::Node).text.as(String)
        end

        item
      }
    end
  end
end
