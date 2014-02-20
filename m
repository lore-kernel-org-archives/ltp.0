Return-Path: <ltp-list-bounces@lists.sourceforge.net>
Received: from sog-mx-1.v43.ch3.sourceforge.com ([172.29.43.191]
	helo=mx.sourceforge.net)
	by sfs-ml-2.v29.ch3.sourceforge.com with esmtp (Exim 4.76)
	(envelope-from <zenglg.jy@cn.fujitsu.com>) id 1WGQ78-00033G-Qj
	for ltp-list@lists.sourceforge.net; Thu, 20 Feb 2014 09:40:18 +0000
Received: from [222.73.24.84] (helo=song.cn.fujitsu.com)
	by sog-mx-1.v43.ch3.sourceforge.com with esmtp (Exim 4.76)
	id 1WGQ77-0006Q1-13
	for ltp-list@lists.sourceforge.net; Thu, 20 Feb 2014 09:40:18 +0000
Message-ID: <1392889204.2053.7.camel@G08JYZSD130126>
From: Zeng Linggang <zenglg.jy@cn.fujitsu.com>
Date: Thu, 20 Feb 2014 17:40:04 +0800
In-Reply-To: <1795224124.5672526.1392809381205.JavaMail.zimbra@redhat.com>
References: <1392372604.2085.10.camel@G08JYZSD130126>
	<1392372746.2085.11.camel@G08JYZSD130126>
	<1615091378.3633979.1392375266510.JavaMail.zimbra@redhat.com>
	<1392802716.2083.4.camel@G08JYZSD130126>
	<1392802803.2083.5.camel@G08JYZSD130126>
	<1795224124.5672526.1392809381205.JavaMail.zimbra@redhat.com>
Mime-Version: 1.0
Subject: [LTP] [PATCH v3 1/2] mlock/mlock02.c: cleanup
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
To: Jan Stancek <jstancek@redhat.com>
Cc: ltp-list <ltp-list@lists.sourceforge.net>

* Delete some useless commtents.
* Move the test body form main() to mlock_verify().
* Some cleanup.

Signed-off-by: Zeng Linggang <zenglg.jy@cn.fujitsu.com>
---
 testcases/kernel/syscalls/mlock/mlock02.c | 136 ++++++++++++------------------
 1 file changed, 56 insertions(+), 80 deletions(-)

diff --git a/testcases/kernel/syscalls/mlock/mlock02.c b/testcases/kernel/syscalls/mlock/mlock02.c
index edd9e45..811d141 100644
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
@@ -13,70 +13,44 @@
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
 
-void setup();
-void setup1();
-void cleanup();
-
 char *TCID = "mlock02";
-int TST_TOTAL = 1;
 
-int exp_enos[] = { ENOMEM, 0 };
-
-void *addr1;
+#if !defined(UCLINUX)
 
 struct test_case_t {
 	void **addr;
 	int len;
 	int error;
-	void (*setupfunc) ();
-} TC[] = {
-	/* mlock should return ENOMEM when some or all of the address
-	 * range pointed to by addr and len are not valid mapped pages
-	 * in the address space of the process
-	 */
-	{
-	&addr1, 1024, ENOMEM, setup1}
+	void (*setupfunc) (struct test_case_t *);
 };
 
-#if !defined(UCLINUX)
+static void *addr1;
+static void setup(void);
+static void setup1(struct test_case_t *);
+static void cleanup(void);
+static void mlock_verify(struct test_case_t *);
+
+static struct test_case_t TC[] = {
+	{&addr1, 1024, ENOMEM, setup1},
+};
+
+int TST_TOTAL = ARRAY_SIZE(TC);
+static int exp_enos[] = { ENOMEM, 0 };
 
 int main(int ac, char **av)
 {
@@ -91,62 +65,64 @@ int main(int ac, char **av)
 	TEST_EXP_ENOS(exp_enos);
 
 	for (lc = 0; TEST_LOOPING(lc); lc++) {
-
 		tst_count = 0;
-
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
+			mlock_verify(&TC[i]);
 	}
 
 	cleanup();
-
 	tst_exit();
 }
 
-#else
-
-int main()
+static void setup(void)
 {
-	tst_brkm(TCONF, NULL, "test is not available on uClinux");
-}
+	tst_sig(NOFORK, DEF_HANDLER, cleanup);
 
-#endif /* if !defined(UCLINUX) */
+	TEST_PAUSE;
+}
 
-void setup()
+static void mlock_verify(struct test_case_t *test)
 {
-	TEST_PAUSE;
+	if (test->setupfunc != NULL)
+		test->setupfunc(test);
+
+	TEST(mlock(*(test->addr), test->len));
+
+	if (TEST_RETURN != -1) {
+		tst_resm(TFAIL, "mlock succeeded unexpectedly");
+		return;
+	}
+
+	if (TEST_ERRNO != test->error) {
+		tst_resm(TFAIL | TTERRNO,
+			 "mlock didn't fail as expected; expected - %d : %s",
+			 test->error, strerror(test->error));
+	} else {
+		tst_resm(TPASS | TTERRNO, "mlock failed as expected");
+	}
 }
 
-void setup1()
+static void setup1(struct test_case_t *test)
 {
 #ifdef __ia64__
-	TC[0].len = getpagesize() + 1;
+	test->len = getpagesize() + 1;
 #else
-	addr1 = NULL;
+	*test->addr = NULL;
 #endif
 }
 
-void cleanup()
+static void cleanup(void)
 {
 	TEST_CLEANUP;
+}
+
+#else
+
+int TST_TOTAL = 1;
 
+int main(void)
+{
+	tst_brkm(TCONF, NULL, "test is not available on uClinux");
 }
+
+#endif /* if !defined(UCLINUX) */
-- 
1.8.4.2




------------------------------------------------------------------------------
Managing the Performance of Cloud-Based Applications
Take advantage of what the Cloud has to offer - Avoid Common Pitfalls.
Read the Whitepaper.
http://pubads.g.doubleclick.net/gampad/clk?id=121054471&iu=/4140/ostg.clktrk
_______________________________________________
Ltp-list mailing list
Ltp-list@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/ltp-list
