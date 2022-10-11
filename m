Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 04E97C433FE
	for <ltp@archiver.kernel.org>; Tue, 11 Oct 2022 05:23:50 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 69CE43CAE97
	for <ltp@archiver.kernel.org>; Tue, 11 Oct 2022 07:23:48 +0200 (CEST)
Received: from in-3.smtp.seeweb.it (in-3.smtp.seeweb.it
 [IPv6:2001:4b78:1:20::3])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-384))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 75F653CA616
 for <ltp@lists.linux.it>; Tue, 11 Oct 2022 07:23:37 +0200 (CEST)
Received: from mail1.bemta37.messagelabs.com (mail1.bemta37.messagelabs.com
 [85.158.142.1])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by in-3.smtp.seeweb.it (Postfix) with ESMTPS id 8DE111A000B3
 for <ltp@lists.linux.it>; Tue, 11 Oct 2022 07:23:35 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fujitsu.com;
 s=170520fj; t=1665465814; i=@fujitsu.com;
 bh=h0RDHpSl+saIYFnTwqIgrqUPoyWU9+eKLwb5wDeWeXc=;
 h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
 MIME-Version:Content-Type;
 b=Ncpv6uQPDLqJ9ksmyyON4tkqB1XdQQNI99FUZGunLnaz8ipe9vkkN6nAOblGc5V7N
 E7gS8tRFS62JZp+SerCPV5aqNRcQ6rIpWuFMKWsr5izydRJn0UlxOWK2Yc1sm7LZ6D
 kccAvbLxsqNysWSyO1X1VwJ8tANhrxHT8U47oeh85bTr6B9ccn69+b0icm8e31Tr4Y
 Rg/m2MhUTW5mUHmOqEA7GmSdA40nKE4YY00+wsyCLkA1n8dFt9rfL66H3o7Drl4r9v
 YHr+rMq1sd/rVdVnXLpjVPslGpXn6HhsddkuYYOq3bGg+m7jO8PovchaNIeozs/+NI
 8Qq0wPR2BrmHA==
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFnrIIsWRWlGSWpSXmKPExsViZ8ORpHv1r0u
 ywfw/NhYrvu9gtOh+tIfVgclj3+91rB6bT1cHMEWxZuYl5VcksGZ8WLqbveCoYkXbqzmMDYxT
 ZboYuTiEBDYySsx4d4MRwlnCJLF3118mCGcPo8Ser5NZuhg5OdgENCWedS5gBrFFBCQlFp+9y
 Q5iMwvYSjx/eIkNxBYWcJdYfmsxI4jNIqAqseTcIrAaXgEPibm3Z4DFJQQUJKY8fA82hxOo5t
 HCB2BxIQEViTnXHrNA1AtKnJz5hAVivoTEwRcvmCF6FSUudXyDmlMhMWtWGxOErSZx9dwm5gm
 MgrOQtM9C0r6AkWkVo3VSUWZ6RkluYmaOrqGBga6hoamupaWuhYleYpVuol5qqW5eflFJhq6h
 XmJ5sV5qcbFecWVuck6KXl5qySZGYGinFCeH7GA8ue+X3iFGSQ4mJVHeq89dkoX4kvJTKjMSi
 zPii0pzUosPMcpwcChJ8D76DpQTLEpNT61Iy8wBxhlMWoKDR0mEl+khUJq3uCAxtzgzHSJ1il
 GXY+rsf/uZhVjy8vNSpcR5834CFQmAFGWU5sGNgMX8JUZZKWFeRgYGBiGegtSi3MwSVPlXjOI
 cjErCvDN/AE3hycwrgdv0CugIJqAjTl51AjmiJBEhJdXAtLrwsohSdE7vQmdvsapzL0TbVmVl
 b07Vl39hWH9FxN+33UnJ0sY88pfq/vpjWnM59LcFZQgmxLQFtpxc7sXueI/xxcMfXx2ui3YGG
 z3t9Xg++dWZOM29Vr4pX1hmbdk7Q31G/ZGyM88enbxkvmLPdFnbhJN6E4Si5hz9HpY7/438iT
 vmTo9/r4639D/UvMX7QNUnvwkmk2pFoxbUTQw/9s+hLlvl5QnXd7d/+vxhToy8OsdVfP+N07a
 dr3dyuOhtiIq23M91eJk74+KzUa/v6Hb/vBbVa3V5xqEPcw4eS/l4JyjuoN2UL2+7lz/Tas3d
 GPHnxou8s4In6kUip0/9HsfpfVcqZULZjk9qFb27+JVYijMSDbWYi4oTAVLLmJZ0AwAA
X-Env-Sender: xuyang2018.jy@fujitsu.com
X-Msg-Ref: server-3.tower-728.messagelabs.com!1665465813!65782!1
X-Originating-IP: [62.60.8.98]
X-SYMC-ESS-Client-Auth: outbound-route-from=pass
X-StarScan-Received: 
X-StarScan-Version: 9.87.3; banners=-,-,-
X-VirusChecked: Checked
Received: (qmail 10830 invoked from network); 11 Oct 2022 05:23:33 -0000
Received: from unknown (HELO n03ukasimr03.n03.fujitsu.local) (62.60.8.98)
 by server-3.tower-728.messagelabs.com with ECDHE-RSA-AES256-GCM-SHA384
 encrypted SMTP; 11 Oct 2022 05:23:33 -0000
