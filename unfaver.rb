require 'twitter'

class TweetUnfaver


def unfaver(goal)
  
  client = Twitter::REST::Client.new do |config|
    config.consumer_key        = "<<consumer key here>>"
    config.consumer_secret     = "<<consumer secret here>>"
    config.access_token        = "<<access token here>>"
    config.access_token_secret = "<<access token secret here>>"
  end
  
  count = client.user.favorites_count
  
  puts "-------------------"
  puts "#{count} favorites remaining until #{goal}"
  puts "-------------------"
  
  if count > goal
    if count - goal < 100
      number_to_delete = count - goal
    else
      number_to_delete = 100
    end
    fave_deleter(client, number_to_delete: number_to_delete)
    unfaver(goal)
  else
    puts "#{goal} favorites reached"
  end

end

def fave_deleter(client, number_to_delete: 100)
  result = client.favorites(count: number_to_delete)
  favorites_to_delete = []
  result.each do |e|
    favorites_to_delete << e.id
  end
  
  faves_to_save = []
  final = client.unfavorite(favorites_to_delete)
  final.each do |e|
    faves_to_save << e.text
  end
  File.open("deleted_faves.txt", "a") do |f|
    f.puts(faves_to_save)
  end
end

end

TweetUnfaver.new.unfaver()