Return-Path: <ltp-list-bounces@lists.sourceforge.net>
Received: from sog-mx-2.v43.ch3.sourceforge.com ([172.29.43.192]
	helo=mx.sourceforge.net)
	by sfs-ml-3.v29.ch3.sourceforge.com with esmtp (Exim 4.76)
	(envelope-from <wangxg.fnst@cn.fujitsu.com>) id 1WD8QC-0004GL-HS
	for ltp-list@lists.sourceforge.net; Tue, 11 Feb 2014 08:10:24 +0000
Received: from [222.73.24.84] (helo=song.cn.fujitsu.com)
	by sog-mx-2.v43.ch3.sourceforge.com with esmtp (Exim 4.76)
	id 1WD8Q6-0000hv-PH
	for ltp-list@lists.sourceforge.net; Tue, 11 Feb 2014 08:10:24 +0000
Received: from fnstmail02.fnst.cn.fujitsu.com (tang.cn.fujitsu.com [127.0.0.1])
	by tang.cn.fujitsu.com (8.14.3/8.13.1) with ESMTP id s1B8A1cD028569
	for <ltp-list@lists.sourceforge.net>; Tue, 11 Feb 2014 16:10:01 +0800
From: Xiaoguang Wang <wangxg.fnst@cn.fujitsu.com>
Date: Tue, 11 Feb 2014 16:08:41 +0800
Message-Id: <1392106121-5480-4-git-send-email-wangxg.fnst@cn.fujitsu.com>
In-Reply-To: <1392106121-5480-1-git-send-email-wangxg.fnst@cn.fujitsu.com>
References: <1392106121-5480-1-git-send-email-wangxg.fnst@cn.fujitsu.com>
Subject: [LTP] [PATCH v2 4/4] module/delete_module: make delete_module tests
	run default
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

module/delete_module/Makefile: make some fixes to conform to
module compile in kernel 2.6 series and higher

testcases/kernel/Makefile: make it include module test

Signed-off-by: Xiaoguang Wang <wangxg.fnst@cn.fujitsu.com>
---
 scenario_groups/default                        |  1 +
 testcases/kernel/Makefile                      |  1 +
 testcases/kernel/module/delete_module/Makefile | 35 ++++++++------------------
 3 files changed, 13 insertions(+), 24 deletions(-)

diff --git a/scenario_groups/default b/scenario_groups/default
index 9eca8ad..ff23c7c 100644
--- a/scenario_groups/default
+++ b/scenario_groups/default
@@ -25,3 +25,4 @@ hugetlb
 commands
 hyperthreading
 kernel_misc
+modules
diff --git a/testcases/kernel/Makefile b/testcases/kernel/Makefile
index fa6a191..6bffe79 100644
--- a/testcases/kernel/Makefile
+++ b/testcases/kernel/Makefile
@@ -53,6 +53,7 @@ SUBDIRS			+= connectors \
 			   security \
 			   timers \
 			   tracing \
+			   module \
 
 ifeq ($(WITH_POWER_MANAGEMENT_TESTSUITE),yes)
 SUBDIRS			+= power_management
diff --git a/testcases/kernel/module/delete_module/Makefile b/testcases/kernel/module/delete_module/Makefile
index 83b1648..95693b1 100644
--- a/testcases/kernel/module/delete_module/Makefile
+++ b/testcases/kernel/module/delete_module/Makefile
@@ -18,36 +18,23 @@
 # description		 : make file for the delete_module(2) testcases	  #
 ###########################################################################
 
-top_srcdir		?= ../../../..
-
-include $(top_srcdir)/include/mk/testcases.mk
-
-CFLAGS			+= -D_GNU_SOURCE
+ifneq ($(KERNELRELEASE),)
 
-LOCALVERSION		?= $(shell uname -r)
+obj-m := dummy_del_mod.o dummy_del_mod_dep.o
 
-MODULEDIR		:= $(DESTDIR)/lib/modules/$(LOCALVERSION)/build
+else
 
-# KBuild make variables...
-MODCFLAGS		+= $(MODULEDIR)
+top_srcdir		?= ../../../..
 
-export EXTRA_CFLAGS	:= $(CFLAGS)
-export EXTRA_CPPFLAGS	:= $(CPPFLAGS)
-export EXTRA_LDFLAGS	:= $(LDFLAGS)
+include $(top_srcdir)/include/mk/testcases.mk
 
-obj-m			:= dummy_del_mod.o dummy_del_mod_dep.o
-MODULES			:= dummy_del_mod.ko dummy_del_mod_dep.ko
+REQ_VERSION_MAJOR	:= 2
+REQ_VERSION_PATCH	:= 6
 
-# New make infra variables...
-CLEAN_TARGETS		:= .dummy* *.mod.c .tmp_version *.ko
-INSTALL_TARGETS		:= $(MODULES)
-MAKE_TARGETS		:= delete_module01 delete_module02 delete_module03
+MAKE_TARGETS		:= delete_module01 delete_module02 delete_module03 \
+			   dummy_del_mod.ko dummy_del_mod_dep.ko
 
+include $(top_srcdir)/include/mk/module.mk
 include $(top_srcdir)/include/mk/generic_leaf_target.mk
 
-$(MAKE_TARGETS): | make-module
-
-# KBuild will gripe because we redefine CFLAGS if KBUILD_NOPEDANTIC isn't set.
-.PHONY: make-module
-make-module:
-	make -C $(MODULEDIR) KBUILD_NOPEDANTIC=1 SUBDIRS=$(abs_srcdir) modules
+endif
-- 
1.8.2.1


------------------------------------------------------------------------------
Android apps run on BlackBerry 10
Introducing the new BlackBerry 10.2.1 Runtime for Android apps.
Now with support for Jelly Bean, Bluetooth, Mapview and more.
Get your Android app in front of a whole new audience.  Start now.
http://pubads.g.doubleclick.net/gampad/clk?id=124407151&iu=/4140/ostg.clktrk
_______________________________________________
Ltp-list mailing list
Ltp-list@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/ltp-list
