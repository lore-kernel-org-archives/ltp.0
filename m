From: Petr Vorel <pvorel@suse.cz>
Date: Tue,  3 Nov 2020 20:13:17 +0100
Subject: [LTP] [PATCH v2 01/11] make: Support compiling native build tools
In-Reply-To: <20201103191327.11081-1-pvorel@suse.cz>
References: <20201103191327.11081-1-pvorel@suse.cz>
Message-ID: <20201103191327.11081-2-pvorel@suse.cz>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

Add HOST_MAKE_TARGETS make target and HOSTCC,
HOST_{CFLAGS,LDFLAGS} make variables.

Needed for cross-compilation.

NOTE: detect cross compilation with comparing $(build) and $(host)
instead of using $cross_compiling configure variable, which would
require move the detection into m4 macro.

Signed-off-by: Petr Vorel <pvorel@suse.cz>
Reviewed-by: Cyril Hrubis <chrubis@suse.cz>
---
 configure.ac                       |  2 ++
 include/mk/config.mk.in            | 21 +++++++++++++++++++++
 include/mk/env_post.mk             |  3 +--
 include/mk/generic_leaf_target.inc |  6 ++++++
 include/mk/rules.mk                |  8 ++++++++
 5 files changed, 38 insertions(+), 2 deletions(-)

diff --git a/configure.ac b/configure.ac
index 03e4e09c9..05672f8f6 100644
--- a/configure.ac
+++ b/configure.ac
@@ -13,6 +13,8 @@ AC_CONFIG_FILES([ \
     execltp \
 ])
 
+AC_ARG_VAR(HOSTCC, [The C compiler on the host])
+
 AM_MAINTAINER_MODE([enable])
 
 AC_CANONICAL_HOST
diff --git a/include/mk/config.mk.in b/include/mk/config.mk.in
index 427608a17..8f73a6a34 100644
--- a/include/mk/config.mk.in
+++ b/include/mk/config.mk.in
@@ -31,6 +31,19 @@ RANLIB			:= @RANLIB@
 STRIP			:= @STRIP@
 YACC			:= @YACC@
 
+HOSTCC  = @HOSTCC@
+build := @build@
+host := @host@
+ifeq ($(strip $(HOSTCC)),)
+# native build, respect CC
+ifeq ($(build),$(host))
+HOSTCC := $(CC)
+else
+# cross compilation
+HOSTCC := cc
+endif
+endif
+
 AIO_LIBS		:= @AIO_LIBS@
 CAP_LIBS		:= @CAP_LIBS@
 ACL_LIBS		:= @ACL_LIBS@
@@ -70,6 +83,14 @@ WCFLAGS			?= -Wall -W @GCC_WARN_OLDSTYLE@
 LDFLAGS			+= $(WLDFLAGS)
 CFLAGS			+= $(DEBUG_CFLAGS) $(OPT_CFLAGS) $(WCFLAGS)
 
+ifeq ($(strip $(HOST_CFLAGS)),)
+HOST_CFLAGS := $(CFLAGS)
+endif
+
+ifeq ($(strip $(HOST_LDFLAGS)),)
+HOST_LDFLAGS := $(LDFLAGS)
+endif
+
 LINUX_VERSION		:= @LINUX_VERSION@
 LINUX_DIR		:= @LINUX_DIR@
 LINUX_VERSION_MAJOR	:= @LINUX_VERSION_MAJOR@
diff --git a/include/mk/env_post.mk b/include/mk/env_post.mk
index 44a333198..d52ad9f0b 100644
--- a/include/mk/env_post.mk
+++ b/include/mk/env_post.mk
@@ -48,11 +48,10 @@ LDFLAGS				+= -L$(top_builddir)/lib/android_librt
 endif
 
 MAKE_TARGETS			?= $(notdir $(patsubst %.c,%,$(wildcard $(abs_srcdir)/*.c)))
-
 MAKE_TARGETS			:= $(filter-out $(FILTER_OUT_MAKE_TARGETS),$(MAKE_TARGETS))
 
 # with only *.dwo, .[0-9]+.dwo can not be cleaned
-CLEAN_TARGETS			+= $(MAKE_TARGETS) *.o *.pyc .cache.mk *.dwo .*.dwo
+CLEAN_TARGETS			+= $(MAKE_TARGETS) $(HOST_MAKE_TARGETS) *.o *.pyc .cache.mk *.dwo .*.dwo
 
 # Majority of the files end up in testcases/bin...
 INSTALL_DIR			?= testcases/bin
diff --git a/include/mk/generic_leaf_target.inc b/include/mk/generic_leaf_target.inc
index dd54d05e9..e6fa107d1 100644
--- a/include/mk/generic_leaf_target.inc
+++ b/include/mk/generic_leaf_target.inc
@@ -57,6 +57,8 @@
 #				     rope to hang one's self in the event of
 #				     unwanted behavior.
 #
+# $(HOST_MAKE_TARGETS)	: Host tools which use $HOSTCC.
+#
 # $(CLEAN_TARGETS)		: What targets should be cleaned (must be
 #				  real files). This will automatically append
 #				  adds the .o suffix to all files referenced
@@ -92,6 +94,10 @@
 
 .PHONY: all clean install
 
+ifneq ($(strip $(MAKE_TARGETS)),)
+$(MAKE_TARGETS) += $(HOST_MAKE_TARGETS)
+endif
+
 $(MAKE_TARGETS): | $(MAKE_DEPS)
 
 all: $(MAKE_TARGETS)
diff --git a/include/mk/rules.mk b/include/mk/rules.mk
index 6a22e43af..c8f4bbbbe 100644
--- a/include/mk/rules.mk
+++ b/include/mk/rules.mk
@@ -22,6 +22,14 @@ else
 	@echo LD $(target_rel_dir)$@
 endif
 
+$(HOST_MAKE_TARGETS): %: %.c
+ifdef VERBOSE
+	$(HOSTCC) $(HOST_CFLAGS) $(HOST_LDFLAGS) $< $(HOST_LDLIBS) -o $@
+else
+	@$(HOSTCC) $(HOST_CFLAGS) $(HOST_LDFLAGS) $< $(HOST_LDLIBS) -o $@
+	@echo HOSTCC $(target_rel_dir)$@
+endif
+
 %: %.c
 ifdef VERBOSE
 	$(CC) $(CPPFLAGS) $(CFLAGS) $(LDFLAGS) $^ $(LTPLDLIBS) $(LDLIBS) -o $@
-- 
2.29.1

