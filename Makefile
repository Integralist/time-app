.PHONY: all run stop clean install uninstall

all:
	./build.sh

run: all stop
	open TimeApp.app

stop:
	killall TimeApp || true

clean: stop
	rm -rf TimeApp.app
	rm -f com.local.TimeApp.plist

install: all
	@echo "Generating launchd plist for current directory: $$(PWD)"
	@echo '<?xml version="1.0" encoding="UTF-8"?>' > com.local.TimeApp.plist
	@echo '<!DOCTYPE plist PUBLIC "-//Apple//DTD PLIST 1.0//EN" "http://www.apple.com/DTDs/PropertyList-1.0.dtd">' >> com.local.TimeApp.plist
	@echo '<plist version="1.0">' >> com.local.TimeApp.plist
	@echo '<dict>' >> com.local.TimeApp.plist
	@echo '    <key>Label</key>' >> com.local.TimeApp.plist
	@echo '    <string>com.local.TimeApp</string>' >> com.local.TimeApp.plist
	@echo '    <key>ProgramArguments</key>' >> com.local.TimeApp.plist
	@echo '    <array>' >> com.local.TimeApp.plist
	@echo '        <string>/usr/bin/open</string>' >> com.local.TimeApp.plist
	@echo '        <string>$$(PWD)/TimeApp.app</string>' >> com.local.TimeApp.plist
	@echo '    </array>' >> com.local.TimeApp.plist
	@echo '    <key>RunAtLoad</key>' >> com.local.TimeApp.plist
	@echo '    <true/>' >> com.local.TimeApp.plist
	@echo '</dict>' >> com.local.TimeApp.plist
	@echo '</plist>' >> com.local.TimeApp.plist
	cp com.local.TimeApp.plist ~/Library/LaunchAgents/
	launchctl load ~/Library/LaunchAgents/com.local.TimeApp.plist

uninstall: stop
	launchctl unload ~/Library/LaunchAgents/com.local.TimeApp.plist || true
	rm -f ~/Library/LaunchAgents/com.local.TimeApp.plist