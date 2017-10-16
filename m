From: Petr Vorel <pvorel@suse.cz>
Date: Mon, 16 Oct 2017 17:41:58 +0200
Subject: [LTP] [PATCH v4 07/14] numa: Drop NUMA_CPPFLAGS
In-Reply-To: <20171016154205.4814-1-pvorel@suse.cz>
References: <20171016154205.4814-1-pvorel@suse.cz>
Message-ID: <20171016154205.4814-8-pvorel@suse.cz>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

and remove most -DNUMA_VERSION1_COMPATIBILITY flags.
The place which requires it (e.g. using legacy code) is
testcases/kernel/lib/commands.c.

Signed-off-by: Petr Vorel <pvorel@suse.cz>
---
 include/mk/config.mk.default                                     | 1 -
 include/mk/config.mk.in                                          | 1 -
 m4/ltp-numa.m4                                                   | 9 ++-------
 testcases/kernel/controllers/cpuset/cpuset_syscall_test/Makefile | 1 -
 testcases/kernel/include/lib.mk                                  | 2 +-
 testcases/kernel/lib/Makefile                                    | 3 ++-
 testcases/kernel/numa/Makefile                                   | 2 +-
 7 files changed, 6 insertions(+), 13 deletions(-)

diff --git a/include/mk/config.mk.default b/include/mk/config.mk.default
index dff3479db..0934d9453 100644
--- a/include/mk/config.mk.default
+++ b/include/mk/config.mk.default
@@ -39,7 +39,6 @@ YACC			:= bison -y
 #ACL_LIBS		:= -lacl
 #CRYPTO_LIBS		:= -lcrypto
 #LEXLIB			:= -lfl
-#NUMA_CPPFLAGS		:= -DNUMA_VERSION1_COMPATIBILITY
 #NUMA_LIBS		:= -lnuma
 #SELINUX_LIBS		:= -lselinux
 #TIRPC_CPPFLAGS		:= -I/usr/include/tirpc
diff --git a/include/mk/config.mk.in b/include/mk/config.mk.in
index dde2a9e55..8c4f9da82 100644
--- a/include/mk/config.mk.in
+++ b/include/mk/config.mk.in
@@ -41,7 +41,6 @@ CAP_LIBS		:= @CAP_LIBS@
 ACL_LIBS		:= @ACL_LIBS@
 CRYPTO_LIBS		:= @CRYPTO_LIBS@
 LEXLIB			:= @LEXLIB@
-NUMA_CPPFLAGS		:= @NUMA_CPPFLAGS@
 NUMA_LIBS		:= @NUMA_LIBS@
 SELINUX_LIBS		:= @SELINUX_LIBS@
 TIRPC_CPPFLAGS		:= @TIRPC_CPPFLAGS@
diff --git a/m4/ltp-numa.m4 b/m4/ltp-numa.m4
index 30650cd00..b9e9069b6 100644
--- a/m4/ltp-numa.m4
+++ b/m4/ltp-numa.m4
@@ -22,8 +22,7 @@ dnl
 dnl LTP_CHECK_SYSCALL_NUMA
 dnl ----------------------------
 dnl
