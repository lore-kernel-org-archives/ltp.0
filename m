Return-Path: <ltp-list-bounces@lists.sourceforge.net>
Received: from sog-mx-1.v43.ch3.sourceforge.com ([172.29.43.191]
	helo=mx.sourceforge.net)
	by sfs-ml-3.v29.ch3.sourceforge.com with esmtp (Exim 4.76)
	(envelope-from <wangxg.fnst@cn.fujitsu.com>) id 1WkVM2-000257-Uz
	for ltp-list@lists.sourceforge.net; Wed, 14 May 2014 09:20:03 +0000
Received: from [59.151.112.132] (helo=heian.cn.fujitsu.com)
	by sog-mx-1.v43.ch3.sourceforge.com with esmtp (Exim 4.76)
	id 1WkVLz-0004jE-JW
	for ltp-list@lists.sourceforge.net; Wed, 14 May 2014 09:20:02 +0000
Received: from G08CNEXCHPEKD02.g08.fujitsu.local (localhost.localdomain
	[127.0.0.1])
	by edo.cn.fujitsu.com (8.14.3/8.13.1) with ESMTP id s4E9Jpx2000795
	for <ltp-list@lists.sourceforge.net>; Wed, 14 May 2014 17:19:52 +0800
From: Xiaoguang Wang <wangxg.fnst@cn.fujitsu.com>
Date: Wed, 14 May 2014 17:17:35 +0800
Message-ID: <1400059055-22877-1-git-send-email-wangxg.fnst@cn.fujitsu.com>
MIME-Version: 1.0
Subject: [LTP] [PATCH RFC] change MAKE_TARGETS's dependency to normal
	prerequisites and order-only prerequisites
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

See the below issue:
  When we made modifications to source files in lib/, for example lib/tst_mkfs.c, then
  back to testcases/kernel/syscalls/access and execute 'make'. This will not make the
  access[0-5] to be re-linked with the newly generated libltp.a, we need to touch
  access[0-5].c or remove access[0-5] files first, then make. This will make no sense.
  Users may expect just a make command to ensure a new access[0-5] generated with the
  new libltp.a.

This is because in 'include/mk/generic_leaf_target.inc', MAKE_TARGETS's dependency is
order-only prerequisites, not normal prerequisites, so we change lib's dependency type
to normal prerequisites, not order-only prerequisites.

The original MAKE_DEPS is replaced by MAKE_NORMAL_DEPS or MAKE_ORDER_ONLY_DEPS.

Signed-off-by: Xiaoguang Wang <wangxg.fnst@cn.fujitsu.com>
---
 include/mk/generic_leaf_target.inc                      | 2 +-
 include/mk/generic_trunk_target.inc                     | 2 +-
 include/mk/testcases.mk                                 | 3 ++-
 testcases/kernel/Makefile                               | 2 +-
 testcases/kernel/containers/Makefile                    | 2 +-
 testcases/kernel/containers/Makefile.inc                | 2 +-
 testcases/kernel/controllers/Makefile                   | 2 +-
 testcases/kernel/controllers/Makefile.inc               | 2 +-
 testcases/kernel/controllers/cpuset/Makefile            | 2 +-
 testcases/kernel/controllers/cpuset/Makefile.inc        | 2 +-
 testcases/kernel/include/lib.mk                         | 2 +-
 testcases/kernel/mem/hugetlb/Makefile                   | 2 +-
 testcases/kernel/mem/hugetlb/Makefile.inc               | 2 +-
 testcases/kernel/mem/include/libmem.mk                  | 2 +-
 testcases/kernel/power_management/Makefile              | 2 +-
 testcases/kernel/syscalls/ipc/Makefile                  | 2 +-
 testcases/kernel/syscalls/ipc/Makefile.inc              | 2 +-
 testcases/kernel/syscalls/ipc/msgctl/Makefile           | 2 +-
 testcases/kernel/syscalls/kill/Makefile                 | 2 +-
 testcases/kernel/syscalls/mremap/Makefile               | 2 +-
 testcases/network/rpc/basic_tests/rpc01/Makefile        | 2 +-
 testcases/network/rpc/rpc-tirpc/tests_pack/Makefile.inc | 2 +-
 testcases/network/tcp_cmds/Makefile.inc                 | 4 ++--
 23 files changed, 25 insertions(+), 24 deletions(-)

