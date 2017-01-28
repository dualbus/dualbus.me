# - we need --groupmap support in the remote side
# - the remote shell might try to expand * as a glob, so we quote it
# - if you use --groupmap, you have to specify -g for it to work
rsync = rsync \
 --recursive \
 --delete-after --delay-updates \
 -g --usermap \\*:b5f8b5d4153e1ab4 --groupmap \\*:www-data --chmod=ug=rX,o= \
 --compress --progress

build:
	jekyll build
push: build
	$(rsync) _site/ b5f8b5d4153e1ab4:www
serve-draft:
	jekyll serve --drafts --watch 

.PHONY: build push serve-draft
