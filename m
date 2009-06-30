Return-Path: <ltp-list-bounces@lists.sourceforge.net>
Received: from sfi-mx-4.v28.ch3.sourceforge.com ([172.29.28.124]
	helo=mx.sourceforge.net)
	by 335xhf1.ch3.sourceforge.com with esmtp (Exim 4.69)
	(envelope-from <mpnayak@linux.vnet.ibm.com>) id 1MLem3-00055Y-V3
	for ltp-list@lists.sourceforge.net; Tue, 30 Jun 2009 14:57:31 +0000
Received: from e1.ny.us.ibm.com ([32.97.182.141])
	by 1b2kzd1.ch3.sourceforge.com with esmtp (Exim 4.69)
	id 1MLem2-00079w-JQ
	for ltp-list@lists.sourceforge.net; Tue, 30 Jun 2009 14:57:31 +0000
Received: from d01relay02.pok.ibm.com (d01relay02.pok.ibm.com [9.56.227.234])
	by e1.ny.us.ibm.com (8.13.1/8.13.1) with ESMTP id n5UEqjwf005081
	for <ltp-list@lists.sourceforge.net>; Tue, 30 Jun 2009 10:52:45 -0400
Received: from d01av04.pok.ibm.com (d01av04.pok.ibm.com [9.56.224.64])
	by d01relay02.pok.ibm.com (8.13.8/8.13.8/NCO v9.2) with ESMTP id
	n5UEvUSu109202
	for <ltp-list@lists.sourceforge.net>; Tue, 30 Jun 2009 10:57:30 -0400
Received: from d01av04.pok.ibm.com (loopback [127.0.0.1])
	by d01av04.pok.ibm.com (8.12.11.20060308/8.13.3) with ESMTP id
	n5UEvTlN023537
	for <ltp-list@lists.sourceforge.net>; Tue, 30 Jun 2009 10:57:29 -0400
From: Poornima Nayak <mpnayak@linux.vnet.ibm.com>
Date: Tue, 30 Jun 2009 20:27:25 +0530
Message-Id: <20090630145725.11163.50654.sendpatchset@localhost.localdomain>
In-Reply-To: <20090630145706.11163.54040.sendpatchset@localhost.localdomain>
References: <20090630145706.11163.54040.sendpatchset@localhost.localdomain>
Subject: [LTP] [Patch 3/10]Readme modified with pre-requisite for sched_mc=2
	test
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

[Patch 3/10]Readme modified with pre-requisite for sched_mc=2 test

Signed-off-by: poornima nayak <mpnayak@linux.vnet.ibm.com>

diff -uprN ltp_orig/testcases/kernel/power_management/README ltp_patched/testcases/kernel/power_management/README
--- ltp_orig/testcases/kernel/power_management/README	2009-06-30 15:04:19.000000000 +0530
+++ ltp_patched/testcases/kernel/power_management/README	2009-06-30 16:31:17.000000000 +0530
@@ -80,3 +80,5 @@ Then either configuration is not set or 
 For CPU consolidation verification ebizzy is included in utils directory of LTP.
 To run cpu consolidation test user has to provide -w <workload> -l <sched_mc_level>.
 Refer to README in LTPROOT/utils/benchmark/ebizzy-0.2 directory for details of ebizzy.
+
+To test CPU consolidation for sched_mc 2 kernbench has to run. Kernbench needs linux kernel source as input in /root directory . For example download from http://www.kernel.org/pub/linux/kernel/v2.6/linux-2.6.29.4.tar.bz2. If Linux kernel source not found kernbench wiil  not execute.

------------------------------------------------------------------------------
_______________________________________________
Ltp-list mailing list
Ltp-list@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/ltp-list
