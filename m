Return-Path: <ltp-list-bounces@lists.sourceforge.net>
Received: from sog-mx-2.v43.ch3.sourceforge.com ([172.29.43.192]
	helo=mx.sourceforge.net)
	by sfs-ml-1.v29.ch3.sourceforge.com with esmtp (Exim 4.76)
	(envelope-from <caspar@casparzhang.com>) id 1SzM2d-0000P0-D4
	for ltp-list@lists.sourceforge.net; Thu, 09 Aug 2012 06:16:19 +0000
Received: from mail-yw0-f47.google.com ([209.85.213.47])
	by sog-mx-2.v43.ch3.sourceforge.com with esmtps (TLSv1:RC4-SHA:128)
	(Exim 4.76) id 1SzM2c-0001Qy-77
	for ltp-list@lists.sourceforge.net; Thu, 09 Aug 2012 06:16:19 +0000
Received: by yhjj56 with SMTP id j56so76579yhj.34
	for <ltp-list@lists.sourceforge.net>;
	Wed, 08 Aug 2012 23:16:12 -0700 (PDT)
From: Caspar Zhang <caspar@casparzhang.com>
Date: Thu,  9 Aug 2012 14:15:42 +0800
Message-Id: <8b75c02f08feec233c87fd99d73e2752d4c40623.1344492473.git.caspar@casparzhang.com>
In-Reply-To: <cover.1344492473.git.caspar@casparzhang.com>
References: <cover.1344492473.git.caspar@casparzhang.com>
In-Reply-To: <cover.1344492473.git.caspar@casparzhang.com>
References: <cover.1344492473.git.caspar@casparzhang.com>
MIME-Version: 1.0
Content-Type: multipart/mixed; boundary="------------1.7.8.6"
Subject: [LTP] [PATCH resend 6/6] mm: add common Makefile include: libmem.mk
List-Id: Linux Test Project General Discussions
	<ltp-list.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/ltp-list>,
	<mailto:ltp-list-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=ltp-list>
List-Post: <mailto:ltp-list@lists.sourceforge.net>
List-Help: <mailto:ltp-list-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/ltp-list>,
	<mailto:ltp-list-request@lists.sourceforge.net?subject=subscribe>
Errors-To: ltp-list-bounces@lists.sourceforge.net
To: LTP List <ltp-list@lists.sourceforge.net>

This is a multi-part message in MIME format.
--------------1.7.8.6
Content-Type: text/plain; charset=UTF-8; format=fixed
Content-Transfer-Encoding: 8bit


libmem.mk is used as a common Makefile used by tests under mem/ dir to
avoid duplicated libmem-related lines.

Signed-off-by: Caspar Zhang <caspar@casparzhang.com>
---
 testcases/kernel/mem/cpuset/Makefile           |   23 +-------------
 testcases/kernel/mem/hugetlb/Makefile.inc      |   19 +++--------
 testcases/kernel/mem/hugetlb/hugemmap/Makefile |   13 +-------
 testcases/kernel/mem/include/libmem.mk         |   40 ++++++++++++++++++++++++
 testcases/kernel/mem/ksm/Makefile              |   23 +-------------
 testcases/kernel/mem/oom/Makefile              |   23 +-------------
 testcases/kernel/mem/swapping/Makefile         |   23 +-------------
 testcases/kernel/mem/thp/Makefile              |   23 +-------------
 testcases/kernel/mem/tunable/Makefile          |   23 +-------------
 testcases/kernel/mem/vma/Makefile              |    3 +-
 10 files changed, 54 insertions(+), 159 deletions(-)
 create mode 100644 testcases/kernel/mem/include/libmem.mk


--------------1.7.8.6
Content-Type: text/x-patch;
	name="0006-mm-add-common-Makefile-include-libmem.mk.patch"
Content-Transfer-Encoding: 8bit
Content-Disposition: attachment;
	filename="0006-mm-add-common-Makefile-include-libmem.mk.patch"

