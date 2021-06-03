From: Richard Palethorpe <rpalethorpe@suse.com>
Date: Thu,  3 Jun 2021 16:48:24 +0100
Subject: [LTP] [RFC PATCH 1/2] Add 'make checks' and clang-checks to build
 system
In-Reply-To: <20210603154825.30165-1-rpalethorpe@suse.com>
References: <20210603154825.30165-1-rpalethorpe@suse.com>
Message-ID: <20210603154825.30165-2-rpalethorpe@suse.com>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

Allows the user to run 'make check' to check all source files or
'make check-<target>' to check one source file corresponding to a
target.

Adds makefile pieces for tools/clang-checks/main which will be a
libclang based tool. By default this is ran by 'make check'.

In theory allows other tools to be specified with
'make CHECK=tool CHECK_FLAGS=<args> check...'. e.g. 'make CHECK=sparse
CHECK_FLAGS= check-tst_cgroup'
---
 configure.ac                       |  2 ++
 include/mk/config.mk.in            |  5 +++++
 include/mk/env_post.mk             |  8 ++++++++
 include/mk/generic_leaf_target.inc |  5 ++++-
 include/mk/lib.mk                  |  3 +++
 include/mk/rules.mk                |  9 +++++++++
 include/mk/testcases.mk            |  1 +
 tools/clang-checks/.gitignore      |  1 +
 tools/clang-checks/Makefile        | 13 +++++++++++++
 9 files changed, 46 insertions(+), 1 deletion(-)
 create mode 100644 tools/clang-checks/.gitignore
 create mode 100644 tools/clang-checks/Makefile

diff --git a/configure.ac b/configure.ac
index 136d82d09..b37c13c3c 100644
--- a/configure.ac
+++ b/configure.ac
@@ -14,6 +14,7 @@ AC_CONFIG_FILES([ \
 ])
 
 AC_ARG_VAR(HOSTCC, [The C compiler on the host])
+AC_ARG_VAR(CLANG, [The LLVM Clang C compiler on the host])
 
 AM_MAINTAINER_MODE([enable])
 
