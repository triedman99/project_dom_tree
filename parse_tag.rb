def parse_tag(string)
  tag_hash = {}
  tag_hash[:type] = string.match(/^<([a-z]*\d?)/).captures.join
  tag_hash[:classes] = string.match(/class[ = ]*'(.*?)'/).captures.join.split(' ')
  tag_hash[:id] = string.match(/id[ = ]*'(.*?)'/).captures.join
  tag_hash[:name] = string.match(/name[ = ]*'(.*?)'/).captures.join
  p  tag_hash
end

parse_tag("<p class = 'foo bar' id = 'baz' name = 'fozzie'>")