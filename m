Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DC830C88E50
	for <ltp@archiver.kernel.org>; Fri, 11 Sep 2026 13:15:05 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id D69A93E920B
	for <ltp@archiver.kernel.org>; Fri, 11 Sep 2026 15:15:03 +0200 (CEST)
Received: from in-7.smtp.seeweb.it (in-7.smtp.seeweb.it
 [IPv6:2001:4b78:1:20::7])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 294B23E2E82
 for <ltp@lists.linux.it>; Fri, 11 Sep 2026 15:14:47 +0200 (CEST)
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.223.131])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-7.smtp.seeweb.it (Postfix) with ESMTPS id 8F0E6200AC7
 for <ltp@lists.linux.it>; Fri, 11 Sep 2026 15:14:46 +0200 (CEST)
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org
 [IPv6:2a07:de40:b281:104:10:150:64:97])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-out2.suse.de (Postfix) with ESMTPS id B42461FEF6;
 Fri, 11 Sep 2026 13:14:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
 t=1789132481; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=FPnaZdgNtsgL9YAf96/Wobg1Ze5IW5+mFMw5oKxwN54=;
 b=lqn3r7xVnuWts+0NNhfD2AjUcWQPHscpbFzpu0RBTk2uxvBtaNxN04JsdfzvjN/UoDAODX
 Om/31Ys+cBl6hcjB3WipP/+Ht74Yh7kbzOAbxEvAei/4wL95k67mNTPFXxUszbjGIZGTDV
 iHhROpEMVan9Pzzb1IGFOPYiuv72yYk=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_ed25519; t=1789132481;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=FPnaZdgNtsgL9YAf96/Wobg1Ze5IW5+mFMw5oKxwN54=;
 b=emEXK4Y7Vz/6vmB0rXCFpgA93HFKlUMa7viXYQ89np4jCgvW00J7BFoWjNMW/cIPM2yh3B
 LYLdWR10rTjMuhBw==
Authentication-Results: smtp-out2.suse.de;
 dkim=pass header.d=suse.de header.s=susede2_rsa header.b=H7lGICAw;
 dkim=pass header.d=suse.de header.s=susede2_ed25519 header.b=h6uyILev
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
 t=1789132477; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=FPnaZdgNtsgL9YAf96/Wobg1Ze5IW5+mFMw5oKxwN54=;
 b=H7lGICAwo+fh9t8zFN9xP6dECvOVfBmRN3xp6iL49NNetmnjtgGAhKPa1GlkBx707jTwyN
 ZMzm2DHZbIY+UtSBuYku2uRKMZn0pf7H0OmFRVlblyoF15JajQNSDjnHoEuipqkW5yTb+H
 8CuVabzr9uJqVkuxyShbVKQTos8oP10=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_ed25519; t=1789132477;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=FPnaZdgNtsgL9YAf96/Wobg1Ze5IW5+mFMw5oKxwN54=;
 b=h6uyILevloGlLOufKQIGFWO4KtkcOPObzkbNcseTXHViyQeN0BFiKUkxGuL2XmZI2DwlKz
 DCP0LBJKOWeQ+NCA==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 756A013794;
 Fri, 11 Sep 2026 13:14:37 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
 by imap1.dmz-prg2.suse.org with ESMTPSA id cBbwGr3+o2qLLgAAD6G6ig
 (envelope-from <andrea.cervesato@suse.de>); Fri, 11 Sep 2026 13:14:37 +0000
From: Andrea Cervesato <andrea.cervesato@suse.de>
Date: Fri, 11 Sep 2026 15:14:35 +0200
MIME-Version: 1.0
Message-Id: <20260911-cve-ghostlock-v10-2-817cfb0187eb@suse.com>
References: <20260911-cve-ghostlock-v10-0-817cfb0187eb@suse.com>
In-Reply-To: <20260911-cve-ghostlock-v10-0-817cfb0187eb@suse.com>
To: Linux Test Project <ltp@lists.linux.it>
X-Mailer: b4 0.16.0
X-Developer-Signature: v=1; a=ed25519-sha256; t=1789132476; l=5914;
 i=andrea.cervesato@suse.com; s=20251210; h=from:subject:message-id;
 bh=vEBe4zWhXLGR1qcRG8fg9np2uGNbIrXrt79qEGMeKro=;
 b=eefqst183gaqCpL7wvE7V8OvIF4W3erJnmJ0Wnjt9I/N7TgL9zFCY6bi/i/TEskVDglKKFFaB
 BtT8F6DZGSBBippCdh0TONLsfrQ6JE+xkjuu05oESFGLoXIJKGJ7dFP
