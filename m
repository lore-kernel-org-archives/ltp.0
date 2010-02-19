Return-Path: <ltp-list-bounces@lists.sourceforge.net>
Received: from sfi-mx-3.v28.ch3.sourceforge.com ([172.29.28.123]
	helo=mx.sourceforge.net)
	by sfs-ml-2.v29.ch3.sourceforge.com with esmtp (Exim 4.69)
	(envelope-from <subrata@linux.vnet.ibm.com>) id 1NiSTj-00050g-KM
	for ltp-list@lists.sourceforge.net; Fri, 19 Feb 2010 13:01:07 +0000
Received: from e32.co.us.ibm.com ([32.97.110.150])
	by sfi-mx-3.v28.ch3.sourceforge.com with esmtps (TLSv1:AES256-SHA:256)
	(Exim 4.69) id 1NiSTh-0005NR-C2
	for ltp-list@lists.sourceforge.net; Fri, 19 Feb 2010 13:01:07 +0000
Received: from d03relay05.boulder.ibm.com (d03relay05.boulder.ibm.com
	[9.17.195.107])
	by e32.co.us.ibm.com (8.14.3/8.13.1) with ESMTP id o1JCT0wm023634
	for <ltp-list@lists.sourceforge.net>; Fri, 19 Feb 2010 05:29:00 -0700
Received: from d03av06.boulder.ibm.com (d03av06.boulder.ibm.com [9.17.195.245])
	by d03relay05.boulder.ibm.com (8.13.8/8.13.8/NCO v10.0) with ESMTP id
	o1JCZ42l126204
	for <ltp-list@lists.sourceforge.net>; Fri, 19 Feb 2010 05:35:04 -0700
Received: from d03av06.boulder.ibm.com (loopback [127.0.0.1])
	by d03av06.boulder.ibm.com (8.14.3/8.13.1/NCO v10.0 AVout) with ESMTP
	id o1JCbLeS000930
	for <ltp-list@lists.sourceforge.net>; Fri, 19 Feb 2010 05:37:22 -0700
From: Subrata Modak <subrata@linux.vnet.ibm.com>
Date: Fri, 19 Feb 2010 18:05:01 +0530
Message-Id: <20100219123501.19085.64668.sendpatchset@subratamodak.linux.ibm.com>
Subject: [LTP] [PATCH] Fix MSGCTL10() to avoid un-necessary cluttering of
	whole system with all PIDs
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
To: LTP Mailing List <ltp-list@lists.sourceforge.net>

Hi,

msgctl10() un-necessarily eats up all the PIDs of the system leading to
system becoming un-responsive. The changed no.s would better do the job.

Signed-off-by: Subrata Modak<subrata@linux.vnet.ibm.com>
---

--- ltp-full-20100131/testcases/kernel/syscalls/ipc/msgctl/msgctl10.c.orig	2010-02-19 17:59:23.000000000 +0530
+++ ltp-full-20100131/testcases/kernel/syscalls/ipc/msgctl/msgctl10.c	2010-02-19 18:01:13.000000000 +0530
@@ -65,12 +65,8 @@ extern int Tst_count;		/* Test Case coun
 
 int exp_enos[] = { 0 };		/* List must end with 0 */
 
-#ifndef CONFIG_COLDFIRE
-#define MAXNPROCS	1000000	/* This value is set to an arbitrary high limit. */
-#else
-#define MAXNPROCS	 100000	/* Coldfire can't deal with 1000000 */
-#endif
-#define MAXNREPS	100000
+#define MAXNPROCS	10000 	/*These should be sufficient*/
+#define MAXNREPS	10000	/*Else they srewup the system un-necessarily*/
 #define FAIL		1
 #define PASS		0
 

---
Regards--
Subrata


------------------------------------------------------------------------------
Download Intel&#174; Parallel Studio Eval
Try the new software tools for yourself. Speed compiling, find bugs
proactively, and fine-tune applications for parallel performance.
See why Intel Parallel Studio got high marks during beta.
http://p.sf.net/sfu/intel-sw-dev
_______________________________________________
Ltp-list mailing list
Ltp-list@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/ltp-list
