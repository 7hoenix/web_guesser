require 'sinatra'
require 'sinatra/reloader'

SECRET_NUMBER = rand(101)
get '/' do
  guess = params["guess"]
  message = check_guess(guess)
  background = background_color(guess)
  erb :index, :locals => {:number => SECRET_NUMBER, :message => message,
    :background => background}
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
  (guess.to_i - SECRET_NUMBER).abs
end

def pre_message(differential)
  if differential >= 5
    pre_message = "Way too "
  else
    pre_message = "Too "
  end
end

def check_guess(guess)
  pre_message = pre_message(differential(guess))
  if guess.nil?
    message = "Take a guess"
  elsif SECRET_NUMBER < guess.to_i
    message = pre_message + "high!"
  elsif SECRET_NUMBER > guess.to_i
    message = pre_message + "low!"
  else
    message = "You got it right!"
  end
  message
end

