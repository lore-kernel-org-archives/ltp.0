Return-Path: <ltp-list-bounces@lists.sourceforge.net>
Received: from sog-mx-4.v43.ch3.sourceforge.com ([172.29.43.194]
	helo=mx.sourceforge.net)
	by sfs-ml-4.v29.ch3.sourceforge.com with esmtp (Exim 4.76)
	(envelope-from <zenglg.jy@cn.fujitsu.com>) id 1WKQye-0004Wq-6q
	for ltp-list@lists.sourceforge.net; Mon, 03 Mar 2014 11:24:08 +0000
Received: from [222.73.24.84] (helo=song.cn.fujitsu.com)
	by sog-mx-4.v43.ch3.sourceforge.com with esmtp (Exim 4.76)
	id 1WKQyb-0006f3-Qk
	for ltp-list@lists.sourceforge.net; Mon, 03 Mar 2014 11:24:08 +0000
Message-ID: <1393845833.1984.11.camel@G08JYZSD130126>
From: Zeng Linggang <zenglg.jy@cn.fujitsu.com>
Date: Mon, 03 Mar 2014 19:23:53 +0800
In-Reply-To: <1393845775.1984.10.camel@G08JYZSD130126>
References: <1392372604.2085.10.camel@G08JYZSD130126>
	<1795224124.5672526.1392809381205.JavaMail.zimbra@redhat.com>
	<1392889204.2053.7.camel@G08JYZSD130126>
	<1392889813.2053.10.camel@G08JYZSD130126>
	<1128042688.6449127.1392894329625.JavaMail.zimbra@redhat.com>
	<929738145.6498501.1392901385804.JavaMail.zimbra@redhat.com>
	<1393832848.1991.19.camel@G08JYZSD130126>
	<1393833079.1991.22.camel@G08JYZSD130126>
	<1720660524.12179720.1393837634610.JavaMail.zimbra@redhat.com>
	<1393845775.1984.10.camel@G08JYZSD130126>
Mime-Version: 1.0
Subject: [LTP] [PATCH v5 2/3] mlock/mlock02.c: cleanup
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
* Use SAFE_* macros.
* Some cleanup.

Signed-off-by: Zeng Linggang <zenglg.jy@cn.fujitsu.com>
---
 testcases/kernel/syscalls/mlock/mlock02.c | 172 ++++++++++++++----------------
 1 file changed, 83 insertions(+), 89 deletions(-)

diff --git a/testcases/kernel/syscalls/mlock/mlock02.c b/testcases/kernel/syscalls/mlock/mlock02.c
index edd9e45..95c499d 100644
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
@@ -13,70 +13,41 @@
  *   the GNU General Public License for more details.
  *
  *   You should have received a copy of the GNU General Public License
- *   along with this program;  if not, write to the Free Software
- *   Foundation, Inc., 51 Franklin Street, Fifth Floor, Boston, MA 02110-1301 USA
+ *   along with this program;  if not, write to the Free Software Foundation,
+ *   Inc., 51 Franklin Street, Fifth Floor, Boston, MA 02110-1301 USA
  */
 
 /*
- * NAME
- * 	mlock02.c
- *
- * DESCRIPTION
- * 	Test to see the proper errors are returned by mlock
- *$
- * ALGORITHM
- * 	test 1:
- *		Call mlock with a NULL address.  ENOMEM should be returned
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
+ * Test Description:
+ *  Verify that,
+ *   1. mlock() fails with -1 return value and sets errno to ENOMEM,
+ *      if some of the specified address range does not correspond to
+ *      mapped pages in the address space of the process.
  */
+
 #include <errno.h>
 #include <unistd.h>
 #include <sys/mman.h>
+
 #include "test.h"
 #include "usctest.h"
-
-void setup();
-void setup1();
-void cleanup();
+#include "safe_macros.h"
 
 char *TCID = "mlock02";
-int TST_TOTAL = 1;
 
-int exp_enos[] = { ENOMEM, 0 };
+#if !defined(UCLINUX)
 
