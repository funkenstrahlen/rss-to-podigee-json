# encoding: utf-8

require 'feedjira'
require 'yaml'
require 'rubygems'
require 'json'

class PodigeeConfigGenerator

	def generate(podcast_feed_url)
		@feed = parse_feed podcast_feed_url
		@feed.entries.reverse_each do |entry|
			generate_config_file_for_entry entry
		end
	end

	private

		def parse_feed(podcast_feed_url)
			puts "parsing feed"
			return Feedjira::Feed.fetch_and_parse podcast_feed_url
		end

		def generate_config_file_for_entry(entry)
			puts "generating config file for #{entry.title}"

			enclosure_filename = URI(entry.enclosure_url).path.split('/').last
			config_filename = "#{File.basename(enclosure_filename, File.extname(enclosure_filename))}.json"
			config_baseurl = "https://podigee.github.io/podigee-podcast-player/example/"
			config_url = URI.join(config_baseurl, config_filename)

			config = {
				"options": {
					"theme": "default",
					"sslProxy": "https://cdn.podigee.com/ssl-proxy/"
				},
				"extensions": {
					"ChapterMarks": {
						"showOnStart": false
					},
					"EpisodeInfo": {
						"showOnStart": false
					},
					"Playlist": {
						"showOnStart": false,
						"disabled": true
					},
					"Share": {
						"showOnStart": false
					},
					"Transcript": {
						"showOnStart": false,
						"disabled": true
					},
					"Waveform": {
						"showOnStart": false,
						"disabled": true
					}
				},
				"podcast": {
					"feed": "#{@feed.feed_url}"
				},
				"episode": {
					"media": {},
					"coverUrl": "#{entry.itunes_image}",
					"url": "#{entry.url}",
					"embedCode": "<script class=\"podigee-podcast-player\" src=\"https://podigee.github.io/podigee-podcast-player/build/javascripts/podigee-podcast-player.js\" data-configuration=\"#{config_url}\"></script>",
					"title": "#{entry.title}",
					"subtitle": "#{entry.itunes_subtitle}",
					"description": "#{entry.itunes_summary}"
				}
			}

			# this currently only supports one single filetype
			# needs to be extended to support multiple available filetypes
			# however this is not easy as I only parse the rss feed of a single filetype
			enclosure_filetype = File.extname(enclosure_filename).split('.').last
			config[:episode][:media][enclosure_filetype] = entry.enclosure_url

			File.write(config_filename, config.to_json)			
		end
end
