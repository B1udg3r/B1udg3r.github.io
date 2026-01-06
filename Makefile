.PHONY: setup serve build clean draft

setup:
	bundle install
	pre-commit install
	@echo "Blog Environment Ready."

serve:
	bundle exec jekyll serve --livereload --drafts

build:
	bundle exec jekyll build

clean:
	bundle exec jekyll clean
	rm -rf _site

# Usage: make draft NAME="my-new-finding"
draft:
	@bash scripts/create_draft.sh "$(NAME)"
