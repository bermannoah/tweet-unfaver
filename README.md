# Unfaver

It unfaves your twitter faves and saves them to a .txt file! 

ATTENTION: This is a clumsy little hack of a script and may cause issues! It does
not know anything about your rate limits and it handles errors by crashing. Every so often
it will get itself stuck in a loop (usually when there's between 1-2 faves to delete remaining)
and you'll need to interrupt it by hitting `control c`. 

As this is licensed under the coward's version of the "do what the fuck you want" license, not only
can you do whatever you want with this you also can't blame me when it goes horribly wrong. 

That being said I'm happy to help if you file an issue on the repo! :)

### How To Use This
I'm assuming you're (1) using a mac and (2) have ruby installed. If (1) is true
(2) will at least be true in some way shape or form. :) 

1. Clone down this repo 
2. `cd` into it with your command line client of choice
3. Install the very good twitter gem:
  `gem install twitter`
4. Go to https://dev.twitter.com and create an application. 
5. Get your keys and access tokens from the keys-and-access-tokens panel. You might
need to generate the tokens.
6. Go to the `unfaver.rb` file. In the bit that looks like this:
```ruby
config.consumer_key        = "<<consumer key here>>"
config.consumer_secret     = "<<consumer secret here>>"
config.access_token        = "<<access token here>>"
config.access_token_secret = "<<access token secret here>>"
```
delete the `<< >>` portions and insert the relevant keys inside the quotes.

IMPORTANT: Do not commit the script containing these keys to github or anywhere else! 

7. Wander on down to the very last line of the code. It will or should look like this:
`TweetUnfaver.new.unfaver()`

You'll need to stick the number of tweets you want to unfave in the () portion of that line.

8. Once you've done all of the above, go back to your command line client and type 
`ruby unfaver.rb`. The script should run. It may take a while as it can only delete 100 
faves at a time.

9. Once it has finished running you'll be able to find all of your deleted faves stored
in the `deleted_faves.txt` file. If you plan on running the script again, I suggest making 
a copy of the file and putting it somewhere else. 

Have fun!

