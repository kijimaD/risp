publish:
	bundle exec rake release

build:
	bundle exec rake install
repl:
	make build
	risp repl

lint:
	bundle exec rubocop
test:
	bundle exec rspec
