packages = CuteGayBitterFont CuteGayShantellSansFont
all: $(packages)
$(packages):
	make -C $@
	cp -f $@/$@.apk .
clean:
	@for dir in $(packages); do \
		make -C $$dir clean; \
	done
distclean: clean
	@for dir in $(packages); do \
		make -C $$dir distclean; \
	done
	rm -f *.apk
.PHONY: all $(packages) clean distclean
