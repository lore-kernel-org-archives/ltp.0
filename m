From: Petr Vorel <pvorel@suse.cz>
Date: Tue, 24 Sep 2019 20:28:41 +0200
Subject: [LTP] [PATCH] make: Add make check target + run.sh
Message-ID: <20190924182841.4528-1-pvorel@suse.cz>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

run.sh is simple runner which adds

Signed-off-by: Petr Vorel <pvorel@suse.cz>
---
Hi,

this is somehow related to Christian's work on shell tests [1].

run.sh is really simple, I'd like to add more evaluation, but that's
hard as some tests expect to fail (e.g. test01.c).
The approach to add comments which should be parsed cannot be used,
as some tests do output PID (so we'd have to support regexp instead of
simple diff, but that might be a way).

So for both shell and C tests I'd like to check both expected exit value
and the output (or expect output to be none).

Any comments?

Kind regards,
Petr

[1] https://patchwork.ozlabs.org/patch/1151766/

 Makefile                  |  5 ++++-
 lib/Makefile              |  5 +++++
 lib/newlib_tests/Makefile |  6 +++++-
 lib/newlib_tests/run.sh   | 17 +++++++++++++++++
 4 files changed, 31 insertions(+), 2 deletions(-)
 create mode 100755 lib/newlib_tests/run.sh

diff --git a/Makefile b/Makefile
index 768ca4606..e06a7c871 100644
--- a/Makefile
+++ b/Makefile
@@ -83,7 +83,10 @@ all: $(addsuffix -all,$(COMMON_TARGETS)) Version
 
 $(MAKE_TARGETS): lib-all libs-all
 
-.PHONY: include-all include-install
+.PHONY: check include-all include-install
+check:
+	$(MAKE) -C lib/newlib_tests $@
+
 include-install: $(top_builddir)/include/config.h include/mk/config.mk include-all
 
 INSTALL_DIR		:= $(DESTDIR)/$(prefix)
diff --git a/lib/Makefile b/lib/Makefile
index e7fc753da..b8210eb8e 100644
--- a/lib/Makefile
+++ b/lib/Makefile
@@ -20,6 +20,8 @@
 # Ngie Cooper, July 2009
 #
 
+.PHONY: check
+
 top_srcdir		?= ..
 
 include $(top_srcdir)/include/mk/env_pre.mk
@@ -44,3 +46,6 @@ $(pc_file):
 
 include $(top_srcdir)/include/mk/lib.mk
 include $(top_srcdir)/include/mk/generic_trunk_target.mk
+
+check:
+	$(MAKE) -C lib/newlib_tests $@
diff --git a/lib/newlib_tests/Makefile b/lib/newlib_tests/Makefile
index 2fc50160a..c2ede767c 100644
--- a/lib/newlib_tests/Makefile
+++ b/lib/newlib_tests/Makefile
@@ -1,5 +1,7 @@
 top_srcdir		?= ../..
 
+.PHONY: check
+
 include $(top_srcdir)/include/mk/env_pre.mk
 
 CFLAGS			+= -W -Wall
@@ -16,5 +18,7 @@ ifeq ($(ANDROID),1)
 FILTER_OUT_MAKE_TARGETS	+= test08
 endif
 
-
 include $(top_srcdir)/include/mk/generic_leaf_target.mk
+
+check: | $(MAKE_TARGETS)
+	./run.sh
diff --git a/lib/newlib_tests/run.sh b/lib/newlib_tests/run.sh
new file mode 100755
index 000000000..566454106
--- /dev/null
+++ b/lib/newlib_tests/run.sh
@@ -0,0 +1,17 @@
+#!/bin/sh
+
+# blacklist directory content which is not a test
+FILTER_OUT_FILES="$(basename $0) *.c config[0-9]* Makefile test_kconfig"
+
+grep_pattern=
+for i in $(echo $FILTER_OUT_FILES); do
+	grep_pattern="-e $i $grep_pattern"
+done
+
+for i in *; do
+	if ! echo $i | grep -q $grep_pattern; then
+		echo "===== $i ====="
+		./$i
+		echo
+	fi
+done
-- 
2.22.1

