# - we need --groupmap support in the remote side
# - the remote shell might try to expand * as a glob, so we quote it
# - if you use --groupmap, you have to specify -g for it to work
rsync = rsync \
 --recursive \
 --delete-after --delay-updates \
 -g --usermap \\*:b5f8b5d4153e1ab4 --groupmap \\*:www-data --chmod=ug=rX,o= \
 --compress --progress

all: build

clean: clean-site clean-gems
clean-site:
	-bundle exec jekyll clean
clean-gems:
	-rm -rf .bundle
install: Gemfile Gemfile.lock
	bundle install --path .bundle
doctor: install
	bundle exec jekyll doctor
build: install doctor
	bundle exec jekyll build
build-sdf: install doctor
	bundle exec jekyll build --config _config.yml,_config.sdf.yml
serve-draft: install
	bundle exec jekyll serve --drafts --watch

pre-push-check: check-git check-certificate check-clean-room
check-git:
	output=$$(git status --porcelain) && [ -z "$$output" ]
	[ "$$(git rev-parse --abbrev-ref HEAD)" = master ]
check-certificate:
	echo -n | openssl s_client -connect dualbus.me:443 -verify_return_error
check-tls:
	testssl dualbus.me
check-clean-room:
	docker run --rm -e LANG=en_US.UTF-8 -v "$$(pwd):/src:ro" -t ruby:2.5 /bin/sh -euxc '\
		cp -r /src /wrk; \
		cd /wrk; \
		make clean build build-sdf; \
		'


push: clean build pre-push-check
	$(rsync) _site/ b5f8b5d4153e1ab4:www


.PHONY: \
	build \
	check-certificate \
	check-clean-room \
	check-git \
	check-tls \
	clean \
	clean-gems \
	clean-site \
	doctor \
	pre-push-check \
	push \
	serve-draft
