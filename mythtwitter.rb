#!/bin/env ruby
require 'rubygems'
require 'feedzirra'

user_id = '100989156'

last = nil
while true
	puts "Checking..."
	feed = Feedzirra::Feed.fetch_and_parse("http://twitter.com/statuses/user_timeline/#{user_id}.rss")
	if !feed.is_a?(Fixnum)
		entry = feed.entries.first
		if entry.title != last
			puts "New tweet found"
			if entry
				`mythtvosd --template=scroller --scroll_text="#{entry.title}"`
			end
			last = entry.title
		else
			puts "No new tweets"
		end
	else
		puts "Twitter fail: #{feed}"
	end
	sleep(60)
end
