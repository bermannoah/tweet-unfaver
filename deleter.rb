require 'twitter'
require 'dotenv'
Dotenv.load

class AllTweetsDeleted < StandardError; end

class TweetDeleter

  def initialize
    @tweets = []
  end

  def get_tweets(client)
    tweets = client.user_timeline(client.user, {count: 200, include_rts: true})
    raise AllTweetsDeleted, "All tweets deleted!" if tweets.empty?
    @tweets = tweets
  end

  def delete_tweets(client, goal)
    raise ArgumentError, "Put a number in deleter() on line 57 - use 0 to delete EVERYTHING." if !goal.is_a?(Integer)

    count = client.user.tweets_count

    puts "-------------------"
    puts "#{count} tweets remaining until #{goal}"
    puts "-------------------"

    if count > goal
      if count - goal < 100
        number_to_delete = count - goal
      else
        number_to_delete = 100
      end
      tweet_deleter(client, number_to_delete)
      delete_tweets(client, goal)
    else
      puts "#{goal} tweets deleted"
    end

  rescue Twitter::Error::TooManyRequests
    puts "You have exceeded Twitter's rate limit, please relax and try again in 24 hours."
  end

  def tweet_deleter(client, number_to_delete)
    tweets_to_delete, deletes_to_save = [], []
    @tweets[0..number_to_delete - 1].each do |e|
      tweets_to_delete << e.id
      deletes_to_save << e.text
    end

    File.open("deleted_tweets.txt", "a") do |f|
      f.puts(deletes_to_save)
    end

    client.destroy_status(tweets_to_delete)
  rescue Twitter::Error::NotFound
    puts "Couldn't find a tweet, hopefully continuing"
  end

end

client = Twitter::REST::Client.new do |config|
  config.consumer_key        = ENV['CONSUMER_KEY']
  config.consumer_secret     = ENV['CONSUMER_SECRET']
  config.access_token        = ENV['ACCESS_TOKEN']
  config.access_token_secret = ENV['ACCESS_TOKEN_SECRET']
end

deleter = TweetDeleter.new
deleter.get_tweets(client)
deleter.delete_tweets(client, 2 )