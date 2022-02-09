Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6FD2EC4332F
	for <ltp@archiver.kernel.org>; Wed,  9 Feb 2022 09:42:20 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 7A8A53C9B71
	for <ltp@archiver.kernel.org>; Wed,  9 Feb 2022 10:42:18 +0100 (CET)
Received: from in-6.smtp.seeweb.it (in-6.smtp.seeweb.it
 [IPv6:2001:4b78:1:20::6])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id E362B3C6912
 for <ltp@lists.linux.it>; Wed,  9 Feb 2022 10:42:07 +0100 (CET)
Received: from mail1.bemta34.messagelabs.com (mail1.bemta34.messagelabs.com
 [195.245.231.4])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by in-6.smtp.seeweb.it (Postfix) with ESMTPS id 3AD5E1400E62
 for <ltp@lists.linux.it>; Wed,  9 Feb 2022 10:42:05 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fujitsu.com;
 s=170520fj; t=1644399725; i=@fujitsu.com;
 bh=rN+zOCNiEmW7bLqnjOVaQdUnK1d9awlei7Mb1P5KaIs=;
 h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type;
 b=l7kW6yR8eRO8El/E4+qhzyU4hd9uoRyx5rLg+ViB4TG5NGt04L/ktqt1x37ORurzY
 E/ON8pi22H+BVIfFoxmwKHy3Gz8X2aj0Wxe6YKjZzujExUacJGi4zX5P9I1RffS91R
 dSV7QNxiVWf715BLhntuOyyVi8Lvtv6jNjx1PLhZSffcwiRv/kwJbSiZZeP4VC84BW
 cBCxgbvtWnHb3V9c07sCa/VVg5tYKunhq+2HGtQBqaNRZEJU8IxMHfejZZWmfu3nGC
 48nLiVOBHGG0z2hT9OramZJbjhCNNTKK8eFJF2uajKVuOedMobwWu1Szb4zNIFqi4F
 WtCA4FkeZOliQ==
Received: from [100.115.34.36] (using TLSv1.2 with cipher
 DHE-RSA-AES256-GCM-SHA384 (256 bits))
 by server-4.bemta.az-a.eu-west-2.aws.ess.symcld.net id B0/8E-29321-D6C83026;
 Wed, 09 Feb 2022 09:42:05 +0000
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFtrIIsWRWlGSWpSXmKPExsViZ8ORqJvTw5x
 k8G6qjcWK7zsYHRg99v1exxrAGMWamZeUX5HAmnG2kbWgXavi8LYOtgbG/cpdjFwcQgJnGSXm
 /XzP3sXICeTsZJJ4+TUAIrGbUWJLywSwBJuApsSzzgXMILaIgIRER8NbsDizgLrE8km/mLoYO
 TiEBcwl2n/HgYRZBFQkvrzpYwGxeQU8JI7uuMIGYksIKEhMefieGSIuKHFy5hMWiDESEgdfvG
 CGqFGUuNTxjRHCrpCYNauNCcJWk7h6bhPzBEb+WUjaZyFpX8DItIrROqkoMz2jJDcxM0fX0MB
 A19DQVNfYUtfIwEAvsUo3US+1VLc8tbhE10gvsbxYL7W4WK+4Mjc5J0UvL7VkEyMwJFOK1U/s
 YHy68qfeIUZJDiYlUd7+mUxJQnxJ+SmVGYnFGfFFpTmpxYcYZTg4lCR4N1cwJwkJFqWmp1akZ
 eYA4wMmLcHBoyTCO6UbKM1bXJCYW5yZDpE6xagoJc67FiQhAJLIKM2Da4PF5CVGWSlhXkYGBg
 YhnoLUotzMElT5V4ziHIxKwrwttUBTeDLzSuCmvwJazAS0eNt0JpDFJYkIKakGJrYyh+r8fTP
 i9/ZuLVwrfiOI6YRvH7up8WrTG1z81dH+b2L/9l0MUsje2zJ3T9Jbi+PdLjciOLOuP/0qIXYi
 IvbH9rR6+8urLlTutrB89sk3fm1IZF7g98R9pWs0+C4vWMqd0Mf8Zq+BX6qB5tF7bYe6/i9cK
 LOtcRfHld8Pjy5sr4myY9t54ZDK2j2bnqyIUpb8V3TueWDOorMfzqQysc//OTvsueBF2YiHp5
 /mK6cEpF4rLwuz9N/o7DA3YeOewzPsbp+dmeMg/z9wbfW0ReKV3TmnPT6+aP259Vy/z5Xt0Vm
 X+TX2+13bV+TVLqJ9aULpurkTN22cOL98zv0dbS8Zj8VP9JIvX5ctNelXrYwSS3FGoqEWc1Fx
 IgDZF3T+RAMAAA==