Received: from n03ukasimr03.n03.fujitsu.local (localhost [127.0.0.1])
 by n03ukasimr03.n03.fujitsu.local (Postfix) with ESMTP id 653991B0;
 Tue, 11 Oct 2022 06:23:33 +0100 (BST)
Received: from R01UKEXCASM126.r01.fujitsu.local (R01UKEXCASM126
 [10.183.43.178])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-SHA384 (256/256 bits))
 (No client certificate requested)
 by n03ukasimr03.n03.fujitsu.local (Postfix) with ESMTPS id 591701AC;
 Tue, 11 Oct 2022 06:23:33 +0100 (BST)
Received: from localhost.localdomain (10.167.220.84) by
 R01UKEXCASM126.r01.fujitsu.local (10.183.43.178) with Microsoft SMTP Server
 (TLS) id 15.0.1497.32; Tue, 11 Oct 2022 06:23:31 +0100
From: Yang Xu <xuyang2018.jy@fujitsu.com>
To: <rpalethorpe@suse.de>
Date: Tue, 11 Oct 2022 14:24:02 +0800
Message-ID: <1665469442-2051-1-git-send-email-xuyang2018.jy@fujitsu.com>
X-Mailer: git-send-email 1.8.3.1
In-Reply-To: <87a663als4.fsf@suse.de>
References: <87a663als4.fsf@suse.de>
MIME-Version: 1.0
X-Originating-IP: [10.167.220.84]
X-ClientProxiedBy: G08CNEXCHPEKD07.g08.fujitsu.local (10.167.33.80) To
 R01UKEXCASM126.r01.fujitsu.local (10.183.43.178)
X-Virus-Scanned: clamav-milter 0.102.4 at in-3.smtp.seeweb.it
X-Virus-Status: Clean
Subject: [LTP] [PATCH v2] syscalls/prctl10: Add basic test for PR_SET/GET_TSC
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
Cc: ltp@lists.linux.it
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: ltp-bounces+ltp=archiver.kernel.org@lists.linux.it
Sender: "ltp" <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>

Signed-off-by: Yang Xu <xuyang2018.jy@fujitsu.com>
---
 include/lapi/prctl.h                       |   7 ++
 runtest/syscalls                           |   1 +
 testcases/kernel/syscalls/prctl/.gitignore |   1 +
 testcases/kernel/syscalls/prctl/prctl10.c  | 108 +++++++++++++++++++++
 4 files changed, 117 insertions(+)
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
index 61a7b7677..51de0a614 100644
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
index 000000000..01307ecd7
--- /dev/null
+++ b/testcases/kernel/syscalls/prctl/prctl10.c
@@ -0,0 +1,108 @@
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
+ * - Pass PR_TSC_SIGSEGV to arg2 to generate a SIGSEGV when read.
+ */
+
+#include <sys/prctl.h>
+#include <string.h>
+#include <stdio.h>
+#include <stdlib.h>
+#include "tst_test.h"
+#include "lapi/prctl.h"
+
+#define TCASE_ENTRY(tsc_read_stat) { .name = #tsc_read_stat, .read_stat = tsc_read_stat}
+
+static const char * const tsc_read_stat_names[] = {
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
+static uint64_t rdtsc(void)
+{
+	uint32_t lo, hi;
+	/* We cannot use "=A", since this would use %rax on x86_64 */
+	__asm__ __volatile__ ("rdtsc" : "=a" (lo), "=d" (hi));
+	return (uint64_t)hi << 32 | lo;
+}
+
+
+static int expected_status(int status, int exp_status)
+{
+	if (!exp_status && WIFEXITED(status))
+		return 0;
+
+	if (exp_status && WIFSIGNALED(status) && WTERMSIG(status) == exp_status)
+		return 0;
+
+	return 1;
+}
+
+static void verify_prctl(unsigned int n)
+{
+	struct tcase *tc = &tcases[n];
+	unsigned long long time1, time2;
+	int tsc_val = 0, pid, status;
+
+	pid = SAFE_FORK();
+	if (!pid) {
+		TST_EXP_PASS_SILENT(prctl(PR_SET_TSC, tc->read_stat));
+		TST_EXP_PASS_SILENT(prctl(PR_GET_TSC, &tsc_val));
+		if (tsc_val == tc->read_stat)
+			tst_res(TPASS, "current state is %s(%d)",
+					tc->name, tc->read_stat);
+		else
+			tst_res(TFAIL, "current state is %s(%d), expect %s(%d)",
+					tsc_read_stat_names[tsc_val],
+					tsc_val, tc->name, tc->read_stat);
+
+		time1 = rdtsc();
+		time2 = rdtsc();
+		if (time2 > time1)
+			tst_res(TPASS, "rdtsc works correctly, %lld ->%lld",
+				time1, time2);
+		else
+			tst_res(TFAIL, "rdtsc works incorrectly, %lld ->%lld",
+				time1, time2);
+		exit(0);
+	}
+	SAFE_WAITPID(pid, &status, 0);
+
+	if (expected_status(status, tc->read_stat == PR_TSC_SIGSEGV ? SIGSEGV : 0))
+		tst_res(TFAIL, "Test %s failed", tc->name);
+	else
+		tst_res(TPASS, "Test %s succeeded", tc->name);
+}
+
+static struct tst_test test = {
+	.needs_root = 1,
+	.forks_child = 1,
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
