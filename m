Return-Path: <ltp-list-bounces@lists.sourceforge.net>
Received: from sog-mx-3.v43.ch3.sourceforge.com ([172.29.43.193]
	helo=mx.sourceforge.net)
	by sfs-ml-4.v29.ch3.sourceforge.com with esmtp (Exim 4.76)
	(envelope-from <zenglg.jy@cn.fujitsu.com>) id 1WG3sF-0000x8-Jx
	for ltp-list@lists.sourceforge.net; Wed, 19 Feb 2014 09:55:27 +0000
Received: from [222.73.24.84] (helo=song.cn.fujitsu.com)
	by sog-mx-3.v43.ch3.sourceforge.com with esmtp (Exim 4.76)
	id 1WG3sE-0005Uf-Ak
	for ltp-list@lists.sourceforge.net; Wed, 19 Feb 2014 09:55:27 +0000
Message-ID: <1392802803.2083.5.camel@G08JYZSD130126>
From: Zeng Linggang <zenglg.jy@cn.fujitsu.com>
Date: Wed, 19 Feb 2014 17:40:03 +0800
In-Reply-To: <1392802716.2083.4.camel@G08JYZSD130126>
References: <1392372604.2085.10.camel@G08JYZSD130126>
	<1392372746.2085.11.camel@G08JYZSD130126>
	<1615091378.3633979.1392375266510.JavaMail.zimbra@redhat.com>
	<1392802716.2083.4.camel@G08JYZSD130126>
Mime-Version: 1.0
Subject: [LTP] [PATCH v2 2/2] mlock/mlock02.c: add EPERM and ENOMEM errno
	tests
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

Add EPERM and ENOMEM errno tests for mlock(2).

Signed-off-by: Zeng Linggang <zenglg.jy@cn.fujitsu.com>
---
 testcases/kernel/syscalls/mlock/mlock02.c | 88 ++++++++++++++++++++++++++++---
 1 file changed, 81 insertions(+), 7 deletions(-)

diff --git a/testcases/kernel/syscalls/mlock/mlock02.c b/testcases/kernel/syscalls/mlock/mlock02.c
index 1d1c853..6ccd281 100644
--- a/testcases/kernel/syscalls/mlock/mlock02.c
+++ b/testcases/kernel/syscalls/mlock/mlock02.c
@@ -20,13 +20,22 @@
  * ALGORITHM
  * 	test 1:
  *		Call mlock with a NULL address.  ENOMEM should be returned
+ *	test 2:
+ *		The caller was not privileged and its RLIMIT_MEMLOCK soft
+ *		resource limit was 0. EPERM should be returned
+ *	test 3:
+ *		The caller was not privileged and its RLIMIT_MEMLOCK soft
+ *		resource limit was nonzero, but tried to lock more memory than
+ *		the limit permitted. ENOMEM should be returned
  */
 
 #include <errno.h>
 #include <unistd.h>
 #include <sys/mman.h>
+#include <pwd.h>
 #include "test.h"
 #include "usctest.h"
+#include "safe_macros.h"
 
 char *TCID = "mlock02";
 
@@ -36,25 +45,32 @@ struct test_case_t {
 	void **addr;
 	int len;
 	int error;
-	void (*setupfunc) ();
+	int (*setupfunc) ();
+	void (*cleanupfunc) ();
 };
 
 static void *addr1;
+static struct passwd *ltpuser;
 static void setup(void);
 #ifdef __ia64__
-static void setup1(const struct test_case_t *);
+static int setup1(const struct test_case_t *);
 #else
-static void setup1(void);
+static int setup1(void);
 #endif
+static int setup2(void);
+static int setup3(void);
+static void cleanup2(void);
 static void cleanup(void);
 static void mlock_verify(const struct test_case_t *);
 
 static struct test_case_t TC[] = {
-	{&addr1, 1024, ENOMEM, setup1},
+	{&addr1, 1024, ENOMEM, setup1, NULL},
+	{&addr1, 1024, EPERM, setup2, cleanup2},
+	{&addr1+1024, 1024, ENOMEM, setup3, cleanup2},
 };
 
 int TST_TOTAL = ARRAY_SIZE(TC);
-static int exp_enos[] = { ENOMEM, 0 };
+static int exp_enos[] = { ENOMEM, EPERM, 0 };
 
 int main(int ac, char **av)
 {
@@ -83,6 +99,8 @@ static void setup(void)
 	tst_sig(NOFORK, DEF_HANDLER, cleanup);
 
 	TEST_PAUSE;
+
+	ltpuser = SAFE_GETPWNAM(cleanup, "nobody");
 }
 
 static void mlock_verify(const struct test_case_t *test)
@@ -92,6 +110,9 @@ static void mlock_verify(const struct test_case_t *test)
 
 	TEST(mlock(*(test->addr), test->len));
 
+	if (test->cleanupfunc != NULL)
+		test->cleanupfunc();
+
 	if (TEST_RETURN != -1) {
 		tst_resm(TFAIL, "mlock succeeded unexpectedly");
 		return;
@@ -107,17 +128,70 @@ static void mlock_verify(const struct test_case_t *test)
 }
 
 #ifdef __ia64__
-static void setup1(const struct test_case_t *test)
+static int setup1(const struct test_case_t *test)
 {
 	test->len = getpagesize() + 1;
+	return 0;
 }
 #else
-static void setup1(void)
+static int setup1(void)
 {
 	addr1 = NULL;
+	return 0;
 }
 #endif
 
+static int setup2(void)
+{
+	struct rlimit rl;
+
+	if (geteuid() != 0) {
+		tst_resm(TWARN, "Test needs to be run as root");
+		return -1;
+	}
+
+	rl.rlim_max = 0;
+	rl.rlim_cur = 0;
+	if (setrlimit(RLIMIT_MEMLOCK, &rl) != 0) {
+		tst_resm(TWARN,
+			 "setrlimit failed to set the resource for "
+			 "RLIMIT_MEMLOCK to check for mlock()");
+		return -1;
+	}
+
+	SAFE_SETEUID(cleanup, ltpuser->pw_uid);
+
+	return 0;
+}
+
+static int setup3(void)
+{
+	struct rlimit rl;
+
+	if (geteuid() != 0) {
+		tst_resm(TWARN, "Test needs to be run as root");
+		return -1;
+	}
+
+	rl.rlim_max = 1;
+	rl.rlim_cur = 1;
+	if (setrlimit(RLIMIT_MEMLOCK, &rl) != 0) {
+		tst_resm(TWARN,
+			 "setrlimit failed to set the resource for "
+			 "RLIMIT_MEMLOCK to check for mlock()");
+		return -1;
+	}
+
+	SAFE_SETEUID(cleanup, ltpuser->pw_uid);
+
+	return 0;
+}
+
+static void cleanup2(void)
+{
+	SAFE_SETEUID(cleanup, 0);
+}
+
 static void cleanup(void)
 {
 	TEST_CLEANUP;
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
