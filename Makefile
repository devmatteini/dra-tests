build:
	./create-deb.sh
	./create-tar.sh
	./create-zip.sh
	./create-compressed-file.sh
	./create-executable-file.sh

.PHONY: build
