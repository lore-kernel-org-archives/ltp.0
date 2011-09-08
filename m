Return-Path: <ltp-list-bounces@lists.sourceforge.net>
Received: from sog-mx-3.v43.ch3.sourceforge.com ([172.29.43.193]
	helo=mx.sourceforge.net)
	by sfs-ml-2.v29.ch3.sourceforge.com with esmtp (Exim 4.76)
	(envelope-from <rnsastry@linux.vnet.ibm.com>) id 1R1bIw-0001WM-9J
	for ltp-list@lists.sourceforge.net; Thu, 08 Sep 2011 09:53:54 +0000
Received: from e28smtp06.in.ibm.com ([122.248.162.6])
	by sog-mx-3.v43.ch3.sourceforge.com with esmtps (TLSv1:AES256-SHA:256)
	(Exim 4.76) id 1R1bIv-00080N-74
	for ltp-list@lists.sourceforge.net; Thu, 08 Sep 2011 09:53:54 +0000
Received: from d28relay01.in.ibm.com (d28relay01.in.ibm.com [9.184.220.58])
	by e28smtp06.in.ibm.com (8.14.4/8.13.1) with ESMTP id p889rj7M028881
	for <ltp-list@lists.sourceforge.net>; Thu, 8 Sep 2011 15:23:45 +0530
Received: from d28av02.in.ibm.com (d28av02.in.ibm.com [9.184.220.64])
	by d28relay01.in.ibm.com (8.13.8/8.13.8/NCO v10.0) with ESMTP id
	p889rjP83256494
	for <ltp-list@lists.sourceforge.net>; Thu, 8 Sep 2011 15:23:45 +0530
Received: from d28av02.in.ibm.com (loopback [127.0.0.1])
	by d28av02.in.ibm.com (8.14.4/8.13.1/NCO v10.0 AVout) with ESMTP id
	p889rjHp015258
	for <ltp-list@lists.sourceforge.net>; Thu, 8 Sep 2011 19:53:45 +1000
Received: from [127.0.0.1] ([9.124.46.53])
	by d28av02.in.ibm.com (8.14.4/8.13.1/NCO v10.0 AVin) with ESMTP id
	p889rjhJ015215
	for <ltp-list@lists.sourceforge.net>; Thu, 8 Sep 2011 19:53:45 +1000
Message-ID: <4E6890A9.8020405@linux.vnet.ibm.com>
Date: Thu, 08 Sep 2011 15:23:45 +0530
From: Nageswara R Sastry <rnsastry@linux.vnet.ibm.com>
MIME-Version: 1.0
Content-Type: multipart/mixed; boundary="------------060600030703060702020001"
Subject: [LTP] [Patch v4 4/4] KSM test case fixes - oom01 and oom03
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
--------------060600030703060702020001
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit

Disable oom01, oom03 tests if KSM is not configured

P.S. patch checked with 'checkpatch.pl'

Signed-off-by: Nageswara R Sastry <rnsastry@linux.vnet.ibm.com>

-- 
Regards
R.Nageswara Sastry


--------------060600030703060702020001
Content-Type: text/plain;
 name="mem.patch"
Content-Transfer-Encoding: 7bit
Content-Disposition: attachment;
 filename="mem.patch"

--- ltp.orig/testcases/kernel/mem/lib/mem.c	2011-09-08 11:32:12.000000000 +0200
+++ ltp/testcases/kernel/mem/lib/mem.c	2011-09-08 11:44:30.000000000 +0200
@@ -139,6 +139,9 @@ void testoom(int mempolicy, int lite, in
 	tst_resm(TINFO, "start OOM testing for mlocked pages.");
 	oom(MLOCK, mempolicy, lite);
 
+	if (access(PATH_KSM, F_OK) == -1)
+		tst_brkm(TCONF, NULL, "KSM configuration is not enabled");
+
 	tst_resm(TINFO, "start OOM testing for KSM pages.");
 	oom(KSM, mempolicy, lite);
 }

--------------060600030703060702020001
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
--------------060600030703060702020001
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
Ltp-list mailing list
Ltp-list@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/ltp-list

--------------060600030703060702020001--


