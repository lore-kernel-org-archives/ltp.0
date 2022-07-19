Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 84889C433EF
	for <ltp@archiver.kernel.org>; Tue, 19 Jul 2022 02:41:24 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id BB9AA3C9582
	for <ltp@archiver.kernel.org>; Tue, 19 Jul 2022 04:41:21 +0200 (CEST)
Received: from in-3.smtp.seeweb.it (in-3.smtp.seeweb.it
 [IPv6:2001:4b78:1:20::3])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-384))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id B72693C9528
 for <ltp@lists.linux.it>; Tue, 19 Jul 2022 04:41:11 +0200 (CEST)
Received: from loongson.cn (mail.loongson.cn [114.242.206.163])
 by in-3.smtp.seeweb.it (Postfix) with ESMTP id 4EFC81A01550
 for <ltp@lists.linux.it>; Tue, 19 Jul 2022 04:41:07 +0200 (CEST)
Received: from localhost.localdomain.localdomain (unknown [10.2.5.46])
 by mail.loongson.cn (Coremail) with SMTP id AQAAf9Dxf+O6GdZibrEnAA--.9838S2;
 Tue, 19 Jul 2022 10:41:04 +0800 (CST)
From: Hongchen Zhang <zhanghongchen@loongson.cn>
To: Cyril Hrubis <chrubis@suse.cz>,
	Jan Stancek <jstancek@redhat.com>
Date: Tue, 19 Jul 2022 10:40:56 +0800
Message-Id: <1658198456-20565-1-git-send-email-zhanghongchen@loongson.cn>
X-Mailer: git-send-email 1.8.3.1
X-CM-TRANSID: AQAAf9Dxf+O6GdZibrEnAA--.9838S2
X-Coremail-Antispam: 1UD129KBjvJXoW3GF15tFW3CFykKF1kWF4xCrg_yoWxKrWUpF
 yxGw48Kr4kJFy8Gr4xCws7Zr15GrsxGay5Wr40y3yFvwn8Aw1Uta1jvFy7AryUJrWvgFy3
 Way0yrWrW3WUJr7anT9S1TB71UUUUUUqnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
 9KBjDU0xBIdaVrnRJUUUkv14x267AKxVWUJVW8JwAFc2x0x2IEx4CE42xK8VAvwI8IcIk0
 rVWrJVCq3wAFIxvE14AKwVWUJVWUGwA2ocxC64kIII0Yj41l84x0c7CEw4AK67xGY2AK02
 1l84ACjcxK6xIIjxv20xvE14v26ryj6F1UM28EF7xvwVC0I7IYx2IY6xkF7I0E14v26r4U
 JVWxJr1l84ACjcxK6I8E87Iv67AKxVW8Jr0_Cr1UM28EF7xvwVC2z280aVCY1x0267AKxV
 WxJr0_GcWle2I262IYc4CY6c8Ij28IcVAaY2xG8wAqx4xG64xvF2IEw4CE5I8CrVC2j2Wl
 Yx0E2Ix0cI8IcVAFwI0_Jr0_Jr4lYx0Ex4A2jsIE14v26r1j6r4UMcvjeVCFs4IE7xkEbV
 WUJVW8JwACjcxG0xvY0x0EwIxGrwACjI8F5VA0II8E6IAqYI8I648v4I1lc2xSY4AK6svP
 MxAIw28IcxkI7VAKI48JMxC20s026xCaFVCjc4AY6r1j6r4UMI8I3I0E5I8CrVAFwI0_Jr
 0_Jr4lx2IqxVCjr7xvwVAFwI0_JrI_JrWlx4CE17CEb7AF67AKxVWUAVWUtwCIc40Y0x0E
 wIxGrwCI42IY6xIIjxv20xvE14v26r1j6r1xMIIF0xvE2Ix0cI8IcVCY1x0267AKxVWUJV
 W8JwCI42IY6xAIw20EY4v20xvaj40_WFyUJVCq3wCI42IY6I8E87Iv67AKxVWUJVW8JwCI
 42IY6I8E87Iv6xkF7I0E14v26r1j6r4UYxBIdaVFxhVjvjDU0xZFpf9x0JUywZ7UUUUU=
X-CM-SenderInfo: x2kd0w5krqwupkhqwqxorr0wxvrqhubq/
X-Virus-Scanned: clamav-milter 0.102.4 at in-3.smtp.seeweb.it
X-Virus-Status: Clean
Subject: [LTP] [PATCH v2] syslog11: convert to new LTP API
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
Cc: Lingling Li <lilingling@loongson.cn>, ltp@lists.linux.it,
 Hongchen Zhang <zhanghongchen@loongson.cn>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: ltp-bounces+ltp=archiver.kernel.org@lists.linux.it
Sender: "ltp" <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>

