From: Fabrice Fontaine <fontaine.fabrice@gmail.com>
Date: Fri, 15 Nov 2019 23:10:38 +0100
Subject: [LTP] [PATCH] Fix static linking with musl-fts
Message-ID: <20191115221038.14383-1-fontaine.fabrice@gmail.com>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

Don't append libraries to LDLIBS but prepend them in cpuset_lib/Makefile
and cpuset/Makefile.inc to allow the user to provide its FTS library
such as -lfts for musl/uclibc through LDLIBS

This will fix static build of ltp with musl-fts on uclibc

Fixes:
 - http://autobuild.buildroot.org/results/9155326e1ff7c2bb2218122c453872c2fc76f65e

Signed-off-by: Fabrice Fontaine <fontaine.fabrice@gmail.com>
---
 testcases/kernel/controllers/cpuset/Makefile.inc        | 2 +-
 testcases/kernel/controllers/cpuset/cpuset_lib/Makefile | 2 +-
 2 files changed, 2 insertions(+), 2 deletions(-)

diff --git a/testcases/kernel/controllers/cpuset/Makefile.inc b/testcases/kernel/controllers/cpuset/Makefile.inc
index db6a84305..c03dd77d7 100644
--- a/testcases/kernel/controllers/cpuset/Makefile.inc
+++ b/testcases/kernel/controllers/cpuset/Makefile.inc
@@ -41,7 +41,7 @@ MAKE_DEPS		:= $(LIBCONTROLLERS) $(LIBCPUSET)
 
 LDFLAGS			+= -L$(abs_builddir)/$(LIBCPUSET_DIR) -L$(abs_builddir)/$(LIBCONTROLLERS_DIR)
 
-LDLIBS			+= -lcpu_set -lcontrollers -lltp
+LDLIBS			:= -lcpu_set -lcontrollers -lltp $(LDLIBS)
 
 INSTALL_TARGETS		?= *.sh
 
diff --git a/testcases/kernel/controllers/cpuset/cpuset_lib/Makefile b/testcases/kernel/controllers/cpuset/cpuset_lib/Makefile
index 322d03cac..069ebc38c 100644
--- a/testcases/kernel/controllers/cpuset/cpuset_lib/Makefile
+++ b/testcases/kernel/controllers/cpuset/cpuset_lib/Makefile
@@ -25,7 +25,7 @@ top_srcdir 		?= ../../../../..
 
 include $(top_srcdir)/include/mk/testcases.mk
 
-LDLIBS			+= -lm -lcontrollers -lltp
+LDLIBS			:= -lm -lcontrollers -lltp $(LDLIBS)
 
 LIB			:= libcpu_set.a
 
-- 
2.24.0

