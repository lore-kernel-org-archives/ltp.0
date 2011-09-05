Return-Path: <ltp-list-bounces@lists.sourceforge.net>
Received: from sog-mx-4.v43.ch3.sourceforge.com ([172.29.43.194]
	helo=mx.sourceforge.net)
	by sfs-ml-1.v29.ch3.sourceforge.com with esmtp (Exim 4.76)
	(envelope-from <rnsastry@linux.vnet.ibm.com>) id 1R0WGy-0000s3-Qt
	for ltp-list@lists.sourceforge.net; Mon, 05 Sep 2011 10:19:24 +0000
Received: from e23smtp09.au.ibm.com ([202.81.31.142])
	by sog-mx-4.v43.ch3.sourceforge.com with esmtps (TLSv1:AES256-SHA:256)
	(Exim 4.76) id 1R0WGv-0003D0-Ds
	for ltp-list@lists.sourceforge.net; Mon, 05 Sep 2011 10:19:24 +0000
Received: from /spool/local by au.ibm.com with XMail ESMTP
	for <ltp-list@lists.sourceforge.net> from <rnsastry@linux.vnet.ibm.com>;
	Mon, 5 Sep 2011 11:15:54 +1000
Received: from d23av02.au.ibm.com (d23av02.au.ibm.com [9.190.235.138])
	by d23relay03.au.ibm.com (8.13.8/8.13.8/NCO v10.0) with ESMTP id
	p85AHui81691786
	for <ltp-list@lists.sourceforge.net>; Mon, 5 Sep 2011 20:17:56 +1000
Received: from d23av02.au.ibm.com (loopback [127.0.0.1])
	by d23av02.au.ibm.com (8.14.4/8.13.1/NCO v10.0 AVout) with ESMTP id
	p85AHuho003934
	for <ltp-list@lists.sourceforge.net>; Mon, 5 Sep 2011 20:17:56 +1000
Received: from [127.0.0.1] ([9.124.33.206])
	by d23av02.au.ibm.com (8.14.4/8.13.1/NCO v10.0 AVin) with ESMTP id
	p85AHsax003574
	for <ltp-list@lists.sourceforge.net>; Mon, 5 Sep 2011 20:17:55 +1000
Message-ID: <4E64A1D2.3070701@linux.vnet.ibm.com>
Date: Mon, 05 Sep 2011 15:47:54 +0530
From: Nageswara R Sastry <rnsastry@linux.vnet.ibm.com>
MIME-Version: 1.0
Content-Type: multipart/mixed; boundary="------------020408080503010703010002"
Subject: [LTP] [Patch 2/4] KSM test case fixes - ksm03
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
--------------020408080503010703010002
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit

While setting up the environment, checking whether ksm related directory 
exists in sysfs or not.

ksm03, ksm03_1:
Before patch:
...
ksm03       0  TINFO  :  KSM merging...
ksm03       1  TBROK  :  open: errno=ENOENT(2): No such file or directory
ksm03       2  TBROK  :  Remaining cases broken
ksm03       0  TINFO  :  child 1 stops.
ksm03       1  TBROK  :  unexpected signal 1 received (pid = 46142).
ksm03       2  TBROK  :  Remaining cases broken
...

After patch:
...
ksm03       1  TCONF  :  KSM configuration is not enabled
ksm03       2  TCONF  :  Remaining cases not appropriate for configuration
...

Signed-off-by: Nageswara R Sastry <rnsastry@linux.vnet.ibm.com>

-- 
Regards
R.Nageswara Sastry


--------------020408080503010703010002
Content-Type: text/plain;
 name="ksm03.patch"
Content-Transfer-Encoding: 7bit
Content-Disposition: attachment;
 filename="ksm03.patch"

--- ltp.orig/testcases/kernel/mem/ksm/ksm03.c	2011-09-05 08:42:12.000000000 +0200
+++ ltp/testcases/kernel/mem/ksm/ksm03.c	2011-09-05 08:45:47.000000000 +0200
@@ -111,6 +111,12 @@ void setup(void)
 	mount_mem("memcg", "cgroup", "memory", MEMCG_PATH, MEMCG_PATH_NEW);
 	tst_sig(FORK, DEF_HANDLER, NULL);
 	TEST_PAUSE;
+
+	char *fname = "/sys/kernel/mm/ksm/";
+
+        if( access( fname, F_OK ) == -1 ) {
+                tst_brkm(TCONF, NULL, "KSM configuration is not enabled");
+        }
 }
 
 void cleanup(void)

--------------020408080503010703010002
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
--------------020408080503010703010002
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
Ltp-list mailing list
Ltp-list@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/ltp-list

--------------020408080503010703010002--


