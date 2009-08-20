Return-Path: <ltp-list-bounces@lists.sourceforge.net>
Received: from sfi-mx-4.v28.ch3.sourceforge.com ([172.29.28.124]
	helo=mx.sourceforge.net)
	by 3yr0jf1.ch3.sourceforge.com with esmtp (Exim 4.69)
	(envelope-from <mpnayak@linux.vnet.ibm.com>) id 1MeAAj-0003EX-Tu
	for ltp-list@lists.sourceforge.net; Thu, 20 Aug 2009 16:07:29 +0000
Received: from e3.ny.us.ibm.com ([32.97.182.143])
	by 1b2kzd1.ch3.sourceforge.com with esmtps (TLSv1:AES256-SHA:256)
	(Exim 4.69) id 1MeAAj-00043Y-1j
	for ltp-list@lists.sourceforge.net; Thu, 20 Aug 2009 16:07:29 +0000
Received: from d01relay06.pok.ibm.com (d01relay06.pok.ibm.com [9.56.227.116])
	by e3.ny.us.ibm.com (8.14.3/8.13.1) with ESMTP id n7KG0oks016063
	for <ltp-list@lists.sourceforge.net>; Thu, 20 Aug 2009 12:00:51 -0400
Received: from d03av04.boulder.ibm.com (d03av04.boulder.ibm.com [9.17.195.170])
	by d01relay06.pok.ibm.com (8.13.8/8.13.8/NCO v10.0) with ESMTP id
	n7KG7Iw82642022
	for <ltp-list@lists.sourceforge.net>; Thu, 20 Aug 2009 12:07:19 -0400
Received: from d03av04.boulder.ibm.com (loopback [127.0.0.1])
	by d03av04.boulder.ibm.com (8.12.11.20060308/8.13.3) with ESMTP id
	n7KG7IgD023507
	for <ltp-list@lists.sourceforge.net>; Thu, 20 Aug 2009 10:07:18 -0600
From: Poornima Nayak <mpnayak@linux.vnet.ibm.com>
Date: Thu, 20 Aug 2009 21:37:14 +0530
Message-Id: <20090820160714.30926.24455.sendpatchset@localhost.localdomain>
In-Reply-To: <20090820160655.30926.34854.sendpatchset@localhost.localdomain>
References: <20090820160655.30926.34854.sendpatchset@localhost.localdomain>
Subject: [LTP] Patch to include workload for consolidation verification
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

Modified to pass workload as a parameter for cpu cosolidation verifcation function.
This is required to verify cpu consolidation on Hypre threaded system for kernbench workload.

Signed-off-by: poornima nayak <mpnayak@linux.vnet.ibm.com>

diff -uprN ltp-full-20090731_orig/testcases/kernel/power_management/cpu_consolidation.py ltp-full-20090731/testcases/kernel/power_management/cpu_consolidation.py
--- ltp-full-20090731_orig/testcases/kernel/power_management/cpu_consolidation.py	2009-08-20 19:59:11.000000000 +0530
+++ ltp-full-20090731/testcases/kernel/power_management/cpu_consolidation.py	2009-08-20 20:39:25.000000000 +0530
@@ -45,7 +45,7 @@ def main(argv=None):
         duration=60
         trigger_workld(options.work_ld, options.stress, duration, background)
         generate_report()
-        status = validate_cpu_consolidation(options.mc_level, options.smt_level)
+        status = validate_cpu_consolidation(options.work_ld,options.mc_level, options.smt_level)
         reset_schedmc()
         if is_hyper_threaded():
             reset_schedsmt()

------------------------------------------------------------------------------
Let Crystal Reports handle the reporting - Free Crystal Reports 2008 30-Day 
trial. Simplify your report design, integration and deployment - and focus on 
what you do best, core application coding. Discover what's new with 
Crystal Reports now.  http://p.sf.net/sfu/bobj-july
_______________________________________________
Ltp-list mailing list
Ltp-list@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/ltp-list
