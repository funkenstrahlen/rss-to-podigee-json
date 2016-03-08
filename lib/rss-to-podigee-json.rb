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
						"showOnStart": false
					},
					"Share": {
						"showOnStart": false
					},
					"Transcript": {
						"showOnStart": false
					},
					"Waveform": {
						"showOnStart": false
					}
				},
				"podcast": {
					"feed": "https://cdn.podigee.com/ppp/samples/feed.xml"
				},
				"episode": {
					"media": {
						"mp3": "https://cdn.podigee.com/ppp/samples/media.mp3?source=webplayer",
						"m4a": "https://cdn.podigee.com/ppp/samples/media.m4a",
						"ogg": "https://cdn.podigee.com/ppp/samples/media.ogg",
						"opus": "https://cdn.podigee.com/ppp/samples/media.opus"
					},
					"coverUrl": "https://cdn.podigee.com/ppp/samples/cover.jpg",
					"url": "https://podigee.github.io/podigee-podcast-player/",
					"embedCode": "<script class=\"podigee-podcast-player\" src=\"https://podigee.github.io/podigee-podcast-player/build/javascripts/podigee-podcast-player.js\" data-configuration=\"https://podigee.github.io/podigee-podcast-player/example/config.json\"></script>",
					"title": "FG009 Wirtschaftspolitischer Journalismus",
					"subtitle": "Wie Henrik Müller in Dortmund wirtschaftspolitischen Journalismus lehrt und erforscht. Und was guten Wirtschaftsjournalismus ausmacht.",
					"description": "Raus aus der prallen journalistischen Praxis, rein in die Gremien-Universität. Henrik Müller hat diesen ungewöhnlichen Schritt gewagt: 2013 übernahm der damalige stellvertretende Chefredakteur des \"manager magazin\" den Lehrstuhl für wirtschaftspolitischen Journalismus am Institut für Journalistik der Technischen Universität Dortmund. Dort baut er seitdem die neuen Bachelor- und Master-Studiengänge für wirtschaftspolitischen Journalismus auf. Wie er diesen Wechsel zwischen den  Welten erlebt hat, was er seinen Studierenden vermitteln will und woran er forscht, erzählt der immer noch sehr umtriebige Autor (\"Wirtschaftsirrtümer: 50 Denkfehler, die uns Kopf und Kragen kosten\") und Spiegel-Online-Kolumnist in dieser anregenden Episode. Dabei geht es darum, was Wirtschaftsjournalismus leisten soll und muss, was Studierende erst mühsam über Lobbyismus lernen müssen und was eigentlich \"gute Geschichten\" sind."
				}
			}
			File.write("test.json", config.to_json)			
		end
end
