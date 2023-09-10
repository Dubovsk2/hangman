class Game
  ERRORS_ALLOWED = 7

  attr_reader :word, :right_letters, :wrong_letters

  def initialize(word)
    @word = get_the_word_from_txt
    @right_letters = []
    @wrong_letters = []
  end

  def errors_number
    @wrong_letters.uniq.size
  end

  def errors_left
    ERRORS_ALLOWED - errors_number
  end

  def check_letter(letter)
    @word.include?(normilize_letter(letter)) ? @right_letters.push(letter) : @wrong_letters.push(letter)
  end

  def word_to_show
    word = []
    @word.each do |letter|
      @right_letters.include?(normilize_letter(letter)) ? word.push(letter) : word.push(nil)
    end
    word
  end

  def finished?
    errors_left == 0
  end

  def won?
    (normilized_letters(@word).uniq - (normilized_letters(@right_letters)).uniq).empty?
  end

  def game_result
    result = 'Вы победили!' if won?
    if finished? && !won?
      result = <<~RESULT
      Вы проиграли!
      Загаданное слово: #{@word.join('')}
      RESULT
    end
    result
  end

  def normilize_letter(letter)
    return 'е' if letter == 'ё'
    return 'и' if letter == 'й'
    return letter
  end

  def normilized_letters(array)
    array.map { |letter| normilize_letter(letter) }
  end

private
  def get_the_word_from_txt
    File.readlines(__dir__ + '/../data/words.txt', chomp: true).sample.split('')
  end
end
