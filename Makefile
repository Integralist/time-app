.PHONY: all run stop clean

all:
	./build.sh

run: all stop
	open TimeApp.app

stop:
	killall TimeApp || true

clean: stop
	rm -rf TimeApp.app