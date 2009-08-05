Return-Path: <ltp-list-bounces@lists.sourceforge.net>
Received: from sfi-mx-2.v28.ch3.sourceforge.com ([172.29.28.122]
	helo=mx.sourceforge.net)
	by 3yr0jf1.ch3.sourceforge.com with esmtp (Exim 4.69)
	(envelope-from <subrata@linux.vnet.ibm.com>) id 1MYe9n-0007t6-P9
	for ltp-list@lists.sourceforge.net; Wed, 05 Aug 2009 10:55:43 +0000
Received: from e2.ny.us.ibm.com ([32.97.182.142])
	by 72vjzd1.ch3.sourceforge.com with esmtps (TLSv1:AES256-SHA:256)
	(Exim 4.69) id 1MYe9j-0001vr-Qu
	for ltp-list@lists.sourceforge.net; Wed, 05 Aug 2009 10:55:43 +0000
Received: from d01relay02.pok.ibm.com (d01relay02.pok.ibm.com [9.56.227.234])
	by e2.ny.us.ibm.com (8.14.3/8.13.1) with ESMTP id n75AnrtV014954
	for <ltp-list@lists.sourceforge.net>; Wed, 5 Aug 2009 06:49:53 -0400
Received: from d01av02.pok.ibm.com (d01av02.pok.ibm.com [9.56.224.216])
	by d01relay02.pok.ibm.com (8.13.8/8.13.8/NCO v10.0) with ESMTP id
	n75AtYCC258230
	for <ltp-list@lists.sourceforge.net>; Wed, 5 Aug 2009 06:55:34 -0400
Received: from d01av02.pok.ibm.com (loopback [127.0.0.1])
	by d01av02.pok.ibm.com (8.12.11.20060308/8.13.3) with ESMTP id
	n75AqlGj005518
	for <ltp-list@lists.sourceforge.net>; Wed, 5 Aug 2009 06:52:48 -0400
From: Subrata Modak <subrata@linux.vnet.ibm.com>
Date: Wed, 05 Aug 2009 16:25:29 +0530
Message-Id: <20090805105529.23399.60242.sendpatchset@subratamodak.linux.ibm.com>
Subject: [LTP] [PATCH] Integration of MCE test suite into LTP
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
To: Huang Ying <ying.huang@intel.com>
Cc: Andi Kleen <andi.kleen@intel.com>, ltp-list@lists.sourceforge.net

Hi Huang Ying,

>On Tue, 2009-06-30 at 10:56 +0800, Huang Ying wrote:
>Hi, All,
> 
> We are working on a test suite to test the Linux kernel MCE handling
> logic named mce-test, which can be find at:
> git://git.kernel.org/pub/scm/utils/cpu/mce/mce-test.git. There is a
> HOWTO for it, which is attached with the mail.
> 
> We think the testing target of mce-test is part of that of LTP, so it is
> better to integrate mce-test into LTP. Do you think so?
> 
> As for integration scheme, maybe we can first add mce-test into LTP as a
> separate test case, just as kdump test case. What's your opinions?
> 
> Any comment is welcome!
> 

Sorry for the very late response to your proposal. Please find below the
first patch which will integrate the existing mce-test to LTP. I had just
done a sanity checking of building it. The following patch will still need:

1) Exclusive testing and sharing those results with the LTP community,
2) Comments for and rewriting of this patch for coding styles,
3) Sign off from Huang Ying <ying.huang@intel.com>, or, the concerned Authors,

Patch-created-for-ltp-integration-by: Subrata Modak<subrata@linux.vnet.ibm.com>
Signed-off-by-is-still-required-from: Huang Ying <ying.huang@intel.com>
---

