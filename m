Return-Path: <ltp-list-bounces@lists.sourceforge.net>
Received: from sog-mx-3.v43.ch3.sourceforge.com ([172.29.43.193]
	helo=mx.sourceforge.net)
	by sfs-ml-3.v29.ch3.sourceforge.com with esmtp (Exim 4.76)
	(envelope-from <gilles.chanteperdrix@xenomai.org>)
	id 1WMiBl-00089m-QV
	for ltp-list@lists.sourceforge.net; Sun, 09 Mar 2014 18:11:05 +0000
Received: from sd-51317.dedibox.fr ([62.210.215.82])
	by sog-mx-3.v43.ch3.sourceforge.com with esmtps (TLSv1:AES128-SHA:128)
	(Exim 4.76) id 1WMiBk-0005aw-N3
	for ltp-list@lists.sourceforge.net; Sun, 09 Mar 2014 18:11:05 +0000
Received: from men13-3-82-231-18-196.fbx.proxad.net ([82.231.18.196]
	helo=hermes.local) by sd-51317.dedibox.fr with esmtpsa
	(TLS1.2:DHE_RSA_AES_128_CBC_SHA1:128) (Exim 4.80)
	(envelope-from <gilles.chanteperdrix@xenomai.org>)
	id 1WMiBe-00050C-GR
	for ltp-list@lists.sourceforge.net; Sun, 09 Mar 2014 19:10:58 +0100
Received: from localhost ([127.0.0.1] helo=hermes.local)
	by hermes.local with esmtpsa (TLS1.0:DHE_RSA_CAMELLIA_256_CBC_SHA1:256)
	(Exim 4.80) (envelope-from <gilles.chanteperdrix@xenomai.org>)
	id 1WMiBe-00009P-08
	for ltp-list@lists.sourceforge.net; Sun, 09 Mar 2014 19:10:58 +0100
Message-ID: <531CAEB1.3060905@xenomai.org>
Date: Sun, 09 Mar 2014 19:10:57 +0100
From: Gilles Chanteperdrix <gilles.chanteperdrix@xenomai.org>
MIME-Version: 1.0
Subject: [LTP] out of tree build
List-Id: Linux Test Project General Discussions
	<ltp-list.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/ltp-list>,
	<mailto:ltp-list-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=ltp-list>
List-Post: <mailto:ltp-list@lists.sourceforge.net>
List-Help: <mailto:ltp-list-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/ltp-list>,
	<mailto:ltp-list-request@lists.sourceforge.net?subject=subscribe>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: ltp-list-bounces@lists.sourceforge.net
To: ltp-list@lists.sourceforge.net


Hi,

I have tried building LTP january release, and found that the following 
changes were necessary.

Regards.

diff -Naurdp ltp-full-20140115.orig/Makefile ltp-full-20140115/Makefile
--- ltp-full-20140115.orig/Makefile	2014-01-15 17:51:29.000000000 +0100
+++ ltp-full-20140115/Makefile	2014-03-09 16:27:39.672310295 +0100
@@ -176,7 +176,7 @@ Version:
 	if git describe >/dev/null 2>&1; then \
 		git describe > "$@"; \
 	else \
-		cp VERSION "$@"; \
+		cp $(top_srcdir)/VERSION "$@"; \
 	fi
 
 $(INSTALL_DIR)/Version: Version
diff -Naurdp ltp-full-20140115.orig/testcases/kernel/include/lib.mk ltp-full-20140115/testcases/kernel/include/lib.mk
--- ltp-full-20140115.orig/testcases/kernel/include/lib.mk	2014-01-15 17:51:29.000000000 +0100
+++ ltp-full-20140115/testcases/kernel/include/lib.mk	2014-03-09 18:47:53.350459134 +0100
@@ -16,10 +16,13 @@
 #  Foundation, Inc., 51 Franklin St, Fifth Floor, Boston, MA  02110-1301  USA
 #
 
-KERNEL_DIR		:= $(top_srcdir)/testcases/kernel
+KERNEL_SRCDIR		:= $(top_srcdir)/testcases/kernel
+LIBKERNTEST_SRCDIR	:= $(KERNEL_SRCDIR)/lib
+
+KERNEL_DIR		:= $(top_builddir)/testcases/kernel
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
diff -Naurdp ltp-full-20140115.orig/testcases/kernel/lib/Makefile ltp-full-20140115/testcases/kernel/lib/Makefile
--- ltp-full-20140115.orig/testcases/kernel/lib/Makefile	2014-01-15 17:51:29.000000000 +0100
+++ ltp-full-20140115/testcases/kernel/lib/Makefile	2014-03-09 18:03:12.474885871 +0100
@@ -22,7 +22,7 @@ top_srcdir		?= ../../..
 
 include $(top_srcdir)/include/mk/env_pre.mk
 
