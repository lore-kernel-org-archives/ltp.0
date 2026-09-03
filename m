Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6132AC624A4
	for <ltp@archiver.kernel.org>; Thu,  3 Sep 2026 12:52:27 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id AFA013EAD7C
	for <ltp@archiver.kernel.org>; Thu,  3 Sep 2026 14:52:25 +0200 (CEST)
Received: from in-5.smtp.seeweb.it (in-5.smtp.seeweb.it [217.194.8.5])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 76F893E9A79
 for <ltp@lists.linux.it>; Thu,  3 Sep 2026 14:52:09 +0200 (CEST)
Received: from smtp-out2.suse.de (smtp-out2.suse.de
 [IPv6:2a07:de40:b251:101:10:150:64:2])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-5.smtp.seeweb.it (Postfix) with ESMTPS id ACCF6600769
 for <ltp@lists.linux.it>; Thu,  3 Sep 2026 14:52:08 +0200 (CEST)
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-out2.suse.de (Postfix) with ESMTPS id 6D6781FD33;
 Thu,  3 Sep 2026 12:51:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
 t=1788439923; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=MXbm5dytOoHQFJsZViPT1Sp7UcKX7jDsgnveR3uJ5uo=;
 b=tg8VJAaLyG0/k16CD7rIFZtY0MqQJZCkPmXcqs/DaEqh9jAz8pxbiWMu0ovoqggFELEgUS
 3sLdvrVZyxei9fphx6mAaWO9pdyADW5lYPsNc8pMbBLXubyhSUzkju029LGtBAfmXDsHS4
 FN2gbmqgTRCmP0grN1agrM94kXHkOnM=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_ed25519; t=1788439923;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=MXbm5dytOoHQFJsZViPT1Sp7UcKX7jDsgnveR3uJ5uo=;
 b=QztD1K4UHO5lIGhxks61S7qT24dRC5ERRE/MWiXOYesVGRlRBeModB0IxkfiGRuZiMCmZ1
 8j5xw+MWjdekOrAA==
Authentication-Results: smtp-out2.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
 t=1788439919; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=MXbm5dytOoHQFJsZViPT1Sp7UcKX7jDsgnveR3uJ5uo=;
 b=HM3R2acRDbNwOrPe3ff11qhEdG7GtpSA9PrRAZcXTtMuNkUHRmFNLnahOTUxjGfdxDBtVz
 BN9AmyvIJbzkl0HypSuVJBoi/Qv71szyXO3VFKBSM3hnaCJg2d1UuMIwCGQPXHa6VMWzcI
 vsJRzU485Jk7eRClpO+ZVLAxKE5rPt0=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_ed25519; t=1788439919;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=MXbm5dytOoHQFJsZViPT1Sp7UcKX7jDsgnveR3uJ5uo=;
 b=1ALKjcctnnS9VZtVT4GYkyncbMqB0z8rMFH7a8/wyXsxnFy2uHHQz//srC8T9tFfyAkNqr
 LR+fLfU/tOqAbPAA==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 0D7D913736;
 Thu,  3 Sep 2026 12:51:59 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
 by imap1.dmz-prg2.suse.org with ESMTPSA id KBuoAG9tmWr7MgAAD6G6ig
 (envelope-from <andrea.cervesato@suse.de>); Thu, 03 Sep 2026 12:51:59 +0000
From: Andrea Cervesato <andrea.cervesato@suse.de>
Date: Thu, 03 Sep 2026 14:51:55 +0200
MIME-Version: 1.0
Message-Id: <20260903-cve-ghostlock-v7-1-771e99aa3057@suse.com>
References: <20260903-cve-ghostlock-v7-0-771e99aa3057@suse.com>
In-Reply-To: <20260903-cve-ghostlock-v7-0-771e99aa3057@suse.com>
To: Linux Test Project <ltp@lists.linux.it>
X-Mailer: b4 0.16.0
X-Developer-Signature: v=1; a=ed25519-sha256; t=1788439918; l=8887;
 i=andrea.cervesato@suse.com; s=20251210; h=from:subject:message-id;
 bh=OR5LpL2iP0kO4ajoDimSAuiDtqquyu3Cucjb2tyD0n0=;
 b=/cXTot5bzDpYg/Z3WxDfXNihrKol+DJeGlaVWugNMoNnmGsChxzJZ/aj3UcVfI3KqbOWuqvdV
 aG4HaLwR3/XBS2aPKRHSiyjiRAGC26+1IcuiJ5+uXPcHapnqNPLqP4s