diff --git a/include/mk/generic_leaf_target.inc b/include/mk/generic_leaf_target.inc
index a88586f..71c8a07 100644
--- a/include/mk/generic_leaf_target.inc
+++ b/include/mk/generic_leaf_target.inc
@@ -92,7 +92,7 @@
 
 .PHONY: all clean install
 
-$(MAKE_TARGETS): | $(MAKE_DEPS)
+$(MAKE_TARGETS): $(MAKE_NORMAL_DEPS) | $(MAKE_ORDER_ONLY_DEPS)
 
 all: $(MAKE_TARGETS)
 
diff --git a/include/mk/generic_trunk_target.inc b/include/mk/generic_trunk_target.inc
index c49e3c6..994e7c0 100644
--- a/include/mk/generic_trunk_target.inc
+++ b/include/mk/generic_trunk_target.inc
@@ -57,7 +57,7 @@ $(eval $(get_make_dirs))
 $(SUBDIRS): %:
 	mkdir -m 00755 -p "$@"
 
-$(MAKE_TARGETS): | $(MAKE_DEPS)
+$(MAKE_TARGETS): $(MAKE_NORMAL_DEPS) | $(MAKE_ORDER_ONLY_DEPS)
 
 trunk-all: $(MAKE_TARGETS)
 
diff --git a/include/mk/testcases.mk b/include/mk/testcases.mk
index ea26d4f..6ab587b 100644
--- a/include/mk/testcases.mk
+++ b/include/mk/testcases.mk
@@ -42,7 +42,8 @@ $(LIBLTP): $(LIBLTP_DIR)
 $(LSN_H): $(abs_top_builddir)/$(TKI_DIR)
 	$(MAKE) -C "$^" -f "$(abs_top_srcdir)/$(TKI_DIR)/Makefile" all
 
-MAKE_DEPS	:= $(LIBLTP) $(LSN_H)
+MAKE_ORDER_ONLY_DEPS	:= $(LSN_H)
+MAKE_NORMAL_DEPS	:= $(LIBLTP)
 
 # For linux_syscall_numbers.h
 CPPFLAGS	+= -I$(abs_top_builddir)/$(TKI_DIR)
diff --git a/testcases/kernel/Makefile b/testcases/kernel/Makefile
index 50a12fa..0460827 100644
--- a/testcases/kernel/Makefile
+++ b/testcases/kernel/Makefile
@@ -60,7 +60,7 @@ endif
 
 endif
 
-MAKE_DEPS		:= include/linux_syscall_numbers.h
+MAKE_NORMAL_DEPS	:= include/linux_syscall_numbers.h
 
 include:
 	mkdir -p "$@"
diff --git a/testcases/kernel/containers/Makefile b/testcases/kernel/containers/Makefile
index 6620ed9..eafbfd1 100644
--- a/testcases/kernel/containers/Makefile
+++ b/testcases/kernel/containers/Makefile
@@ -38,7 +38,7 @@ $(LIBDIR):
 $(LIB): $(LIBDIR)
 	$(MAKE) -C $^ -f "$(abs_srcdir)/$(LIBDIR)/Makefile" all
 
-MAKE_DEPS		:= $(LIB)
+MAKE_NORMAL_DEPS	:= $(LIB)
 
 trunk-clean:: | lib-clean
 
diff --git a/testcases/kernel/containers/Makefile.inc b/testcases/kernel/containers/Makefile.inc
index 0750f50..ae90a1a 100644
--- a/testcases/kernel/containers/Makefile.inc
+++ b/testcases/kernel/containers/Makefile.inc
@@ -40,6 +40,6 @@ $(LIBS): $(LIBDIR)
 
 INSTALL_TARGETS		?= *.sh
 
-MAKE_DEPS		:= $(LIBS)
+MAKE_NORMAL_DEPS	:= $(LIBS)
 
 # vim: syntax=make
diff --git a/testcases/kernel/controllers/Makefile b/testcases/kernel/controllers/Makefile
index 80e5e9e..471eb5e 100644
--- a/testcases/kernel/controllers/Makefile
+++ b/testcases/kernel/controllers/Makefile
@@ -35,7 +35,7 @@ $(LIBDIR):
 $(LIB): $(LIBDIR)
 	$(MAKE) -C $^ -f "$(abs_srcdir)/$^/Makefile" all
 
-MAKE_DEPS		:= $(LIB)
+MAKE_ORDER_ONLY_DEPS	:= $(LIB)
 
 trunk-clean:: | lib-clean
 
