From: Petr Vorel <pvorel@suse.cz>
Date: Fri, 18 Jun 2021 21:12:52 +0200
Subject: [LTP] [RFC PATCH v2 1/1] make: Add make test{, -c, -c-run,
 -shell-run} targets
Message-ID: <20210618191252.12403-1-pvorel@suse.cz>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

For testing C and shell API.

Signed-off-by: Petr Vorel <pvorel@suse.cz>
---
Hi all,

another attempt for make test target.

In a long term, I'd like to wrap the execution with some script, as I
suppose there will be some metadata in test, allowing to run tests which
don't TPASS or TBROK (we have quite a lot of them). Then the summary
would be even more useful.

FIXME: broken in lib/, it runs all test twice.

changes v1->v2:
Not sure if it's a good approach to process each test separately,
there is no loop as Cyril suggested in [1], thus there is no summary
what happen.

I previously had in similar loop in include/mk/generic_leaf_target.inc:

test-c-run: $(TEST_TARGETS)
	@set -e; echo; echo "===== Test C API ====="; \
	for i in $(TEST_TARGETS); do \
	    echo; echo "* $$i"; \
	    echo "PATH $(top_srcdir)/testcases/lib:$$PATH"; \
	    PATH="$(top_srcdir)/testcases/lib:$$PATH" ./$$i || [ $$? -eq 32 ]; \
	done; echo; \
	echo "All C API tests passed or TCONF"

test-shell-run:
	@set -e; echo; echo "===== Test shell API ====="; \
	for i in $(TEST_SHELL_TARGETS); do \
	    echo; echo "* $$i"; \
	    PATH="$(abs_top_srcdir)/testcases/lib:$(abs_top_builddir)/testcases/lib:$$PATH" $(abs_srcdir)/$$i || [ $$? -eq 32 ]; \
	done; echo; \
	echo "All shell API tests passed or TCONF"

but that was problematic in lib (which uses generic_leaf_target.inc).

Kind regards,
Petr

[1] https://patchwork.ozlabs.org/project/ltp/patch/20210603183827.24339-2-pvorel@suse.cz/#2695533

 Makefile                            | 23 ++++++++++++++++++++++-
 include/mk/generic_leaf_target.inc  | 25 ++++++++++++++++++++++---
 include/mk/generic_trunk_target.inc |  2 +-
 lib/newlib_tests/Makefile           | 13 +++++++++++++
 4 files changed, 58 insertions(+), 5 deletions(-)

diff --git a/Makefile b/Makefile
index 56812d77b..40cd4b1cb 100644
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
+TEST_TARGETS		:= $(addsuffix -test-c-run,$(TEST_TARGETS))
+TEST_SHELL_TARGETS	:= $(addsuffix -test-shell-run,$(TEST_SHELL_TARGETS))
 
 # There's no reason why we should run `all' twice. Otherwise we're just wasting
 # 3+ mins of useful CPU cycles on a modern machine, and even more time on an
@@ -189,8 +193,25 @@ INSTALL_TARGETS		+= $(addprefix $(DESTDIR)/$(bindir)/,$(BINDIR_INSTALL_SCRIPTS))
 
 $(INSTALL_TARGETS): $(INSTALL_DIR) $(DESTDIR)/$(bindir)
 
+## Test library API
+.PHONY: test test-c test-c-run test-shell-run
+
+$(TEST_TARGETS): lib-all
+	$(MAKE) -C "$(subst -test-c-run,,$@)" \
+		-f "$(abs_top_srcdir)/$(subst -test-c-run,,$@)/Makefile" test-c-run
+
+$(TEST_SHELL_TARGETS): lib-all
+	$(MAKE) -C "$(subst -test-shell-run,,$@)" \
+		-f "$(abs_top_srcdir)/$(subst -test-shell-run,,$@)/Makefile" test-shell-run
+
+test-c-run: $(TEST_TARGETS)
+
+test-shell-run: $(TEST_SHELL_TARGETS)
+
+test: test-c test-c-run test-shell-run
+
 ## Install
-install: $(INSTALL_TARGETS)
+install: lib-all $(INSTALL_TARGETS)
 
 ## Help
 .PHONY: help
