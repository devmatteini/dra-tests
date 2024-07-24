build:
	./create-deb.sh
	./create-tar.sh
	./create-zip.sh
	./create-compressed-file.sh

.PHONY: build
