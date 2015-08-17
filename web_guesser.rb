require 'sinatra'
require 'sinatra/reloader'

@@secret_number = rand(101)
@@guesses       = 5

get '/' do
  guess = params["guess"]
  message = generate_message(guess)
  background = background_color(guess)
  erb :index, :locals => {:number => @@secret_number, :message => message,
    :background => background}
end

def generate_message(guess)
  if @@guesses > 0
    @@guesses -= 1
    message = check_guess(guess)
  else
    @@guesses = 5
    @@secret_number= rand(101)
    message = "You are out of guesses... and therefore lose."
  end
end

def background_color(guess)
  if differential(guess) >= 5
    "maroon"
  elsif differential(guess) == 0
    "green"
  else
    "red"
  end
end

def differential(guess)
  (guess.to_i - @@secret_number).abs
end


def check_guess(guess)
  pre_message = pre_message(differential(guess))
  if guess.nil?
    message = "Take a guess"
  elsif @@secret_number < guess.to_i
    message = pre_message + "high!"
  elsif @@secret_number > guess.to_i
    message = pre_message + "low!"
  else
    @@secret_number = rand(101)
    @@guesses = 5
    message = "You got it right! Guesses and the secret number have been reset
    for you to try again"
  end
  message
end

def pre_message(differential)
  if differential >= 5
    pre_message = "Way too "
  else
    pre_message = "Too "
  end
end

