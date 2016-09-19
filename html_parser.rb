Node = Struct.new(:tag, :children, :parent)

class HTMLParser

  def initialize(html)
    @root = Node.new({:type => 'document'}, [], nil)
    @html = html
    parse
  end

  def tags
    @html.scan(/<.*?>/)
  end

  def text
    @html.split(/<.*?>/)
  end

  def parse
    tag_array = tags
    text_array = text[1..-1]
    current_parent = @root
    current_node = Node.new(tag_array.shift, [], @root)
    current_parent.children << current_node
    current_node.children << text_array.shift
    until tag_array.empty?
      if tag_array[0].match(/\/#{current_node.tag[1..-2]}/)
        current_node = current_node.parent
        tag_array.shift
        current_node.children << text_array.shift
      else
        current_parent = current_node
        current_node = Node.new(tag_array.shift, [], current_parent)
        current_parent.children << current_node
        current_node.children << text_array.shift
      end
    end
    @root = @root.children[0]
    outputter(@root)
  end

  def outputter(node)
    current_root = node
    print current_root.tag
    current_root.children.each do |child|
      if child.is_a?(String)
        print child
      else
        outputter(child)
      end
    end
    print "</#{current_root.tag[1..-2]}>"
  end

end

parser = HTMLParser.new("<div> div text before <p> p text </p> <div> more div text </div> div text after </div>")