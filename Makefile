.PHONY: all run stop clean install uninstall

all:
	./build.sh

run: all stop
	open TimeApp.app

stop:
	killall TimeApp || true

clean: stop
	rm -rf TimeApp.app

install: all
	cp com.local.TimeApp.plist ~/Library/LaunchAgents/
	launchctl load ~/Library/LaunchAgents/com.local.TimeApp.plist

uninstall: stop
	launchctl unload ~/Library/LaunchAgents/com.local.TimeApp.plist || true
	rm -f ~/Library/LaunchAgents/com.local.TimeApp.plist