convert to use new LTP API for syslog11.

Signed-off-by: Hongchen Zhang <zhanghongchen@loongson.cn>
Signed-off-by: Lingling Li <lilingling@loongson.cn>
---
 testcases/kernel/syscalls/syslog/syslog11.c | 215 +++++-----------------------
 1 file changed, 34 insertions(+), 181 deletions(-)

diff --git a/testcases/kernel/syscalls/syslog/syslog11.c b/testcases/kernel/syscalls/syslog/syslog11.c
index b9540ef..89f12f8 100644
--- a/testcases/kernel/syscalls/syslog/syslog11.c
+++ b/testcases/kernel/syscalls/syslog/syslog11.c
@@ -1,212 +1,65 @@
+// SPDX-License-Identifier: GPL-2.0-or-later
 /*
- * Copyright (c) Wipro Technologies Ltd, 2002.  All Rights Reserved.
- *
- * This program is free software; you can redistribute it and/or modify it
- * under the terms of version 2 of the GNU General Public License as
- * published by the Free Software Foundation.
- *
- * This program is distributed in the hope that it would be useful, but
- * WITHOUT ANY WARRANTY; without even the implied warranty of
- * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.
- *
- * You should have received a copy of the GNU General Public License along
- * with this program; if not, write the Free Software Foundation, Inc.,
- * 51 Franklin Street, Fifth Floor, Boston, MA 02110-1301 USA.
- *
+ * Author: Madhu T L <madhu.tarikere@wipro.com>
  */
-/**********************************************************
- *
- *    TEST IDENTIFIER   : syslog11
- *
- *    EXECUTED BY       : root / superuser
- *
- *    TEST TITLE        : Basic tests for syslog(2)
- *
- *    TEST CASE TOTAL   : 11
- *
- *    AUTHOR            : Madhu T L <madhu.tarikere@wipro.com>
- *
- *    SIGNALS
- *      Uses SIGUSR1 to pause before test if option set.
- *      (See the parse_opts(3) man page).
- *
- *    DESCRIPTION
- *	Verify that, syslog(2) is successful for type ranging from 1 to 8
- *
- *	Setup:
- *	  Setup signal handling.
- *	  Test caller is superuser
- *	  Check existence of user nobody
- *	  Pause for SIGUSR1 if option specified.
- *
- *	Test:
- *	 Loop if the proper options are given.
- *	  Execute system call
- *	  Check return value, if not successful,
- *		 Issue FAIL message
- *	  Otherwise,
- *		Issue PASS message
- *
- *	Cleanup:
- *	  Print errno log and/or timing stats if options given
- *
- * USAGE:  <for command-line>
- *  syslog11 [-c n] [-e] [-f] [-h] [-i n] [-I x] [-p] [-P x] [-t]
- *		where,  -c n : Run n copies concurrently.
- *			-e   : Turn on errno logging.
- *			-f   : Turn off functional testing
- *			-h   : Show help screen
- *			-i n : Execute test n times.
- *			-I x : Execute test for x seconds.
- *			-p   : Pause for SIGUSR1 before starting
- *			-P x : Pause for x seconds between iterations.
- *			-t   : Turn on syscall timing.
+
+/*
+ * [Description]
+ * Verify that, syslog(2) is successful for type ranging from 1 to 8
  *
- ****************************************************************/
+ */
 
 #include <errno.h>
-#include <pwd.h>
-#include <sys/types.h>
-#include <unistd.h>
-#include <linux/unistd.h>
-#include <sys/syscall.h>
-#include "test.h"
-#include "safe_macros.h"
 
-#define UNEXP_RET_VAL	-1
+#include "tst_test.h"
+#include "lapi/syscalls.h"
+#include "tst_safe_macros.h"
 
