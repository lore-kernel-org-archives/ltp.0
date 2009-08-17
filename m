Return-Path: <ltp-list-bounces@lists.sourceforge.net>
Received: from sfi-mx-3.v28.ch3.sourceforge.com ([172.29.28.123]
	helo=mx.sourceforge.net)
	by 335xhf1.ch3.sourceforge.com with esmtp (Exim 4.69)
	(envelope-from <subrata@linux.vnet.ibm.com>) id 1Md11r-0004e3-Mk
	for ltp-list@lists.sourceforge.net; Mon, 17 Aug 2009 12:09:35 +0000
Received: from e2.ny.us.ibm.com ([32.97.182.142])
	by 3b2kzd1.ch3.sourceforge.com with esmtps (TLSv1:AES256-SHA:256)
	(Exim 4.69) id 1Md11n-0001Zg-Gt
	for ltp-list@lists.sourceforge.net; Mon, 17 Aug 2009 12:09:35 +0000
Received: from d01relay04.pok.ibm.com (d01relay04.pok.ibm.com [9.56.227.236])
	by e2.ny.us.ibm.com (8.14.3/8.13.1) with ESMTP id n7HC3J0j027095
	for <ltp-list@lists.sourceforge.net>; Mon, 17 Aug 2009 08:03:19 -0400
Received: from d01av01.pok.ibm.com (d01av01.pok.ibm.com [9.56.224.215])
	by d01relay04.pok.ibm.com (8.13.8/8.13.8/NCO v10.0) with ESMTP id
	n7HC9FNq222488
	for <ltp-list@lists.sourceforge.net>; Mon, 17 Aug 2009 08:09:15 -0400
Received: from d01av01.pok.ibm.com (loopback [127.0.0.1])
	by d01av01.pok.ibm.com (8.12.11.20060308/8.13.3) with ESMTP id
	n7HC9FN6005764
	for <ltp-list@lists.sourceforge.net>; Mon, 17 Aug 2009 08:09:15 -0400
From: Subrata Modak <subrata@linux.vnet.ibm.com>
Date: Mon, 17 Aug 2009 17:38:59 +0530
Message-Id: <20090817120857.8902.12069.sendpatchset@subratamodak.linux.ibm.com>
In-Reply-To: <20090817120835.8902.4597.sendpatchset@subratamodak.linux.ibm.com>
References: <20090817120835.8902.4597.sendpatchset@subratamodak.linux.ibm.com>
Subject: [LTP] [PATCH v2 01/05] Provide all necessary information through
	ltp/README
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
To: LTP Mailing List <ltp-list@lists.sourceforge.net>
Cc: Sachin P Sant <sachinp@linux.vnet.ibm.com>, Mike Frysinger <vapier@gentoo.org>, Michael Reed <mreed10@us.ibm.com>, Nate Straz <nate@refried.org>, Paul Larson <paul.larson@ubuntu.com>, Manoj Iyer <manoj.iyer@ubuntu.com>, Balbir Singh <balbir@linux.vnet.ibm.com>

Provide all necessary information to create/use "Fault Injection Framework"
through ltp/README. This is necessary before any test case(s) can be run
on this harness. Also describes the general algorithm that would be followed
while running LTP tests in "Fault Injection" harness.

Changed the debugfs mount point from /debug/ to /sys/kernel/debug/ as
pointed out by Mike.

Signed-off-by: Subrata Modak<subrata@linux.vnet.ibm.com>
---

--- ltp-full-20090731.orig/README	2009-08-17 10:46:41.000000000 +0530
+++ ltp-full-20090731/README	2009-08-17 11:01:00.000000000 +0530
@@ -272,7 +272,6 @@ The tests also require CUnit Framework t
 http://sourceforge.net/projects/cunit/
 ---------------------------------
 ---------------------------------
-
 Native language support (nls) testsuite requirements
 ----------------------------------------------------
 CONFIG_NLS=m
@@ -287,4 +286,111 @@ CONFIG_CAN_BCM=m
 # CAN Device Drivers
 CONFIG_CAN_VCAN=m
 ---------------------------------
