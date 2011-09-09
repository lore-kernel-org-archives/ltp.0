Return-Path: <ltp-list-bounces@lists.sourceforge.net>
Received: from sog-mx-1.v43.ch3.sourceforge.com ([172.29.43.191]
	helo=mx.sourceforge.net)
	by sfs-ml-1.v29.ch3.sourceforge.com with esmtp (Exim 4.76)
	(envelope-from <rnsastry@linux.vnet.ibm.com>) id 1R1tfH-0001z9-SD
	for ltp-list@lists.sourceforge.net; Fri, 09 Sep 2011 05:30:11 +0000
Received: from e23smtp07.au.ibm.com ([202.81.31.140])
	by sog-mx-1.v43.ch3.sourceforge.com with esmtps (TLSv1:AES256-SHA:256)
	(Exim 4.76) id 1R1tfG-00018w-N7
	for ltp-list@lists.sourceforge.net; Fri, 09 Sep 2011 05:30:11 +0000
Received: from d23relay05.au.ibm.com (d23relay05.au.ibm.com [202.81.31.247])
	by e23smtp07.au.ibm.com (8.14.4/8.13.1) with ESMTP id p895U3DR001959
	for <ltp-list@lists.sourceforge.net>; Fri, 9 Sep 2011 15:30:03 +1000
Received: from d23av03.au.ibm.com (d23av03.au.ibm.com [9.190.234.97])
	by d23relay05.au.ibm.com (8.13.8/8.13.8/NCO v10.0) with ESMTP id
	p895SO7p831740
	for <ltp-list@lists.sourceforge.net>; Fri, 9 Sep 2011 15:28:24 +1000
Received: from d23av03.au.ibm.com (loopback [127.0.0.1])
	by d23av03.au.ibm.com (8.14.4/8.13.1/NCO v10.0 AVout) with ESMTP id
	p895U3aF005014
	for <ltp-list@lists.sourceforge.net>; Fri, 9 Sep 2011 15:30:03 +1000
Received: from [127.0.0.1] ([9.124.46.47])
	by d23av03.au.ibm.com (8.14.4/8.13.1/NCO v10.0 AVin) with ESMTP id
	p895TwM0004602
	for <ltp-list@lists.sourceforge.net>; Fri, 9 Sep 2011 15:30:02 +1000
Message-ID: <4E69A455.7070908@linux.vnet.ibm.com>
Date: Fri, 09 Sep 2011 10:59:57 +0530
From: Nageswara R Sastry <rnsastry@linux.vnet.ibm.com>
MIME-Version: 1.0
Content-Type: multipart/mixed; boundary="------------020707060406090209020404"
Subject: [LTP] [Patch v5 3/4] KSM test case fixes - mmap10
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
--------------020707060406090209020404
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


--------------020707060406090209020404
Content-Type: text/plain;
 name="mmap10.patch"
Content-Transfer-Encoding: 7bit
Content-Disposition: attachment;
 filename="mmap10.patch"

--- ltp.orig/testcases/kernel/syscalls/mmap/mmap10.c	2011-09-08 11:32:12.000000000 +0200
+++ ltp/testcases/kernel/syscalls/mmap/mmap10.c	2011-09-09 07:22:35.000000000 +0200
@@ -62,6 +62,7 @@
 #include "test.h"
 #include "usctest.h"
 #include "config.h"
+#include "../../mem/include/mem.h"
 
 #define SIZE (5*1024*1024)
 
@@ -94,6 +95,8 @@ int main(int argc, char *argv[])
 
 	if (opt_ksm)
 	{
+		if (access(PATH_KSM, F_OK) == -1)
+			tst_brkm(TCONF, NULL, "KSM configuration is not enabled");
 #ifdef HAVE_MADV_MERGEABLE
 		tst_resm(TINFO, "add to KSM regions.");
 #else

--------------020707060406090209020404
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

------------------------------------------------------------------------------
Why Cloud-Based Security and Archiving Make Sense
Osterman Research conducted this study that outlines how and why cloud
computing security and archiving is rapidly being adopted across the IT 
space for its ease of implementation, lower cost, and increased 
reliability. Learn more. http://www.accelacomm.com/jaw/sfnl/114/51425301/
--------------020707060406090209020404
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
Ltp-list mailing list
Ltp-list@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/ltp-list

--------------020707060406090209020404--


