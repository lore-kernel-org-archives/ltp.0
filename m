Return-Path: <ltp-list-bounces@lists.sourceforge.net>
Received: from sog-mx-2.v43.ch3.sourceforge.com ([172.29.43.192]
	helo=mx.sourceforge.net)
	by sfs-ml-4.v29.ch3.sourceforge.com with esmtp (Exim 4.76)
	(envelope-from <rnsastry@linux.vnet.ibm.com>) id 1R0vIf-0005Ag-ET
	for ltp-list@lists.sourceforge.net; Tue, 06 Sep 2011 13:02:49 +0000
Received: from e23smtp06.au.ibm.com ([202.81.31.148])
	by sog-mx-2.v43.ch3.sourceforge.com with esmtps (TLSv1:AES256-SHA:256)
	(Exim 4.76) id 1R0vIZ-0006X4-OA
	for ltp-list@lists.sourceforge.net; Tue, 06 Sep 2011 13:02:49 +0000
Received: from d23relay03.au.ibm.com (d23relay03.au.ibm.com [202.81.31.245])
	by e23smtp06.au.ibm.com (8.14.4/8.13.1) with ESMTP id p86D1ak4011220
	for <ltp-list@lists.sourceforge.net>; Tue, 6 Sep 2011 23:01:36 +1000
Received: from d23av03.au.ibm.com (d23av03.au.ibm.com [9.190.234.97])
	by d23relay03.au.ibm.com (8.13.8/8.13.8/NCO v10.0) with ESMTP id
	p86D2aak868574
	for <ltp-list@lists.sourceforge.net>; Tue, 6 Sep 2011 23:02:36 +1000
Received: from d23av03.au.ibm.com (loopback [127.0.0.1])
	by d23av03.au.ibm.com (8.14.4/8.13.1/NCO v10.0 AVout) with ESMTP id
	p86D2aNL016206
	for <ltp-list@lists.sourceforge.net>; Tue, 6 Sep 2011 23:02:36 +1000
Received: from [127.0.0.1] ([9.77.196.21])
	by d23av03.au.ibm.com (8.14.4/8.13.1/NCO v10.0 AVin) with ESMTP id
	p86D2YL1016186
	for <ltp-list@lists.sourceforge.net>; Tue, 6 Sep 2011 23:02:35 +1000
Message-ID: <4E6619E9.9060400@linux.vnet.ibm.com>
Date: Tue, 06 Sep 2011 18:32:33 +0530
From: Nageswara R Sastry <rnsastry@linux.vnet.ibm.com>
MIME-Version: 1.0
Content-Type: multipart/mixed; boundary="------------090407070307040300000906"
Subject: [LTP] [Patch v3 3/4] KSM test case fixes - mmap10
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
--------------090407070307040300000906
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit

Fixed format issues.

Signed-off-by: Nageswara R Sastry <rnsastry@linux.vnet.ibm.com>

-- 
Regards
R.Nageswara Sastry


--------------090407070307040300000906
Content-Type: text/plain;
 name="mmap10.patch"
Content-Transfer-Encoding: 7bit
Content-Disposition: attachment;
 filename="mmap10.patch"

--- ltp.orig/testcases/kernel/syscalls/mmap/mmap10.c	2011-09-05 08:42:12.000000000 +0200
+++ ltp/testcases/kernel/syscalls/mmap/mmap10.c	2011-09-06 14:50:28.000000000 +0200
@@ -62,6 +62,7 @@
 #include "test.h"
 #include "usctest.h"
 #include "config.h"
+#include "../../mem/include/mem.h"
 
 #define SIZE (5*1024*1024)
 
@@ -94,6 +95,8 @@ int main(int argc, char *argv[])
 
 	if (opt_ksm)
 	{
+		if(access( PATH_KSM, F_OK ) == -1)
+			tst_brkm(TCONF, NULL, "KSM configuration is not enabled");
 #ifdef HAVE_MADV_MERGEABLE
 		tst_resm(TINFO, "add to KSM regions.");
 #else

--------------090407070307040300000906
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
--------------090407070307040300000906
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
Ltp-list mailing list
Ltp-list@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/ltp-list

--------------090407070307040300000906--


