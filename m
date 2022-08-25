Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id EA57EC64991
	for <ltp@archiver.kernel.org>; Thu, 25 Aug 2022 14:37:36 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 468AE3CA41C
	for <ltp@archiver.kernel.org>; Thu, 25 Aug 2022 16:37:35 +0200 (CEST)
Received: from in-3.smtp.seeweb.it (in-3.smtp.seeweb.it [217.194.8.3])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-384))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 3E5313CA47E
 for <ltp@lists.linux.it>; Thu, 25 Aug 2022 16:37:09 +0200 (CEST)
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
 by in-3.smtp.seeweb.it (Postfix) with ESMTP id EA7BA1A00607
 for <ltp@lists.linux.it>; Thu, 25 Aug 2022 16:37:07 +0200 (CEST)
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
 by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 0F697D6E;
 Thu, 25 Aug 2022 07:37:11 -0700 (PDT)
Received: from e129169.arm.com (usa-sjc-imap-foss1.foss.arm.com
 [10.121.207.14])
 by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id A8B663F67D;
 Thu, 25 Aug 2022 07:37:05 -0700 (PDT)
From: Tudor Cretu <tudor.cretu@arm.com>
To: ltp@lists.linux.it
Date: Thu, 25 Aug 2022 15:38:19 +0100
Message-Id: <20220825143819.311023-3-tudor.cretu@arm.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20220825143819.311023-1-tudor.cretu@arm.com>
References: <20220825143819.311023-1-tudor.cretu@arm.com>
MIME-Version: 1.0
X-Virus-Scanned: clamav-milter 0.102.4 at in-3.smtp.seeweb.it
X-Virus-Status: Clean
Subject: [LTP] [PATCH v4 2/2] syscalls/statfs02,
 fstatfs02: Accept segfault instead of EFAULT
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

Allow the tests to pass if segfault is thrown instead of returning EFAULT.

Signed-off-by: Tudor Cretu <tudor.cretu@arm.com>
---
 testcases/kernel/syscalls/fstatfs/fstatfs02.c | 23 ++++++++++++++++++-
 testcases/kernel/syscalls/statfs/statfs02.c   | 23 ++++++++++++++++++-
 2 files changed, 44 insertions(+), 2 deletions(-)

diff --git a/testcases/kernel/syscalls/fstatfs/fstatfs02.c b/testcases/kernel/syscalls/fstatfs/fstatfs02.c
index 4267bd02b..e12ad2b70 100644
--- a/testcases/kernel/syscalls/fstatfs/fstatfs02.c
+++ b/testcases/kernel/syscalls/fstatfs/fstatfs02.c
@@ -9,6 +9,7 @@
  */
 
 #include <errno.h>
+#include <stdlib.h>
 #include <sys/types.h>
 #include <sys/statfs.h>
 #include <sys/wait.h>
@@ -33,7 +34,26 @@ static struct test_case_t {
 
 static void fstatfs_verify(unsigned int n)
 {
-	TST_EXP_FAIL(fstatfs(tests[n].fd, tests[n].sbuf), tests[n].error, "fstatfs()");
+	int pid, status;
+
+	pid = SAFE_FORK();
+	if (!pid) {
+		TST_EXP_FAIL(fstatfs(tests[n].fd, tests[n].sbuf), tests[n].error, "fstatfs()");
+		exit(0);
+	}
+
+	SAFE_WAITPID(pid, &status, 0);
+
+	if (WIFEXITED(status))
+		return;
+
+	if (tests[n].error == EFAULT &&
+	    WIFSIGNALED(status) && WTERMSIG(status) == SIGSEGV) {
+		tst_res(TPASS, "Got SIGSEGV instead of EFAULT");
+		return;
+	}
+
+	tst_res(TFAIL, "Child %s", tst_strstatus(status));
 }
 
 static void setup(void)
@@ -57,4 +77,5 @@ static struct tst_test test = {
 	.setup = setup,
 	.cleanup = cleanup,
 	.needs_tmpdir = 1,
+	.forks_child = 1,
 };
diff --git a/testcases/kernel/syscalls/statfs/statfs02.c b/testcases/kernel/syscalls/statfs/statfs02.c
index f906c84ff..be5e1ee16 100644
--- a/testcases/kernel/syscalls/statfs/statfs02.c
+++ b/testcases/kernel/syscalls/statfs/statfs02.c
@@ -22,6 +22,7 @@
 
 #include <errno.h>
 #include <fcntl.h>
+#include <stdlib.h>
 #include <sys/statfs.h>
 #include <sys/wait.h>
 #include "tst_test.h"
@@ -56,7 +57,26 @@ static void cleanup(void);
 
 static void statfs_verify(unsigned int n)
 {
-	TST_EXP_FAIL(statfs(tests[n].path, tests[n].buf), tests[n].exp_error, "statfs()");
+	int pid, status;
+
+	pid = SAFE_FORK();
+	if (!pid) {
+		TST_EXP_FAIL(statfs(tests[n].path, tests[n].buf), tests[n].exp_error, "statfs()");
+		exit(0);
+	}
+
+	SAFE_WAITPID(pid, &status, 0);
+
+	if (WIFEXITED(status))
+		return;
+
+	if (tests[n].exp_error == EFAULT &&
+	    WIFSIGNALED(status) && WTERMSIG(status) == SIGSEGV) {
+		tst_res(TPASS, "Got SIGSEGV instead of EFAULT");
+		return;
+	}
+
+	tst_res(TFAIL, "Child %s", tst_strstatus(status));
 }
 
 static void setup(void)
@@ -86,4 +106,5 @@ static struct tst_test test = {
 	.setup = setup,
 	.cleanup = cleanup,
 	.needs_tmpdir = 1,
+	.forks_child = 1,
 };
-- 
2.25.1


-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
