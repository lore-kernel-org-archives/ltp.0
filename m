Return-Path: <ltp-list-bounces@lists.sourceforge.net>
Received: from sfi-mx-2.v28.ch3.sourceforge.com ([172.29.28.122]
	helo=mx.sourceforge.net)
	by 235xhf1.ch3.sourceforge.com with esmtp (Exim 4.69)
	(envelope-from <mpnayak@linux.vnet.ibm.com>) id 1MeABd-0004rD-Hl
	for ltp-list@lists.sourceforge.net; Thu, 20 Aug 2009 16:08:25 +0000
Received: from e2.ny.us.ibm.com ([32.97.182.142])
	by 72vjzd1.ch3.sourceforge.com with esmtps (TLSv1:AES256-SHA:256)
	(Exim 4.69) id 1MeABc-0006gd-Ji
	for ltp-list@lists.sourceforge.net; Thu, 20 Aug 2009 16:08:25 +0000
Received: from d01relay02.pok.ibm.com (d01relay02.pok.ibm.com [9.56.227.234])
	by e2.ny.us.ibm.com (8.14.3/8.13.1) with ESMTP id n7KG2I03027099
	for <ltp-list@lists.sourceforge.net>; Thu, 20 Aug 2009 12:02:18 -0400
Received: from d01av01.pok.ibm.com (d01av01.pok.ibm.com [9.56.224.215])
	by d01relay02.pok.ibm.com (8.13.8/8.13.8/NCO v10.0) with ESMTP id
	n7KG8IIL209074
	for <ltp-list@lists.sourceforge.net>; Thu, 20 Aug 2009 12:08:18 -0400
Received: from d01av01.pok.ibm.com (loopback [127.0.0.1])
	by d01av01.pok.ibm.com (8.12.11.20060308/8.13.3) with ESMTP id
	n7KG8I4q003661
	for <ltp-list@lists.sourceforge.net>; Thu, 20 Aug 2009 12:08:18 -0400
From: Poornima Nayak <mpnayak@linux.vnet.ibm.com>
Date: Thu, 20 Aug 2009 21:38:09 +0530
Message-Id: <20090820160809.30926.5725.sendpatchset@localhost.localdomain>
In-Reply-To: <20090820160655.30926.34854.sendpatchset@localhost.localdomain>
References: <20090820160655.30926.34854.sendpatchset@localhost.localdomain>
Subject: [LTP] New testcase to test timer_migration interface
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
To: vaidy <svaidy@linux.vnet.ibm.com>, ltp-list@lists.sourceforge.net, gautham <ego@in.ibm.com>, arun@linux.vnet.ibm.com

This is the new tescase to test timer migration interface.

Signed-off-by: poornima nayak <mpnayak@linux.vnet.ibm.com>

diff -uprN ltp-full-20090731_orig/testcases/kernel/power_management/test_timer_migration.sh ltp-full-20090731/testcases/kernel/power_management/test_timer_migration.sh
--- ltp-full-20090731_orig/testcases/kernel/power_management/test_timer_migration.sh	1970-01-01 05:30:00.000000000 +0530
+++ ltp-full-20090731/testcases/kernel/power_management/test_timer_migration.sh	2009-08-20 20:49:48.000000000 +0530
@@ -0,0 +1,22 @@
+#!/bin/bash
+
+. pm_include.sh
+
+valid_input="0 1"
+invalid_input="3 4 5 6 7 8 a abcefg x1999 xffff -1 -00000
+200000000000000000000000000000000000000000000000000000000000000000000000000000
+ox324 -0xfffffffffffffffffffff"
+test_file="/proc/sys/kernel/timer_migration"
+if [ ! -f ${test_file} ] ; then
+	echo "MISSING_FILE: missing file ${test_file}"
+	exit $MISSING_FILE
+fi
+
+RC=0
+echo "${0}: ---Valid test cases---"
+check_input "${valid_input}" valid $test_file 
+RC=$?
+echo "${0}: ---Invalid test cases---"
+check_input "${invalid_input}" invalid $test_file
+RC=$(( RC | $? ))
+exit $RC

------------------------------------------------------------------------------
Let Crystal Reports handle the reporting - Free Crystal Reports 2008 30-Day 
trial. Simplify your report design, integration and deployment - and focus on 
what you do best, core application coding. Discover what's new with 
Crystal Reports now.  http://p.sf.net/sfu/bobj-july
_______________________________________________
Ltp-list mailing list
Ltp-list@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/ltp-list