diff --git a/testcases/kernel/mem/cpuset/Makefile b/testcases/kernel/mem/cpuset/Makefile
index c9d03bf..8e41c02 100644
--- a/testcases/kernel/mem/cpuset/Makefile
+++ b/testcases/kernel/mem/cpuset/Makefile
@@ -20,26 +20,5 @@
 top_srcdir		?= ../../../..
 
 include $(top_srcdir)/include/mk/testcases.mk
-
-LDLIBS 			+= $(NUMA_LIBS) -lmem -lltp -lm
-LIBDIR			:= ../lib
-LIB			:= $(LIBDIR)/libmem.a
-FILTER_OUT_DIRS		:= $(LIBDIR)
-CFLAGS			+= -I../include
-LDFLAGS			+= -L$(LIBDIR)
-
-$(LIBDIR):
-	mkdir -p "$@"
-
-$(LIB): $(LIBDIR)
-	$(MAKE) -C $^ -f "$(abs_srcdir)/$^/Makefile" all
-
-MAKE_DEPS		:= $(LIB)
-
-trunk-clean:: | lib-clean
-
-lib-clean:: $(LIBDIR)
-	$(MAKE) -C $^ -f "$(abs_srcdir)/$^/Makefile" clean
-
-include $(top_srcdir)/testcases/kernel/include/lib.mk
+include $(top_srcdir)/testcases/kernel/mem/include/libmem.mk
 include $(top_srcdir)/include/mk/generic_leaf_target.mk
diff --git a/testcases/kernel/mem/hugetlb/Makefile.inc b/testcases/kernel/mem/hugetlb/Makefile.inc
index 1831fbb..cc0ada6 100644
--- a/testcases/kernel/mem/hugetlb/Makefile.inc
+++ b/testcases/kernel/mem/hugetlb/Makefile.inc
@@ -23,23 +23,16 @@
 # DO NOT USE THIS FILE FOR hugetlb / lib!!!
 LIBIPCDIR		:= ../lib
 LIBIPC			:= $(LIBIPCDIR)/libipc_hugetlb.a
+
 $(LIBIPCDIR):
 	mkdir -p "$@"
 $(LIBIPC): $(LIBIPCDIR)
 	$(MAKE) -C "$^" -f "$(abs_srcdir)/$^/Makefile" all
 
-LIBMEMDIR		:= ../../lib
-LIBMEM			:= $(LIBMEMDIR)/libmem.a
-$(LIBMEM): $(LIBMEMDIR)
-	$(MAKE) -C "$^" -f "$(abs_srcdir)/$^/Makefile" all
-
-CPPFLAGS		+= -I$(abs_srcdir)/$(LIBIPCDIR) -I$(abs_srcdir)/../../include
-LDFLAGS			+= -L$(abs_builddir)/$(LIBIPCDIR) -L$(abs_builddir)/$(LIBMEMDIR)
-LDLIBS			+= $(NUMA_LIBS) -lmem -lltp -lipc_hugetlb
-MAKE_DEPS		+= $(LIBMEM) $(LIBIPC)
-
-lib-clean:: $(LIBMEMDIR)
-	$(MAKE) -C $^ -f "$(abs_srcdir)/$^/Makefile" clean
+CPPFLAGS		+= -I$(abs_srcdir)/$(LIBIPCDIR)
+LDFLAGS			+= -L$(abs_builddir)/$(LIBIPCDIR)
+LDLIBS			+= -lipc_hugetlb
+MAKE_DEPS		+= $(LIBIPC)
 
-include $(top_srcdir)/testcases/kernel/include/lib.mk
+include $(top_srcdir)/testcases/kernel/mem/include/libmem.mk
 # vim: syntax=make