X-Env-Sender: xuyang2018.jy@fujitsu.com
X-Msg-Ref: server-8.tower-548.messagelabs.com!1644399724!2626!1
X-Originating-IP: [62.60.8.97]
X-SYMC-ESS-Client-Auth: outbound-route-from=pass
X-StarScan-Received: 
X-StarScan-Version: 9.81.7; banners=-,-,-
X-VirusChecked: Checked
Received: (qmail 8482 invoked from network); 9 Feb 2022 09:42:04 -0000
Received: from unknown (HELO n03ukasimr01.n03.fujitsu.local) (62.60.8.97)
 by server-8.tower-548.messagelabs.com with ECDHE-RSA-AES256-GCM-SHA384
 encrypted SMTP; 9 Feb 2022 09:42:04 -0000
Received: from n03ukasimr01.n03.fujitsu.local (localhost [127.0.0.1])
 by n03ukasimr01.n03.fujitsu.local (Postfix) with ESMTP id 866651001A4
 for <ltp@lists.linux.it>; Wed,  9 Feb 2022 09:42:04 +0000 (GMT)
Received: from R01UKEXCASM126.r01.fujitsu.local (unknown [10.183.43.178])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-SHA384 (256/256 bits))
 (No client certificate requested)
 by n03ukasimr01.n03.fujitsu.local (Postfix) with ESMTPS id 7927910019B
 for <ltp@lists.linux.it>; Wed,  9 Feb 2022 09:42:04 +0000 (GMT)
Received: from localhost.localdomain (10.167.220.84) by
 R01UKEXCASM126.r01.fujitsu.local (10.183.43.178) with Microsoft SMTP Server
 (TLS) id 15.0.1497.28; Wed, 9 Feb 2022 09:41:54 +0000
From: Yang Xu <xuyang2018.jy@fujitsu.com>
To: <ltp@lists.linux.it>
Date: Wed, 9 Feb 2022 17:42:17 +0800
Message-ID: <1644399738-2155-1-git-send-email-xuyang2018.jy@fujitsu.com>
X-Mailer: git-send-email 1.8.3.1
MIME-Version: 1.0
X-Originating-IP: [10.167.220.84]
X-ClientProxiedBy: G08CNEXCHPEKD07.g08.fujitsu.local (10.167.33.80) To
 R01UKEXCASM126.r01.fujitsu.local (10.183.43.178)
X-Virus-Scanned: clamav-milter 0.102.4 at in-6.smtp.seeweb.it
X-Virus-Status: Clean
Subject: [LTP] [PATCH 1/2] syscalls/pidfd_open: Simplify code
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

1) make use of TST_EXP_FAIL2 or TST_EXP_PID_SILENT macros
2) remove min_kver check and use pidfd_open_supported()
3) Add docparse formatting

Signed-off-by: Yang Xu <xuyang2018.jy@fujitsu.com>
---
 include/lapi/pidfd_open.h                     |  8 +++--
 .../kernel/syscalls/pidfd_open/pidfd_open01.c | 22 +++++++-----
 .../kernel/syscalls/pidfd_open/pidfd_open02.c | 34 +++++++------------
 .../kernel/syscalls/pidfd_open/pidfd_open03.c | 16 ++++++---
 4 files changed, 44 insertions(+), 36 deletions(-)

diff --git a/include/lapi/pidfd_open.h b/include/lapi/pidfd_open.h
index 9806c73d4..5cf10933e 100644
--- a/include/lapi/pidfd_open.h
+++ b/include/lapi/pidfd_open.h
@@ -9,11 +9,15 @@
 
 #include <sys/syscall.h>
 #include <sys/types.h>
-
 #include "lapi/syscalls.h"
-
 #include "config.h"
 