diff --git a/testcases/kernel/controllers/Makefile.inc b/testcases/kernel/controllers/Makefile.inc
index b106283..57e53b7 100644
--- a/testcases/kernel/controllers/Makefile.inc
+++ b/testcases/kernel/controllers/Makefile.inc
@@ -31,7 +31,7 @@ LIB			:= $(LIBDIR)/libcontrollers.a
 $(LIB): ../$(LIBDIR)
 	$(MAKE) -C $^ -f "$(abs_srcdir)/$^/Makefile" all
 
-MAKE_DEPS		:= $(LIB)
+MAKE_ORDER_ONLY_DEPS	:= $(LIB)
 
 CPPFLAGS		+= -I$(abs_srcdir)/../$(LIBDIR)
 
diff --git a/testcases/kernel/controllers/cpuset/Makefile b/testcases/kernel/controllers/cpuset/Makefile
index d988d0c..c265118 100644
--- a/testcases/kernel/controllers/cpuset/Makefile
+++ b/testcases/kernel/controllers/cpuset/Makefile
@@ -35,7 +35,7 @@ $(LIBDIR):
 $(LIB): $(LIBDIR)
 	$(MAKE) -C $^ -f "$(abs_srcdir)/$^/Makefile" all
 
-MAKE_DEPS		:= $(LIB)
+MAKE_NORMAL_DEPS	:= $(LIB)
 
 trunk-clean:: | lib-clean
 
diff --git a/testcases/kernel/controllers/cpuset/Makefile.inc b/testcases/kernel/controllers/cpuset/Makefile.inc
index 9e002f4..332b2bf 100644
--- a/testcases/kernel/controllers/cpuset/Makefile.inc
+++ b/testcases/kernel/controllers/cpuset/Makefile.inc
@@ -37,7 +37,7 @@ $(LIBCONTROLLERS): $(LIBCONTROLLERS_DIR)
 $(LIBCPUSET): $(LIBCPUSET_DIR) | $(LIBCONTROLLERS)
 	$(MAKE) -C $^ -f "$(abs_srcdir)/$^/Makefile" all
 
-MAKE_DEPS		:= $(LIBCONTROLLERS) $(LIBCPUSET)
+MAKE_NORMAL_DEPS	:= $(LIBCONTROLLERS) $(LIBCPUSET)
 
 LDFLAGS			+= -L$(abs_builddir)/$(LIBCPUSET_DIR) -L$(abs_builddir)/$(LIBCONTROLLERS_DIR)
 
diff --git a/testcases/kernel/include/lib.mk b/testcases/kernel/include/lib.mk
index c193ca3..c0b9189 100644
--- a/testcases/kernel/include/lib.mk
+++ b/testcases/kernel/include/lib.mk
@@ -32,7 +32,7 @@ $(LIBKERNTEST_DIR):
 $(LIBKERNTEST): $(LIBKERNTEST_DIR)
 	$(MAKE) -C $^ -f "$(LIBKERNTEST_SRCDIR)/Makefile" all
 
-MAKE_DEPS		+= $(LIBKERNTEST)
+MAKE_ORDER_ONLY_DEPS	+= $(LIBKERNTEST)
 
 trunk-clean:: | lib-clean
 
diff --git a/testcases/kernel/mem/hugetlb/Makefile b/testcases/kernel/mem/hugetlb/Makefile
index 1e8f8f8..0fbc0dd 100644
--- a/testcases/kernel/mem/hugetlb/Makefile
+++ b/testcases/kernel/mem/hugetlb/Makefile
@@ -30,7 +30,7 @@ $(LIBDIR):
 $(LIB): $(LIBDIR)
 	$(MAKE) -C $^ -f "$(abs_srcdir)/$^/Makefile" all
 
-MAKE_DEPS		:= $(LIB)
+MAKE_NORMAL_DEPS	:= $(LIB)
 
 trunk-clean:: | lib-clean
 
diff --git a/testcases/kernel/mem/hugetlb/Makefile.inc b/testcases/kernel/mem/hugetlb/Makefile.inc
index cc0ada6..6b7983f 100644
--- a/testcases/kernel/mem/hugetlb/Makefile.inc
+++ b/testcases/kernel/mem/hugetlb/Makefile.inc
@@ -32,7 +32,7 @@ $(LIBIPC): $(LIBIPCDIR)
 CPPFLAGS		+= -I$(abs_srcdir)/$(LIBIPCDIR)
 LDFLAGS			+= -L$(abs_builddir)/$(LIBIPCDIR)
 LDLIBS			+= -lipc_hugetlb
