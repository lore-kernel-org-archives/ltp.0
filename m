Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6413AC433EF
	for <ltp@archiver.kernel.org>; Wed,  6 Jul 2022 10:15:33 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 6EBD83CA357
	for <ltp@archiver.kernel.org>; Wed,  6 Jul 2022 12:15:30 +0200 (CEST)
Received: from in-4.smtp.seeweb.it (in-4.smtp.seeweb.it
 [IPv6:2001:4b78:1:20::4])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-384))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 931893CA16B
 for <ltp@lists.linux.it>; Wed,  6 Jul 2022 12:15:19 +0200 (CEST)
Received: from mail1.bemta37.messagelabs.com (mail1.bemta37.messagelabs.com
 [85.158.142.1])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by in-4.smtp.seeweb.it (Postfix) with ESMTPS id A695E10000C0
 for <ltp@lists.linux.it>; Wed,  6 Jul 2022 12:15:17 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fujitsu.com;
 s=170520fj; t=1657102517; i=@fujitsu.com;
 bh=k5bn8qtOTwUonXRqIlCZ3MptXt05Hk2Y4EWlBoLQ+jU=;
 h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type;
 b=aRhgJ8Yl9anbljL9/fmyScq87qZqQ3QEiGaj9+OKJEb5cyhhG1TDKj4rFYdZtKbn6
 GrniYo/NKn6VCHp3dZ+d3GyEk12k7rzZlLJEh8xTaXyOAC0S0W4P4h7zaWjrjddNpJ
 7TZ9YGdnDNMTxT/gpz1sZHFpwH5pqWztm+oWoLKa5Y4IzEeeRgxc5Bgv2jBtRE8a5p
 xHLxpn+mzx4T5p+1mfy+GobVmC2+e7vZvpLGeqBC98EkSEca8RlEMNqbh5GJ6bnOP/
 BbZsbfNVTbiGB06ESkiRYpyy5Kfrh5VOCJBzu3fcV6ZIS9z+j5RlEXIWeRfPpkO97Q
 aZrFkn49sHBTA==
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFjrIIsWRWlGSWpSXmKPExsViZ8OxWXdrwtE
 kg40bGC1WfN/B6MDose/3OtYAxijWzLyk/IoE1ozfpx8yFpxVrDg36SZbA+MqmS5GLg4hgVOM
 Ej+m7GGDcPYwSay/c4sRwtnNKHFz0VagDCcHm4CmxLPOBcwgtoiAhERHw1t2EJtZQF1i+aRfT
 CC2sICLxO+pK8FqWARUJC4enAnWyyvgIfHj20MWEFtCQEFiysP3zBBxQYmTM5+wQMyRkDj44g
 UzRI2ixKWOb4wQdoXE68OXoOJqElfPbWKewMg/C0n7LCTtCxiZVjHaJBVlpmeU5CZm5ugaGhj
 oGhqaAmlDXWMDvcQq3US91FLdvPyikgxdQ73E8mK91OJiveLK3OScFL281JJNjMDQTClOldvB
 eGDfL71DjJIcTEqivD3hR5OE+JLyUyozEosz4otKc1KLDzHKcHAoSfDWRgLlBItS01Mr0jJzg
 HECk5bg4FES4dWIB0rzFhck5hZnpkOkTjHqcvz99HcvsxBLXn5eqpQ471+QIgGQoozSPLgRsJ
 i9xCgrJczLyMDAIMRTkFqUm1mCKv+KUZyDUUmY93Yc0BSezLwSuE2vgI5gAjpiWf4RkCNKEhF
 SUg1Mq/0mcFx8pD0nuLPQ+Dkzx2fZwMq4rkDWZ1VH3xhfvLryIPvLtl8nD9lnn5L6oikzpfzg
 U/PwBw75xX1MDTJzRC9Oa2/819nx4kWNbPg9ub3Ltj851b3GhvHS06ykQwz3stZzycR//Lz05
 kKnVQcWPvuS1W0YlCiZkN94dMpXE5M3/w+6uuYtb52hHfc6w3kFg8TLxqxdr+6eE59lHqR+4l
 B0ycayIJvTp/UnPJ9eepx9T8iv4v8eDvfXTvbYIzetwoqhNv8Bo63fJt6ViTpHu5e/zezQei6
 1U36bw0WHW4UJ5x4/bajRaf/+5VF305rtKqXhf9wK1lyblvP9mNqqtJQTyZMbD511XW1YoVA0
 VYmlOCPRUIu5qDgRAGysDyBUAwAA
