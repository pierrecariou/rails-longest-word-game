require 'open-uri'
require 'json'

class GamesController < ApplicationController

  def new
    alphabet = "A".."Z"
  letters = alphabet.to_a
  @new_letters = []
  letters.each do |letter|
    until @new_letters.size == 10
      @new_letters << letters.sample
    end
  end
  end

  def score
  @new_letters = params[:grid].split(" ")
  @word = params[:word]
  @answer = "Sorry but #{@word} can't be built out of #{@new_letters.join(", ")}"
  url = "https://wagon-dictionary.herokuapp.com/#{@word}"
  response = open(url).read
  attempt_word = JSON.parse(response)

  if @word == ""
    @answer = "You didn't type any word"
  elsif attempt_word['found'] == false
    @answer = "Sorry but #{@word} does not seems to be an english word"
  elsif @word.upcase.split("").all? do |letter|
          @word.upcase.split("").count(letter) <= @new_letters.count(letter)
        end
  @answer = "Congratulations! #{@word} is a valid english word"
  end
end
end