-void *addr1;
+static void setup(void);
+static void cleanup(void);
+static void test_enomem1(void);
+static void mlock_verify(const void *, const size_t, const int);
 
-struct test_case_t {
-	void **addr;
-	int len;
-	int error;
-	void (*setupfunc) ();
-} TC[] = {
-	/* mlock should return ENOMEM when some or all of the address
-	 * range pointed to by addr and len are not valid mapped pages
-	 * in the address space of the process
-	 */
-	{
-	&addr1, 1024, ENOMEM, setup1}
-};
+static size_t len;
 
-#if !defined(UCLINUX)
+static void (*test_func[])(void) = { test_enomem1 };
+
+int TST_TOTAL = ARRAY_SIZE(test_func);
+static int exp_enos[] = { ENOMEM, 0 };
 
 int main(int ac, char **av)
 {
@@ -91,62 +62,85 @@ int main(int ac, char **av)
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
+			(*test_func[i])();
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
+
+	len = getpagesize();
+}
 
-void setup()
+static void test_enomem1(void)
 {
-	TEST_PAUSE;
+	void *addr;
+	struct rlimit rl;
+
+	/*
+	 * RLIMIT_MEMLOCK resource limit.
+	 * In Linux kernels before 2.6.9, this limit controlled the amount
+	 * of  memory that could be locked by a privileged process. Since
+	 * Linux 2.6.9, no limits are placed on the amount of memory that a
+	 * privileged process may lock, and this limit instead governs the
+	 * amount of memory that an unprivileged process may lock. So here
+	 * we set RLIMIT_MEMLOCK resource limit to RLIM_INFINITY when kernel
+	 * is under 2.6.9, to make sure this ENOMEM error is indeed caused by
+	 * that some of the specified address range does not correspond to
+	 * mapped pages in the address space of the process.
+	 */
+	if ((tst_kvercmp(2, 6, 9)) < 0) {
+		rl.rlim_cur = RLIM_INFINITY;
+		rl.rlim_max = RLIM_INFINITY;
+		SAFE_SETRLIMIT(cleanup, RLIMIT_MEMLOCK, &rl);
+	}
+
+	addr = SAFE_MMAP(cleanup, NULL, len, PROT_READ,
+			 MAP_PRIVATE | MAP_ANONYMOUS, 0, 0);
+
+	SAFE_MUNMAP(cleanup, addr, len);
+
+	mlock_verify(addr, len, ENOMEM);
 }
 
-void setup1()
+static void mlock_verify(const void *addr, const size_t len, const int error)
 {
-#ifdef __ia64__
-	TC[0].len = getpagesize() + 1;
-#else
-	addr1 = NULL;
-#endif
+	TEST(mlock(addr, len));
+
+	if (TEST_RETURN != -1) {
+		tst_resm(TFAIL, "mlock succeeded unexpectedly");
+		return;
+	}
+
+	if (TEST_ERRNO != error) {
+		tst_resm(TFAIL | TTERRNO,
+			 "mlock didn't fail as expected; expected - %d : %s",
+			 error, strerror(error));
+	} else {
+		tst_resm(TPASS | TTERRNO, "mlock failed as expected");
+	}
 }
 
-void cleanup()
+static void cleanup(void)
 {
 	TEST_CLEANUP;
+}
 
+#else
+
+int TST_TOTAL = 1;
+
+int main(void)
+{
+	tst_brkm(TCONF, NULL, "test is not available on uClinux");
 }
+
+#endif /* if !defined(UCLINUX) */
-- 
1.8.4.2




------------------------------------------------------------------------------
Subversion Kills Productivity. Get off Subversion & Make the Move to Perforce.
With Perforce, you get hassle-free workflows. Merge that actually works. 
Faster operations. Version large binaries.  Built-in WAN optimization and the
freedom to use Git, Perforce or both. Make the move to Perforce.
http://pubads.g.doubleclick.net/gampad/clk?id=122218951&iu=/4140/ostg.clktrk
_______________________________________________
Ltp-list mailing list
Ltp-list@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/ltp-list