X-Env-Sender: xuyang2018.jy@fujitsu.com
X-Msg-Ref: server-9.tower-745.messagelabs.com!1657102516!14179!1
X-Originating-IP: [62.60.8.179]
X-SYMC-ESS-Client-Auth: outbound-route-from=pass
X-StarScan-Received: 
X-StarScan-Version: 9.86.8; banners=-,-,-
X-VirusChecked: Checked
Received: (qmail 6585 invoked from network); 6 Jul 2022 10:15:16 -0000
Received: from unknown (HELO n03ukasimr04.n03.fujitsu.local) (62.60.8.179)
 by server-9.tower-745.messagelabs.com with ECDHE-RSA-AES256-GCM-SHA384
 encrypted SMTP; 6 Jul 2022 10:15:16 -0000
Received: from n03ukasimr04.n03.fujitsu.local (localhost [127.0.0.1])
 by n03ukasimr04.n03.fujitsu.local (Postfix) with ESMTP id 63CB4142
 for <ltp@lists.linux.it>; Wed,  6 Jul 2022 11:15:16 +0100 (BST)
Received: from R01UKEXCASM126.r01.fujitsu.local (R01UKEXCASM126
 [10.183.43.178])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-SHA384 (256/256 bits))
 (No client certificate requested)
 by n03ukasimr04.n03.fujitsu.local (Postfix) with ESMTPS id 566E67B
 for <ltp@lists.linux.it>; Wed,  6 Jul 2022 11:15:16 +0100 (BST)
Received: from localhost.localdomain (10.167.220.84) by
 R01UKEXCASM126.r01.fujitsu.local (10.183.43.178) with Microsoft SMTP Server
 (TLS) id 15.0.1497.32; Wed, 6 Jul 2022 11:15:14 +0100
From: Yang Xu <xuyang2018.jy@fujitsu.com>
To: <ltp@lists.linux.it>
Date: Wed, 6 Jul 2022 19:16:00 +0800
Message-ID: <1657106160-2126-1-git-send-email-xuyang2018.jy@fujitsu.com>
X-Mailer: git-send-email 1.8.3.1
MIME-Version: 1.0
X-Originating-IP: [10.167.220.84]
X-ClientProxiedBy: G08CNEXCHPEKD08.g08.fujitsu.local (10.167.33.83) To
 R01UKEXCASM126.r01.fujitsu.local (10.183.43.178)
X-Virus-Scanned: clamav-milter 0.102.4 at in-4.smtp.seeweb.it
X-Virus-Status: Clean
Subject: [LTP] [PATCH] syscalls/prctl10: Add basic test for PR_SET/GET_TSC
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

Signed-off-by: Yang Xu <xuyang2018.jy@fujitsu.com>
---
 include/lapi/prctl.h                       |   7 ++
 runtest/syscalls                           |   1 +
 testcases/kernel/syscalls/prctl/.gitignore |   1 +
 testcases/kernel/syscalls/prctl/prctl10.c  | 112 +++++++++++++++++++++
 4 files changed, 121 insertions(+)
 create mode 100644 testcases/kernel/syscalls/prctl/prctl10.c

diff --git a/include/lapi/prctl.h b/include/lapi/prctl.h
index fa5922231..8d3ef5c32 100644
--- a/include/lapi/prctl.h
+++ b/include/lapi/prctl.h
@@ -19,6 +19,13 @@
 # define PR_SET_SECCOMP  22
 #endif
 
+#ifndef PR_SET_TSC
+# define PR_GET_TSC 25
+# define PR_SET_TSC 26
+# define PR_TSC_ENABLE  1
+# define PR_TSC_SIGSEGV 2
+#endif
+
 #ifndef PR_SET_TIMERSLACK
 # define PR_SET_TIMERSLACK 29
 # define PR_GET_TIMERSLACK 30
diff --git a/runtest/syscalls b/runtest/syscalls
index 36fc50aeb..a0935821a 100644
--- a/runtest/syscalls
+++ b/runtest/syscalls
@@ -1004,6 +1004,7 @@ prctl06 prctl06
 prctl07 prctl07
 prctl08 prctl08
 prctl09 prctl09
+prctl10 prctl10
 
 pread01 pread01
 pread01_64 pread01_64
diff --git a/testcases/kernel/syscalls/prctl/.gitignore b/testcases/kernel/syscalls/prctl/.gitignore
index 0f2c9b194..50ee4bf60 100644
--- a/testcases/kernel/syscalls/prctl/.gitignore
+++ b/testcases/kernel/syscalls/prctl/.gitignore
@@ -8,3 +8,4 @@
 /prctl07
 /prctl08
 /prctl09
