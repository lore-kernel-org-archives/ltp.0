Return-Path: <ltp-list-bounces@lists.sourceforge.net>
Received: from sog-mx-4.v43.ch3.sourceforge.com ([172.29.43.194]
	helo=mx.sourceforge.net)
	by sfs-ml-3.v29.ch3.sourceforge.com with esmtp (Exim 4.76)
	(envelope-from <rnsastry@linux.vnet.ibm.com>) id 1R0vJJ-00034P-62
	for ltp-list@lists.sourceforge.net; Tue, 06 Sep 2011 13:03:29 +0000
Received: from e23smtp06.au.ibm.com ([202.81.31.148])
	by sog-mx-4.v43.ch3.sourceforge.com with esmtps (TLSv1:AES256-SHA:256)
	(Exim 4.76) id 1R0vJD-000323-Ir
	for ltp-list@lists.sourceforge.net; Tue, 06 Sep 2011 13:03:29 +0000
Received: from d23relay04.au.ibm.com (d23relay04.au.ibm.com [202.81.31.246])
	by e23smtp06.au.ibm.com (8.14.4/8.13.1) with ESMTP id p86D2Gnp011459
	for <ltp-list@lists.sourceforge.net>; Tue, 6 Sep 2011 23:02:16 +1000
Received: from d23av03.au.ibm.com (d23av03.au.ibm.com [9.190.234.97])
	by d23relay04.au.ibm.com (8.13.8/8.13.8/NCO v10.0) with ESMTP id
	p86D1h0v1237102
	for <ltp-list@lists.sourceforge.net>; Tue, 6 Sep 2011 23:01:43 +1000
Received: from d23av03.au.ibm.com (loopback [127.0.0.1])
	by d23av03.au.ibm.com (8.14.4/8.13.1/NCO v10.0 AVout) with ESMTP id
	p86D3GWi016613
	for <ltp-list@lists.sourceforge.net>; Tue, 6 Sep 2011 23:03:16 +1000
Received: from [127.0.0.1] ([9.77.196.21])
	by d23av03.au.ibm.com (8.14.4/8.13.1/NCO v10.0 AVin) with ESMTP id
	p86D3DC8016583
	for <ltp-list@lists.sourceforge.net>; Tue, 6 Sep 2011 23:03:15 +1000
Message-ID: <4E661A10.9080000@linux.vnet.ibm.com>
Date: Tue, 06 Sep 2011 18:33:12 +0530
From: Nageswara R Sastry <rnsastry@linux.vnet.ibm.com>
MIME-Version: 1.0
Content-Type: multipart/mixed; boundary="------------080101030507060207070409"
Subject: [LTP] [Patch v3 4/4] KSM test case fixes - oom01 and oom03
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
--------------080101030507060207070409
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit

Fixed format issues.

Signed-off-by: Nageswara R Sastry <rnsastry@linux.vnet.ibm.com>

-- 
Regards
R.Nageswara Sastry


--------------080101030507060207070409
Content-Type: text/plain;
 name="mem.patch"
Content-Transfer-Encoding: 7bit
Content-Disposition: attachment;
 filename="mem.patch"

--- ltp.orig/testcases/kernel/mem/lib/mem.c	2011-09-05 08:42:12.000000000 +0200
+++ ltp/testcases/kernel/mem/lib/mem.c	2011-09-06 14:50:51.000000000 +0200
@@ -139,6 +139,9 @@ void testoom(int mempolicy, int lite, in
 	tst_resm(TINFO, "start OOM testing for mlocked pages.");
 	oom(MLOCK, mempolicy, lite);
 
+	if(access( PATH_KSM, F_OK ) == -1)
+		tst_brkm(TCONF, NULL, "KSM configuration is not enabled");
+
 	tst_resm(TINFO, "start OOM testing for KSM pages.");
 	oom(KSM, mempolicy, lite);
 }

--------------080101030507060207070409
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
--------------080101030507060207070409
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
Ltp-list mailing list
Ltp-list@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/ltp-list

--------------080101030507060207070409--


