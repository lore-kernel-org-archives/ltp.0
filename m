Return-Path: <ltp-list-bounces@lists.sourceforge.net>
Received: from sog-mx-4.v43.ch3.sourceforge.com ([172.29.43.194]
	helo=mx.sourceforge.net)
	by sfs-ml-2.v29.ch3.sourceforge.com with esmtp (Exim 4.76)
	(envelope-from <zenglg.jy@cn.fujitsu.com>) id 1WqD1f-0005xZ-5e
	for ltp-list@lists.sourceforge.net; Fri, 30 May 2014 02:58:35 +0000
Received: from [59.151.112.132] (helo=heian.cn.fujitsu.com)
	by sog-mx-4.v43.ch3.sourceforge.com with esmtp (Exim 4.76)
	id 1WqD1c-0006Nl-6C
	for ltp-list@lists.sourceforge.net; Fri, 30 May 2014 02:58:35 +0000
Received: from G08CNEXCHPEKD03.g08.fujitsu.local (localhost.localdomain
	[127.0.0.1])
	by edo.cn.fujitsu.com (8.14.3/8.13.1) with ESMTP id s4U2wOCJ013012
	for <ltp-list@lists.sourceforge.net>; Fri, 30 May 2014 10:58:24 +0800
Message-ID: <1401418614.3225.15.camel@G08JYZSD130126>
From: Zeng Linggang <zenglg.jy@cn.fujitsu.com>
Date: Fri, 30 May 2014 10:56:54 +0800
MIME-Version: 1.0
Subject: [LTP] [PATCH 1/2] statvfs/statvfs01.c: cleanup
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
To: ltp-list <ltp-list@lists.sourceforge.net>

* Delete some useless commtents.

* Some cleanup.

Signed-off-by: Zeng Linggang <zenglg.jy@cn.fujitsu.com>
---
 testcases/kernel/syscalls/statvfs/statvfs01.c | 49 +++++++--------------------
 1 file changed, 12 insertions(+), 37 deletions(-)

diff --git a/testcases/kernel/syscalls/statvfs/statvfs01.c b/testcases/kernel/syscalls/statvfs/statvfs01.c
index 306ca00..0ea882a 100644
--- a/testcases/kernel/syscalls/statvfs/statvfs01.c
+++ b/testcases/kernel/syscalls/statvfs/statvfs01.c
@@ -1,5 +1,6 @@
 /*
  * Copyright (c) Wipro Technologies Ltd, 2005.  All Rights Reserved.
+ *    AUTHOR: Prashant P Yendigeri <prashant.yendigeri@wipro.com>
  *
  * This program is free software; you can redistribute it and/or modify it
  * under the terms of version 2 of the GNU General Public License as
@@ -14,25 +15,12 @@
  * 51 Franklin Street, Fifth Floor, Boston, MA 02110-1301 USA.
  *
  */
-/**********************************************************
- *
- *    TEST IDENTIFIER   : statvfs01
- *
- *    EXECUTED BY       : root / superuser
- *
- *    TEST TITLE        : Basic tests for statvfs(2)
- *
- *    TEST CASE TOTAL   : 1
- *
- *    AUTHOR            : Prashant P Yendigeri
- *                        <prashant.yendigeri@wipro.com>
- *
+/*
  *    DESCRIPTION
  *      This is a Phase I test for the statvfs(2) system call.
  *      It is intended to provide a limited exposure of the system call.
  *	This call behaves similar to statfs.
- *
- **********************************************************/
+ */
 
 #include <stdio.h>
 #include <unistd.h>
@@ -43,15 +31,15 @@
 #include "test.h"
 #include "usctest.h"
 
-#define TEST_PATH "/"		/* Should be a mounted FS */
+#define TEST_PATH "/"
 
-void setup();
-void cleanup();
+static void setup(void);
+static void cleanup(void);
 
 char *TCID = "statvfs01";
 int TST_TOTAL = 1;
 
-int exp_enos[] = { 0 };		/* must be a 0 terminated list */
+int exp_enos[] = { 0 };
 
 int main(int ac, char **av)
 {
@@ -64,7 +52,6 @@ int main(int ac, char **av)
 
 	setup();
 
-	/* set the expected errnos... */
 	TEST_EXP_ENOS(exp_enos);
 
 	for (lc = 0; TEST_LOOPING(lc); lc++) {
@@ -73,11 +60,12 @@ int main(int ac, char **av)
 
 		TEST(statvfs(TEST_PATH, &buf));
 
-		if (TEST_RETURN == -1)
+		if (TEST_RETURN == -1) {
 			tst_resm(TFAIL | TERRNO, "statvfs(%s, ...) failed",
 				 TEST_PATH);
-		else
+		} else {
 			tst_resm(TPASS, "statvfs(%s, ...) passed", TEST_PATH);
+		}
 
 	}
 
@@ -96,30 +84,17 @@ int main(int ac, char **av)
 	tst_resm(TINFO, "file system max filename length = %lu", buf.f_namemax);
 
 	cleanup();
-
 	tst_exit();
 }
 
-/***************************************************************
- * setup() - performs all ONE TIME setup for this test.
- ***************************************************************/
-void setup(void)
+static void setup(void)
 {
-
 	tst_sig(NOFORK, DEF_HANDLER, cleanup);
 
 	TEST_PAUSE;
 }
 
-/***************************************************************
- * cleanup() - performs all ONE TIME cleanup for this test at
- *              completion or premature exit.
- ***************************************************************/
-void cleanup(void)
+static void cleanup(void)
 {
-	/*
-	 * print timing stats if that option was specified.
-	 * print errno log if that option was specified.
-	 */
 	TEST_CLEANUP;
 }
-- 
1.8.4.2




------------------------------------------------------------------------------
Time is money. Stop wasting it! Get your web API in 5 minutes.
www.restlet.com/download
http://p.sf.net/sfu/restlet
_______________________________________________
Ltp-list mailing list
Ltp-list@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/ltp-list
