class ConsoleInterface
  HANGMAN_PIC = Dir[__dir__ + '/../data/figures/*.txt'].map { |pic| File.read(pic, chomp: true)}
  
  attr_reader :hangman
  def initialize(game)
    @game = game
  end

  def print_results
    <<~RESULTS
      Слово: #{print_word}
      #{HANGMAN_PIC[@game.errors_number]}
      Ошибки (#{@game.errors_number}): #{wrong_letters_to_show}
      Ошибок осталось: #{@game.errors_left}

    RESULTS
  end

  def print_word
    @game.word_to_show.map { |letter| letter.nil? ? '_' : letter }.join(' ')
  end

  def wrong_letters_to_show
    @game.wrong_letters.join(' , ')
  end

  def get_letter
    print "Введите букву: "
    letter = gets[0].downcase
    letter
  end
end
