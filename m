From: Petr Vorel <pvorel@suse.cz>
Date: Wed,  5 Apr 2017 10:58:20 +0200
Subject: [LTP] [PATCH 1/2] open_posix_testsuite: Fix recursive build
Message-ID: <20170405085821.13121-1-pvorel@suse.cz>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

TODO: Fix make install. This fixes only compile issues, there
are still some data files missing.

Signed-off-by: Petr Vorel <pvorel@suse.cz>
---
 testcases/open_posix_testsuite/Makefile            | 46 +++++++++++-----------
 testcases/open_posix_testsuite/Makefile.linux      |  2 +-
 .../scripts/generate-makefiles.sh                  |  2 +-
 3 files changed, 25 insertions(+), 25 deletions(-)

diff --git a/testcases/open_posix_testsuite/Makefile b/testcases/open_posix_testsuite/Makefile
index 0601fa648..21917ae07 100644
--- a/testcases/open_posix_testsuite/Makefile
+++ b/testcases/open_posix_testsuite/Makefile
@@ -24,9 +24,9 @@ BUILD_MAKE=		env $(BUILD_MAKE_ENV) $(MAKE)
 
 TEST_MAKE=		env $(TEST_MAKE_ENV) $(MAKE) -k
 
-top_srcdir?=		.
+open_posix_srcdir := $(if $(top_srcdir),$(top_srcdir)/testcases/open_posix_testsuite,$(abspath .))
 
-prefix?=		`$(top_srcdir)/scripts/print_prefix.sh`
+prefix?=		`$(open_posix_srcdir)/scripts/print_prefix.sh`
 
 datadir?=		$(prefix)/share
 
@@ -35,13 +35,13 @@ exec_prefix?=		$(prefix)
 all: conformance-all functional-all stress-all tools-all
 
 ifeq ($(shell uname -s), Linux)
-include Makefile.linux
+include $(open_posix_srcdir)/Makefile.linux
 endif
 
 clean: $(CRITICAL_MAKEFILE)
 	@rm -f $(LOGFILE)*
 	@for dir in $(SUBDIRS) tools; do \
-	    $(MAKE) -C $$dir clean >/dev/null; \
+	    $(MAKE) -C $(open_posix_srcdir)/$$dir clean >/dev/null; \
 	done
 
 distclean: distclean-makefiles
@@ -49,12 +49,12 @@ distclean: distclean-makefiles
 # Clean out all of the generated Makefiles.
 distclean-makefiles:
 	@for dir in $(SUBDIRS); do \
-		$(MAKE) -C $$dir $@; \
+		$(MAKE) -C $(open_posix_srcdir)/$$dir $@; \
 	done
 
 generate-makefiles: distclean-makefiles
-	@env top_srcdir=$(top_srcdir) \
-	    $(top_srcdir)/scripts/generate-makefiles.sh
+	@env top_srcdir=$(open_posix_srcdir) \
+	    $(open_posix_srcdir)/scripts/generate-makefiles.sh
 
 install: bin-install conformance-install functional-install stress-install
 
@@ -63,47 +63,47 @@ test: conformance-test functional-test stress-test
 # Test build and execution targets.
 conformance-all: $(CRITICAL_MAKEFILE)
 	@rm -f `if echo "$(LOGFILE)" | grep -q '^/'; then echo "$(LOGFILE)"; else echo "\`pwd\`/$(LOGFILE)"; fi`.$@
-	@$(BUILD_MAKE) -C conformance -j1 all
+	@$(BUILD_MAKE) -C $(open_posix_srcdir)/conformance -j1 all
 
 conformance-install:
-	@$(MAKE) -C conformance install
+	@$(MAKE) -C $(open_posix_srcdir)/conformance install
 
 conformance-test:
 	@rm -f `if echo "$(LOGFILE)" | grep -q '^/'; then echo "$(LOGFILE)"; else echo "\`pwd\`/$(LOGFILE)"; fi`.$@
-	@$(TEST_MAKE) -C conformance test
+	@$(TEST_MAKE) -C $(open_posix_srcdir)/conformance test
 
 functional-all: $(CRITICAL_MAKEFILE)
 	@rm -f `if echo "$(LOGFILE)" | grep -q '^/'; then echo "$(LOGFILE)"; else echo "\`pwd\`/$(LOGFILE)"; fi`.$@
