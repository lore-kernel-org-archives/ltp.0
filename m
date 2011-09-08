Return-Path: <ltp-list-bounces@lists.sourceforge.net>
Received: from sog-mx-1.v43.ch3.sourceforge.com ([172.29.43.191]
	helo=mx.sourceforge.net)
	by sfs-ml-1.v29.ch3.sourceforge.com with esmtp (Exim 4.76)
	(envelope-from <rnsastry@linux.vnet.ibm.com>) id 1R1bHB-0003YE-4V
	for ltp-list@lists.sourceforge.net; Thu, 08 Sep 2011 09:52:05 +0000
Received: from e28smtp05.in.ibm.com ([122.248.162.5])
	by sog-mx-1.v43.ch3.sourceforge.com with esmtps (TLSv1:AES256-SHA:256)
	(Exim 4.76) id 1R1bH3-0000aY-6f
	for ltp-list@lists.sourceforge.net; Thu, 08 Sep 2011 09:52:05 +0000
Received: from d28relay03.in.ibm.com (d28relay03.in.ibm.com [9.184.220.60])
	by e28smtp05.in.ibm.com (8.14.4/8.13.1) with ESMTP id p889pnLi001866
	for <ltp-list@lists.sourceforge.net>; Thu, 8 Sep 2011 15:21:49 +0530
Received: from d28av02.in.ibm.com (d28av02.in.ibm.com [9.184.220.64])
	by d28relay03.in.ibm.com (8.13.8/8.13.8/NCO v10.0) with ESMTP id
	p889oXmN4018372
	for <ltp-list@lists.sourceforge.net>; Thu, 8 Sep 2011 15:20:33 +0530
Received: from d28av02.in.ibm.com (loopback [127.0.0.1])
	by d28av02.in.ibm.com (8.14.4/8.13.1/NCO v10.0 AVout) with ESMTP id
	p889oXBE005932
	for <ltp-list@lists.sourceforge.net>; Thu, 8 Sep 2011 19:50:33 +1000
Received: from [127.0.0.1] ([9.124.46.53])
	by d28av02.in.ibm.com (8.14.4/8.13.1/NCO v10.0 AVin) with ESMTP id
	p889oWeu005881
	for <ltp-list@lists.sourceforge.net>; Thu, 8 Sep 2011 19:50:32 +1000
Message-ID: <4E688FE8.5020701@linux.vnet.ibm.com>
Date: Thu, 08 Sep 2011 15:20:32 +0530
From: Nageswara R Sastry <rnsastry@linux.vnet.ibm.com>
MIME-Version: 1.0
Content-Type: multipart/mixed; boundary="------------080109020601050007090803"
Subject: [LTP] [Patch v4 1/4] KSM test case fixes - ksm01
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
--------------080109020601050007090803
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit

Disable ksm01 test if KSM is not configured

P.S. patch checked with 'checkpatch.pl'

Signed-off-by: Nageswara R Sastry <rnsastry@linux.vnet.ibm.com>

-- 
Regards
R.Nageswara Sastry


--------------080109020601050007090803
Content-Type: text/plain;
 name="ksm01.patch"
Content-Transfer-Encoding: 7bit
Content-Disposition: attachment;
 filename="ksm01.patch"

--- ltp.orig/testcases/kernel/mem/ksm/ksm01.c	2011-09-08 11:32:12.000000000 +0200
+++ ltp/testcases/kernel/mem/ksm/ksm01.c	2011-09-08 11:35:56.000000000 +0200
@@ -106,6 +106,8 @@ void setup(void)
 
 	if (tst_kvercmp(2, 6, 32) < 0)
 		tst_brkm(TCONF, NULL, "2.6.32 or greater kernel required");
+	if (access(PATH_KSM, F_OK) == -1)
+		tst_brkm(TCONF, NULL, "KSM configuration is not enabled");
 
 	tst_sig(FORK, DEF_HANDLER, NULL);
 	TEST_PAUSE;

--------------080109020601050007090803
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

------------------------------------------------------------------------------
Doing More with Less: The Next Generation Virtual Desktop 
What are the key obstacles that have prevented many mid-market businesses
from deploying virtual desktops?   How do next-generation virtual desktops
provide companies an easier-to-deploy, easier-to-manage and more affordable
virtual desktop model.http://www.accelacomm.com/jaw/sfnl/114/51426474/
--------------080109020601050007090803
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
Ltp-list mailing list
Ltp-list@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/ltp-list

--------------080109020601050007090803--


