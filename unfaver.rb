require 'twitter'
require 'dotenv'
Dotenv.load

class TweetUnfaver


  def unfaver(goal)
    
    client = Twitter::REST::Client.new do |config|
      config.consumer_key        = ENV['CONSUMER_KEY']
      config.consumer_secret     = ENV['CONSUMER_SECRET']
      config.access_token        = ENV['ACCESS_TOKEN']
      config.access_token_secret = ENV['ACCESS_TOKEN_SECRET']
    end
    
    count = client.user.favorites_count
    
    puts "-------------------"
    puts "#{count} faves remaining until #{goal}"
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

TweetUnfaver.new.unfaver(0)