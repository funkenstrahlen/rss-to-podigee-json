Gem::Specification.new do |spec|
	spec.name        = 'rss-to-podigee-json'
	spec.version     = '0.1'
	spec.licenses    = ['MIT']
	spec.summary     = "Ruby script to generate json config files required for the podigee podcast player."
	spec.description = "The podigee podcast player requires config.json files with the required metadata inside to be embeddable. This script fetches your podcast's rss feed and generates a podigee podcast player config file for each episode."
	spec.authors     = ["Stefan Trauth"]
	spec.email       = 'mail@stefantrauth.de'
	spec.homepage    = 'https://github.com/funkenstrahlen/rss-to-podigee-json'

	spec.files       = ["lib/rss-to-podigee-json.rb"]
	spec.executables << 'rss-to-podigee-json'

	spec.required_ruby_version = '>= 1.9.3'
	spec.add_dependency 'feedjira', '~> 2.0'
	spec.add_dependency 'json', '~> 1.7'
end