diff --git a/testcases/kernel/mem/hugetlb/hugemmap/Makefile b/testcases/kernel/mem/hugetlb/hugemmap/Makefile
index 0b1b60c..71da630 100644
--- a/testcases/kernel/mem/hugetlb/hugemmap/Makefile
+++ b/testcases/kernel/mem/hugetlb/hugemmap/Makefile
@@ -23,16 +23,5 @@
 top_srcdir		?= ../../../../..
 
 include $(top_srcdir)/include/mk/testcases.mk
-
-LIBMEMDIR		:= ../../lib
-LIBMEM			:= $(LIBMEMDIR)/libmem.a
-$(LIBMEM): $(LIBMEMDIR)
-	$(MAKE) -C "$^" -f "$(abs_srcdir)/$^/Makefile" all
-
-CPPFLAGS		+= -I$(abs_srcdir)/$(LIBMEMDIR) -I$(abs_srcdir)/../../include
-LDFLAGS			+= -L$(abs_builddir)/$(LIBMEMDIR)
-LDLIBS			+= $(NUMA_LIBS) -lmem -lltp
-MAKE_DEPS		+= $(LIBMEM)
-
-include $(top_srcdir)/testcases/kernel/include/lib.mk
+include $(top_srcdir)/testcases/kernel/mem/include/libmem.mk
 include $(top_srcdir)/include/mk/generic_leaf_target.mk
diff --git a/testcases/kernel/mem/include/libmem.mk b/testcases/kernel/mem/include/libmem.mk
new file mode 100644
index 0000000..22efda2
--- /dev/null
+++ b/testcases/kernel/mem/include/libmem.mk
@@ -0,0 +1,40 @@
+#
+#  Copyright (C) 2012  Red Hat, Inc.
+#
+#  This program is free software;  you can redistribute it and/or modify
+#  it under the terms of the GNU General Public License as published by
+#  the Free Software Foundation; either version 2 of the License, or
+#  (at your option) any later version.
+#
+#  This program is distributed in the hope that it will be useful,
+#  but WITHOUT ANY WARRANTY;  without even the implied warranty of
+#  MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See
+#  the GNU General Public License for more details.
+#
+#  You should have received a copy of the GNU General Public License
+#  along with this program;  if not, write to the Free Software
+#  Foundation, Inc., 59 Temple Place, Suite 330, Boston, MA 02111-1307 USA
+#
+
+MEM_DIR			:= $(top_srcdir)/testcases/kernel/mem
+LIBMEM_DIR		:= $(MEM_DIR)/lib
+LIBMEM			:= $(LIBMEM_DIR)/libmem.a
+FILTER_OUT_DIRS		:= $(LIBMEM_DIR)
+CFLAGS			+= -I$(MEM_DIR)/include
+LDLIBS			+= $(NUMA_LIBS) -lmem -lltp
+LDFLAGS			+= -L$(LIBMEM_DIR)
+
+$(LIBMEM_DIR):
+	mkdir -p "$@"
+
+$(LIBMEM): $(LIBMEM_DIR)
+	$(MAKE) -C $^ -f "$(abs_srcdir)/$^/Makefile" all
+
+MAKE_DEPS		+= $(LIBMEM)
+
+trunk-clean:: | lib-clean
+
+lib-clean:: $(LIBMEM_DIR)
+	$(MAKE) -C $^ -f "$(abs_srcdir)/$^/Makefile" clean
+
+include $(top_srcdir)/testcases/kernel/include/lib.mk
diff --git a/testcases/kernel/mem/ksm/Makefile b/testcases/kernel/mem/ksm/Makefile
index b17845b..128d7bc 100644
--- a/testcases/kernel/mem/ksm/Makefile
+++ b/testcases/kernel/mem/ksm/Makefile
@@ -19,26 +19,5 @@
 top_srcdir		?= ../../../..
 
 include $(top_srcdir)/include/mk/testcases.mk
