# encoding: utf-8

require 'feedjira'
require 'yaml'
require 'rubygems'
require 'json'

class PodigeeConfigGenerator

	def generate(podcast_feed_url)
		feed = parse_feed podcast_feed_url
		feed.entries.reverse_each do |entry|
			generate_config_file_for_entry entry
		end
	end

	private

		def parse_feed(podcast_feed_url)
			puts "parsing feed"
			return Feedjira::Feed.fetch_and_parse podcast_feed_url
		end

		def generate_config_file_for_entry(entry)
			puts "generating config file for #{entry}"
			client_secret['installed']['refresh_token'] = "sdfklj"
			File.write("test.json", client_secret.to_json)			
		end
end
