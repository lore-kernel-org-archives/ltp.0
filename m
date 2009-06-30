Return-Path: <ltp-list-bounces@lists.sourceforge.net>
Received: from sfi-mx-2.v28.ch3.sourceforge.com ([172.29.28.122]
	helo=mx.sourceforge.net)
	by h25xhf1.ch3.sourceforge.com with esmtp (Exim 4.69)
	(envelope-from <mpnayak@linux.vnet.ibm.com>) id 1MLemk-0004Uo-US
	for ltp-list@lists.sourceforge.net; Tue, 30 Jun 2009 14:58:14 +0000
Received: from e1.ny.us.ibm.com ([32.97.182.141])
	by 72vjzd1.ch3.sourceforge.com with esmtp (Exim 4.69)
	id 1MLemk-0004AF-3k
	for ltp-list@lists.sourceforge.net; Tue, 30 Jun 2009 14:58:14 +0000
Received: from d01relay07.pok.ibm.com (d01relay07.pok.ibm.com [9.56.227.147])
	by e1.ny.us.ibm.com (8.13.1/8.13.1) with ESMTP id n5UErS8L006914
	for <ltp-list@lists.sourceforge.net>; Tue, 30 Jun 2009 10:53:28 -0400
Received: from d03av01.boulder.ibm.com (d03av01.boulder.ibm.com [9.17.195.167])
	by d01relay07.pok.ibm.com (8.13.8/8.13.8/NCO v9.2) with ESMTP id
	n5UEwADX557292
	for <ltp-list@lists.sourceforge.net>; Tue, 30 Jun 2009 10:58:10 -0400
Received: from d03av01.boulder.ibm.com (loopback [127.0.0.1])
	by d03av01.boulder.ibm.com (8.12.11.20060308/8.13.3) with ESMTP id
	n5UEw9XM018014
	for <ltp-list@lists.sourceforge.net>; Tue, 30 Jun 2009 08:58:10 -0600
From: Poornima Nayak <mpnayak@linux.vnet.ibm.com>
Date: Tue, 30 Jun 2009 20:28:06 +0530
Message-Id: <20090630145806.11163.61029.sendpatchset@localhost.localdomain>
In-Reply-To: <20090630145706.11163.54040.sendpatchset@localhost.localdomain>
References: <20090630145706.11163.54040.sendpatchset@localhost.localdomain>
Subject: [LTP] [Patch 7/10]Fixes for sched_mc & sched_smt interface test
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

[Patch 7/10]Fixes for sched_mc & sched_smt interface test
Existing testcase in LTP would fail or not cover all possible sched_mc values. 
This patch has been written to make testcase flexible to run on future releases.

Signed-off-by: poornima nayak <mpnayak@linux.vnet.ibm.com>

diff -uprN ltp_orig/testcases/kernel/power_management/test_sched_mc.sh ltp_patched/testcases/kernel/power_management/test_sched_mc.sh
--- ltp_orig/testcases/kernel/power_management/test_sched_mc.sh	2009-06-30 15:04:19.000000000 +0530
+++ ltp_patched/testcases/kernel/power_management/test_sched_mc.sh	2009-06-30 16:09:06.000000000 +0530
@@ -2,8 +2,10 @@
 
 . pm_include.sh
 
-valid_input="0 1 2"
-invalid_input="a abcefg x1999 xffff -1 -00000
+get_kernel_version
+get_valid_input $kernel_version
+
+invalid_input="3 4 5 6 7 8 a abcefg x1999 xffff -1 -00000
 200000000000000000000000000000000000000000000000000000000000000000000000000000
 ox324 -0xfffffffffffffffffffff"
 test_file="/sys/devices/system/cpu/sched_mc_power_savings"
@@ -14,7 +16,7 @@ fi
 
 RC=0
 echo "${0}: ---Valid test cases---"
-check_input "${valid_input}" valid $test_file
+check_input "${valid_input}" valid $test_file 
 RC=$?
 echo "${0}: ---Invalid test cases---"
 check_input "${invalid_input}" invalid $test_file
diff -uprN ltp_orig/testcases/kernel/power_management/test_sched_smt.sh ltp_patched/testcases/kernel/power_management/test_sched_smt.sh
--- ltp_orig/testcases/kernel/power_management/test_sched_smt.sh	2009-06-30 15:04:19.000000000 +0530
+++ ltp_patched/testcases/kernel/power_management/test_sched_smt.sh	2009-06-30 16:09:13.000000000 +0530
@@ -1,8 +1,11 @@
 #!/bin/bash
 
 . pm_include.sh
-valid_input="0 1"
-invalid_input="a abcefg x1999 xffff -1 -00000
+
+get_kernel_version
+get_valid_input $kernel_version
+
+invalid_input="3 4 5 6 7 8 a abcefg x1999 xffff -1 -00000
 200000000000000000000000000000000000000000000000000000000000000000000000000000
 ox324 -0xfffffffffffffffffffff"
 test_file="/sys/devices/system/cpu/sched_smt_power_savings"

------------------------------------------------------------------------------
_______________________________________________
Ltp-list mailing list
Ltp-list@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/ltp-list