-	@$(BUILD_MAKE) -C functional -j1 all
+	@$(BUILD_MAKE) -C $(open_posix_srcdir)/functional -j1 all
 
 functional-install:
-	@$(MAKE) -C functional install
+	@$(MAKE) -C $(open_posix_srcdir)/functional install
 
 functional-test:
 	@rm -f `if echo "$(LOGFILE)" | grep -q '^/'; then echo "$(LOGFILE)"; else echo "\`pwd\`/$(LOGFILE)"; fi`.$@
-	@$(TEST_MAKE) -C functional test
+	@$(TEST_MAKE) -C $(open_posix_srcdir)/functional test
 
 stress-all: $(CRITICAL_MAKEFILE)
 	@rm -f `if echo "$(LOGFILE)" | grep -q '^/'; then echo "$(LOGFILE)"; else echo "\`pwd\`/$(LOGFILE)"; fi`.$@
-	@$(BUILD_MAKE) -C stress -j1 all
+	@$(BUILD_MAKE) -C $(open_posix_srcdir)/stress -j1 all
 
 stress-install:
-	@$(MAKE) -C stress install
+	@$(MAKE) -C $(open_posix_srcdir)/stress install
 
 stress-test:
 	@rm -f `if echo "$(LOGFILE)" | grep -q '^/'; then echo "$(LOGFILE)"; else echo "\`pwd\`/$(LOGFILE)"; fi`.$@
-	@$(TEST_MAKE) -C stress test
+	@$(TEST_MAKE) -C $(open_posix_srcdir)/stress test
 
 # Tools build and install targets.
 bin-install:
-	@$(MAKE) -C bin install
+	@$(MAKE) -C $(open_posix_srcdir)/bin install
 
 tools-all:
-	@$(MAKE) -C tools all
+	@$(MAKE) -C $(open_posix_srcdir)/tools all top_srcdir=$(open_posix_srcdir)
 
 $(CRITICAL_MAKEFILE): \
-    $(top_srcdir)/scripts/generate-makefiles.sh	\
-    $(top_srcdir)/CFLAGS			\
-    $(top_srcdir)/LDFLAGS			\
-    $(top_srcdir)/LDLIBS
-	@$(MAKE) generate-makefiles
+    $(open_posix_srcdir)/scripts/generate-makefiles.sh	\
+    $(open_posix_srcdir)/CFLAGS			\
+    $(open_posix_srcdir)/LDFLAGS			\
+    $(open_posix_srcdir)/LDLIBS
+	@$(MAKE) -f $(open_posix_srcdir)/Makefile generate-makefiles
diff --git a/testcases/open_posix_testsuite/Makefile.linux b/testcases/open_posix_testsuite/Makefile.linux
index 77e20a958..adef565a8 100644
--- a/testcases/open_posix_testsuite/Makefile.linux
+++ b/testcases/open_posix_testsuite/Makefile.linux
@@ -8,7 +8,7 @@ cmd_disable = @set -e; \
 
 BROKEN :=
 
-kver_cmp = $(shell $(top_srcdir)/scripts/tst_kvercmp.sh 2 6 22)
+kver_cmp = $(shell $(open_posix_srcdir)/scripts/tst_kvercmp.sh 2 6 22)
 ifeq ($(kver_cmp), 1)
 BROKEN += t_sigaction_16-1
 endif
diff --git a/testcases/open_posix_testsuite/scripts/generate-makefiles.sh b/testcases/open_posix_testsuite/scripts/generate-makefiles.sh
index 67a60c8cb..d50d517ae 100755
--- a/testcases/open_posix_testsuite/scripts/generate-makefiles.sh
+++ b/testcases/open_posix_testsuite/scripts/generate-makefiles.sh
@@ -22,7 +22,7 @@ generate_locate_test_makefile() {
 
 	echo "Generating $maketype Makefiles"
 
-	locate-test --$maketype | sed -e 's,^./,,g' > make-gen.$maketype
+	locate-test --$maketype $top_srcdir | sed -e 's,^./,,g' > make-gen.$maketype
 
 	generate_makefiles make-gen.$maketype $*
 
-- 
2.12.0

