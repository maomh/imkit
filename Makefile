EXECUTABLE_NAME = imkit
ZSH_COMPLETION_DIR = /usr/local/share/zsh/site-functions
ZSH_COMPLETION_PATH = $(ZSH_COMPLETION_DIR)/_$(EXECUTABLE_NAME)

build:
	swift build -c release

dev:
	swift build

update:
	swift package update

install:
	cp -f .build/release/$(EXECUTABLE_NAME) /usr/local/bin/$(EXECUTABLE_NAME)
	[ -d $(ZSH_COMPLETION_DIR) ] || mkdir -p $(ZSH_COMPLETION_DIR) && cp -f $(EXECUTABLE_NAME).zsh-completion $(ZSH_COMPLETION_PATH)	

uninstall:
	rm -f /usr/local/bin/$(EXECUTABLE_NAME)
	rm -f $(ZSH_COMPLETION_PATH)

clean:
	rm -rf .build
