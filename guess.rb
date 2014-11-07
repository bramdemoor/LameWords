DEBUG = false

words = []
File.readlines('words.txt').each do |line|
  line.chomp!.downcase!
  #TODO BDM: remove words that contain non- alpha characters like spaces, numbers or special signs
  next if line.empty?  
  words << line
end

wordToGuess = words.sample
wordLn = wordToGuess.length
guessedLetters = Array.new(wordLn, '.')

playing = true

turnswithoutprogress = 0

begin

  showhint = turnswithoutprogress == 3
  if showhint 
    puts "Last #{turnswithoutprogress} guesses where pretty bad huh? Here's a hint:"
    hintLetterIndex = guessedLetters.join('').index('.')
    puts "Letter #{hintLetterIndex+1} is rumored to be #{wordToGuess[hintLetterIndex]}"
    turnswithoutprogress = 0
  end

  if DEBUG then puts "DEBUG: the word is #{wordToGuess}" end

  puts "Do a guess:"
  puts guessedLetters.join('')

  input = gets.chomp!

  if input.length != wordLn
    puts "FOUL! The word to guess is #{wordLn} chars long. Why did you type #{input.length} chars?"
    next
  end
 
  nothingnewfound = true
 
  0.upto(wordLn-1) do |letterindex| 
    if guessedLetters[letterindex] != '.' then next end
  
    try = input[letterindex]
    act = wordToGuess[letterindex]

    if try == act
      guessedLetters[letterindex] = try
      puts "Props! you guessed the letter #{act} at position #{letterindex}."
      nothingnewfound = false
    end
  end
  
  if input == wordToGuess    
    puts "Congratz! you guessed the word, #{wordToGuess}"
    playing = false
  elsif nothingnewfound
    turnswithoutprogress += 1
  end
  
end while playing
