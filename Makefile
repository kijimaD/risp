publish:
	rake release

build:
	rake install
repl:
	make build
	risp repl

lint:
	bundle exec rubocop
test:
	bundle exec rspec