X-Developer-Key: i=andrea.cervesato@suse.com; a=ed25519;
 pk=zKY+6GCauOiuHNZ//d8PQ/UL4jFCTKbXrzXAOQSLevI=
X-Spamd-Result: default: False [-4.30 / 50.00]; BAYES_HAM(-3.00)[100.00%];
 NEURAL_HAM_LONG(-1.00)[-1.000];
 NEURAL_HAM_SHORT(-0.20)[-0.997]; MIME_GOOD(-0.10)[text/plain];
 RCPT_COUNT_TWO(0.00)[2]; RCVD_TLS_ALL(0.00)[];
 RCVD_VIA_SMTP_AUTH(0.00)[]; ARC_NA(0.00)[];
 DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
 TO_DN_ALL(0.00)[]; TO_MATCH_ENVRCPT_ALL(0.00)[];
 FROM_HAS_DN(0.00)[]; MIME_TRACE(0.00)[0:+];
 FROM_EQ_ENVFROM(0.00)[]; RCVD_COUNT_TWO(0.00)[2];
 DBL_BLOCKED_OPENRESOLVER(0.00)[suse.com:email, suse.com:mid,
 imap1.dmz-prg2.suse.org:helo]
X-Virus-Scanned: clamav-milter 1.0.9 at in-5.smtp.seeweb.it
X-Virus-Status: Clean
Subject: [LTP] [PATCH v7 1/5] sched_setattr01: Convert to new API
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

From: Andrea Cervesato <andrea.cervesato@suse.com>

Rewrite the test to use the modern LTP API (tst_test.h) with a
struct tcase array and TST_EXP_* macros.

Signed-off-by: Andrea Cervesato <andrea.cervesato@suse.com>
---
 testcases/kernel/syscalls/sched_setattr/Makefile   |   1 -
 .../syscalls/sched_setattr/sched_setattr01.c       | 231 +++++++++++++--------
 2 files changed, 142 insertions(+), 90 deletions(-)

diff --git a/testcases/kernel/syscalls/sched_setattr/Makefile b/testcases/kernel/syscalls/sched_setattr/Makefile
index 8fd2bd6f2..81f9dc164 100644
--- a/testcases/kernel/syscalls/sched_setattr/Makefile
+++ b/testcases/kernel/syscalls/sched_setattr/Makefile
@@ -5,6 +5,5 @@ top_srcdir		?= ../../../..
 
 include $(top_srcdir)/include/mk/testcases.mk
 
-CFLAGS			+= -pthread
 
 include $(top_srcdir)/include/mk/generic_leaf_target.mk
diff --git a/testcases/kernel/syscalls/sched_setattr/sched_setattr01.c b/testcases/kernel/syscalls/sched_setattr/sched_setattr01.c
index 13380d177..721620850 100644
--- a/testcases/kernel/syscalls/sched_setattr/sched_setattr01.c
+++ b/testcases/kernel/syscalls/sched_setattr/sched_setattr01.c
@@ -1,134 +1,187 @@
+// SPDX-License-Identifier: GPL-2.0-or-later
 /*
  * Copyright (c) Huawei Technologies Co., Ltd., 2015
- * This program is free software; you can redistribute it and/or modify
- * it under the terms of the GNU General Public License as published by
- * the Free Software Foundation; either version 2 of the License, or
- *  (at your option) any later version.
- *
- * This program is distributed in the hope that it will be useful,
- * but WITHOUT ANY WARRANTY; without even the implied warranty of
- * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE. See
- * the GNU General Public License for more details.
+ * Copyright (C) 2026 SUSE LLC Andrea Cervesato <andrea.cervesato@suse.com>
  */
