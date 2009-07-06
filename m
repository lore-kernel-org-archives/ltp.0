Return-Path: <ltp-list-bounces@lists.sourceforge.net>
Received: from sfi-mx-2.v28.ch3.sourceforge.com ([172.29.28.122]
	helo=mx.sourceforge.net)
	by 335xhf1.ch3.sourceforge.com with esmtp (Exim 4.69)
	(envelope-from <gomuthuk@linux.vnet.ibm.com>) id 1MNlEz-0000OK-VT
	for ltp-list@lists.sourceforge.net; Mon, 06 Jul 2009 10:16:05 +0000
Received: from e28smtp07.in.ibm.com ([59.145.155.7])
	by 72vjzd1.ch3.sourceforge.com with esmtps (TLSv1:AES256-SHA:256)
	(Exim 4.69) id 1MNlEx-0008OK-6X
	for ltp-list@lists.sourceforge.net; Mon, 06 Jul 2009 10:16:05 +0000
Message-ID: <4A51CEDC.6080605@linux.vnet.ibm.com>
Date: Mon, 06 Jul 2009 15:45:56 +0530
From: gowrishankar <gomuthuk@linux.vnet.ibm.com>
MIME-Version: 1.0
Content-Type: multipart/mixed; boundary="------------090302030907020900070709"
Subject: [LTP] [PATCH] cgroups: conditionally enable building cgroup tests
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
To: subrata@linux.vnet.ibm.com
Cc: ltp-list@lists.sf.net

This is a multi-part message in MIME format.
--------------090302030907020900070709
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit

Hi Subrata,
Please accept the patch below.

Thanks,
Gowri
---
cgroups: conditionally enable building cgroup tests

controllers tests gets included into default ltp build if "/proc/cgroup"
exists. It stops the ltp build in realtime kernel environment where kernel
is new and supports cgroups, but necessary file "linux/cgroupstats.h" may not
exist in the base OS (like RHEL5.3). So configure command enables the build,
but actual build fails, due to missing header file.

Below patch proposes new symbol LTP_CHECK_CGROUPSTATS to check for header file
"linux/cgroupstats.h" and include controllers in the list of tests to build.

Tested the patch in non-RT as well as RT environment for the changes.

Signed-off-by: Gowrishankar <gowrishankar.m@in.ibm.com>
Tested-by: Gowrishankar <gowrishankar.m@in.ibm.com>
---


--------------090302030907020900070709
Content-Type: text/x-patch;
 name="controllers-build.patch"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="controllers-build.patch"

Index: ltp-full-20090630/m4/ltp-cgroupstats.m4
===================================================================
--- /dev/null	1970-01-01 00:00:00.000000000 +0000
+++ ltp-full-20090630/m4/ltp-cgroupstats.m4	2009-07-03 13:41:55.000000000 +0530
@@ -0,0 +1,9 @@
+dnl
+dnl LTP_CHECK_CGROUPSTATS
+dnl ----------------------------
+dnl
+AC_DEFUN([LTP_CHECK_CGROUPSTATS],
+[dnl
+AC_CHECK_HEADERS(linux/cgroupstats.h,[LTP_CHECK_CGROUPSTATS_HEADER=yes])
+AC_SUBST(LTP_CHECK_CGROUPSTATS_HEADER)
+])
Index: ltp-full-20090630/configure.ac
===================================================================
--- ltp-full-20090630.orig/configure.ac	2009-07-03 13:59:48.000000000 +0530
+++ ltp-full-20090630/configure.ac	2009-07-03 14:00:14.000000000 +0530
@@ -21,5 +21,6 @@
 LTP_CHECK_SELINUX
 LTP_CHECK_CRYPTO
 LTP_CHECK_TASKSTATS
+LTP_CHECK_CGROUPSTATS
 
 AC_OUTPUT
Index: ltp-full-20090630/testcases/kernel/Makefile
===================================================================
--- ltp-full-20090630.orig/testcases/kernel/Makefile	2009-07-03 14:01:25.000000000 +0530
+++ ltp-full-20090630/testcases/kernel/Makefile	2009-07-03 14:02:42.000000000 +0530
@@ -1,6 +1,12 @@
-SUBDIRS = power_management numa containers controllers connectors include fs io ipc mem pty sched security syscalls timers
+include ../../config.mk
+
+SUBDIRS = power_management numa containers connectors include fs io ipc mem pty sched security syscalls timers
 UCLINUX_SUBDIRS = include syscalls
 
+ifeq ($(LTP_CHECK_CGROUPSTATS_HEADER),yes)
+	SUBDIRS+= controllers
+endif
+
 all:
 	@set -e; for i in $(SUBDIRS); do $(MAKE) -C $$i ; done
 

--------------090302030907020900070709
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

------------------------------------------------------------------------------

--------------090302030907020900070709
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
Ltp-list mailing list
Ltp-list@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/ltp-list

--------------090302030907020900070709--

