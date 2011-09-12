Return-Path: <ltp-list-bounces@lists.sourceforge.net>
Received: from sog-mx-1.v43.ch3.sourceforge.com ([172.29.43.191]
	helo=mx.sourceforge.net)
	by sfs-ml-2.v29.ch3.sourceforge.com with esmtp (Exim 4.76)
	(envelope-from <rnsastry@linux.vnet.ibm.com>) id 1R356p-0001Qs-8f
	for ltp-list@lists.sourceforge.net; Mon, 12 Sep 2011 11:55:31 +0000
Received: from e23smtp05.au.ibm.com ([202.81.31.147])
	by sog-mx-1.v43.ch3.sourceforge.com with esmtps (TLSv1:AES256-SHA:256)
	(Exim 4.76) id 1R356o-0007C5-6n
	for ltp-list@lists.sourceforge.net; Mon, 12 Sep 2011 11:55:31 +0000
Received: from d23relay03.au.ibm.com (d23relay03.au.ibm.com [202.81.31.245])
	by e23smtp05.au.ibm.com (8.14.4/8.13.1) with ESMTP id p8CBmdAl002651
	for <ltp-list@lists.sourceforge.net>; Mon, 12 Sep 2011 21:48:39 +1000
Received: from d23av02.au.ibm.com (d23av02.au.ibm.com [9.190.235.138])
	by d23relay03.au.ibm.com (8.13.8/8.13.8/NCO v10.0) with ESMTP id
	p8CBtNvm1630426
	for <ltp-list@lists.sourceforge.net>; Mon, 12 Sep 2011 21:55:23 +1000
Received: from d23av02.au.ibm.com (loopback [127.0.0.1])
	by d23av02.au.ibm.com (8.14.4/8.13.1/NCO v10.0 AVout) with ESMTP id
	p8CBtNFi012648
	for <ltp-list@lists.sourceforge.net>; Mon, 12 Sep 2011 21:55:23 +1000
Received: from [127.0.0.1] ([9.79.197.179])
	by d23av02.au.ibm.com (8.14.4/8.13.1/NCO v10.0 AVin) with ESMTP id
	p8CBtJm2012608
	for <ltp-list@lists.sourceforge.net>; Mon, 12 Sep 2011 21:55:22 +1000
Message-ID: <4E6DF327.7070908@linux.vnet.ibm.com>
Date: Mon, 12 Sep 2011 17:25:19 +0530
From: Nageswara R Sastry <rnsastry@linux.vnet.ibm.com>
MIME-Version: 1.0
Content-Type: multipart/mixed; boundary="------------070408060701090108060702"
Subject: [LTP] [Patch v6 3/4] KSM test case fixes - mmap10
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
--------------070408060701090108060702
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit

Disable mmap10 test if KSM is not configured

P.S. patch checked with 'checkpatch.pl'

# ./mmap10 -s
mmap10      1  TCONF  :  KSM configuration is not enabled
mmap10      2  TCONF  :  Remaining cases not appropriate for configuration


Signed-off-by: Nageswara R Sastry <rnsastry@linux.vnet.ibm.com>

-- 
Regards
R.Nageswara Sastry


--------------070408060701090108060702
Content-Type: text/plain;
 name="mmap10.patch"
Content-Transfer-Encoding: 7bit
Content-Disposition: attachment;
 filename="mmap10.patch"

--- ltp.orig/testcases/kernel/syscalls/mmap/mmap10.c	2011-09-08 11:32:12.000000000 +0200
+++ ltp/testcases/kernel/syscalls/mmap/mmap10.c	2011-09-12 13:52:57.000000000 +0200
@@ -64,6 +64,7 @@
 #include "config.h"
 
 #define SIZE (5*1024*1024)
+#define PATH_KSM "/sys/kernel/mm/ksm/"
 
 char *TCID = "mmap10";
 int TST_TOTAL = 1;
@@ -94,6 +95,8 @@ int main(int argc, char *argv[])
 
 	if (opt_ksm)
 	{
+		if (access(PATH_KSM, F_OK) == -1)
+			tst_brkm(TCONF, NULL, "KSM configuration is not enabled");
 #ifdef HAVE_MADV_MERGEABLE
 		tst_resm(TINFO, "add to KSM regions.");
 #else

--------------070408060701090108060702
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
--------------070408060701090108060702
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
Ltp-list mailing list
Ltp-list@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/ltp-list

--------------070408060701090108060702--


