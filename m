Return-Path: <ltp-list-bounces@lists.sourceforge.net>
Received: from sfi-mx-3.v28.ch3.sourceforge.com ([172.29.28.123]
	helo=mx.sourceforge.net)
	by 3yr0jf1.ch3.sourceforge.com with esmtp (Exim 4.69)
	(envelope-from <sachinp@in.ibm.com>) id 1N8ZHy-0003mX-2K
	for ltp-list@lists.sourceforge.net; Thu, 12 Nov 2009 13:00:38 +0000
Received: from e35.co.us.ibm.com ([32.97.110.153])
	by 3b2kzd1.ch3.sourceforge.com with esmtps (TLSv1:AES256-SHA:256)
	(Exim 4.69) id 1N8ZHt-0001wP-Q0
	for ltp-list@lists.sourceforge.net; Thu, 12 Nov 2009 13:00:37 +0000
Received: from d03relay05.boulder.ibm.com (d03relay05.boulder.ibm.com
	[9.17.195.107])
	by e35.co.us.ibm.com (8.14.3/8.13.1) with ESMTP id nACC3NHi018421
	for <ltp-list@lists.sourceforge.net>; Thu, 12 Nov 2009 05:03:23 -0700
Received: from d03av04.boulder.ibm.com (d03av04.boulder.ibm.com [9.17.195.170])
	by d03relay05.boulder.ibm.com (8.13.8/8.13.8/NCO v10.0) with ESMTP id
	nACCF0wo177970
	for <ltp-list@lists.sourceforge.net>; Thu, 12 Nov 2009 05:15:00 -0700
Received: from d03av04.boulder.ibm.com (loopback [127.0.0.1])
	by d03av04.boulder.ibm.com (8.14.3/8.13.1/NCO v10.0 AVout) with ESMTP
	id nAC6ASl7029414
	for <ltp-list@lists.sourceforge.net>; Wed, 11 Nov 2009 23:10:28 -0700
From: Sachin Sant <sachinp@in.ibm.com>
Date: Thu, 12 Nov 2009 17:44:55 +0530
Message-Id: <20091112121455.16825.70322.sendpatchset@localhost.localdomain>
Subject: [LTP] [PATCH] Power Management: Fix missing make targets.
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
Cc: Sachin Sant <sachinp@in.ibm.com>

Make sure required binaries used by the power management tests are compiled and
installed properly. Without the required MAKE TARGETS the test fails with

<<<test_output>>>
Are we really executing this ?
/opt/ltp/testcases/bin/runpwtests.sh: line 57: check_kv_arch: command not found
.....
Power_Management    7  TPASS  :  CPUIDLE sysfs tests passed
/opt/ltp/testcases/bin/runpwtests.sh: line 173: get_sched_values: command not
found

Patch is against LTP October version.

Signed-off-by: Sachin Sant <sachinp@in.ibm.com>
---
diff -Naurp a/testcases/kernel/power_management/Makefile b/testcases/kernel/power_management/Makefile
--- a/testcases/kernel/power_management/Makefile	2009-11-12 13:02:57.000000000 +0530
+++ b/testcases/kernel/power_management/Makefile	2009-11-12 13:04:03.000000000 +0530
@@ -26,6 +26,6 @@ $(eval $(call generate_vpath_rule,c,$(sr
 
 INSTALL_TARGETS		:= lib/*.py *.py *.sh
 
-MAKE_TARGETS		:=
+MAKE_TARGETS		:= check_kv_arch get_sched_values
 
 include $(top_srcdir)/include/mk/generic_leaf_target.mk

------------------------------------------------------------------------------
Let Crystal Reports handle the reporting - Free Crystal Reports 2008 30-Day 
trial. Simplify your report design, integration and deployment - and focus on 
what you do best, core application coding. Discover what's new with
Crystal Reports now.  http://p.sf.net/sfu/bobj-july
_______________________________________________
Ltp-list mailing list
Ltp-list@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/ltp-list
