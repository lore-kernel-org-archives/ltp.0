Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6DF03CD37BB
	for <ltp@archiver.kernel.org>; Sat, 16 Sep 2023 12:49:44 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 045BE3CE615
	for <ltp@archiver.kernel.org>; Sat, 16 Sep 2023 14:49:42 +0200 (CEST)
Received: from in-6.smtp.seeweb.it (in-6.smtp.seeweb.it [217.194.8.6])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-384) server-digest SHA384)
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 801973CB154
 for <ltp@lists.linux.it>; Sat, 16 Sep 2023 14:49:30 +0200 (CEST)
Received: from smtp-out1.suse.de (smtp-out1.suse.de [IPv6:2001:67c:2178:6::1c])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-6.smtp.seeweb.it (Postfix) with ESMTPS id 463AD14010DB
 for <ltp@lists.linux.it>; Sat, 16 Sep 2023 14:49:28 +0200 (CEST)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
 (No client certificate requested)
 by smtp-out1.suse.de (Postfix) with ESMTPS id CA2F921958;
 Sat, 16 Sep 2023 12:49:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
 t=1694868566; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=jeXS7VpOe8+WslI0PvLZ9dmL2dBAn+7HY/7upCIFsY0=;
 b=AVc0qKyqM4tHfFcfkUieEM1poX6SykzpQ7ltqOrmW55/SPB4aFcm2vmdeeqCr9gBIjctB8
 JURkymEEf+IIf5anOsuO8K1pgOs63DJKWpgGSQx1uWIT3KXxmzFZaNr+Cq/LHSMjzN/D1E
 eVo0p+Tyo9DwbsJOtp5Z3C6RyCdhz8o=
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
 (No client certificate requested)
 by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 9FF7013580;
 Sat, 16 Sep 2023 12:49:25 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
 by imap2.suse-dmz.suse.de with ESMTPSA id 5N7kF1WkBWWsYAAAMHmgww
 (envelope-from <wegao@suse.com>); Sat, 16 Sep 2023 12:49:25 +0000
To: ltp@lists.linux.it
Date: Sat, 16 Sep 2023 08:49:19 -0400
Message-Id: <20230916124919.31203-1-wegao@suse.com>
X-Mailer: git-send-email 2.35.3
In-Reply-To: <20221114225616.54212-1-federico.bonfiglio@protonmail.ch>
References: <20221114225616.54212-1-federico.bonfiglio@protonmail.ch>
MIME-Version: 1.0
X-Virus-Scanned: clamav-milter 1.0.1 at in-6.smtp.seeweb.it
X-Virus-Status: Clean
Subject: [LTP] [PATCH v3] sched_setscheduler04.c: Test SCHED_RESET_ON_FORK
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
From: Wei Gao via ltp <ltp@lists.linux.it>
Reply-To: Wei Gao <wegao@suse.com>
Cc: Federico Bonfiglio <federico.bonfiglio@protonmail.ch>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: ltp-bounces+ltp=archiver.kernel.org@lists.linux.it
Sender: "ltp" <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>

Signed-off-by: Federico Bonfiglio <federico.bonfiglio@protonmail.ch>
Signed-off-by: Wei Gao <wegao@suse.com>
---
 include/lapi/capability.h                     |  4 +
 runtest/syscalls                              |  1 +
 .../syscalls/sched_setscheduler/.gitignore    |  1 +
 .../sched_setscheduler/sched_setscheduler04.c | 78 +++++++++++++++++++
 4 files changed, 84 insertions(+)
 create mode 100644 testcases/kernel/syscalls/sched_setscheduler/sched_setscheduler04.c

diff --git a/include/lapi/capability.h b/include/lapi/capability.h
index 17ec107b1..2b593797c 100644
--- a/include/lapi/capability.h
+++ b/include/lapi/capability.h
@@ -36,6 +36,10 @@
 # define CAP_SYS_ADMIN        21
 #endif
 
+#ifndef CAP_SYS_NICE
+# define CAP_SYS_NICE         23
+#endif
+
 #ifndef CAP_SYS_TIME
 # define CAP_SYS_TIME         25
 #endif
