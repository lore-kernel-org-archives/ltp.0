Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 83320C433EF
	for <ltp@archiver.kernel.org>; Thu, 10 Feb 2022 03:41:25 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id BB25B3C9DDD
	for <ltp@archiver.kernel.org>; Thu, 10 Feb 2022 04:41:23 +0100 (CET)
Received: from in-7.smtp.seeweb.it (in-7.smtp.seeweb.it
 [IPv6:2001:4b78:1:20::7])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id CA5093C9DDA
 for <ltp@lists.linux.it>; Thu, 10 Feb 2022 04:41:03 +0100 (CET)
Received: from mail1.bemta36.messagelabs.com (mail1.bemta36.messagelabs.com
 [85.158.142.113])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by in-7.smtp.seeweb.it (Postfix) with ESMTPS id 514E7200059
 for <ltp@lists.linux.it>; Thu, 10 Feb 2022 04:41:01 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fujitsu.com;
 s=170520fj; t=1644464461; i=@fujitsu.com;
 bh=AnF8V+2GwCMFXgAbP4lNeePxSuQkFdVlalMdduN8ohk=;
 h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
 MIME-Version:Content-Type;
 b=MwAE5/X/Iox6AQRXK3DOSWkh3wYJxfjLgSbjvyDlImKrnQM7TxwmwnW9BKf4I1yBT
 QJI5k5pyIRH635wX+Tq2sr3I/LUqKhxbzcukQ9lauJAJaWtEY5GYKpM0QS2NhLL6Dc
 qypMrMQTP4l8udhFQxm/2SiYbbnEz2vqn2y3Y4688s0PJicqf6keuBO1Arpr7sKFU6
 RpHoj3z7Uixu2NtNgT6czKp8RAcxy7PMUGr/gCF9sGuzw3ed4rWqjqiS/P+LVn7F14
 AK7p269F2lLLVSyky2vp7ofAOXFsPw8nYM9SnNOf7a5AyVOu1QBX+QJc+WfnfTX5zf
 QHRRwz/bgtWEg==
Received: from [100.115.69.41] (using TLSv1.2 with cipher
 DHE-RSA-AES256-GCM-SHA384 (256 bits))
 by server-4.bemta.az-a.eu-central-1.aws.ess.symcld.net id 04/E7-23802-D4984026;
 Thu, 10 Feb 2022 03:41:01 +0000
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFtrMIsWRWlGSWpSXmKPExsViZ8MxRde3kyX
 J4Mw7ZosV33cwOjB67Pu9jjWAMYo1My8pvyKBNaOp5wp7wRzNiqlXvrE0ML5Q6mLk4hASaGKS
 aOu7zwLh7GGU6LuwnamLkZODTUBT4lnnAmYQW0RAQqKj4S07iM0soC6xfNIvoBoODmEBK4m1b
 2VAwiwCqhKfvu0Aa+UV8JS4efcJWKuEgILElIfvmUHKOYFqDk9iBQkLCahI/P5xghWiXFDi5M
 wnLBDTJSQOvngB1aoocanjGyOEXSExa1Yb0wRG/llIWmYhaVnAyLSK0TapKDM9oyQ3MTNH19D
 AQNfQ0FTXzELXyEQvsUo3US+1VDc5Na+kKBEoq5dYXqyXWlysV1yZm5yTopeXWrKJERiWKcUu
 EjsYb/b91DvEKMnBpCTKq9nGkiTEl5SfUpmRWJwRX1Sak1p8iFGGg0NJgleiESgnWJSanlqRl
 pkDjBGYtAQHj5II7/dWoDRvcUFibnFmOkTqFKOilDjvh3aghABIIqM0D64NFpeXGGWlhHkZGR
 gYhHgKUotyM0tQ5V8xinMwKgnzKnQATeHJzCuBm/4KaDET0OJt05lAFpckIqSkGpis1O4yi0r
 HfhdZJ/zILLhrLt/SILEaAYGYVwu9X+3RfXSeLc/Bp2ru73obx0fMs+ZnW59TdldL4pp6WH6n
 tuT2W/+kbn0WV//8p/mg9q097nYrfeIdlvQ5fWxqbDvpcHVF55J7D5qMqvX4058eTnjtpJS41
 3B+/5F8x7wV7N4MOz2TLLO3ieXlzQ/+83Nl0IbpJyL29WudZ37wgP/tdL25e867S3Fw/vkQso
 H1Lovm1zuuH5iyFkmuncu3/Kces0rLH8bSrwf0z/Fwzby88kUa/+FZi1ZsZlDamXjgo8DES8G
 f9E+4h/H/fduoVZA3N2sfy9aC3rXLni9a9cUqKztm/Y0i8QePHmVJBWrpXP2kxFKckWioxVxU
 nAgAx3TliUYDAAA=
