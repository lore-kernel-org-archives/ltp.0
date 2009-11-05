Return-Path: <ltp-list-bounces@lists.sourceforge.net>
Received: from sfi-mx-1.v28.ch3.sourceforge.com ([172.29.28.121]
	helo=mx.sourceforge.net)
	by h25xhf1.ch3.sourceforge.com with esmtp (Exim 4.69)
	(envelope-from <chrubis@suse.de>) id 1N62F3-00052c-60
	for ltp-list@lists.sourceforge.net; Thu, 05 Nov 2009 13:19:09 +0000
Received: from relay2.suse.de (mail2.suse.de [195.135.221.8])
	by mx2.suse.de (Postfix) with ESMTP id D0321867E2
	for <ltp-list@lists.sourceforge.net>;
	Thu,  5 Nov 2009 14:18:52 +0100 (CET)
Date: Thu, 5 Nov 2009 14:18:52 +0100
From: Cyril Hrubis <chrubis@suse.cz>
Message-ID: <20091105131852.GA13908@schrodinger.suse.cz>
MIME-Version: 1.0
Content-Type: multipart/mixed; boundary="FCuugMFkClbJLl1L"
Content-Disposition: inline
Subject: [LTP] [PATCH] replacing -Wextra with -W
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
To: ltp-list@lists.sourceforge.net


--FCuugMFkClbJLl1L
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

Hi!
Lately gcc developers introduced -Wextra flag that does the same as -W but is
more descriptive. According to this using -W flag should be safe (as gcc is
backward compatlible) but using -Wextra is limited to newer gcc releases.

Attached patch replaces all -Wextra occurences with -W and thus fixes
compliation failures with older gcc (mine was gcc-3.3.3 on sles). 

Signed-off-by: chrubis@suse.cz

-- 
Cyril Hrubis
chrubis@suse.cz

--FCuugMFkClbJLl1L
Content-Type: text/x-patch; charset=us-ascii
Content-Disposition: attachment; filename="replace_wextra_with_w.patch"

Index: delme/testcases/kernel/controllers/cpuctl_fj/Makefile
===================================================================
--- delme.orig/testcases/kernel/controllers/cpuctl_fj/Makefile
+++ delme/testcases/kernel/controllers/cpuctl_fj/Makefile
@@ -25,7 +25,7 @@ top_srcdir		?= ../../../..
 include $(top_srcdir)/include/mk/testcases.mk
 include $(abs_srcdir)/../Makefile.inc
 
-CPPFLAGS		+= -Wall -O2 -Wextra
+CPPFLAGS		+= -Wall -O2 -W
 
 INSTALL_TARGETS		:= *.sh
 
Index: delme/testcases/kernel/device-drivers/v4l/kernel_space/Makefile
===================================================================
--- delme.orig/testcases/kernel/device-drivers/v4l/kernel_space/Makefile
+++ delme/testcases/kernel/device-drivers/v4l/kernel_space/Makefile
@@ -1,5 +1,5 @@
 
-EXTRA_CFLAGS += -Wall -Wextra -Wno-unused-parameter
+EXTRA_CFLAGS += -Wall -W -Wno-unused-parameter
 
 ifneq ($(KERNELRELEASE),)
 
Index: delme/testcases/kernel/device-drivers/v4l/user_space/Makefile
===================================================================
--- delme.orig/testcases/kernel/device-drivers/v4l/user_space/Makefile
+++ delme/testcases/kernel/device-drivers/v4l/user_space/Makefile
@@ -33,7 +33,7 @@
 # Released under GPL
 #
 
-CFLAGS = -O2 -Wall -Wextra
+CFLAGS = -O2 -Wall -W
 #CFLAGS += -g
 LDFLAGS = -lcunit
 
Index: delme/testcases/kernel/device-drivers/acpi/Makefile
===================================================================
--- delme.orig/testcases/kernel/device-drivers/acpi/Makefile
+++ delme/testcases/kernel/device-drivers/acpi/Makefile
@@ -6,7 +6,7 @@
 #
 
 #KERNELDIR := /usr/src/linux-2.5.64-gcov