diff --git a/runtest/syscalls b/runtest/syscalls
index 04b758fd9..b86188013 100644
--- a/runtest/syscalls
+++ b/runtest/syscalls
@@ -1228,6 +1228,7 @@ sched_getscheduler02 sched_getscheduler02
 sched_setscheduler01 sched_setscheduler01
 sched_setscheduler02 sched_setscheduler02
 sched_setscheduler03 sched_setscheduler03
+sched_setscheduler04 sched_setscheduler04
 
 sched_yield01 sched_yield01
 
diff --git a/testcases/kernel/syscalls/sched_setscheduler/.gitignore b/testcases/kernel/syscalls/sched_setscheduler/.gitignore
index aa8ad9695..1b8860d2c 100644
--- a/testcases/kernel/syscalls/sched_setscheduler/.gitignore
+++ b/testcases/kernel/syscalls/sched_setscheduler/.gitignore
@@ -1,3 +1,4 @@
 /sched_setscheduler01
 /sched_setscheduler02
 /sched_setscheduler03
+/sched_setscheduler04
diff --git a/testcases/kernel/syscalls/sched_setscheduler/sched_setscheduler04.c b/testcases/kernel/syscalls/sched_setscheduler/sched_setscheduler04.c
new file mode 100644
index 000000000..828d1ec09
--- /dev/null
+++ b/testcases/kernel/syscalls/sched_setscheduler/sched_setscheduler04.c
@@ -0,0 +1,78 @@
+// SPDX-License-Identifier: GPL-2.0-or-later
+/*
+ * Copyright (c) 2022 Federico Bonfiglio <federico.bonfiglio@protonmail.ch>
+ */
+
+/*
+ * [Description]
+ *
+ * Testcases that test if sched_setscheduler with flag
+ * SCHED_RESET_ON_FORK restores children policy to
+ * SCHED_NORMAL.
+ *
+ */
+
+#define _GNU_SOURCE
+#include <stdio.h>
+#include <stdlib.h>
+#include <sched.h>
+#include <linux/sched.h>
+
+#include "tst_test.h"
+#include "tst_sched.h"
+
+struct test_case_t {
+	int policy;
+	char *desc;
+};
+
+static struct test_case_t cases[] = {
+	{
+		.policy = SCHED_FIFO,
+		.desc = "SCHED_FIFO"
+	},
+	{
+		.policy = SCHED_RR,
+		.desc = "SCHED_RR"
+	}
+};
+
+static void test_reset_on_fork(unsigned int i)
+{
+	struct sched_variant *tv = &sched_variants[tst_variant];
+	struct test_case_t *tc = &cases[i];
+
+	tst_res(TINFO, "Testing %s variant %s policy", tv->desc, tc->desc);
+
+	struct sched_param param = { .sched_priority = 10 };
+
+	tv->sched_setscheduler(getpid(), tc->policy | SCHED_RESET_ON_FORK, &param);
+
+	pid_t pid = SAFE_FORK();
+
+	if (pid) {
+		if (sched_getscheduler(pid) == SCHED_NORMAL)
+			tst_res(TPASS, "Policy reset to SCHED_NORMAL");
+		else
+			tst_res(TFAIL, "Policy NOT reset to SCHED_NORMAL");
+
+		sched_getparam(pid, &param);
+
+		/* kernel will return sched_priority 0 if task is not RT Policy */
+		if (param.sched_priority == 0)
+			tst_res(TPASS, "Priority set to 0");
+		else
+			tst_res(TFAIL, "Priority not set to 0");
+	}
+}
+
+static struct tst_test test = {
+	.forks_child = 1,
+	.caps = (struct tst_cap[]) {
+		TST_CAP(TST_CAP_REQ, CAP_SYS_NICE),
+		{}
+	},
+	.test_variants = ARRAY_SIZE(sched_variants),
+	.tcnt = ARRAY_SIZE(cases),
+	.test = test_reset_on_fork,
+};
-- 
2.35.3


-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
