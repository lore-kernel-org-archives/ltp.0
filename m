Return-Path: <ltp-list-bounces@lists.sourceforge.net>
Received: from sog-mx-1.v43.ch3.sourceforge.com ([172.29.43.191]
	helo=mx.sourceforge.net)
	by sfs-ml-1.v29.ch3.sourceforge.com with esmtp (Exim 4.76)
	(envelope-from <rnsastry@linux.vnet.ibm.com>) id 1R0WFB-0000k8-Hm
	for ltp-list@lists.sourceforge.net; Mon, 05 Sep 2011 10:17:33 +0000
Received: from e23smtp07.au.ibm.com ([202.81.31.140])
	by sog-mx-1.v43.ch3.sourceforge.com with esmtps (TLSv1:AES256-SHA:256)
	(Exim 4.76) id 1R0WFA-0007OG-IL
	for ltp-list@lists.sourceforge.net; Mon, 05 Sep 2011 10:17:33 +0000
Received: from d23relay03.au.ibm.com (d23relay03.au.ibm.com [202.81.31.245])
	by e23smtp07.au.ibm.com (8.14.4/8.13.1) with ESMTP id p85AHP1o006181
	for <ltp-list@lists.sourceforge.net>; Mon, 5 Sep 2011 20:17:25 +1000
Received: from d23av02.au.ibm.com (d23av02.au.ibm.com [9.190.235.138])
	by d23relay03.au.ibm.com (8.13.8/8.13.8/NCO v10.0) with ESMTP id
	p85AHPYM1970254
	for <ltp-list@lists.sourceforge.net>; Mon, 5 Sep 2011 20:17:25 +1000
Received: from d23av02.au.ibm.com (loopback [127.0.0.1])
	by d23av02.au.ibm.com (8.14.4/8.13.1/NCO v10.0 AVout) with ESMTP id
	p85AHO7T002833
	for <ltp-list@lists.sourceforge.net>; Mon, 5 Sep 2011 20:17:24 +1000
Received: from [127.0.0.1] ([9.124.33.206])
	by d23av02.au.ibm.com (8.14.4/8.13.1/NCO v10.0 AVin) with ESMTP id
	p85AHMfH002476
	for <ltp-list@lists.sourceforge.net>; Mon, 5 Sep 2011 20:17:23 +1000
Message-ID: <4E64A1B2.1020401@linux.vnet.ibm.com>
Date: Mon, 05 Sep 2011 15:47:22 +0530
From: Nageswara R Sastry <rnsastry@linux.vnet.ibm.com>
MIME-Version: 1.0
Content-Type: multipart/mixed; boundary="------------090704040509020903050805"
Subject: [LTP] [Patch 4/4] KSM test case fixes - oom01 and oom03
List-Id: Linux Test Project General Discussions
	<ltp-list.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/ltp-list>,
	<mailto:ltp-list-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=ltp-list>
List-Post: <mailto:ltp-list@lists.sourceforge.net>
List-Help: <mailto:ltp-list-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/ltp-list>,
	<mailto:ltp-list-request@lists.sourceforge.net?subject=subscribe>
Errors-To: ltp-list-bounces@lists.sourceforge.net
To: ltp-list@lists.sourceforge.net

This is a multi-part message in MIME format.
--------------090704040509020903050805
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit

Before testing 'oom' with KSM pages - checking whether ksm related 
directory exists in sysfs or not.

oom01:
Before the patch:
...
oom01       0  TINFO  :  start OOM testing for KSM pages.
oom01       0  TINFO  :  allocating 3221225472 bytes.
oom01       1  TBROK  :  madvise: errno=EINVAL(22): Invalid argument
oom01       2  TBROK  :  Remaining cases broken
...

After the patch:
...
oom01       1  TCONF  :  KSM configuration is not enabled
oom01       2  TCONF  :  Remaining cases not appropriate for configuration
...

oom03
Before the patch:
...
oom03       0  TINFO  :  start OOM testing for KSM pages.
oom03       0  TINFO  :  expected victim is 46162.
oom03       1  TFAIL  :  the victim unexpectedly failed: 512
oom03       2  TBROK  :  open 46159: errno=ENOENT(2): No such file or 
directory
oom03       3  TBROK  :  Remaining cases broken
...

After the patch:
...
oom03       1  TCONF  :  KSM configuration is not enabled
oom03       2  TCONF  :  Remaining cases not appropriate for configuration
...

Signed-off-by: Nageswara R Sastry <rnsastry@linux.vnet.ibm.com>

-- 
Regards
R.Nageswara Sastry


--------------090704040509020903050805
Content-Type: text/plain;
 name="mem.patch"
Content-Transfer-Encoding: 7bit
Content-Disposition: attachment;
 filename="mem.patch"

--- ltp.orig/testcases/kernel/mem/lib/mem.c	2011-09-05 08:42:12.000000000 +0200
+++ ltp/testcases/kernel/mem/lib/mem.c	2011-09-05 08:50:27.000000000 +0200
@@ -139,6 +139,11 @@ void testoom(int mempolicy, int lite, in
 	tst_resm(TINFO, "start OOM testing for mlocked pages.");
 	oom(MLOCK, mempolicy, lite);
 
+        char *fname = "/sys/kernel/mm/ksm/";
+        if( access( fname, F_OK ) == -1 ) {
+                tst_brkm(TCONF, NULL, "KSM configuration is not enabled");
+        }
+
 	tst_resm(TINFO, "start OOM testing for KSM pages.");
 	oom(KSM, mempolicy, lite);
 }

--------------090704040509020903050805
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

------------------------------------------------------------------------------
Special Offer -- Download ArcSight Logger for FREE!
Finally, a world-class log management solution at an even better 
price-free! And you'll get a free "Love Thy Logs" t-shirt when you
download Logger. Secure your free ArcSight Logger TODAY!
http://p.sf.net/sfu/arcsisghtdev2dev
--------------090704040509020903050805
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
Ltp-list mailing list
Ltp-list@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/ltp-list

--------------090704040509020903050805--


