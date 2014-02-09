INSTALLDIR = $(DESTDIR)

all:
	@echo "Nothing here"

install:
	mkdir -p $(INSTALLDIR)/usr/bin
	mkdir -p $(INSTALLDIR)/usr/share/avahi-ps/plugs
	install -m 0755 avahi-ps $(INSTALLDIR)/usr/bin
	install -m 0644 plugs/* $(INSTALLDIR)/usr/share/avahi-ps/plugs/

uninstall:
	rm -rf $(INSTALLDIR)/usr/share/avahi-ps
	rm -f $(INSTALLDIR)/usr/bin/avahi-ps

