
# makefile for doing a trial build of the dockerfile

IMG=phlummox/gitpod-android-studio:0.1

build:
	docker build -t $(IMG) .

