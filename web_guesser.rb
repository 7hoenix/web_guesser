require 'sinatra'
require 'sinatra/reloader'


SECRET_NUMBER = rand(101)
get '/' do
  guess = params["guess"]
  message = check_guess(guess)
  erb :index, :locals => {:number => SECRET_NUMBER, :message => message}
end

def check_guess(guess)
  differential = (guess.to_i - SECRET_NUMBER).abs
  if differential >= 5
    pre_message = "Way too "
  else
    pre_message = "Too "
  end
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