X-Developer-Key: i=andrea.cervesato@suse.com; a=ed25519;
 pk=zKY+6GCauOiuHNZ//d8PQ/UL4jFCTKbXrzXAOQSLevI=
X-Rspamd-Queue-Id: B42461FEF6
X-Rspamd-Server: rspamd1.dmz-prg2.suse.org
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-4.51 / 50.00]; BAYES_HAM(-3.00)[100.00%];
 NEURAL_HAM_LONG(-1.00)[-1.000];
 R_DKIM_ALLOW(-0.20)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
 NEURAL_HAM_SHORT(-0.20)[-1.000]; MIME_GOOD(-0.10)[text/plain];
 MX_GOOD(-0.01)[]; RCVD_VIA_SMTP_AUTH(0.00)[]; ARC_NA(0.00)[];
 SPAMHAUS_XBL(0.00)[2a07:de40:b281:104:10:150:64:97:from];
 MIME_TRACE(0.00)[0:+];
 DNSWL_BLOCKED(0.00)[2a07:de40:b281:104:10:150:64:97:from];
 RCVD_TLS_ALL(0.00)[];
 DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
 FROM_EQ_ENVFROM(0.00)[]; FROM_HAS_DN(0.00)[];
 RCPT_COUNT_THREE(0.00)[3]; RCVD_COUNT_TWO(0.00)[2];
 TO_MATCH_ENVRCPT_ALL(0.00)[];
 DBL_BLOCKED_OPENRESOLVER(0.00)[suse.com:mid,suse.com:email,imap1.dmz-prg2.suse.org:helo,imap1.dmz-prg2.suse.org:rdns,suse.de:dkim,suse.cz:email];
 TO_DN_ALL(0.00)[]; DKIM_TRACE(0.00)[suse.de:+]
X-Virus-Scanned: clamav-milter 1.0.9 at in-7.smtp.seeweb.it
X-Virus-Status: Clean
Subject: [LTP] [PATCH v10 2/5] sched_getattr01: Convert to new API
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

Rewrite the test to use the modern LTP API (tst_test.h) with
TST_EXP_* macros and cleanup callback.

Reviewed-by: Cyril Hrubis <chrubis@suse.cz>
Signed-off-by: Andrea Cervesato <andrea.cervesato@suse.com>
---
 testcases/kernel/syscalls/sched_getattr/Makefile   |   1 -
 .../syscalls/sched_getattr/sched_getattr01.c       | 143 ++++++++-------------
 2 files changed, 57 insertions(+), 87 deletions(-)

diff --git a/testcases/kernel/syscalls/sched_getattr/Makefile b/testcases/kernel/syscalls/sched_getattr/Makefile
index ea299ff4a..4cef5e763 100644
--- a/testcases/kernel/syscalls/sched_getattr/Makefile
+++ b/testcases/kernel/syscalls/sched_getattr/Makefile
@@ -5,6 +5,5 @@ top_srcdir		?= ../../../..
 
 include $(top_srcdir)/include/mk/testcases.mk
 
-CFLAGS			+= -pthread
 
 include $(top_srcdir)/include/mk/generic_leaf_target.mk
diff --git a/testcases/kernel/syscalls/sched_getattr/sched_getattr01.c b/testcases/kernel/syscalls/sched_getattr/sched_getattr01.c
index 2e06d1809..0edd9e47e 100644
--- a/testcases/kernel/syscalls/sched_getattr/sched_getattr01.c
+++ b/testcases/kernel/syscalls/sched_getattr/sched_getattr01.c
@@ -1,105 +1,76 @@
+// SPDX-License-Identifier: GPL-2.0-or-later
 /*
  * Copyright (c) Huawei Technologies Co., Ltd., 2015
- * This program is free software; you can redistribute it and/or modify
- * it under the terms of the GNU General Public License as published by
- * the Free Software Foundation; either version 2 of the License, or
- *  (at your option) any later version.
+ * Copyright (C) 2026 SUSE LLC Andrea Cervesato <andrea.cervesato@suse.com>
+ */
+
+/*\
+ * Verify that :manpage:`sched_getattr(2)` correctly reads back the scheduling
+ * attributes of a task configured with :manpage:`sched_setattr(2)`.
+ *
+ * Root is required (:c:macro:`CAP_SYS_NICE`) to configure the
+ * :c:macro:`SCHED_DEADLINE` policy.
  *
- * This program is distributed in the hope that it will be useful,
- * but WITHOUT ANY WARRANTY; without even the implied warranty of
- * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE. See
- * the GNU General Public License for more details.
+ * The test relies on the LTP harness process isolation and resets the
+ * scheduling policy to :c:macro:`SCHED_OTHER` after testing to prevent
+ * :c:macro:`SCHED_DEADLINE` constraints from leaking across test iterations.
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
-#include <errno.h>
 
-#include "test.h"
+#include "tst_test.h"
 #include "lapi/sched.h"
 
-char *TCID = "sched_getattr01";
-int TST_TOTAL = 1;
-
 #define RUNTIME_VAL 10000000
 #define PERIOD_VAL 30000000
 #define DEADLINE_VAL 30000000
 
-void *run_deadline(void *data LTP_ATTRIBUTE_UNUSED)
-{
-	struct sched_attr attr, attr_copy;
-	int ret;
-	unsigned int flags = 0;
-	unsigned int size;
-
-	attr.size = sizeof(attr);
-	attr.sched_flags = 0;
-	attr.sched_nice = 0;
-	attr.sched_priority = 0;
-
-	/* This creates a 10ms/30ms reservation */
-	attr.sched_policy = SCHED_DEADLINE;
-	attr.sched_runtime = RUNTIME_VAL;
-	attr.sched_period = PERIOD_VAL;
-	attr.sched_deadline = DEADLINE_VAL;
-
-	ret = sched_setattr(0, &attr, flags);
-	if (ret < 0)
-		tst_brkm(TFAIL | TERRNO, NULL, "sched_setattr() failed");
-
-	size = sizeof(attr_copy);
-	ret = sched_getattr(0, &attr_copy, size, flags);
-	if (ret < 0)
-		tst_brkm(TFAIL | TERRNO, NULL, "sched_getattr() failed");
+static struct sched_attr *read_attr;
 
