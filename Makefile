XCODE_COMMAND=$(shell { command -v xctool || command -v xcodebuild; } 2>/dev/null)
XCODE_NAME=NSErrorRepresentable
XCODE_GENERIC_FLAGS=-project '$(XCODE_NAME).xcodeproj'
XCODE_OSX_FLAGS=-scheme '$(XCODE_NAME)-OSX'
XCODE_IOS_FLAGS=-scheme '$(XCODE_NAME)-iOS'

.PHONY: all clean docs test

all:
	$(XCODE_COMMAND) $(XCODE_GENERIC_FLAGS) $(XCODE_OSX_FLAGS) build
	$(XCODE_COMMAND) $(XCODE_GENERIC_FLAGS) $(XCODE_IOS_FLAGS) build

clean:
	$(XCODE_COMMAND) $(XCODE_GENERIC_FLAGS) $(XCODE_OSX_FLAGS) clean
	$(XCODE_COMMAND) $(XCODE_GENERIC_FLAGS) $(XCODE_IOS_FLAGS) clean

docs:
	jazzy \
		--clean \
		--author "Nate Stedman" \
		--author_url "http://natestedman.com" \
		--github_url "https://github.com/natestedman/$(XCODE_NAME)" \
		--github-file-prefix "https://github.com/natestedman/$(XCODE_NAME)/tree/master" \
		--module-version "0.1.0" \
		--xcodebuild-arguments -scheme,$(XCODE_NAME)-OSX \
		--module $(XCODE_NAME) \
		--output Documentation \
