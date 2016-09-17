Tags = Struct.new(:type, :classes, :id, :name)

class ParseTag

  def initialize(string)
    @string = string
    @tag_hash = {}
  end

  def type
    @tag_hash[:type] = @string.match(/^<([a-z]*\d?)/).captures.join
  end

  def classes
    @tag_hash[:classes] = @string.match(/class[ = ]*'(.*?)'/).captures.join.split(' ')
  end

  def id
    @tag_hash[:id] = @string.match(/id[ = ]*'(.*?)'/).captures.join
  end

  def name
    @tag_hash[:name] = @string.match(/name[ = ]*'(.*?)'/).captures.join
  end

end

tag = ParseTag.new("<p class= 'foo bar' id = 'head' name ='Tamal'>Hello</p>")
html = Tags.new(tag.type, tag.classes, tag.id, tag.name)
p html