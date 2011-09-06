Return-Path: <ltp-list-bounces@lists.sourceforge.net>
Received: from sog-mx-4.v43.ch3.sourceforge.com ([172.29.43.194]
	helo=mx.sourceforge.net)
	by sfs-ml-2.v29.ch3.sourceforge.com with esmtp (Exim 4.76)
	(envelope-from <rnsastry@linux.vnet.ibm.com>) id 1R0uei-0000U8-7T
	for ltp-list@lists.sourceforge.net; Tue, 06 Sep 2011 12:21:32 +0000
Received: from e23smtp05.au.ibm.com ([202.81.31.147])
	by sog-mx-4.v43.ch3.sourceforge.com with esmtps (TLSv1:AES256-SHA:256)
	(Exim 4.76) id 1R0uef-000129-NT
	for ltp-list@lists.sourceforge.net; Tue, 06 Sep 2011 12:21:32 +0000
Received: from d23relay03.au.ibm.com (d23relay03.au.ibm.com [202.81.31.245])
	by e23smtp05.au.ibm.com (8.14.4/8.13.1) with ESMTP id p86CEeAf027119
	for <ltp-list@lists.sourceforge.net>; Tue, 6 Sep 2011 22:14:40 +1000
Received: from d23av03.au.ibm.com (d23av03.au.ibm.com [9.190.234.97])
	by d23relay03.au.ibm.com (8.13.8/8.13.8/NCO v10.0) with ESMTP id
	p86CLMt61581240
	for <ltp-list@lists.sourceforge.net>; Tue, 6 Sep 2011 22:21:22 +1000
Received: from d23av03.au.ibm.com (loopback [127.0.0.1])
	by d23av03.au.ibm.com (8.14.4/8.13.1/NCO v10.0 AVout) with ESMTP id
	p86CLMGA012881
	for <ltp-list@lists.sourceforge.net>; Tue, 6 Sep 2011 22:21:22 +1000
Received: from [127.0.0.1] ([9.77.196.21])
	by d23av03.au.ibm.com (8.14.4/8.13.1/NCO v10.0 AVin) with ESMTP id
	p86CLJYW012852
	for <ltp-list@lists.sourceforge.net>; Tue, 6 Sep 2011 22:21:21 +1000
Message-ID: <4E66103E.1040408@linux.vnet.ibm.com>
Date: Tue, 06 Sep 2011 17:51:18 +0530
From: Nageswara R Sastry <rnsastry@linux.vnet.ibm.com>
MIME-Version: 1.0
Content-Type: multipart/mixed; boundary="------------040408070906010901090602"
Subject: [LTP] [Patch v2 4/4] KSM test case fixes - oom01 and oom03
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
--------------040408070906010901090602
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit

Thanks Casper. Used macro 'PATH_KSM' and removed braces. And tested the 
same.

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


--------------040408070906010901090602
Content-Type: text/plain;
 name="mem.patch"
Content-Transfer-Encoding: 7bit
Content-Disposition: attachment;
 filename="mem.patch"

--- ltp.orig/testcases/kernel/mem/lib/mem.c	2011-09-05 08:42:12.000000000 +0200
+++ ltp/testcases/kernel/mem/lib/mem.c	2011-09-06 13:52:37.000000000 +0200
@@ -139,6 +139,9 @@ void testoom(int mempolicy, int lite, in
 	tst_resm(TINFO, "start OOM testing for mlocked pages.");
 	oom(MLOCK, mempolicy, lite);
 
+	if( access( PATH_KSM, F_OK ) == -1 )
+		tst_brkm(TCONF, NULL, "KSM configuration is not enabled");
+
 	tst_resm(TINFO, "start OOM testing for KSM pages.");
 	oom(KSM, mempolicy, lite);
 }

--------------040408070906010901090602
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
--------------040408070906010901090602
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
Ltp-list mailing list
Ltp-list@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/ltp-list

--------------040408070906010901090602--