-CPPFLAGS		+= $(NUMA_CPPFLAGS) -I../include
+CPPFLAGS		+= $(NUMA_CPPFLAGS) -I$(abs_srcdir)/../include
 INTERNAL_LIB		:= libkerntest.a
 
 include $(top_srcdir)/include/mk/lib.mk
diff -Naurdp ltp-full-20140115.orig/testcases/kernel/mem/include/libmem.mk ltp-full-20140115/testcases/kernel/mem/include/libmem.mk
--- ltp-full-20140115.orig/testcases/kernel/mem/include/libmem.mk	2014-01-15 17:51:29.000000000 +0100
+++ ltp-full-20140115/testcases/kernel/mem/include/libmem.mk	2014-03-09 18:52:04.124003580 +0100
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
diff -Naurdp ltp-full-20140115.orig/testcases/kernel/mem/lib/Makefile ltp-full-20140115/testcases/kernel/mem/lib/Makefile
--- ltp-full-20140115.orig/testcases/kernel/mem/lib/Makefile	2014-01-15 17:51:29.000000000 +0100
+++ ltp-full-20140115/testcases/kernel/mem/lib/Makefile	2014-03-09 18:15:15.718987539 +0100
@@ -20,7 +20,7 @@ top_srcdir		?= ../../../..
 
 include $(top_srcdir)/include/mk/env_pre.mk
 
-CFLAGS			+= -I../include
+CPPFLAGS		+= -I$(abs_srcdir)/../include
 INTERNAL_LIB		:= libmem.a
 
 include $(top_srcdir)/testcases/kernel/include/lib.mk
diff -Naurdp ltp-full-20140115.orig/utils/ffsb-6.0-rc2/stamp-h ltp-full-20140115/utils/ffsb-6.0-rc2/stamp-h
--- ltp-full-20140115.orig/utils/ffsb-6.0-rc2/stamp-h	1970-01-01 01:00:00.000000000 +0100
+++ ltp-full-20140115/utils/ffsb-6.0-rc2/stamp-h	2014-03-09 17:19:19.784615242 +0100
@@ -0,0 +1 @@
+timestamp
diff -Naurdp ltp-full-20140115.orig/utils/Makefile ltp-full-20140115/utils/Makefile
--- ltp-full-20140115.orig/utils/Makefile	2014-01-15 17:51:29.000000000 +0100
+++ ltp-full-20140115/utils/Makefile	2014-03-09 17:41:04.629421233 +0100
@@ -28,18 +28,18 @@ FFSBDIR			:= ffsb-6.0-rc2
 FILTER_OUT_DIRS		:= $(FFSBDIR)
 FFSB			:= $(FFSBDIR)/ffsb
 
-$(FFSB): $(FFSBDIR)
-	cd $^; ./configure
-	$(MAKE) -C $^ -f "$(abs_srcdir)/$^/Makefile" all
-	cp $(FFSBDIR)/ffsb ffsb
+unexport MAKEFLAGS
+
+$(FFSB): $(abs_srcdir)/$(FFSBDIR)
+	mkdir -p $(FFSBDIR)
+	cd $(FFSBDIR) && "$^/configure" && $(MAKE) all
 
 trunk-all: $(FFSB)
 
 trunk-clean:: | ffsb-clean
 
-ffsb-clean:: $(FFSBDIR)
-	$(MAKE) -C $^ -f "$(abs_srcdir)/$^/Makefile" clean
-	rm -rf ffsb
+ffsb-clean:: $(abs_srcdir)/$(FFSBDIR)
+	cd $(FFSBDIR); $(MAKE) clean
 
 
 include $(top_srcdir)/include/mk/generic_trunk_target.mk


-- 
                                                                Gilles.

------------------------------------------------------------------------------
Subversion Kills Productivity. Get off Subversion & Make the Move to Perforce.
With Perforce, you get hassle-free workflows. Merge that actually works. 
Faster operations. Version large binaries.  Built-in WAN optimization and the
freedom to use Git, Perforce or both. Make the move to Perforce.
http://pubads.g.doubleclick.net/gampad/clk?id=122218951&iu=/4140/ostg.clktrk
_______________________________________________
Ltp-list mailing list
Ltp-list@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/ltp-list
