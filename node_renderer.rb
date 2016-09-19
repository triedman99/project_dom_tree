class NodeRenderer

  def initialize(tree)
    @tree = tree
    @current_node = nil
    @tags = Hash.new(0)
    render(@tree)
  end

  def render(node=nil)
    if node
      @current_node = node
    else
      @current_node = @tree
    end
    puts "# There are #{count_nodes} nodes below this node."
    @tags.each do |tag, count|
      puts "# <#{tag}>: #{count}"
    end
    puts "# These are the attributes of your starting node:"
    @current_node.attributes.each do |attribute, value|
      puts "# #{attribute} = #{value}"
    end
  end

  def count_nodes
    total = 0
    stack = []
    @current_node.children.each do |child|
      if child.is_a?(Node)
        stack << child
        @tags[child.attributes[:type]] += 1
        total += 1
      end
    end
    until stack.empty?
      @current_node = stack.pop
      @current_node.children.each do |child|
        if child.is_a?(Node)
          stack << child
          @tags[child.attributes[:type]] += 1
          total += 1
        end
      end
    end
    total
  end

end