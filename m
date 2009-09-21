Return-Path: <ltp-list-bounces@lists.sourceforge.net>
Received: from sfi-mx-4.v28.ch3.sourceforge.com ([172.29.28.124]
	helo=mx.sourceforge.net)
	by h25xhf1.ch3.sourceforge.com with esmtp (Exim 4.69)
	(envelope-from <mpnayak@linux.vnet.ibm.com>) id 1MpdGy-0002R4-9X
	for ltp-list@lists.sourceforge.net; Mon, 21 Sep 2009 07:25:20 +0000
Received: from e5.ny.us.ibm.com ([32.97.182.145])
	by 1b2kzd1.ch3.sourceforge.com with esmtps (TLSv1:AES256-SHA:256)
	(Exim 4.69) id 1MpdGq-00050j-Cs
	for ltp-list@lists.sourceforge.net; Mon, 21 Sep 2009 07:25:20 +0000
Received: from d01relay04.pok.ibm.com (d01relay04.pok.ibm.com [9.56.227.236])
	by e5.ny.us.ibm.com (8.14.3/8.13.1) with ESMTP id n8L7G8vG003205
	for <ltp-list@lists.sourceforge.net>; Mon, 21 Sep 2009 03:16:08 -0400
Received: from d01av04.pok.ibm.com (d01av04.pok.ibm.com [9.56.224.64])
	by d01relay04.pok.ibm.com (8.13.8/8.13.8/NCO v10.0) with ESMTP id
	n8L7P647178632
	for <ltp-list@lists.sourceforge.net>; Mon, 21 Sep 2009 03:25:06 -0400
Received: from d01av04.pok.ibm.com (loopback [127.0.0.1])
	by d01av04.pok.ibm.com (8.12.11.20060308/8.13.3) with ESMTP id
	n8L7P6sc021529
	for <ltp-list@lists.sourceforge.net>; Mon, 21 Sep 2009 03:25:06 -0400
From: Poornima Nayak <mpnayak@linux.vnet.ibm.com>
Date: Mon, 21 Sep 2009 12:55:02 +0530
Message-Id: <20090921072502.7307.58886.sendpatchset@localhost.localdomain>
In-Reply-To: <20090921072444.7307.84825.sendpatchset@localhost.localdomain>
References: <20090921072444.7307.84825.sendpatchset@localhost.localdomain>
Subject: [LTP] [Patch 3/6] To incorporate changes in reusable function
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

ILB testcase uses trigger workload to pin a task to CPU. This patch is to incorporate the changes in
the prototype of function testcase invokes to trigger workload.

Signed-off-by: poornima nayak <mpnayak@linux.vnet.ibm.com>

diff -uprN ltp-full-20090831/testcases/kernel/power_management/ilb_test.py ltp-full-20090831_patched/testcases/kernel/power_management/ilb_test.py
--- ltp-full-20090831/testcases/kernel/power_management/ilb_test.py	2009-08-31 10:45:45.000000000 +0530
+++ ltp-full-20090831_patched/testcases/kernel/power_management/ilb_test.py	2009-09-21 12:13:26.205934090 +0530
@@ -42,13 +42,15 @@ def main(argv=None):
         background="no"
         duration=60
         pinned="yes"
-        trigger_workld(options.work_ld, "single_job", duration, background, pinned)
+
+        trigger_workld(options.smt_level,options.work_ld, "single_job", duration, background, pinned)
         generate_loc_intr_report()
         status = validate_ilb(options.mc_level, options.smt_level)
         reset_schedmc()
         if is_hyper_threaded():
             reset_schedsmt()
-        return(status)        
+        return(status)     
+   
     except Exception, details:
         print "INFO: Idle Load Balancer test failed", details
         return(1)

------------------------------------------------------------------------------
Come build with us! The BlackBerry&reg; Developer Conference in SF, CA
is the only developer event you need to attend this year. Jumpstart your
developing skills, take BlackBerry mobile applications to market and stay 
ahead of the curve. Join us from November 9&#45;12, 2009. Register now&#33;
http://p.sf.net/sfu/devconf
_______________________________________________
Ltp-list mailing list
Ltp-list@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/ltp-list
