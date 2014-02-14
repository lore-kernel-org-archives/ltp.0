Return-Path: <ltp-list-bounces@lists.sourceforge.net>
Received: from sog-mx-3.v43.ch3.sourceforge.com ([172.29.43.193]
	helo=mx.sourceforge.net)
	by sfs-ml-1.v29.ch3.sourceforge.com with esmtp (Exim 4.76)
	(envelope-from <zenglg.jy@cn.fujitsu.com>) id 1WEFiu-0008Na-Bk
	for ltp-list@lists.sourceforge.net; Fri, 14 Feb 2014 10:10:20 +0000
Received: from [222.73.24.84] (helo=song.cn.fujitsu.com)
	by sog-mx-3.v43.ch3.sourceforge.com with esmtp (Exim 4.76)
	id 1WEFis-0008WQ-3Y
	for ltp-list@lists.sourceforge.net; Fri, 14 Feb 2014 10:10:20 +0000
Received: from fnstmail02.fnst.cn.fujitsu.com (tang.cn.fujitsu.com [127.0.0.1])
	by tang.cn.fujitsu.com (8.14.3/8.13.1) with ESMTP id s1EAA9R8016512
	for <ltp-list@lists.sourceforge.net>; Fri, 14 Feb 2014 18:10:10 +0800
Message-ID: <1392372604.2085.10.camel@G08JYZSD130126>
From: Zeng Linggang <zenglg.jy@cn.fujitsu.com>
Date: Fri, 14 Feb 2014 18:10:04 +0800
Mime-Version: 1.0
Subject: [LTP] [PATCH] mlock/mlock02.c: cleanup
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
* Use SAFE_* macros.
* Move the test body form main() to mlock_verify().
* Some cleanup.

Signed-off-by: Zeng Linggang <zenglg.jy@cn.fujitsu.com>
---
 testcases/kernel/syscalls/mlock/mlock02.c | 110 +++++++++++-------------------
 1 file changed, 38 insertions(+), 72 deletions(-)

diff --git a/testcases/kernel/syscalls/mlock/mlock02.c b/testcases/kernel/syscalls/mlock/mlock02.c
index edd9e45..a635d24 100644
--- a/testcases/kernel/syscalls/mlock/mlock02.c
+++ b/testcases/kernel/syscalls/mlock/mlock02.c
@@ -1,6 +1,6 @@
 /*
- *
  *   Copyright (c) International Business Machines  Corp., 2002
+ *	06/2002 Written by Paul Larson
  *
  *   This program is free software;  you can redistribute it and/or modify
  *   it under the terms of the GNU General Public License as published by
@@ -13,69 +13,40 @@
  *   the GNU General Public License for more details.
  *
  *   You should have received a copy of the GNU General Public License
- *   along with this program;  if not, write to the Free Software
- *   Foundation, Inc., 51 Franklin Street, Fifth Floor, Boston, MA 02110-1301 USA
+ *   along with this program;  if not, write to the Free Software Foundation,
+ *   Inc., 51 Franklin Street, Fifth Floor, Boston, MA 02110-1301 USA
  */
-
 /*
- * NAME
- * 	mlock02.c
- *
- * DESCRIPTION
- * 	Test to see the proper errors are returned by mlock
- *$
  * ALGORITHM
  * 	test 1:
  *		Call mlock with a NULL address.  ENOMEM should be returned
- *
- * USAGE:  <for command-line>
- *         -c n    Run n copies concurrently
- *         -e      Turn on errno logging
- *         -f      Turn off functional testing
- *         -h      Show this help screen
- *         -i n    Execute test n times
- *         -I x    Execute test for x seconds
- *         -p      Pause for SIGUSR1 before starting
- *         -P x    Pause for x seconds between iterations
- *         -t      Turn on syscall timing
- *
- * HISTORY
- *	06/2002 Written by Paul Larson
- *
- * RESTRICTIONS
- * 	None
  */
