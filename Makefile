.PHONY: test default lint

default: test

test:
	ruby -e 'ARGV.each {|file| require file}' ./test/*/*.rb

lint:
	rubocop libraries/ recipes/ test/ attributes/
