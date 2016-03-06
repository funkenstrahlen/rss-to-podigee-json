gem:
	rm *.gem
	gem build rss-to-podigee-json.gemspec

release: gem
	gem push *.gem