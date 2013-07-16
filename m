Return-Path: <ltp-list-bounces@lists.sourceforge.net>
Received: from sog-mx-2.v43.ch3.sourceforge.com ([172.29.43.192]
	helo=mx.sourceforge.net)
	by sfs-ml-2.v29.ch3.sourceforge.com with esmtp (Exim 4.76)
	(envelope-from <penght@cn.fujitsu.com>) id 1Uz17J-00067Q-Il
	for ltp-list@lists.sourceforge.net; Tue, 16 Jul 2013 09:00:17 +0000
Received: from [222.73.24.84] (helo=song.cn.fujitsu.com)
	by sog-mx-2.v43.ch3.sourceforge.com with esmtp (Exim 4.76)
	id 1Uz17F-0003PK-N5
	for ltp-list@lists.sourceforge.net; Tue, 16 Jul 2013 09:00:17 +0000
Received: from fnstmail02.fnst.cn.fujitsu.com (tang.cn.fujitsu.com [127.0.0.1])
	by tang.cn.fujitsu.com (8.14.3/8.13.1) with ESMTP id r6G8WD4k011621
	for <ltp-list@lists.sourceforge.net>; Tue, 16 Jul 2013 16:32:17 +0800
From: Peng Haitao <penght@cn.fujitsu.com>
Date: Tue, 16 Jul 2013 16:31:38 +0800
Message-Id: <1373963498-838-1-git-send-email-penght@cn.fujitsu.com>
Subject: [LTP] [PATCH] testcases/kernel/firmware: fix a bug of make install
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

When kernel version is before 3.7, the cases should be installed.

Signed-off-by: Peng Haitao <penght@cn.fujitsu.com>
---
 include/mk/config.mk.default                      |  1 +
 include/mk/config.mk.in                           |  1 +
 m4/ltp-kernel_devel.m4                            | 15 +++++++++++++++
 testcases/kernel/firmware/Makefile                | 23 -----------------------
 testcases/kernel/firmware/fw_load_kernel/Makefile |  6 +++++-
 testcases/kernel/firmware/fw_load_user/fw_load.c  |  6 ++++++
 6 files changed, 28 insertions(+), 24 deletions(-)

diff --git a/include/mk/config.mk.default b/include/mk/config.mk.default
index 953747c..ca203cb 100644
--- a/include/mk/config.mk.default
+++ b/include/mk/config.mk.default
@@ -78,5 +78,6 @@ LINUX_DIR		:=
 LINUX_VERSION_MAJOR	:=
 LINUX_VERSION_PATCH	:=
 WITH_MODULES		:= no
+LINUX_VERSION_AFTER	:= no
 
 export datarootdir includedir libdir mandir prefix
diff --git a/include/mk/config.mk.in b/include/mk/config.mk.in
index 96633f1..24052ff 100644
--- a/include/mk/config.mk.in
+++ b/include/mk/config.mk.in
@@ -80,6 +80,7 @@ LINUX_DIR		:= @LINUX_DIR@
 LINUX_VERSION_MAJOR	:= @LINUX_VERSION_MAJOR@
 LINUX_VERSION_PATCH	:= @LINUX_VERSION_PATCH@
 WITH_MODULES		:= @WITH_MODULES@
+LINUX_VERSION_AFTER	:= @LINUX_VERSION_AFTER@
 
 ifeq ($(strip $(prefix)),)
 $(error you are using $$(prefix) incorrectly -- set it to $(abs_top_srcdir) if you want to build in the source tree)