- /* Description:
- *   Verify that:
- *              1) sched_setattr succeed with correct parameters
- *              2) sched_setattr fails with unused pid
- *              3) sched_setattr fails with invalid address
- *              4) sched_setattr fails with invalid flag
+
+/*\
+ * Verify that :manpage:`sched_setattr(2)`:
+ *
+ * - succeeds with correct parameters and attributes are verified via
+ *   :manpage:`sched_getattr(2)`
+ * - fails with ESRCH when pid is unused
+ * - fails with EINVAL when pid is negative
+ * - fails with EINVAL when sched_attr address is NULL
+ * - fails with EFAULT when sched_attr address is invalid
+ * - fails with E2BIG when sched_attr size is smaller than version 0
+ * - fails with EINVAL when flags are invalid
+ * - fails with EINVAL when sched_policy is invalid
+ * - fails with EINVAL when runtime exceeds deadline
+ *
+ * Root is required (:c:macro:`CAP_SYS_NICE`) to configure and validate the
+ * :c:macro:`SCHED_DEADLINE` policy.
+ *
+ * The test relies on the LTP harness process isolation and resets the
+ * scheduling policy to :c:macro:`SCHED_OTHER` after testing to prevent
+ * :c:macro:`SCHED_DEADLINE` constraints from leaking into subsequent
+ * test cases or iterations.
  */
 
 #define _GNU_SOURCE
-#include <unistd.h>
-#include <stdio.h>
-#include <stdlib.h>
-#include <string.h>
-#include <time.h>
-#include <linux/unistd.h>
-#include <linux/kernel.h>
-#include <linux/types.h>
-#include <sys/syscall.h>
-#include <pthread.h>
+
 #include <errno.h>
 
-#include "test.h"
+#include "tst_test.h"
 #include "lapi/sched.h"
 
-char *TCID = "sched_setattr01";
-
 #define RUNTIME_VAL 10000000
 #define PERIOD_VAL 30000000
 #define DEADLINE_VAL 30000000
 
-static pid_t pid;
 static pid_t unused_pid;
+static pid_t invalid_pid = -1;
+static void *bad_addr;
 
 static struct sched_attr attr = {
 	.size = sizeof(struct sched_attr),
-	.sched_flags = 0,
-	.sched_nice = 0,
-	.sched_priority = 0,
-
 	.sched_policy = SCHED_DEADLINE,
 	.sched_runtime = RUNTIME_VAL,
 	.sched_period = PERIOD_VAL,
 	.sched_deadline = DEADLINE_VAL,
 };
 
