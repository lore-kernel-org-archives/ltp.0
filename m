Return-Path: <ltp-list-bounces@lists.sourceforge.net>
Received: from sfi-mx-3.v28.ch3.sourceforge.com ([172.29.28.123]
	helo=mx.sourceforge.net)
	by 3yr0jf1.ch3.sourceforge.com with esmtp (Exim 4.69)
	(envelope-from <mpnayak@linux.vnet.ibm.com>) id 1MLenC-0001kC-LP
	for ltp-list@lists.sourceforge.net; Tue, 30 Jun 2009 14:58:42 +0000
Received: from e8.ny.us.ibm.com ([32.97.182.138])
	by 3b2kzd1.ch3.sourceforge.com with esmtp (Exim 4.69)
	id 1MLen8-00033T-Md
	for ltp-list@lists.sourceforge.net; Tue, 30 Jun 2009 14:58:42 +0000
Received: from d01relay02.pok.ibm.com (d01relay02.pok.ibm.com [9.56.227.234])
	by e8.ny.us.ibm.com (8.13.1/8.13.1) with ESMTP id n5UElo87017939
	for <ltp-list@lists.sourceforge.net>; Tue, 30 Jun 2009 10:47:50 -0400
Received: from d01av01.pok.ibm.com (d01av01.pok.ibm.com [9.56.224.215])
	by d01relay02.pok.ibm.com (8.13.8/8.13.8/NCO v9.2) with ESMTP id
	n5UEwbYn256766
	for <ltp-list@lists.sourceforge.net>; Tue, 30 Jun 2009 10:58:37 -0400
Received: from d01av01.pok.ibm.com (loopback [127.0.0.1])
	by d01av01.pok.ibm.com (8.12.11.20060308/8.13.3) with ESMTP id
	n5UEwbL0007504
	for <ltp-list@lists.sourceforge.net>; Tue, 30 Jun 2009 10:58:37 -0400
From: Poornima Nayak <mpnayak@linux.vnet.ibm.com>
Date: Tue, 30 Jun 2009 20:28:33 +0530
Message-Id: <20090630145833.11163.78843.sendpatchset@localhost.localdomain>
In-Reply-To: <20090630145706.11163.54040.sendpatchset@localhost.localdomain>
References: <20090630145706.11163.54040.sendpatchset@localhost.localdomain>
Subject: [LTP] [Patch 10/10]Patch to add another command file in runtest
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

[Patch 10/10]Patch to add another command file in runtest

Signed-off-by: poornima nayak <mpnayak@linux.vnet.ibm.com>

diff -uprN ltp_orig/runtest/power_management_tests_exclusive ltp_patched/runtest/power_management_tests_exclusive
--- ltp_orig/runtest/power_management_tests_exclusive	1970-01-01 05:30:00.000000000 +0530
+++ ltp_patched/runtest/power_management_tests_exclusive	2009-06-30 16:25:28.000000000 +0530
@@ -0,0 +1 @@
+POWER_MANAGEMENT runpwtests.sh -exclusive

------------------------------------------------------------------------------
_______________________________________________
Ltp-list mailing list
Ltp-list@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/ltp-list
