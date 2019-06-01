# - we need --groupmap support in the remote side
# - the remote shell might try to expand * as a glob, so we quote it
# - if you use --groupmap, you have to specify -g for it to work
rsync = rsync \
 --recursive \
 --delete-after --delay-updates \
 -g --usermap \\*:b5f8b5d4153e1ab4 --groupmap \\*:www-data --chmod=ug=rX,o= \
 --compress --progress

all: clean build

clean:
	bundle exec jekyll clean
doctor:
	bundle exec jekyll doctor
build: doctor
	bundle exec jekyll build
serve-draft:
	bundle exec jekyll serve --drafts --watch

pre-push-check: check-git check-certificate
check-git:
	output=$$(git status --porcelain) && [ -z "$$output" ]
	[ "$$(git rev-parse --abbrev-ref HEAD)" = master ]
check-certificate:
	echo -n | openssl s_client -connect dualbus.me:443 -verify_return_error
check-tls:
	testssl dualbus.me

push: clean build pre-push-check
	$(rsync) _site/ b5f8b5d4153e1ab4:www


.PHONY: \
	check-git \
	check-certificate \
	check-tls \
	pre-push-check \
	build \
	clean \
	doctor \
	push \
	serve-draft
