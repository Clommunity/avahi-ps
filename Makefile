INSTALLDIR = $(DESTDIR)

all:
	@echo "Nothing here"

install:
	mkdir -p $(INSTALLDIR)/usr/sbin
	mkdir -p $(INSTALLDIR)/usr/share/avahi-ps/plugs
	mkdir -p $(INSTALLDIR)/usr/share/avahi-service/files
	mkdir -p $(INSTALLDIR)/etc/cron.d/
	install -m 0755 avahi-ps $(INSTALLDIR)/usr/sbin
	install -m 0755 services/avahi-service $(INSTALLDIR)/usr/sbin	
	install -m 0644 plugs/* $(INSTALLDIR)/usr/share/avahi-ps/plugs/
	install -m 0644 services/files/* $(INSTALLDIR)/usr/share/avahi-service/files/
	install -m 0755 avahi-service.cron $(INSTALLDIR)/etc/cron.d/

uninstall:
	rm -rf $(INSTALLDIR)/usr/share/avahi-ps
	rm -f $(INSTALLDIR)/usr/sbin/avahi-ps
	rm -rf $(INSTALLDIR)/usr/share/avahi-service
	rm -f $(INSTALLDIR)/usr/sbin/avahi-service
	rm -f $(INSTALLDIR)/etc/cron.d/avahi-service.cron


