NAME=gitoriousd
VERSION=0.0.1

DIRS=usr
INSTALL_DIRS=`find $(DIRS) -type d 2>/dev/null`
INSTALL_FILES=`find $(DIRS) -type f 2>/dev/null`

PREFIX?=/
DOC_DIR=$(PREFIX)/share/doc/$(NAME)
DOC_FILES=readme.org

RUN_DIR=$(PREFIX)/var/run/$(NAME)
install:
	for dir in $(INSTALL_DIRS); do mkdir -p $(PREFIX)/$$dir; done
	for file in $(INSTALL_FILES); do install $$file $(PREFIX)/$$file; done
	mkdir -p $(DOC_DIR)
	mkdir -p $(RUN_DIR)
	cp -r $(DOC_FILES) $(DOC_DIR)/

uninstall:
	for file in $(INSTALL_FILES); do rm -f $(PREFIX)/$$file; done
	rm -rf $(DOC_DIR)
