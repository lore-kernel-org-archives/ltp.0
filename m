Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 136F3C28D13
	for <ltp@archiver.kernel.org>; Mon, 22 Aug 2022 11:39:38 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 29DF23CA3D7
	for <ltp@archiver.kernel.org>; Mon, 22 Aug 2022 13:39:36 +0200 (CEST)
Received: from in-6.smtp.seeweb.it (in-6.smtp.seeweb.it
 [IPv6:2001:4b78:1:20::6])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-384))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 5DE353CA34D
 for <ltp@lists.linux.it>; Mon, 22 Aug 2022 13:38:48 +0200 (CEST)
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
 by in-6.smtp.seeweb.it (Postfix) with ESMTP id 4F89B1400123
 for <ltp@lists.linux.it>; Mon, 22 Aug 2022 13:38:46 +0200 (CEST)
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
 by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 1DE0412FC;
 Mon, 22 Aug 2022 04:38:49 -0700 (PDT)
Received: from e129169.arm.com (usa-sjc-imap-foss1.foss.arm.com
 [10.121.207.14])
 by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 3DDB23F718;
 Mon, 22 Aug 2022 04:38:45 -0700 (PDT)
From: Tudor Cretu <tudor.cretu@arm.com>
To: ltp@lists.linux.it
Date: Mon, 22 Aug 2022 12:39:19 +0100
Message-Id: <20220822113919.196953-5-tudor.cretu@arm.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20220822113919.196953-1-tudor.cretu@arm.com>
References: <20220822113919.196953-1-tudor.cretu@arm.com>
MIME-Version: 1.0
X-Virus-Scanned: clamav-milter 0.102.4 at in-6.smtp.seeweb.it
X-Virus-Status: Clean
Subject: [LTP] [PATCH v2 4/4] syscalls/statfs: Accept segfault instead of
 EFAULT
X-BeenThere: ltp@lists.linux.it
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: Linux Test Project <ltp.lists.linux.it>
List-Unsubscribe: <https://lists.linux.it/options/ltp>,
 <mailto:ltp-request@lists.linux.it?subject=unsubscribe>
List-Archive: <http://lists.linux.it/pipermail/ltp/>
List-Post: <mailto:ltp@lists.linux.it>
List-Help: <mailto:ltp-request@lists.linux.it?subject=help>
List-Subscribe: <https://lists.linux.it/listinfo/ltp>,
 <mailto:ltp-request@lists.linux.it?subject=subscribe>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: ltp-bounces+ltp=archiver.kernel.org@lists.linux.it
Sender: "ltp" <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>

The [f]statfs02 testsuites check that [f]statfs returns EFUALT when the
provided buf parameter is invalid. There are cases in which the supported
libcs don't exhibit this behaviour.

glibc versions newer than 2.34 and on systems that support [f]statfs64,
call the syscall with a local struct statfs and then copy the result
into buf. This throws a segfault for an invalid buf. musl dereferences buf
before the syscall is called and, similarly, throws a segfault.

Implement a sighandler to handle the cases where a segfault is thrown
instead of returning EFAULT.

Signed-off-by: Tudor Cretu <tudor.cretu@arm.com>
---
 testcases/kernel/syscalls/fstatfs/fstatfs02.c | 60 ++++++++++++++-----
 testcases/kernel/syscalls/statfs/statfs02.c   | 32 +++++++++-
 2 files changed, 73 insertions(+), 19 deletions(-)

diff --git a/testcases/kernel/syscalls/fstatfs/fstatfs02.c b/testcases/kernel/syscalls/fstatfs/fstatfs02.c
index db2230f82..e46b9df23 100644
--- a/testcases/kernel/syscalls/fstatfs/fstatfs02.c
+++ b/testcases/kernel/syscalls/fstatfs/fstatfs02.c
@@ -21,6 +21,8 @@
  *	Testcase to check fstatfs() sets errno correctly.
  */
 
+#include <setjmp.h>
+#include <signal.h>
 #include <sys/vfs.h>
 #include <sys/types.h>
 #include <sys/statfs.h>
@@ -28,9 +30,6 @@
 #include "test.h"
 #include "safe_macros.h"
 
-static void setup(void);
-static void cleanup(void);
-
 char *TCID = "fstatfs02";
 
 static struct statfs buf;