-MAKE_DEPS		+= $(LIBIPC)
+MAKE_NORMAL_DEPS	+= $(LIBIPC)
 
 include $(top_srcdir)/testcases/kernel/mem/include/libmem.mk
 # vim: syntax=make
diff --git a/testcases/kernel/mem/include/libmem.mk b/testcases/kernel/mem/include/libmem.mk
index 4503e78..8b84b6c 100644
--- a/testcases/kernel/mem/include/libmem.mk
+++ b/testcases/kernel/mem/include/libmem.mk
@@ -33,7 +33,7 @@ $(LIBMEM_DIR):
 $(LIBMEM): $(LIBMEM_DIR)
 	$(MAKE) -C $^ -f "$(LIBMEM_SRCDIR)/Makefile" all
 
-MAKE_DEPS		+= $(LIBMEM)
+MAKE_NORMAL_DEPS	+= $(LIBMEM)
 
 trunk-clean:: | lib-clean
 
diff --git a/testcases/kernel/power_management/Makefile b/testcases/kernel/power_management/Makefile
index 24f75f8..f3289d2 100644
--- a/testcases/kernel/power_management/Makefile
+++ b/testcases/kernel/power_management/Makefile
@@ -26,6 +26,6 @@ vpath %.c $(srcdir):$(top_srcdir)/lib
 
 INSTALL_TARGETS		:= lib/*.py *.py *.sh
 
-MAKE_DEPS		+= $(APICMDS_DIR)/tst_kvercmp
+MAKE_NORMAL_DEPS	+= $(APICMDS_DIR)/tst_kvercmp
 
 include $(top_srcdir)/include/mk/generic_leaf_target.mk
diff --git a/testcases/kernel/syscalls/ipc/Makefile b/testcases/kernel/syscalls/ipc/Makefile
index 42492db..4a5ce2d 100644
--- a/testcases/kernel/syscalls/ipc/Makefile
+++ b/testcases/kernel/syscalls/ipc/Makefile
@@ -30,7 +30,7 @@ $(LIBDIR):
 $(LIB): $(LIBDIR)
 	$(MAKE) -C $^ -f "$(abs_srcdir)/$^/Makefile" all
 
-MAKE_DEPS		:= $(LIB)
+MAKE_NORMAL_DEPS		:= $(LIB)
 
 trunk-clean:: | lib-clean
 
diff --git a/testcases/kernel/syscalls/ipc/Makefile.inc b/testcases/kernel/syscalls/ipc/Makefile.inc
index c7890a9..ed8a086 100644
--- a/testcases/kernel/syscalls/ipc/Makefile.inc
+++ b/testcases/kernel/syscalls/ipc/Makefile.inc
@@ -33,7 +33,7 @@ $(LIBDIR):
 $(LIBIPC): $(LIBDIR)
 	$(MAKE) -C $^ -f "$(abs_srcdir)/$^/Makefile" all
 
-MAKE_DEPS		:= $(LIBIPC)
+MAKE_NORMAL_DEPS	:= $(LIBIPC)
 
 CPPFLAGS		+= -I$(abs_srcdir)/$(LIBDIR)
 
diff --git a/testcases/kernel/syscalls/ipc/msgctl/Makefile b/testcases/kernel/syscalls/ipc/msgctl/Makefile
index 4472eeb..d38cbe8 100644
--- a/testcases/kernel/syscalls/ipc/msgctl/Makefile
+++ b/testcases/kernel/syscalls/ipc/msgctl/Makefile
@@ -23,7 +23,7 @@ include $(top_srcdir)/include/mk/testcases.mk
 LIBMSGCTL               := $(LIBDIR)/libmsgctl.a
 LDLIBS                  += -lmsgctl
 
-MAKE_DEPS               := $(LIBMSGCTL)
+MAKE_NORMAL_DEPS	:= $(LIBMSGCTL)
 
 include $(abs_srcdir)/../Makefile.inc
 include $(top_srcdir)/include/mk/generic_leaf_target.mk
diff --git a/testcases/kernel/syscalls/kill/Makefile b/testcases/kernel/syscalls/kill/Makefile
index 23dabfc..f413fe6 100644
--- a/testcases/kernel/syscalls/kill/Makefile
+++ b/testcases/kernel/syscalls/kill/Makefile
@@ -32,7 +32,7 @@ $(LIBDIR):
 $(LIB): $(LIBDIR)
 	$(MAKE) -C $^ -f "$(abs_srcdir)/$^/Makefile" all
 
-MAKE_DEPS		:= $(LIB)
+MAKE_NORMAL_DEPS	:= $(LIB)
 
 CPPFLAGS                += -I$(abs_srcdir)/$(LIBDIR)
 
diff --git a/testcases/kernel/syscalls/mremap/Makefile b/testcases/kernel/syscalls/mremap/Makefile
index 102e473..f20c4c5 100644
--- a/testcases/kernel/syscalls/mremap/Makefile
+++ b/testcases/kernel/syscalls/mremap/Makefile
@@ -32,7 +32,7 @@ $(LIBDIR):
 $(LIB): $(LIBDIR)
 	$(MAKE) -C $^ -f "$(abs_srcdir)/$^/Makefile" all
 
-MAKE_DEPS		:= $(LIB)
+MAKE_NORMAL_DEPS	:= $(LIB)
 
 CPPFLAGS                += -I$(abs_srcdir)/$(LIBDIR)
 
diff --git a/testcases/network/rpc/basic_tests/rpc01/Makefile b/testcases/network/rpc/basic_tests/rpc01/Makefile
index b07e14e..4687675 100644
--- a/testcases/network/rpc/basic_tests/rpc01/Makefile
+++ b/testcases/network/rpc/basic_tests/rpc01/Makefile
@@ -46,6 +46,6 @@ lib-clean:: $(LIBDIR)
 	$(MAKE) -C $^ -f "$(abs_srcdir)/$^/Makefile" clean
 
 MAKE_TARGETS		:= rpc1 rpc_server
-MAKE_DEPS		:= $(LIB)
+MAKE_NORMAL_DEPS	:= $(LIB)
 
 include $(top_srcdir)/include/mk/generic_trunk_target.mk
diff --git a/testcases/network/rpc/rpc-tirpc/tests_pack/Makefile.inc b/testcases/network/rpc/rpc-tirpc/tests_pack/Makefile.inc
index ff6b2e0..7db45d4 100644
--- a/testcases/network/rpc/rpc-tirpc/tests_pack/Makefile.inc
+++ b/testcases/network/rpc/rpc-tirpc/tests_pack/Makefile.inc
@@ -27,7 +27,7 @@ $(LIBDDIR):
 $(LIBRPC-TIRPC): $(LIBDIR)
 	$(MAKE) -C $^ -f "$(LIBSRCDIR)/Makefile" all
 
-MAKE_DEPS	+= $(LIBRPC-TIRPC)
+MAKE_NORMAL_DEPS	+= $(LIBRPC-TIRPC)
 
 LDFLAGS		+= -L$(LIBDIR)
 LDLIBS		+= $(TIRPC_LIBS) -lrpc-tirpc
diff --git a/testcases/network/tcp_cmds/Makefile.inc b/testcases/network/tcp_cmds/Makefile.inc
index 8ef8717..8c10599 100644
--- a/testcases/network/tcp_cmds/Makefile.inc
+++ b/testcases/network/tcp_cmds/Makefile.inc
@@ -22,9 +22,9 @@
 
 GENERATE_FILE_DIR	:= ../..
 
-MAKE_DEPS		:= $(GENERATE_FILE_DIR)/datafiles/bin.sm
+MAKE_ORDER_ONLY_DEPS	:= $(GENERATE_FILE_DIR)/datafiles/bin.sm
 
-$(MAKE_DEPS):
+$(MAKE_ORDER_ONLY_DEPS):
 	$(MAKE) -C $(GENERATE_FILE_DIR) \
 	    -f "$(abs_srcdir)/$(GENERATE_FILE_DIR)/Makefile" generate
 
-- 
1.8.2.1


------------------------------------------------------------------------------
"Accelerate Dev Cycles with Automated Cross-Browser Testing - For FREE
Instantly run your Selenium tests across 300+ browser/OS combos.
Get unparalleled scalability from the best Selenium testing platform available
Simple to use. Nothing to install. Get started now for free."
http://p.sf.net/sfu/SauceLabs
_______________________________________________
Ltp-list mailing list
Ltp-list@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/ltp-list
