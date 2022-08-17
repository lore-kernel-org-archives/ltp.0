Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 95ABDC25B08
	for <ltp@archiver.kernel.org>; Wed, 17 Aug 2022 13:39:42 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id B55263C9FF0
	for <ltp@archiver.kernel.org>; Wed, 17 Aug 2022 15:39:40 +0200 (CEST)
Received: from in-3.smtp.seeweb.it (in-3.smtp.seeweb.it [217.194.8.3])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-384))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 849C93C9FD5
 for <ltp@lists.linux.it>; Wed, 17 Aug 2022 15:38:50 +0200 (CEST)
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
 by in-3.smtp.seeweb.it (Postfix) with ESMTP id 8A2531A002EA
 for <ltp@lists.linux.it>; Wed, 17 Aug 2022 15:38:49 +0200 (CEST)
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
 by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 65D93113E;
 Wed, 17 Aug 2022 06:38:48 -0700 (PDT)
Received: from e129169.arm.com (usa-sjc-imap-foss1.foss.arm.com
 [10.121.207.14])
 by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 0D4CA3F67D;
 Wed, 17 Aug 2022 06:38:46 -0700 (PDT)
From: Tudor Cretu <tudor.cretu@arm.com>
To: ltp@lists.linux.it
Date: Wed, 17 Aug 2022 14:39:46 +0100
Message-Id: <20220817133946.234985-5-tudor.cretu@arm.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20220817133946.234985-1-tudor.cretu@arm.com>
References: <20220817133946.234985-1-tudor.cretu@arm.com>
MIME-Version: 1.0
X-Virus-Scanned: clamav-milter 0.102.4 at in-3.smtp.seeweb.it
X-Virus-Status: Clean
Subject: [LTP] [PATCH 4/4] syscalls/statfs: Avoid dereferencing invalid buf
 in libc
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

To avoid dereferencing an invalid buf in libc, bypass the [f]statfs wrapper
and call the syscall directly. Consistently with the libc wrappers,
choose [f]statfs64 instead of [f]statfs if the target supports it.

Signed-off-by: Tudor Cretu <tudor.cretu@arm.com>
---
 testcases/kernel/syscalls/fstatfs/fstatfs02.c | 7 ++++++-
 testcases/kernel/syscalls/statfs/statfs02.c   | 7 ++++++-
 2 files changed, 12 insertions(+), 2 deletions(-)

diff --git a/testcases/kernel/syscalls/fstatfs/fstatfs02.c b/testcases/kernel/syscalls/fstatfs/fstatfs02.c
index db2230f82..c1af07070 100644
--- a/testcases/kernel/syscalls/fstatfs/fstatfs02.c
+++ b/testcases/kernel/syscalls/fstatfs/fstatfs02.c
@@ -25,6 +25,7 @@
 #include <sys/types.h>
 #include <sys/statfs.h>
 #include <errno.h>
+#include "lapi/syscalls.h"
 #include "test.h"
 #include "safe_macros.h"
 
@@ -68,7 +69,11 @@ int main(int ac, char **av)
 
 		for (i = 0; i < TST_TOTAL; i++) {
 
-			TEST(fstatfs(TC[i].fd, TC[i].sbuf));
+#if __NR_fstatfs64 != __LTP__NR_INVALID_SYSCALL
+			TEST(tst_syscall(__NR_fstatfs64, TC[i].fd, TC[i].sbuf));
+#else
+			TEST(tst_syscall(__NR_fstatfs, TC[i].fd, TC[i].sbuf));
+#endif
 
 			if (TEST_RETURN != -1) {
 				tst_resm(TFAIL, "call succeeded unexpectedly");
diff --git a/testcases/kernel/syscalls/statfs/statfs02.c b/testcases/kernel/syscalls/statfs/statfs02.c
index 279665f86..e1afbda39 100644
--- a/testcases/kernel/syscalls/statfs/statfs02.c
+++ b/testcases/kernel/syscalls/statfs/statfs02.c
@@ -39,6 +39,7 @@
 #include <sys/vfs.h>
 #include <sys/mman.h>
 #include <errno.h>
+#include "lapi/syscalls.h"
 #include "test.h"
 #include "safe_macros.h"
 
@@ -116,7 +117,11 @@ static void setup(void)
 
 static void statfs_verify(const struct test_case_t *test)
 {
-	TEST(statfs(test->path, test->buf));
+#if __NR_statfs64 != __LTP__NR_INVALID_SYSCALL
+	TEST(tst_syscall(__NR_statfs64, test->path, test->buf));
+#else
+	TEST(tst_syscall(__NR_statfs, test->path, test->buf));
+#endif
 
 	if (TEST_RETURN != -1) {
 		tst_resm(TFAIL, "call succeeded unexpectedly");
-- 
2.25.1


-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