diff --git a/include/mk/generic_leaf_target.inc b/include/mk/generic_leaf_target.inc
index 64953f89a..19e238f92 100644
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
+# $(TEST_TARGETS)		: LTP C API tests to be runned with test-c-run.
+#
+# $(TEST_SHELL_TARGETS)		: LTP shell API tests to be runned with test-shell-run.
+#
 # $(INSTALL_MODE)		: What mode should we using when calling
 # 				  install(1)?
 #
@@ -92,7 +96,7 @@
 # INSTALL_DIR			:= $(libdir)
 #
 
-.PHONY: all clean install
+.PHONY: all clean install test test-c test-c-run test-shell-run
 
 ifneq ($(strip $(MAKE_TARGETS)),)
 $(MAKE_TARGETS) += $(HOST_MAKE_TARGETS)
@@ -102,11 +106,26 @@ $(MAKE_TARGETS): | $(MAKE_DEPS)
 
 all: $(MAKE_TARGETS)
 
+TEST_TARGETS_RUN := $(addsuffix -run,$(TEST_TARGETS))
+TEST_SHELL_TARGETS_RUN := $(addsuffix -run,$(TEST_SHELL_TARGETS))
+
+$(TEST_TARGETS_RUN): | $(TEST_TARGETS)
+test-c-run: $(TEST_TARGETS_RUN)
+test-shell-run: $(TEST_SHELL_TARGETS_RUN)
+
+.PHONY: $(TEST_TARGETS_RUN) $(TEST_SHELL_TARGETS_RUN)
+$(TEST_TARGETS_RUN) $(TEST_SHELL_TARGETS_RUN):
+	@set -e; echo; echo "* $(subst -run,,$@)"; \
+	PATH="$(top_srcdir)/testcases/lib:$$PATH" ./$(subst -run,,$@) || [ $$? -eq 32 ]; \
+
+test: test-c-run test-shell-run
+
 clean:: $(CLEAN_DEPS)
 	-$(RM) -f -r $(CLEAN_TARGETS)
 
 $(INSTALL_FILES): | $(INSTALL_DEPS)
 
 install: $(INSTALL_FILES)
+test-c: $(TEST_TARGETS)
 
 # vim: syntax=make
diff --git a/include/mk/generic_trunk_target.inc b/include/mk/generic_trunk_target.inc
index fc59f944f..4427a0f86 100644
--- a/include/mk/generic_trunk_target.inc
+++ b/include/mk/generic_trunk_target.inc
@@ -48,7 +48,7 @@
 
 include $(top_srcdir)/include/mk/functions.mk
 
-RECURSIVE_TARGETS		?= all install
+RECURSIVE_TARGETS		?= all install test test-c test-c-run test-shell-run
 
 $(eval $(get_make_dirs))
 
diff --git a/lib/newlib_tests/Makefile b/lib/newlib_tests/Makefile
index 30ca6810c..7ac28660d 100644
--- a/lib/newlib_tests/Makefile
+++ b/lib/newlib_tests/Makefile
@@ -19,5 +19,18 @@ ifeq ($(ANDROID),1)
 FILTER_OUT_MAKE_TARGETS	+= test08
 endif
 
+# C API tests
+# NOTE: only those which exit 0 (TPASS) or 32 (TCONF)
+# TODO: commented out for quicker demonstration
+# TEST_TARGETS += test05 test07 test09 test12 test15 test16 test18
+# TEST_TARGETS += test_exec test_timer tst_bool_expr tst_res_hexd
+# TEST_TARGETS += tst_strstatus tst_fuzzy_sync01 tst_fuzzy_sync02
+TEST_TARGETS += tst_strstatus test05
+
+# shell API tests
+# NOTE: only those which exit 0 (TPASS) or 32 (TCONF)
+TEST_SHELL_TARGETS += shell/tst_check_driver.sh
+# TODO: commented out for quicker demonstration
+# TEST_SHELL_TARGETS += shell/net/*.sh
 
 include $(top_srcdir)/include/mk/generic_leaf_target.mk
-- 
2.32.0

