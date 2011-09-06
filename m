Return-Path: <ltp-list-bounces@lists.sourceforge.net>
Received: from sog-mx-4.v43.ch3.sourceforge.com ([172.29.43.194]
	helo=mx.sourceforge.net)
	by sfs-ml-4.v29.ch3.sourceforge.com with esmtp (Exim 4.76)
	(envelope-from <rnsastry@linux.vnet.ibm.com>) id 1R0vHm-00057T-7I
	for ltp-list@lists.sourceforge.net; Tue, 06 Sep 2011 13:01:54 +0000
Received: from e23smtp04.au.ibm.com ([202.81.31.146])
	by sog-mx-4.v43.ch3.sourceforge.com with esmtps (TLSv1:AES256-SHA:256)
	(Exim 4.76) id 1R0vHi-0002x8-9d
	for ltp-list@lists.sourceforge.net; Tue, 06 Sep 2011 13:01:54 +0000
Received: from d23relay05.au.ibm.com (d23relay05.au.ibm.com [202.81.31.247])
	by e23smtp04.au.ibm.com (8.14.4/8.13.1) with ESMTP id p86Ct93x011350
	for <ltp-list@lists.sourceforge.net>; Tue, 6 Sep 2011 22:55:09 +1000
Received: from d23av03.au.ibm.com (d23av03.au.ibm.com [9.190.234.97])
	by d23relay05.au.ibm.com (8.13.8/8.13.8/NCO v10.0) with ESMTP id
	p86D07fH565378
	for <ltp-list@lists.sourceforge.net>; Tue, 6 Sep 2011 23:00:07 +1000
Received: from d23av03.au.ibm.com (loopback [127.0.0.1])
	by d23av03.au.ibm.com (8.14.4/8.13.1/NCO v10.0 AVout) with ESMTP id
	p86D1hu0015192
	for <ltp-list@lists.sourceforge.net>; Tue, 6 Sep 2011 23:01:43 +1000
Received: from [127.0.0.1] ([9.77.196.21])
	by d23av03.au.ibm.com (8.14.4/8.13.1/NCO v10.0 AVin) with ESMTP id
	p86D1e6M015131
	for <ltp-list@lists.sourceforge.net>; Tue, 6 Sep 2011 23:01:42 +1000
Message-ID: <4E6619B3.5080306@linux.vnet.ibm.com>
Date: Tue, 06 Sep 2011 18:31:39 +0530
From: Nageswara R Sastry <rnsastry@linux.vnet.ibm.com>
MIME-Version: 1.0
Content-Type: multipart/mixed; boundary="------------050703090507020906080207"
Subject: [LTP] [Patch v3 2/4] KSM test case fixes - ksm03
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
--------------050703090507020906080207
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit

Fixed format issues.

Signed-off-by: Nageswara R Sastry <rnsastry@linux.vnet.ibm.com>

-- 
Regards
R.Nageswara Sastry


--------------050703090507020906080207
Content-Type: text/plain;
 name="ksm03.patch"
Content-Transfer-Encoding: 7bit
Content-Disposition: attachment;
 filename="ksm03.patch"

--- ltp.orig/testcases/kernel/mem/ksm/ksm03.c	2011-09-05 08:42:12.000000000 +0200
+++ ltp/testcases/kernel/mem/ksm/ksm03.c	2011-09-06 14:49:53.000000000 +0200
@@ -107,6 +107,8 @@ void setup(void)
 
 	if (tst_kvercmp(2, 6, 32) < 0)
 		tst_brkm(TCONF, NULL, "2.6.32 or greater kernel required");
+	if(access( PATH_KSM, F_OK ) == -1)
+		tst_brkm(TCONF, NULL, "KSM configuration is not enabled");
 
 	mount_mem("memcg", "cgroup", "memory", MEMCG_PATH, MEMCG_PATH_NEW);
 	tst_sig(FORK, DEF_HANDLER, NULL);

--------------050703090507020906080207
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
--------------050703090507020906080207
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
Ltp-list mailing list
Ltp-list@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/ltp-list

--------------050703090507020906080207--


