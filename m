Return-Path: <ltp-list-bounces@lists.sourceforge.net>
Received: from sog-mx-2.v43.ch3.sourceforge.com ([172.29.43.192]
	helo=mx.sourceforge.net)
	by sfs-ml-2.v29.ch3.sourceforge.com with esmtp (Exim 4.76)
	(envelope-from <gilles.chanteperdrix@xenomai.org>)
	id 1WV45F-0003nu-7P
	for ltp-list@lists.sourceforge.net; Tue, 01 Apr 2014 19:10:53 +0000
Received: from sd-51317.dedibox.fr ([62.210.215.82])
	by sog-mx-2.v43.ch3.sourceforge.com with esmtps (TLSv1:AES128-SHA:128)
	(Exim 4.76) id 1WV45E-0006RE-2j
	for ltp-list@lists.sourceforge.net; Tue, 01 Apr 2014 19:10:53 +0000
From: Gilles Chanteperdrix <gilles.chanteperdrix@xenomai.org>
Date: Tue,  1 Apr 2014 21:10:42 +0200
Message-Id: <1396379442-7380-1-git-send-email-gilles.chanteperdrix@xenomai.org>
In-Reply-To: <533B0F0C.6040801@xenomai.org>
References: <533B0F0C.6040801@xenomai.org>
Subject: [LTP] [PATCH] build: fix out-of-tree build
List-Id: Linux Test Project General Discussions
	<ltp-list.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/ltp-list>,
	<mailto:ltp-list-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=ltp-list>
List-Post: <mailto:ltp-list@lists.sourceforge.net>
List-Help: <mailto:ltp-list-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/ltp-list>,
	<mailto:ltp-list-request@lists.sourceforge.net?subject=subscribe>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: ltp-list-bounces@lists.sourceforge.net
To: ltp-list@lists.sourceforge.net

Signed-off-by: Gilles Chanteperdrix <gilles.chanteperdrix@xenomai.org>
---
 Makefile                                         |    2 +-
 testcases/kernel/include/lib.mk                  |   11 +++++++----
 testcases/kernel/lib/Makefile                    |    2 +-
 testcases/kernel/mem/include/libmem.mk           |   11 +++++++----
 testcases/kernel/mem/lib/Makefile                |    2 +-
 testcases/network/rpc/basic_tests/rpc01/Makefile |    2 +-
 utils/Makefile                                   |   12 +++++-------
 7 files changed, 23 insertions(+), 19 deletions(-)

diff --git a/Makefile b/Makefile
index 71efca4..297f8e7 100644
--- a/Makefile
+++ b/Makefile
@@ -176,7 +176,7 @@ Version:
 	if git describe >/dev/null 2>&1; then \
 		git describe > "$@"; \
 	else \
-		cp VERSION "$@"; \
+		cp $(top_srcdir)/VERSION "$@"; \
 	fi
 
 $(INSTALL_DIR)/Version: Version
diff --git a/testcases/kernel/include/lib.mk b/testcases/kernel/include/lib.mk
index 624134b..c193ca3 100644
--- a/testcases/kernel/include/lib.mk
+++ b/testcases/kernel/include/lib.mk
@@ -16,10 +16,13 @@
 #  Foundation, Inc., 51 Franklin St, Fifth Floor, Boston, MA  02110-1301  USA
 #
 
-KERNEL_DIR		:= $(top_srcdir)/testcases/kernel
+KERNEL_SRCDIR		:= $(abs_top_srcdir)/testcases/kernel
+LIBKERNTEST_SRCDIR	:= $(KERNEL_SRCDIR)/lib
+
+KERNEL_DIR		:= $(abs_top_builddir)/testcases/kernel
 LIBKERNTEST_DIR		:= $(KERNEL_DIR)/lib
 LIBKERNTEST		:= $(KERNEL_DIR)/libkerntest.a
-CPPFLAGS		+= $(NUMA_CPPFLAGS) -I$(KERNEL_DIR)/include
+CPPFLAGS		+= $(NUMA_CPPFLAGS) -I$(KERNEL_SRCDIR)/include
 LDLIBS			+= $(NUMA_LIBS) -lkerntest -lltp
 LDFLAGS			+= -L$(LIBKERNTEST_DIR)
 
@@ -27,11 +30,11 @@ $(LIBKERNTEST_DIR):
 	mkdir -p "$@"
 
 $(LIBKERNTEST): $(LIBKERNTEST_DIR)
-	$(MAKE) -C $^ -f "$(abs_srcdir)/$^/Makefile" all
+	$(MAKE) -C $^ -f "$(LIBKERNTEST_SRCDIR)/Makefile" all
 
 MAKE_DEPS		+= $(LIBKERNTEST)
 
 trunk-clean:: | lib-clean
 
 lib-clean:: $(LIBKERNTEST_DIR)
-	$(MAKE) -C $^ -f "$(abs_srcdir)/$^/Makefile" clean
+	$(MAKE) -C $^ -f "$(LIBKERNTEST_SRCDIR)/Makefile" clean
diff --git a/testcases/kernel/lib/Makefile b/testcases/kernel/lib/Makefile
index db094e8..c4af8df 100644
--- a/testcases/kernel/lib/Makefile
+++ b/testcases/kernel/lib/Makefile
@@ -22,7 +22,7 @@ top_srcdir		?= ../../..
 
 include $(top_srcdir)/include/mk/env_pre.mk
 
