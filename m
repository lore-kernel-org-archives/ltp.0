Return-Path: <ltp-list-bounces@lists.sourceforge.net>
Received: from sog-mx-1.v43.ch3.sourceforge.com ([172.29.43.191]
	helo=mx.sourceforge.net)
	by sfs-ml-3.v29.ch3.sourceforge.com with esmtp (Exim 4.76)
	(envelope-from <rnsastry@linux.vnet.ibm.com>) id 1R0udg-00016E-Qt
	for ltp-list@lists.sourceforge.net; Tue, 06 Sep 2011 12:20:28 +0000
Received: from e23smtp09.au.ibm.com ([202.81.31.142])
	by sog-mx-1.v43.ch3.sourceforge.com with esmtps (TLSv1:AES256-SHA:256)
	(Exim 4.76) id 1R0udc-0005u3-Pf
	for ltp-list@lists.sourceforge.net; Tue, 06 Sep 2011 12:20:28 +0000
Received: from /spool/local by au.ibm.com with XMail ESMTP
	for <ltp-list@lists.sourceforge.net> from <rnsastry@linux.vnet.ibm.com>;
	Tue, 6 Sep 2011 13:16:55 +1000
Received: from d23av03.au.ibm.com (d23av03.au.ibm.com [9.190.234.97])
	by d23relay05.au.ibm.com (8.13.8/8.13.8/NCO v10.0) with ESMTP id
	p86CIe9j413766
	for <ltp-list@lists.sourceforge.net>; Tue, 6 Sep 2011 22:18:40 +1000
Received: from d23av03.au.ibm.com (loopback [127.0.0.1])
	by d23av03.au.ibm.com (8.14.4/8.13.1/NCO v10.0 AVout) with ESMTP id
	p86CKFRA011407
	for <ltp-list@lists.sourceforge.net>; Tue, 6 Sep 2011 22:20:15 +1000
Received: from [127.0.0.1] ([9.77.196.21])
	by d23av03.au.ibm.com (8.14.4/8.13.1/NCO v10.0 AVin) with ESMTP id
	p86CKCVW011359
	for <ltp-list@lists.sourceforge.net>; Tue, 6 Sep 2011 22:20:14 +1000
Message-ID: <4E660FFC.9080900@linux.vnet.ibm.com>
Date: Tue, 06 Sep 2011 17:50:12 +0530
From: Nageswara R Sastry <rnsastry@linux.vnet.ibm.com>
MIME-Version: 1.0
Content-Type: multipart/mixed; boundary="------------020109010405060709070500"
Subject: [LTP] [Patch v2 3/4] KSM test case fixes - mmap10
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
--------------020109010405060709070500
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit

Thanks Casper. Used macro 'PATH_KSM' and removed braces. And tested the 
same.

mmap10_2:
Before patch:
...
mmap10      0  TINFO  :  add to KSM regions.
mmap10      0  TINFO  :  use /dev/zero.
mmap10      0  TINFO  :  start tests.
mmap10      1  TBROK  :  madvise: errno=EINVAL(22): Invalid argument
mmap10      2  TBROK  :  Remaining cases broken
...

After patch:
...
mmap10      1  TCONF  :  KSM configuration is not enabled
mmap10      2  TCONF  :  Remaining cases not appropriate for configuration
...


mmap10_3, mmap10_4, mmap10_5:
Before patch:
...
mmap10      0  TINFO  :  add to KSM regions.
mmap10      0  TINFO  :  use anonymous pages.
mmap10      0  TINFO  :  start tests.
mmap10      1  TBROK  :  madvise: errno=EINVAL(22): Invalid argument
mmap10      2  TBROK  :  Remaining cases broken
...

After patch:
...
mmap10      1  TCONF  :  KSM configuration is not enabled
mmap10      2  TCONF  :  Remaining cases not appropriate for configuration
...

Signed-off-by: Nageswara R Sastry <rnsastry@linux.vnet.ibm.com>

-- 
Regards
R.Nageswara Sastry


--------------020109010405060709070500
Content-Type: text/plain;
 name="mmap10.patch"
Content-Transfer-Encoding: 7bit
Content-Disposition: attachment;
 filename="mmap10.patch"

--- ltp.orig/testcases/kernel/syscalls/mmap/mmap10.c	2011-09-05 08:42:12.000000000 +0200
+++ ltp/testcases/kernel/syscalls/mmap/mmap10.c	2011-09-06 14:10:23.000000000 +0200
@@ -62,6 +62,7 @@
 #include "test.h"
 #include "usctest.h"
 #include "config.h"
+#include "../../mem/include/mem.h"
 
 #define SIZE (5*1024*1024)
 
@@ -94,6 +95,8 @@ int main(int argc, char *argv[])
 
 	if (opt_ksm)
 	{
+		if( access( PATH_KSM, F_OK ) == -1 )
+			tst_brkm(TCONF, NULL, "KSM configuration is not enabled");
 #ifdef HAVE_MADV_MERGEABLE
 		tst_resm(TINFO, "add to KSM regions.");
 #else

--------------020109010405060709070500
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
--------------020109010405060709070500
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
Ltp-list mailing list
Ltp-list@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/ltp-list

--------------020109010405060709070500--