-	int fail = 0;
-
-	if (attr_copy.sched_runtime != RUNTIME_VAL) {
-		tst_resm(TINFO, "sched_runtime is incorrect (%"PRIu64"),"
-			" expected %u", attr.sched_runtime, RUNTIME_VAL);
-		fail++;
-	}
-	if (attr_copy.sched_period != PERIOD_VAL) {
-		tst_resm(TINFO, "sched_period is incorrect (%"PRIu64"),"
-			" expected %u", attr.sched_period, PERIOD_VAL);
-		fail++;
-	}
-	if (attr_copy.sched_deadline != DEADLINE_VAL) {
-		tst_resm(TINFO, "sched_deadline is incorrect (%"PRIu64"),"
-			" expected %u", attr.sched_deadline, DEADLINE_VAL);
-		fail++;
-	}
-
-	if (fail)
-		tst_resm(TFAIL, "attributes were read back incorrectly");
-	else
-		tst_resm(TPASS, "attributes were read back correctly");
+static void reset_sched(void)
+{
+	struct sched_attr normal = {
+		.size = sizeof(normal),
+		.sched_policy = SCHED_OTHER,
+	};
 
-	return NULL;
+	sched_setattr(0, &normal, 0);
 }
 
-int main(int argc, char **argv)
+static void run(void)
 {
-	pthread_t thread;
-	int lc;
-
-	tst_parse_opts(argc, argv, NULL, NULL);
-
-	tst_require_root();
-
-	for (lc = 0; TEST_LOOPING(lc); lc++) {
-		pthread_create(&thread, NULL, run_deadline, NULL);
-		pthread_join(thread, NULL);
-	}
-
-	tst_exit();
+	struct sched_attr attr = {
+		.size = sizeof(attr),
+		.sched_policy = SCHED_DEADLINE,
+		.sched_runtime = RUNTIME_VAL,
+		.sched_deadline = DEADLINE_VAL,
+		.sched_period = PERIOD_VAL,
+	};
+
+	if (sched_setattr(0, &attr, 0) == -1)
+		tst_brk(TBROK | TERRNO, "sched_setattr() failed");
+
+	memset((void *)read_attr, 0, sizeof(*read_attr));
+
+	TST_EXP_PASS(sched_getattr(0, read_attr, sizeof(*read_attr), 0),
+		     "sched_getattr() with valid parameters");
+	if (!TST_PASS)
+		return;
+
+	TST_EXP_EQ_LU(read_attr->sched_policy, SCHED_DEADLINE);
+	TST_EXP_EQ_LU(read_attr->sched_runtime, RUNTIME_VAL);
+	TST_EXP_EQ_LU(read_attr->sched_deadline, DEADLINE_VAL);
+	TST_EXP_EQ_LU(read_attr->sched_period, PERIOD_VAL);
+
+	reset_sched();
 }
+
+static struct tst_test test = {
+	.test_all = run,
+	.cleanup = reset_sched,
+	.needs_root = 1,
+	.bufs = (struct tst_buffers []) {
+	    {&read_attr, .size = sizeof(*read_attr)},
+	    {},
+	},
+};

-- 
2.51.0


-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
