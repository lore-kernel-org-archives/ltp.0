From: Cyril Hrubis <chrubis@suse.cz>
Date: Fri,  8 Mar 2019 13:42:56 +0100
Subject: [LTP] [PATCH 1/2 v2] Fix build with libnuma-dev on some
	distributions
Message-ID: <20190308124257.25282-1-chrubis@suse.cz>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

On some distributions when libnuma-dev is installed the tst_numa.o,
which was added to libltp.a pulls in symbols from numa library to random
unrealted tests which breaks the build.

This commit hence moves the tst_numa to a separate libltpnuma.a library
that is used for linking only for tests that actually use it and link
with -lnuma.

It also adds a libs/ directory to the top level directory which is
intended to collect all possible library code that is used from
different tests but couldn't be included in the main library.

Signed-off-by: Cyril Hrubis <chrubis@suse.cz>
CC: Jan Stancek <jstancek@redhat.com>
CC: Petr Vorel <pvorel@suse.cz>
---
 Makefile                                         |  6 +++---
 libs/Makefile                                    |  8 ++++++++
 libs/libltpnuma/Makefile                         | 12 ++++++++++++
 {lib => libs/libltpnuma}/tst_numa.c              |  0
 testcases/kernel/syscalls/set_mempolicy/Makefile |  3 ++-
 5 files changed, 25 insertions(+), 4 deletions(-)
 create mode 100644 libs/Makefile
 create mode 100644 libs/libltpnuma/Makefile
 rename {lib => libs/libltpnuma}/tst_numa.c (100%)

diff --git a/Makefile b/Makefile
index bcadd21b2..bc6e9a3e0 100644
--- a/Makefile
+++ b/Makefile
@@ -77,7 +77,7 @@ INSTALL_TARGETS		+= runtest scenario_groups testscripts
 CLEAN_TARGETS		+= include runtest scenario_groups testscripts
 endif
 INSTALL_TARGETS		+= $(COMMON_TARGETS)
-CLEAN_TARGETS		+= $(COMMON_TARGETS) lib
+CLEAN_TARGETS		+= $(COMMON_TARGETS) lib libs
 BOOTSTRAP_TARGETS	:= $(sort $(COMMON_TARGETS) $(CLEAN_TARGETS) $(INSTALL_TARGETS))
 
 CLEAN_TARGETS		:= $(addsuffix -clean,$(CLEAN_TARGETS))
@@ -89,7 +89,7 @@ MAKE_TARGETS		:= $(addsuffix -all,$(filter-out lib,$(COMMON_TARGETS)))
 # overtaxed one, or one where -j => 1 was specified.
 all: $(addsuffix -all,$(COMMON_TARGETS)) Version
 
-$(MAKE_TARGETS): lib-all
+$(MAKE_TARGETS): lib-all libs-all
 
 .PHONY: include-all include-install
 include-install: $(top_builddir)/include/config.h include/mk/config.mk include-all
@@ -110,7 +110,7 @@ $(sort $(addprefix $(abs_top_builddir)/,$(BOOTSTRAP_TARGETS)) $(INSTALL_DIR) $(D
 ## Pattern based subtarget rules.
 lib-install: lib-all
 
-$(MAKE_TARGETS) include-all lib-all:
+$(MAKE_TARGETS) include-all lib-all libs-all:
 	$(MAKE) -C "$(subst -all,,$@)" \
 		-f "$(abs_top_srcdir)/$(subst -all,,$@)/Makefile" all
 
diff --git a/libs/Makefile b/libs/Makefile
new file mode 100644
index 000000000..16ed3aa6d
--- /dev/null
+++ b/libs/Makefile
@@ -0,0 +1,8 @@
+# SPDX-License-Identifier: GPL-2.0-or-later
+#
+# Copyright (C) Cyril Hrubis <chrubis@suse.cz>
+
+top_srcdir		?= ..
+
+include $(top_srcdir)/include/mk/env_pre.mk
+include $(top_srcdir)/include/mk/generic_trunk_target.mk
diff --git a/libs/libltpnuma/Makefile b/libs/libltpnuma/Makefile
new file mode 100644
index 000000000..56d6b7762
--- /dev/null
+++ b/libs/libltpnuma/Makefile
@@ -0,0 +1,12 @@
+# SPDX-License-Identifier: GPL-2.0-or-later
+#
+# Copyright (C) Cyril Hrubis <chrubis@suse.cz>
+
+top_srcdir		?= ../..
+
+include $(top_srcdir)/include/mk/env_pre.mk
+
+LIB			:= libltpnuma.a
+
+include $(top_srcdir)/include/mk/lib.mk
+include $(top_srcdir)/include/mk/generic_leaf_target.mk
diff --git a/lib/tst_numa.c b/libs/libltpnuma/tst_numa.c
similarity index 100%
rename from lib/tst_numa.c
rename to libs/libltpnuma/tst_numa.c
diff --git a/testcases/kernel/syscalls/set_mempolicy/Makefile b/testcases/kernel/syscalls/set_mempolicy/Makefile
index d273b432b..b79a53faf 100644
--- a/testcases/kernel/syscalls/set_mempolicy/Makefile
+++ b/testcases/kernel/syscalls/set_mempolicy/Makefile
@@ -2,6 +2,7 @@ top_srcdir		?= ../../../..
 
 include $(top_srcdir)/include/mk/testcases.mk
 
-LDLIBS  += $(NUMA_LIBS)
+LDFLAGS += -L$(top_builddir)/libs/libltpnuma
+LDLIBS  += $(NUMA_LIBS) -lltpnuma
 
 include $(top_srcdir)/include/mk/generic_leaf_target.mk
-- 
2.19.2

