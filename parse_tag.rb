
class ParseTag

  def initialize(string)
    @string = string
  end

  def type
    puts @string.match(/^<([a-z]*\d?)/).captures.join
  end

  def classes
    puts @string.match(/class[ = ]*'(.*?)'/).captures.join
  end

  def id
    puts @string.match(/id[ = ]*'(.*?)'/).captures.join
  end

  def name
    puts @string.match(/name[ = ]*'(.*?)'/).captures.join
  end
end

tag = ParseTag.new("<p class= 'foo bar' id = 'baz' name ='fozzie'>Hello</p>")
tag.type
tag.classes
tag.id
tag.name