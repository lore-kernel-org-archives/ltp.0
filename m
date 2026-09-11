Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 82808C88E50
	for <ltp@archiver.kernel.org>; Fri, 11 Sep 2026 13:16:28 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 346803E921A
	for <ltp@archiver.kernel.org>; Fri, 11 Sep 2026 15:16:27 +0200 (CEST)
Received: from in-3.smtp.seeweb.it (in-3.smtp.seeweb.it [217.194.8.3])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id E69203E9222
 for <ltp@lists.linux.it>; Fri, 11 Sep 2026 15:14:48 +0200 (CEST)
Received: from smtp-out1.suse.de (smtp-out1.suse.de
 [IPv6:2a07:de40:b251:101:10:150:64:1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-3.smtp.seeweb.it (Postfix) with ESMTPS id 5DDC61A00A5A
 for <ltp@lists.linux.it>; Fri, 11 Sep 2026 15:14:46 +0200 (CEST)
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org
 [IPv6:2a07:de40:b281:104:10:150:64:97])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-out1.suse.de (Postfix) with ESMTPS id 8B91821D7F;
 Fri, 11 Sep 2026 13:14:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
 t=1789132481; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=/g3oHyXNykRjGtZhTRmOo08DiXOcq+oJo5byp4KpHc0=;
 b=cfmahbX1xzrzp79QDo4y+qQVBjsDrZyA/Ui9ZwldJpVww5vhhqZ3S/Rw8iZtArsvo8IMGF
 Cuq90DBWxR+BDeIZ+RXumJShbk7zfpjYJiQGxkK/VL0BiKJKSCeYIfbXbi4lKlJUDAz+mj
 nhAAMYKlTl57VldMgNnFeInNOghGNNA=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_ed25519; t=1789132481;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=/g3oHyXNykRjGtZhTRmOo08DiXOcq+oJo5byp4KpHc0=;
 b=LwP/0oiwmjqvXac/7viFxxZm/gP6tuHWwwjlDYrty35YdPN0D0u0Jk7cmN9NwdH/eaCKBP
 eQ1dkkB6WeHnnRDQ==
Authentication-Results: smtp-out1.suse.de;
 dkim=pass header.d=suse.de header.s=susede2_rsa header.b=SeY6qg2m;
 dkim=pass header.d=suse.de header.s=susede2_ed25519 header.b=s6Uvb5IE
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
 t=1789132477; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=/g3oHyXNykRjGtZhTRmOo08DiXOcq+oJo5byp4KpHc0=;
 b=SeY6qg2mFj5Ra9TUf7ppGZUKd8oxy90hIPG0jdgOODQ89KI0PSJSvy/XgZouYa4I0sbZk6
 5rOrhP9bDip+/r49s9QvuO+lSc1Z9VKWHt8+xWgv7CtZJx52uWIprZWS8WEHRrvJ7rem9A
 G9D6zR2PK8aGmQQzIg6BeCmWsSaScCc=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_ed25519; t=1789132477;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=/g3oHyXNykRjGtZhTRmOo08DiXOcq+oJo5byp4KpHc0=;
 b=s6Uvb5IESfrnzr0nICoJN69Fd1rWr21Pi0nTQWd5d4W/ImhYibhUxciqV7n75LqzFBI9UK
 zDLDplpafBSUBaBg==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 488E813715;
 Fri, 11 Sep 2026 13:14:37 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
 by imap1.dmz-prg2.suse.org with ESMTPSA id +CUJEL3+o2qLLgAAD6G6ig
 (envelope-from <andrea.cervesato@suse.de>); Fri, 11 Sep 2026 13:14:37 +0000
From: Andrea Cervesato <andrea.cervesato@suse.de>
Date: Fri, 11 Sep 2026 15:14:34 +0200
MIME-Version: 1.0
Message-Id: <20260911-cve-ghostlock-v10-1-817cfb0187eb@suse.com>
References: <20260911-cve-ghostlock-v10-0-817cfb0187eb@suse.com>
In-Reply-To: <20260911-cve-ghostlock-v10-0-817cfb0187eb@suse.com>
To: Linux Test Project <ltp@lists.linux.it>
X-Mailer: b4 0.16.0
X-Developer-Signature: v=1; a=ed25519-sha256; t=1789132476; l=10920;
 i=andrea.cervesato@suse.com; s=20251210; h=from:subject:message-id;
 bh=ym+pXIoul399J1esFHr7KduWmLb5RIWLzrhOiwy3zyg=;
 b=8dRWCrZqJ4M0WIpyBKzUDZ+gHh8xhVyeXnr9JVau3WfXUTmvHoaoRpnh5eDh1Utkxs0fIvS2H
 r8hUlA33I9qBOSTp8gchwgpAqAmXXceRBYY1iADgX5W2T0WfNgFvb9M
X-Developer-Key: i=andrea.cervesato@suse.com; a=ed25519;
 pk=zKY+6GCauOiuHNZ//d8PQ/UL4jFCTKbXrzXAOQSLevI=
X-Rspamd-Action: no action
X-Rspamd-Server: rspamd2.dmz-prg2.suse.org
X-Rspamd-Queue-Id: 8B91821D7F
X-Spamd-Result: default: False [-4.51 / 50.00]; BAYES_HAM(-3.00)[100.00%];
 NEURAL_HAM_LONG(-1.00)[-1.000];
 R_DKIM_ALLOW(-0.20)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
 NEURAL_HAM_SHORT(-0.20)[-1.000]; MIME_GOOD(-0.10)[text/plain];
 MX_GOOD(-0.01)[];
 RBL_SPAMHAUS_BLOCKED_OPENRESOLVER(0.00)[2a07:de40:b281:104:10:150:64:97:from]; 
 RECEIVED_SPAMHAUS_BLOCKED_OPENRESOLVER(0.00)[2a07:de40:b281:106:10:150:64:167:received];
 ARC_NA(0.00)[]; MIME_TRACE(0.00)[0:+];
 DNSWL_BLOCKED(0.00)[2a07:de40:b281:104:10:150:64:97:from];
 RCVD_VIA_SMTP_AUTH(0.00)[]; RCVD_TLS_ALL(0.00)[];
 DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
 FROM_EQ_ENVFROM(0.00)[]; FROM_HAS_DN(0.00)[];
 RCPT_COUNT_THREE(0.00)[3]; RCVD_COUNT_TWO(0.00)[2];
 TO_MATCH_ENVRCPT_ALL(0.00)[];
 DBL_BLOCKED_OPENRESOLVER(0.00)[suse.cz:email,imap1.dmz-prg2.suse.org:rdns,imap1.dmz-prg2.suse.org:helo,suse.de:dkim,suse.com:email,suse.com:mid];
 TO_DN_ALL(0.00)[]; DKIM_TRACE(0.00)[suse.de:+]
X-Virus-Scanned: clamav-milter 1.0.9 at in-3.smtp.seeweb.it
X-Virus-Status: Clean
Subject: [LTP] [PATCH v10 1/5] sched_setattr: Convert to new API
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

Convert the test to the new LTP API and split it into sched_setattr01
for the positive test and sched_setattr02 for the negative tests.

Reviewed-by: Cyril Hrubis <chrubis@suse.cz>
Signed-off-by: Andrea Cervesato <andrea.cervesato@suse.com>
---
 runtest/syscalls                                   |   1 +
 testcases/kernel/syscalls/sched_setattr/.gitignore |   1 +
 testcases/kernel/syscalls/sched_setattr/Makefile   |   1 -
 .../syscalls/sched_setattr/sched_setattr01.c       | 138 ++++++--------------
 .../syscalls/sched_setattr/sched_setattr02.c       | 140 +++++++++++++++++++++
 5 files changed, 182 insertions(+), 99 deletions(-)

diff --git a/runtest/syscalls b/runtest/syscalls
index ca190dd97..4150daa59 100644
--- a/runtest/syscalls
+++ b/runtest/syscalls
@@ -1337,6 +1337,7 @@ sched_setaffinity01 sched_setaffinity01
 sched_getaffinity01 sched_getaffinity01
 
 sched_setattr01 sched_setattr01
+sched_setattr02 sched_setattr02
 sched_getattr01 sched_getattr01
 sched_getattr02 sched_getattr02
 
diff --git a/testcases/kernel/syscalls/sched_setattr/.gitignore b/testcases/kernel/syscalls/sched_setattr/.gitignore
index f2b192d08..8a0b89a74 100644
--- a/testcases/kernel/syscalls/sched_setattr/.gitignore
+++ b/testcases/kernel/syscalls/sched_setattr/.gitignore
@@ -1 +1,2 @@
 /sched_setattr01
+/sched_setattr02
diff --git a/testcases/kernel/syscalls/sched_setattr/Makefile b/testcases/kernel/syscalls/sched_setattr/Makefile
index 8fd2bd6f2..81f9dc164 100644
--- a/testcases/kernel/syscalls/sched_setattr/Makefile
+++ b/testcases/kernel/syscalls/sched_setattr/Makefile
@@ -5,6 +5,5 @@ top_srcdir		?= ../../../..
 
 include $(top_srcdir)/include/mk/testcases.mk
 
-CFLAGS			+= -pthread
 
 include $(top_srcdir)/include/mk/generic_leaf_target.mk
diff --git a/testcases/kernel/syscalls/sched_setattr/sched_setattr01.c b/testcases/kernel/syscalls/sched_setattr/sched_setattr01.c
index 13380d177..f89b829f4 100644
--- a/testcases/kernel/syscalls/sched_setattr/sched_setattr01.c
+++ b/testcases/kernel/syscalls/sched_setattr/sched_setattr01.c
@@ -1,134 +1,76 @@
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
+ * Verify that :manpage:`sched_setattr(2)` correctly sets the scheduling
+ * attributes of a process and that they can be read back using
+ * :manpage:`sched_getattr(2)`.
+ *
+ * Root is required (:c:macro:`CAP_SYS_NICE`) to configure the
+ * :c:macro:`SCHED_DEADLINE` policy.
+ *
+ * The test relies on the LTP harness process isolation and resets the
+ * scheduling policy to :c:macro:`SCHED_OTHER` after testing to prevent
+ * :c:macro:`SCHED_DEADLINE` constraints from leaking into subsequent
+ * test iterations.
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
-static pid_t unused_pid;
-
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
-	pid_t *pid;
-	struct sched_attr *a;
-	unsigned int flags;
-	int exp_return;
-	int exp_errno;
-} test_cases[] = {
-	{&pid, &attr, 0, 0, 0},
-	{&unused_pid, &attr, 0, -1, ESRCH},
-	{&pid, NULL, 0, -1, EINVAL},
-	{&pid, &attr, 1000, -1, EINVAL}
-};
-
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
+static void run(void)
 {
-	TEST(sched_setattr(*(test->pid), test->a, test->flags));
+	struct sched_attr read_attr = { .size = sizeof(read_attr) };
 
-	if (TEST_RETURN != test->exp_return) {
-		tst_resm(TFAIL | TTERRNO, "sched_setattr(%i,attr,%u) "
-		         "returned: %ld expected: %d",
-		         *(test->pid), test->flags,
-		         TEST_RETURN, test->exp_return);
+	TST_EXP_PASS(sched_setattr(0, &attr, 0),
+		     "sched_setattr() with valid parameters");
+	if (!TST_PASS)
 		return;
-	}
 
-	if (TEST_ERRNO == test->exp_errno) {
-		tst_resm(TPASS | TTERRNO,
-			"sched_setattr() works as expected");
+	if (sched_getattr(0, &read_attr, sizeof(read_attr), 0) == -1) {
+		tst_res(TFAIL | TERRNO, "sched_getattr() failed");
 		return;
 	}
 
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
+	TST_EXP_EQ_LU(read_attr.sched_policy, SCHED_DEADLINE);
+	TST_EXP_EQ_LU(read_attr.sched_runtime, RUNTIME_VAL);
+	TST_EXP_EQ_LU(read_attr.sched_deadline, DEADLINE_VAL);
+	TST_EXP_EQ_LU(read_attr.sched_period, PERIOD_VAL);
 
-	tst_parse_opts(argc, argv, NULL, NULL);
-
-	setup();
-
-	for (lc = 0; TEST_LOOPING(lc); lc++) {
-		pthread_create(&thread, NULL, do_test, NULL);
-		pthread_join(thread, NULL);
-	}
-
-	tst_exit();
+	reset_sched();
 }
 
-void setup(void)
-{
-	unused_pid = tst_get_unused_pid(setup);
-
-	tst_require_root();
-
-	TEST_PAUSE;
-}
+static struct tst_test test = {
+	.test_all = run,
+	.cleanup = reset_sched,
+	.needs_root = 1,
+};
diff --git a/testcases/kernel/syscalls/sched_setattr/sched_setattr02.c b/testcases/kernel/syscalls/sched_setattr/sched_setattr02.c
new file mode 100644
index 000000000..9f1ccfcd0
--- /dev/null
+++ b/testcases/kernel/syscalls/sched_setattr/sched_setattr02.c
@@ -0,0 +1,140 @@
+// SPDX-License-Identifier: GPL-2.0-or-later
+/*
+ * Copyright (c) Huawei Technologies Co., Ltd., 2015
+ * Copyright (C) 2026 SUSE LLC Andrea Cervesato <andrea.cervesato@suse.com>
+ */
+
+/*\
+ * Verify that :manpage:`sched_setattr(2)` fails and sets errno to:
+ *
+ * - :c:macro:`ESRCH` when pid is unused
+ * - :c:macro:`EINVAL` when pid is negative
+ * - :c:macro:`EINVAL` when sched_attr address is NULL
+ * - :c:macro:`EFAULT` when sched_attr address is invalid
+ * - :c:macro:`E2BIG` when sched_attr size is smaller than version 0
+ * - :c:macro:`EINVAL` when flags are invalid
+ * - :c:macro:`EINVAL` when sched_policy is invalid
+ * - :c:macro:`EINVAL` when runtime exceeds deadline
+ */
+
+#define _GNU_SOURCE
+
+#include <errno.h>
+
+#include "tst_test.h"
+#include "lapi/sched.h"
+
+#define RUNTIME_VAL 10000000
+#define PERIOD_VAL 30000000
+#define DEADLINE_VAL 30000000
+
+static pid_t unused_pid;
+static pid_t invalid_pid = -1;
+static void *bad_addr;
+
+static struct sched_attr attr = {
+	.size = sizeof(struct sched_attr),
+	.sched_policy = SCHED_DEADLINE,
+	.sched_runtime = RUNTIME_VAL,
+	.sched_period = PERIOD_VAL,
+	.sched_deadline = DEADLINE_VAL,
+};
+
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
+	pid_t *pid;
+	struct sched_attr *attr;
+	int bad_attr;
+	unsigned int flags;
+	int exp_errno;
+	const char *desc;
+} tcases[] = {
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
+};
+
+static void verify_sched_setattr(unsigned int n)
+{
+	struct tcase *tc = &tcases[n];
+	pid_t pid = tc->pid ? *tc->pid : 0;
+	struct sched_attr *target_attr = tc->bad_attr ? bad_addr : tc->attr;
+
+	/*
+	 * The kernel writes sizeof(struct sched_attr) back to uattr->size
+	 * on the -E2BIG error path, clobbering our test input. Refresh
+	 * before each call so re-runs (e.g. -i N) still exercise the
+	 * intended size.
+	 */
+	attr_small.size = SCHED_ATTR_SIZE_VER0 - 1;
+
+	TST_EXP_FAIL(sched_setattr(pid, target_attr, tc->flags),
+		     tc->exp_errno, "%s", tc->desc);
+}
+
+static void setup(void)
+{
+	unused_pid = tst_get_unused_pid();
+	bad_addr = tst_get_bad_addr(NULL);
+}
+
+static struct tst_test test = {
+	.test = verify_sched_setattr,
+	.tcnt = ARRAY_SIZE(tcases),
+	.setup = setup,
+};

-- 
2.51.0


-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
