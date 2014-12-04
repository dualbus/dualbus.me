rsync = rsync \
 --recursive \
 --delete-after --delay-updates \
 --no-p --no-g --chmod=ug=rX,o= \
 --compress --progress

build:
	jekyll build
push: build
	$(rsync) _site/ dualbus.me:public_html/