@@ -42,6 +43,7 @@ AC_CHECK_DECLS([SEM_STAT_ANY],,,[#include <sys/sem.h>])
 
 AC_CHECK_HEADERS_ONCE([ \
     asm/ldt.h \
+    clang-c/Index.h \
     ifaddrs.h \
     keyutils.h \
     linux/can.h \
diff --git a/include/mk/config.mk.in b/include/mk/config.mk.in
index 218447ef3..361b6a746 100644
--- a/include/mk/config.mk.in
+++ b/include/mk/config.mk.in
@@ -44,6 +44,11 @@ HOSTCC := cc
 endif
 endif
 
+CLANG := @CLANG@
+ifeq ($(strip $(CLANG)),)
+CLANG := clang
+endif
+
 AIO_LIBS		:= @AIO_LIBS@
 CAP_LIBS		:= @CAP_LIBS@
 ACL_LIBS		:= @ACL_LIBS@
diff --git a/include/mk/env_post.mk b/include/mk/env_post.mk
index 1d22f9c53..13f1104ed 100644
--- a/include/mk/env_post.mk
+++ b/include/mk/env_post.mk
@@ -89,6 +89,14 @@ $(error You must define $$(prefix) before executing install)
 endif # END $(filter-out install,$(MAKECMDGOALS)),$(MAKECMDGOALS)
 endif
 
+CHECK_TARGETS			?= $(addprefix check-,$(MAKE_TARGETS))
+CHECK				?= $(abs_top_srcdir)/tools/clang-checks/main
+CHECK_FLAGS			?= -resource-dir $(shell $(CLANG) -print-resource-dir)
+
+ifeq ($(dir $(CHECK)),$(abs_top_srcdir)/tools/clang-checks/)
+CHECK_DEPS			+= $(CHECK)
+endif
+
 include $(top_srcdir)/include/mk/rules.mk
 
 endif
diff --git a/include/mk/generic_leaf_target.inc b/include/mk/generic_leaf_target.inc
index 64953f89a..aa092a5a3 100644
--- a/include/mk/generic_leaf_target.inc
+++ b/include/mk/generic_leaf_target.inc
@@ -92,7 +92,7 @@
 # INSTALL_DIR			:= $(libdir)
 #
 
-.PHONY: all clean install
+.PHONY: all clean install check
 
 ifneq ($(strip $(MAKE_TARGETS)),)
 $(MAKE_TARGETS) += $(HOST_MAKE_TARGETS)
@@ -109,4 +109,7 @@ $(INSTALL_FILES): | $(INSTALL_DEPS)
 
 install: $(INSTALL_FILES)
 
+$(CHECK_TARGETS): | $(CHECK_DEPS)
+check: $(CHECK_TARGETS)
+
 # vim: syntax=make
diff --git a/include/mk/lib.mk b/include/mk/lib.mk
index f9b6c0aff..f99e63acd 100644
--- a/include/mk/lib.mk
+++ b/include/mk/lib.mk
@@ -26,6 +26,7 @@
 # Makefile to include for libraries.
 
 include $(top_srcdir)/include/mk/env_pre.mk
+include $(top_srcdir)/include/mk/clang-checks.mk
 
 INSTALL_DIR	:= $(libdir)
 
@@ -57,6 +58,8 @@ LIBSRCS		:= $(filter-out $(FILTER_OUT_LIBSRCS),$(LIBSRCS))
 
 LIBOBJS		:= $(LIBSRCS:.c=.o)
 
+CHECK_TARGETS	:= $(addprefix check-,$(notdir $(LIBSRCS:.c=)))
+
 $(LIB): $(notdir $(LIBOBJS))
 	@if [ -z "$(strip $^)" ] ; then \
 		echo "Cowardly refusing to create empty archive"; \
diff --git a/include/mk/rules.mk b/include/mk/rules.mk
index c8f4bbbbe..2a04b2b67 100644
--- a/include/mk/rules.mk
+++ b/include/mk/rules.mk
@@ -37,3 +37,12 @@ else
 	@$(CC) $(CPPFLAGS) $(CFLAGS) $(LDFLAGS) $^ $(LTPLDLIBS) $(LDLIBS) -o $@
 	@echo CC $(target_rel_dir)$@
 endif
+
+.PHONY: $(CHECK_TARGETS)
+$(CHECK_TARGETS): check-%: %.c
+ifdef VERBOSE
+	$(CHECK) $(CHECK_FLAGS) $(CPPFLAGS) $(CFLAGS) $<
+else
+	@$(CHECK) $(CHECK_FLAGS) $(CPPFLAGS) $(CFLAGS) $<
+	@echo CHECK $(target_rel_dir)$<
+endif
diff --git a/include/mk/testcases.mk b/include/mk/testcases.mk
index 1c81773d0..32b3b0f84 100644
--- a/include/mk/testcases.mk
+++ b/include/mk/testcases.mk
@@ -22,6 +22,7 @@
 
 include $(top_srcdir)/include/mk/env_pre.mk
 include $(top_srcdir)/include/mk/functions.mk
+include $(top_srcdir)/include/mk/clang-checks.mk
 
 APICMDS_DIR	:= $(abs_top_builddir)/tools/apicmds
 
diff --git a/tools/clang-checks/.gitignore b/tools/clang-checks/.gitignore
new file mode 100644
index 000000000..ba2906d06
--- /dev/null
+++ b/tools/clang-checks/.gitignore
@@ -0,0 +1 @@
+main
diff --git a/tools/clang-checks/Makefile b/tools/clang-checks/Makefile
new file mode 100644
index 000000000..f132ba527
--- /dev/null
+++ b/tools/clang-checks/Makefile
@@ -0,0 +1,13 @@
+# SPDX-License-Identifier: GPL-2.0-or-later
+# Copyright (c) 2019 Cyril Hrubis <chrubis@suse.cz>
+# Copyright (c) 2020 Petr Vorel <pvorel@suse.cz>
+
+top_srcdir		?= ../..
+
+include $(top_srcdir)/include/mk/env_pre.mk
+include $(top_srcdir)/include/mk/functions.mk
+
+HOST_MAKE_TARGETS	:= main
+HOST_LDFLAGS 		+= -lclang
+
+include $(top_srcdir)/include/mk/generic_leaf_target.mk
-- 
2.31.1

