Return-Path: <ltp-list-bounces@lists.sourceforge.net>
Received: from sog-mx-2.v43.ch3.sourceforge.com ([172.29.43.192]
	helo=mx.sourceforge.net)
	by sfs-ml-1.v29.ch3.sourceforge.com with esmtp (Exim 4.76)
	(envelope-from <rnsastry@linux.vnet.ibm.com>) id 1R0ub2-0003wO-Oj
	for ltp-list@lists.sourceforge.net; Tue, 06 Sep 2011 12:17:44 +0000
Received: from e23smtp09.au.ibm.com ([202.81.31.142])
	by sog-mx-2.v43.ch3.sourceforge.com with esmtps (TLSv1:AES256-SHA:256)
	(Exim 4.76) id 1R0ub1-0004Ph-LY
	for ltp-list@lists.sourceforge.net; Tue, 06 Sep 2011 12:17:44 +0000
Received: from /spool/local by au.ibm.com with XMail ESMTP
	for <ltp-list@lists.sourceforge.net> from <rnsastry@linux.vnet.ibm.com>;
	Tue, 6 Sep 2011 13:14:14 +1000
Received: from d23av03.au.ibm.com (d23av03.au.ibm.com [9.190.234.97])
	by d23relay05.au.ibm.com (8.13.8/8.13.8/NCO v10.0) with ESMTP id
	p86CFvWQ1065054
	for <ltp-list@lists.sourceforge.net>; Tue, 6 Sep 2011 22:15:57 +1000
Received: from d23av03.au.ibm.com (loopback [127.0.0.1])
	by d23av03.au.ibm.com (8.14.4/8.13.1/NCO v10.0 AVout) with ESMTP id
	p86CHXDL009513
	for <ltp-list@lists.sourceforge.net>; Tue, 6 Sep 2011 22:17:33 +1000
Received: from [127.0.0.1] ([9.77.196.21])
	by d23av03.au.ibm.com (8.14.4/8.13.1/NCO v10.0 AVin) with ESMTP id
	p86CHTYo009471
	for <ltp-list@lists.sourceforge.net>; Tue, 6 Sep 2011 22:17:32 +1000
Message-ID: <4E660F57.6050608@linux.vnet.ibm.com>
Date: Tue, 06 Sep 2011 17:47:27 +0530
From: Nageswara R Sastry <rnsastry@linux.vnet.ibm.com>
MIME-Version: 1.0
Content-Type: multipart/mixed; boundary="------------000504060708050702080802"
Subject: [LTP] [Patch v2 1/4] KSM test case fixes - ksm01
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
--------------000504060708050702080802
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit

Thanks Casper. Used macro 'PATH_KSM' and removed braces. And tested the 
same.

ksm01, ksm01_1:
Before patch:
...
ksm01       0  TINFO  :  KSM merging...
ksm01       1  TBROK  :  open: errno=ENOENT(2): No such file or directory
ksm01       2  TBROK  :  Remaining cases broken
...

After patch:
...
ksm01       1  TCONF  :  KSM configuration is not enabled
ksm01       2  TCONF  :  Remaining cases not appropriate for configuration
...

Signed-off-by: Nageswara R Sastry <rnsastry@linux.vnet.ibm.com>

-- 
Regards
R.Nageswara Sastry


--------------000504060708050702080802
Content-Type: text/plain;
 name="ksm01.patch"
Content-Transfer-Encoding: 7bit
Content-Disposition: attachment;
 filename="ksm01.patch"

--- ltp.orig/testcases/kernel/mem/ksm/ksm01.c	2011-09-05 08:42:12.000000000 +0200
+++ ltp/testcases/kernel/mem/ksm/ksm01.c	2011-09-06 13:48:56.000000000 +0200
@@ -109,6 +109,8 @@ void setup(void)
 
 	tst_sig(FORK, DEF_HANDLER, NULL);
 	TEST_PAUSE;
+        if( access( PATH_KSM, F_OK ) == -1 )
+                tst_brkm(TCONF, NULL, "KSM configuration is not enabled");
 }
 
 void cleanup(void)

--------------000504060708050702080802
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
--------------000504060708050702080802
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
Ltp-list mailing list
Ltp-list@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/ltp-list

--------------000504060708050702080802--