+/prctl10
diff --git a/testcases/kernel/syscalls/prctl/prctl10.c b/testcases/kernel/syscalls/prctl/prctl10.c
new file mode 100644
index 000000000..1b6791679
--- /dev/null
+++ b/testcases/kernel/syscalls/prctl/prctl10.c
@@ -0,0 +1,112 @@
+// SPDX-License-Identifier: GPL-2.0-or-later
+/*
+ * Copyright (c) 2022 FUJITSU LIMITED. All rights reserved.
+ * Author: Yang Xu <xuyang2018.jy@fujitsu.com>
+ */
+
+/*\
+ * [Description]
+ *
+ * Basic test to test behaviour of PR_GET_TSC and PR_SET_TSC.
+ *
+ * Set the state of the flag determining whether the timestamp counter can
+ * be read by the process.
+ *
+ * - Pass PR_TSC_ENABLE to arg2 to allow it to be read.
+ * - Pass PR_TSC_SIGSEGV to arg2 to generate a SIGSEGV when reading TSC.
+ */
+
+#include <sys/prctl.h>
+#include <string.h>
+#include <stdio.h>
+#include <setjmp.h>
+#include "tst_test.h"
+#include "lapi/prctl.h"
+
+#define TCASE_ENTRY(tsc_read_stat) { .name = #tsc_read_stat, .read_stat = tsc_read_stat}
+
+static int pass;
+static sigjmp_buf env;
+
+static const char *tsc_read_stat_names[] = {
+	[0] = "[not set]",
+	[PR_TSC_ENABLE] = "PR_TSC_ENABLE",
+	[PR_TSC_SIGSEGV] = "PR_TSC_SIGSEGV",
+};
+
+static struct tcase {
+	char *name;
+	int read_stat;
+} tcases[] = {
+	TCASE_ENTRY(PR_TSC_ENABLE),
+	TCASE_ENTRY(PR_TSC_SIGSEGV)
+};
+
+static void sighandler(int sig LTP_ATTRIBUTE_UNUSED)
+{
+	pass = 1;
+	TST_EXP_PASS_SILENT(prctl(PR_SET_TSC, PR_TSC_ENABLE));
+	siglongjmp(env, 1);
+}
+
+static uint64_t rdtsc(void)
+{
+	uint32_t lo, hi;
+	/* We cannot use "=A", since this would use %rax on x86_64 */
+	__asm__ __volatile__ ("rdtsc" : "=a" (lo), "=d" (hi));
+	return (uint64_t)hi << 32 | lo;
+}
+
+static void verify_prctl(unsigned int n)
+{
+	struct tcase *tc = &tcases[n];
+	unsigned long long time1, time2;
+	int tsc_val = 0;
+
+	TST_EXP_PASS_SILENT(prctl(PR_SET_TSC, tc->read_stat));
+	TST_EXP_PASS_SILENT(prctl(PR_GET_TSC, &tsc_val));
+	if (tsc_val == tc->read_stat)
+		tst_res(TPASS, "current state is %s(%d)",
+				tc->name, tc->read_stat);
+	else
+		tst_res(TFAIL, "current state is %s(%d), expect %s(%d)",
+				tsc_read_stat_names[tsc_val], tsc_val, tc->name, tc->read_stat);
+
+	if (tc->read_stat == PR_TSC_SIGSEGV) {
+		if (sigsetjmp(env, 1) == 0)
+			rdtsc();
+
+		if (pass)
+			tst_res(TPASS,
+				"get SIGSEGV signal under PR_TSC_SIGSEGV situation");
+		else
+			tst_res(TFAIL,
+				"don't get SIGSEGV signal under PR_TSC_SIGSEGV situation");
+		pass = 0;
+	}
+
+	time1 = rdtsc();
+	time2 = rdtsc();
+	if (time2 > time1)
+		tst_res(TPASS, "rdtsc works correctly, %lld ->%lld",
+			time1, time2);
+	else
+		tst_res(TFAIL, "rdtsc works incorrectly, %lld ->%lld",
+			time1, time2);
+}
+
+static void setup(void)
+{
+	SAFE_SIGNAL(SIGSEGV, sighandler);
+}
+
+static struct tst_test test = {
+	.setup = setup,
+	.test = verify_prctl,
+	.tcnt = ARRAY_SIZE(tcases),
+	.supported_archs = (const char *const []) {
+		"x86",
+		"x86_64",
+		NULL
+	},
+};
-- 
2.27.0


-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
