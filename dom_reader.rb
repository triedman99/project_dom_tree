require_relative 'node_renderer.rb'

Node = Struct.new(:tag, :attributes, :children, :parent)

class DOMReader
  attr_reader :root

  def initialize(file = nil)
    @root = Node.new("document", {:type => "document"}, [], nil)
    file.nil? ? get_file : build_tree(file)
  end

  def get_file
    puts "# enter the file location you would like to read:"
    file_name = gets.chomp
    file_string = File.read(file_name)
    build_tree(file_string)
  end

  def tags(string)
    string.scan(/<.*?>/)
  end

  def text(string)
    string.split(/<.*?>/)
  end

  def parse_tag(string)
    tag_hash = {}
    tag_hash[:type] = string.match(/^<([a-z]*\d?)/).captures.join
    tag_hash[:classes] = string.match(/class[ = ]*'(.*?)'/).captures.join.split(' ') if string.match(/class[ = ]*'(.*?)'/)
    tag_hash[:id] = string.match(/id[ = ]*'(.*?)'/).captures.join if string.match(/id[ = ]*'(.*?)'/)
    tag_hash[:name] = string.match(/name[ = ]*'(.*?)'/).captures.join if string.match(/name[ = ]*'(.*?)'/)
    tag_hash
  end

  def build_tree(file_string)
    tag_array = tags(file_string)
    text_array = text(file_string)[1..-1]
    current_parent = @root
    current_tag = tag_array.shift
    current_node = Node.new(current_tag, parse_tag(current_tag), [], current_parent)
    current_parent.children << current_node
    current_node.children << text_array.shift
    until tag_array.empty?
      if tag_array[0].match(/\/#{current_node.attributes[:type]}/)
        current_node = current_node.parent
        tag_array.shift
        current_node.children << text_array.shift
      else
        current_parent = current_node
        current_tag = tag_array.shift
        current_node = Node.new(current_tag, parse_tag(current_tag), [], current_parent)
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
    print "</#{current_root.attributes[:type]}>"
  end

end

parser = DOMReader.new(File.read('test.html'))
renderer = NodeRenderer.new(parser.root)