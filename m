Return-Path: <ltp-list-bounces@lists.sourceforge.net>
Received: from sfi-mx-1.v28.ch3.sourceforge.com ([172.29.28.121]
	helo=mx.sourceforge.net)
	by 235xhf1.ch3.sourceforge.com with esmtp (Exim 4.69)
	(envelope-from <mpnayak@linux.vnet.ibm.com>) id 1MgyUD-0005n3-Mc
	for ltp-list@lists.sourceforge.net; Fri, 28 Aug 2009 10:15:13 +0000
Received: from e35.co.us.ibm.com ([32.97.110.153])
	by 29vjzd1.ch3.sourceforge.com with esmtps (TLSv1:AES256-SHA:256)
	(Exim 4.69) id 1MgyUB-0004vW-Dc
	for ltp-list@lists.sourceforge.net; Fri, 28 Aug 2009 10:15:13 +0000
Received: from d03relay02.boulder.ibm.com (d03relay02.boulder.ibm.com
	[9.17.195.227])
	by e35.co.us.ibm.com (8.14.3/8.13.1) with ESMTP id n7SA5gBH010169
	for <ltp-list@lists.sourceforge.net>; Fri, 28 Aug 2009 04:05:42 -0600
Received: from d03av03.boulder.ibm.com (d03av03.boulder.ibm.com [9.17.195.169])
	by d03relay02.boulder.ibm.com (8.13.8/8.13.8/NCO v10.0) with ESMTP id
	n7SAF1Qo236988
	for <ltp-list@lists.sourceforge.net>; Fri, 28 Aug 2009 04:15:01 -0600
Received: from d03av03.boulder.ibm.com (loopback [127.0.0.1])
	by d03av03.boulder.ibm.com (8.12.11.20060308/8.13.3) with ESMTP id
	n7SAF1T4014085
	for <ltp-list@lists.sourceforge.net>; Fri, 28 Aug 2009 04:15:01 -0600
From: Poornima Nayak <mpnayak@linux.vnet.ibm.com>
Date: Fri, 28 Aug 2009 15:44:57 +0530
Message-Id: <20090828101457.12177.8327.sendpatchset@localhost.localdomain>
In-Reply-To: <20090828101440.12177.32012.sendpatchset@localhost.localdomain>
References: <20090828101440.12177.32012.sendpatchset@localhost.localdomain>
Subject: [LTP] [Patch 3/8] Patch to integrate ILB testcase to LTP
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
To: ltp-list@lists.sourceforge.net, svaidy@linux.vnet.ibm.com, ego@in.ibm.com, arun@linux.vnet.ibm.com

Patch to integrate ILB testcase to LTP

Signed-off-by: poornima nayak <mpnayak@linux.vnet.ibm.com>

diff -uprN ltp_orig/testcases/kernel/power_management/Makefile ltp/testcases/kernel/power_management/Makefile
--- ltp_orig/testcases/kernel/power_management/Makefile	2009-08-28 10:54:59.000000000 +0530
+++ ltp/testcases/kernel/power_management/Makefile	2009-08-28 12:28:50.000000000 +0530
@@ -49,6 +49,7 @@ install:
 	ln -f  check_cpuidle_sysfs_files.sh ../../bin/check_cpuidle_sysfs_files.sh;
 	ln -f  cpu_consolidation.py ../../bin/cpu_consolidation.py
 	ln -f  sched_domain.py ../../bin/sched_domain.py
+	ln -f  ilb_test.py ../../bin/ilb_test.py
 	chmod ugo+x *.sh
 clean:
 	@set -e; for i in $(SUBDIRS); do $(MAKE) -C $$i $@ ; done

------------------------------------------------------------------------------
Let Crystal Reports handle the reporting - Free Crystal Reports 2008 30-Day 
trial. Simplify your report design, integration and deployment - and focus on 
what you do best, core application coding. Discover what's new with 
Crystal Reports now.  http://p.sf.net/sfu/bobj-july
_______________________________________________
Ltp-list mailing list
Ltp-list@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/ltp-list