-
-LDLIBS			+= $(NUMA_LIBS) -lmem -lltp
-LIBDIR			:= ../lib
-LIB			:= $(LIBDIR)/libmem.a
-FILTER_OUT_DIRS		:= $(LIBDIR)
-CFLAGS			+= -I../include
-LDFLAGS			+= -L$(LIBDIR)
-
-$(LIBDIR):
-	mkdir -p "$@"
-
-$(LIB): $(LIBDIR)
-	$(MAKE) -C $^ -f "$(abs_srcdir)/$^/Makefile" all
-
-MAKE_DEPS		:= $(LIB)
-
-trunk-clean:: | lib-clean
-
-lib-clean:: $(LIBDIR)
-	$(MAKE) -C $^ -f "$(abs_srcdir)/$^/Makefile" clean
-
-include $(top_srcdir)/testcases/kernel/include/lib.mk
+include $(top_srcdir)/testcases/kernel/mem/include/libmem.mk
 include $(top_srcdir)/include/mk/generic_leaf_target.mk
diff --git a/testcases/kernel/mem/oom/Makefile b/testcases/kernel/mem/oom/Makefile
index b17845b..128d7bc 100644
--- a/testcases/kernel/mem/oom/Makefile
+++ b/testcases/kernel/mem/oom/Makefile
@@ -19,26 +19,5 @@
 top_srcdir		?= ../../../..
 
 include $(top_srcdir)/include/mk/testcases.mk
-
-LDLIBS			+= $(NUMA_LIBS) -lmem -lltp
-LIBDIR			:= ../lib
-LIB			:= $(LIBDIR)/libmem.a
-FILTER_OUT_DIRS		:= $(LIBDIR)
-CFLAGS			+= -I../include
-LDFLAGS			+= -L$(LIBDIR)
-
-$(LIBDIR):
-	mkdir -p "$@"
-
-$(LIB): $(LIBDIR)
-	$(MAKE) -C $^ -f "$(abs_srcdir)/$^/Makefile" all
-
-MAKE_DEPS		:= $(LIB)
-
-trunk-clean:: | lib-clean
-
-lib-clean:: $(LIBDIR)
-	$(MAKE) -C $^ -f "$(abs_srcdir)/$^/Makefile" clean
-
-include $(top_srcdir)/testcases/kernel/include/lib.mk
+include $(top_srcdir)/testcases/kernel/mem/include/libmem.mk
 include $(top_srcdir)/include/mk/generic_leaf_target.mk
diff --git a/testcases/kernel/mem/swapping/Makefile b/testcases/kernel/mem/swapping/Makefile
index b17845b..128d7bc 100644
--- a/testcases/kernel/mem/swapping/Makefile
+++ b/testcases/kernel/mem/swapping/Makefile
@@ -19,26 +19,5 @@
 top_srcdir		?= ../../../..
 
 include $(top_srcdir)/include/mk/testcases.mk
-
-LDLIBS			+= $(NUMA_LIBS) -lmem -lltp
-LIBDIR			:= ../lib
-LIB			:= $(LIBDIR)/libmem.a
-FILTER_OUT_DIRS		:= $(LIBDIR)
-CFLAGS			+= -I../include
-LDFLAGS			+= -L$(LIBDIR)
-
-$(LIBDIR):
-	mkdir -p "$@"
-
-$(LIB): $(LIBDIR)
-	$(MAKE) -C $^ -f "$(abs_srcdir)/$^/Makefile" all
-
-MAKE_DEPS		:= $(LIB)
-
-trunk-clean:: | lib-clean
-
-lib-clean:: $(LIBDIR)
-	$(MAKE) -C $^ -f "$(abs_srcdir)/$^/Makefile" clean
-
-include $(top_srcdir)/testcases/kernel/include/lib.mk
+include $(top_srcdir)/testcases/kernel/mem/include/libmem.mk
 include $(top_srcdir)/include/mk/generic_leaf_target.mk
