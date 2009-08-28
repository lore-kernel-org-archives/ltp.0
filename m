Return-Path: <ltp-list-bounces@lists.sourceforge.net>
Received: from sfi-mx-4.v28.ch3.sourceforge.com ([172.29.28.124]
	helo=mx.sourceforge.net)
	by 235xhf1.ch3.sourceforge.com with esmtp (Exim 4.69)
	(envelope-from <mpnayak@linux.vnet.ibm.com>) id 1MgyUp-0005pK-Mg
	for ltp-list@lists.sourceforge.net; Fri, 28 Aug 2009 10:15:51 +0000
Received: from e34.co.us.ibm.com ([32.97.110.152])
	by 1b2kzd1.ch3.sourceforge.com with esmtps (TLSv1:AES256-SHA:256)
	(Exim 4.69) id 1MgyUh-0006fo-Eg
	for ltp-list@lists.sourceforge.net; Fri, 28 Aug 2009 10:15:51 +0000
Received: from d03relay04.boulder.ibm.com (d03relay04.boulder.ibm.com
	[9.17.195.106])
	by e34.co.us.ibm.com (8.14.3/8.13.1) with ESMTP id n7SABX28025995
	for <ltp-list@lists.sourceforge.net>; Fri, 28 Aug 2009 04:11:33 -0600
Received: from d03av01.boulder.ibm.com (d03av01.boulder.ibm.com [9.17.195.167])
	by d03relay04.boulder.ibm.com (8.13.8/8.13.8/NCO v10.0) with ESMTP id
	n7SAFZes176144
	for <ltp-list@lists.sourceforge.net>; Fri, 28 Aug 2009 04:15:35 -0600
Received: from d03av01.boulder.ibm.com (loopback [127.0.0.1])
	by d03av01.boulder.ibm.com (8.12.11.20060308/8.13.3) with ESMTP id
	n7SAFZ0M017313
	for <ltp-list@lists.sourceforge.net>; Fri, 28 Aug 2009 04:15:35 -0600
From: Poornima Nayak <mpnayak@linux.vnet.ibm.com>
Date: Fri, 28 Aug 2009 15:45:31 +0530
Message-Id: <20090828101531.12177.80803.sendpatchset@localhost.localdomain>
In-Reply-To: <20090828101440.12177.32012.sendpatchset@localhost.localdomain>
References: <20090828101440.12177.32012.sendpatchset@localhost.localdomain>
Subject: [LTP] [Patch 7/8] Patch for cpu_consolidation to incorporate
	changes in reusable function
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

Patch for cpu_consolidation to incorporate changes in reusable function

Signed-off-by: poornima nayak <mpnayak@linux.vnet.ibm.com>

diff -uprN ltp_orig/testcases/kernel/power_management/cpu_consolidation.py ltp/testcases/kernel/power_management/cpu_consolidation.py
--- ltp_orig/testcases/kernel/power_management/cpu_consolidation.py	2009-08-28 10:54:59.000000000 +0530
+++ ltp/testcases/kernel/power_management/cpu_consolidation.py	2009-08-28 12:17:34.000000000 +0530
@@ -43,7 +43,8 @@ def main(argv=None):
         print "INFO: Created table mapping cpu to package"
         background="no"
         duration=60
-        trigger_workld(options.work_ld, options.stress, duration, background)
+        pinned ="no"
+        trigger_workld(options.work_ld, options.stress, duration, background, pinned)
         generate_report()
         status = validate_cpu_consolidation(options.work_ld,options.mc_level, options.smt_level)
         reset_schedmc()

------------------------------------------------------------------------------
Let Crystal Reports handle the reporting - Free Crystal Reports 2008 30-Day 
trial. Simplify your report design, integration and deployment - and focus on 
what you do best, core application coding. Discover what's new with 
Crystal Reports now.  http://p.sf.net/sfu/bobj-july
_______________________________________________
Ltp-list mailing list
Ltp-list@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/ltp-list