X-Env-Sender: xuyang2018.jy@fujitsu.com
X-Msg-Ref: server-7.tower-532.messagelabs.com!1644464460!43085!1
X-Originating-IP: [62.60.8.148]
X-SYMC-ESS-Client-Auth: outbound-route-from=pass
X-StarScan-Received: 
X-StarScan-Version: 9.81.7; banners=-,-,-
X-VirusChecked: Checked
Received: (qmail 10429 invoked from network); 10 Feb 2022 03:41:01 -0000
Received: from unknown (HELO mailhost1.uk.fujitsu.com) (62.60.8.148)
 by server-7.tower-532.messagelabs.com with ECDHE-RSA-AES256-GCM-SHA384
 encrypted SMTP; 10 Feb 2022 03:41:01 -0000
Received: from R01UKEXCASM126.r01.fujitsu.local ([10.183.43.178])
 by mailhost1.uk.fujitsu.com (8.14.5/8.14.5) with ESMTP id 21A3erRt002560
 (version=TLSv1/SSLv3 cipher=AES256-SHA bits=256 verify=FAIL)
 for <ltp@lists.linux.it>; Thu, 10 Feb 2022 03:41:00 GMT
Received: from localhost.localdomain (10.167.220.84) by
 R01UKEXCASM126.r01.fujitsu.local (10.183.43.178) with Microsoft SMTP Server
 (TLS) id 15.0.1497.28; Thu, 10 Feb 2022 03:40:51 +0000
From: Yang Xu <xuyang2018.jy@fujitsu.com>
To: <ltp@lists.linux.it>
Date: Thu, 10 Feb 2022 11:41:16 +0800
Message-ID: <1644464477-16644-1-git-send-email-xuyang2018.jy@fujitsu.com>
X-Mailer: git-send-email 1.8.3.1
In-Reply-To: <YgPNWHc+xwKCRcvv@pevik>
References: <YgPNWHc+xwKCRcvv@pevik>
MIME-Version: 1.0
X-Originating-IP: [10.167.220.84]
X-ClientProxiedBy: G08CNEXCHPEKD07.g08.fujitsu.local (10.167.33.80) To
 R01UKEXCASM126.r01.fujitsu.local (10.183.43.178)
X-Virus-Scanned: clamav-milter 0.102.4 at in-7.smtp.seeweb.it
X-Virus-Status: Clean
Subject: [LTP] [PATCH v2 1/2] syscalls/pidfd_open: Simplify code
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

1) make use of TST_EXP_FAIL2 or TST_EXP_FD_SILENT macros
2) remove min_kver check and use pidfd_open_supported()
3) Add docparse formatting

Reviewed-by: Cyril Hrubis <chrubis@suse.cz>
Reviewed-by: Petr Vorel <pvorel@suse.cz>
Signed-off-by: Yang Xu <xuyang2018.jy@fujitsu.com>
---
 include/lapi/pidfd_open.h                     |  8 +++--
 .../kernel/syscalls/pidfd_open/pidfd_open01.c | 17 +++++-----
 .../kernel/syscalls/pidfd_open/pidfd_open02.c | 34 +++++++------------
 .../kernel/syscalls/pidfd_open/pidfd_open03.c | 11 +++---
 4 files changed, 34 insertions(+), 36 deletions(-)

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
index f40e9b624..c0e88647f 100644
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
+	TST_EXP_FD_SILENT(pidfd_open(getpid(), 0), "pidfd_open(getpid(), 0)");
 
 	flag = fcntl(TST_RET, F_GETFD);
 
@@ -36,6 +37,6 @@ static void run(void)
 }
 
 static struct tst_test test = {
-	.min_kver = "5.3",
+	.setup = pidfd_open_supported,
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
index 48470e5e1..7c7c75cb1 100644
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
+	TST_EXP_FD_SILENT(pidfd_open(pid, 0), "pidfd_open(%d, 0)", pid);
 
 	fd = TST_RET;
-	if (fd == -1)
-		tst_brk(TFAIL | TTERRNO, "pidfd_open() failed");
 
 	TST_CHECKPOINT_WAKE(0);
 
@@ -50,7 +51,7 @@ static void run(void)
 }
 
 static struct tst_test test = {
-	.min_kver = "5.3",
+	.setup = pidfd_open_supported,
 	.test_all = run,
 	.forks_child = 1,
 	.needs_checkpoints = 1,
-- 
2.23.0


-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
