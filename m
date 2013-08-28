Return-Path: <ltp-list-bounces@lists.sourceforge.net>
Received: from sog-mx-1.v43.ch3.sourceforge.com ([172.29.43.191]
	helo=mx.sourceforge.net)
	by sfs-ml-3.v29.ch3.sourceforge.com with esmtp (Exim 4.76)
	(envelope-from <dave.kleikamp@oracle.com>) id 1VEfTC-00059C-22
	for ltp-list@lists.sourceforge.net; Wed, 28 Aug 2013 13:07:34 +0000
Received: from userp1040.oracle.com ([156.151.31.81])
	by sog-mx-1.v43.ch3.sourceforge.com with esmtps (TLSv1:AES256-SHA:256)
	(Exim 4.76) id 1VEfTB-0007ph-6X
	for ltp-list@lists.sourceforge.net; Wed, 28 Aug 2013 13:07:34 +0000
Received: from ucsinet22.oracle.com (ucsinet22.oracle.com [156.151.31.94])
	by userp1040.oracle.com (Sentrion-MTA-4.3.1/Sentrion-MTA-4.3.1) with
	ESMTP id r7SD7Qal027090
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=OK)
	for <ltp-list@lists.sourceforge.net>; Wed, 28 Aug 2013 13:07:27 GMT
Received: from aserz7021.oracle.com (aserz7021.oracle.com [141.146.126.230])
	by ucsinet22.oracle.com (8.14.4+Sun/8.14.4) with ESMTP id
	r7SD7P1D008762
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=NO)
	for <ltp-list@lists.sourceforge.net>; Wed, 28 Aug 2013 13:07:26 GMT
Received: from abhmt103.oracle.com (abhmt103.oracle.com [141.146.116.55])
	by aserz7021.oracle.com (8.14.4+Sun/8.14.4) with ESMTP id
	r7SD7PiB019870
	for <ltp-list@lists.sourceforge.net>; Wed, 28 Aug 2013 13:07:25 GMT
Message-ID: <521DF60B.9010401@oracle.com>
Date: Wed, 28 Aug 2013 08:07:23 -0500
From: Dave Kleikamp <dave.kleikamp@oracle.com>
MIME-Version: 1.0
Subject: [LTP] [PATCH] ltp: Fix races in mmap1
List-Id: Linux Test Project General Discussions
	<ltp-list.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/ltp-list>,
	<mailto:ltp-list-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=ltp-list>
List-Post: <mailto:ltp-list@lists.sourceforge.net>
List-Help: <mailto:ltp-list-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/ltp-list>,
	<mailto:ltp-list-request@lists.sourceforge.net?subject=subscribe>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: ltp-list-bounces@lists.sourceforge.net
To: ltp-list@lists.sourceforge.net

Make map_address a volatile pointer so that it is dereferenced in
read_mem() after read_lock is set.

Also read_lock must protect the verbose printf that reads from map_address
as well.

Signed-off-by: Dave Kleikamp <dave.kleikamp@oracle.com>

diff --git a/testcases/kernel/mem/mtest06/mmap1.c b/testcases/kernel/mem/mtest06/mmap1.c
index 7c80bb4..cd1127f 100644
--- a/testcases/kernel/mem/mtest06/mmap1.c
+++ b/testcases/kernel/mem/mtest06/mmap1.c
@@ -62,7 +62,7 @@
 } while (0)
 
 static int verbose_print = 0;
-static char *map_address;
+static char *volatile map_address;
 static jmp_buf jmpbuf;
 static volatile char read_lock = 0;
 
@@ -228,11 +228,13 @@ void *read_mem(void *ptr)
 				tst_resm(TINFO, "page fault occurred due to "
 					 "a read after an unmap");
 		} else {
-			if (verbose_print)
+			if (verbose_print) {
+				read_lock = 1;
 				tst_resm(TINFO,
 					 "read_mem(): content of memory: %s",
 					 (char *)map_address);
-
+				read_lock = 0;
+			}
 			for (j = 0; j < args[1]; j++) {
 				read_lock = 1;
 				if (map_address[j] != 'a')

------------------------------------------------------------------------------
Learn the latest--Visual Studio 2012, SharePoint 2013, SQL 2012, more!
Discover the easy way to master current and previous Microsoft technologies
and advance your career. Get an incredible 1,500+ hours of step-by-step
tutorial videos with LearnDevNow. Subscribe today and save!
http://pubads.g.doubleclick.net/gampad/clk?id=58040911&iu=/4140/ostg.clktrk
_______________________________________________
Ltp-list mailing list
Ltp-list@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/ltp-list
