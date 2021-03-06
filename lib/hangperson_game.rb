class HangpersonGame

  # add the necessary class methods, attributes, etc. here
  # to make the tests in spec/hangperson_game_spec.rb pass.

  # Get a word from remote "random word" service

  # def initialize()
  # end
  attr_accessor :word
  attr_accessor :guesses
  attr_accessor :wrong_guesses
  #attr_reader :word_with_guesses

  def initialize(word)
    @word = word
    @guesses = ''
    @wrong_guesses = ''
  end

  def guess(c_orig)
    # raise error for incorrect input
    if c_orig == nil || c_orig == '' || /[^a-zA-Z]/.match(c_orig) || c_orig.length > 1
      raise ArgumentError
    end
    # case-insensitive
    c = c_orig.downcase
    # take care of repeated guesses
    if @guesses.include?(c) || @wrong_guesses.include?(c)
      return false
    end
    # core logic
    if @word.include?(c)
      @guesses << c
     
    else 
      @wrong_guesses << c
    end
    true
  end

  def word_with_guesses
    word_g = '-' * @word.length
    (0..@word.length-1).each do |i|
      if @guesses.include?(@word[i]) || @guesses.upcase.include?(@word[i])
        word_g[i] = @word[i]
      end
    end
    word_g
  end

  def check_win_or_lose
    if @wrong_guesses.length >= 7
      :lose
    else
      @word == self.word_with_guesses ? :win : :play
    end
  end

  def self.get_random_word
    require 'uri'
    require 'net/http'
    uri = URI('http://watchout4snakes.com/wo4snakes/Random/RandomWord')
    Net::HTTP.post_form(uri ,{}).body
  end

end
