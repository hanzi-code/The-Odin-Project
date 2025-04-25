def caesar_cipher(str, shift)
  ciphered = []
  alpha_lower = 'abcdefghijklmnopqrstuvwxyz'.split('')
  alpha_upper = 'ABCDEFGHIJKLMNOPQRSTUVWXYZ'.split('')

  # Modulus 26 handles the alphabet wrapping
  str.each_char do |char|
    if alpha_lower.include?(char)
      index = (alpha_lower.index(char) + shift) % 26
      ciphered << alpha_lower[index]
    elsif alpha_upper.include?(char)
      index = (alpha_upper.index(char) + shift) % 26
      ciphered << alpha_upper[index]
    else
      ciphered << char
    end
  end

  ciphered.join
end

print 'Type your string: '
str = gets.chomp

print 'Type the shift value: '
shift = gets.chomp.to_i

puts "#{caesar_cipher(str, shift)}"
