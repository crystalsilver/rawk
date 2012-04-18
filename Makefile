PREFIX := /usr/local
GROUP := bin
TARGET := rawk
VERSION := 1.2.3

all: install

install:
	install -o $(USER) -g $(GROUP) ./rawk $(PREFIX)/bin/rawk
	mkdir -p $(PREFIX)/share/rawk/
	cp -r ./site $(PREFIX)/share/rawk/
	install -o $(USER) -g $(GROUP) ./README $(PREFIX)/share/rawk
	find $(PREFIX)/share/rawk/ -type f -exec chmod 644 '{}' \;
	find $(PREFIX)/share/rawk/ -type d -exec chmod 755 '{}' \;
	install -m 0755 -d $(PREFIX)/share/man/man1
	install -m 0755 -d $(PREFIX)/share/man/man5
	install -o $(USER) -g $(GROUP) -m 0444 rawk.1 $(PREFIX)/share/man/man1/
	install -o $(USER) -g $(GROUP) -m 0444 rawkrc.5 $(PREFIX)/share/man/man5/

remove:
	rm -f  $(PREFIX)/bin/rawk
	rm -rf $(PREFIX)/share/rawk

dist: 
	-find . -iname .\*.\* -print -exec rm {} \;
	-mkdir $(TARGET)-$(VERSION)
	-cp * $(TARGET)-$(VERSION)
	-cp -r site $(TARGET)-$(VERSION)
	-cp -r test $(TARGET)-$(VERSION)
	-tar czf $(TARGET)-$(VERSION).tgz $(TARGET)-$(VERSION)

htmldoc:
	-mandoc -Thtml rawk.1 > rawk.1.html
	-mandoc -Thtml rawkrc.5 > rawkrc.5.html

.PHONY: all remove