-EXTRA_CFLAGS := -Wall -g -Wextra -Wno-unused-parameter
+EXTRA_CFLAGS := -Wall -g -W -Wno-unused-parameter
 
 ifneq ($(KERNELRELEASE),)
 
Index: delme/testcases/kernel/device-drivers/block/kernel_space/Makefile
===================================================================
--- delme.orig/testcases/kernel/device-drivers/block/kernel_space/Makefile
+++ delme/testcases/kernel/device-drivers/block/kernel_space/Makefile
@@ -1,5 +1,5 @@
 
-EXTRA_CFLAGS += -Wall -Wextra -Wno-unused-parameter
+EXTRA_CFLAGS += -Wall -W -Wno-unused-parameter
 
 ifneq ($(KERNELRELEASE),)
 
Index: delme/testcases/kernel/device-drivers/misc_modules/per_cpu_allocator_module/Makefile
===================================================================
--- delme.orig/testcases/kernel/device-drivers/misc_modules/per_cpu_allocator_module/Makefile
+++ delme/testcases/kernel/device-drivers/misc_modules/per_cpu_allocator_module/Makefile
@@ -1,5 +1,5 @@
 
-EXTRA_CFLAGS += -Wall -Wextra -Wno-unused-parameter
+EXTRA_CFLAGS += -Wall -W -Wno-unused-parameter
 
 ifneq ($(KERNELRELEASE),)
 
Index: delme/testcases/kernel/device-drivers/nls/Makefile
===================================================================
--- delme.orig/testcases/kernel/device-drivers/nls/Makefile
+++ delme/testcases/kernel/device-drivers/nls/Makefile
@@ -2,7 +2,7 @@
 # Makefile for GCOV profiling kernel module
 #
 
-EXTRA_CFLAGS := -Wall -Wextra -Wno-unused-parameter
+EXTRA_CFLAGS := -Wall -W -Wno-unused-parameter
 
 ifneq ($(KERNELRELEASE),)
 
Index: delme/testcases/kernel/device-drivers/tbio/user_space/Makefile
===================================================================
--- delme.orig/testcases/kernel/device-drivers/tbio/user_space/Makefile
+++ delme/testcases/kernel/device-drivers/tbio/user_space/Makefile
@@ -1,5 +1,5 @@
 
-CFLAGS += -O2 -Wall -Wextra -g
+CFLAGS += -O2 -Wall -W -g
 OBJS = tbio_ki.o user_tbio.o
 
 test_bio: $(OBJS)
Index: delme/testcases/kernel/device-drivers/usb/tusb/Makefile
===================================================================
--- delme.orig/testcases/kernel/device-drivers/usb/tusb/Makefile
+++ delme/testcases/kernel/device-drivers/usb/tusb/Makefile
@@ -3,7 +3,7 @@
 #
 
 #KERNELDIR := /usr/src/linux-2.5.64-gcov
-EXTRA_CFLAGS := -Wall -Wextra -Wno-unused-parameter
+EXTRA_CFLAGS := -Wall -W -Wno-unused-parameter
 
 ifneq ($(KERNELRELEASE),)
 
Index: delme/testcases/kernel/controllers/cgroup_fj/Makefile
===================================================================
--- delme.orig/testcases/kernel/controllers/cgroup_fj/Makefile
+++ delme/testcases/kernel/controllers/cgroup_fj/Makefile
@@ -25,7 +25,7 @@ top_srcdir		?= ../../../..
 include $(top_srcdir)/include/mk/testcases.mk
 include $(abs_srcdir)/../Makefile.inc
 
-CPPFLAGS		+= -Wall -O2 -Wextra
+CPPFLAGS		+= -Wall -O2 -W
 
 INSTALL_TARGETS		:= *.sh
 

--FCuugMFkClbJLl1L
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

------------------------------------------------------------------------------
Let Crystal Reports handle the reporting - Free Crystal Reports 2008 30-Day 
trial. Simplify your report design, integration and deployment - and focus on 
what you do best, core application coding. Discover what's new with
Crystal Reports now.  http://p.sf.net/sfu/bobj-july
--FCuugMFkClbJLl1L
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
Ltp-list mailing list
Ltp-list@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/ltp-list

--FCuugMFkClbJLl1L--