-struct test_case_t {		/* test case structure */
+struct tcase {		/* test case structure */
 	int type;		/* 1st arg. */
 	char *buf;		/* 2nd arg. */
 	int len;		/* 3rd arg. */
-	int (*setup) (void);	/* Individual setup routine */
-	void (*cleanup) (void);	/* Individual cleanup routine */
 	char *desc;		/* Test description */
 };
 
-char *TCID = "syslog11";
-static int testno;
 static char buf;
-static struct passwd *ltpuser;
-
-static void setup(void);
-static void cleanup(void);
-static int setup1(void);
-static void cleanup1(void);
 
-#define syslog(arg1, arg2, arg3) syscall(__NR_syslog, arg1, arg2, arg3)
+#define syslog(arg1, arg2, arg3) tst_syscall(__NR_syslog, arg1, arg2, arg3)
 
-static struct test_case_t tdat[] = {
+static struct tcase tcases[] = {
 	/* Type 0 and 1 are currently not implemented, always returns success */
 	{0, &buf, 0, NULL, NULL, "type 0/Close the log"},
 	{1, &buf, 0, NULL, NULL, "type 1/Open the log"},
 	{2, &buf, 0, NULL, NULL, "type 2/Read from the log"},
 	{3, &buf, 0, NULL, NULL, "type 3/Read ring buffer"},
-	{3, &buf, 0, setup1, cleanup1, "type 3/Read ring buffer for non-root "
-	 "user"},
-	/* Next two lines will clear dmesg. Uncomment if that is okay. -Robbie Williamson */
-	/*    { 4, &buf, 0, NULL, NULL, "type 4/Read and clear ring buffer" },            */
-	/*    { 5, &buf, 0, NULL, NULL, "type 5/Clear ring buffer" },                     */
-
+	/*
+	 * Next two lines will clear dmesg.
+	 * Uncomment if that is okay. -Robbie Williamson
+	 */
+	/*
+	 * { 4, &buf, 0, NULL, NULL, "type 4/Read and clear ring buffer" },
+	 * { 5, &buf, 0, NULL, NULL, "type 5/Clear ring buffer" },
+	 */
 	{8, NULL, 1, NULL, NULL, "type 8/Set log level to 1"},
 	{8, NULL, 7, NULL, NULL, "type 8/Set log level to 7(default)"},
 	{6, NULL, 0, NULL, NULL, "type 6/Disable printk's to console"},
 	{7, NULL, 0, NULL, NULL, "type 7/Enable printk's to console"},
 };
 
-int TST_TOTAL = sizeof(tdat) / sizeof(tdat[0]);
-
-int main(int argc, char **argv)
+static void run(unsigned int n)
 {
-	int lc;
-
-	tst_parse_opts(argc, argv, NULL, NULL);
-	setup();
-
-	for (lc = 0; TEST_LOOPING(lc); lc++) {
-		/* reset tst_count in case we are looping */
-		tst_count = 0;
-
-		for (testno = 0; testno < TST_TOTAL; ++testno) {
+	struct tcase *tc = &tcases[n];
 
-			if (tdat[testno].setup && tdat[testno].setup()) {
-				/* Setup failed, skip this testcase */
-				continue;
-			}
-
-			TEST(syslog(tdat[testno].type, tdat[testno].buf,
-				    tdat[testno].len));
-
-			if (TEST_RETURN == UNEXP_RET_VAL) {
-				if (TEST_ERRNO == EPERM && geteuid() != 0) {
-					tst_resm(TPASS,
-						 "syslog() passed for %s (non-root EPERM is OK)",
-						 tdat[testno].desc);
-				} else {
-					tst_resm(TFAIL,
-						 "syslog() failed for %s: errno "
-						 "%d (%s)", tdat[testno].desc,
-						 TEST_ERRNO, strerror(errno));
-				}
-			} else {
-				tst_resm(TPASS, "syslog() successful for %s",
-					 tdat[testno].desc);
-			}
-
-			if (tdat[testno].cleanup) {
-				tdat[testno].cleanup();
-			}
-		}
-	}
-	cleanup();
-
-	tst_exit();
-}
-
-int setup1(void)
-{
-	/* Change effective user id to nodody */
-	if (seteuid(ltpuser->pw_uid) == -1) {
-		tst_resm(TBROK, "seteuid failed to set the effective"
-			 " uid to %d", ltpuser->pw_uid);
-		return 1;
-	}
-	return 0;
+	TST_EXP_PASS(syslog(tc->type, tc->buf, tc->len),
+			"syslog() with %s", tc->desc);
 }
 
-void cleanup1(void)
-{
-	/* Change effective user id to root */
-	SAFE_SETEUID(NULL, 0);
-}
-
-/*
- * setup()
- *	performs all ONE TIME setup for this test
- */
-void setup(void)
-{
-	tst_require_root();
-
-	tst_sig(NOFORK, DEF_HANDLER, cleanup);
-
-	/* Check for nobody_uid user id */
-	if ((ltpuser = getpwnam("nobody")) == NULL) {
-		tst_brkm(TBROK, NULL, "nobody user id doesn't exist");
-	}
-
-	/* Pause if that option was specified
-	 * TEST_PAUSE contains the code to fork the test with the -c option.
-	 */
-	TEST_PAUSE;
-}
-
-/*
- * cleanup()
- *	performs all ONE TIME cleanup for this test at
- *	completion or premature exit
- */
-void cleanup(void)
-{
-
-}
+static struct tst_test test = {
+	.test = run,
+	.save_restore = (const struct tst_path_val[]) {
+		{"!/proc/sys/kernel/printk", NULL},
+		{NULL, NULL}
+	},
+	.needs_root = 1,
+	.tcnt = ARRAY_SIZE(tcases),
+};
-- 
1.8.3.1


-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
