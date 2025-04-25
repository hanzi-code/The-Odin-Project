def substrings (str, dict)
  result = Hash.new(0)
  str.downcase!
  
  dict.each do |word|
    count = str.scan(word).count
    result[word] = count unless count == 0
  end

  return result
end


dictionary = ["below","down","go","going","horn","how","howdy","it","i","low","own","part","partner","sit"]
print "Type a sentence: "
string = gets.chomp

puts substrings(string, dictionary)