+
 #include <errno.h>
 #include <unistd.h>
 #include <sys/mman.h>
 #include "test.h"
 #include "usctest.h"
-
-void setup();
-void setup1();
-void cleanup();
+#include "safe_macros.h"
 
 char *TCID = "mlock02";
-int TST_TOTAL = 1;
-
-int exp_enos[] = { ENOMEM, 0 };
 
-void *addr1;
+static void *addr1;
+static void setup(void);
+static void mlock_verify(int);
+static void cleanup(void);
 
-struct test_case_t {
+static struct test_case_t {
 	void **addr;
 	int len;
 	int error;
-	void (*setupfunc) ();
 } TC[] = {
-	/* mlock should return ENOMEM when some or all of the address
-	 * range pointed to by addr and len are not valid mapped pages
-	 * in the address space of the process
-	 */
-	{
-	&addr1, 1024, ENOMEM, setup1}
+	{&addr1, 1024, ENOMEM},
 };
 
+int TST_TOTAL = ARRAY_SIZE(TC);
+static int exp_enos[] = { ENOMEM, 0 };
+
 #if !defined(UCLINUX)
 
 int main(int ac, char **av)
@@ -94,50 +65,28 @@ int main(int ac, char **av)
 
 		tst_count = 0;
 
-		for (i = 0; i < TST_TOTAL; i++) {
-
-			if (TC[i].setupfunc != NULL)
-				TC[i].setupfunc();
-
-			TEST(mlock(*(TC[i].addr), TC[i].len));
-
-			if (TEST_RETURN == -1) {
-				if (TEST_ERRNO != TC[i].error)
-					tst_brkm(TFAIL | TTERRNO, cleanup,
-						 "mlock didn't fail as expected; "
-						 "expected - %d : %s",
-						 TC[i].error,
-						 strerror(TC[i].error));
-				else
-					tst_resm(TPASS | TTERRNO,
-						 "mlock failed as expected");
-			} else
-				tst_brkm(TFAIL, cleanup,
-					 "mlock succeeded unexpectedly");
-		}
+		for (i = 0; i < TST_TOTAL; i++)
+
+			mlock_verify(i);
 	}
 
 	cleanup();
-
 	tst_exit();
 }
 
 #else
 
-int main()
+int main(void)
 {
 	tst_brkm(TCONF, NULL, "test is not available on uClinux");
 }
 
 #endif /* if !defined(UCLINUX) */
 
-void setup()
+static void setup(void)
 {
 	TEST_PAUSE;
-}
 
-void setup1()
-{
 #ifdef __ia64__
 	TC[0].len = getpagesize() + 1;
 #else
@@ -145,8 +94,25 @@ void setup1()
 #endif
 }
 
-void cleanup()
+static void mlock_verify(int i)
 {
-	TEST_CLEANUP;
+	TEST(mlock(*(TC[i].addr), TC[i].len));
+
+	if (TEST_RETURN != -1) {
+		tst_resm(TFAIL, "mlock succeeded unexpectedly");
+		return;
+	}
+
+	if (TEST_ERRNO != TC[i].error) {
+		tst_resm(TFAIL | TTERRNO,
+			 "mlock didn't fail as expected; expected - %d : %s",
+			 TC[i].error, strerror(TC[i].error));
+	} else {
+		tst_resm(TPASS | TTERRNO, "mlock failed as expected");
+	}
+}
 
+static void cleanup(void)
+{
+	TEST_CLEANUP;
 }
-- 
1.8.4.2




------------------------------------------------------------------------------
Android apps run on BlackBerry 10
Introducing the new BlackBerry 10.2.1 Runtime for Android apps.
Now with support for Jelly Bean, Bluetooth, Mapview and more.
Get your Android app in front of a whole new audience.  Start now.
http://pubads.g.doubleclick.net/gampad/clk?id=124407151&iu=/4140/ostg.clktrk
_______________________________________________
Ltp-list mailing list
Ltp-list@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/ltp-list