diff --git a/testcases/kernel/mem/thp/Makefile b/testcases/kernel/mem/thp/Makefile
index 3ef9288..867dcf0 100644
--- a/testcases/kernel/mem/thp/Makefile
+++ b/testcases/kernel/mem/thp/Makefile
@@ -20,26 +20,5 @@
 top_srcdir		?= ../../../..
 
 include $(top_srcdir)/include/mk/testcases.mk
-
-LDLIBS			+= $(NUMA_LIBS) -lmem -lltp
-LIBDIR			:= ../lib
-LIB			:= $(LIBDIR)/libmem.a
-FILTER_OUT_DIRS		:= $(LIBDIR)
-CFLAGS			+= -I../include
-LDFLAGS			+= -L$(LIBDIR)
-
-$(LIBDIR):
-	mkdir -p "$@"
-
-$(LIB): $(LIBDIR)
-	$(MAKE) -C $^ -f "$(abs_srcdir)/$^/Makefile" all
-
-MAKE_DEPS		:= $(LIB)
-
-trunk-clean:: | lib-clean
-
-lib-clean:: $(LIBDIR)
-	$(MAKE) -C $^ -f "$(abs_srcdir)/$^/Makefile" clean
-
-include $(top_srcdir)/testcases/kernel/include/lib.mk
+include $(top_srcdir)/testcases/kernel/mem/include/libmem.mk
 include $(top_srcdir)/include/mk/generic_leaf_target.mk
diff --git a/testcases/kernel/mem/tunable/Makefile b/testcases/kernel/mem/tunable/Makefile
index 3ef9288..867dcf0 100644
--- a/testcases/kernel/mem/tunable/Makefile
+++ b/testcases/kernel/mem/tunable/Makefile
@@ -20,26 +20,5 @@
 top_srcdir		?= ../../../..
 
 include $(top_srcdir)/include/mk/testcases.mk
-
-LDLIBS			+= $(NUMA_LIBS) -lmem -lltp
-LIBDIR			:= ../lib
-LIB			:= $(LIBDIR)/libmem.a
-FILTER_OUT_DIRS		:= $(LIBDIR)
-CFLAGS			+= -I../include
-LDFLAGS			+= -L$(LIBDIR)
-
-$(LIBDIR):
-	mkdir -p "$@"
-
-$(LIB): $(LIBDIR)
-	$(MAKE) -C $^ -f "$(abs_srcdir)/$^/Makefile" all
-
-MAKE_DEPS		:= $(LIB)
-
-trunk-clean:: | lib-clean
-
-lib-clean:: $(LIBDIR)
-	$(MAKE) -C $^ -f "$(abs_srcdir)/$^/Makefile" clean
-
-include $(top_srcdir)/testcases/kernel/include/lib.mk
+include $(top_srcdir)/testcases/kernel/mem/include/libmem.mk
 include $(top_srcdir)/include/mk/generic_leaf_target.mk
diff --git a/testcases/kernel/mem/vma/Makefile b/testcases/kernel/mem/vma/Makefile
index 949db9a..b323dbf 100644
--- a/testcases/kernel/mem/vma/Makefile
+++ b/testcases/kernel/mem/vma/Makefile
@@ -20,6 +20,5 @@
 top_srcdir              ?= ../../../..
 
 include $(top_srcdir)/include/mk/testcases.mk
-
-include $(top_srcdir)/testcases/kernel/include/lib.mk
+include $(top_srcdir)/testcases/kernel/mem/include/libmem.mk
 include $(top_srcdir)/include/mk/generic_leaf_target.mk

--------------1.7.8.6
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

------------------------------------------------------------------------------
Live Security Virtual Conference
Exclusive live event will cover all the ways today's security and 
threat landscape has changed and how IT managers can respond. Discussions 
will include endpoint security, mobile security and the latest in malware 
threats. http://www.accelacomm.com/jaw/sfrnl04242012/114/50122263/
--------------1.7.8.6
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
Ltp-list mailing list
Ltp-list@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/ltp-list

--------------1.7.8.6--