-AC_DEFUN([LTP_CHECK_SYSCALL_NUMA],
-[dnl
+AC_DEFUN([LTP_CHECK_SYSCALL_NUMA], [
 AC_CHECK_HEADERS([linux/mempolicy.h numa.h numaif.h],[
 	LTP_SYSCALL_NUMA_HEADERS=yes
 	AC_CHECK_LIB(numa,numa_alloc_onnode,[have_numa_alloc_onnode="yes"])
@@ -35,14 +34,10 @@ AC_CHECK_HEADERS([linux/mempolicy.h numa.h numaif.h],[
 		AC_DEFINE(HAVE_NUMA_MOVE_PAGES,1,[define to 1 if you have 'numa_move_pages' function])
 	fi
 ]
-	AC_CHECK_LIB(numa,numa_available,[
-NUMA_CPPFLAGS="-DNUMA_VERSION1_COMPATIBILITY"
-NUMA_LIBS="-lnuma"
-	])
+	AC_CHECK_LIB(numa,numa_available,[NUMA_LIBS="-lnuma"])
 dnl For testcases/kernel/controllers/cpuset, testcases/kernel/syscalls/get_mempolicy,
 dnl testcases/kernel/syscalls/mbind
 AC_CHECK_DECLS([MPOL_BIND, MPOL_DEFAULT, MPOL_F_ADDR, MPOL_F_MEMS_ALLOWED, MPOL_F_NODE, MPOL_INTERLEAVE, MPOL_PREFERRED],[have_mpol_constants="yes"],,[#include <numaif.h>])
-AC_SUBST(NUMA_CPPFLAGS)
 AC_SUBST(NUMA_LIBS)
 if test "x$have_mpol_constants" = "xyes"; then
 	AC_DEFINE(HAVE_MPOL_CONSTANTS,1,[define to 1 if you have all constants required to use mbind tests])
diff --git a/testcases/kernel/controllers/cpuset/cpuset_syscall_test/Makefile b/testcases/kernel/controllers/cpuset/cpuset_syscall_test/Makefile
index 6de1f8901..3f5e591f9 100644
--- a/testcases/kernel/controllers/cpuset/cpuset_syscall_test/Makefile
+++ b/testcases/kernel/controllers/cpuset/cpuset_syscall_test/Makefile
@@ -26,7 +26,6 @@ include $(top_srcdir)/include/mk/testcases.mk
 include $(abs_srcdir)/../Makefile.inc
 
 LDLIBS                  += $(NUMA_LIBS)
-CPPFLAGS                += $(NUMA_CPPFLAGS)
 
 include $(top_srcdir)/include/mk/generic_leaf_target.mk
 
diff --git a/testcases/kernel/include/lib.mk b/testcases/kernel/include/lib.mk
index 5c97ae2c9..40a09b77e 100644
--- a/testcases/kernel/include/lib.mk
+++ b/testcases/kernel/include/lib.mk
@@ -22,7 +22,7 @@ LIBKERNTEST_SRCDIR	:= $(KERNEL_SRCDIR)/lib
 KERNEL_DIR		:= $(abs_top_builddir)/testcases/kernel
 LIBKERNTEST_DIR		:= $(KERNEL_DIR)/lib
 LIBKERNTEST		:= $(LIBKERNTEST_DIR)/libkerntest.a
-CPPFLAGS		+= $(NUMA_CPPFLAGS) -I$(KERNEL_SRCDIR)/include
+CPPFLAGS		+= -I$(KERNEL_SRCDIR)/include
 LDLIBS			+= -lkerntest -lltp $(NUMA_LIBS)
 LDFLAGS			+= -L$(LIBKERNTEST_DIR)
 
diff --git a/testcases/kernel/lib/Makefile b/testcases/kernel/lib/Makefile
index 8e19eed9e..fabf2f06e 100644
--- a/testcases/kernel/lib/Makefile
+++ b/testcases/kernel/lib/Makefile
@@ -22,7 +22,8 @@ top_srcdir		?= ../../..
 
 include $(top_srcdir)/include/mk/env_pre.mk
 
-CPPFLAGS		+= $(NUMA_CPPFLAGS) -I$(abs_srcdir)/../include \
+CPPFLAGS		+= -DNUMA_VERSION1_COMPATIBILITY \
+			   -I$(abs_srcdir)/../include \
 			   -I$(abs_builddir)/../include
 INTERNAL_LIB		:= libkerntest.a
 
diff --git a/testcases/kernel/numa/Makefile b/testcases/kernel/numa/Makefile
index f5e1881fd..48494e456 100644
--- a/testcases/kernel/numa/Makefile
+++ b/testcases/kernel/numa/Makefile
@@ -20,7 +20,7 @@ top_srcdir		:= ../../..
 
 include $(top_srcdir)/include/mk/testcases.mk
 
-CPPFLAGS		+= -D_GNU_SOURCE -DNUMA_VERSION1_COMPATIBILITY
+CPPFLAGS		+= -D_GNU_SOURCE
 
 LDLIBS 			+= $(NUMA_LIBS)
 
-- 
2.14.2

