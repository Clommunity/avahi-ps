INSTALLDIR = $(DESTDIR)

all:
	@echo "Nothing here"

install:
	mkdir -p $(INSTALLDIR)/usr/sbin
	mkdir -p $(INSTALLDIR)/usr/share/avahi-ps/plugs
	install -m 0755 avahi-ps $(INSTALLDIR)/usr/sbin
	install -m 0644 plugs/* $(INSTALLDIR)/usr/share/avahi-ps/plugs/

uninstall:
	rm -rf $(INSTALLDIR)/usr/share/avahi-ps
	rm -f $(INSTALLDIR)/usr/sbin/avahi-ps

