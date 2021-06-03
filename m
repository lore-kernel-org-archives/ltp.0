From: Petr Vorel <pvorel@suse.cz>
Date: Thu,  3 Jun 2021 20:38:25 +0200
Subject: [LTP] [RFC PATCH 1/3] make: Add make check{,-c,-shell} targets
In-Reply-To: <20210603183827.24339-1-pvorel@suse.cz>
References: <20210603183827.24339-1-pvorel@suse.cz>
Message-ID: <20210603183827.24339-2-pvorel@suse.cz>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

For testing C and shell API.

Signed-off-by: Petr Vorel <pvorel@suse.cz>
---
 Makefile                            | 21 ++++++++++++++++++++-
 include/mk/generic_leaf_target.inc  | 25 ++++++++++++++++++++++---
 include/mk/generic_trunk_target.inc |  4 ++--
 lib/newlib_tests/Makefile           |  8 ++++++++
 4 files changed, 52 insertions(+), 6 deletions(-)

diff --git a/Makefile b/Makefile
index 56812d77b..acea4551e 100644
--- a/Makefile
+++ b/Makefile
@@ -75,10 +75,14 @@ endif
 INSTALL_TARGETS		+= $(COMMON_TARGETS)
 CLEAN_TARGETS		+= $(COMMON_TARGETS) lib libs
 BOOTSTRAP_TARGETS	:= $(sort $(COMMON_TARGETS) $(CLEAN_TARGETS) $(INSTALL_TARGETS))
+TEST_TARGETS		:= lib
+TEST_SHELL_TARGETS	:= lib
 
 CLEAN_TARGETS		:= $(addsuffix -clean,$(CLEAN_TARGETS))
 INSTALL_TARGETS		:= $(addsuffix -install,$(INSTALL_TARGETS))
 MAKE_TARGETS		:= $(addsuffix -all,$(filter-out lib,$(COMMON_TARGETS)))
+TEST_TARGETS		:= $(addsuffix -check-c,$(TEST_TARGETS))
+TEST_SHELL_TARGETS	:= $(addsuffix -check-shell,$(TEST_SHELL_TARGETS))
 
 # There's no reason why we should run `all' twice. Otherwise we're just wasting
 # 3+ mins of useful CPU cycles on a modern machine, and even more time on an
@@ -113,6 +117,14 @@ $(filter-out include-clean,$(CLEAN_TARGETS))::
 	-$(MAKE) -C "$(subst -clean,,$@)" \
 		 -f "$(abs_top_srcdir)/$(subst -clean,,$@)/Makefile" clean
 
+$(TEST_TARGETS): lib-all
+	$(MAKE) -C "$(subst -check-c,,$@)" \
+		-f "$(abs_top_srcdir)/$(subst -check-c,,$@)/Makefile" check-c
+
+$(TEST_SHELL_TARGETS):
+	$(MAKE) -C "$(subst -check-shell,,$@)" \
+		-f "$(abs_top_srcdir)/$(subst -check-shell,,$@)/Makefile" check-shell
+
 # Just like everything depends on include-all / -install, we need to get rid
 # of include last to ensure that things won't be monkey screwed up. Only do
 # this if we're invoking clean or a subclean directly though.
@@ -189,8 +201,15 @@ INSTALL_TARGETS		+= $(addprefix $(DESTDIR)/$(bindir)/,$(BINDIR_INSTALL_SCRIPTS))
 
 $(INSTALL_TARGETS): $(INSTALL_DIR) $(DESTDIR)/$(bindir)
 
+.PHONY: check check-c check-shell
+
+## Check
+check-c: $(TEST_TARGETS)
+check-shell: $(TEST_SHELL_TARGETS)
+check: check-c check-shell
+
 ## Install
-install: $(INSTALL_TARGETS)
+install: lib-all $(INSTALL_TARGETS)
 
 ## Help
 .PHONY: help
diff --git a/include/mk/generic_leaf_target.inc b/include/mk/generic_leaf_target.inc
index 64953f89a..d53623456 100644
--- a/include/mk/generic_leaf_target.inc
+++ b/include/mk/generic_leaf_target.inc
@@ -63,8 +63,12 @@
 #				  real files or directories). This will automatically append
 #				  adds the .o suffix to all files referenced by
 #				  $(MAKE_TARGETS)) to CLEAN_TARGETS, if MAKE_TARGETS wasn't