diff --git a/m4/ltp-kernel_devel.m4 b/m4/ltp-kernel_devel.m4
index ba53bc1..febe603 100644
--- a/m4/ltp-kernel_devel.m4
+++ b/m4/ltp-kernel_devel.m4
@@ -25,6 +25,8 @@ dnl requires kernel-devel installed
 dnl
 
 AC_DEFUN([LTP_CHECK_KERNEL_DEVEL],[dnl
+AH_TEMPLATE(LINUX_VERSION_AFTER,
+[Define to yes if kernel version is after 3.7.])
 
 AC_MSG_CHECKING([for kernel-devel])
 AC_ARG_WITH(
@@ -73,4 +75,17 @@ AC_ARG_WITH(
 			[])
 
 AC_SUBST(WITH_MODULES)
+
+REQ_VERSION_MAJOR=3
+REQ_VERSION_PATCH=7
+if test "x$WITH_MODULES" = "xyes"; then
+	if test ${LINUX_VERSION_MAJOR} -ge ${REQ_VERSION_MAJOR}; then
+		if test ${LINUX_VERSION_PATCH} -ge ${REQ_VERSION_PATCH}; then
+			LINUX_VERSION_AFTER="yes"
+			AC_DEFINE(LINUX_VERSION_AFTER)
+		fi
+	fi
+fi
+
+AC_SUBST(LINUX_VERSION_AFTER)
 ])
diff --git a/testcases/kernel/firmware/Makefile b/testcases/kernel/firmware/Makefile
index fbacf8d..03069b8 100644
--- a/testcases/kernel/firmware/Makefile
+++ b/testcases/kernel/firmware/Makefile
@@ -18,27 +18,4 @@ top_srcdir	?= ../../..
 
 include $(top_srcdir)/include/mk/env_pre.mk
 
-SUBDIRS			=
-REQ_VERSION_MAJOR	= 3
-REQ_VERSION_PATCH	= 7
-
-ifeq ($(MAKECMDGOALS),clean)
-SKIP = 0
-endif
-
-ifeq ($(WITH_MODULES),yes)
-SKIP ?= $(shell test $(LINUX_VERSION_MAJOR) -gt $(REQ_VERSION_MAJOR); echo $$?)
-ifeq ($(SKIP),1)
-SKIP = $(shell test $(LINUX_VERSION_MAJOR) -eq $(REQ_VERSION_MAJOR); echo $$?)
-ifeq ($(SKIP),0)
-SKIP = $(shell test $(LINUX_VERSION_PATCH) -ge $(REQ_VERSION_PATCH); echo $$?)
-endif
-endif
-endif
-
-ifeq ($(SKIP),0)
-SUBDIRS			+= fw_load_kernel
-SUBDIRS			+= fw_load_user
-endif
-
 include $(top_srcdir)/include/mk/generic_trunk_target.mk
diff --git a/testcases/kernel/firmware/fw_load_kernel/Makefile b/testcases/kernel/firmware/fw_load_kernel/Makefile
index 076d4ed..564501b 100644
--- a/testcases/kernel/firmware/fw_load_kernel/Makefile
+++ b/testcases/kernel/firmware/fw_load_kernel/Makefile
@@ -25,7 +25,11 @@ else
 top_srcdir	?= ../../../..
 include $(top_srcdir)/include/mk/env_pre.mk
 
-MAKE_TARGETS	:= ltp_fw_load.ko
+ifeq ($(LINUX_VERSION_AFTER),yes)
+	MAKE_TARGETS	:= ltp_fw_load.ko
+else
+	MAKE_TARGETS    :=
+endif
 
 # Ignoring the exit status of commands is done to be forward compatible with
 # kernel internal API changes. The user-space test will return TCONF, if it
diff --git a/testcases/kernel/firmware/fw_load_user/fw_load.c b/testcases/kernel/firmware/fw_load_user/fw_load.c
index 880531e..69b6d81 100644
--- a/testcases/kernel/firmware/fw_load_user/fw_load.c
+++ b/testcases/kernel/firmware/fw_load_user/fw_load.c
@@ -28,6 +28,7 @@
 #include <unistd.h>
 #include <string.h>
 
+#include "config.h"
 #include "test.h"
 #include "usctest.h"
 #include "safe_macros.h"
@@ -84,11 +85,16 @@ static void create_firmware(char *const fw_paths[]);
 
 int main(int argc, char *argv[])
 {
+#ifdef LINUX_VERSION_AFTER
 	setup(argc, argv);
 
 	test_run();
 
 	cleanup();
+#else
+	tst_resm(TCONF, "This device firmware loading is not supported");
+	tst_resm(TCONF, "before kernel 3.7");
+#endif
 
 	tst_exit();
 }
-- 
1.8.3.1


------------------------------------------------------------------------------
See everything from the browser to the database with AppDynamics
Get end-to-end visibility with application monitoring from AppDynamics
Isolate bottlenecks and diagnose root cause in seconds.
Start your free trial of AppDynamics Pro today!
http://pubads.g.doubleclick.net/gampad/clk?id=48808831&iu=/4140/ostg.clktrk
_______________________________________________
Ltp-list mailing list
Ltp-list@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/ltp-list
