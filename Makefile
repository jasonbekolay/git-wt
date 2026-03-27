PREFIX ?= /usr/local
BINDIR = $(PREFIX)/bin
BASH_COMPLETION_DIR ?= $(PREFIX)/etc/bash_completion.d
ZSH_COMPLETION_DIR ?= $(PREFIX)/share/zsh/site-functions

.PHONY: install install-alias install-completions uninstall test

install: install-completions
	install -d $(BINDIR)
	install -m 755 git-wt $(BINDIR)/git-wt

install-alias: install
	ln -sf $(BINDIR)/git-wt $(BINDIR)/wt

install-completions:
	install -d $(BASH_COMPLETION_DIR)
	install -m 644 completions/git-wt.bash $(BASH_COMPLETION_DIR)/git-wt
	install -d $(ZSH_COMPLETION_DIR)
	install -m 644 completions/git-wt.zsh $(ZSH_COMPLETION_DIR)/_git-wt

uninstall:
	rm -f $(BINDIR)/git-wt
	rm -f $(BINDIR)/wt
	rm -f $(BASH_COMPLETION_DIR)/git-wt
	rm -f $(ZSH_COMPLETION_DIR)/_git-wt

test:
	bats test/