-CPPFLAGS		+= $(NUMA_CPPFLAGS) -I../include
+CPPFLAGS		+= $(NUMA_CPPFLAGS) -I$(abs_srcdir)/../include
 INTERNAL_LIB		:= libkerntest.a
 
 include $(top_srcdir)/include/mk/lib.mk
diff --git a/testcases/kernel/mem/include/libmem.mk b/testcases/kernel/mem/include/libmem.mk
index fdf38a1..7ebcf05 100644
--- a/testcases/kernel/mem/include/libmem.mk
+++ b/testcases/kernel/mem/include/libmem.mk
@@ -16,11 +16,14 @@
 #  Foundation, Inc., 51 Franklin Street, Fifth Floor, Boston, MA 02110-1301 USA
 #
 
-MEM_DIR			:= $(top_srcdir)/testcases/kernel/mem
+MEM_SRCDIR		:= $(top_srcdir)/testcases/kernel/mem
+LIBMEM_SRCDIR		:= $(MEM_SRCDIR)/lib
+
+MEM_DIR			:= $(top_builddir)/testcases/kernel/mem
 LIBMEM_DIR		:= $(MEM_DIR)/lib
 LIBMEM			:= $(LIBMEM_DIR)/libmem.a
 FILTER_OUT_DIRS		:= $(LIBMEM_DIR)
-CFLAGS			+= -I$(MEM_DIR)/include
+CFLAGS			+= -I$(MEM_SRCDIR)/include
 LDLIBS			+= $(NUMA_LIBS) -lmem -lltp
 LDFLAGS			+= -L$(LIBMEM_DIR)
 
@@ -28,13 +31,13 @@ $(LIBMEM_DIR):
 	mkdir -p "$@"
 
 $(LIBMEM): $(LIBMEM_DIR)
-	$(MAKE) -C $^ -f "$(abs_srcdir)/$^/Makefile" all
+	$(MAKE) -C $^ -f "$(LIBMEM_SRCDIR)/Makefile" all
 
 MAKE_DEPS		+= $(LIBMEM)
 
 trunk-clean:: | lib-clean
 
 lib-clean:: $(LIBMEM_DIR)
-	$(MAKE) -C $^ -f "$(abs_srcdir)/$^/Makefile" clean
+	$(MAKE) -C $^ -f "$(LIBMEM_SRCDIR)/Makefile" clean
 
 include $(top_srcdir)/testcases/kernel/include/lib.mk
diff --git a/testcases/kernel/mem/lib/Makefile b/testcases/kernel/mem/lib/Makefile
index 6bc5863..d4624e9 100644
--- a/testcases/kernel/mem/lib/Makefile
+++ b/testcases/kernel/mem/lib/Makefile
@@ -20,7 +20,7 @@ top_srcdir		?= ../../../..
 
 include $(top_srcdir)/include/mk/env_pre.mk
 
-CFLAGS			+= -I../include
+CPPFLAGS		+= -I$(abs_srcdir)/../include
 INTERNAL_LIB		:= libmem.a
 
 include $(top_srcdir)/testcases/kernel/include/lib.mk
diff --git a/testcases/network/rpc/basic_tests/rpc01/Makefile b/testcases/network/rpc/basic_tests/rpc01/Makefile
index 68ea85e..7815cbb 100644
--- a/testcases/network/rpc/basic_tests/rpc01/Makefile
+++ b/testcases/network/rpc/basic_tests/rpc01/Makefile
@@ -32,7 +32,7 @@ SUBDIRS			:= datafiles
 
 LIBSRCS			:= $(abs_srcdir)/librpc01.c
 INTERNAL_LIB		:= librpc01.a
-LDFLAGS			+= -L$(abs_srcdir)
+LDFLAGS			+= -L$(abs_builddir)
 LDLIBS			+= -lrpc01
 
 MAKE_TARGETS		:= rpc1 rpc_server
diff --git a/utils/Makefile b/utils/Makefile
index 58cec7c..aa052e6 100644
--- a/utils/Makefile
+++ b/utils/Makefile
@@ -28,18 +28,16 @@ FFSBDIR			:= ffsb-6.0-rc2
 FILTER_OUT_DIRS		:= $(FFSBDIR)
 FFSB			:= $(FFSBDIR)/ffsb
 
-$(FFSB): $(FFSBDIR)
-	cd $^; ./configure
-	$(MAKE) -C $^ -f "$(abs_srcdir)/$^/Makefile" all
-	cp $(FFSBDIR)/ffsb ffsb
+$(FFSB): $(abs_srcdir)/$(FFSBDIR)
+	mkdir -p $(FFSBDIR)
+	cd $(FFSBDIR) && "$^/configure" && $(MAKE) top_srcdir="$^" all
 
 trunk-all: $(FFSB)
 
 trunk-clean:: | ffsb-clean
 
-ffsb-clean:: $(FFSBDIR)
-	$(MAKE) -C $^ -f "$(abs_srcdir)/$^/Makefile" clean
-	rm -rf ffsb
+ffsb-clean:: $(abs_srcdir)/$(FFSBDIR)
+	cd $(FFSBDIR); $(MAKE) top_srcdir="$^" clean
 
 
 include $(top_srcdir)/include/mk/generic_trunk_target.mk
-- 
1.7.10.4


------------------------------------------------------------------------------
_______________________________________________
Ltp-list mailing list
Ltp-list@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/ltp-list