+Enabling Fault Injection Support for your kernel (version 2.6.29).
+Please check with the original kernel for the fault injection
+types it supports. Following supports will be available:
+
+/sys/kernel/debug/fail_io_timeout/interval
+/sys/kernel/debug/fail_io_timeout/probability
+/sys/kernel/debug/fail_io_timeout/reject-end
+/sys/kernel/debug/fail_io_timeout/reject-start
+/sys/kernel/debug/fail_io_timeout/require-end
+/sys/kernel/debug/fail_io_timeout/require-start
+/sys/kernel/debug/fail_io_timeout/space
+/sys/kernel/debug/fail_io_timeout/stacktrace-depth
+/sys/kernel/debug/fail_io_timeout/task-filter
+/sys/kernel/debug/fail_io_timeout/times
+/sys/kernel/debug/fail_io_timeout/verbose
+
+/sys/kernel/debug/fail_make_request/interval
+/sys/kernel/debug/fail_make_request/probability
+/sys/kernel/debug/fail_make_request/reject-end
+/sys/kernel/debug/fail_make_request/reject-start
+/sys/kernel/debug/fail_make_request/require-end
+/sys/kernel/debug/fail_make_request/require-start
+/sys/kernel/debug/fail_make_request/space
+/sys/kernel/debug/fail_make_request/stacktrace-depth
+/sys/kernel/debug/fail_make_request/task-filter
+/sys/kernel/debug/fail_make_request/times
+/sys/kernel/debug/fail_make_request/verbose
+
+/sys/kernel/debug/fail_page_alloc/ignore-gfp-highmem
+/sys/kernel/debug/fail_page_alloc/ignore-gfp-wait
+/sys/kernel/debug/fail_page_alloc/interval
+/sys/kernel/debug/fail_page_alloc/min-order
+/sys/kernel/debug/fail_page_alloc/probability
+/sys/kernel/debug/fail_page_alloc/reject-end
+/sys/kernel/debug/fail_page_alloc/reject-start
+/sys/kernel/debug/fail_page_alloc/require-end
+/sys/kernel/debug/fail_page_alloc/require-start
+/sys/kernel/debug/fail_page_alloc/space
+/sys/kernel/debug/fail_page_alloc/stacktrace-depth
+/sys/kernel/debug/fail_page_alloc/task-filter
+/sys/kernel/debug/fail_page_alloc/times
+/sys/kernel/debug/fail_page_alloc/verbose
+
+/sys/kernel/debug/failslab/ignore-gfp-wait
+/sys/kernel/debug/failslab/interval
+/sys/kernel/debug/failslab/probability
+/sys/kernel/debug/failslab/reject-end
+/sys/kernel/debug/failslab/reject-start
+/sys/kernel/debug/failslab/require-end
+/sys/kernel/debug/failslab/require-start
+/sys/kernel/debug/failslab/space
+/sys/kernel/debug/failslab/stacktrace-depth
+/sys/kernel/debug/failslab/task-filter
+/sys/kernel/debug/failslab/times
+/sys/kernel/debug/failslab/verbose
+
+when the below kernel config options are set:
+
+CONFIG_FAULT_INJECTION=y
+CONFIG_DEBUG_KERNEL=y
+CONFIG_FAILSLAB=y (Fault-injection capability for kmalloc)
+(CONFIG_SLAB=y || CONFIG_SLUB=y) if CONFIG_FAILSLAB=y
+CONFIG_FAIL_PAGE_ALLOC=y (Fault-injection capabilitiy for alloc_pages())
+CONFIG_FAIL_MAKE_REQUEST=y (Fault-injection capability for disk IO)
+CONFIG_BLOCK=y if CONFIG_FAIL_MAKE_REQUEST=y
+CONFIG_FAIL_IO_TIMEOUT=y (Faul-injection capability for faking disk interrupts)
+CONFIG_BLOCK=y if CONFIG_FAIL_IO_TIMEOUT=y
+CONFIG_FAULT_INJECTION_DEBUG_FS=y (Debugfs entries for fault-injection capabilities)
+(CONFIG_SYSFS=y && CONFIG_DEBUG_FS=y) if CONFIG_FAULT_INJECTION_DEBUG_FS=y
+CONFIG_FAULT_INJECTION_STACKTRACE_FILTER=y (stacktrace filter for fault-injection capabilities)
+(CONFIG_FAULT_INJECTION_DEBUG_FS=y && CONFIG_STACKTRACE_SUPPORT=y && !CONFIG_X86_64) if
+	CONFIG_FAULT_INJECTION_STACKTRACE_FILTER=y
+
+For more information on Fault injection, please refer to:
+linux-2.6/Documentation/fault-injection/fault-injection.txt,
+
+You should also have made the following entries in your /etc/fstab file
+once the kernel is booted with the above CONFIG options set:
+
+debugfs		/sys/kernel/debug/		debugfs
+
+# How the Kernel Fault Injection works for LTP ?
+
+1) Build Kernel with all the above possible kernel CONFIG Options,
+2) Create the above entry in /etc/fstab file,
+3) Reboot in the new kernel,
+4) Goto LTPROOT. Build and Install LTP as per ltp/INSTALL file,
+5) Choose your own test(or default) to run with fault injection as follows:
+	./runltp -f <command_file> -F <LOOPS>,<FAULT_PROBABILITY>
+
+The agorithm will work as:
+loop (for each testcase)
+begin
+	execute_testcase(inside_stable_kernel)
+	begin
+		insert_fault_into_kernel()
+		loop X Times
+		begin
+			execute_testcase(inside_fault_kernel)
+		end
+		restore_kernel_to_normal()
+	end
+end
+
+# Eternal TODOs:
+1) Add as many framework as they get added/modifed in the kernel
+---------------------------------
 

---
Regards--
Subrata


------------------------------------------------------------------------------
Let Crystal Reports handle the reporting - Free Crystal Reports 2008 30-Day 
trial. Simplify your report design, integration and deployment - and focus on 
what you do best, core application coding. Discover what's new with 
Crystal Reports now.  http://p.sf.net/sfu/bobj-july
_______________________________________________
Ltp-list mailing list
Ltp-list@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/ltp-list
