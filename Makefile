#
# Common puppet tasks.
#
# author: Thomas Van Doren
#

ECHO=@echo
PUPPET=puppet
RAKE=@rake

.PHONY: help
help:
	$(ECHO) "make <target>"
	$(ECHO) ""
	$(ECHO) "    Common puppet tasks."
	$(ECHO) ""
	$(ECHO) "    check - parse and validate all manifests."
	$(ECHO) ""
	$(ECHO) "    build - build the tar ball for puppet forge."
	$(ECHO) ""
	$(ECHO) "    clean - remote build status."
	$(ECHO) ""
	$(ECHO) "    help  - print this help page."
	$(ECHO) ""

.PHONY: check
check:
	$(RAKE) || true
	@find . -type f -name '*.pp' -exec $(PUPPET) parser validate {} ';'
	@find tests -type f -name '*.pp' -exec $(PUPPET) apply --noop --verbose {} ';'

.PHONY: build
build:
	$(PUPPET) module build .

.PHONY: clean
clean:
	$(RM) -fr pkg