+static inline void pidfd_open_supported(void)
+{
+	/* allow the tests to fail early */
+	tst_syscall(__NR_pidfd_open);
+}
+
 #ifndef HAVE_PIDFD_OPEN
 static inline int pidfd_open(pid_t pid, unsigned int flags)
 {
diff --git a/testcases/kernel/syscalls/pidfd_open/pidfd_open01.c b/testcases/kernel/syscalls/pidfd_open/pidfd_open01.c
index f40e9b624..ed9b82637 100644
--- a/testcases/kernel/syscalls/pidfd_open/pidfd_open01.c
+++ b/testcases/kernel/syscalls/pidfd_open/pidfd_open01.c
@@ -1,11 +1,15 @@
 // SPDX-License-Identifier: GPL-2.0-or-later
 /*
  * Copyright (c) 2020 Viresh Kumar <viresh.kumar@linaro.org>
+ */
+
+/*\
+ * [Description]
  *
- * Description:
  * Basic pidfd_open() test:
- * 1) Fetch the PID of the current process and try to get its file descriptor.
- * 2) Check that the close-on-exec flag is set on the file descriptor.
+ *
+ * - Fetch the PID of the current process and try to get its file descriptor.
+ * - Check that the close-on-exec flag is set on the file descriptor.
  */
 
 #include <unistd.h>
@@ -17,10 +21,7 @@ static void run(void)
 {
 	int flag;
 
-	TEST(pidfd_open(getpid(), 0));
-
-	if (TST_RET == -1)
-		tst_brk(TFAIL | TTERRNO, "pidfd_open(getpid(), 0) failed");
+	TST_EXP_PID_SILENT(pidfd_open(getpid(), 0), "pidfd_open(getpid(), 0)");
 
 	flag = fcntl(TST_RET, F_GETFD);
 
@@ -35,7 +36,12 @@ static void run(void)
 	tst_res(TPASS, "pidfd_open(getpid(), 0) passed");
 }
 
+static void setup(void)
+{
+	pidfd_open_supported();
+}
+
 static struct tst_test test = {
-	.min_kver = "5.3",
+	.setup = setup,
 	.test_all = run,
 };
diff --git a/testcases/kernel/syscalls/pidfd_open/pidfd_open02.c b/testcases/kernel/syscalls/pidfd_open/pidfd_open02.c
index dc86cae7a..93a61a51d 100644
--- a/testcases/kernel/syscalls/pidfd_open/pidfd_open02.c
+++ b/testcases/kernel/syscalls/pidfd_open/pidfd_open02.c
@@ -1,14 +1,21 @@
 // SPDX-License-Identifier: GPL-2.0-or-later
 /*
  * Copyright (c) 2020 Viresh Kumar <viresh.kumar@linaro.org>
+ */
+
+/*\
+ * [Description]
+ *
+ * Tests basic error handling of the pidfd_open syscall.
  *
- * Description:
- * Basic pidfd_open() test to test invalid arguments.
+ * - ESRCH the process specified by pid does not exist
+ * - EINVAL pid is not valid
+ * - EINVAL flags is not valid
  */
 #include "tst_test.h"
 #include "lapi/pidfd_open.h"
 
-pid_t expired_pid, my_pid, invalid_pid = -1;
+static pid_t expired_pid, my_pid, invalid_pid = -1;
 
 static struct tcase {
 	char *name;
@@ -23,6 +30,7 @@ static struct tcase {
 
 static void setup(void)
 {
+	pidfd_open_supported();
 	expired_pid = tst_get_unused_pid();
 	my_pid = getpid();
 }
@@ -31,27 +39,11 @@ static void run(unsigned int n)
 {
 	struct tcase *tc = &tcases[n];
 
-	TEST(pidfd_open(*tc->pid, tc->flags));
-
-	if (TST_RET != -1) {
-		SAFE_CLOSE(TST_RET);
-		tst_res(TFAIL, "%s: pidfd_open succeeded unexpectedly (index: %d)",
-			tc->name, n);
-		return;
-	}
-
-	if (tc->exp_errno != TST_ERR) {
-		tst_res(TFAIL | TTERRNO, "%s: pidfd_open() should fail with %s",
-			tc->name, tst_strerrno(tc->exp_errno));
-		return;
-	}
-
-	tst_res(TPASS | TTERRNO, "%s: pidfd_open() failed as expected",
-		tc->name);
+	TST_EXP_FAIL2(pidfd_open(*tc->pid, tc->flags), tc->exp_errno,
+			"pidfd_open with %s", tc->name);
 }
 
 static struct tst_test test = {
-	.min_kver = "5.3",
 	.tcnt = ARRAY_SIZE(tcases),
 	.test = run,
 	.setup = setup,
diff --git a/testcases/kernel/syscalls/pidfd_open/pidfd_open03.c b/testcases/kernel/syscalls/pidfd_open/pidfd_open03.c
index 48470e5e1..f41afa2fc 100644
--- a/testcases/kernel/syscalls/pidfd_open/pidfd_open03.c
+++ b/testcases/kernel/syscalls/pidfd_open/pidfd_open03.c
@@ -1,8 +1,11 @@
 // SPDX-License-Identifier: GPL-2.0-or-later
 /*
  * Copyright (c) 2020 Viresh Kumar <viresh.kumar@linaro.org>
+ */
+
+/*\
+ * [Description]
  *
- * Description:
  * This program opens the PID file descriptor of the child process created with
  * fork(). It then uses poll to monitor the file descriptor for process exit, as
  * indicated by an EPOLLIN event.
@@ -27,11 +30,9 @@ static void run(void)
 		exit(EXIT_SUCCESS);
 	}
 
-	TEST(pidfd_open(pid, 0));
+	TST_EXP_PID_SILENT(pidfd_open(pid, 0), "pidfd_open(%d, 0)", pid);
 
 	fd = TST_RET;
-	if (fd == -1)
-		tst_brk(TFAIL | TTERRNO, "pidfd_open() failed");
 
 	TST_CHECKPOINT_WAKE(0);
 
@@ -49,8 +50,13 @@ static void run(void)
 		tst_res(TPASS, "pidfd_open() passed");
 }
 
+static void setup(void)
+{
+	pidfd_open_supported();
+}
+
 static struct tst_test test = {
-	.min_kver = "5.3",
+	.setup = setup,
 	.test_all = run,
 	.forks_child = 1,
 	.needs_checkpoints = 1,
-- 
2.23.0


-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