-static struct test_case {
+static struct sched_attr attr_small = {
+	.size = SCHED_ATTR_SIZE_VER0 - 1,
+};
+
+static struct sched_attr attr_invalid_policy = {
+	.size = sizeof(struct sched_attr),
+	.sched_policy = 999,
+};
+
+static struct sched_attr attr_bad_dl = {
+	.size = sizeof(struct sched_attr),
+	.sched_policy = SCHED_DEADLINE,
+	.sched_runtime = PERIOD_VAL,
+	.sched_deadline = RUNTIME_VAL,
+	.sched_period = PERIOD_VAL,
+};
+
+static struct tcase {
 	pid_t *pid;
-	struct sched_attr *a;
+	struct sched_attr *attr;
+	int bad_attr;
 	unsigned int flags;
-	int exp_return;
 	int exp_errno;
-} test_cases[] = {
-	{&pid, &attr, 0, 0, 0},
-	{&unused_pid, &attr, 0, -1, ESRCH},
-	{&pid, NULL, 0, -1, EINVAL},
-	{&pid, &attr, 1000, -1, EINVAL}
+	const char *desc;
+} tcases[] = {
+	{
+		.attr = &attr,
+		.desc = "sched_setattr() with valid parameters",
+	},
+	{
+		.pid = &unused_pid,
+		.attr = &attr,
+		.exp_errno = ESRCH,
+		.desc = "sched_setattr() with unused pid",
+	},
+	{
+		.pid = &invalid_pid,
+		.attr = &attr,
+		.exp_errno = EINVAL,
+		.desc = "sched_setattr() with negative pid",
+	},
+	{
+		.exp_errno = EINVAL,
+		.desc = "sched_setattr() with NULL sched_attr",
+	},
+	{
+		.bad_attr = 1,
+		.exp_errno = EFAULT,
+		.desc = "sched_setattr() with invalid sched_attr address",
+	},
+	{
+		.attr = &attr_small,
+		.exp_errno = E2BIG,
+		.desc = "sched_setattr() with size smaller than version 0",
+	},
+	{
+		.attr = &attr,
+		.flags = 1000,
+		.exp_errno = EINVAL,
+		.desc = "sched_setattr() with invalid flags",
+	},
+	{
+		.attr = &attr_invalid_policy,
+		.exp_errno = EINVAL,
+		.desc = "sched_setattr() with invalid sched_policy",
+	},
+	{
+		.attr = &attr_bad_dl,
+		.exp_errno = EINVAL,
+		.desc = "sched_setattr() with runtime exceeding deadline",
+	},
 };
 
-static void setup(void);
-static void sched_setattr_verify(const struct test_case *test);
-
-int TST_TOTAL = ARRAY_SIZE(test_cases);
-
-void *do_test(void *data LTP_ATTRIBUTE_UNUSED)
+static void reset_sched(void)
 {
-	int i;
-
-	for (i = 0; i < TST_TOTAL; i++)
-		sched_setattr_verify(&test_cases[i]);
+	struct sched_attr normal = {
+		.size = sizeof(normal),
+		.sched_policy = SCHED_OTHER,
+	};
 
-	return NULL;
+	sched_setattr(0, &normal, 0);
 }
 
-static void sched_setattr_verify(const struct test_case *test)
+static void verify_sched_setattr(unsigned int n)
 {
-	TEST(sched_setattr(*(test->pid), test->a, test->flags));
-
-	if (TEST_RETURN != test->exp_return) {
-		tst_resm(TFAIL | TTERRNO, "sched_setattr(%i,attr,%u) "
-		         "returned: %ld expected: %d",
-		         *(test->pid), test->flags,
-		         TEST_RETURN, test->exp_return);
+	struct tcase *tc = &tcases[n];
+	pid_t pid = tc->pid ? *tc->pid : 0;
+	struct sched_attr *target_attr = tc->bad_attr ? bad_addr : tc->attr;
+	struct sched_attr read_attr = { .size = sizeof(read_attr) };
+
+	/*
+	 * The kernel writes sizeof(struct sched_attr) back to uattr->size
+	 * on the -E2BIG error path, clobbering our test input. Refresh
+	 * before each call so re-runs (e.g. -i N) still exercise the
+	 * intended size.
+	 */
+	attr_small.size = SCHED_ATTR_SIZE_VER0 - 1;
+
+	if (tc->exp_errno) {
+		TST_EXP_FAIL(sched_setattr(pid, target_attr, tc->flags),
+			     tc->exp_errno, "%s", tc->desc);
 		return;
 	}
 
-	if (TEST_ERRNO == test->exp_errno) {
-		tst_resm(TPASS | TTERRNO,
-			"sched_setattr() works as expected");
+	TST_EXP_PASS(sched_setattr(pid, target_attr, tc->flags),
+		     "%s", tc->desc);
+	if (!TST_PASS)
 		return;
-	}
-
-	tst_resm(TFAIL | TTERRNO, "sched_setattr(%i,attr,%u): "
-		"expected: %d - %s",
-		*(test->pid), test->flags,
-		test->exp_errno, tst_strerrno(test->exp_errno));
-}
-
-int main(int argc, char **argv)
-{
-	pthread_t thread;
-	int lc;
 
-	tst_parse_opts(argc, argv, NULL, NULL);
-
-	setup();
-
-	for (lc = 0; TEST_LOOPING(lc); lc++) {
-		pthread_create(&thread, NULL, do_test, NULL);
-		pthread_join(thread, NULL);
+	if (sched_getattr(pid, &read_attr, sizeof(read_attr), 0) == -1) {
+		tst_res(TFAIL | TERRNO, "sched_getattr() failed");
+		return;
 	}
 
-	tst_exit();
+	TST_EXP_EQ_LU(read_attr.sched_policy, SCHED_DEADLINE);
+	TST_EXP_EQ_LU(read_attr.sched_runtime, RUNTIME_VAL);
+	TST_EXP_EQ_LU(read_attr.sched_deadline, DEADLINE_VAL);
+	TST_EXP_EQ_LU(read_attr.sched_period, PERIOD_VAL);
+
+	reset_sched();
 }
 
-void setup(void)
+static void setup(void)
 {
-	unused_pid = tst_get_unused_pid(setup);
-
-	tst_require_root();
-
-	TEST_PAUSE;
+	unused_pid = tst_get_unused_pid();
+	bad_addr = tst_get_bad_addr(NULL);
 }
+
+static struct tst_test test = {
+	.test = verify_sched_setattr,
+	.tcnt = ARRAY_SIZE(tcases),
+	.setup = setup,
+	.cleanup = reset_sched,
+	.needs_root = 1,
+};

-- 
2.51.0


-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