-#				  defined (see
-#				  $(MAKE_TARGETS)).
+#				  defined (see $(MAKE_TARGETS)).
+#
+# $(TEST_TARGETS)		: LTP C API tests.
+#
+# $(TEST_SHELL_TARGETS)		: LTP shell API tests.
+#
 # $(INSTALL_MODE)		: What mode should we using when calling
 # 				  install(1)?
 #
@@ -92,7 +96,7 @@
 # INSTALL_DIR			:= $(libdir)
 #
 
-.PHONY: all clean install
+.PHONY: all check-c check-shell clean install
 
 ifneq ($(strip $(MAKE_TARGETS)),)
 $(MAKE_TARGETS) += $(HOST_MAKE_TARGETS)
@@ -102,6 +106,21 @@ $(MAKE_TARGETS): | $(MAKE_DEPS)
 
 all: $(MAKE_TARGETS)
 
+check-c: $(TEST_TARGETS)
+	@set -e; echo; echo "===== Test C API ====="; \
+	for i in $(TEST_TARGETS); do \
+	    echo; echo "* $$i"; \
+	    echo "PATH $(top_srcdir)/testcases/lib:$$PATH"; \
+	    PATH="$(top_srcdir)/testcases/lib:$$PATH" ./$$i || [ $$? -eq 32 ]; \
+	done
+
+check-shell: $(TEST_SHELL_TARGETS)
+	@set -e; echo; echo "===== Test shell API ====="; \
+	for i in $(TEST_SHELL_TARGETS); do \
+	    echo; echo "* $$i"; \
+	    PATH="$(abs_top_srcdir)/testcases/lib:$(abs_top_builddir)/testcases/lib:$$PATH" $(abs_srcdir)/$$i || [ $$? -eq 32 ]; \
+	done
+
 clean:: $(CLEAN_DEPS)
 	-$(RM) -f -r $(CLEAN_TARGETS)
 
diff --git a/include/mk/generic_trunk_target.inc b/include/mk/generic_trunk_target.inc
index fc59f944f..d195fe3bd 100644
--- a/include/mk/generic_trunk_target.inc
+++ b/include/mk/generic_trunk_target.inc
@@ -48,7 +48,7 @@
 
 include $(top_srcdir)/include/mk/functions.mk
 
-RECURSIVE_TARGETS		?= all install
+RECURSIVE_TARGETS		?= all check check-c check-shell install
 
 $(eval $(get_make_dirs))
 
@@ -71,7 +71,7 @@ trunk-install: $(INSTALL_FILES)
 # Avoid creating duplicate .PHONY references to all, clean, and install. IIRC,
 # I've seen some indeterministic behavior when one does this in the past with
 # GNU Make...
-.PHONY: $(filter-out $(RECURSIVE_TARGETS),all clean install)
+.PHONY: $(filter-out $(RECURSIVE_TARGETS),all check clean install)
 all: trunk-all
 
 clean:: trunk-clean
diff --git a/lib/newlib_tests/Makefile b/lib/newlib_tests/Makefile
index 30ca6810c..182ef5689 100644
--- a/lib/newlib_tests/Makefile
+++ b/lib/newlib_tests/Makefile
@@ -19,5 +19,13 @@ ifeq ($(ANDROID),1)
 FILTER_OUT_MAKE_TARGETS	+= test08
 endif
 
+# C API tests (which exit 0)
+TEST_TARGETS += test0[579] test1[2568] test_exec test_timer
+TEST_TARGETS += tst_bool_expr tst_res_hexd tst_strstatus
+TEST_TARGETS += tst_fuzzy_sync0[1-2]
+
+# shell API tests (which exit 0)
+TEST_SHELL_TARGETS += shell/tst_check_driver.sh
+TEST_SHELL_TARGETS += shell/net/*.sh
 
 include $(top_srcdir)/include/mk/generic_leaf_target.mk
-- 
2.31.1

