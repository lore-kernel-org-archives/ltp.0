From: Petr Vorel <pvorel@suse.cz>
Date: Fri, 11 Jun 2021 15:49:59 +0200
Subject: [LTP] [RFC PATCH v2 1/2] Add 'make check' and clang-check to
 build system
In-Reply-To: <20210604111434.21422-2-rpalethorpe@suse.com>
References: <20210604111434.21422-1-rpalethorpe@suse.com>
 <20210604111434.21422-2-rpalethorpe@suse.com>
Message-ID: <YMNqB2j57/b7ESJB@pevik>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

Hi Richie,

> Allows the user to run 'make check' to check all source files or
> 'make check-<target>' to check one source file corresponding to a
> target.

> Adds makefile pieces for tools/clang-check/main which will be a
> libclang based tool. By default this is ran by 'make check'.

> In theory allows other tools to be specified with
> 'make CHECK=tool CHECK_FLAGS=<args> check...'. e.g. 'make CHECK=sparse
> CHECK_FLAGS= check-tst_cgroup'

one more proposal (addition to Metan's fix [1]):
how about to add top level make check target:

diff --git Makefile Makefile
index 56812d77b..b65315618 100644
--- Makefile
+++ Makefile
@@ -79,6 +79,7 @@ BOOTSTRAP_TARGETS	:= $(sort $(COMMON_TARGETS) $(CLEAN_TARGETS) $(INSTALL_TARGETS
 CLEAN_TARGETS		:= $(addsuffix -clean,$(CLEAN_TARGETS))
 INSTALL_TARGETS		:= $(addsuffix -install,$(INSTALL_TARGETS))
 MAKE_TARGETS		:= $(addsuffix -all,$(filter-out lib,$(COMMON_TARGETS)))
+CHECK_TARGETS		:= $(addsuffix -check,testcases lib)
 
 # There's no reason why we should run `all' twice. Otherwise we're just wasting
 # 3+ mins of useful CPU cycles on a modern machine, and even more time on an
@@ -99,6 +100,11 @@ INSTALL_DIR		:= $(abspath $(INSTALL_DIR))
 $(sort $(addprefix $(abs_top_builddir)/,$(BOOTSTRAP_TARGETS)) $(INSTALL_DIR) $(DESTDIR)/$(bindir)):
 	mkdir -m 00755 -p "$@"
 
+$(CHECK_TARGETS):
+	echo "CHECK_TARGETS: $(CHECK_TARGETS)"; \
+	$(MAKE) -C "$(subst -check,,$@)" \
+		-f "$(abs_top_srcdir)/$(subst -check,,$@)/Makefile" all
+
 ## Pattern based subtarget rules.
 lib-install: lib-all
 
@@ -189,6 +195,9 @@ INSTALL_TARGETS		+= $(addprefix $(DESTDIR)/$(bindir)/,$(BINDIR_INSTALL_SCRIPTS))
 
 $(INSTALL_TARGETS): $(INSTALL_DIR) $(DESTDIR)/$(bindir)
 
+## Check
+check: $(CHECK_TARGETS)
+
 ## Install
 install: $(INSTALL_TARGETS)
 
---

Kind regards,
Petr

[1] https://lists.linux.it/pipermail/ltp/2021-June/023017.html
