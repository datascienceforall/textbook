.PHONY: help notebooks stage deploy

BLUE=\033[0;34m
NOCOLOR=\033[0m

BOOK_URL=https://www.cs.cornell.edu/courses/cs1380/2018sp/textbook/

help:
	@echo "Please use 'make <target>' where <target> is one of:"
	@echo "  install       to install the plugins needed to build the book."
	@echo "  notebooks     to convert the notebooks to HTML for embedding."
	@echo "  build         to build locally."
	@echo "  serve         to serve locally."
	@echo "  deploy        to deploy the book to the course website."

install:
	gitbook install

notebooks:
	@echo "${BLUE}Converting notebooks to HTML.${NOCOLOR}"
	@echo "${BLUE}=============================${NOCOLOR}"

	python convert_notebooks_to_html_partial.py
	python add_section_numbers_to_book.py

	@echo ""
	@echo "${BLUE}    Done, output is in notebooks-html${NOCOLOR}"

build: notebooks
	gitbook build

serve: notebooks
	gitbook serve

deploy:
	@echo "${BLUE}REMINDER: always 'make build' or 'make serve' before deploying.${NOCOLOR}"
	@echo ""
	@echo "${BLUE}Deploying book to course website.${NOCOLOR}"
	@echo "${BLUE}=================================${NOCOLOR}"
	./deploy.sh
	@echo ""
	@echo "${BLUE}    Done, see book at ${BOOK_URL}.${NOCOLOR}"