--- ltp-full-20090731.orig/testcases/mce-test/cases/soft-inj/non-panic/cases.sh	1970-01-01 05:30:00.000000000 +0530
+++ ltp-full-20090731/testcases/mce-test/cases/soft-inj/non-panic/cases.sh	2009-08-05 14:50:57.000000000 +0530
@@ -0,0 +1,55 @@
+#!/bin/sh
+#
+# Software injection based test cases - non-panic cases: test cases
+# are triggered via the mce-inject tool, and they will not trigger kernel
+# panic.
+#
+# Copyright (C) 2008, Intel Corp.
+#   Author: Huang Ying <ying.huang@intel.com>
+#
+# This file is released under the GPLv2.
+#
+
+. $ROOT/lib/functions.sh
+. $ROOT/lib/dirs.sh
+. $ROOT/lib/mce.sh
+. $ROOT/lib/soft-inject.sh
+
+enumerate()
+{
+    soft_inject_enumerate
+}
+
+trigger()
+{
+    soft_inject_trigger
+}
+
+get_result()
+{
+    soft_inject_get_klog
+    get_gcov arch/x86/kernel/cpu/mcheck/mce.c
+
+    case "$bcase" in
+	corrected|corrected_hold|corrected_over|corrected_no_en)
+	    get_mcelog_from_dev $mcelog_result
+	    ;;
+	*)
+	    echo '!!! Unknown case: $this_case !!!'
+    esac
+}
+
+verify()
+{
+    local removes="TSC TIME PROCESSOR"
+    case "$bcase" in
+	corrected|corrected_hold|corrected_over|corrected_no_en)
+	    soft_inject_verify_mcelog
+	    verify_klog $klog
+	    ;;
+	*)
+	    echo "!!! Unknown case: $this_case !!!"
+    esac
+}
+
+soft_inject_main "$@"
--- ltp-full-20090731.orig/testcases/mce-test/cases/soft-inj/non-panic/data/corrected	1970-01-01 05:30:00.000000000 +0530
+++ ltp-full-20090731/testcases/mce-test/cases/soft-inj/non-panic/data/corrected	2009-08-05 14:50:57.000000000 +0530
@@ -0,0 +1,14 @@
+# 
+# log corrected machine checks
+CPU 0 BANK 1
+STATUS CORRECTED
+ADDR 0xabcd
+HOLD
+CPU 1 BANK 0
+#  
+CPU 1 BANK 2
+STATUS CORRECTED
+MISC 0xabcd
+ADDR 0x1234
+HOLD
+CPU 0 BANK 0
--- ltp-full-20090731.orig/testcases/mce-test/cases/soft-inj/non-panic/data/corrected_hold	1970-01-01 05:30:00.000000000 +0530
+++ ltp-full-20090731/testcases/mce-test/cases/soft-inj/non-panic/data/corrected_hold	2009-08-05 14:50:57.000000000 +0530
@@ -0,0 +1,10 @@
+# 
+# log two corrected machine checks
+CPU 0 BANK 1
+STATUS CORRECTED
+ADDR 0xabcd
+HOLD
+#  
+CPU 1 BANK 2
+STATUS CORRECTED
+ADDR 0x1234
--- ltp-full-20090731.orig/testcases/mce-test/cases/soft-inj/non-panic/data/corrected_no_en	1970-01-01 05:30:00.000000000 +0530
+++ ltp-full-20090731/testcases/mce-test/cases/soft-inj/non-panic/data/corrected_no_en	2009-08-05 14:50:57.000000000 +0530
@@ -0,0 +1,5 @@
+#
+CPU 0 BANK 3
+STATUS VAL
+HOLD
+CPU 1 BANK 0
\ No newline at end of file
--- ltp-full-20090731.orig/testcases/mce-test/cases/soft-inj/non-panic/data/corrected_over	1970-01-01 05:30:00.000000000 +0530
+++ ltp-full-20090731/testcases/mce-test/cases/soft-inj/non-panic/data/corrected_over	2009-08-05 14:50:57.000000000 +0530
@@ -0,0 +1,4 @@
+CPU 0 BANK 2
+STATUS VAL OVER EN
+HOLD
+CPU 1 BANK 0
--- ltp-full-20090731.orig/testcases/mce-test/cases/soft-inj/panic/cases.sh	1970-01-01 05:30:00.000000000 +0530
+++ ltp-full-20090731/testcases/mce-test/cases/soft-inj/panic/cases.sh	2009-08-05 14:50:57.000000000 +0530
@@ -0,0 +1,89 @@
+#!/bin/sh
+#
+# Software injection based test cases - panic cases: test cases are
+# triggered via the mce-inject tool, and they will trigger kernel panic.
+#
+# Copyright (C) 2008, Intel Corp.
+#   Author: Huang Ying <ying.huang@intel.com>
+#
+# This file is released under the GPLv2.
+#
+
+. $ROOT/lib/functions.sh
+. $ROOT/lib/dirs.sh
+. $ROOT/lib/mce.sh
+. $ROOT/lib/soft-inject.sh
+
+enumerate()
+{
+    soft_inject_enumerate
+}
+
+trigger()
+{
+    reset_severity_cov
+    soft_inject_trigger
+}
+
+get_result()
+{
+    soft_inject_get_klog
+    get_gcov arch/x86/kernel/cpu/mcheck/mce.c
+    get_severity_cov
+
+    case "$bcase" in
+	fatal*)
+	    soft_inject_get_mcelog
+	    ;;
+	*)
+	    echo '!!! Unknown case: $this_case !!!'
+    esac
+}
+
+verify()
+{
+    local removes="TSC TIME PROCESSOR"
+    local curr_cpu_panic=": Fatal machine check on current CPU"
+    local fatal_panic="Fatal Machine check"
+    local pcc_exp="Processor context corrupt"
+    case "$bcase" in
+	fatal|fatal_irq|fatal_over)
+	    removes="$removes RIP"
+	    soft_inject_verify_mcelog
+	    verify_klog $klog
+	    soft_inject_verify_panic "$fatal_panic"
+	    soft_inject_verify_exp "$pcc_exp"
+	    ;;
+	fatal_ripv|fatal_eipv|fatal_userspace)
+	    soft_inject_verify_mcelog
+	    verify_klog $klog
+	    soft_inject_verify_panic "$fatal_panic"
+	    soft_inject_verify_exp "$pcc_exp"
+	    ;;
+	fatal_no_en)
+	    removes="$removes RIP"
+	    soft_inject_verify_mcelog
+	    verify_klog $klog
+	    soft_inject_verify_panic "Machine check from unknown source"
+	    ;;
+	fatal_timeout)
+	    removes="$removes RIP"
+	    soft_inject_verify_mcelog
+	    verify_klog $klog
+	    soft_inject_verify_panic "$curr_cpu_panic"
+	    soft_inject_verify_timeout
+	    soft_inject_verify_exp "$pcc_exp"
+	    ;;
+	fatal_timeout_ripv)
+	    soft_inject_verify_mcelog
+	    verify_klog $klog
+	    soft_inject_verify_panic "$curr_cpu_panic"
+	    soft_inject_verify_timeout
+	    soft_inject_verify_exp "$pcc_exp"
+	    ;;
+	*)
+	    echo "!!! Unknown case: $this_case !!!"
+    esac
+}
+
+soft_inject_main "$@"
--- ltp-full-20090731.orig/testcases/mce-test/cases/soft-inj/panic/data/fatal	1970-01-01 05:30:00.000000000 +0530
+++ ltp-full-20090731/testcases/mce-test/cases/soft-inj/panic/data/fatal	2009-08-05 14:50:57.000000000 +0530
@@ -0,0 +1,8 @@
+# WARNING
+# this will panic your machine!
+# don't try casually
+CPU 0 BANK 4
+MCGSTATUS MCIP
+STATUS FATAL
+RIP 12343434
+MISC 11
--- ltp-full-20090731.orig/testcases/mce-test/cases/soft-inj/panic/data/fatal_eipv	1970-01-01 05:30:00.000000000 +0530
+++ ltp-full-20090731/testcases/mce-test/cases/soft-inj/panic/data/fatal_eipv	2009-08-05 14:50:57.000000000 +0530
@@ -0,0 +1,7 @@
+# WARNING
+# this will panic your machine!
+# don't try casually
+CPU 1 BANK 4
+MCGSTATUS MCIP EIPV
+STATUS FATAL
+RIP 0x10:0x12343434
--- ltp-full-20090731.orig/testcases/mce-test/cases/soft-inj/panic/data/fatal_irq	1970-01-01 05:30:00.000000000 +0530
+++ ltp-full-20090731/testcases/mce-test/cases/soft-inj/panic/data/fatal_irq	2009-08-05 14:50:57.000000000 +0530
@@ -0,0 +1,9 @@
+# WARNING
+# this will panic your machine!
+# don't try casually
+CPU 0 BANK 4
+MCGSTATUS MCIP
+STATUS FATAL
+RIP 12343434
+MISC 11
+IN_IRQ
--- ltp-full-20090731.orig/testcases/mce-test/cases/soft-inj/panic/data/fatal_no_en	1970-01-01 05:30:00.000000000 +0530
+++ ltp-full-20090731/testcases/mce-test/cases/soft-inj/panic/data/fatal_no_en	2009-08-05 14:50:57.000000000 +0530
@@ -0,0 +1,8 @@
+# WARNING
+# this will panic your machine!
+# don't try casually
+CPU 0 BANK 4
+MCGSTATUS MCIP
+STATUS UC VAL PCC
+RIP 0x10:12343434
+MISC 11
--- ltp-full-20090731.orig/testcases/mce-test/cases/soft-inj/panic/data/fatal_over	1970-01-01 05:30:00.000000000 +0530
+++ ltp-full-20090731/testcases/mce-test/cases/soft-inj/panic/data/fatal_over	2009-08-05 14:50:57.000000000 +0530
@@ -0,0 +1,9 @@
+# WARNING
+# this will panic your machine!
+# don't try casually
+CPU 0 BANK 4
+MCGSTATUS MCIP
+STATUS FATAL OVER
+RIP 12343434
+MISC 11
+
--- ltp-full-20090731.orig/testcases/mce-test/cases/soft-inj/panic/data/fatal_ripv	1970-01-01 05:30:00.000000000 +0530
+++ ltp-full-20090731/testcases/mce-test/cases/soft-inj/panic/data/fatal_ripv	2009-08-05 14:50:57.000000000 +0530
@@ -0,0 +1,7 @@
+# WARNING
+# this will panic your machine!
+# don't try casually
+CPU 1 BANK 4
+MCGSTATUS MCIP RIPV
+STATUS FATAL
+RIP 0x10:0x12343434
--- ltp-full-20090731.orig/testcases/mce-test/cases/soft-inj/panic/data/fatal_timeout	1970-01-01 05:30:00.000000000 +0530
+++ ltp-full-20090731/testcases/mce-test/cases/soft-inj/panic/data/fatal_timeout	2009-08-05 14:50:57.000000000 +0530
@@ -0,0 +1,9 @@
+# WARNING
+# this will panic your machine!
+# don't try casually
+CPU 0 BANK 4
+MCGSTATUS MCIP
+STATUS FATAL
+RIP 0x10:0x12343434
+MISC 0xb
+NOBROADCAST
--- ltp-full-20090731.orig/testcases/mce-test/cases/soft-inj/panic/data/fatal_timeout_ripv	1970-01-01 05:30:00.000000000 +0530
+++ ltp-full-20090731/testcases/mce-test/cases/soft-inj/panic/data/fatal_timeout_ripv	2009-08-05 14:50:57.000000000 +0530
@@ -0,0 +1,9 @@
+# WARNING
+# this will panic your machine!
+# don't try casually
+CPU 0 BANK 4
+MCGSTATUS MCIP RIPV
+STATUS FATAL
+RIP 0x10:0x12343434
+MISC 0xb
+NOBROADCAST
--- ltp-full-20090731.orig/testcases/mce-test/cases/soft-inj/panic/data/fatal_userspace	1970-01-01 05:30:00.000000000 +0530
+++ ltp-full-20090731/testcases/mce-test/cases/soft-inj/panic/data/fatal_userspace	2009-08-05 14:50:57.000000000 +0530
@@ -0,0 +1,7 @@
+# WARNING
+# this will panic your machine!
+# don't try casually
+CPU 1 BANK 4
+MCGSTATUS MCIP EIPV
+STATUS FATAL
+RIP 0x73:0x12343434
--- ltp-full-20090731.orig/testcases/mce-test/cases/soft-inj/panic/refer/fatal_no_en	1970-01-01 05:30:00.000000000 +0530
+++ ltp-full-20090731/testcases/mce-test/cases/soft-inj/panic/refer/fatal_no_en	2009-08-05 14:50:57.000000000 +0530
@@ -0,0 +1 @@
+# empty mcelog
--- ltp-full-20090731.orig/testcases/mce-test/cases/soft-inj/panic_noser/cases.sh	1970-01-01 05:30:00.000000000 +0530
+++ ltp-full-20090731/testcases/mce-test/cases/soft-inj/panic_noser/cases.sh	2009-08-05 14:50:57.000000000 +0530
@@ -0,0 +1,61 @@
+#!/bin/sh
+#
+# Software injection based test cases: test cases are triggered via
+# the mce-inject tool.
+#
+# Copyright (C) 2009, Intel Corp.
+#   Author: Huang Ying <ying.huang@intel.com>
+#
+# This file is released under the GPLv2.
+#
+
+. $ROOT/lib/functions.sh
+. $ROOT/lib/dirs.sh
+. $ROOT/lib/mce.sh
+. $ROOT/lib/soft-inject.sh
+
+enumerate()
+{
+    soft_inject_enumerate
+}
+
+trigger()
+{
+    reset_severity_cov
+    soft_inject_trigger
+}
+
+get_result()
+{
+    soft_inject_get_klog
+    get_gcov arch/x86/kernel/cpu/mcheck/mce.c
+    soft_inject_get_mcelog
+    get_severity_cov
+}
+
+verify()
+{
+    local removes="TSC TIME PROCESSOR"
+    local over_exp="Overflowed uncorrected"
+    local fatal_panic=": Fatal Machine check"
+    local curr_cpu_panic=": Fatal machine check on current CPU"
+    case "$bcase" in
+	uc_over|uc_over_corrected)
+	    soft_inject_verify_mcelog
+	    verify_klog $klog
+	    soft_inject_verify_panic "$fatal_panic"
+	    soft_inject_verify_exp "$over_exp"
+	    ;;
+	uc_over_timeout)
+	    soft_inject_verify_mcelog
+	    verify_klog $klog
+	    soft_inject_verify_panic "$curr_cpu_panic"
+	    soft_inject_verify_exp "$over_exp"
+	    soft_inject_verify_timeout
+	    ;;
+	*)
+	    echo "!!! Unknown case: $this_case !!!"
+    esac
+}
+
+soft_inject_main "$@"
--- ltp-full-20090731.orig/testcases/mce-test/cases/soft-inj/panic_noser/data/uc_over	1970-01-01 05:30:00.000000000 +0530
+++ ltp-full-20090731/testcases/mce-test/cases/soft-inj/panic_noser/data/uc_over	2009-08-05 14:50:57.000000000 +0530
@@ -0,0 +1,6 @@
+# this should just kill the process
+CPU 0 BANK 2
+STATUS UNCORRECTED OVER
+MCGSTATUS RIPV EIPV MCIP
+ADDR 0x1234
+RIP 0x10:0xdeadbabe
--- ltp-full-20090731.orig/testcases/mce-test/cases/soft-inj/panic_noser/data/uc_over_corrected	1970-01-01 05:30:00.000000000 +0530
+++ ltp-full-20090731/testcases/mce-test/cases/soft-inj/panic_noser/data/uc_over_corrected	2009-08-05 14:50:57.000000000 +0530
@@ -0,0 +1,13 @@
+CPU 1 BANK 1
+MCGSTATUS RIPV MCIP
+STATUS CORRECTED
+RIP 0x13:0x12345678
+IN_PROC
+EXCP
+HOLD
+
+CPU 0 BANK 2
+STATUS UNCORRECTED OVER
+MCGSTATUS RIPV EIPV MCIP
+ADDR 0x1234
+RIP 0x10:0xdeadbabe
--- ltp-full-20090731.orig/testcases/mce-test/cases/soft-inj/panic_noser/data/uc_over_timeout	1970-01-01 05:30:00.000000000 +0530
+++ ltp-full-20090731/testcases/mce-test/cases/soft-inj/panic_noser/data/uc_over_timeout	2009-08-05 14:50:57.000000000 +0530
@@ -0,0 +1,6 @@
+CPU 0 BANK 2
+STATUS UNCORRECTED OVER
+MCGSTATUS RIPV EIPV MCIP
+ADDR 0x1234
+RIP 0x10:0xdeadbabe
+NOBROADCAST
--- ltp-full-20090731.orig/testcases/mce-test/cases/soft-inj/panic_npcc/cases.sh	1970-01-01 05:30:00.000000000 +0530
+++ ltp-full-20090731/testcases/mce-test/cases/soft-inj/panic_npcc/cases.sh	2009-08-05 14:50:57.000000000 +0530
@@ -0,0 +1,108 @@
+#!/bin/sh
+#
+# Software injection based test cases: test cases are triggered via
+# the mce-inject tool.
+#
+# Copyright (C) 2008, Intel Corp.
+#   Author: Huang Ying <ying.huang@intel.com>
+#
+# This file is released under the GPLv2.
+#
+
+. $ROOT/lib/functions.sh
+. $ROOT/lib/dirs.sh
+. $ROOT/lib/mce.sh
+. $ROOT/lib/soft-inject.sh
+
+enumerate()
+{
+    soft_inject_enumerate
+}
+
+trigger()
+{
+    reset_severity_cov
+    soft_inject_trigger
+}
+
+get_result()
+{
+    soft_inject_get_klog
+    get_gcov arch/x86/kernel/cpu/mcheck/mce.c
+    soft_inject_get_mcelog
+    get_severity_cov
+}
+
+verify()
+{
+    local mce_panic
+    local removes="TSC TIME PROCESSOR"
+    local pcc_exp="Processor context corrupt"
+    local knoripv_exp="In kernel and no restart IP"
+    local no_mcip_exp="MCIP not set in MCA handler"
+    local no_eripv_exp="Neither restart nor error IP"
+    local over_exp="Overflowed uncorrected"
+    local fatal_panic=": Fatal Machine check"
+    local curr_cpu_panic=": Fatal machine check on current CPU"
+    local unknown_src_panic=": Machine check from unknown source"
+    case "$bcase" in
+	fatal_severity)
+	    removes="$removes RIP"
+	    soft_inject_verify_mcelog
+	    verify_klog $klog
+	    soft_inject_verify_panic "$fatal_panic"
+	    soft_inject_verify_exp "$pcc_exp"
+	    ;;
+	uncorrected)
+	    soft_inject_verify_mcelog
+	    verify_klog $klog
+	    soft_inject_verify_panic "$fatal_panic"
+	    soft_inject_verify_exp "$knoripv_exp"
+	    ;;
+	uncorrected_timeout*)
+	    soft_inject_verify_mcelog
+	    verify_klog $klog
+	    soft_inject_verify_panic "$curr_cpu_panic"
+	    soft_inject_verify_timeout
+	    soft_inject_verify_exp "$knoripv_exp"
+	    ;;
+	uc_no_mcip)
+	    removes="$removes RIP"
+	    soft_inject_verify_mcelog
+	    verify_klog $klog
+	    soft_inject_verify_panic "$fatal_panic"
+	    soft_inject_verify_exp "$no_mcip_exp"
+	    ;;
+	uc_no_mcip_timeout)
+	    removes="$removes RIP"
+	    soft_inject_verify_mcelog
+	    verify_klog $klog
+	    soft_inject_verify_panic "$curr_cpu_panic"
+	    soft_inject_verify_exp "$no_mcip_exp"
+	    soft_inject_verify_timeout
+	    ;;
+	uc_no_eripv)
+	    removes="$removes RIP"
+	    soft_inject_verify_mcelog
+	    verify_klog $klog
+	    soft_inject_verify_panic "$fatal_panic"
+	    soft_inject_verify_exp "$no_eripv_exp"
+	    ;;
+	uc_no_eripv_timeout)
+	    removes="$removes RIP"
+	    soft_inject_verify_mcelog
+	    verify_klog $klog
+	    soft_inject_verify_panic "$curr_cpu_panic"
+	    soft_inject_verify_exp "$no_eripv_exp"
+	    soft_inject_verify_timeout
+	    ;;
+	unknown)
+	    verify_klog $klog
+	    soft_inject_verify_panic "$unknown_src_panic"
+	    ;;
+	*)
+	    echo "!!! Unknown case: $this_case !!!"
+    esac
+}
+
+soft_inject_main "$@"
--- ltp-full-20090731.orig/testcases/mce-test/cases/soft-inj/panic_npcc/data/fatal_severity	1970-01-01 05:30:00.000000000 +0530
+++ ltp-full-20090731/testcases/mce-test/cases/soft-inj/panic_npcc/data/fatal_severity	2009-08-05 14:50:57.000000000 +0530
@@ -0,0 +1,16 @@
+# WARNING
+# this will panic your machine!
+# don't try casually
+CPU 0 BANK 3
+MCGSTATUS RIPV EIPV MCIP
+# S is regarded as SRAO for SER_P = 1 and ignored otherwise
+STATUS UNCORRECTED S
+RIP 0x10:0x12343434
+MISC 0x2314
+ADDR 0xabcd1234
+HOLD
+
+CPU 1 BANK 1
+MCGSTATUS MCIP
+STATUS FATAL
+RIP 0x10:0xabcdcdcd
--- ltp-full-20090731.orig/testcases/mce-test/cases/soft-inj/panic_npcc/data/uc_no_eripv	1970-01-01 05:30:00.000000000 +0530
+++ ltp-full-20090731/testcases/mce-test/cases/soft-inj/panic_npcc/data/uc_no_eripv	2009-08-05 14:50:57.000000000 +0530
@@ -0,0 +1,5 @@
+CPU 0 BANK 1
+STATUS UNCORRECTED
+MCGSTATUS MCIP
+ADDR 0x1234
+RIP 0x10:0xdeadbabe
--- ltp-full-20090731.orig/testcases/mce-test/cases/soft-inj/panic_npcc/data/uc_no_eripv_timeout	1970-01-01 05:30:00.000000000 +0530
+++ ltp-full-20090731/testcases/mce-test/cases/soft-inj/panic_npcc/data/uc_no_eripv_timeout	2009-08-05 14:50:57.000000000 +0530
@@ -0,0 +1,6 @@
+CPU 0 BANK 1
+STATUS UNCORRECTED
+MCGSTATUS MCIP
+ADDR 0x1234
+RIP 0x10:0xdeadbabe
+NOBROADCAST
--- ltp-full-20090731.orig/testcases/mce-test/cases/soft-inj/panic_npcc/data/uc_no_mcip	1970-01-01 05:30:00.000000000 +0530
+++ ltp-full-20090731/testcases/mce-test/cases/soft-inj/panic_npcc/data/uc_no_mcip	2009-08-05 14:50:57.000000000 +0530
@@ -0,0 +1,4 @@
+CPU 0 BANK 1
+STATUS UNCORRECTED
+ADDR 0x1234
+RIP 0x10:0xdeadbabe
--- ltp-full-20090731.orig/testcases/mce-test/cases/soft-inj/panic_npcc/data/uc_no_mcip_timeout	1970-01-01 05:30:00.000000000 +0530
+++ ltp-full-20090731/testcases/mce-test/cases/soft-inj/panic_npcc/data/uc_no_mcip_timeout	2009-08-05 14:50:57.000000000 +0530
@@ -0,0 +1,5 @@
+CPU 0 BANK 1
+STATUS UNCORRECTED
+ADDR 0x1234
+RIP 0x10:0xdeadbabe
+NOBROADCAST
--- ltp-full-20090731.orig/testcases/mce-test/cases/soft-inj/panic_npcc/data/uncorrected	1970-01-01 05:30:00.000000000 +0530
+++ ltp-full-20090731/testcases/mce-test/cases/soft-inj/panic_npcc/data/uncorrected	2009-08-05 14:50:57.000000000 +0530
@@ -0,0 +1,7 @@
+# this should just kill the process
+CPU 0 BANK 2
+STATUS UNCORRECTED
+MCGSTATUS EIPV MCIP
+ADDR 0x1234
+RIP 0x10:0xdeadbabe
+IN_PROC
\ No newline at end of file
--- ltp-full-20090731.orig/testcases/mce-test/cases/soft-inj/panic_npcc/data/uncorrected_timeout	1970-01-01 05:30:00.000000000 +0530
+++ ltp-full-20090731/testcases/mce-test/cases/soft-inj/panic_npcc/data/uncorrected_timeout	2009-08-05 14:50:57.000000000 +0530
@@ -0,0 +1,8 @@
+# this should just kill the process
+CPU 0 BANK 2
+STATUS UNCORRECTED
+MCGSTATUS EIPV MCIP
+ADDR 0x1234
+RIP 0x10:0xdeadbabe
+IN_PROC
+NOBROADCAST
--- ltp-full-20090731.orig/testcases/mce-test/cases/soft-inj/panic_npcc/data/unknown	1970-01-01 05:30:00.000000000 +0530
+++ ltp-full-20090731/testcases/mce-test/cases/soft-inj/panic_npcc/data/unknown	2009-08-05 14:50:57.000000000 +0530
@@ -0,0 +1,3 @@
+# this should just kill the process
+CPU 0 BANK 2
+STATUS UC
--- ltp-full-20090731.orig/testcases/mce-test/cases/soft-inj/panic_ucr/cases.sh	1970-01-01 05:30:00.000000000 +0530
+++ ltp-full-20090731/testcases/mce-test/cases/soft-inj/panic_ucr/cases.sh	2009-08-05 14:50:57.000000000 +0530
@@ -0,0 +1,71 @@
+#!/bin/sh
+#
+# Software injection based test cases: test cases are triggered via
+# mce-inject tool.
+#
+# Copyright (C) 2009, Intel Corp.
+#   Author: Huang Ying <ying.huang@intel.com>
+#
+# This file is released under the GPLv2.
+#
+
+. $ROOT/lib/functions.sh
+. $ROOT/lib/dirs.sh
+. $ROOT/lib/mce.sh
+. $ROOT/lib/soft-inject.sh
+
+enumerate()
+{
+    soft_inject_enumerate
+}
+
+trigger()
+{
+    reset_severity_cov
+    soft_inject_trigger
+}
+
+get_result()
+{
+    soft_inject_get_klog
+    get_gcov arch/x86/kernel/cpu/mcheck/mce.c
+    soft_inject_get_mcelog
+    get_severity_cov
+}
+
+verify()
+{
+    local removes="TSC TIME PROCESSOR"
+    local fatal_panic=": Fatal Machine check"
+    local curr_cpu_panic=": Fatal machine check on current CPU"
+    local unknown_src_panic=": Machine check from unknown source"
+    case "$bcase" in
+	s0_ar1)
+	    soft_inject_verify_mcelog
+	    verify_klog $klog
+	    soft_inject_verify_panic "$fatal_panic"
+	    soft_inject_verify_exp "Illegal combination (UCNA with AR=1)"
+	    ;;
+	srar_over)
+	    soft_inject_verify_mcelog
+	    verify_klog $klog
+	    soft_inject_verify_panic "$fatal_panic"
+	    soft_inject_verify_exp "Action required with lost events"
+	    ;;
+	srar_unkown)
+	    soft_inject_verify_mcelog
+	    verify_klog $klog
+	    soft_inject_verify_panic "$fatal_panic"
+	    soft_inject_verify_exp "Action required; unknown MCACOD"
+	    ;;
+        srar_no_en)
+            soft_inject_verify_mcelog
+            verify_klog $klog
+            soft_inject_verify_panic "Machine check from unknown source"
+            ;;
+	*)
+	    echo "!!! Unknown case: $this_case !!!"
+    esac
+}
+
+soft_inject_main "$@"
--- ltp-full-20090731.orig/testcases/mce-test/cases/soft-inj/panic_ucr/data/s0_ar1	1970-01-01 05:30:00.000000000 +0530
+++ ltp-full-20090731/testcases/mce-test/cases/soft-inj/panic_ucr/data/s0_ar1	2009-08-05 14:50:57.000000000 +0530
@@ -0,0 +1,5 @@
+CPU 0 BANK 2
+STATUS UNCORRECTED AR
+MCGSTATUS RIPV EIPV MCIP
+ADDR 0x1234
+RIP 0x10:0xdeadbabe
--- ltp-full-20090731.orig/testcases/mce-test/cases/soft-inj/panic_ucr/data/srar_no_en	1970-01-01 05:30:00.000000000 +0530
+++ ltp-full-20090731/testcases/mce-test/cases/soft-inj/panic_ucr/data/srar_no_en	2009-08-05 14:50:57.000000000 +0530
@@ -0,0 +1,6 @@
+CPU 0 BANK 2
+STATUS VAL UC SRAR
+MCGSTATUS EIPV MCIP
+ADDR 0x1234
+RIP 0x73:0x2eadbabe
+
--- ltp-full-20090731.orig/testcases/mce-test/cases/soft-inj/panic_ucr/data/srar_over	1970-01-01 05:30:00.000000000 +0530
+++ ltp-full-20090731/testcases/mce-test/cases/soft-inj/panic_ucr/data/srar_over	2009-08-05 14:50:57.000000000 +0530
@@ -0,0 +1,5 @@
+CPU 0 BANK 2
+STATUS UNCORRECTED SRAR OVER
+MCGSTATUS EIPV MCIP
+ADDR 0x1234
+RIP 0x73:0x1eadbabe
--- ltp-full-20090731.orig/testcases/mce-test/cases/soft-inj/panic_ucr/data/srar_unkown	1970-01-01 05:30:00.000000000 +0530
+++ ltp-full-20090731/testcases/mce-test/cases/soft-inj/panic_ucr/data/srar_unkown	2009-08-05 14:50:57.000000000 +0530
@@ -0,0 +1,5 @@
+CPU 0 BANK 2
+STATUS UNCORRECTED SRAR
+MCGSTATUS EIPV MCIP
+ADDR 0x1234
+RIP 0x73:0x2eadbabe
--- ltp-full-20090731.orig/testcases/mce-test/cases/soft-inj/panic_ucr/refer/srar_no_en	1970-01-01 05:30:00.000000000 +0530
+++ ltp-full-20090731/testcases/mce-test/cases/soft-inj/panic_ucr/refer/srar_no_en	2009-08-05 14:50:57.000000000 +0530
@@ -0,0 +1 @@
+#empty
--- ltp-full-20090731.orig/testcases/mce-test/cases/soft-inj/poll_ucr/cases.sh	1970-01-01 05:30:00.000000000 +0530
+++ ltp-full-20090731/testcases/mce-test/cases/soft-inj/poll_ucr/cases.sh	2009-08-05 14:50:57.000000000 +0530
@@ -0,0 +1,49 @@
+#!/bin/sh
+#
+# Software injection based test cases: test cases are triggered via
+# mce-inject tool.
+#
+# Copyright (C) 2009, Intel Corp.
+#   Author: Huang Ying <ying.huang@intel.com>
+#
+# This file is released under the GPLv2.
+#
+
+. $ROOT/lib/functions.sh
+. $ROOT/lib/dirs.sh
+. $ROOT/lib/mce.sh
+. $ROOT/lib/soft-inject.sh
+
+enumerate()
+{
+    soft_inject_enumerate
+}
+
+trigger()
+{
+    reset_severity_cov
+    soft_inject_trigger
+}
+
+get_result()
+{
+    soft_inject_get_klog
+    get_gcov arch/x86/kernel/cpu/mcheck/mce.c
+    soft_inject_get_mcelog
+    get_severity_cov
+}
+
+verify()
+{
+    local removes="TSC TIME PROCESSOR"
+    case "$bcase" in
+	ucna|ucna_over)
+	    soft_inject_verify_mcelog
+	    verify_klog $klog
+	    ;;
+	*)
+	    echo "!!! Unknown case: $this_case !!!"
+    esac
+}
+
+soft_inject_main "$@"
--- ltp-full-20090731.orig/testcases/mce-test/cases/soft-inj/poll_ucr/data/ucna	1970-01-01 05:30:00.000000000 +0530
+++ ltp-full-20090731/testcases/mce-test/cases/soft-inj/poll_ucr/data/ucna	2009-08-05 14:50:57.000000000 +0530
@@ -0,0 +1,7 @@
+CPU 0 BANK 2
+STATUS UNCORRECTED UCNA
+ADDR 0x1234
+MISC 0x8c
+POLL
+HOLD
+CPU 1 BANK 0
\ No newline at end of file
--- ltp-full-20090731.orig/testcases/mce-test/cases/soft-inj/poll_ucr/data/ucna_over	1970-01-01 05:30:00.000000000 +0530
+++ ltp-full-20090731/testcases/mce-test/cases/soft-inj/poll_ucr/data/ucna_over	2009-08-05 14:50:57.000000000 +0530
@@ -0,0 +1,6 @@
+CPU 0 BANK 2
+STATUS UNCORRECTED UCNA OVER
+ADDR 0x1234
+MISC 0x8c
+POLL
+
--- ltp-full-20090731.orig/testcases/mce-test/cases/soft-inj/recoverable_ucr/cases.sh	1970-01-01 05:30:00.000000000 +0530
+++ ltp-full-20090731/testcases/mce-test/cases/soft-inj/recoverable_ucr/cases.sh	2009-08-05 14:50:57.000000000 +0530
@@ -0,0 +1,56 @@
+#!/bin/sh
+#
+# Software injection based test cases: test cases are triggered via
+# mce-inject tool.
+#
+# Copyright (C) 2009, Intel Corp.
+#   Author: Huang Ying <ying.huang@intel.com>
+#
+# This file is released under the GPLv2.
+#
+
+. $ROOT/lib/functions.sh
+. $ROOT/lib/dirs.sh
+. $ROOT/lib/mce.sh
+. $ROOT/lib/soft-inject.sh
+
+enumerate()
+{
+    soft_inject_enumerate
+}
+
+trigger()
+{
+    reset_severity_cov
+    soft_inject_trigger
+}
+
+get_result()
+{
+    soft_inject_get_klog
+    soft_inject_get_mcelog
+    get_gcov arch/x86/kernel/cpu/mcheck/mce.c
+    get_severity_cov
+}
+
+verify()
+{
+    local removes="TSC TIME PROCESSOR"
+    case "$bcase" in
+	srao_mem_scrub|srao_ewb|srao_unknown|srao_over|srao_no_en|srao_corrected|srao_ucna)
+	    soft_inject_verify_mcelog
+	    verify_klog $klog
+	    soft_inject_verify_return_val
+	    ;;
+	srao_mem_scrub_noripv|srao_ewb_noripv)
+            soft_inject_verify_mcelog
+            verify_klog $klog
+            soft_inject_verify_panic "$fatal_panic"
+            soft_inject_verify_exp "$no_eripv_exp"
+            ;;
+	*)
+	    echo "!!! Unknown case: $this_case !!!"
+    esac
+}
+
+soft_inject_main "$@"
--- ltp-full-20090731.orig/testcases/mce-test/cases/soft-inj/recoverable_ucr/data/srao_corrected	1970-01-01 05:30:00.000000000 +0530
+++ ltp-full-20090731/testcases/mce-test/cases/soft-inj/recoverable_ucr/data/srao_corrected	2009-08-05 14:50:57.000000000 +0530
@@ -0,0 +1,11 @@
+CPU 1 BANK 1
+MCGSTATUS RIPV MCIP
+STATUS CORRECTED
+EXCP
+HOLD
+
+CPU 0 BANK 2
+STATUS UNCORRECTED SRAO
+MCGSTATUS RIPV MCIP
+ADDR 0x1234
+RIP 0x73:0x1eadbabe
--- ltp-full-20090731.orig/testcases/mce-test/cases/soft-inj/recoverable_ucr/data/srao_ewb	1970-01-01 05:30:00.000000000 +0530
+++ ltp-full-20090731/testcases/mce-test/cases/soft-inj/recoverable_ucr/data/srao_ewb	2009-08-05 14:50:57.000000000 +0530
@@ -0,0 +1,6 @@
+CPU 0 BANK 2
+STATUS UNCORRECTED SRAO 0x17a
+MCGSTATUS RIPV MCIP
+ADDR 0x1234
+MISC 0x8c
+RIP 0x73:0x1eadbabe
--- ltp-full-20090731.orig/testcases/mce-test/cases/soft-inj/recoverable_ucr/data/srao_ewb_noripv	1970-01-01 05:30:00.000000000 +0530
+++ ltp-full-20090731/testcases/mce-test/cases/soft-inj/recoverable_ucr/data/srao_ewb_noripv	2009-08-05 14:50:57.000000000 +0530
@@ -0,0 +1,5 @@
+CPU 0 BANK 2
+STATUS UNCORRECTED SRAO 0x17a
+MCGSTATUS MCIP
+ADDR 0x1234
+MISC 0x8c
--- ltp-full-20090731.orig/testcases/mce-test/cases/soft-inj/recoverable_ucr/data/srao_mem_scrub	1970-01-01 05:30:00.000000000 +0530
+++ ltp-full-20090731/testcases/mce-test/cases/soft-inj/recoverable_ucr/data/srao_mem_scrub	2009-08-05 14:50:57.000000000 +0530
@@ -0,0 +1,6 @@
+CPU 0 BANK 2
+STATUS UNCORRECTED SRAO 0xc0
+MCGSTATUS RIPV MCIP
+ADDR 0x1234
+MISC 0x8c
+RIP 0x73:0x1eadbabe
--- ltp-full-20090731.orig/testcases/mce-test/cases/soft-inj/recoverable_ucr/data/srao_mem_scrub_noripv	1970-01-01 05:30:00.000000000 +0530
+++ ltp-full-20090731/testcases/mce-test/cases/soft-inj/recoverable_ucr/data/srao_mem_scrub_noripv	2009-08-05 14:50:57.000000000 +0530
@@ -0,0 +1,5 @@
+CPU 0 BANK 2
+STATUS UNCORRECTED SRAO 0xc0
+MCGSTATUS MCIP
+ADDR 0x1234
+MISC 0x8c
--- ltp-full-20090731.orig/testcases/mce-test/cases/soft-inj/recoverable_ucr/data/srao_no_en	1970-01-01 05:30:00.000000000 +0530
+++ ltp-full-20090731/testcases/mce-test/cases/soft-inj/recoverable_ucr/data/srao_no_en	2009-08-05 14:50:57.000000000 +0530
@@ -0,0 +1,5 @@
+CPU 0 BANK 2
+STATUS VAL UC SRAO
+MCGSTATUS RIPV MCIP
+ADDR 0x1234
+RIP 0x73:0x1eadbabe
--- ltp-full-20090731.orig/testcases/mce-test/cases/soft-inj/recoverable_ucr/data/srao_over	1970-01-01 05:30:00.000000000 +0530
+++ ltp-full-20090731/testcases/mce-test/cases/soft-inj/recoverable_ucr/data/srao_over	2009-08-05 14:50:57.000000000 +0530
@@ -0,0 +1,5 @@
+CPU 0 BANK 2
+STATUS UNCORRECTED SRAO OVER
+MCGSTATUS RIPV MCIP
+ADDR 0x1234
+RIP 0x73:0x1eadbabe
--- ltp-full-20090731.orig/testcases/mce-test/cases/soft-inj/recoverable_ucr/data/srao_ucna	1970-01-01 05:30:00.000000000 +0530
+++ ltp-full-20090731/testcases/mce-test/cases/soft-inj/recoverable_ucr/data/srao_ucna	2009-08-05 14:50:57.000000000 +0530
@@ -0,0 +1,11 @@
+CPU 1 BANK 1
+MCGSTATUS RIPV MCIP
+STATUS UNCORRECTED UCNA
+EXCP
+HOLD
+
+CPU 0 BANK 2
+STATUS UNCORRECTED SRAO
+MCGSTATUS RIPV MCIP
+ADDR 0x1234
+RIP 0x73:0x1eadbabe
--- ltp-full-20090731.orig/testcases/mce-test/cases/soft-inj/recoverable_ucr/data/srao_unknown	1970-01-01 05:30:00.000000000 +0530
+++ ltp-full-20090731/testcases/mce-test/cases/soft-inj/recoverable_ucr/data/srao_unknown	2009-08-05 14:50:57.000000000 +0530
@@ -0,0 +1,5 @@
+CPU 0 BANK 2
+STATUS UNCORRECTED SRAO
+MCGSTATUS RIPV MCIP
+ADDR 0x1234
+RIP 0x73:0x1eadbabe
--- ltp-full-20090731.orig/testcases/mce-test/cases/soft-inj/recoverable_ucr/refer/srao_corrected	1970-01-01 05:30:00.000000000 +0530
+++ ltp-full-20090731/testcases/mce-test/cases/soft-inj/recoverable_ucr/refer/srao_corrected	2009-08-05 14:50:57.000000000 +0530
@@ -0,0 +1,5 @@
+CPU 0 BANK 2
+STATUS UNCORRECTED SRAO
+MCGSTATUS RIPV MCIP
+ADDR 0x1234
+RIP 0x73:0x1eadbabe
--- ltp-full-20090731.orig/testcases/mce-test/cases/soft-inj/recoverable_ucr/refer/srao_no_en	1970-01-01 05:30:00.000000000 +0530
+++ ltp-full-20090731/testcases/mce-test/cases/soft-inj/recoverable_ucr/refer/srao_no_en	2009-08-05 14:50:57.000000000 +0530
@@ -0,0 +1 @@
+#empty
--- ltp-full-20090731.orig/testcases/mce-test/cases/soft-inj/recoverable_ucr/refer/srao_ucna	1970-01-01 05:30:00.000000000 +0530
+++ ltp-full-20090731/testcases/mce-test/cases/soft-inj/recoverable_ucr/refer/srao_ucna	2009-08-05 14:50:57.000000000 +0530
@@ -0,0 +1,6 @@
+CPU 0 BANK 2
+STATUS UNCORRECTED SRAO
+MCGSTATUS RIPV MCIP
+ADDR 0x1234
+RIP 0x73:0x1eadbabe
+
--- ltp-full-20090731.orig/testcases/mce-test/config/kdump_noser.conf	1970-01-01 05:30:00.000000000 +0530
+++ ltp-full-20090731/testcases/mce-test/config/kdump_noser.conf	2009-08-05 14:50:57.000000000 +0530
@@ -0,0 +1,6 @@
+
+CASES="soft-inj/panic/cases.sh soft-inj/panic_npcc/cases.sh soft-inj/panic_noser/cases.sh"
+COREDIR="/var/crash"
+GCOV=1
+KSRC_DIR=/lib/modules/$(uname -r)/build
+VMLINUX=$KSRC_DIR/vmlinux
--- ltp-full-20090731.orig/testcases/mce-test/config/kdump_panic.conf	1970-01-01 05:30:00.000000000 +0530
+++ ltp-full-20090731/testcases/mce-test/config/kdump_panic.conf	2009-08-05 14:50:57.000000000 +0530
@@ -0,0 +1,6 @@
+
+CASES="soft-inj/panic/cases.sh"
+COREDIR="/var/crash"
+GCOV=1
+KSRC_DIR=/lib/modules/$(uname -r)/build
+VMLINUX=$KSRC_DIR/vmlinux
--- ltp-full-20090731.orig/testcases/mce-test/config/kdump_panic_noser.conf	1970-01-01 05:30:00.000000000 +0530
+++ ltp-full-20090731/testcases/mce-test/config/kdump_panic_noser.conf	2009-08-05 14:50:57.000000000 +0530
@@ -0,0 +1,6 @@
+
+CASES="soft-inj/panic_noser/cases.sh"
+COREDIR="/var/crash"
+GCOV=1
+KSRC_DIR=/lib/modules/$(uname -r)/build
+VMLINUX=$KSRC_DIR/vmlinux
--- ltp-full-20090731.orig/testcases/mce-test/config/kdump_panic_npcc.conf	1970-01-01 05:30:00.000000000 +0530
+++ ltp-full-20090731/testcases/mce-test/config/kdump_panic_npcc.conf	2009-08-05 14:50:57.000000000 +0530
@@ -0,0 +1,6 @@
+
+CASES="soft-inj/panic_npcc/cases.sh"
+COREDIR="/var/crash"
+GCOV=1
+KSRC_DIR=/lib/modules/$(uname -r)/build
+VMLINUX=$KSRC_DIR/vmlinux
--- ltp-full-20090731.orig/testcases/mce-test/config/kdump_panic_ucr.conf	1970-01-01 05:30:00.000000000 +0530
+++ ltp-full-20090731/testcases/mce-test/config/kdump_panic_ucr.conf	2009-08-05 14:50:57.000000000 +0530
@@ -0,0 +1,6 @@
+
+CASES="soft-inj/panic_ucr/cases.sh"
+COREDIR="/var/crash"
+GCOV=1
+KSRC_DIR=/lib/modules/$(uname -r)/build
+VMLINUX=$KSRC_DIR/vmlinux
--- ltp-full-20090731.orig/testcases/mce-test/config/kdump_ser.conf	1970-01-01 05:30:00.000000000 +0530
+++ ltp-full-20090731/testcases/mce-test/config/kdump_ser.conf	2009-08-05 14:50:57.000000000 +0530
@@ -0,0 +1,6 @@
+
+CASES="soft-inj/panic/cases.sh soft-inj/panic_npcc/cases.sh soft-inj/panic_ucr/cases.sh"
+COREDIR="/var/crash"
+GCOV=1
+KSRC_DIR=/lib/modules/$(uname -r)/build
+VMLINUX=$KSRC_DIR/vmlinux
--- ltp-full-20090731.orig/testcases/mce-test/config/simple_non_panic.conf	1970-01-01 05:30:00.000000000 +0530
+++ ltp-full-20090731/testcases/mce-test/config/simple_non_panic.conf	2009-08-05 14:50:57.000000000 +0530
@@ -0,0 +1,4 @@
+
+CASES="soft-inj/non-panic/cases.sh"
+GCOV=1
+KSRC_DIR=/lib/modules/$(uname -r)/build
--- ltp-full-20090731.orig/testcases/mce-test/config/simple_nopanic_noser.conf	1970-01-01 05:30:00.000000000 +0530
+++ ltp-full-20090731/testcases/mce-test/config/simple_nopanic_noser.conf	2009-08-05 14:50:57.000000000 +0530
@@ -0,0 +1,4 @@
+
+CASES="soft-inj/non-panic/cases.sh"
+GCOV=1
+KSRC_DIR=/lib/modules/$(uname -r)/build
--- ltp-full-20090731.orig/testcases/mce-test/config/simple_nopanic_ser.conf	1970-01-01 05:30:00.000000000 +0530
+++ ltp-full-20090731/testcases/mce-test/config/simple_nopanic_ser.conf	2009-08-05 14:50:57.000000000 +0530
@@ -0,0 +1,4 @@
+
+CASES="soft-inj/non-panic/cases.sh soft-inj/poll_ucr/cases.sh soft-inj/recoverable_ucr/cases.sh"
+GCOV=1
+KSRC_DIR=/lib/modules/$(uname -r)/build
--- ltp-full-20090731.orig/testcases/mce-test/config/simple_noser.conf	1970-01-01 05:30:00.000000000 +0530
+++ ltp-full-20090731/testcases/mce-test/config/simple_noser.conf	2009-08-05 14:50:57.000000000 +0530
@@ -0,0 +1,4 @@
+
+CASES="soft-inj/non-panic/cases.sh soft-inj/panic/cases.sh soft-inj/panic_npcc/cases.sh soft-inj/panic_noser/cases.sh"
+GCOV=1
+KSRC_DIR=/lib/modules/$(uname -r)/build
--- ltp-full-20090731.orig/testcases/mce-test/config/simple_panic.conf	1970-01-01 05:30:00.000000000 +0530
+++ ltp-full-20090731/testcases/mce-test/config/simple_panic.conf	2009-08-05 14:50:57.000000000 +0530
@@ -0,0 +1,4 @@
+
+CASES="soft-inj/panic/cases.sh"
+GCOV=1
+KSRC_DIR=/lib/modules/$(uname -r)/build
--- ltp-full-20090731.orig/testcases/mce-test/config/simple_panic_noser.conf	1970-01-01 05:30:00.000000000 +0530
+++ ltp-full-20090731/testcases/mce-test/config/simple_panic_noser.conf	2009-08-05 14:50:57.000000000 +0530
@@ -0,0 +1,4 @@
+
+CASES="soft-inj/panic_noser/cases.sh"
+GCOV=1
+KSRC_DIR=/lib/modules/$(uname -r)/build
--- ltp-full-20090731.orig/testcases/mce-test/config/simple_panic_npcc.conf	1970-01-01 05:30:00.000000000 +0530
+++ ltp-full-20090731/testcases/mce-test/config/simple_panic_npcc.conf	2009-08-05 14:50:57.000000000 +0530
@@ -0,0 +1,4 @@
+
+CASES="soft-inj/panic_npcc/cases.sh"
+GCOV=1
+KSRC_DIR=/lib/modules/$(uname -r)/build
--- ltp-full-20090731.orig/testcases/mce-test/config/simple_panic_ucr.conf	1970-01-01 05:30:00.000000000 +0530
+++ ltp-full-20090731/testcases/mce-test/config/simple_panic_ucr.conf	2009-08-05 14:50:57.000000000 +0530
@@ -0,0 +1,4 @@
+
+CASES="soft-inj/panic_ucr/cases.sh"
+GCOV=1
+KSRC_DIR=/lib/modules/$(uname -r)/build
--- ltp-full-20090731.orig/testcases/mce-test/config/simple_poll_ucr.conf	1970-01-01 05:30:00.000000000 +0530
+++ ltp-full-20090731/testcases/mce-test/config/simple_poll_ucr.conf	2009-08-05 14:50:57.000000000 +0530
@@ -0,0 +1,4 @@
+
+CASES="soft-inj/poll_ucr/cases.sh"
+GCOV=1
+KSRC_DIR=/lib/modules/$(uname -r)/build
--- ltp-full-20090731.orig/testcases/mce-test/config/simple_recoverable_ucr.conf	1970-01-01 05:30:00.000000000 +0530
+++ ltp-full-20090731/testcases/mce-test/config/simple_recoverable_ucr.conf	2009-08-05 14:50:57.000000000 +0530
@@ -0,0 +1,4 @@
+
+CASES="soft-inj/recoverable_ucr/cases.sh"
+GCOV=1
+KSRC_DIR=/lib/modules/$(uname -r)/build
--- ltp-full-20090731.orig/testcases/mce-test/config/simple_ser.conf	1970-01-01 05:30:00.000000000 +0530
+++ ltp-full-20090731/testcases/mce-test/config/simple_ser.conf	2009-08-05 14:50:57.000000000 +0530
@@ -0,0 +1,4 @@
+
+CASES="soft-inj/non-panic/cases.sh soft-inj/panic/cases.sh soft-inj/panic_npcc/cases.sh soft-inj/poll_ucr/cases.sh soft-inj/panic_ucr/cases.sh soft-inj/recoverable_ucr/cases.sh"
+GCOV=1
+KSRC_DIR=/lib/modules/$(uname -r)/build
--- ltp-full-20090731.orig/testcases/mce-test/COPYING	1970-01-01 05:30:00.000000000 +0530
+++ ltp-full-20090731/testcases/mce-test/COPYING	2009-08-05 14:50:57.000000000 +0530
@@ -0,0 +1,340 @@
+		    GNU GENERAL PUBLIC LICENSE
+		       Version 2, June 1991
+
+ Copyright (C) 1989, 1991 Free Software Foundation, Inc.
+                       59 Temple Place, Suite 330, Boston, MA  02111-1307  USA
+ Everyone is permitted to copy and distribute verbatim copies
+ of this license document, but changing it is not allowed.
+
+			    Preamble
+
+  The licenses for most software are designed to take away your
+freedom to share and change it.  By contrast, the GNU General Public
+License is intended to guarantee your freedom to share and change free
+software--to make sure the software is free for all its users.  This
+General Public License applies to most of the Free Software
+Foundation's software and to any other program whose authors commit to
+using it.  (Some other Free Software Foundation software is covered by
+the GNU Library General Public License instead.)  You can apply it to
+your programs, too.
+
+  When we speak of free software, we are referring to freedom, not
+price.  Our General Public Licenses are designed to make sure that you
+have the freedom to distribute copies of free software (and charge for
+this service if you wish), that you receive source code or can get it
+if you want it, that you can change the software or use pieces of it
+in new free programs; and that you know you can do these things.
+
+  To protect your rights, we need to make restrictions that forbid
+anyone to deny you these rights or to ask you to surrender the rights.
+These restrictions translate to certain responsibilities for you if you
+distribute copies of the software, or if you modify it.
+
+  For example, if you distribute copies of such a program, whether
+gratis or for a fee, you must give the recipients all the rights that
+you have.  You must make sure that they, too, receive or can get the
+source code.  And you must show them these terms so they know their
+rights.
+
+  We protect your rights with two steps: (1) copyright the software, and
+(2) offer you this license which gives you legal permission to copy,
+distribute and/or modify the software.
+
+  Also, for each author's protection and ours, we want to make certain
+that everyone understands that there is no warranty for this free
+software.  If the software is modified by someone else and passed on, we
+want its recipients to know that what they have is not the original, so
+that any problems introduced by others will not reflect on the original
+authors' reputations.
+
+  Finally, any free program is threatened constantly by software
+patents.  We wish to avoid the danger that redistributors of a free
+program will individually obtain patent licenses, in effect making the
+program proprietary.  To prevent this, we have made it clear that any
+patent must be licensed for everyone's free use or not licensed at all.
+
+  The precise terms and conditions for copying, distribution and
+modification follow.
+
+		    GNU GENERAL PUBLIC LICENSE
+   TERMS AND CONDITIONS FOR COPYING, DISTRIBUTION AND MODIFICATION
+
+  0. This License applies to any program or other work which contains
+a notice placed by the copyright holder saying it may be distributed
+under the terms of this General Public License.  The "Program", below,
+refers to any such program or work, and a "work based on the Program"
+means either the Program or any derivative work under copyright law:
+that is to say, a work containing the Program or a portion of it,
+either verbatim or with modifications and/or translated into another
+language.  (Hereinafter, translation is included without limitation in
+the term "modification".)  Each licensee is addressed as "you".
+
+Activities other than copying, distribution and modification are not
+covered by this License; they are outside its scope.  The act of
+running the Program is not restricted, and the output from the Program
+is covered only if its contents constitute a work based on the
+Program (independent of having been made by running the Program).
+Whether that is true depends on what the Program does.
+
+  1. You may copy and distribute verbatim copies of the Program's
+source code as you receive it, in any medium, provided that you
+conspicuously and appropriately publish on each copy an appropriate
+copyright notice and disclaimer of warranty; keep intact all the
+notices that refer to this License and to the absence of any warranty;
+and give any other recipients of the Program a copy of this License
+along with the Program.
+
+You may charge a fee for the physical act of transferring a copy, and
+you may at your option offer warranty protection in exchange for a fee.
+
+  2. You may modify your copy or copies of the Program or any portion
+of it, thus forming a work based on the Program, and copy and
+distribute such modifications or work under the terms of Section 1
+above, provided that you also meet all of these conditions:
+
+    a) You must cause the modified files to carry prominent notices
+    stating that you changed the files and the date of any change.
+
+    b) You must cause any work that you distribute or publish, that in
+    whole or in part contains or is derived from the Program or any
+    part thereof, to be licensed as a whole at no charge to all third
+    parties under the terms of this License.
+
+    c) If the modified program normally reads commands interactively
+    when run, you must cause it, when started running for such
+    interactive use in the most ordinary way, to print or display an
+    announcement including an appropriate copyright notice and a
+    notice that there is no warranty (or else, saying that you provide
+    a warranty) and that users may redistribute the program under
+    these conditions, and telling the user how to view a copy of this
+    License.  (Exception: if the Program itself is interactive but
+    does not normally print such an announcement, your work based on
+    the Program is not required to print an announcement.)
+
+These requirements apply to the modified work as a whole.  If
+identifiable sections of that work are not derived from the Program,
+and can be reasonably considered independent and separate works in
+themselves, then this License, and its terms, do not apply to those
+sections when you distribute them as separate works.  But when you
+distribute the same sections as part of a whole which is a work based
+on the Program, the distribution of the whole must be on the terms of
+this License, whose permissions for other licensees extend to the
+entire whole, and thus to each and every part regardless of who wrote it.
+
+Thus, it is not the intent of this section to claim rights or contest
+your rights to work written entirely by you; rather, the intent is to
+exercise the right to control the distribution of derivative or
+collective works based on the Program.
+
+In addition, mere aggregation of another work not based on the Program
+with the Program (or with a work based on the Program) on a volume of
+a storage or distribution medium does not bring the other work under
+the scope of this License.
+
+  3. You may copy and distribute the Program (or a work based on it,
+under Section 2) in object code or executable form under the terms of
+Sections 1 and 2 above provided that you also do one of the following:
+
+    a) Accompany it with the complete corresponding machine-readable
+    source code, which must be distributed under the terms of Sections
+    1 and 2 above on a medium customarily used for software interchange; or,
+
+    b) Accompany it with a written offer, valid for at least three
+    years, to give any third party, for a charge no more than your
+    cost of physically performing source distribution, a complete
+    machine-readable copy of the corresponding source code, to be
+    distributed under the terms of Sections 1 and 2 above on a medium
+    customarily used for software interchange; or,
+
+    c) Accompany it with the information you received as to the offer
+    to distribute corresponding source code.  (This alternative is
+    allowed only for noncommercial distribution and only if you
+    received the program in object code or executable form with such
+    an offer, in accord with Subsection b above.)
+
+The source code for a work means the preferred form of the work for
+making modifications to it.  For an executable work, complete source
+code means all the source code for all modules it contains, plus any
+associated interface definition files, plus the scripts used to
+control compilation and installation of the executable.  However, as a
+special exception, the source code distributed need not include
+anything that is normally distributed (in either source or binary
+form) with the major components (compiler, kernel, and so on) of the
+operating system on which the executable runs, unless that component
+itself accompanies the executable.
+
+If distribution of executable or object code is made by offering
+access to copy from a designated place, then offering equivalent
+access to copy the source code from the same place counts as
+distribution of the source code, even though third parties are not
+compelled to copy the source along with the object code.
+
+  4. You may not copy, modify, sublicense, or distribute the Program
+except as expressly provided under this License.  Any attempt
+otherwise to copy, modify, sublicense or distribute the Program is
+void, and will automatically terminate your rights under this License.
+However, parties who have received copies, or rights, from you under
+this License will not have their licenses terminated so long as such
+parties remain in full compliance.
+
+  5. You are not required to accept this License, since you have not
+signed it.  However, nothing else grants you permission to modify or
+distribute the Program or its derivative works.  These actions are
+prohibited by law if you do not accept this License.  Therefore, by
+modifying or distributing the Program (or any work based on the
+Program), you indicate your acceptance of this License to do so, and
+all its terms and conditions for copying, distributing or modifying
+the Program or works based on it.
+
+  6. Each time you redistribute the Program (or any work based on the
+Program), the recipient automatically receives a license from the
+original licensor to copy, distribute or modify the Program subject to
+these terms and conditions.  You may not impose any further
+restrictions on the recipients' exercise of the rights granted herein.
+You are not responsible for enforcing compliance by third parties to
+this License.
+
+  7. If, as a consequence of a court judgment or allegation of patent
+infringement or for any other reason (not limited to patent issues),
+conditions are imposed on you (whether by court order, agreement or
+otherwise) that contradict the conditions of this License, they do not
+excuse you from the conditions of this License.  If you cannot
+distribute so as to satisfy simultaneously your obligations under this
+License and any other pertinent obligations, then as a consequence you
+may not distribute the Program at all.  For example, if a patent
+license would not permit royalty-free redistribution of the Program by
+all those who receive copies directly or indirectly through you, then
+the only way you could satisfy both it and this License would be to
+refrain entirely from distribution of the Program.
+
+If any portion of this section is held invalid or unenforceable under
+any particular circumstance, the balance of the section is intended to
+apply and the section as a whole is intended to apply in other
+circumstances.
+
+It is not the purpose of this section to induce you to infringe any
+patents or other property right claims or to contest validity of any
+such claims; this section has the sole purpose of protecting the
+integrity of the free software distribution system, which is
+implemented by public license practices.  Many people have made
+generous contributions to the wide range of software distributed
+through that system in reliance on consistent application of that
+system; it is up to the author/donor to decide if he or she is willing
+to distribute software through any other system and a licensee cannot
+impose that choice.
+
+This section is intended to make thoroughly clear what is believed to
+be a consequence of the rest of this License.
+
+  8. If the distribution and/or use of the Program is restricted in
+certain countries either by patents or by copyrighted interfaces, the
+original copyright holder who places the Program under this License
+may add an explicit geographical distribution limitation excluding
+those countries, so that distribution is permitted only in or among
+countries not thus excluded.  In such case, this License incorporates
+the limitation as if written in the body of this License.
+
+  9. The Free Software Foundation may publish revised and/or new versions
+of the General Public License from time to time.  Such new versions will
+be similar in spirit to the present version, but may differ in detail to
+address new problems or concerns.
+
+Each version is given a distinguishing version number.  If the Program
+specifies a version number of this License which applies to it and "any
+later version", you have the option of following the terms and conditions
+either of that version or of any later version published by the Free
+Software Foundation.  If the Program does not specify a version number of
+this License, you may choose any version ever published by the Free Software
+Foundation.
+
+  10. If you wish to incorporate parts of the Program into other free
+programs whose distribution conditions are different, write to the author
+to ask for permission.  For software which is copyrighted by the Free
+Software Foundation, write to the Free Software Foundation; we sometimes
+make exceptions for this.  Our decision will be guided by the two goals
+of preserving the free status of all derivatives of our free software and
+of promoting the sharing and reuse of software generally.
+
+			    NO WARRANTY
+
+  11. BECAUSE THE PROGRAM IS LICENSED FREE OF CHARGE, THERE IS NO WARRANTY
+FOR THE PROGRAM, TO THE EXTENT PERMITTED BY APPLICABLE LAW.  EXCEPT WHEN
+OTHERWISE STATED IN WRITING THE COPYRIGHT HOLDERS AND/OR OTHER PARTIES
+PROVIDE THE PROGRAM "AS IS" WITHOUT WARRANTY OF ANY KIND, EITHER EXPRESSED
+OR IMPLIED, INCLUDING, BUT NOT LIMITED TO, THE IMPLIED WARRANTIES OF
+MERCHANTABILITY AND FITNESS FOR A PARTICULAR PURPOSE.  THE ENTIRE RISK AS
+TO THE QUALITY AND PERFORMANCE OF THE PROGRAM IS WITH YOU.  SHOULD THE
+PROGRAM PROVE DEFECTIVE, YOU ASSUME THE COST OF ALL NECESSARY SERVICING,
+REPAIR OR CORRECTION.
+
+  12. IN NO EVENT UNLESS REQUIRED BY APPLICABLE LAW OR AGREED TO IN WRITING
+WILL ANY COPYRIGHT HOLDER, OR ANY OTHER PARTY WHO MAY MODIFY AND/OR
+REDISTRIBUTE THE PROGRAM AS PERMITTED ABOVE, BE LIABLE TO YOU FOR DAMAGES,
+INCLUDING ANY GENERAL, SPECIAL, INCIDENTAL OR CONSEQUENTIAL DAMAGES ARISING
+OUT OF THE USE OR INABILITY TO USE THE PROGRAM (INCLUDING BUT NOT LIMITED
+TO LOSS OF DATA OR DATA BEING RENDERED INACCURATE OR LOSSES SUSTAINED BY
+YOU OR THIRD PARTIES OR A FAILURE OF THE PROGRAM TO OPERATE WITH ANY OTHER
+PROGRAMS), EVEN IF SUCH HOLDER OR OTHER PARTY HAS BEEN ADVISED OF THE
+POSSIBILITY OF SUCH DAMAGES.
+
+		     END OF TERMS AND CONDITIONS
+
+	    How to Apply These Terms to Your New Programs
+
+  If you develop a new program, and you want it to be of the greatest
+possible use to the public, the best way to achieve this is to make it
+free software which everyone can redistribute and change under these terms.
+
+  To do so, attach the following notices to the program.  It is safest
+to attach them to the start of each source file to most effectively
+convey the exclusion of warranty; and each file should have at least
+the "copyright" line and a pointer to where the full notice is found.
+
+    <one line to give the program's name and a brief idea of what it does.>
+    Copyright (C) 19yy  <name of author>
+
+    This program is free software; you can redistribute it and/or modify
+    it under the terms of the GNU General Public License as published by
+    the Free Software Foundation; either version 2 of the License, or
+    (at your option) any later version.
+
+    This program is distributed in the hope that it will be useful,
+    but WITHOUT ANY WARRANTY; without even the implied warranty of
+    MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
+    GNU General Public License for more details.
+
+    You should have received a copy of the GNU General Public License
+    along with this program; if not, write to the Free Software
+    Foundation, Inc., 59 Temple Place, Suite 330, Boston, MA  02111-1307  USA
+
+
+Also add information on how to contact you by electronic and paper mail.
+
+If the program is interactive, make it output a short notice like this
+when it starts in an interactive mode:
+
+    Gnomovision version 69, Copyright (C) 19yy name of author
+    Gnomovision comes with ABSOLUTELY NO WARRANTY; for details type `show w'.
+    This is free software, and you are welcome to redistribute it
+    under certain conditions; type `show c' for details.
+
+The hypothetical commands `show w' and `show c' should show the appropriate
+parts of the General Public License.  Of course, the commands you use may
+be called something other than `show w' and `show c'; they could even be
+mouse-clicks or menu items--whatever suits your program.
+
+You should also get your employer (if you work as a programmer) or your
+school, if any, to sign a "copyright disclaimer" for the program, if
+necessary.  Here is a sample; alter the names:
+
+  Yoyodyne, Inc., hereby disclaims all copyright interest in the program
+  `Gnomovision' (which makes passes at compilers) written by James Hacker.
+
+  <signature of Ty Coon>, 1 April 1989
+  Ty Coon, President of Vice
+
+This General Public License does not permit incorporating your program into
+proprietary programs.  If your program is a subroutine library, you may
+consider it more useful to permit linking proprietary applications with the
+library.  If this is what you want to do, use the GNU Library General
+Public License instead of this License.
--- ltp-full-20090731.orig/testcases/mce-test/doc/cases/soft-inj_non-panic.txt	1970-01-01 05:30:00.000000000 +0530
+++ ltp-full-20090731/testcases/mce-test/doc/cases/soft-inj_non-panic.txt	2009-08-05 14:50:57.000000000 +0530
@@ -0,0 +1,66 @@
+Overall:(4 cases)
+
+- Test method
+  * Preparation
+    + Disable mcelog cron job
+  * Add cases/soft-inj/non-panic/cases.sh into configuration file, and invoke
+    a test driver on it.
+- Common
+  * Test script of test cases in this file can be found in
+    cases/soft-inj/non-panic/cases.sh
+
+
+1. corrected
+
+- Objective:
+  * Test machine_check_poll() and mce_log()
+- Code path tested:
+  * machine_check_poll()
+  * mce_get_rip(), branch without EIPV, RIPV, rip_msr
+  * mce_log()
+- Reference:
+  * Inject data file: cases/soft-inj/non-panic/data/corrected
+- Expected results:
+  * MCE records gotten via /dev/mcelog is same as injected ones
+  * No warning or bug during kernel processing
+
+
+2. corrected hold
+
+- Objective:
+  * Whether is there race condition in machine_check_poll() and mce_log(),
+    multiple machine_check_poll() or mce_log() may be run simultaneously
+    on difference CPU.
+- Code path tested:
+  * same as corrected
+- Reference:
+  * Inject data file: cases/soft-inj/non-panic/data/corrected_hold
+- Expected results:
+  * MCE records gotten via /dev/mcelog is same as injected ones
+  * No warning or bug during kernel processing
+
+
+3. corrected over
+
+- Objective:
+  * Test OVER processing
+- Code path tested:
+  * same as 1
+- Reference:
+  * Inject data file: cases/soft-inj/non-panic/data/corrected_over
+- Expected results:
+  * MCE records gotten via /dev/mcelog is same as injected ones
+  * No warning or bug during kernel processing
+
+
+4. corrected without EN
+
+- Objective:
+  * Test no EN processing
+- Code path tested:
+  * same as 1
+- Reference:
+  * Inject data file: cases/soft-inj/non-panic/data/corrected_no_en
+- Expected results:
+  * MCE records gotten via /dev/mcelog is same as injected ones
+  * No warning or bug during kernel processing
--- ltp-full-20090731.orig/testcases/mce-test/doc/cases/soft-inj_panic_noser.txt	1970-01-01 05:30:00.000000000 +0530
+++ ltp-full-20090731/testcases/mce-test/doc/cases/soft-inj_panic_noser.txt	2009-08-05 14:50:57.000000000 +0530
@@ -0,0 +1,83 @@
+Overall: (3 cases)
+
+- Test method
+  * Add cases/soft-inj/panic_noser/cases.sh into configuration file, and invoke
+    a test driver on it.
+- Common
+  * Test script of test cases in this file can be found in
+    cases/soft-inj/panic_noser/cases.sh
+
+1. uc_over
+
+- Objective:
+  * Test MSR read logic of MCE handler
+  * Test synchronization between monarch and subject
+  * Test logic of uncorrected with UC and OVER
+- Code path tested:
+  * do_machine_check()
+  * mce_start()
+  * mce_timeout() except if (*t <= 0) branch
+  * mce_log()
+  * mce_end()
+  * mce_severity()
+  * mce_reign() until mce_panic("Fatal Machine check",)
+  * mce_panic()
+  * print_mce()
+- Reference:
+  * Inject data file: cases/soft-inj/panic_noser/data/uc_over
+- Expected result:
+  * No warning or bug during kernel processing.
+  * MCE records collected via kernel panic log is same as reference ones.
+  * Kernel panic message is "Fatal Machine check"
+  * Exception message is "Overflowed uncorrected"
+
+
+2. uc_over_corrected
+
+- Objective:
+  * Test synchronization between monarch and subject
+  * Test logic of uncorrected and corrected
+  * Test logic of uncorrected with UC and OVER
+  * Test logic of corrected with EXCP
+- Code path tested:
+  * do_machine_check()
+  * mce_start()
+  * mce_timeout() except if (*t <= 0) branch
+  * mce_log()
+  * mce_end()
+  * mce_severity()
+  * mce_reign() until mce_panic("Fatal Machine check",)
+  * mce_panic()
+  * print_mce()
+- Reference:
+  * Inject data file: cases/soft-inj/panic_noser/data/uc_over_corrected
+- Expected result:
+  * No warning or bug during kernel processing.
+  * MCE records collected via kernel panic log is same as reference ones.
+  * Kernel panic message is "Fatal Machine check"
+  * Exception message is "Overflowed uncorrected"
+
+
+3. uc_over_timeout
+
+- Objective:
+  * Test logic of timeout during monarch/subject synchronization
+  * Test logic of uncorrected with UC and OVER
+- Code path tested:
+  * do_machine_check()
+  * mce_start()
+  * mce_timeout() if (*t <= 0) branch
+  * mce_log()
+  * mce_severity()
+  * mce_panic("Fatal machine check on current CPU",)
+  * print_mce()
+- Reference:
+  * Inject data file: cases/soft-inj/panic_noser/data/uc_over_timeout
+- Expected result:
+  * No warning or bug during kernel processing.
+  * MCE records collected via kernel panic log is same as reference ones.
+  * Kernel panic message is "Fatal machine check on current CPU"
+  * Exception message is "Overflowed uncorrected"
+  * Timeout message is "Some CPUs didn't answer in synchronization"
+
+
--- ltp-full-20090731.orig/testcases/mce-test/doc/cases/soft-inj_panic_npcc.txt	1970-01-01 05:30:00.000000000 +0530
+++ ltp-full-20090731/testcases/mce-test/doc/cases/soft-inj_panic_npcc.txt	2009-08-05 14:50:57.000000000 +0530
@@ -0,0 +1,145 @@
+Overall:(8 cases)
+
+- Test method
+  * Preparation
+    + Disable mcelog cron job
+  * Add cases/soft-inj/panic_npcc/cases.sh into configuration file, and invoke
+    a test driver on it.
+- Common
+  * Test script of test cases in this file can be found in
+    cases/soft-inj/panic_npcc/cases.sh
+
+
+1. fatal severity
+
+- Objective:
+  * Test severity comparison logic of MCE handler
+- Code path tested:
+  * do_machine_check()
+  * mce_start()
+  * mce_end()
+  * mce_severity()
+  * mce_regin() for_each_possible_loops loops(check mce-severity message)
+  * mce_panic()
+  * mce_log()
+  * print_mce()
+- Reference:
+  * Inject data file: cases/soft-inj/panic_npcc/data/fatal_severity
+- Expected result:
+  * No warning or bug during kernel processing.
+  * MCE records collected via kernel panic log is same as reference ones.
+  * Kernel panic message is "Fatal Machine check"
+  * Exception message is "Processor context corrupt"
+
+
+2. uncorrected
+
+- Objective:
+  * Test MCE handler logic for EIPV MCE in kernel space
+- Code path tested:
+  * Same as falta severity
+- Reference:
+  * Inject data file: cases/soft-inj/panic_npcc/data/uncorrected
+- Expected result:
+  * No warning or bug during kernel processing.
+  * MCE records collected via kernel panic log is same as reference ones.
+  * Kernel panic message is "Fatal Machine check"
+  * Exception message is "In kernel and no restart IP"
+
+
+3. uncorrected timeout
+
+- Objective:
+  * Test MCE handler timeout logic for EIPV MCE in kernel space
+- Code path tested:
+  * do_machine_check()
+  * mce_start() until timeout
+  * mce_severity()
+  * mce_panic("Fatal machine check on current CPU", )
+  * mce_log()
+  * print_mce()
+- Reference:
+  * Inject data file: cases/soft-inj/panic_npcc/data/uncorrected_timeout
+- Expected result:
+  * No warning or bug during kernel processing.
+  * MCE records collected via kernel panic log is same as reference ones.
+  * Kernel panic message is "Fatal machine check on current CPU"
+  * Exception message is "In kernel and no restart IP"
+  * Timeout message is "Some CPUs didn't answer in synchronization"
+
+
+4. uncorrected without MCIP
+
+- Objective:
+  * Test MCE handler logic for MCE without PCC, MCIP, EIPV and RIPV
+- Code path tested:
+  * Same as fatal severity
+- Reference:
+  * Inject data file: cases/soft-inj/panic_npcc/data/uncorrected_no_mcip
+- Expected result:
+  * No warning or bug during kernel processing.
+  * MCE records collected via kernel panic log is same as reference ones.
+  * Kernel panic message is "Fatal Machine check"
+  * Exception message is "MCIP not set in MCA handler"
+
+
+5. uncorrect timeout without MCIP
+
+- Objective:
+  * Test MCE handler timeout logic for MCE without PCC, MCIP, EIPV and RIPV
+- Code path tested:
+  * Same as uncorrected timeout
+- Reference:
+  * Inject data file: cases/soft-inj/panic_npcc/data/uncorrected_no_mcip_timeout
+- Expected result:
+  * No warning or bug during kernel processing.
+  * MCE records collected via kernel panic log is same as reference ones.
+  * Kernel panic message is "Fatal machine check on current CPU"
+  * Kernel panic message is "MCIP not set in MCA handler"
+  * Timeout message is "Some CPUs didn't answer in synchronization"
+
+
+6. uncorrected without EIPV and RIPV
+
+- Objective:
+  * Test MCE handler logic for EIPV and RIPV MCE in kernel space
+- Code path tested:
+  * Same as uncorrected
+- Reference:
+  * Inject data file: cases/soft-inj/panic_npcc/data/uncorrected_no_eripv
+- Expected result:
+  * No warning or bug during kernel processing.
+  * MCE records collected via kernel panic log is same as reference ones.
+  * Kernel panic message is "Fatal Machine check"
+  * Exception message is "Neither restart nor error IP"
+
+
+7. uncorrected timeout without EIPV and RIPV
+
+- Objective:
+  * Test MCE handler timout logic for EIPV|RIPV MCE in kernel space
+- Code path tested:
+  * Same as uncorrected timeout
+- Reference:
+  * Inject data file: cases/soft-inj/panic_npcc/data/uncorrected_no_eripv_timeout
+- Expected result:
+  * No warning or bug during kernel processing.
+  * MCE records collected via kernel panic log is same as reference ones.
+  * Kernel panic message is "Fatal Machine check"
+  * Exception message is "In kernel and no restart IP"
+  * Timeout message is "Some CPUs didn't answer in synchronization"
+
+
+8. unknown
+
+- Objective:
+  * Test logic for MCE from unknown source (external?)
+- Code path tested:
+  * mce_reign(), mce_panic("Machine check from unknown source") branch
+  * Others are same as fatal severity
+- Reference:
+  * Inject data file: cases/soft-inj/panic_npcc/data/unknown
+- Expected result:
+  * No warning or bug during kernel processing.
+  * Kernel panic message is "Machine check from unknown source"
+  * No exception and timeout message.
--- ltp-full-20090731.orig/testcases/mce-test/doc/cases/soft-inj_panic.txt	1970-01-01 05:30:00.000000000 +0530
+++ ltp-full-20090731/testcases/mce-test/doc/cases/soft-inj_panic.txt	2009-08-05 14:50:57.000000000 +0530
@@ -0,0 +1,173 @@
+Overall: (9 cases)
+
+- Test method
+  * Add cases/soft-inj/panic/cases.sh into configuration file, and invoke
+    a test driver on it.
+- Common
+  * Test script of test cases in this file can be found in
+    cases/soft-inj/panic/cases.sh
+
+1. fatal
+
+- Objective:
+  * Test MSR read logic of MCE handler
+  * Test synchronization between monarch and subject
+  * Test logic to recognize a fatal (PCC) MCE
+- Code path tested:
+  * do_machine_check()
+  * mce_start()
+  * mce_end()
+  * mce_reign() until mce_panic("Fatal Machine check",)
+  * mce_severity()
+  * mce_timeout() except if (*t <= 0) branch
+  * mce_panic()
+  * print_mce()
+  * mce_log()
+- Reference:
+  * Inject data file: cases/soft-inj/panic/data/fatal
+- Expected result:
+  * No warning or bug during kernel processing.
+  * MCE records collected via kernel panic log is same as reference ones.
+  * Kernel panic message is "Fatal Machine check"
+  * Exception message is "Processor context corrupt"
+
+
+2. fatal timeout
+
+- Objective:
+  * Test logic of timeout during monarch/subject synchronization
+  * Test logic to recognize a fatal (PCC) MCE
+- Code path tested:
+  * do_machine_check()
+  * mce_start()
+  * mce_timeout() if (*t <= 0) branch
+  * mce_severity()
+  * mce_panic("Fatal machine check on current CPU",);
+  * print_mce()
+  * mce_log()
+- Reference:
+  * Inject data file: cases/soft-inj/panic/data/fatal_timeout
+- Expected result:
+  * No warning or bug during kernel processing.
+  * MCE records collected via kernel panic log is same as reference ones.
+  * Kernel panic message is "Fatal machine check on current CPU"
+  * Exception message is "Processor context corrupt"
+  * Timeout message is "Some CPUs didn't answer in synchronization"
+
+
+3. fatal in irq
+
+- Objective:
+  * Test fatal MCE occur in IRQ context
+  * Test logic to recognize a fatal (PCC) MCE
+- Code path tested:
+  * Same as fatal
+- Reference:
+  * Inject data file: cases/soft-inj/panic/data/fatal_irq
+- Expected result:
+  * No warning or bug during kernel processing.
+  * MCE records collected via kernel panic log is same as reference ones.
+  * Kernel panic message is "Fatal Machine check"
+  * Exception message is "Processor context corrupt"
+
+
+4. fatal with RIPV
+
+- Objective:
+  * Test combination of PCC and RIPV
+  * Test logic to recognize a fatal (PCC) MCE
+- Code path tested:
+  * MCG_STATUS_RIPV branch of switch(m.mcgstatus) in do_machine_check
+  * Others are same as fatal
+- Reference:
+  * Inject data file: cases/soft-inj/panic/data/fatal_ripv
+- Expected result:
+  * No warning or bug during kernel processing.
+  * MCE records collected via kernel panic log is same as reference ones.
+  * Kernel panic message is "Fatal Machine check"
+  * Exception message is "Processor context corrupt"
+
+
+5. fatal timeout with RIPV
+
+- Objective:
+  * Test timeout logic of combination of PCC and RIPV
+  * Test logic to recognize a fatal (PCC) MCE
+- Code path tested:
+  * MCG_STATUS_RIPV branch of switch(m.mcgstatus) in do_machine_check
+  * Others are same as fatal_timeout
+- Reference:
+  * Inject data file: cases/soft-inj/panic/data/fatal_timeout_ripv
+- Expected result:
+  * No warning or bug during kernel processing.
+  * MCE records collected via kernel panic log is same as reference ones.
+  * Kernel panic message is "Fatal machine check on current CPU"
+  * Exception message is "Processor context corrupt"
+  * Timeout message is "Some CPUs didn't answer in synchronization"
+
+
+6. fatal with OVER
+
+- Objective:
+  * Test OVER flag in MCI_STATUS processing
+  * Test logic to recognize a fatal (PCC) MCE
+- Code path tested:
+  * Same as fatal
+- Reference:
+  * Inject data file: cases/soft-inj/panic/data/fatal_over
+- Expected result:
+  * No warning or bug during kernel processing.
+  * MCE records collected via kernel panic log is same as reference ones.
+  * Kernel panic message is "Fatal Machine check"
+  * Exception message is "Processor context corrupt"
+
+
+7. fatal and UC without EN
+
+- Objective:
+  * Test no EN processing. Only one MCE can be injected on one CPU, so
+    a MCE without EN are injected on other CPU.
+  * Test logic to recognize a fatal (PCC) MCE
+- Code path tested:
+  * Same as fatal except no EN branch in do_machine_check()
+- Reference:
+  * Inject data file: cases/soft-inj/panic/data/fatal_no_en
+  * Reference MCE records: cases/soft-inj/panic/refer/fatal_no_en
+- Expected result:
+  * No warning or bug during kernel processing.
+  * MCE records collected via kernel panic log is same as reference ones.
+  * Kernel panic message is "Machine check from unknown source"
+  * No exception message
+
+8. fatal with EIPV
+
+- Objective:
+  * Test combination of PCC and EIPV
+  * Test logic to recognize a fatal (PCC) MCE
+- Code path tested:
+  * Same as fatal
+- Reference:
+  * Inject data file: cases/soft-inj/panic/data/fatal_eipv
+- Expected result:
+  * No warning or bug during kernel processing.
+  * MCE records collected via kernel panic log is same as reference ones.
+  * Kernel panic message is "Fatal Machine check"
+  * Exception message is "Processor context corrupt"
+
+
+9. fatal in userspace
+
+- Objective:
+  * Test of PCC in userspace
+  * Test logic to recognize a fatal (PCC) MCE
+- Code path tested:
+  * Same as fatal
+- Reference:
+  * Inject data file: cases/soft-inj/panic/data/fatal_eipv
+- Expected result:
+  * No warning or bug during kernel processing.
+  * MCE records collected via kernel panic log is same as reference ones.
+  * Kernel panic message is "Fatal Machine check"
+  * Exception message is "Processor context corrupt"
+
+
--- ltp-full-20090731.orig/testcases/mce-test/doc/cases/soft-inj_panic_ucr.txt	1970-01-01 05:30:00.000000000 +0530
+++ ltp-full-20090731/testcases/mce-test/doc/cases/soft-inj_panic_ucr.txt	2009-08-05 14:50:57.000000000 +0530
@@ -0,0 +1,100 @@
+Overall: (4 cases)
+
+- Test method
+  * Add cases/soft-inj/panic_ucr/cases.sh into configuration file, and invoke
+    a test driver on it.
+- Common
+  * Test script of test cases in this file can be found in
+    cases/soft-inj/panic_ucr/cases.sh
+
+1. s0_ar1
+
+- Objective:
+  * Test MSR read logic of MCE handler
+  * Test synchronization between monarch and subject
+- Code path tested:
+  * do_machine_check()
+  * mce_start()
+  * mce_timeout() except if (*t <= 0) branch
+  * mce_log()
+  * mce_end()
+  * mce_severity()
+  * mce_reign() until mce_panic("Fatal Machine check",)
+  * mce_panic()
+  * print_mce()
+- Reference:
+  * Inject data file: cases/soft-inj/panic_ucr/data/s0_ar1
+- Expected result:
+  * No warning or bug during kernel processing.
+  * MCE records collected via kernel panic log is same as reference ones.
+  * Kernel panic message is "Fatal Machine check"
+  * Exception message is "Illegal combination (UCNA with AR=1)"
+
+
+2. srar_over
+
+- Objective:
+  * Test logic of timeout during monarch/subject synchronization
+- Code path tested:
+  * do_machine_check()
+  * mce_start()
+  * mce_timeout() except if (*t <= 0) branch
+  * mce_log()
+  * mce_end()
+  * mce_severity()
+  * mce_reign() until mce_panic("Fatal Machine check",)
+  * mce_panic();
+  * print_mce()
+- Reference:
+  * Inject data file: cases/soft-inj/panic_ucr/data/srar_over
+- Expected result:
+  * No warning or bug during kernel processing.
+  * MCE records collected via kernel panic log is same as reference ones.
+  * Kernel panic message is "Fatal Machine check"
+  * Exception message is "Action required with lost events"
+
+
+3. srar_unknown
+
+- Objective:
+  * Test fatal MCE occur in IRQ context
+- Code path tested:
+  * do_machine_check()
+  * mce_start()
+  * mce_timeout() except if (*t <= 0) branch
+  * mce_log()
+  * mce_end()
+  * mce_severity()
+  * mce_reign() until mce_panic("Fatal Machine check",)
+  * mce_panic()
+  * print_mce()
+- Reference:
+  * Inject data file: cases/soft-inj/panic_ucr/data/srar_unknown
+- Expected result:
+  * No warning or bug during kernel processing.
+  * MCE records collected via kernel panic log is same as reference ones.
+  * Kernel panic message is "Fatal Machine check"
+  * Exception message is "Action required; unknown MCACOD"
+
+
+4. srar_no_en
+
+- Objective:
+  * Test fatal MCE occur
+- Code path tested:
+  * do_machine_check()
+  * mce_start()
+  * mce_timeout() except if (*t <= 0) branch
+  * mce_log()
+  * mce_end()
+  * mce_severity()
+  * mce_reign() until mce_panic("Machine check from unknown source",)
+  * mce_panic()
+  * print_mce()
+- Reference:
+  * Inject data file: cases/soft-inj/panic_ucr/data/srar_no_en
+  * Reference MCE records: cases/soft-inj/panic_ucr/refer/srar_no_en
+- Expected result:
+  * No warning or bug during kernel processing.
+  * MCE records collected via kernel panic log is same as reference ones.
+  * Kernel panic message is "Machine check from unknown source"
--- ltp-full-20090731.orig/testcases/mce-test/doc/cases/soft-inj_poll_ucr.txt	1970-01-01 05:30:00.000000000 +0530
+++ ltp-full-20090731/testcases/mce-test/doc/cases/soft-inj_poll_ucr.txt	2009-08-05 14:50:57.000000000 +0530
@@ -0,0 +1,44 @@
+Overall:(2 cases)
+
+- Test method
+  * Preparation
+    + Disable mcelog cron job
+  * Add cases/soft-inj/panic_ucr/cases.sh into configuration file, and invoke
+    a test driver on it.
+- Common
+  * Test script of test cases in this file can be found in
+    cases/soft-inj/panic_ucr/cases.sh
+
+
+1. ucna
+
+- Objective:
+  * Test severity comparison logic of MCE handler
+  * Test logic of uncorrected with POLL
+- Code path tested:
+  * machine_check_poll() except
+        if (!(flags & MCP_UC) &&
+            (m.status & (mce_ser ? MCI_STATUS_S : MCI_STATUS_UC))
+  * mce_log()
+- Reference:
+  * Inject data file: cases/soft-inj/poll_ucr/data/ucna
+- Expected result:
+  * MCE records collected via kernel panic log is same as reference ones.
+  * No warning or bug during kernel processing.
+
+
+2. ucna_over
+
+- Objective:
+  * Test severity comparison logic of MCE handler
+  * Test logic of uncorrected with POLL
+- Code path tested:
+  * machine_check_poll() except
+        if (!(flags & MCP_UC) &&
+            (m.status & (mce_ser ? MCI_STATUS_S : MCI_STATUS_UC))
+  * mce_log()
+- Reference:
+  * Inject data file: cases/soft-inj/poll_ucr/data/ucna_over
+- Expected result:
+  * MCE records collected via kernel panic log is same as reference ones.
+  * No warning or bug during kernel processing.
--- ltp-full-20090731.orig/testcases/mce-test/doc/cases/soft-inj_recoverable_ucr.txt	1970-01-01 05:30:00.000000000 +0530
+++ ltp-full-20090731/testcases/mce-test/doc/cases/soft-inj_recoverable_ucr.txt	2009-08-05 14:50:57.000000000 +0530
@@ -0,0 +1,138 @@
+overall: (7 cases)
+
+- Test method
+  * Add cases/soft-inj/recoverable_ucr/cases.sh into configuration file, and invoke a test driver on it.
+- Common
+  * Test script of test cases in this file can be found in
+    cases/soft-inj/recoverable_ucr/cases.sh
+
+1.srao_corrected
+
+- Objective:
+  * Test logic of uncorrected and corrected
+  * Test logic of uncorrected with S
+  * Test logic of corrected with EXCP
+- Code path tested:
+  * do_machine_check()
+  * mce_start()
+  * mce_timeout() except if (*t <= 0) branch
+  * mce_severity()
+  * mce_log()
+  * mce_end()
+  * mce_reign()
+  * mce_report_event()
+- Reference:
+  * Inject data file: cases/soft-inj/recoverable_uc/data/srao_corrected
+- Expected result:
+  * No warning or bug during kernel processing.
+  * Exception message is "Action optional unknown MCACOD"
+
+2.srao_ewb
+- Objective:
+  * Test logic of uncorrected with S
+  * Test logic of UCR errors detected during last level cache(LLC) explicit writebacks.
+- Code path tested:
+  * do_machine_check()
+  * mce_start()
+  * mce_timeout() except if (*t <= 0) branch
+  * mce_severity()
+  * mce_ring_add()
+  * mce_log()
+  * mce_end()
+  * mce_reign()
+- Reference:
+  * Inject data file: cases/soft-inj/recoverable_uc/data/srao_ewb
+- Expected result:
+  * No warning or bug during kernel processing.
+  * Exception message is "Action optional: last level cache writeback error"
+
+3.srao_mem_scrub
+- Objective:
+  * Test logic of uncorrected with S
+  * Test logic of UCR errors detected on data load
+- Code path tested:
+  * do_machine_check()
+  * mce_start()
+  * mce_timeout() except if (*t <= 0) branch
+  * mce_severity()
+  * mce_ring_add()
+  * mce_log()
+  * mce_end()
+  * mce_reign()
+- Reference:
+  * Inject data file: cases/soft-inj/recoverable_uc/data/srao_mem_scrub
+- Expected result:
+  * No warning or bug during kernel processing.
+  * Exception message is "Action optional: memory scrubbing error"
+
+4.srao_no_en
+- Objective:
+  * Test no EN processing.
+- Code path tested:
+  * do_machine_check()
+  * mce_start()
+  * mce_timeout() except if (*t <= 0) branch
+  * mce_severity()
+  * mce_end()
+  * mce_reign()
+  * mce_panic()
+- Reference:
+  * Inject data file: cases/soft-inj/recoverable_uc/data/srao_no_en
+- Expected result:
+  * No warning or bug during kernel processing.
+  * Kernel panic message is "Machine check from unknown source"
+
+5.srao_over
+- Objective:
+  * Test logic of uncorrected with S and OVER
+- Code path tested:
+  * do_machine_check()
+  * mce_start()
+  * mce_timeout() except if (*t <= 0) branch
+  * mce_severity()
+  * mce_log()
+  * mce_end()
+  * mce_reign()
+- Reference:
+  * Inject data file: cases/soft-inj/recoverable_uc/data/srao_over
+- Expected result:
+  * No warning or bug during kernel processing.
+  * Exception message is "Action optional with lost events"
+
+6.srao_ucna
+- Objective:
+  * Test logic of uncorrected with S
+  * Test logic of ucna
+- Code path tested:
+  * do_machine_check()
+  * mce_start()
+  * mce_timeout() except if (*t <= 0) branch
+  * mce_severity()
+  * mce_get_rip()
+  * mce_log()
+  * mce_end()
+  * mce_reign()
+- Reference:
+  * Inject data file: cases/soft-inj/recoverable_uc/data/srao_ucna
+- Expected result:
+  * No warning or bug during kernel processing.
+  * Exception message is "Action optional with unknown MCACOD"
+
+7.srao_unknown
+- Objective:
+  * Test logic of uncorrected with S
+- Code path tested:
+  * do_machine_check()
+  * mce_start()
+  * mce_timeout() except if (*t <= 0) branch
+  * mce_severity()
+  * mce_get_rip()
+  * mce_log()
+  * mce_end()
+  * mce_reign()
+- Reference:
+  * Inject data file: cases/soft-inj/recoverable_uc/data/srao_unknown
+- Expected result:
+  * No warning or bug during kernel processing.
+  * Exception message is "Action optional with unknown MCACOD"
+
--- ltp-full-20090731.orig/testcases/mce-test/doc/howto.txt	1970-01-01 05:30:00.000000000 +0530
+++ ltp-full-20090731/testcases/mce-test/doc/howto.txt	2009-08-05 14:50:57.000000000 +0530
@@ -0,0 +1,462 @@
+
+MCE test suite HOWTO
+====================
+
+11 November 2008
+
+Huang Ying
+
+Section 4.2 (Test with kdump test driver) is based on the README of
+LTP kdump test case.
+
+Abstract
+--------
+
+This document explains the structure and design of MCE test suite, the
+kernel patch and user space tools needed for automatic tests, usage
+guide and how to add new test cases into test suite.
+
+0. Quick shortcut
+------------------
+- Get mcelog git version from 
+git://git.kernel.org/pub/scm/utils/cpu/mce/mcelog.git.
+and install in /usr/sbin (or rather first in your $PATH)
+
+git clone git://git.kernel.org/pub/scm/utils/cpu/mce/mcelog.git
+cd mcelog
+make
+sudo make install
+
+- Get mce-inject git version from
+git://git.kernel.org/pub/scm/utils/cpu/mce/mce-inject.git.
+
+git clone git://git.kernel.org/pub/scm/utils/cpu/mce/mce-inject.git
+cd mce-inject
+make
+sudo make install
+
+- Run make test-simple
+This will do the basic tests, but not the more complicated kdump ones.
+For more information on those read below.
+
+1. Introduction
+---------------
+
+The MCE test suite is a collection of tools and test scripts for
+testing the Linux kernel MCE processing features. The goal is to cover
+most Linux kernel MCE processing code paths and features with
+automation tests.
+
+If you just want to start testing as quickly as possible, you can skip
+section 2 and section 3, and go section 4.1 directly.
+
+
+2. Structure
+------------
+
+The main intention behind the design is to re-use test cases amongst
+various test methods (represented as test drivers), such as kdump
+based, kernel MCE panic log (tolerant=3) based, etc.
+
+2.1 Test cases
+
+Test cases are grouped into test case classes. The test cases in one
+class share the similar triggering, result collecting and result
+verifying methods. They can be used in same set of test drivers. The
+interface of a test case class is a shell script, usually named as
+cases.sh under a sub-directory of cases/. The following command line
+option should be supported by the test case class shell script:
+
+cases.sh enumerate		enumerate test cases in class, print test
+				case names to stdout
+cases.sh trigger		trigger the test case
+cases.sh get_result		get the result of test case
+cases.sh verify			verify the result of test case, and print
+				the verify result to stdout
+
+When execute cases.sh [trigger|get_result|verify], the test case is
+specified via environment variable this_case, which must be one of the
+test case names returned by "cases.sh enumerate".
+
+Other environment variables are also used to pass some information
+from driver to test cases, such as:
+
+this_case			name current test case
+driver				name of test driver
+klog				file name which holds kernel log during test
+KSRC_DIR (for gcov)		kernel source code directory
+GCOV (for gcov)			gcov collection method
+vmcore (for kdump)		vmcore file name
+reboot (for kdump)		indicate there is a reboot between test
+				case trigger and test case verify, some
+				context has been gone.
+
+Several test case classes are provided with the test suite. They are
+all based on mce-inject MCE software injection tool, and follows same
+structure.
+
+cases/soft-inj/<class name>/cases.sh	Interface of the test case class
+cases/soft-inj/<class name>/data/	Directory contains data file for
+					mce-inject tool.
+cases/soft-inj/<class name>/refer/	Directory contains data file for
+					reference MCE records if necessary.
+
+For document of various test cases, please refer to doc/cases/*.
+
+2.2 Test drivers
+
+Test drivers drive the test procedure, its main structure is a loop
+over test case classes specified in configuration file. For each test
+case class, test driver loops over test cases returned by "cases.sh
+enumerate". And, for each test case, it calls "cases.sh" to trigger,
+get_result and verify the test case. Test driver also do some common
+work for test cases, such as kdump driver collects vmcore file, and
+invoking gcovdump command to get gcov data file.
+
+The interface of test driver is driver.sh, which is usually put in
+drivers/<driver_name>/ directory. The test configuration file should
+be used as the only command line parameter for driver.sh. Test case
+classes should be specified in test configuration file as CASES
+variable, details below.
+
+2.3 Test configuration file
+
+Test configuration file is a shell script to specify parameters for
+test drivers and test cases. It must be put in config/ directory. The
+parameters are represented as shell variables as follow:
+
+CASES				Name of test case classes, separate by
+				white space.
+START_BACKGROUND		Shell command to start a background process
+				during testing, used for random testing.*
+STOP_BACKGROUND			Shell command to stop the background process
+				during testing.
+COREDIR (for kdump)		directory contains Linux kernel crash core
+				dump after kdump.
+VMLINUX (for kdump, gcov)	vmlinux of Linux kernel
+GCOV (for gcov)			Enable GCOV if set none zero.
+KSRC_DIR (for gcov)		Kernel source code directory
+
+* To test MCE processing under random environment, a background
+  process can be automatically run simultaneously during MCE
+  testing. The start/stop command is specified via START_BACKGROUND
+  and STOP_BACKGROUND.
+
+2.4 Test result
+
+After test, the general test result will go results/<driver_name>/result.
+The format of general test result is as follow:
+
+<test case name>:
+  Passed: item 1 description
+  Failed: item 2 description
+  ...
+  Passed: item n description
+
+One blank line is used to separate test cases.
+
+Additional test result for various test cases will go
+"results/<driver_name>/<case_name>/<xxx>. For in-package test case
+class, additional test results include:
+
+results/<driver_name>/soft-inject/<case_name>/klog
+				Kernel log during testing
+results/<driver_name>/soft-inject/<case_name>/mcelog
+				mcelog output during testing
+results/<driver_name>/soft-inject/<case_name>/mcelog_refer
+				mcelog output reference
+results/<driver_name>/soft-inject/<case_name>/mce_64.c.gcov (for gcov)
+				gcov output file
+
+
+3. Tools
+--------
+
+3.1 mce-inject
+
+mce-inject is a software MCE injection tool, which is based on Linux
+kernel software MCE injection mechanism. To inject a MCE into Linux
+kernel via mce-inject, a data file should be provided. The syntax is
+similar to the logging output by mcelog with some extensions. 
+Please refer to the documentation of mce-inject for more information.
+
+The mce-inject program must be executable in $PATH.
+
+3.2 mcelog
+
+mcelog read /dev/mcelog and prints the stored machine check records to
+stdout. It is used by MCE test suite to verify MCE records generated
+by kernel is same as reference records, at most time, same as input
+records. The current git mcelog version is needed for MCE test suite to
+work properly. Please refer to document of mcelog for more
+information. The latest mcelog can be gotten via git snapshot from
+git://git.kernel.org/pub/scm/utils/cpu/mce/mcelog.git.
+
+Note you need the git version of mcelog available in $PATH.
+
+3.3 readcore
+
+readcore read crash dump core file and output memory contents at
+specified virtual address with specified length or zero
+terminated. readcore is used to read some kernel information from
+/proc/kcore and kdump core file. The source code of readcore is put
+in tools/readcore. For more information about readcore please refer to
+README of readcore, which is in tools/readcore/README.
+
+3.4 gcovdump
+
+gcov is a test coverage tool, the original implementation is used for
+user space program only. LTP (Linux Test Project) provides the kernel
+gcov support. But MCE test involves panic or kdump, so gcovdump is
+developed to dump gcov data from kdump crash dump core. gcovdump has
+been merged by LTP cvs. For more information please refer to gcovdump
+document. The latest gcovdump can be gotten from cvs:
+http://ltp.cvs.sourceforge.net/viewvc/ltp/utils/analysis/gcov-kdump/.
+
+
+4. Usage Guide
+--------------
+
+4.1 Test with simple test driver
+
+4.1.1 Simple test driver
+
+The simple test driver just call cases.sh of test cases one by one in
+a loop. So it is not permitted for test cases to trigger real panic or
+reboot during test. For MCE testing, a special processing mode to just
+log everything in case of MCE is used for the simple test driver, it
+is enabled via set MCE parameter "tolerant=3" during
+testing. "tolerant" can be set via writing:
+    /sys/devices/system/machinecheck/machinecheck0/tolerant
+
+4.1.2 test instruction
+
+The following is the basic test instruction, for some additional
+features such as gcov support, please refer to corresponding
+instructions.
+
+a. Linux kernel and user space tools as follow should be installed
+
+   - A Linux kernel with MCE injection support. Latest Linux kernel
+     MCE injection patches can be found at:
+     git://git.kernel.org/pub/scm/linux/kernel/git/ak/linux-mce-2.6.git
+   - mce-inject tool (see 3.1)
+   - mcelog with proper version (see 3.2)
+
+b. Modify config/simple.conf or create a new test configuration
+   file. Refer to section 2.3 for more instruction about test
+   configuration file.
+
+c. Run "make". Carefully check for any errors.
+
+d. To be root and invoke simple test driver on test configuration file
+   as follow
+
+       drivers/simple/driver.sh config/simple.conf
+
+e. General test result will go results/simple/result. Test log will go
+   work/simple/log. Additional test results for various test cases
+   will go results/simple/<test case>/<xxx>. For more details about
+   in-package test case class, please refer to section 2.1.
+
+
+4.2 Test with kdump test driver
+
+4.2.1 kdump test driver
+
+The kdump test driver is based on the kdump test case in Linux Test
+Project, thank LTP for their excellent work!
+
+The kdump driver helps run tests which trigger crash/panic and
+generate result and report via kdump.  The test scripts cycle through a
+series of crash/panic scenarios. Each test cycle does the following:
+
+a.  Triggers a test case which triggers crash/panic (MCE with tolerant=1).
+b.  Kdump kernel boots and saves a vmcore.
+c.  System reboots to 1st kernel.
+d.  Verifies test case, generate result and report.
+e.  After a 1 to 2 minute delay, the next test case is run.
+
+4.2.2 test instruction
+
+Follow the steps to setup kdump test driver.
+
+The test driver is written for SuSE Linux Enterprise Server 10 (and
+onward releases), OpenSUSE, Fedora, Debian, as well as RedHat
+Enterprise Linux 5. Since KDUMP is supported by the above mentioned
+distro's the test driver was written and tested on them. Contribution
+towards supporting more distributions are welcome.
+
+a. Install Linux kernel with MCE injection support. Latest Linux
+   kernel MCE injection patches can be found at: FIXME url.
+
+b. Install these additional packages:
+
+   For SLES10 or OpenSUSE Distro:
+
+     * kernel-kdump
+     * kernel-source
+     * kexec-tools
+
+   For RHEL5 or Fedora distro:
+
+     * kexec-tools
+     * kernel-devel
+
+c. In addition to bzImage and modules of Linux kernel should be
+   installed on test machine, the vmlinux of Linux kernel should be
+   put on test machine and specified via VMLINUX in test configuration
+   file.
+
+d. Make sure the partition where the test driver is running has space
+   for the tests results and one vmcore file (size of physical
+   memory).
+
+e. Create a new test configuration file or use a existing one in
+   config/, such as kdump.conf. Note: not all test case classes can be
+   used with kdump test driver, see "important points" below.
+
+f. Run "make". Carefully check for any errors.
+
+g. To be root and run "drivers/kdump/driver.sh <conf>"
+
+h. After test is done, the test log of the last run of kdump driver will
+   be displayed on main console.
+
+Few Important points to remember:
+
+- kdump test driver request that a real panic should be triggered when
+  test case is triggered. So not all test case classes can be used
+  with kdump test driver, for example, all test case classes for
+  corrected MCE can not be used with kdump test driver.
+
+- If you need to stop the tests before all test cases have run, run
+  "crontab -r" and "killall driver.sh" within 1 minute after the 1st
+  kernel reboots. Then, if you'd like to carry on tests from that point
+  on, run:
+    rm work/kdump/stamps/setupped
+    drivers/kdump/driver.sh <conf>
+  If you'd like to start tests from the beginning, run:
+    make reset
+    drivers/kdump/driver.sh <conf>
+
+- If a failure occurs when booting the kdump kernel, you'll need to
+  manually reset the system so it reboots back to the 1st kernel and
+  continues on to the next test. For this reason, it's best to monitor
+  the tests from a console. If possible, setup a serial console (not a
+  must, any type of console setup will do). If using minicom, enable
+  saving of kernel messages displayed on minicom into a file, by
+  pressing ctrl+a+l on the console. Else, when it is observed that the
+  kdump kernel has failed to boot, manually copy the boot message into
+  a file to enable the debugging the cause of the hang.
+
+- The results are saved in results/kdump/result, which also shows
+  where you are in the test run. When the "Test run complete" entry
+  appears in that file, you're done. Verbose log can be found at
+  work/log.
+
+- The test machine would be unavailable for any other work during the
+  period of the test run.
+
+4.3 Gcov support
+
+Gcov is a test coverage tool. It can be used to discover untested
+parts of program, collect branch taken statistics to optimize program,
+etc. In MCE test suite, it is used to get test coverage, that is,
+which C statements are covered by each test case.
+
+Gcov support is optional, if you don't care about test coverage
+information, just skip this section.
+
+a. Make sure your kernel has gcov support. You can find lasted kernel
+   gcov patches from:
+       http://ltp.sourceforge.net/coverage/gcov.php
+
+   A README for kernel gcov can be found from:
+       http://ltp.sourceforge.net/coverage/gcov/readme.php
+
+   Notes: CONFIG_GCOV_ALL does not work for me. Add the line
+       EXTRA_CFLAGS += $(KBUILD_GCOV_FLAGS)
+   to the respective Makefiles are more stable. For example, this line
+   can be added into "linux/arch/x86/kernel/cpu/mcheck/Makefile"
+
+b. If you want to use gcov with kdump test driver, please install
+   gcovdump tool(see section 3.4). The latest gcovdump can be gotten
+   from cvs:
+   http://ltp.cvs.sourceforge.net/viewvc/ltp/utils/analysis/gcov-kdump/.
+
+c. Linux kernel source source code should be put on the test
+   machine. Its root directory should be specified in test
+   configuration file via KSRC_DIR.
+
+d. In addition to bzImage and modules of Linux kernel should be
+   installed on test machine, the vmlinux of Linux kernel should be
+   put on test machine and specified via VMLINUX of test configuration
+   file.
+
+e. Make sure gcov is available in your test system. It comes with gcc
+   package normally. If kdump test driver is used, a tool named
+   gcovdump is also needed to dump *.gcda from crash dump image.
+
+f. In test configuration file, make sure the following setting is
+   available:
+
+       # enable GCOV support
+       GCOV=1
+       # kernel source is needed to get gcov graph
+       KSRC_DIR=<kernel source directory>
+       VMLINUX=<vmlinux>
+
+g. After testing, *.c.gcov will be generated in test case result
+   directory, such as
+   results/kdump/soft-inj/non-panic/corrected/mce_64.c.gcov.
+
+h. To merge gcov graph data from several test cases, a tool named
+   gcov_merge.py in tools sub-directory can be used. For example,
+
+       tools/gcov_merge results/kdump/soft-inj/*/*/mce_64.c.gcov
+
+   Will output merged gcov graph from all test cases under
+   soft-inj. This can be used to check coverage of several test cases.
+
+4.4 tool
+
+Some tools are provided to help analyze test result.
+
+- tools/grep_result.sh
+
+  Grep from general test result (results/<driver_name>/result) in
+  terms of test case instead of line, because the result of one test
+  case may span several line.
+
+  Usage:
+      cat results/<driver_name>/result | tools/grep_result.sh <grep options>
+
+  Where <grep options> are same as options available to /bin/grep.
+
+
+5. Add test cases
+-----------------
+
+5.1 Add test case to in-package test class
+
+All in-package test classes use mce-inject software injection tool and
+follows same structure. The steps to add a new test case is as follow:
+
+a. Find an appropriate test case class to add your test case.
+
+b. Add a new mce-inject data file into to cases/soft-inj/<class name>/data/.
+
+c. If the reference mcelog is different from mce-inject input data
+   file, put that reference file into cases/soft-inj/<class_name>/refer/.
+
+d. In cases/soft-inj/<class name>/cases.sh, there are shell commands
+   "case" in shell functions get_result() and verify(). Add a branch
+   in each shell command "case" for your test case.
+
+5.2 Add test class
+
+To add a new test class, add a cases.sh under a sub-directory of
+cases/, and follow the test case class interface definition in section
+2.1. The general result output format should follow that in section
+2.4.
--- ltp-full-20090731.orig/testcases/mce-test/doc/verify.txt	1970-01-01 05:30:00.000000000 +0530
+++ ltp-full-20090731/testcases/mce-test/doc/verify.txt	2009-08-05 14:50:57.000000000 +0530
@@ -0,0 +1,33 @@
+To verify the result of MCE testing, the MCE record from kernel (via
+/dev/mcelog or panic information) should be compared with reference
+MCE record (for software inject error: the input MCE record). To
+compare MCE record, the following scheme is proposed:
+
+- Define a standard MCE record representation format. It should be
+  human readable, compatible with MCE parser in mce-inject, easy to
+  manipulate in shell (such as remove a field), easy to compare
+  (literally).
+
+  One MCE record is as follow:
+
+  CPU NUMBER
+  BANK NUMBER
+  TSC NUMBER
+  RIP NUMBER
+  ADDR NUMBER
+  MISC NUMBER
+  STATUS NUMBER
+  MCGSTATUS NUMBER
+
+  Multiple MCE records are separated by one empty line.
+
+- Enhance mce-inject or develop a new tool to convert from other
+  format to standard format.
+
+- Develop a new tool based on /usr/sbin/mcelog to output mce-inject
+  compatible MCE record. Because there may be different (uncompatible
+  version) /usr/sbin/mcelog on different machine.
+
+- During verifying, firstly convert various MCE recoards from kernel
+  and reference MCE records to standard format, then compare the
+  standard format MCE records in shell.
--- ltp-full-20090731.orig/testcases/mce-test/drivers/kdump/driver.sh	1970-01-01 05:30:00.000000000 +0530
+++ ltp-full-20090731/testcases/mce-test/drivers/kdump/driver.sh	2009-08-05 14:50:57.000000000 +0530
@@ -0,0 +1,280 @@
+#!/bin/sh -xe
+#
+# Kdump test driver: test case will trigger panic, and then crash
+# dump. The test result is collected via dumped vmcore. For more
+# information about kdump dirver please refer to doc/README.kdump.
+#
+# Copyright (C) 2008, Intel Corp.
+#   Author: Huang Ying <ying.huang@intel.com>
+#
+# This file is based on kdump test case in LTP.
+#
+# This file is released under the GPLv2.
+#
+
+sd=$(dirname "$0")
+export ROOT=`(cd $sd/../..; pwd)`
+
+export driver=kdump
+
+. $ROOT/lib/functions.sh
+setup_path
+. $ROOT/lib/dirs.sh
+. $ROOT/lib/mce.sh
+
+setup_crontab ()
+{
+    echo "Setup crontab."
+
+    set +e
+    crontab -r
+    set -e
+   
+    # crontab in some distros will not read from STDIN.
+
+    cat <<EOF > $WDIR/kdump.cron
+SHELL=/bin/sh
+PATH=/usr/local/bin:/usr/bin:/usr/sbin:/sbin:/bin
+MAILTO=root
+@reboot cd "$(pwd)"; ${0} $conf >> $WDIR/log 2>&1; cat $WDIR/log > /dev/console
+EOF
+
+    crontab $WDIR/kdump.cron
+
+    echo "Enable cron daemon by default."
+    
+    if [ -f /etc/init.d/crond ]; then
+        cron=crond
+    else
+        # SUSE
+        cron=cron
+    fi
+
+    # Red Hat and SUSE.
+    if [ -x "/sbin/chkconfig" ]; then
+        /sbin/chkconfig "${cron}" on
+ 
+    # Debian and Ubuntu.
+    elif [ -x "/sbin/update-rc.d" ]; then
+        /sbin/update-rc.d "${cron}" defaults
+    fi
+}
+
+setup_kdump ()
+{
+    echo "Start kdump daemon."
+    /etc/init.d/kdump restart
+    
+    echo "Enable kdump daemon by default."
+    # Red Hat and SUSE.
+    if [ -x "/sbin/chkconfig" ]; then
+        /sbin/chkconfig kdump on
+        
+    # Debian and Ubuntu.
+    elif [ -x "/sbin/update-rc.d" ]; then
+        /sbin/update-rc.d kdump defaults
+    fi    
+}
+
+get_klog()
+{
+    klog=$RDIR/$this_case/klog
+    cat <<EOF > $WDIR/get_klog_gdb.cmd
+dump memory $klog log_buf log_buf+log_end
+EOF
+    set +e
+    gdb -batch -batch-silent -x $WDIR/get_klog_gdb.cmd $VMLINUX $vmcore \
+	> /dev/null 2>&1
+    ret=$?
+    set -e
+    if [ $ret -eq 0 -a -s $klog ]; then
+	export klog
+    else
+	echo "  Failed: can not get kernel log"
+	rm -rf $klog
+    fi
+}
+
+dump_gcov()
+{
+    if [ -z "$GCOV" ]; then
+	return
+    fi
+    if ! chk_gcov; then
+	echo "gcov is not supported by kernel, or there is no gcov utility installed, disable gcov support."
+	unset GCOV
+	return
+    fi
+    if [ -z "$KSRC_DIR" ]; then
+	echo "  Failed: please set KSRC_DIR for GCOV"
+	return
+    else
+	KSRC_DIR=$(set -P && cd "$KSRC_DIR" && pwd)
+	if [ -z "$KSRC_DIR"]; then
+	    echo "  Failed: Invalid KSRC_DIR, please check your setup"
+	    return
+	fi
+    fi
+    export KSRC_DIR
+    local gcov_head_raw=$WDIR/dump_gcov_head_raw
+    cat <<EOF > $WDIR/dump_gcov_gdb.cmd
+dump value $gcov_head_raw (void *)gcov_info_head
+EOF
+    set +e
+    gdb -batch -batch-silent -x $WDIR/dump_gcov_gdb.cmd $VMLINUX $vmcore \
+	> /dev/null 2>&1
+    ret=$?
+    set -e
+    if [ $ret -ne 0 -o ! -s $gcov_head_raw ]; then
+	echo "  Failed: can not get kernel gcov_info_head"
+	return
+    fi
+    wl=$(stat -c '%s' $gcov_head_raw)
+    h=$(echo -n 0x; od -A n -t x$wl $gcov_head_raw | tr -d ' ')
+    if ! gcovdump -g $h $vmcore &> /dev/null; then
+	echo "  Failed: can not dump kernel gcov info"
+	return
+    fi
+cat <<"EOF" > $WDIR/dump_gcov_deskew.sh
+    fn="$1"
+    bfn=$(basename "$fn")
+    dbfn="${bfn##\.tmp_}"
+    if [ -z "$dbfn" ]; then
+        return
+    fi
+    d=$(dirname "$fn")
+    cp $fn "$d/$dbfn"
+EOF
+    chmod +x $WDIR/dump_gcov_deskew.sh
+    find $KSRC_DIR \( -name '*.tmp_*gcno' -o -name '*.tmp_*gcda' \) \
+        -exec $WDIR/dump_gcov_deskew.sh \{\} \;
+
+    export GCOV=dump
+}
+
+get_result ()
+{
+    vmcore=$(ls -t "${COREDIR}"/*/vmcore* 2>/dev/null | head -1)
+
+    if [ -n "$vmcore" -a -f "$vmcore" ]; then
+	export vmcore
+	get_klog
+	dump_gcov
+    else
+	echo "  Failed: can not get vmcore"
+    fi
+
+    export reboot=1
+
+    $CDIR/$case_sh get_result
+}
+
+verify_case ()
+{
+    if [ -z "$vmcore" ]; then
+	echo "  Failed: can not got vmcore"
+    fi
+    $CDIR/$case_sh verify
+}
+
+trigger_case ()
+{
+    # Be careful to define COREDIR.
+    rm -rf "${COREDIR}"/*
+
+    # Save STDIO buffers.
+    sync
+    $CDIR/$case_sh trigger
+}
+
+# Start test.
+if [ $# -lt 1 ]; then
+    die "Usage: $0 <config>"
+fi
+
+conf=$(basename "$1")
+
+. $CONF_DIR/$conf
+
+driver_prepare
+set_tolerant 1
+set_panic_on_oops 0
+
+# Check mandatory variables.
+if [ -z "${COREDIR}" ]; then
+    die "Fail: some mandatory variables are missing from configuration file."
+fi
+
+# Reboot the machine first to take advantage of boot parameter 
+# changes.
+if [ ! -f $WDIR/stamps/setupped ]; then
+    echo "Setup test environment."
+
+    setup_crontab
+
+    $SDIR/setup.sh $CONF_DIR/$conf
+
+    echo > $WDIR/stamps/setupped
+
+    echo "System is going to reboot."
+    /sbin/shutdown -r now
+    sleep 60
+    exit -1
+fi
+
+for case_sh in ${CASES}; do
+    for this_case in $($CDIR/$case_sh enumerate); do
+	export this_case
+	_this_case=$(echo $this_case | tr '/' '_')
+
+	if [ -f $WDIR/stamps/${_this_case}_done ]; then
+	    continue
+	fi
+
+        # First Test.
+	if [ ! -f $WDIR/stamps/first_test_checked ]; then
+            echo "First test..."
+            echo "Verify Boot Loader."
+            if ! grep 'crashkernel=' /proc/cmdline; then
+		die "Fail: error changing Boot Loader, no crashkernel=."
+            fi
+            setup_kdump
+	    echo > $WDIR/stamps/first_test_checked
+	fi
+
+	if [ ! -f $WDIR/stamps/${_this_case}_triggered ]; then
+	    echo > $WDIR/stamps/${_this_case}_triggered
+
+	    mkdir -p $RDIR/$this_case
+	    rm -rf $RDIR/$this_case/*
+	    echo -e "\n$this_case:" | tee -a $RDIR/result
+
+	    echo "Running current test $this_case."
+
+	    trigger_case | tee -a $RDIR/result
+
+	    triggering=1
+	fi
+
+	sleep 5
+
+	if [ -z "$triggering" ]; then
+            (get_result; verify_case) | tee -a $RDIR/result
+	else
+	    echo "  Failed: Failed to trigger kdump" | tee -a $RDIR/result
+	fi
+	echo > $WDIR/stamps/${_this_case}_done
+
+        # Wait for system to fully boot and leave a chance for user to
+        # stop test
+	sleep 55
+    done
+done
+
+echo "Test run complete" | tee -a $RDIR/result
+
+# We are done.
+# Reset.
+crontab -r
+
+exit 0
--- ltp-full-20090731.orig/testcases/mce-test/drivers/kdump/setup.sh	1970-01-01 05:30:00.000000000 +0530
+++ ltp-full-20090731/testcases/mce-test/drivers/kdump/setup.sh	2009-08-05 14:50:57.000000000 +0530
@@ -0,0 +1,105 @@
+#!/bin/sh -ex
+#
+# Setup for kdump test driver.
+#
+# This file is copied from kdump test case of LTP.
+#
+# This file is released under the GPLv2.
+#
+
+conf=${1}
+arch=$(uname -m)
+kver=$(uname -r)
+
+. "${conf}"
+
+echo "Verify Kernel version >= 2.6.16."
+# Kernel might in the following format.
+# x.y.z-1.el
+# x.y.z.1.el
+kx=${kver%%.*}
+tmp=${kver#*.}
+ky=${tmp%%.*}
+tmp=${tmp#*.}
+tmp=${tmp%%.*}
+kz=${tmp%%-*}
+
+if [ "${kx}" -lt 2 ]; then
+    error=1
+
+elif [ "${kx}" -eq 2 ]; then
+    if [ "${ky}" -lt 6 ]; then
+        error=1
+
+    elif [ "${ky}" -eq 6 ]; then
+        if [ "${kz}" -lt 16 ]; then
+            error=1
+        fi
+    fi
+fi
+
+if [ "${error}" ]; then
+    echo "Fail: kernel version ${kver} is less than 2.6.16."
+fi
+
+
+echo "Verify user is root."
+if [ $(id -u) != 0 ]; then
+    echo "Fail: root is required."
+    error=1
+fi
+
+
+echo "Verify prerequisite."
+if [ ! -x "/sbin/kexec" ]; then
+    echo "Fail: kexec-tools not found."
+    error=1
+fi
+
+if [ ! -d "/lib/modules/${kver}/build" ]; then
+    echo "Fail: kernel-devel not found."
+    error=1
+fi
+
+if [ "${CRASH}" ] && [ "${CRASH}" -eq 1 ]; then
+    if [ ! -x "/usr/bin/crash" ]; then
+        echo "Fail: crash not found."
+        error=1
+    fi
+
+    if [ ! -f "${VMLINUX}" ]; then
+        echo "Fail: kernel-debuginfo not found."
+        error=1
+    fi
+fi
+
+# Final result.
+if [ "${error}" ]; then
+    echo "Please fixed the above failures before continuing."
+    exit 1
+fi
+
+echo "Modify Boot Loader."
+if [ "${arch}" = "ppc64" ]; then
+    args="crashkernel=256M@32M xmon=off"
+elif [ "${arch}" = "i686" ]; then
+    args="crashkernel=128M@16M nmi_watchdog=1"
+elif [ "${arch}" = "ia64" ]; then
+    args="crashkernel=512M@256M"
+else
+    args="crashkernel=128M@16M"
+fi
+
+if [ -x "/sbin/grubby" ]; then
+    /sbin/grubby --default-kernel |
+     xargs /sbin/grubby --args="${args}" --update-kernel
+
+else
+    echo "Warn: please make sure the following arguments are in Boot\
+ Loader:"
+    echo "$args"
+    echo "Hit any key when ready."
+    read
+fi
+
+exit 0
--- ltp-full-20090731.orig/testcases/mce-test/drivers/simple/driver.sh	1970-01-01 05:30:00.000000000 +0530
+++ ltp-full-20090731/testcases/mce-test/drivers/simple/driver.sh	2009-08-05 14:50:57.000000000 +0530
@@ -0,0 +1,119 @@
+#!/bin/sh
+#
+# Simple test driver: run test cases one by one, assuming test case
+# will not trigger panic or reboot.
+#
+# Copyright (C) 2008, Intel Corp.
+#   Author: Huang Ying <ying.huang@intel.com>
+#
+# This file is released under the GPLv2.
+#
+
+sd=$(dirname "$0")
+export ROOT=`(cd $sd/../..; pwd)`
+
+export driver=simple
+
+. $ROOT/lib/functions.sh
+setup_path
+. $ROOT/lib/dirs.sh
+. $ROOT/lib/mce.sh
+
+tmp_klog=$WDIR/simple_klog_tmp
+
+chk_err()
+{
+    if [ \( -n "$DEBUG_MCE_TEST" \) -a \( -s $err_log \) ]; then
+	cat $err_log
+    fi
+}
+
+klog_begin()
+{
+    dmesg > $tmp_klog.1
+}
+
+klog_end()
+{
+    dmesg | sed -e '1d' > $tmp_klog.2
+    diff $tmp_klog.1 $tmp_klog.2 | grep '^> ' | sed 's/> \(.*\)/\1/' > $klog
+}
+
+trigger()
+{
+    reset_gcov
+
+    $CDIR/$case_sh trigger
+}
+
+get_result()
+{
+    $CDIR/$case_sh get_result
+}
+
+test_all()
+{
+    if [ -n "$GCOV" ]; then
+	if chk_gcov; then
+	    export GCOV=copy
+	    export KSRC_DIR
+	else
+	    echo "gcov is not supported by kernel, or there is no gcov utility installed, disable gcov support."
+	    unset GCOV
+	fi
+    fi
+
+    for case_sh in $CASES; do
+	for this_case in $($CDIR/$case_sh enumerate); do
+	    set_fake_panic 1
+
+	    export this_case
+	    mkdir -p $RDIR/$this_case
+	    rm -rf $RDIR/$this_case/*
+	    echo -e "\n$this_case:" | tee -a $RDIR/result
+	    klog=$RDIR/$this_case/klog
+
+	    mkdir -p $WDIR/$this_case
+	    rm -rf $WDIR/$this_case/*
+	    local err_log=$WDIR/$this_case/err_log
+
+	    klog_begin
+	    trigger 2>$err_log | tee -a $RDIR/result
+	    chk_err
+	    random_sleep
+	    klog_end
+	    get_result 2>$err_log | tee -a $RDIR/result
+	    chk_err
+	    $CDIR/$case_sh verify 2>$err_log | tee -a $RDIR/result
+	    chk_err
+
+	    set_fake_panic 0
+	done
+    done
+}
+
+if [ $# -lt 1 ]; then
+    die "Usage: $0 <config>"
+fi
+
+conf=$(basename "$1")
+
+. $CONF_DIR/$conf
+
+driver_prepare
+set_panic_on_oops 0
+
+if [ -n "$START_BACKGROUND" ]; then
+    eval $START_BACKGROUND
+else
+    start_background
+fi
+
+test_all
+
+if [ -n "$STOP_BACKGROUND" ]; then
+    eval $STOP_BACKGROUND
+else
+    stop_background
+fi
+
--- ltp-full-20090731.orig/testcases/mce-test/lib/dirs.sh	1970-01-01 05:30:00.000000000 +0530
+++ ltp-full-20090731/testcases/mce-test/lib/dirs.sh	2009-08-05 14:50:57.000000000 +0530
@@ -0,0 +1,21 @@
+#
+# Setup environment variable for various directories.
+#
+# Copyright (C) 2008, Intel Corp.
+#   Author: Huang Ying <ying.huang@intel.com>
+#
+# This file is released under the GPLv2.
+#
+
+RCDIR=cases
+RCONF_DIR=config
+RRDIR=results
+RWDIR=work
+RLDIR=lib
+
+SDIR=$(script_dir)
+CDIR=$ROOT/cases
+CONF_DIR=$ROOT/config
+RDIR=$ROOT/results/$driver
+WDIR=$ROOT/work/$driver
+LDIR=$ROOT/lib
--- ltp-full-20090731.orig/testcases/mce-test/lib/functions.sh	1970-01-01 05:30:00.000000000 +0530
+++ ltp-full-20090731/testcases/mce-test/lib/functions.sh	2009-08-05 14:50:57.000000000 +0530
@@ -0,0 +1,90 @@
+#
+# Function library: provide common functions
+#
+# Copyright (C) 2008, Intel Corp.
+#   Author: Huang Ying <ying.huang@intel.com>
+#
+# This file is released under the GPLv2.
+#
+
+setup_path()
+{
+    export PATH=$ROOT/bin:$PATH
+}
+
+script_dir()
+{
+    local rd=$(dirname "$0")
+    (cd $rd; pwd)
+}
+
+relative_path()
+{
+    local len1=${#1}
+    local len2=${#2}
+    if [ $len1 -eq 0 -o $len1 -ge $len2 -o "${2:0:$len1}" != "$1" ]; then
+	die "$2 is not the sub-path of $1!"
+    fi
+    len1=$((len1 + 1))
+    echo "${2:$len1}"
+}
+
+die()
+{
+    echo "DIE: $@"
+    echo "DIE: $@" 1>&2
+    exit -1
+}
+
+driver_prepare()
+{
+    mkdir -p $WDIR/stamps
+}
+
+check_kern_warning_bug()
+{
+    local f="$1"
+    [ -n "$f" ] || die "missing parameter for check_kern_warning"
+    grep -e '----\[ cut here \]---' $f > /dev/null || \
+	grep -e 'BUG:' $f > /dev/null
+}
+
+random_sleep()
+{
+    local s=$((RANDOM / 13107 + 5))
+    sleep $s
+}
+
+start_background()
+{
+    if [ -n "$BACKGROUND" ]; then
+	pid_background=$(bash -i -c "$BACKGROUND &>$WDIR/background_log & echo \$!")
+	if ! ps -p $pid_background > /dev/null; then
+	    die "Failed to start background testing: $BACKGROUND"
+	fi
+    fi
+}
+
+stop_background()
+{
+    if [ -n "$pid_background" ]; then
+	if ! kill -TERM -$pid_background &> /dev/null; then
+	    kill $pid_background || true
+	fi
+    fi
+}
+
+filter_fake_panic()
+{
+    local orig_klog=$1
+    local new_klog=$2
+    [ $# -eq 2 ] || die "missing parameter for filter_fake_panic"
+
+    local pn
+    pn=$(grep -n "Fake kernel panic" $orig_klog | cut -d ':' -f 1 | head -1)
+    if [ -z "$pn" ]; then
+	cp $orig_klog $new_klog
+    else
+	sed -n "1,${pn}p" < $orig_klog > $new_klog
+    fi
+}
--- ltp-full-20090731.orig/testcases/mce-test/lib/mce.sh	1970-01-01 05:30:00.000000000 +0530
+++ ltp-full-20090731/testcases/mce-test/lib/mce.sh	2009-08-05 14:50:57.000000000 +0530
@@ -0,0 +1,311 @@
+#
+# MCE library: provide MCE specific functions
+#
+# Copyright (C) 2008, Intel Corp.
+#   Author: Huang Ying <ying.huang@intel.com>
+#
+# This file is released under the GPLv2.
+#
+
+extract_mce_from_log()
+{
+    [ $# -eq 2 ] || die "missing parameter for extract_mce_from_log"
+    local log="$1"
+    local outf="$2"
+
+    sed '1,/HARDWARE ERROR/d' "$log" | \
+	mcelog --no-dmi --dump-raw-ascii --ascii > "$outf"
+}
+
+mce_reformat()
+{
+    [ $# -eq 2 ] || die "missing parameter for mce_reformat"
+    local org="$1"
+    local outf="$2"
+
+    mce-inject --dump "$org" > "$outf"
+}
+
+mce_reformat_for_cmp()
+{
+    local inf="$1"
+    local outf="$2"
+    local removes="$3"
+
+    local tmpf=$WDIR/mce_reformat_for_cmp
+
+    mce-inject --dump "$inf" > $tmpf
+
+    if [ -n "$removes" ]; then
+	for remove in $removes; do
+	    sed "/$remove/d" -i $tmpf
+	done
+    fi
+
+    cat $tmpf | tr '\n' '#' | sed '1,$s/##/\n/g' | \
+	grep -v '#STATUS 0x0#' | \
+	grep -v '#STATUS 0x800000000000000#' | sort > "$outf"
+}
+
+mce_cmp()
+{
+    [ $# -eq 3 ] || die "missing parameter for mce_cmp"
+    local m1="$1"
+    local m2="$2"
+    local removes="$3"
+
+    local tmpf1=$WDIR/mce_cmp_1
+    local tmpf2=$WDIR/mce_cmp_2
+
+    mce_reformat_for_cmp "$m1" $tmpf1 "$removes"
+    mce_reformat_for_cmp "$m2" $tmpf2 "$removes"
+    diff $tmpf1 $tmpf2 > /dev/null
+}
+
+get_mcelog_from_dev()
+{
+    [ $# -eq 1 ] || die "missing parameter for get_mcelog_from_dev"
+    local mcelog_result="$1"
+    if mcelog --dump-raw-ascii > "$mcelog_result"; then
+	true
+    else
+	echo "  Failed: can not get mce log from /dev/mcelog"
+    fi
+}
+
+# extract mcelog from kernel log
+get_mcelog_from_klog()
+{
+    [ $# -eq 2 ] || die "missing parameter for get_mcelog_from_klog"
+    local klog="$1"
+    local mcelog_result="$2"
+    if [ -f "$klog" ] && extract_mce_from_log "$klog" "$mcelog_result"; then
+	true
+    else
+	echo "  Failed: Can not extract mcelog from console log"
+    fi
+}
+
+mcelog_filter()
+{
+    [ $# -eq 2 ] || die "missing parameter for mcelog_filter"
+    local inf="$1"
+    local pat="$2"
+
+    mce-inject --dump "$inf" | tr '\n' '#' | sed '1,$s/##/\n/g' | \
+	grep -e "$pat"
+}
+
+chk_gcov()
+{
+    if [ -z "$GCOV" ]; then
+	return 1
+    fi
+
+    if [ -f /sys/kernel/debug/gcov/reset ] && which gcov > /dev/null; then
+	return 0
+    else
+	return 1
+    fi
+}
+
+reset_gcov()
+{
+    if [ -z "$GCOV" ]; then
+	return
+    fi
+    case $GCOV in
+	copy)
+	    echo 1 > /sys/kernel/debug/gcov/reset
+	    ;;
+	dump)
+	    true;
+	    ;;
+	*)
+	    echo "  Failed: can not reset gcov, invalid GCOV=$GCOV"
+	    return
+	    ;;
+    esac
+}
+
+get_gcov()
+{
+    [ $# -eq 1 ] || die "missing parameter for get_gcov"
+    local src_path=$1
+    local src_fn=$(basename $src_path)
+    local src_dir=$(dirname $src_path)
+    if [ -z "$GCOV" ]; then
+	return
+    fi
+    local abs_dir=$(cd -P $KSRC_DIR/$src_dir; pwd)
+    case $GCOV in
+	copy)
+	    for f in /sys/kernel/debug/gcov/$abs_dir/*.gc*; do
+		bf=$(basename $f)
+		cat $f > $abs_dir/$bf
+	    done
+	    ;;
+	dump)
+	    true
+	    ;;
+	*)
+	    echo "  Failed: can not get gcov path, invalid GCOV=$GCOV"
+	    return
+	    ;;
+    esac
+    if ! (cd $KSRC_DIR; gcov -o $src_dir $src_fn &> /dev/null) || \
+	! [ -s $KSRC_DIR/$src_fn.gcov ]; then
+	echo "  Failed: can not get gcov graph"
+	return
+    fi
+    cp $KSRC_DIR/$src_fn.gcov $RDIR/$this_case
+}
+
+reset_severity_cov()
+{
+    echo 1 > /sys/kernel/debug/mce/severities-coverage
+}
+
+get_severity_cov()
+{
+    local sev_cor=/sys/kernel/debug/mce/severities-coverage
+    if [ ! -f $sev_cor ]; then
+	echo "  Failed: can not get severities_coverage"
+	return
+    fi
+    cp $sev_cor $RDIR/$this_case
+}
+
+verify_klog()
+{
+    [ $# -eq 1 ] || die "missing parameter for verify_klog"
+    local klog="$1"
+    if [ -f "$klog" ]; then
+	if check_kern_warning_bug "$klog"; then
+	    echo "  Failed: kernel warning or bug during MCE"
+	else
+	    echo "  Passed: No kernel warning or bug"
+	fi
+    else
+	echo "  Failed: no kernel log"
+    fi
+}
+
+verify_panic_via_klog()
+{
+    [ $# -eq 2 ] || die "missing parameter for verify_panic"
+    local klog="$1"
+    local mce_panic="$2"
+    if [ ! -f "$klog" ]; then
+	echo "  Failed: no kernel log for checking panic"
+	return -1
+    fi
+
+    if grep "panic" "$klog" | grep "$mce_panic" > /dev/null; then
+	echo "  Passed: correct panic"
+    else
+	echo "  Failed: uncorrect panic, expected: $mce_panic"
+    fi
+}
+
+verify_timeout_via_klog()
+{
+    [ $# -eq 1 ] || die "missing parameter for verify_timeout"
+    local klog="$1"
+    if [ ! -f "$klog" ]; then
+	echo "  Failed: No kernel log for checking timeout"
+	return -1
+    fi
+
+    if grep "Some CPUs didn't answer in synchronization" "$klog" \
+	> /dev/null; then
+	echo "  Passed: timeout detected"
+    else
+	echo "  Failed: no timeout detected"
+    fi
+}
+
+verify_exp_via_klog()
+{
+    [ $# -ge 2 ] || die "missing parameter for verrify_exp_via_klog"
+    local klog="$1"
+    shift
+    if [ ! -f "$klog" ]; then
+	echo "  Failed: No kernel log for checking MCE exp"
+	return -1
+    fi
+
+    for exp in "$@"; do
+	if grep "Machine check: " "$klog" | grep "$exp" > /dev/null; then
+	    echo "  Passed: correct MCE exp"
+	    return
+	fi
+    done
+    echo "  Failed:  uncorrected MCE exp, expected: $exp"
+}
+
+get_panic_from_mcelog()
+{
+    [ $# -eq 1 ] || die "missing parameter for get_panic_from_mcelog"
+    local mcelog="$1"
+    local tmpf=$WDIR/get_panic_from_mcelog
+    local addr
+    if mcelog_filter $mcelog "#BANK 219#" | head -1 > $tmpf; then
+	local F="$(sed '1,$s/#/\n/g' $tmpf | awk '/MISC / { print $2 }')"
+	case "$F" in 
+	0x1) echo "Fatal machine check" ;;
+	0x2) echo "Machine check from unknown source" ;;
+	0x3) echo "Uncorrected data corruption machine check" ;;
+	0x4) echo "Fatal machine check" ;;
+	*) echo unknown panic $F ;;
+	esac
+    fi
+}
+
+verify_panic_msg()
+{
+    [ $# -eq 2 ] || die "missing parameter for verify_panic_msg"
+    local panic_msg="$1"
+    local mce_panic="$2"
+
+    if echo ": $panic_msg" | grep -e "$mce_panic" &> /dev/null; then
+	echo "  Passed: correct panic"
+    else
+	echo "  Failed: uncorrect panic, expected: $mce_panic"
+    fi
+}
+
+verify_timeout_via_mcelog()
+{
+    [ $# -eq 1 ] || die "missing parameter for verify_timeout"
+    local mcelog="$1"
+
+    if mcelog_filter $mcelog "#BANK 218#" &> /dev/null; then
+	echo "  Passed: timeout detected"
+    else
+	echo "  Failed: no timeout detected"
+    fi
+}
+
+set_tolerant()
+{
+    [ $# -eq 1 ] || die "missing parameter for set_tolerant"
+    echo -n $1 > /sys/devices/system/machinecheck/machinecheck0/tolerant
+}
+
+get_tolerant()
+{
+    cat /sys/devices/system/machinecheck/machinecheck0/tolerant
+}
+
+set_fake_panic()
+{
+    [ $# -eq 1 ] || die "missing parameter for set_fake_panic"
+    echo -n $1 > /sys/devices/system/machinecheck/machinecheck0/fake_panic
+}
+
+set_panic_on_oops()
+{
+    [ $# -eq 1 ] || die "missing parameter for set_panic_on_oops"
+    echo -n $1 > /proc/sys/kernel/panic_on_oops
+}
--- ltp-full-20090731.orig/testcases/mce-test/lib/soft-inject.sh	1970-01-01 05:30:00.000000000 +0530
+++ ltp-full-20090731/testcases/mce-test/lib/soft-inject.sh	2009-08-05 14:50:57.000000000 +0530
@@ -0,0 +1,146 @@
+#
+# Software Inject library: Software inject specific functions
+#
+# Copyright (C) 2008, Intel Corp.
+#   Author: Huang Ying <ying.huang@intel.com>
+#
+# This file is released under the GPLv2.
+#
+
+if [ -n "$this_case" ]; then
+    bcase=$(basename $this_case)
+fi
+mcelog_result=$RDIR/$this_case/mcelog
+klog=$RDIR/$this_case/klog
+
+soft_inject_verify_mcelog()
+{
+    # check mcelog
+    if [ -f $RDIR/$this_case/mcelog ]; then
+	if [ -f $SDIR/refer/$bcase ]; then
+	    mcelog_refer=$SDIR/refer/$bcase
+	else
+	    mcelog_refer=$SDIR/data/$bcase
+	fi
+	mce_reformat $mcelog_refer $RDIR/$this_case/mcelog_refer
+
+	if mce_cmp $RDIR/$this_case/mcelog $mcelog_refer "$removes"; then
+	    echo "  Passed: MCE log is ok"
+	else
+	    echo "  Failed: MCE log is different from input"
+	fi
+    else
+	echo "  Failed: no MCE log result"
+    fi
+}
+
+soft_inject_get_klog()
+{
+    local klog=$RDIR/$this_case/klog
+    local orig_klog=$RDIR/$this_case/orig_klog
+
+    if [ -f $klog ]; then
+	cp $klog $orig_klog
+	filter_fake_panic $orig_klog $klog
+    fi
+}
+
+soft_inject_get_mcelog()
+{
+    case "$driver" in
+	simple*)
+	    get_mcelog_from_dev $mcelog_result
+	    ;;
+	kdump*)
+	    get_mcelog_from_klog $klog $mcelog_result
+	    ;;
+	*)
+	    echo '!!! Unsupported driver !!!'
+    esac
+}
+
+# verify return value
+soft_inject_verify_return_val()
+{
+    if [ -f $RDIR/$this_case/return ] && \
+	[ $(cat $RDIR/$this_case/return) -eq 0 ]; then
+	echo "  Passed: inject process continue"
+    else
+	echo "  Failed: inject process killed"
+    fi
+}
+
+soft_inject_verify_kill()
+{
+    if [ -f $RDIR/$this_case/return ] && \
+	[ $(cat $RDIR/$this_case/return) -eq 139 ]; then
+	echo "  Passed: inject process killed!"
+    else
+	echo "  Failed: Not killed"
+    fi
+}
+
+soft_inject_enumerate()
+{
+    local base=$(relative_path ${CDIR} ${SDIR})
+    [ -z "$base" ] && die "BUG!!! Please contact your software vendor!"
+    for c in $(cd $SDIR/data; ls *[^~]); do
+	echo $base/$c
+    done
+}
+
+soft_inject_trigger()
+{
+    mcelog &> /dev/null
+    case "$driver" in
+	kdump*)
+	    mce-inject --no-random $SDIR/data/$bcase
+	    ;;
+	*)
+	    mce-inject $SDIR/data/$bcase
+	    ;;
+    esac
+    ret=$?
+    echo $ret > $RDIR/$this_case/return
+    sleep 1
+}
+
+soft_inject_verify_panic()
+{
+    local mce_panic="$1"
+    verify_panic_via_klog $klog "$mce_panic"
+}
+
+soft_inject_verify_timeout()
+{
+    verify_timeout_via_klog $klog
+}
+
+soft_inject_verify_exp()
+{
+    verify_exp_via_klog $klog "$@"
+}
+
+soft_inject_main()
+{
+    op="$1"
+    shift
+
+    case "$op" in
+	enumerate)
+	    enumerate
+	    ;;
+	trigger)
+	    trigger "$@"
+	    ;;
+	get_result)
+	    get_result
+	    ;;
+	verify)
+	    verify
+	    ;;
+	*)
+	    die "Usage: $0 enumerate|trigger|get_result|verify"
+    esac
+    exit 0
+}
--- ltp-full-20090731.orig/testcases/mce-test/Makefile	1970-01-01 05:30:00.000000000 +0530
+++ ltp-full-20090731/testcases/mce-test/Makefile	2009-08-05 14:50:57.000000000 +0530
@@ -0,0 +1,30 @@
+
+all:
+	$(MAKE) -C tools
+	$(MAKE) -C tsrc
+
+clean:
+	$(MAKE) -C tools clean
+	$(MAKE) -C tsrc clean
+	$(MAKE) reset
+
+distclean:
+	$(MAKE) -C tools distclean
+	$(MAKE) -C tsrc distclean
+	$(MAKE) reset
+
+reset:
+	rm -rf work/*
+	rm -rf results/*
+
+test:
+	$(MAKE) reset
+	./drivers/simple/driver.sh simple.conf
+	./drivers/kdump/driver.sh kdump.conf
+
+test-simple:
+	$(MAKE) reset
+	./drivers/simple/driver.sh simple.conf
+
+
+
--- ltp-full-20090731.orig/testcases/mce-test/README	1970-01-01 05:30:00.000000000 +0530
+++ ltp-full-20090731/testcases/mce-test/README	2009-08-05 14:50:57.000000000 +0530
@@ -0,0 +1,87 @@
+MCE test suite
+---------------
+
+The MCE test suite is a collection of tools and test scripts for
+testing the Linux kernel MCE processing features. The goal is to cover
+most Linux kernel MCE processing code paths and features with
+automation tests.
+
+
+In the Package
+--------------
+
+Here is a short description of what is included in the package
+
+README
+	This document
+COPYING
+	GNU General Public License
+
+Makefile
+	Top level make file for MCE test suite
+
+drivers/*
+
+	Contains test drivers, which drive test procedure and do some
+	common works for test drivers. There is one directory for each
+	test driver, the user interface of a driver is the driver.sh
+	in corresponding directory, such as:
+	    drivers/kdump/driver.sh
+	is user interface of kdump test driver.
+
+cases/*
+	Contains all test cases, which may be organized in
+	sub-directories, the interface of a class of test cases is a
+	shell script under cases/, such as:
+	    cases/soft-inj/panic/cases.sh
+	is for test cases triggered by soft-inject and my cause system
+	panic during testing.
+
+config/*
+	Contains test configuration files, which specifies the
+	parameters for test driver, which test cases are used in test,
+	the parameters for test cases, etc.
+
+lib/*
+	Contains some shell scripts, in which some common shell
+	functions and variable definitions are defined to be used by
+	multiple test drivers or test cases.
+
+tools/*
+	Some tools used by MCE test suites.
+
+doc/*
+	Documentation for MCE test suites include howto and
+	descriptions of every test case.
+
+results/
+	When test is done, the test result will be placed in this
+	directory, test results for a specific test driver will be
+	placed in corresponding directory, such as test results of
+	kdump test driver will be placed in "results/kdump". General
+	test result is in results/$driver/result; additional results
+	of various cases may be in corresponding directory, for
+	example, files in
+	    results/kdump/soft-inj/panic/fatal/
+	is for additional result for test case soft-inj/panic/fatal.
+
+work/
+	During test, some temporary file will be put in work
+	directory, temporary files for a specific test driver will be
+	placed in corresponding directory, such as temporary files of
+	kdump test driver will be placed in "work/kdump". Test log is
+	in work/$driver/log.
+
+bin/
+	Some tools used by test drivers or test cases will be
+	installed into this directory.
+
+Futher Information
+------------------
+
+For futher information about MCE test suite, please refer to documents
+in doc sub-directory.
+
+README.kdump:		For testing via kdump. With kdump, a real panic
+			will triggered.
+design.txt:		Simple design document
--- ltp-full-20090731.orig/testcases/mce-test/tools/gcov_merge.py	1970-01-01 05:30:00.000000000 +0530
+++ ltp-full-20090731/testcases/mce-test/tools/gcov_merge.py	2009-08-05 14:50:57.000000000 +0530
@@ -0,0 +1,76 @@
+#!/usr/bin/env python
+#
+# Merge gcov graph from several test cases. This can be used to check
+# the coverage of several test cases.
+#
+# Copyright (C) 2008, Intel Corp.
+#   Author: Huang Ying <ying.huang@intel.com>
+#
+# This file is released under the GPLv2.
+
+import sys
+
+def die(str):
+    print str
+    sys.exit(-1)
+
+def die_on(cond, str):
+    if cond:
+        die(str)
+
+class GCovLine(object):
+    def __init__(self, l):
+        object.__init__(self)
+        self.parse(l)
+    def parse(self, l):
+        sep = l.find(':')
+        die_on(sep <= 0, 'input error format error')
+        remain = l[sep:]
+        scnt = l[:sep]
+        if scnt[-1] == '-':
+            count = -1
+        elif scnt[-1] == '#':
+            count = 0
+        else:
+            count = int(scnt)
+        self.sep = sep
+        self.count = count
+        self.remain = remain
+    def merge(self, gcl):
+        self.count = self.count + gcl.count
+    def write(self, of):
+        if self.count < 0:
+            of.write("%*s" % (self.sep, '-'))
+        elif self.count == 0:
+            of.write("%*s" % (self.sep, '#####'))
+        else:
+            of.write("%*d" % (self.sep, self.count))
+        of.write(self.remain)
+
+def parse(f):
+    return [GCovLine(l) for l in f]
+
+def merge(gcls1, gcls2):
+    for gcl1, gcl2 in zip(gcls1, gcls2):
+        gcl1.merge(gcl2)
+
+def gcov_merge(fns, of):
+    f = file(fns[0])
+    gcls_base = parse(f)
+
+    for fn in fns[1:]:
+        f = file(fn)
+        gcls = parse(f)
+        merge(gcls_base, gcls)
+
+    for gcl in gcls_base:
+        gcl.write(of)
+
+def usage():
+    print 'Usage: %s <gcov graph files>' % (sys.argv[0])
+
+if __name__ == '__main__':
+    if len(sys.argv) <= 1:
+        usage()
+        exit -1
+    gcov_merge(sys.argv[1:], sys.stdout)
--- ltp-full-20090731.orig/testcases/mce-test/tools/grep_result.sh	1970-01-01 05:30:00.000000000 +0530
+++ ltp-full-20090731/testcases/mce-test/tools/grep_result.sh	2009-08-05 14:50:57.000000000 +0530
@@ -0,0 +1,12 @@
+#!/bin/sh
+#
+# Filter out specified test case results from all results.
+#
+# Copyright (C) 2008, Intel Corp.
+#   Author: Huang Ying <ying.huang@intel.com>
+#
+# This file is released under the GPLv2.
+#
+
+tr '\n' '|' | sed -e '1,$s/||/\n/g' | grep "$@" | sed -e '/^$/d' | \
+    sed -e '1,$s/^|\?\([^|].*[^|]\)|\?$/\1/' | sed -e '1,$i\ ' | tr '|' '\n'
--- ltp-full-20090731.orig/testcases/mce-test/tools/Makefile	1970-01-01 05:30:00.000000000 +0530
+++ ltp-full-20090731/testcases/mce-test/tools/Makefile	2009-08-05 14:50:57.000000000 +0530
@@ -0,0 +1,12 @@
+
+all:
+	$(MAKE) -C readcore
+	cp readcore/readcore ../bin
+
+clean:
+	$(MAKE) -C readcore clean
+	rm -f ../bin/readcore
+
+distclean:
+	$(MAKE) -C readcore distclean
+	rm -f ../bin/readcore
--- ltp-full-20090731.orig/testcases/mce-test/tools/mce_shell.sh	1970-01-01 05:30:00.000000000 +0530
+++ ltp-full-20090731/testcases/mce-test/tools/mce_shell.sh	2009-08-05 14:50:57.000000000 +0530
@@ -0,0 +1,50 @@
+#!/bin/bash
+#
+# Simulate the environment of mce-test driver or test case shell
+# script, used for debugging. You can invoking mce-test library
+# functions directly in shell created.
+#
+# Copyright (C) 2009, Intel Corp.
+#   Author: Huang Ying <ying.huang@intel.com>
+#
+# This file is released under the GPLv2.
+#
+
+sd=$(dirname "$0")
+export ROOT=`(cd $sd/..; pwd)`
+
+if [ $# -eq 1 ]; then
+    export driver=$1
+else
+    export driver=simple
+fi
+
+tmpfile=$(mktemp)
+
+trap "rm $tmpfile" EXIT
+
+cat <<"EOF" > $tmpfile
+if [ -f /etc/bash.bashrc ]; then
+    source /etc/bash.bashrc
+fi
+
+if [ -f $HOME/.bashrc ]; then
+    source $HOME/.bashrc
+fi
+
+. $ROOT/lib/functions.sh
+setup_path
+. $ROOT/lib/dirs.sh
+. $ROOT/lib/mce.sh
+. $ROOT/lib/soft-inject.sh
+
+export PS1="MDE $driver: "
+
+echo "-----------------------------------------------------"
+echo "| MCE-test shell, You can use mce internal function |"
+echo "-----------------------------------------------------"
+EOF
+
+export PS1="MCE $driver: "
+/bin/bash --rcfile $tmpfile
+rm $tmpfile
--- ltp-full-20090731.orig/testcases/mce-test/tools/readcore/.depend	1970-01-01 05:30:00.000000000 +0530
+++ ltp-full-20090731/testcases/mce-test/tools/readcore/.depend	2009-08-05 14:50:57.000000000 +0530
@@ -0,0 +1,3 @@
+readcore.o: readcore.c mem_image.h util.h
+mem_image.o: mem_image.c mem_image.h util.h
+util.o: util.c util.h
--- ltp-full-20090731.orig/testcases/mce-test/tools/readcore/Makefile	1970-01-01 05:30:00.000000000 +0530
+++ ltp-full-20090731/testcases/mce-test/tools/readcore/Makefile	2009-08-05 14:50:57.000000000 +0530
@@ -0,0 +1,28 @@
+EXEC_NAME = readcore
+OBJS = readcore.o mem_image.o util.o
+SRC = readcore.c mem_image.c util.c
+
+CC = gcc
+CFLAGS = -Wall -O2
+LDFLAGS =
+LIBS =
+
+$(EXEC_NAME) : $(OBJS)
+	$(CC) -o $@ $(LDFLAGS) $^ $(LIBS)
+
+clean :
+	rm -rf $(EXEC_NAME) $(OBJS)
+
+distclean: clean
+	rm -f ${DISTCLEAN} *~
+	rm -f .depend
+
+depend: .depend
+
+.depend: ${SRC}
+	${CC} -MM -DDEPS_RUN -I. ${SRC} ${GENSRC} > .depend.X && \
+		mv .depend.X .depend
+
+Makefile: .depend
+
+include .depend
--- ltp-full-20090731.orig/testcases/mce-test/tools/readcore/mem_image.c	1970-01-01 05:30:00.000000000 +0530
+++ ltp-full-20090731/testcases/mce-test/tools/readcore/mem_image.c	2009-08-05 14:50:57.000000000 +0530
@@ -0,0 +1,232 @@
+/*
+ * vmcore memory image accessing functions
+ *
+ * Copyright (C) NEC Corporation., 2006, 2007
+ *
+ * Copyright (C) Intel Corp., 2008
+ *     Author: Huang Ying <ying.huang@intel.com>
+ *
+ * Revised from vmcore accessing function from makedumpfile.
+ *                                            - Huang Ying 2008/08/28
+ *
+ * This program is free software; you can redistribute it and/or modify
+ * it under the terms of the GNU General Public License as published by
+ * the Free Software Foundation; either version 2 of the License, or
+ * (at your option) any later version.
+ */
+
+#include <stdio.h>
+#include <stdlib.h>
+#include <unistd.h>
+#include <fcntl.h>
+#include <elf.h>
+
+#include "mem_image.h"
+#include "util.h"
+
+struct pt_load {
+	loff_t			offset;
+	unsigned long long	pstart;
+	unsigned long long	pend;
+	unsigned long long	vstart;
+	unsigned long long	vend;
+};
+
+struct mem_image
+{
+	struct pt_load *ptloads;
+	int nptload;
+	int elf_fd;
+};
+
+static void get_elf64_phdr(int fd, int num, Elf64_Phdr *phdr)
+{
+	off_t off, offret;
+	int ret;
+
+	off = sizeof(Elf64_Ehdr) + sizeof(Elf64_Phdr) * num;
+	offret = lseek(fd, off, SEEK_SET);
+	ERROR_EXIT_ON(offret == (off_t)-1, "Fail to seek");
+	ret = read(fd, phdr, sizeof(Elf64_Phdr));
+	ERROR_EXIT_ON(ret != sizeof(Elf64_Phdr), "Cannot read Elf64_Phdr");
+}
+
+static void get_elf32_phdr(int fd, int num, Elf32_Phdr *phdr)
+{
+	off_t off, offret;
+	int ret;
+
+	off = sizeof(Elf32_Ehdr) + sizeof(Elf32_Phdr) * num;
+	offret = lseek(fd, off, SEEK_SET);
+	ERROR_EXIT_ON(offret == (off_t)-1, "Fail to seek");
+	ret = read(fd, phdr, sizeof(Elf32_Phdr));
+	ERROR_EXIT_ON(ret != sizeof(Elf32_Phdr), "Cannot read Elf32_Phdr");
+}
+
+struct mem_image *mi_open(const char *image_file_name)
+{
+	struct mem_image *mi;
+	struct pt_load *ptload;
+	int i, ret;
+	Elf64_Ehdr ehdr64;
+	Elf64_Phdr load64;
+	Elf32_Ehdr ehdr32;
+	Elf32_Phdr load32;
+	off_t offret;
+	const off_t failed = (off_t)-1;
+
+	mi = calloc(1, sizeof(struct mem_image));
+	ERROR_EXIT_ON(!mi, "Cannot allocate mem_image");
+
+	mi->elf_fd = open(image_file_name, O_RDWR);
+	ERROR_EXIT_ON(mi->elf_fd == -1, "Cannot open image file: %s",
+		      image_file_name);
+
+	ret = read(mi->elf_fd, &ehdr64, sizeof(Elf64_Ehdr));
+	ERROR_EXIT_ON(ret!= sizeof(Elf64_Ehdr), "Can't read");
+
+	offret = lseek(mi->elf_fd, 0, SEEK_SET);
+	ERROR_EXIT_ON(offret == failed, "Fail to seek");
+	ret = read(mi->elf_fd, &ehdr32, sizeof(Elf32_Ehdr));
+	ERROR_EXIT_ON(ret!= sizeof(Elf32_Ehdr), "Can't read");
+
+	mi->nptload = 0;
+	if ((ehdr64.e_ident[EI_CLASS] == ELFCLASS64)
+	    && (ehdr32.e_ident[EI_CLASS] != ELFCLASS32)) {
+		for (i = 0; i < ehdr64.e_phnum; i++) {
+			get_elf64_phdr(mi->elf_fd, i, &load64);
+			if (load64.p_type == PT_LOAD)
+				mi->nptload++;
+		}
+
+		mi->ptloads = calloc(mi->nptload, sizeof(struct pt_load));
+		ERROR_EXIT_ON(!mi->ptloads, "Cannot allocate for mem_image");
+
+		ptload = mi->ptloads;
+		for (i = 0; i < ehdr64.e_phnum; i++) {
+			get_elf64_phdr(mi->elf_fd, i, &load64);
+			if (load64.p_type == PT_LOAD) {
+				ptload->pstart = load64.p_paddr;
+				ptload->pend = load64.p_paddr+load64.p_filesz;
+				ptload->vstart = load64.p_vaddr;
+				ptload->vend = load64.p_vaddr+load64.p_filesz;
+				ptload->offset = load64.p_offset;
+				ptload++;
+			}
+		}
+	} else if ((ehdr64.e_ident[EI_CLASS] != ELFCLASS64)
+	    && (ehdr32.e_ident[EI_CLASS] == ELFCLASS32)) {
+		for (i = 0; i < ehdr32.e_phnum; i++) {
+			get_elf32_phdr(mi->elf_fd, i, &load32);
+			if (load32.p_type == PT_LOAD)
+				mi->nptload++;
+		}
+
+		mi->ptloads = calloc(mi->nptload, sizeof(struct pt_load));
+		ERROR_EXIT_ON(!mi->ptloads, "Cannot allocate for mem_image");
+
+		ptload = mi->ptloads;
+		for (i = 0; i < ehdr32.e_phnum; i++) {
+			get_elf32_phdr(mi->elf_fd, i, &load32);
+			if (load32.p_type == PT_LOAD) {
+				ptload->pstart = load32.p_paddr;
+				ptload->pend = load32.p_paddr+load32.p_filesz;
+				ptload->vstart = load32.p_vaddr;
+				ptload->vend = load32.p_vaddr+load32.p_filesz;
+				ptload->offset = load32.p_offset;
+				ptload++;
+			}
+		}
+	} else
+		ERROR_EXIT("Can't get valid ehdr.\n");
+
+	return mi;
+}
+
+off_t mi_paddr_to_offset(struct mem_image *mi, unsigned long paddr,
+				unsigned long size)
+{
+	int i;
+	struct pt_load *p;
+
+	for (i = 0; i < mi->nptload; i++) {
+		p = mi->ptloads + i;
+		if (p->pstart <= paddr &&
+		    p->pend >= paddr + size)
+			return p->offset + (paddr - p->pstart);
+	}
+	error_exit("Can not find paddr 0x%lx.\n", paddr);
+	return 0;
+}
+
+off_t mi_vaddr_to_offset(struct mem_image *mi, unsigned long vaddr,
+				unsigned long size)
+{
+	int i;
+	struct pt_load *p;
+
+	for (i = 0; i < mi->nptload; i++) {
+		p = mi->ptloads + i;
+		if (vaddr >= p->vstart &&
+		    vaddr + size <= p->vend)
+			return p->offset + (vaddr - p->vstart);
+	}
+	error_exit("Can not find vaddr 0x%lx.\n", vaddr);
+	return 0;
+}
+
+void __mi_vread_mem(struct mem_image *mi, unsigned long vaddr,
+		    void *buf, unsigned long size)
+{
+	off_t off, offret;
+	int ret;
+
+	off = mi_vaddr_to_offset(mi, vaddr, size);
+	offret = lseek(mi->elf_fd, off, SEEK_SET);
+	ERROR_EXIT_ON(offret == (off_t)-1, "Fail to seek");
+	ret = read(mi->elf_fd, buf, size);
+	ERROR_EXIT_ON(ret != size, "Cannot read mem");
+}
+
+void mi_close(struct mem_image *mi)
+{
+	close(mi->elf_fd);
+	free(mi->ptloads);
+	free(mi);
+}
+
+void *mi_vread_mem(struct mem_image *mi, const void *vaddr, size_t len)
+{
+	void *buf = malloc(len);
+
+	ERROR_EXIT_ON(!buf, "Can not allocate memory in vread_mem");
+	__mi_vread_mem(mi, (unsigned long)vaddr, buf, len);
+	return buf;
+}
+
+uint32_t mi_vread_u32(struct mem_image *mi, const void *vaddr)
+{
+	uint32_t u32;
+	__mi_vread_mem(mi, (unsigned long)vaddr, &u32, sizeof(u32));
+	return u32;
+}
+
+uint64_t mi_vread_u64(struct mem_image *mi, const void *vaddr)
+{
+	uint64_t u64;
+	__mi_vread_mem(mi, (unsigned long)vaddr, &u64, sizeof(u64));
+	return u64;
+}
+
+char *mi_vread_string(struct mem_image *mi, const void *vaddr)
+{
+	char ch;
+	size_t len = 0;
+
+	do {
+		__mi_vread_mem(mi, (unsigned long)vaddr + len, &ch, 1);
+		len++;
+	} while (ch);
+
+	return mi_vread_mem(mi, vaddr, len);
+}
--- ltp-full-20090731.orig/testcases/mce-test/tools/readcore/mem_image.h	1970-01-01 05:30:00.000000000 +0530
+++ ltp-full-20090731/testcases/mce-test/tools/readcore/mem_image.h	2009-08-05 14:50:57.000000000 +0530
@@ -0,0 +1,15 @@
+#ifndef MEM_IMAGE_H
+#define MEM_IMAGE_H
+
+#include <stdint.h>
+
+struct mem_image;
+
+struct mem_image *mi_open(const char *image_file_name);
+void mi_close(struct mem_image *mi);
+void *mi_vread_mem(struct mem_image *mi, const void *vaddr, size_t len);
+uint32_t mi_vread_u32(struct mem_image *mi, const void *vaddr);
+uint64_t mi_vread_u64(struct mem_image *mi, const void *vaddr);
+char *mi_vread_string(struct mem_image *mi, const void *vaddr);
+
+#endif
--- ltp-full-20090731.orig/testcases/mce-test/tools/readcore/readcore.c	1970-01-01 05:30:00.000000000 +0530
+++ ltp-full-20090731/testcases/mce-test/tools/readcore/readcore.c	2009-08-05 14:50:57.000000000 +0530
@@ -0,0 +1,80 @@
+/*
+ * Copyright (C) Intel Corp., 2008
+ *     Author: Huang Ying <ying.huang@intel.com>
+ *
+ * This program is free software; you can redistribute it and/or modify
+ * it under the terms of the GNU General Public License as published by
+ * the Free Software Foundation; either version 2 of the License, or
+ * (at your option) any later version.
+ */
+
+#include <stdio.h>
+#include <stdlib.h>
+#include <getopt.h>
+
+#include "mem_image.h"
+#include "util.h"
+
+struct mem_image *mimg;
+
+void usage(void)
+{
+	printf("Usage: readcore -a <addr> -l <len> <crash core>\n"
+	       "       readcore -a <addr> -s <crash core>\n"
+	       "       readcore -h\n"
+	       "read some data from crash core.\n"
+	       "\n"
+	       "-a		virtual address to read\n"
+	       "-l		length to read\n"
+	       "-s		read a string\n"
+	       "-h		Print this help.\n"
+	       "<crash core>	Crash core.\n");
+	printf("\n");
+}
+
+int main(int argc, char *argv[])
+{
+	int opt, fileind, str = 0;
+	unsigned long vaddr = 0, len = 0;
+	char *endptr, *data;
+
+	while ((opt = getopt(argc, argv, "a:hl:s")) != -1) {
+		switch (opt) {
+		case 'a':
+			vaddr = strtoul(optarg, &endptr, 0);
+			ERROR_EXIT_ON(*endptr, "Invalid address");
+			break;
+		case 'l':
+			len = strtoul(optarg, &endptr, 0);
+			ERROR_EXIT_ON(*endptr, "Invalid length");
+			break;
+		case 's':
+			str = 1;
+			break;
+		case 'h':
+			usage();
+			return 0;
+		default:
+			ERROR_EXIT("Unknown option %c", opt);
+			break;
+		}
+	}
+	fileind = optind;
+
+	ERROR_EXIT_ON(fileind >= argc, "No crash core file specified!");
+	ERROR_EXIT_ON(!vaddr, "No virtual address specified!");
+	ERROR_EXIT_ON(!len && !str, "Please specify data length or string!");
+
+	mimg = mi_open(argv[fileind]);
+	if (len) {
+		data = mi_vread_mem(mimg, (void *)vaddr, len);
+		fwrite(data, len, 1, stdout);
+	} else {
+		data = mi_vread_string(mimg, (void *)vaddr);
+		puts(data);
+	}
+	free(data);
+	mi_close(mimg);
+
+	return 0;
+}
--- ltp-full-20090731.orig/testcases/mce-test/tools/readcore/util.c	1970-01-01 05:30:00.000000000 +0530
+++ ltp-full-20090731/testcases/mce-test/tools/readcore/util.c	2009-08-05 14:50:57.000000000 +0530
@@ -0,0 +1,34 @@
+/*
+ * Some utility functions
+ *
+ * Copyright (C) Intel Corp., 2008
+ *     Author: Huang Ying <ying.huang@intel.com>
+ *
+ * This program is free software; you can redistribute it and/or modify
+ * it under the terms of the GNU General Public License as published by
+ * the Free Software Foundation; either version 2 of the License, or
+ * (at your option) any later version.
+ */
+
+#include <stdarg.h>
+#include <errno.h>
+#include <string.h>
+#include <stdio.h>
+#include <stdlib.h>
+
+#include "util.h"
+
+void error_exit(char *fmt, ...)
+{
+	va_list ap;
+
+	fprintf(stderr, "Error: ");
+	va_start(ap, fmt);
+	vfprintf(stderr, fmt, ap);
+	if (errno)
+		fprintf(stderr, ", %s\n", strerror(errno));
+	else
+		fprintf(stderr, "\n");
+	exit(-1);
+}
+
--- ltp-full-20090731.orig/testcases/mce-test/tools/readcore/util.h	1970-01-01 05:30:00.000000000 +0530
+++ ltp-full-20090731/testcases/mce-test/tools/readcore/util.h	2009-08-05 14:50:57.000000000 +0530
@@ -0,0 +1,17 @@
+#ifndef UTIL_H
+#define UTIL_H
+
+void error_exit(char *fmt, ...);
+
+#define ERROR_EXIT(fmt, ...)					\
+	do {							\
+		error_exit(fmt, ## __VA_ARGS__);		\
+	} while (0)
+
+#define ERROR_EXIT_ON(check, fmt, ...)				\
+	do {							\
+		if (check)					\
+			error_exit(fmt, ## __VA_ARGS__);	\
+	} while (0)
+
+#endif
--- ltp-full-20090731.orig/testcases/mce-test/tools/scov_merge.py	1970-01-01 05:30:00.000000000 +0530
+++ ltp-full-20090731/testcases/mce-test/tools/scov_merge.py	2009-08-05 14:50:57.000000000 +0530
@@ -0,0 +1,68 @@
+#!/usr/bin/env python
+#
+# Merge mce serverity coverage file from several test cases. This can
+# be used to check the coverage of several test cases.
+#
+# Copyright (C) 2009, Intel Corp.
+#   Author: Huang Ying <ying.huang@intel.com>
+#
+# This file is released under the GPLv2.
+
+import sys
+
+def die(str):
+    print str
+    sys.exit(-1)
+
+def die_on(cond, str):
+    if cond:
+        die(str)
+
+class SCovLine(object):
+    def __init__(self, l):
+        object.__init__(self)
+        self.parse(l)
+    def parse(self, l):
+        sep = l.find('\t')
+        die_on(sep <= 0, 'input error format error')
+        remain = l[sep:]
+        scnt = l[:sep]
+        count = int(scnt)
+        self.count = count
+        self.remain = remain
+    def merge(self, gcl):
+        self.count = self.count + gcl.count
+    def write(self, of):
+        if self.count == 0:
+            of.write("0")
+        else:
+            of.write("1")
+        of.write(self.remain)
+
+def parse(f):
+    return [SCovLine(l) for l in f]
+
+def merge(gcls1, gcls2):
+    for gcl1, gcl2 in zip(gcls1, gcls2):
+        gcl1.merge(gcl2)
+
+def scov_merge(fns, of):
+    f = file(fns[0])
+    gcls_base = parse(f)
+
+    for fn in fns[1:]:
+        f = file(fn)
+        gcls = parse(f)
+        merge(gcls_base, gcls)
+
+    for gcl in gcls_base:
+        gcl.write(of)
+
+def usage():
+    print 'Usage: %s <severities coverage files>' % (sys.argv[0])
+
+if __name__ == '__main__':
+    if len(sys.argv) <= 1:
+        usage()
+        exit -1
+    scov_merge(sys.argv[1:], sys.stdout)
--- ltp-full-20090731.orig/testcases/mce-test/tsrc/kinclude/linux/debugfs.h	1970-01-01 05:30:00.000000000 +0530
+++ ltp-full-20090731/testcases/mce-test/tsrc/kinclude/linux/debugfs.h	2009-08-05 14:50:57.000000000 +0530
@@ -0,0 +1,15 @@
+
+static inline struct dentry *debugfs_create_file(const char *name, mode_t mode,
+				   struct dentry *parent, void *data,
+				   const struct file_operations *fops)
+{
+	return NULL;
+}
+
+static inline struct dentry *debugfs_create_dir(const char *name, struct dentry *parent)
+{
+	return NULL;
+}
+
+
+static inline void debugfs_remove(struct dentry *dentry) { } 
--- ltp-full-20090731.orig/testcases/mce-test/tsrc/kinclude/linux/fs.h	1970-01-01 05:30:00.000000000 +0530
+++ ltp-full-20090731/testcases/mce-test/tsrc/kinclude/linux/fs.h	2009-08-05 14:50:57.000000000 +0530
@@ -0,0 +1,10 @@
+struct inode;
+struct file;
+struct dentry;
+
+struct file_operations {
+	ssize_t (*read) (struct file *, char  *, size_t, loff_t *);
+	int (*open) (struct inode *, struct file *);
+	int (*release) (struct inode *, struct file *);
+	ssize_t (*write) (struct file *, const char *, size_t, loff_t *);
+};
--- ltp-full-20090731.orig/testcases/mce-test/tsrc/kinclude/linux/init.h	1970-01-01 05:30:00.000000000 +0530
+++ ltp-full-20090731/testcases/mce-test/tsrc/kinclude/linux/init.h	2009-08-05 14:50:57.000000000 +0530
@@ -0,0 +1,5 @@
+
+#define __init
+#define __user
+
+#define late_initcall(x) typeof(x) x __attribute__((used))
--- ltp-full-20090731.orig/testcases/mce-test/tsrc/kinclude/linux/percpu.h	1970-01-01 05:30:00.000000000 +0530
+++ ltp-full-20090731/testcases/mce-test/tsrc/kinclude/linux/percpu.h	2009-08-05 14:50:57.000000000 +0530
@@ -0,0 +1,9 @@
+
+#define DECLARE_PER_CPU(x,y)
+#define BITS_PER_LONG (sizeof(long)*8)
+#define DECLARE_BITMAP(x,y) unsigned long x[((y) + BITS_PER_LONG - 1) / BITS_PER_LONG];
+#define MAX_NR_BANKS 32
+#define ARRAY_SIZE(x) (sizeof(x) / sizeof(*(x)))
+
+struct cpuinfo_x86;
+
--- ltp-full-20090731.orig/testcases/mce-test/tsrc/kinclude/linux/seq_file.h	1970-01-01 05:30:00.000000000 +0530
+++ ltp-full-20090731/testcases/mce-test/tsrc/kinclude/linux/seq_file.h	2009-08-05 14:50:57.000000000 +0530
@@ -0,0 +1,22 @@
+
+#include <linux/fs.h>
+
+struct file;
+
+struct seq_file {
+};
+
+struct seq_operations {
+	void * (*start) (struct seq_file *m, loff_t *pos);
+	void (*stop) (struct seq_file *m, void *v);
+	void * (*next) (struct seq_file *m, void *v, loff_t *pos);
+	int (*show) (struct seq_file *m, void *v);
+};
+
+#define seq_printf(a, b, c...) printf(b , ## c)
+static inline int seq_open(struct file *f, const struct seq_operations *o) { return -1; }
+
+static inline ssize_t seq_read(struct file *a, char  *b, size_t c, loff_t *d) { return 0; }
+static inline ssize_t seq_write(struct file *a, const char  *b, size_t c, loff_t *d) { return 0; }
+static inline int seq_release(struct inode *a, struct file *b) { return 0; }
+
--- ltp-full-20090731.orig/testcases/mce-test/tsrc/kinclude/linux/sysdev.h	1970-01-01 05:30:00.000000000 +0530
+++ ltp-full-20090731/testcases/mce-test/tsrc/kinclude/linux/sysdev.h	2009-08-05 14:50:57.000000000 +0530
@@ -0,0 +1,2 @@
+
+struct sysdev_attribute {};
--- ltp-full-20090731.orig/testcases/mce-test/tsrc/kinclude/README	1970-01-01 05:30:00.000000000 +0530
+++ ltp-full-20090731/testcases/mce-test/tsrc/kinclude/README	2009-08-05 14:50:57.000000000 +0530
@@ -0,0 +1,3 @@
+
+Fake kernel includes to build some kernel code in user context.
+
--- ltp-full-20090731.orig/testcases/mce-test/tsrc/Makefile	1970-01-01 05:30:00.000000000 +0530
+++ ltp-full-20090731/testcases/mce-test/tsrc/Makefile	2009-08-05 14:50:57.000000000 +0530
@@ -0,0 +1,42 @@
+LSRC := ../linux
+BROWSER := firefox
+
+CFLAGS += -I ${LSRC}/arch/x86/kernel/cpu/mcheck/ -g -Wall
+
+KFLAGS := -I ./kinclude
+
+all: standalone
+
+standalone: tinjpage tinjpage-working tkillpoison
+
+requireskernel: tcases ttable
+
+tcases: tcases.c ${LSRC}/arch/x86/kernel/cpu/mcheck/mce-severity.c ${LSRC}/arch/x86/kernel/cpu/mcheck/mce-internal.h
+	${CC} ${CFLAGS} ${KFLAGS} -o tcases tcases.c
+
+ttable: ttable.c ${LSRC}/arch/x86/kernel/cpu/mcheck/mce-severity.c ${LSRC}/arch/x86/kernel/cpu/mcheck/mce-internal.h
+	${CC} ${CFLAGS} ${KFLAGS} -o ttable ttable.c
+
+tring: tring.o 
+
+tring : LDFLAGS += -lpthread
+
+x.html: ttable
+	./ttable ${TFLAGS} > x.html
+
+.PHONY: see
+
+see: x.html
+	${BROWSER} x.html
+
+tinjpage: LDFLAGS += -lpthread
+
+.PHONY: clean distclean
+
+clean:
+	rm -f tcases ttable x.html tinjpage	
+	rm -f tkillpoison tring
+
+distclean: clean
+
+
--- ltp-full-20090731.orig/testcases/mce-test/tsrc/README	1970-01-01 05:30:00.000000000 +0530
+++ ltp-full-20090731/testcases/mce-test/tsrc/README	2009-08-05 14:50:57.000000000 +0530
@@ -0,0 +1,55 @@
+These are some standalone test programs for various parts of the
+machine check code:
+
+To use ttable and tcases you need to specify a linux source tree
+with the mce improvements patchkit added with make LSRC=/path/to/linux
+or symlink the linux tree to ../linux
+
+The programs requiring kernel sources are not in the all make target.
+If you want to build them use make requireskernel after you
+set up the kernel sources or specified LSRC.
+
+tcases
+
+Simple tester of a few test cases by running the machine check grader code
+in user space. This is an alternative to the more complete coverage
+in the main mce-test test cases.
+
+Doesn't aim to be complete, but more a quick sanity check, that 
+can be done without booting a kernel.
+
+ttable
+
+Generate a table of the output of the machine check grader. This gives
+an overview how all the status bits in the machine check architecture 
+are processed. Note that a few bits are tested outside the grader
+and this doesn't apply to corrected machine check interrupts.
+
+Use make see to render the output  using links -g (note this doesn't work
+with elinks as it is used on many distributions, in this case specify
+a different browser with make BROWSER=browserbinary see)
+
+tinjpage
+
+tinjpage is a coverage test for the hwpoison page recovery code
+in the kernel. It tests different cases by putting pages
+into different stages, triggering poison injection on them 
+and verifies the results.
+
+tinjpage requires a kernel with MADV_POISON injection support and the
+hwpoison testkit, but doesn't require a kernel tree and can be built directly with
+make tinjpage
+
+A few of the test cases are timing dependent and might require adjustment
+to run successfully.
+
+tinjpage-working
+
+Old version of tinjpage that tests much less cases, but might be more reliable.
+
+tring
+
+Old unit test program for the ring buffer used in mca recovery.
+Not in default Makefile target.
+
+-Andi Kleen
--- ltp-full-20090731.orig/testcases/mce-test/tsrc/tcases.c	1970-01-01 05:30:00.000000000 +0530
+++ ltp-full-20090731/testcases/mce-test/tsrc/tcases.c	2009-08-05 14:50:57.000000000 +0530
@@ -0,0 +1,99 @@
+/* 
+ * Verify MCA grading engine against some examples.
+ */
+#include <sys/types.h>
+#include <stdio.h>
+#define __KERNEL__ 1
+#include <asm/types.h>
+#include <asm/mce.h>
+#include <errno.h>
+
+typedef unsigned long long u64;
+
+#define MCI_STATUS_S	 (1ULL<<56)  /* Signaled machine check */
+#define MCI_STATUS_AR	 (1ULL<<55)  /* Action required */
+
+int mce_ser = 1;
+int tolerant = 1;
+int panic_on_oops = 0;
+
+#include "mce-severity.c"
+
+char *resname[] = {
+#define R(x) [MCE_ ## x ## _SEVERITY] = #x
+	R(NO),
+	R(KEEP),
+	R(SOME),
+	R(AO),
+	R(AR),
+	R(PANIC),
+};
+#define VAL MCI_STATUS_VAL
+#define EN MCI_STATUS_EN
+#define PCC MCI_STATUS_PCC
+#define S MCI_STATUS_S
+#define AR MCI_STATUS_AR
+#define UC MCI_STATUS_UC
+
+int ring = 3;
+int fail;
+
+void test2(u64 flag, char *flagname, u64 mcg, char *mcgname, int result)
+{
+	struct mce m = {
+		.ip = 1,
+		.cs = ring,
+		.status = flag,
+		.mcgstatus = mcg,
+	};
+	int r;
+	char *msg;
+
+	if ((r = mce_severity(&m, tolerant, &msg)) != result) { 
+		printf("%s %s expected %s got %s msg %s\n",
+		       flagname, mcgname, resname[result], resname[r], msg);	
+		fail++;
+	}
+}
+
+
+#define TEST(flag, result) \
+	test2(flag, #flag, MCG_STATUS_MCIP|MCG_STATUS_RIPV, "mcip,ripv", \
+		MCE_ ## result ## _SEVERITY)
+
+void test(void)
+{
+	// corrected
+	TEST(VAL|EN, KEEP);
+
+	// uncorrected fatal
+	TEST(VAL|UC|PCC|EN|S|AR, PANIC);
+	TEST(VAL|UC|PCC|EN|S, PANIC);
+	TEST(VAL|UC|PCC|EN, PANIC);
+
+	// SW recoverable action required
+	// unknown mcacod -> panic
+	TEST(VAL|UC|EN|S|AR, PANIC);
+
+	// SW recoverable action optional
+	TEST(VAL|UC|EN|S|0xc0, AO);
+	// unknown mcacod
+	TEST(VAL|UC|EN|S|1, SOME);
+
+	// UCNA
+	TEST(VAL|UC|EN, KEEP);
+	TEST(VAL|UC, NO);	// linux clears. correct?	
+}
+
+int main(void)
+{
+	ring = 3;
+	test();
+	ring = 0;
+	test();
+	if (fail == 0)
+		printf("SUCCESS\n");
+	else
+		printf("%d FAILURES\n", fail);
+	return fail;
+}
--- ltp-full-20090731.orig/testcases/mce-test/tsrc/tinjpage.c	1970-01-01 05:30:00.000000000 +0530
+++ ltp-full-20090731/testcases/mce-test/tsrc/tinjpage.c	2009-08-05 14:50:57.000000000 +0530
@@ -0,0 +1,527 @@
+/*
+ * Test program for Linux poison memory error recovery.
+ * This injects poison into various mapping cases and triggers the poison
+ * handling.  Requires special injection support in the kernel.
+ * Author: Andi Kleen
+ */
+#define _GNU_SOURCE 1
+#include <stdio.h>
+#include <signal.h>
+#include <unistd.h>
+#include <sys/fcntl.h>
+#include <sys/wait.h>
+#include <sys/mman.h>
+#include <stdlib.h>
+#include <setjmp.h>
+#include <errno.h>
+#include <string.h>
+#include <time.h>
+#include <pthread.h>
+
+#ifndef MADV_POISON
+#define MADV_POISON 12
+#endif
+
+#define TMPDIR "./"
+#define PATHBUFLEN 100
+
+#define err(x) perror(x),exit(1)
+#define Perror(x) failure++, perror(x)
+#define PAIR(x) x, sizeof(x)-1
+#define mb() asm volatile("" ::: "memory")
+#if defined(__i386__) || defined(__x86_64__)
+#define cpu_relax() asm volatile("rep ; nop" ::: "memory")
+#else
+#define cpu_relax() mb()
+#endif
+
+int PS;
+int failure;
+int unexpected;
+int early_kill;
+
+void *checked_mmap(void *start, size_t length, int prot, int flags,
+                   int fd, off_t offset)
+{
+	void *map = mmap(start, length, prot, flags, fd, offset);
+	if (map == (void*)-1L)
+		err("mmap");
+	return map;
+}
+
+void munmap_reserve(void *page, int size)
+{
+	munmap(page, size);
+	mmap(page, size, PROT_NONE, MAP_PRIVATE|MAP_FIXED, 0, 0);
+}
+
+void *xmalloc(size_t s)
+{
+	void *p = malloc(s);
+	if (!p)
+		exit(ENOMEM);
+	return p;
+}
+
+int recovercount;
+sigjmp_buf recover_ctx;
+sigjmp_buf early_recover_ctx;
+void *expected_addr;
+
+void sighandler(int sig, siginfo_t *si, void *arg)
+{
+	if (si->si_addr != expected_addr) {
+		printf("XXX: Unexpected address in signal %p (expected %p)\n", si->si_addr,
+			expected_addr);
+		failure++;
+	}
+
+	printf("signal %d code %d addr %p\n", sig, si->si_code, si->si_addr);
+
+	if (--recovercount == 0) {
+		write(1, PAIR("I seem to be in a signal loop. bailing out.\n"));
+		exit(1);
+	}
+
+	if (si->si_code == 4)
+		siglongjmp(recover_ctx, 1);
+	else
+		siglongjmp(early_recover_ctx, 1);
+}
+
+enum rmode {
+	MREAD = 0,
+	MWRITE = 1,
+	MREAD_OK = 2,
+	MWRITE_OK = 3,
+	MNOTHING = -1,
+};
+
+void poison(char *msg, char *page, enum rmode mode)
+{
+	expected_addr = page;
+	recovercount = 5;
+
+	if (sigsetjmp(early_recover_ctx, 1) == 0) {
+
+		if (madvise(page, PS, MADV_POISON) != 0) {
+			if (errno == EINVAL) {
+				printf("Kernel doesn't support poison injection\n");
+				exit(0);
+			}
+			Perror("madvise");
+			return;
+		}
+
+		if (early_kill && (mode == MWRITE || mode == MREAD)) {
+			printf("XXX: %s: process is not early killed\n", msg);
+			failure++;
+		}
+
+		return;
+	}
+
+	if (early_kill) {
+		if (mode == MREAD_OK || mode == MWRITE_OK) {
+			printf("XXX: %s: killed\n", msg);
+			failure++;
+		} else
+			printf("recovered\n");
+	}
+}
+
+void recover(char *msg, char *page, enum rmode mode)
+{
+	expected_addr = page;
+	recovercount = 5;
+
+	if (sigsetjmp(recover_ctx, 1) == 0) {
+		switch (mode) {
+		case MWRITE:
+			printf("writing 2\n");
+			*page = 2;
+			break;
+		case MWRITE_OK:
+			printf("writing 4\n");
+			*page = 4;
+			return;
+		case MREAD:
+			printf("%x\n", *(unsigned char *)page);
+			break;
+		case MREAD_OK:
+			printf("%x\n", *(unsigned char *)page);
+			return;
+		case MNOTHING:
+			return;
+		}
+		/* signal or kill should have happened */
+		printf("XXX: %s: page not poisoned after injection\n", msg);
+		failure++;
+		return;
+	}
+	if (mode == MREAD_OK || mode == MWRITE_OK) {
+		printf("XXX: %s: killed\n", msg);
+		failure++;
+	} else
+		printf("recovered\n");
+}
+
+void testmem(char *msg, char *page, enum rmode mode)
+{
+	printf("%s page %p\n", msg, page);
+	poison(msg, page, mode);
+	recover(msg, page, mode);
+}
+
+void expecterr(char *msg, int res)
+{
+	if (res == 0) {
+		failure++;
+		printf("XXX: unexpected no error on %s\n", msg);
+	} else
+		printf("expected error %d on %s\n", errno, msg);
+}
+
+void optionalerr(char *msg, int res)
+{
+	if (res == 0) {
+		unexpected++;
+		printf("XXX: expected likely incorrect no error on %s\n", msg);
+	} else
+		printf("expected optional error %d on %s\n", errno, msg);
+}
+
+static int tmpcount;
+int tempfd(void)
+{
+	int fd;
+	char buf[PATHBUFLEN];
+	snprintf(buf, sizeof buf, TMPDIR "poison%d",tmpcount++);
+	fd = open(buf, O_CREAT|O_RDWR, 0600);
+	if (fd >= 0)
+		unlink(buf);
+	if (fd < 0)
+		err("opening temporary file in " TMPDIR);
+	return fd;
+}
+
+int playfile(char *buf)
+{
+	int fd;
+	if (buf[0] == 0)
+		snprintf(buf, PATHBUFLEN, TMPDIR "poison%d", tmpcount++);
+	fd = open(buf, O_CREAT|O_RDWR|O_TRUNC, 0600);
+	if (fd < 0)
+		err("opening temporary file in " TMPDIR);
+
+	const int NPAGES = 5;
+	char *tmp = xmalloc(PS * NPAGES);
+	int i;
+	for (i = 0; i < PS*NPAGES; i++)
+		tmp[i] = i;
+	write(fd, tmp, PS*NPAGES);
+
+	lseek(fd, 0, SEEK_SET);
+	return fd;
+}
+
+static void dirty_anonymous(void)
+{
+	char *page;
+	page = checked_mmap(NULL, PS, PROT_READ|PROT_WRITE, MAP_PRIVATE|MAP_ANONYMOUS|MAP_POPULATE, 0, 0);
+	testmem("dirty", page, MWRITE);
+}
+
+static void dirty_anonymous_unmap(void)
+{
+	char *page;
+	page = checked_mmap(NULL, PS, PROT_READ|PROT_WRITE, MAP_PRIVATE|MAP_ANONYMOUS|MAP_POPULATE, 0, 0);
+	testmem("dirty", page, MWRITE);
+	munmap_reserve(page, PS);
+}
+
+static void mlocked_anonymous(void)
+{
+	char *page;
+	page = checked_mmap(NULL, PS, PROT_READ|PROT_WRITE, MAP_PRIVATE|MAP_ANONYMOUS|MAP_LOCKED, 0, 0);
+	testmem("mlocked", page, MWRITE);
+}
+
+static void file_clean(void)
+{
+	char *page;
+	char fn[30];
+	snprintf(fn, 30, TMPDIR "test%d", tmpcount++);
+	int fd = open(fn, O_RDWR|O_TRUNC|O_CREAT);
+	if (fd < 0)
+		err("open temp file");
+	write(fd, fn, 4);
+	fsync(fd);
+	page = checked_mmap(NULL, PS, PROT_READ|PROT_WRITE, MAP_SHARED, fd, 0);
+	close(fd);
+	testmem("file clean", page, MREAD_OK);
+	printf("%x\n", *(unsigned char *)page); /* reread page from disk */
+	testmem("file clean", page, MWRITE_OK);
+}
+
+static void file_dirty(void)
+{
+	char *page;
+	char fn[PATHBUFLEN];
+	fn[0] = 0;
+	int fd = playfile(fn);
+
+	page = checked_mmap(NULL, PS, PROT_READ, MAP_SHARED|MAP_POPULATE, fd, 0);
+	testmem("dirty file initial", page, MREAD);
+	expecterr("msync expect error", msync(page, PS, MS_SYNC));
+	close(fd);
+	munmap_reserve(page, PS);
+
+	fd = open(fn, O_RDONLY);
+	if (fd < 0) err("reopening temp file");
+	page = checked_mmap(NULL, PS, PROT_READ, MAP_SHARED|MAP_POPULATE, fd, 0);
+	recover("dirty file populated", page, MREAD_OK);
+	close(fd);
+	munmap_reserve(page, PS);
+
+	fd = open(fn, O_RDONLY);
+	if (fd < 0) err("reopening temp file");
+	page = checked_mmap(NULL, PS, PROT_READ, MAP_SHARED, fd, 0);
+	recover("dirty file fault", page, MREAD_OK);
+	close(fd);
+	munmap_reserve(page, PS);
+
+	fd = open(fn, O_RDONLY);
+	char buf[128];
+	expecterr("explicit read after poison", read(fd, buf, sizeof buf));
+	expecterr("explicit write after poison", write(fd, "foobar", 6));
+	optionalerr("fsync expect error", fsync(fd));
+	close(fd);
+
+	/* should unlink return an error here? */
+	if (unlink(fn) < 0)
+		perror("unlink");
+}
+
+/* TBD */
+static void file_hole(void)
+{
+	int fd = tempfd();
+	char *page;
+
+	ftruncate(fd, PS);
+	page = checked_mmap(NULL, PS, PROT_READ|PROT_WRITE, MAP_SHARED, fd, 0);
+	*page = 1;
+	testmem("hole file dirty", page, MREAD);
+	expecterr("hole fsync expect error", fsync(fd));
+	optionalerr("hole msync expect error", msync(page, PS, MS_SYNC));
+	close(fd);
+}
+
+static void nonlinear(void)
+{
+	int fd;
+	const int NPAGES = 10;
+	int i;
+	char *page;
+	char *tmp;
+
+	fd = tempfd();
+	tmp = xmalloc(PS);
+	for (i = 0; i < NPAGES; i++)  {
+		memset(tmp, i, PS);
+		write(fd, tmp, PS);
+	}
+	free(tmp);
+	page = checked_mmap(NULL, PS*NPAGES, PROT_READ|PROT_WRITE, MAP_SHARED, fd, 0);
+	int k = NPAGES - 1;
+	for (i = 0; i < NPAGES; i++, k--) {
+		if (remap_file_pages(page + i*PS, PS, 0, k, 0))
+			perror("remap_file_pages");
+	}
+	*page = 1;
+	testmem("rfp file dirty", page, MREAD);
+	expecterr("rfp fsync expect error", fsync(fd));
+	optionalerr("rfp msync expect error", msync(page, PS, MS_SYNC));
+	close(fd);
+}
+
+/*
+ * This is quite timing dependent. The sniper might hit the page
+ * before it is dirtied. If that happens tweak the delay
+ * (should auto tune)
+ */
+enum {
+	DELAY_NS = 30,
+};
+
+volatile enum sstate { START, WAITING, SNIPE } sstate;
+
+void waitfor(enum sstate w, enum sstate s)
+{
+	sstate = w;
+	mb();
+	while (sstate != s)
+		cpu_relax();
+}
+
+struct poison_arg {
+	char *msg;
+	char *page;
+	enum rmode mode;
+};
+
+void *sniper(void *p)
+{
+	struct poison_arg *arg = p;
+
+	waitfor(START, WAITING);
+	nanosleep(&((struct timespec) { .tv_nsec = DELAY_NS }), NULL);
+	poison(arg->msg, arg->page, arg->mode);
+	return NULL;
+}
+
+int setup_sniper(struct poison_arg *arg)
+{
+	if (sysconf(_SC_NPROCESSORS_ONLN) < 2)  {
+		printf("%s: Need at least two CPUs. Not tested\n", arg->msg);
+		return -1;
+	}
+	sstate = START;
+	mb();
+	pthread_t thr;
+	if (pthread_create(&thr, NULL, sniper, arg) < 0)
+		err("pthread_create");
+	pthread_detach(thr);
+	return 0;
+}
+
+static void under_io_dirty(void)
+{
+	struct poison_arg arg;
+	int fd = tempfd();
+	char *page;
+
+	page = checked_mmap(NULL, PS, PROT_READ|PROT_WRITE, MAP_SHARED|MAP_POPULATE, fd, 0);
+
+	arg.page = page;
+	arg.msg  = "under io dirty";
+	arg.mode = MWRITE;
+	if (setup_sniper(&arg) < 0)
+		return;
+
+	write(fd, "xyz", 3);
+	waitfor(WAITING, WAITING);
+	expecterr("write under io", fsync(fd));
+	close(fd);
+}
+
+static void under_io_clean(void)
+{
+	struct poison_arg arg;
+	char fn[PATHBUFLEN];
+	int fd;
+	char *page;
+	char buf[10];
+
+ 	fd = playfile(fn);
+	page = checked_mmap(NULL, PS, PROT_READ|PROT_WRITE, MAP_SHARED|MAP_POPULATE, fd, 0);
+	madvise(page, PS, MADV_DONTNEED);
+
+	arg.page = page;
+	arg.msg  = "under io clean";
+	arg.mode = MREAD_OK;
+	if (setup_sniper(&arg) < 0)
+		return;
+
+	waitfor(WAITING, WAITING);
+	// what is correct here?
+	if (pread(fd, buf, 10, 0) != 0)
+		perror("pread under io clean");
+	close(fd);
+}
+
+
+struct testcase {
+	void (*f)(void);
+	char *name;
+	int survivable;
+} cases[] = {
+	{ dirty_anonymous, "dirty anonymous" },
+	{ dirty_anonymous_unmap, "dirty anonymous unmap" },
+	{ mlocked_anonymous, "mlocked anonymous" },
+	{ file_clean, "file clean", 1 },
+	{ file_dirty, "file dirty" },
+	{ file_hole, "file hole" },
+	{ nonlinear, "nonlinear" },
+	/* { under_io_dirty, "under io dirty" }, */
+	/* { under_io_clean, "under io clean" }, */
+	{}
+};
+
+
+int main(void)
+{
+	PS = getpagesize();
+
+	/* don't kill me at poison time, but possibly at page fault time */
+	early_kill = 0;
+	system("sysctl -w vm.memory_failure_early_kill=0");
+
+	struct sigaction sa = {
+		.sa_sigaction = sighandler,
+		.sa_flags = SA_SIGINFO
+	};
+
+	struct testcase *t;
+	/* catch signals */
+	sigaction(SIGBUS, &sa, NULL);
+	for (t = cases; t->f; t++)
+		t->f();
+
+	/* suicide version */
+	for (t = cases; t->f; t++) {
+		pid_t child = fork();
+		if (child == 0) {
+			signal(SIGBUS, SIG_DFL);
+			t->f();
+			if (t->survivable)
+				_exit(2);
+			write(1, t->name, strlen(t->name));
+			write(1, PAIR(" didn't kill itself?\n"));
+			_exit(1);
+		} else {
+			siginfo_t sig;
+			if (waitid(P_PID, child, &sig, WEXITED) < 0)
+				perror("waitid");
+			else {
+				if (t->survivable) {
+					if (sig.si_code != CLD_EXITED) {
+						printf("XXX: %s: child not survived\n", t->name);
+						failure++;
+					}
+				} else {
+					if (sig.si_code != CLD_KILLED || sig.si_status != SIGBUS) {
+						printf("XXX: %s: child not killed by SIGBUS\n", t->name);
+						failure++;
+					}
+				}
+			}
+		}
+	}
+
+	/* early kill version */
+	early_kill = 1;
+	system("sysctl -w vm.memory_failure_early_kill=1");
+
+	sigaction(SIGBUS, &sa, NULL);
+	for (t = cases; t->f; t++)
+		t->f();
+
+	if (failure > 0) {
+		printf("FAILURE -- %d cases broken!\n", failure);
+		return 1;
+	}
+	printf("SUCCESS\n");
+	return 0;
+}
--- ltp-full-20090731.orig/testcases/mce-test/tsrc/tinjpage-working.c	1970-01-01 05:30:00.000000000 +0530
+++ ltp-full-20090731/testcases/mce-test/tsrc/tinjpage-working.c	2009-08-05 14:50:57.000000000 +0530
@@ -0,0 +1,151 @@
+/* 
+ * Test program for Linux memory error recovery. 
+ * Requires special injection support.
+ */
+#define _GNU_SOURCE 1
+#include <sys/mman.h>
+#include <stdio.h>
+#include <signal.h>
+#include <unistd.h>
+#include <sys/fcntl.h>
+#include <stdlib.h>
+#include <setjmp.h>
+#include <errno.h>
+#include <string.h>
+
+#define MADV_POISON 12
+
+#define err(x) perror(x),exit(1)
+
+int count = 20;
+sigjmp_buf recover;
+int PS;
+
+void sighandler(int sig, siginfo_t *si, void *arg)
+{
+	printf("signal %d code %d addr %p\n", sig, si->si_code, si->si_addr);
+
+	if (--count == 0)
+		exit(1);
+
+	siglongjmp(recover, 1);
+}
+
+void testmem(char *msg, char *page, int write)
+{
+	printf("%s page %p\n", msg, page);
+	if (sigsetjmp(recover,1) == 0) {
+		if (madvise(page, PS, MADV_POISON) != 0)
+			perror("madvise");
+		if (write)
+			*page = 2;
+		else
+			printf("%x\n", *(unsigned char *)page);	
+	}
+	printf("recovered\n");
+}
+
+void expecterr(char *msg, int res)
+{
+	if (res == 0)
+		printf("no error on %s\n", msg);
+	else
+		perror(msg);
+}
+
+int tempfd(void)
+{
+	static int tmpcount;
+	int fd;
+	char buf[30];
+	snprintf(buf,30,"/tmp/test%d.XXXXXXXX",tmpcount++);
+	fd = mkstemp(buf);
+	if (fd >= 0)
+		unlink(buf);
+	return fd;
+}
+
+#define RANDOM_FILE "/etc/profile"
+
+int main(void)
+{
+	PS = getpagesize();
+	char *page;
+
+	struct sigaction sa = { 	
+		.sa_sigaction = sighandler,
+		.sa_flags = SA_SIGINFO
+	};
+	sigaction(SIGBUS, &sa, NULL);
+//	sigaction(SIGSEGV, &sa, NULL);
+
+ 	page = mmap(NULL, PS, PROT_READ|PROT_WRITE, MAP_PRIVATE|MAP_ANONYMOUS|MAP_POPULATE, 0, 0);
+	testmem("dirty", page, 1);
+
+	page = mmap(NULL, PS, PROT_READ|PROT_WRITE, MAP_PRIVATE|MAP_ANONYMOUS|MAP_LOCKED, 0, 0);
+	testmem("mlocked", page, 1);
+
+	int fd = open(RANDOM_FILE, O_RDONLY);
+	if (fd < 0) err("open " RANDOM_FILE);
+	page = mmap(NULL, PS, PROT_READ, MAP_SHARED|MAP_POPULATE, fd, 0);
+	if (page == (char *)-1) err("mmap");
+	close(fd);
+	testmem("clean file", page, 0);
+
+	fd = tempfd();
+	if (fd < 0) err("open testfile");
+	char *tmp = malloc(PS);
+	if (!tmp) exit(ENOMEM);
+	memset(tmp, 0xff, PS);
+	write(fd, tmp, PS);
+	free(tmp);
+	page = mmap(NULL, PS, PROT_READ|PROT_WRITE, MAP_SHARED, fd, 0);
+	if (page == (char*)-1) err("mmap");
+	*page = 1;
+	testmem("file dirty", page, 0);
+	expecterr("msync expect error", msync(page, PS, MS_SYNC));
+	expecterr("fsync expect error", fsync(fd));
+	close(fd);
+
+	/* hole case still broken in the kernel -- doesn't report error */
+	fd = tempfd();
+	if (fd < 0) err("open testfile");
+	ftruncate(fd, PS);
+	page = mmap(NULL, PS, PROT_READ|PROT_WRITE, MAP_SHARED, fd, 0);
+	if (page == (char*)-1) err("mmap");
+	*page = 1;
+	testmem("hole file dirty", page, 0);
+	expecterr("hole msync expect error", msync(page, PS, MS_SYNC));
+	expecterr("hole fsync expect error", fsync(fd));
+	close(fd);
+
+#if 0
+	const int NPAGES = 10;
+	int i;
+	fd = tempfd();
+	if (fd < 0) err("open rfp testfile");
+	tmp = malloc(PS);
+	if (!tmp) exit(ENOMEM);
+	for (i = 0; i < NPAGES; i++)  {
+		memset(tmp, i, PS);
+		write(fd, tmp, PS);
+	}
+	free(tmp);
+	page = mmap(NULL, PS*NPAGES, PROT_READ|PROT_WRITE, MAP_SHARED, fd, 0);
+	if (page == (char*)-1) err("mmap");
+	int k = NPAGES - 1;
+	for (i = 0; i < NPAGES; i++, k--) {
+		if (remap_file_pages(page + i*PS, PS, 0, k, 0))
+			perror("remap_file_pages");
+	}
+	*page = 1;
+	testmem("rfp file dirty", page, 0);
+	expecterr("rfp msync expect error", msync(page, PS, MS_SYNC));
+	expecterr("rfp fsync expect error", fsync(fd));
+	close(fd);
+#endif
+
+	return 0;
+}	
+
+
--- ltp-full-20090731.orig/testcases/mce-test/tsrc/tkillpoison.c	1970-01-01 05:30:00.000000000 +0530
+++ ltp-full-20090731/testcases/mce-test/tsrc/tkillpoison.c	2009-08-05 14:50:57.000000000 +0530
@@ -0,0 +1,21 @@
+// kills itself using poison
+#define _GNU_SOURCE 1
+#include <stdlib.h>
+#include <sys/mman.h>
+#include <stdio.h>
+#include <unistd.h>
+
+#define MADV_POISON 12
+
+int main(void)
+{
+	int PS = getpagesize();
+	char *ptr = mmap(NULL, PS, PROT_READ|PROT_WRITE, MAP_PRIVATE|MAP_ANONYMOUS|MAP_POPULATE, 0,0);;
+	printf("ptr = %p\n", ptr);
+	madvise(ptr, PS, MADV_POISON);
+	printf("faulting\n");
+	*ptr = 1;
+	printf("waiting\n");
+	sleep(100);
+	return 0;
+}
--- ltp-full-20090731.orig/testcases/mce-test/tsrc/tring.c	1970-01-01 05:30:00.000000000 +0530
+++ ltp-full-20090731/testcases/mce-test/tsrc/tring.c	2009-08-05 14:50:57.000000000 +0530
@@ -0,0 +1,85 @@
+
+#define DEFINE_PER_CPU(a,b) a b
+#define __get_cpu_var(x) x
+#define barrier() asm volatile("" ::: "memory")
+#define rmb() barrier()
+#define wmb() barrier()
+
+/*
+ * Simple lockless ring to communicate PFNs from the exception handler with the
+ * process context work function. This is vastly simplified because there's
+ * only a single reader and a single writer.
+ */
+#define MCE_RING_SIZE 16	/* we use one entry less */
+
+struct mce_ring {
+	unsigned short start;
+	unsigned short end;
+	unsigned long ring[MCE_RING_SIZE];
+};
+static DEFINE_PER_CPU(struct mce_ring, mce_ring);
+
+static int mce_ring_empty(void)
+{
+	struct mce_ring *r = &__get_cpu_var(mce_ring);
+
+	return r->start == r->end;
+}
+
+static int mce_ring_get(unsigned long *pfn)
+{
+	struct mce_ring *r = &__get_cpu_var(mce_ring);
+
+	if (r->start == r->end)
+		return 0;
+	*pfn = r->ring[r->start];
+	r->start = (r->start + 1) % MCE_RING_SIZE;
+	return 1;
+}
+
+static int mce_ring_add(unsigned long pfn)
+{
+	struct mce_ring *r = &__get_cpu_var(mce_ring);
+	unsigned next;
+
+	next = (r->end + 1) % MCE_RING_SIZE;
+	if (next == r->start)
+		return -1;
+	r->ring[r->end] = pfn;
+	wmb();
+	r->end = next;
+	return 0;
+}
+
+#include <stdio.h>
+#include <assert.h>
+#include <pthread.h>
+
+void *thread(void *arg)
+{
+	long i = 0;
+	for (;;) { 
+		if (mce_ring_add(i) >= 0)
+			i++;
+	}
+}
+
+main()
+{
+	long k;
+	
+	pthread_t thr;
+	pthread_create(&thr, NULL, thread, NULL);
+
+	k = 0;
+	for (;;) { 	
+		while (!mce_ring_empty()) { 
+			unsigned long pfn;
+			int r = mce_ring_get(&pfn);
+			assert(r != 0);
+			if (pfn != k) 
+				printf("got %lu expected %lu delta %ld\n", pfn, k, k-pfn);
+			k++;
+		}
+	}
+}
--- ltp-full-20090731.orig/testcases/mce-test/tsrc/ttable.c	1970-01-01 05:30:00.000000000 +0530
+++ ltp-full-20090731/testcases/mce-test/tsrc/ttable.c	2009-08-05 14:50:57.000000000 +0530
@@ -0,0 +1,258 @@
+/* 
+ * Print table of MCA status bit combinations with results in HTML.
+ * Author: Andi Kleen
+ */
+#define _GNU_SOURCE 1
+#include <stdio.h>
+#include <stdlib.h>
+#include <stddef.h>
+#include <string.h>
+#include <assert.h>
+#include <unistd.h>
+#include <errno.h>
+#define __KERNEL__ 1
+#include <asm/types.h>
+#include <asm/mce.h>
+
+typedef unsigned long long u64;
+
+
+#define MCI_STATUS_S	 (1ULL<<56)  /* Signaled machine check */
+#define MCI_STATUS_AR	 (1ULL<<55)  /* Action required */
+
+int tolerant = 1;
+int panic_on_oops = 0;
+int mce_ser = 1;
+
+#include "mce-severity.c"
+
+int disable_opt = 0;
+
+struct rname { 
+	char *name;
+	unsigned color;
+	char *desc;
+} rnames[] = {
+#define R(x,col,d) [MCE_ ## x ## _SEVERITY] = { #x, col, d }
+	R(NO, 0xc0c0c0, "Ignored"),
+	R(KEEP, 0x800080, "Ignore. Keep for CMC"),
+	R(SOME, 0x808080, "Log & Clear"),
+	R(AO, 0xffff00, "Kill address owner"),
+	R(UC, 0x700000, "Kill or panic"),
+	R(AR, 0x00ff00, "Kill current context"),
+	R(PANIC, 0xff0000, "Shutdown"),
+#undef R
+};
+
+struct bit { 
+	char *name;
+	unsigned offset;
+	u64 bit;
+} bits[] = { 
+#define O(x) offsetof(struct mce, x)
+#define S(x) { #x, O(status), MCI_STATUS_ ## x }
+	{ "RIPV", O(mcgstatus), MCG_STATUS_RIPV },
+	{ "EIPV", O(mcgstatus), MCG_STATUS_EIPV },
+	{ "MCIP", O(mcgstatus), MCG_STATUS_MCIP },
+	S(EN),
+	S(VAL),
+	S(UC),
+	S(S),
+	S(AR),
+	S(PCC),
+	S(OVER),
+	{ "SCRB-ERR", O(status), 0xc0 },
+#undef S
+#undef O
+};
+
+struct mce basem;
+
+#define bit_for_each(i,v) for (i = 0; i < 64; i++) if ((v) & (1ULL << i)) 
+
+struct result { 
+	int res;
+	unsigned dontcare;
+	char *msg;
+};
+
+void genstate(struct mce *m, unsigned num)
+{
+	int i;
+	*m = basem;
+	
+	bit_for_each (i, num)
+		*(u64 *)((char *)m + bits[i].offset) |= bits[i].bit;
+}
+
+// find don't care bits
+// brute force version because andi is not clever enough to make the clever 
+// version work. luckily the tables are small
+
+#define for_rr(start, i) for (i = start; i < num; i++) if (rr[i].res >= 0) 
+#define mask_of(x) ((1U << (x))-1)
+
+static void disable(struct result *rr, int i, int src)
+{
+	//fprintf(stderr, "disabling %d from %d\n", i, src);
+	rr[i].res = -1;
+}
+
+// handle case: one bit set always the same outcome
+static void one_bit_all(struct result *rr, int num, int mask)
+{
+	int first, k;
+	if (mask >= num)
+		return;
+	first = mask;
+	for_rr (first, k) { 
+		if (!(k & mask))
+			continue;
+		if (rr[k].res != rr[first].res)
+			return;
+	}
+	rr[first].dontcare = mask_of(ARRAY_SIZE(bits)) & ~mask;
+	for_rr (first + 1, k) { 
+		if (k & mask)
+			disable(rr, k, k);
+	}
+}
+
+// check if toggling one bit gives the same outcome
+static void neighbour_same(struct result *rr, int num, int mask)
+{
+	int k, other;
+	for_rr (mask, k) { 
+		if (!(k & mask) || (rr[k].dontcare & mask))
+			continue;
+		other = k ^ mask;
+		if (other >= num)
+			continue;
+		if (rr[other].res == rr[k].res && rr[other].msg == rr[k].msg) { 
+			disable(rr, other, k);
+			rr[k].dontcare |= mask;
+		}
+	}
+}
+
+void optimizer(struct result *rr, int num)
+{
+	int i;
+
+	for (i = 1; i <= 1 << ARRAY_SIZE(bits); i <<= 1)
+		one_bit_all(rr, num, i);
+	for (i = 1; i <= 1 << ARRAY_SIZE(bits); i <<= 1)
+		neighbour_same(rr, num, i);
+}
+
+int bitcount(u64 v)
+{
+	int num = 0;
+	while (v) {
+		if (v & 1)
+			num++;
+		v >>= 1;
+	}
+	return num;
+}
+
+void table(char *title)
+{
+	struct mce m;
+	int i, w, num; 
+	
+	struct result *rr = calloc(sizeof(struct result), 1U << ARRAY_SIZE(bits));
+
+	num = 0;
+	for (i = 0; i < 1U << ARRAY_SIZE(bits); i++) {
+		genstate(&m, i);
+		rr[num].res = mce_severity(&m, tolerant, &rr[num].msg);
+		num++;
+	}
+
+	if (!disable_opt)
+		optimizer(rr, num);
+	
+	printf("<p><table border=1>\n");
+	printf("<chaption>%s</chaption>\n", title);
+
+	printf("<tr>\n");	
+	for (i = 0; i < ARRAY_SIZE(bits); i++) { 
+		printf("<th>%s</th>", bits[i].name);
+	}
+	printf("<th>Result</th><th>Rule</th><th>Action</th>\n");
+	printf("</tr>\n");
+
+	for_rr (0, i) { 
+		printf("<tr>");
+		for (w = 0; w < ARRAY_SIZE(bits); w++) { 
+			char *p = "0"; 
+			char *col = "";
+			unsigned mask = 1U << w;
+
+			if (mask & rr[i].dontcare) {
+				p = "x";
+				col = " bgcolor=\"888888\"";
+			} else if (mask & i) { 
+				if (bitcount(bits[w].bit) > 1) 
+					asprintf(&p, "%llx", bits[w].bit);
+				else
+					p = "1";
+ 				col = " bgcolor=\"ffffff\"";
+			}
+			printf("<td%s>%s</td>", col, p);
+		}
+		struct rname *rname = &rnames[rr[i].res];
+		if ((unsigned)rr[i].res >= ARRAY_SIZE(rnames))
+			rname = &((struct rname) { .name = "out of bounds", .color = 0xff00ff });
+		assert(rname->name != NULL);
+		printf("<td bgcolor=\"%06x\">%s</td>", rname->color, rname->name);
+		assert(rr[i].msg != NULL);
+		printf("<td>%s</td>", rr[i].msg);
+		printf("<td>%s</td>", rname->desc);
+		printf("</tr>\n");	
+	}
+	printf("</table>\n");
+}
+
+void usage(void)
+{
+	fprintf(stderr, "ttable [-a]\n"
+			"-a don't print don't care bits, but all states\n");
+	exit(1);
+}
+
+int main(int ac, char **av)
+{
+	int opt;
+	while ((opt = getopt(ac, av, "a")) != -1) { 
+		switch (opt) { 
+		case 'a': 
+			disable_opt = 1;
+			break;
+		default:
+			usage();
+		}
+	}
+
+	printf("<html><body>\n");
+	printf("<!-- Auto generated. Changes will be overwritten -->\n");
+	basem.ip = 1;
+	printf("<h1>Linux kernel machine check grading</h1>\n");
+	printf("Caveats: Only scrubber error AO MCACOD. Only applies to exceptions.\n");
+	mce_ser = 1;
+	basem.cs = 0;
+	table("With MCA recovery ring 0");
+	tolerant = 0;
+	table("With MCA recovery ring 0 tolerant = 0");
+	tolerant = 1;
+	basem.cs = 3;
+	table("With MCA recovery ring 3");
+	basem.cs = 0;
+	mce_ser = 0;
+	table("Without MCA recovery ring 0");
+	basem.cs = 3;
+	table("Without MCA recovery ring 3");
+	printf("</body></html>\n");
+	return 0;
+}

---
Regards--
Subrata

> 
> Best Regards,
> Huang Ying

------------------------------------------------------------------------------
Let Crystal Reports handle the reporting - Free Crystal Reports 2008 30-Day 
trial. Simplify your report design, integration and deployment - and focus on 
what you do best, core application coding. Discover what's new with 
Crystal Reports now.  http://p.sf.net/sfu/bobj-july
_______________________________________________
Ltp-list mailing list
Ltp-list@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/ltp-list