@@ -53,6 +52,13 @@ static struct test_case_t {
 
 int TST_TOTAL = ARRAY_SIZE(TC);
 
+static int sig_caught;
+static sigjmp_buf env;
+
+static void setup(void);
+static void cleanup(void);
+static void fstatfs_verify(const struct test_case_t *);
+
 int main(int ac, char **av)
 {
 	int lc;
@@ -67,23 +73,20 @@ int main(int ac, char **av)
 		tst_count = 0;
 
 		for (i = 0; i < TST_TOTAL; i++) {
+			sig_caught = 0;
+			if (sigsetjmp(env, 1) == 0)
+				fstatfs_verify(&TC[i]);
 
-			TEST(fstatfs(TC[i].fd, TC[i].sbuf));
+			if (!sig_caught)
+				continue;
 
-			if (TEST_RETURN != -1) {
-				tst_resm(TFAIL, "call succeeded unexpectedly");
+			if (TC[i].error == EFAULT && sig_caught == SIGSEGV) {
+				tst_resm(TINFO, "received SIGSEGV instead of returning EFAULT");
+				tst_resm(TPASS | TTERRNO, "expected failure");
 				continue;
 			}
 
-			if (TEST_ERRNO == TC[i].error) {
-				tst_resm(TPASS, "expected failure - "
-					 "errno = %d : %s", TEST_ERRNO,
-					 strerror(TEST_ERRNO));
-			} else {
-				tst_resm(TFAIL, "unexpected error - %d : %s - "
-					 "expected %d", TEST_ERRNO,
-					 strerror(TEST_ERRNO), TC[i].error);
-			}
+			tst_resm(TFAIL, "Received an unexpected signal: %d", sig_caught);
 		}
 	}
 	cleanup();
@@ -91,9 +94,16 @@ int main(int ac, char **av)
 	tst_exit();
 }
 
+static void sighandler(int sig)
+{
+	sig_caught = sig;
+	siglongjmp(env, 1);
+
+}
+
 static void setup(void)
 {
-	tst_sig(NOFORK, DEF_HANDLER, cleanup);
+	tst_sig(NOFORK, sighandler, cleanup);
 
 	TEST_PAUSE;
 
@@ -103,6 +113,24 @@ static void setup(void)
 #endif
 }
 
+static void fstatfs_verify(const struct test_case_t *test)
+{
+	TEST(fstatfs(test->fd, test->sbuf));
+
+	if (TEST_RETURN != -1) {
+		tst_resm(TFAIL, "call succeeded unexpectedly");
+		return;
+	}
+
+	if (TEST_ERRNO == test->error) {
+		tst_resm(TPASS, "expected failure - errno = %d : %s",
+			 TEST_ERRNO, strerror(TEST_ERRNO));
+	} else {
+		tst_resm(TFAIL, "unexpected error - %d : %s - expected %d",
+			 TEST_ERRNO, strerror(TEST_ERRNO), test->error);
+	}
+}
+
 static void cleanup(void)
 {
 #ifndef UCLINUX
diff --git a/testcases/kernel/syscalls/statfs/statfs02.c b/testcases/kernel/syscalls/statfs/statfs02.c
index 279665f86..7f150d1d9 100644
--- a/testcases/kernel/syscalls/statfs/statfs02.c
+++ b/testcases/kernel/syscalls/statfs/statfs02.c
@@ -32,6 +32,8 @@
  *		ELOOP.
  */
 
+#include <setjmp.h>
+#include <signal.h>
 #include <sys/types.h>
 #include <sys/statfs.h>
 #include <sys/stat.h>
@@ -70,6 +72,10 @@ static struct test_case_t {
 };
 
 int TST_TOTAL = ARRAY_SIZE(TC);
+
+static int sig_caught;
+static sigjmp_buf env;
+
 static void setup(void);
 static void cleanup(void);
 static void statfs_verify(const struct test_case_t *);
@@ -85,17 +91,37 @@ int main(int ac, char **av)
 
 	for (lc = 0; TEST_LOOPING(lc); lc++) {
 		tst_count = 0;
-		for (i = 0; i < TST_TOTAL; i++)
-			statfs_verify(&TC[i]);
+		for (i = 0; i < TST_TOTAL; i++) {
+			sig_caught = 0;
+			if (sigsetjmp(env, 1) == 0)
+				statfs_verify(&TC[i]);
+
+			if (!sig_caught)
+				continue;
+
+			if (TC[i].exp_error == EFAULT && sig_caught == SIGSEGV) {
+				tst_resm(TINFO, "received SIGSEGV instead of returning EFAULT");
+				tst_resm(TPASS | TTERRNO, "expected failure");
+				continue;
+			}
+
+			tst_resm(TFAIL, "Received an unexpected signal: %d", sig_caught);
+		}
 	}
 
 	cleanup();
 	tst_exit();
 }
 
+static void sighandler(int sig)
+{
+	sig_caught = sig;
+	siglongjmp(env, 1);
+}
+
 static void setup(void)
 {
-	tst_sig(NOFORK, DEF_HANDLER, cleanup);
+	tst_sig(NOFORK, sighandler, cleanup);
 
 	TEST_PAUSE;
 
-- 
2.25.1


-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
