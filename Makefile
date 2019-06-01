# - we need --groupmap support in the remote side
# - the remote shell might try to expand * as a glob, so we quote it
# - if you use --groupmap, you have to specify -g for it to work
rsync = rsync \
 --recursive \
 --delete-after --delay-updates \
 -g --usermap \\*:b5f8b5d4153e1ab4 --groupmap \\*:www-data --chmod=ug=rX,o= \
 --compress --progress

all: clean doctor build push

clean:
	bundle exec jekyll clean
doctor:
	bundle exec jekyll doctor
build:
	bundle exec jekyll build
push: build
	$(rsync) _site/ b5f8b5d4153e1ab4:www
serve-draft:
	bundle exec jekyll serve --drafts --watch

.PHONY: clean doctor build push serve-draft
