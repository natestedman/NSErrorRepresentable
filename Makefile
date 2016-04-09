BASE_NAME=NSErrorRepresentable
XCODE_COMMAND=$(shell { command -v xctool || command -v xcodebuild; } 2>/dev/null)
XCODE_GENERIC_FLAGS=-project '$(BASE_NAME).xcodeproj'
XCODE_OSX_FLAGS=-scheme "$(BASE_NAME)-OSX"
XCODE_IOS_FLAGS=-scheme "$(BASE_NAME)-iOS"

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
		--github_url "https://github.com/natestedman/$(BASE_NAME)" \
		--github-file-prefix "https://github.com/natestedman/$(BASE_NAME)/tree/master" \
		--xcodebuild-arguments -scheme,$(BASE_NAME)-OSX \
		--module $(BASE_NAME) \
		--output Documentation

test:
	xcodebuild $(XCODE_GENERIC_FLAGS) $(XCODE_OSX_FLAGS) test
