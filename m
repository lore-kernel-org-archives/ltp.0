Return-Path: <ltp-list-bounces@lists.sourceforge.net>
Received: from sfi-mx-3.v28.ch3.sourceforge.com ([172.29.28.123]
	helo=mx.sourceforge.net)
	by 3yr0jf1.ch3.sourceforge.com with esmtp (Exim 4.69)
	(envelope-from <subrata@linux.vnet.ibm.com>) id 1MavBR-0006OZ-Vb
	for ltp-list@lists.sourceforge.net; Tue, 11 Aug 2009 17:30:49 +0000
Received: from e35.co.us.ibm.com ([32.97.110.153])
	by 3b2kzd1.ch3.sourceforge.com with esmtps (TLSv1:AES256-SHA:256)
	(Exim 4.69) id 1MavBN-00055m-PJ
	for ltp-list@lists.sourceforge.net; Tue, 11 Aug 2009 17:30:49 +0000
Received: from d03relay02.boulder.ibm.com (d03relay02.boulder.ibm.com
	[9.17.195.227])
	by e35.co.us.ibm.com (8.14.3/8.13.1) with ESMTP id n7BHLjlf009747
	for <ltp-list@lists.sourceforge.net>; Tue, 11 Aug 2009 11:21:45 -0600
Received: from d03av03.boulder.ibm.com (d03av03.boulder.ibm.com [9.17.195.169])
	by d03relay02.boulder.ibm.com (8.13.8/8.13.8/NCO v10.0) with ESMTP id
	n7BHUQ9X243138
	for <ltp-list@lists.sourceforge.net>; Tue, 11 Aug 2009 11:30:27 -0600
Received: from d03av03.boulder.ibm.com (loopback [127.0.0.1])
	by d03av03.boulder.ibm.com (8.12.11.20060308/8.13.3) with ESMTP id
	n7BHUG5U030084
	for <ltp-list@lists.sourceforge.net>; Tue, 11 Aug 2009 11:30:17 -0600
From: Subrata Modak <subrata@linux.vnet.ibm.com>
Date: Tue, 11 Aug 2009 23:00:09 +0530
Message-Id: <20090811173009.7074.3994.sendpatchset@subratamodak.linux.ibm.com>
In-Reply-To: <20090811172957.7074.62874.sendpatchset@subratamodak.linux.ibm.com>
References: <20090811172957.7074.62874.sendpatchset@subratamodak.linux.ibm.com>
Subject: [LTP] [PATCH 01/05] Provide all necessary information through
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

Signed-off-by: Subrata Modak <subrata@linux.vnet.ibm.com>
---

--- ltp-full-20090731.orig/README	2009-08-11 21:54:21.000000000 +0530
+++ ltp-full-20090731/README	2009-08-11 21:53:00.000000000 +0530
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
+/debug/fail_io_timeout/interval
+/debug/fail_io_timeout/probability
+/debug/fail_io_timeout/reject-end
+/debug/fail_io_timeout/reject-start
+/debug/fail_io_timeout/require-end
+/debug/fail_io_timeout/require-start
+/debug/fail_io_timeout/space
+/debug/fail_io_timeout/stacktrace-depth
+/debug/fail_io_timeout/task-filter
+/debug/fail_io_timeout/times
+/debug/fail_io_timeout/verbose
+
+/debug/fail_make_request/interval
+/debug/fail_make_request/probability
+/debug/fail_make_request/reject-end
+/debug/fail_make_request/reject-start
+/debug/fail_make_request/require-end
+/debug/fail_make_request/require-start
+/debug/fail_make_request/space
+/debug/fail_make_request/stacktrace-depth
+/debug/fail_make_request/task-filter
+/debug/fail_make_request/times
+/debug/fail_make_request/verbose
+
+/debug/fail_page_alloc/ignore-gfp-highmem
+/debug/fail_page_alloc/ignore-gfp-wait
+/debug/fail_page_alloc/interval
+/debug/fail_page_alloc/min-order
+/debug/fail_page_alloc/probability
+/debug/fail_page_alloc/reject-end
+/debug/fail_page_alloc/reject-start
+/debug/fail_page_alloc/require-end
+/debug/fail_page_alloc/require-start
+/debug/fail_page_alloc/space
+/debug/fail_page_alloc/stacktrace-depth
+/debug/fail_page_alloc/task-filter
+/debug/fail_page_alloc/times
+/debug/fail_page_alloc/verbose
+
+/debug/failslab/ignore-gfp-wait
+/debug/failslab/interval
+/debug/failslab/probability
+/debug/failslab/reject-end
+/debug/failslab/reject-start
+/debug/failslab/require-end
+/debug/failslab/require-start
+/debug/failslab/space
+/debug/failslab/stacktrace-depth
+/debug/failslab/task-filter
+/debug/failslab/times
+/debug/failslab/verbose
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
+debugfs		/debug		debugfs
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
