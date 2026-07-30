Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 91A9DC531D0
	for <ltp@archiver.kernel.org>; Thu, 30 Jul 2026 06:35:33 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id E14563E2EEA
	for <ltp@archiver.kernel.org>; Thu, 30 Jul 2026 08:35:31 +0200 (CEST)
Received: from in-2.smtp.seeweb.it (in-2.smtp.seeweb.it
 [IPv6:2001:4b78:1:20::2])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1) server-digest SHA384)
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 3661B3E29BF
 for <ltp@lists.linux.it>; Thu, 30 Jul 2026 05:29:41 +0200 (CEST)
Received: from mailgw.kylinos.cn (mailgw.kylinos.cn [124.126.103.232])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-2.smtp.seeweb.it (Postfix) with ESMTPS id 2C56C60082E
 for <ltp@lists.linux.it>; Thu, 30 Jul 2026 05:29:37 +0200 (CEST)
X-UUID: e07029ae8bc611f1aa26b74ffac11d73-20260730
X-CTIC-Tags: HR_CC_AS_FROM, HR_CC_COUNT, HR_CC_DOMAIN_COUNT, HR_CC_NAME,
 HR_CTE_8B
 HR_CTT_MISS, HR_DATE_H, HR_DATE_WKD, HR_DATE_ZONE, HR_FROM_NAME
 HR_SJ_DIGIT_LEN, HR_SJ_LANG, HR_SJ_LEN, HR_SJ_LETTER, HR_SJ_NOR_SYM
 HR_SJ_PHRASE, HR_SJ_PHRASE_LEN, HR_SJ_WS, HR_TO_COUNT, HR_TO_DOMAIN_COUNT
 HR_TO_NO_NAME, IP_TRUSTED, SRC_TRUSTED, DN_TRUSTED, SA_TRUSTED
 SA_EXISTED, SN_EXISTED, SPF_NOPASS, DKIM_NOPASS, DMARC_NOPASS
X-CID-O-RULE: Release_Ham
X-CID-RULE: Release_Ham
X-CID-O-INFO: VERSION:1.3.12, REQID:f36b1fea-6f71-4679-82e1-4c728ee0bc42, IP:10,
 URL:0,TC:0,Content:0,EDM:0,RT:0,SF:0,FILE:0,BULK:0,RULE:Release_Ham,ACTION
 :release,TS:10
X-CID-INFO: VERSION:1.3.12, REQID:f36b1fea-6f71-4679-82e1-4c728ee0bc42, IP:10,
 UR
 L:0,TC:0,Content:0,EDM:0,RT:0,SF:0,FILE:0,BULK:0,RULE:Release_Ham,ACTION:r
 elease,TS:10
X-CID-META: VersionHash:e7bac3a, CLOUDID:c75e41ddd49863138c8b7849f4fd3869,
 BulkI
 D:260730112934KIUW6FT3,BulkQuantity:0,Recheck:0,SF:10|66|78|81|82|102|127|
 850|865|898,TC:nil,Content:0|15|50,EDM:-3,IP:-2,URL:0,File:nil,RT:nil,Bulk
 :nil,QS:nil,BEC:nil,COL:0,OSI:0,OSA:0,AV:0,LES:1,SPR:NO,DKR:0,DKP:0,BRR:0,
 BRE:0,ARC:0
X-CID-BVR: 2,SSN|SDN
X-CID-BAS: 2,SSN|SDN,0,_
X-CID-FACTOR: TF_CID_SPAM_SNR
X-CID-RHF: D41D8CD98F00B204E9800998ECF8427E
X-UUID: e07029ae8bc611f1aa26b74ffac11d73-20260730
X-User: sunshaojie@kylinos.cn
Received: from localhost.localdomain [(223.70.159.239)] by mailgw.kylinos.cn
 (envelope-from <sunshaojie@kylinos.cn>)
 (Generic MTA with TLSv1.3 TLS_AES_256_GCM_SHA384 256/256)
 with ESMTP id 1712737286; Thu, 30 Jul 2026 11:29:31 +0800
From: Shaojie Sun <sunshaojie@kylinos.cn>
To: ltp@lists.linux.it
Date: Thu, 30 Jul 2026 11:28:49 +0800
Message-Id: <20260730032850.775128-3-sunshaojie@kylinos.cn>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20260730032850.775128-1-sunshaojie@kylinos.cn>
References: <20260730032850.775128-1-sunshaojie@kylinos.cn>
MIME-Version: 1.0
X-Virus-Scanned: clamav-milter 1.0.9 at in-2.smtp.seeweb.it
X-Virus-Status: Clean
X-Mailman-Approved-At: Thu, 30 Jul 2026 08:34:47 +0200
Subject: [LTP] [PATCH 2/3] cgroup: add CPU cgroup v2 tests ported from
 kselftest
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

Port the following kselftest CPU cgroup v2 tests to LTP:
  - test_cpucg_subtree_control (cgroup_cpu01)
  - test_cpucg_stats (cgroup_cpu02)
  - test_cpucg_nice (cgroup_cpu03)
  - test_cpucg_weight_overprovisioned (cgroup_cpu04)
  - test_cpucg_weight_underprovisioned (cgroup_cpu04)
  - test_cpucg_nested_weight_overprovisioned (cgroup_cpu04)
  - test_cpucg_nested_weight_underprovisioned (cgroup_cpu04)
  - test_cpucg_max (cgroup_cpu05)
  - test_cpucg_max_nested (cgroup_cpu05)

Converted from tools/testing/selftests/cgroup/test_cpu.c.

Signed-off-by: Shaojie Sun <sunshaojie@kylinos.cn>
---
 testcases/kernel/controllers/cpu/.gitignore   |   5 +
 testcases/kernel/controllers/cpu/Makefile     |   9 +
 .../kernel/controllers/cpu/cgroup_cpu01.c     |  65 ++++
 .../kernel/controllers/cpu/cgroup_cpu02.c     | 104 ++++++
 .../kernel/controllers/cpu/cgroup_cpu03.c     | 116 ++++++
 .../kernel/controllers/cpu/cgroup_cpu04.c     | 346 ++++++++++++++++++
 .../kernel/controllers/cpu/cgroup_cpu05.c     | 175 +++++++++
 .../controllers/cpu/cgroup_cpu_common.h       | 130 +++++++
 8 files changed, 950 insertions(+)
 create mode 100644 testcases/kernel/controllers/cpu/.gitignore
 create mode 100644 testcases/kernel/controllers/cpu/Makefile
 create mode 100644 testcases/kernel/controllers/cpu/cgroup_cpu01.c
 create mode 100644 testcases/kernel/controllers/cpu/cgroup_cpu02.c
 create mode 100644 testcases/kernel/controllers/cpu/cgroup_cpu03.c
 create mode 100644 testcases/kernel/controllers/cpu/cgroup_cpu04.c
 create mode 100644 testcases/kernel/controllers/cpu/cgroup_cpu05.c
 create mode 100644 testcases/kernel/controllers/cpu/cgroup_cpu_common.h

diff --git a/testcases/kernel/controllers/cpu/.gitignore b/testcases/kernel/controllers/cpu/.gitignore
new file mode 100644
index 000000000..1a81d332a
--- /dev/null
+++ b/testcases/kernel/controllers/cpu/.gitignore
@@ -0,0 +1,5 @@
+/cgroup_cpu01
+/cgroup_cpu02
+/cgroup_cpu03
+/cgroup_cpu04
+/cgroup_cpu05
diff --git a/testcases/kernel/controllers/cpu/Makefile b/testcases/kernel/controllers/cpu/Makefile
new file mode 100644
index 000000000..d1fbcba3e
--- /dev/null
+++ b/testcases/kernel/controllers/cpu/Makefile
@@ -0,0 +1,9 @@
+# SPDX-License-Identifier: GPL-2.0-or-later
+
+top_srcdir		?= ../../../..
+
+include $(top_srcdir)/include/mk/testcases.mk
+
+LDLIBS			+= -lpthread
+
+include $(top_srcdir)/include/mk/generic_leaf_target.mk
diff --git a/testcases/kernel/controllers/cpu/cgroup_cpu01.c b/testcases/kernel/controllers/cpu/cgroup_cpu01.c
new file mode 100644
index 000000000..b8fd1d770
--- /dev/null
+++ b/testcases/kernel/controllers/cpu/cgroup_cpu01.c
@@ -0,0 +1,65 @@
+// SPDX-License-Identifier: GPL-2.0-or-later
+/*
+ * Copyright (c) 2025 Richard Palethorpe <rpalethorpe@suse.com>
+ */
+
+/*\
+ * Conversion of kselftest test_cpucg_subtree_control from
+ * tools/testing/selftests/cgroup/test_cpu.c.
+ *
+ * This test creates two nested cgroups with and without enabling
+ * the cpu controller.
+ *
+ * The LTP API automatically adds controllers to subtree_control when
+ * a child cgroup is added. So unlike the kselftest we remove the
+ * controller after it being added automatically.
+ */
+
+#define _GNU_SOURCE
+#include "tst_test.h"
+
+static struct tst_cg_group *cg_parent_0, *cg_child_0;
+static struct tst_cg_group *cg_parent_1, *cg_child_1;
+
+static void test_cpucg_subtree_control(void)
+{
+	cg_parent_0 = tst_cg_group_mk(tst_cg, "cpucg_test_0");
+	cg_child_0 = tst_cg_group_mk(cg_parent_0, "cpucg_child_0");
+
+	cg_parent_1 = tst_cg_group_mk(tst_cg, "cpucg_test_1");
+	cg_child_1 = tst_cg_group_mk(cg_parent_1, "cpucg_child_1");
+	SAFE_CG_PRINT(cg_parent_1, "cgroup.subtree_control", "-cpu");
+
+	TST_EXP_POSITIVE(
+		SAFE_CG_OCCURSIN(cg_child_0, "cgroup.controllers", "cpu"),
+		"child with cpu enabled should have cpu controller");
+
+	TST_EXP_POSITIVE(
+		!SAFE_CG_OCCURSIN(cg_child_1, "cgroup.controllers", "cpu"),
+		"child without cpu enabled should not have cpu controller");
+
+	cg_child_1 = tst_cg_group_rm(cg_child_1);
+	cg_parent_1 = tst_cg_group_rm(cg_parent_1);
+	cg_child_0 = tst_cg_group_rm(cg_child_0);
+	cg_parent_0 = tst_cg_group_rm(cg_parent_0);
+}
+
+static void cleanup(void)
+{
+	if (cg_child_1)
+		cg_child_1 = tst_cg_group_rm(cg_child_1);
+	if (cg_parent_1)
+		cg_parent_1 = tst_cg_group_rm(cg_parent_1);
+	if (cg_child_0)
+		cg_child_0 = tst_cg_group_rm(cg_child_0);
+	if (cg_parent_0)
+		cg_parent_0 = tst_cg_group_rm(cg_parent_0);
+}
+
+static struct tst_test test = {
+	.cleanup = cleanup,
+	.test_all = test_cpucg_subtree_control,
+	.needs_cgroup_ver = TST_CG_V2,
+	.needs_cgroup_ctrls = (const char *const []){ "cpu", NULL },
+	.needs_cgroup_nsdelegate = 0,
+};
diff --git a/testcases/kernel/controllers/cpu/cgroup_cpu02.c b/testcases/kernel/controllers/cpu/cgroup_cpu02.c
new file mode 100644
index 000000000..55b076ddd
--- /dev/null
+++ b/testcases/kernel/controllers/cpu/cgroup_cpu02.c
@@ -0,0 +1,104 @@
+// SPDX-License-Identifier: GPL-2.0-or-later
+/*
+ * Copyright (c) 2025 Richard Palethorpe <rpalethorpe@suse.com>
+ */
+
+/*\
+ * Conversion of kselftest test_cpucg_stats from
+ * tools/testing/selftests/cgroup/test_cpu.c.
+ *
+ * Creates a cpu cgroup, burns a CPU for a few quanta, and verifies that
+ * cpu.stat shows the expected output.
+ */
+
+#define _GNU_SOURCE
+#include <time.h>
+#include <sys/wait.h>
+
+#include "tst_test.h"
+#include "cgroup_cpu_common.h"
+
+#define USEC_PER_SEC 1000000L
+
+static struct tst_cg_group *cg_test;
+
+static void test_cpucg_stats(void)
+{
+	long usage_usec, user_usec, system_usec;
+	long usage_seconds = 2;
+	long expected_usage_usec = usage_seconds * USEC_PER_SEC;
+	int status;
+
+	cg_test = tst_cg_group_mk(tst_cg, "cpucg_test");
+
+	SAFE_CG_LINES_SCANF(cg_test, "cpu.stat",
+			    "usage_usec %ld", &usage_usec);
+	SAFE_CG_LINES_SCANF(cg_test, "cpu.stat",
+			    "user_usec %ld", &user_usec);
+	SAFE_CG_LINES_SCANF(cg_test, "cpu.stat",
+			    "system_usec %ld", &system_usec);
+
+	if (usage_usec != 0 || user_usec != 0 || system_usec != 0) {
+		tst_res(TFAIL,
+			"Initial cpu.stat values not zero: usage=%ld user=%ld system=%ld",
+			usage_usec, user_usec, system_usec);
+		goto cleanup;
+	}
+
+	if (!SAFE_FORK()) {
+		struct cpu_hog_func_param param = {
+			.nprocs = 1,
+			.ts = {
+				.tv_sec = usage_seconds,
+				.tv_nsec = 0,
+			},
+			.clock_type = CPU_HOG_CLOCK_PROCESS,
+		};
+
+		SAFE_CG_PRINTF(cg_test, "cgroup.procs", "%d", getpid());
+		exit(hog_cpus_timed(&param));
+	}
+
+	SAFE_WAITPID(-1, &status, 0);
+
+	SAFE_CG_LINES_SCANF(cg_test, "cpu.stat",
+			    "usage_usec %ld", &usage_usec);
+	SAFE_CG_LINES_SCANF(cg_test, "cpu.stat",
+			    "user_usec %ld", &user_usec);
+
+	if (user_usec <= 0) {
+		tst_res(TFAIL, "user_usec=%ld should be > 0 after CPU hog",
+			user_usec);
+		goto cleanup;
+	}
+
+	if (!values_close(usage_usec, expected_usage_usec, 1)) {
+		tst_res(TFAIL,
+			"usage_usec=%ld should be close to expected=%ld (diff > 1%%)",
+			usage_usec, expected_usage_usec);
+		goto cleanup;
+	}
+
+	tst_res(TPASS, "cpu.stat values valid: usage=%ld user=%ld",
+		usage_usec, user_usec);
+
+cleanup:
+	cg_test = tst_cg_group_rm(cg_test);
+}
+
+static void cleanup(void)
+{
+	if (cg_test) {
+		SAFE_CG_PRINTF(tst_cg_drain, "cgroup.procs", "%d", getpid());
+		cg_test = tst_cg_group_rm(cg_test);
+	}
+}
+
+static struct tst_test test = {
+	.cleanup = cleanup,
+	.test_all = test_cpucg_stats,
+	.forks_child = 1,
+	.needs_cgroup_ver = TST_CG_V2,
+	.needs_cgroup_ctrls = (const char *const []){ "cpu", NULL },
+	.needs_cgroup_nsdelegate = 0,
+};
diff --git a/testcases/kernel/controllers/cpu/cgroup_cpu03.c b/testcases/kernel/controllers/cpu/cgroup_cpu03.c
new file mode 100644
index 000000000..64175842a
--- /dev/null
+++ b/testcases/kernel/controllers/cpu/cgroup_cpu03.c
@@ -0,0 +1,116 @@
+// SPDX-License-Identifier: GPL-2.0-or-later
+/*
+ * Copyright (c) 2025 Richard Palethorpe <rpalethorpe@suse.com>
+ */
+
+/*\
+ * Conversion of kselftest test_cpucg_nice from
+ * tools/testing/selftests/cgroup/test_cpu.c.
+ *
+ * Creates a nice process that consumes CPU and checks that the elapsed
+ * nice time in the cgroup is close to the expected time.
+ */
+
+#define _GNU_SOURCE
+#include <string.h>
+#include <sys/wait.h>
+#include <unistd.h>
+
+#include "tst_test.h"
+#include "cgroup_cpu_common.h"
+
+#define USEC_PER_SEC 1000000L
+
+static struct tst_cg_group *cg_child;
+
+static long read_nice_usec(void)
+{
+	char buf[256];
+	long val = -1;
+	char *line, *saveptr;
+
+	SAFE_CG_READ(cg_child, "cpu.stat", buf, sizeof(buf));
+
+	line = strtok_r(buf, "\n", &saveptr);
+	while (line) {
+		if (sscanf(line, "nice_usec %ld", &val) == 1)
+			return val;
+		line = strtok_r(NULL, "\n", &saveptr);
+	}
+
+	return -1;
+}
+
+static void test_cpucg_nice(void)
+{
+	long user_usec, nice_usec;
+	long usage_seconds = 2;
+	long expected_nice_usec = usage_seconds * USEC_PER_SEC;
+	int status;
+
+	cg_child = tst_cg_group_mk(tst_cg, "cpucg_test");
+
+	SAFE_CG_LINES_SCANF(cg_child, "cpu.stat",
+			    "user_usec %ld", &user_usec);
+
+	nice_usec = read_nice_usec();
+	if (nice_usec < 0)
+		tst_brk(TCONF, "nice_usec not available in cpu.stat");
+
+	if (user_usec != 0 || nice_usec != 0) {
+		tst_res(TFAIL,
+			"Initial cpu.stat values not zero: user=%ld nice=%ld", user_usec, nice_usec);
+		goto cleanup;
+	}
+
+	if (!SAFE_FORK()) {
+		struct cpu_hog_func_param param = {
+			.nprocs = 1,
+			.ts = {
+				.tv_sec = usage_seconds,
+				.tv_nsec = 0,
+			},
+			.clock_type = CPU_HOG_CLOCK_PROCESS,
+		};
+		SAFE_CG_PRINTF(cg_child, "cgroup.procs", "%d", getpid());
+
+		if (nice(1) == -1 && errno != 0)
+			exit(1);
+		exit(hog_cpus_timed(&param));
+	}
+
+	SAFE_WAITPID(-1, &status, 0);
+
+	nice_usec = read_nice_usec();
+
+	if (!values_close(nice_usec, expected_nice_usec, 1)) {
+		tst_res(TFAIL,
+			"nice_usec=%ld should be close to expected=%ld",
+			nice_usec, expected_nice_usec);
+		goto cleanup;
+	}
+
+	tst_res(TPASS, "nice_usec=%ld is close to expected=%ld",
+		nice_usec, expected_nice_usec);
+
+cleanup:
+	cg_child = tst_cg_group_rm(cg_child);
+}
+
+static void cleanup(void)
+{
+	if (cg_child) {
+		SAFE_CG_PRINTF(tst_cg_drain, "cgroup.procs", "%d", getpid());
+		cg_child = tst_cg_group_rm(cg_child);
+	}
+}
+
+static struct tst_test test = {
+	.cleanup = cleanup,
+	.test_all = test_cpucg_nice,
+	.forks_child = 1,
+	.needs_root = 1,
+	.needs_cgroup_ver = TST_CG_V2,
+	.needs_cgroup_ctrls = (const char *const []){ "cpu", NULL },
+	.needs_cgroup_nsdelegate = 0,
+};
diff --git a/testcases/kernel/controllers/cpu/cgroup_cpu04.c b/testcases/kernel/controllers/cpu/cgroup_cpu04.c
new file mode 100644
index 000000000..c45097f86
--- /dev/null
+++ b/testcases/kernel/controllers/cpu/cgroup_cpu04.c
@@ -0,0 +1,346 @@
+// SPDX-License-Identifier: GPL-2.0-or-later
+/*
+ * Copyright (c) 2025 Richard Palethorpe <rpalethorpe@suse.com>
+ */
+
+/*\
+ * Conversion of kselftest cpu weight tests from
+ * tools/testing/selftests/cgroup/test_cpu.c.
+ *
+ * Includes:
+ * - test_cpucg_weight_overprovisioned
+ * - test_cpucg_weight_underprovisioned
+ * - test_cpucg_nested_weight_overprovisioned
+ * - test_cpucg_nested_weight_underprovisioned
+ */
+
+#define _GNU_SOURCE
+#include <sys/wait.h>
+#include <unistd.h>
+
+#include "tst_test.h"
+#include "cgroup_cpu_common.h"
+
+#define USEC_PER_SEC 1000000L
+#define HOG_SECONDS 10
+
+static struct tst_cg_group *cg_parent;
+static struct tst_cg_group *cg_child;
+static struct tst_cg_group *cg_leaf[3];
+
+static pid_t fork_hog_child(struct tst_cg_group *cg, int nprocs,
+			     enum hog_clock_type clock_type)
+{
+	pid_t pid;
+
+	pid = SAFE_FORK();
+	if (pid == 0) {
+		struct cpu_hog_func_param param = {
+			.nprocs = nprocs,
+			.ts = {
+				.tv_sec = HOG_SECONDS,
+				.tv_nsec = 0,
+			},
+			.clock_type = clock_type,
+		};
+
+		SAFE_CG_PRINTF(cg, "cgroup.procs", "%d", getpid());
+		exit(hog_cpus_timed(&param));
+	}
+
+	return pid;
+}
+
+static void wait_children(pid_t *pids, int n)
+{
+	int i, status;
+
+	for (i = 0; i < n; i++)
+		SAFE_WAITPID(pids[i], &status, 0);
+}
+
+static void test_cpucg_weight_overprovisioned(void)
+{
+	int i, nprocs;
+	pid_t pids[3];
+	long usage[3];
+	long delta;
+
+	cg_parent = tst_cg_group_mk(tst_cg, "cpucg_test_0");
+
+	for (i = 0; i < 3; i++) {
+		cg_leaf[i] = tst_cg_group_mk(cg_parent, "cpucg_child_%d", i);
+		SAFE_CG_PRINTF(cg_leaf[i], "cpu.weight", "%d", 50 * (i + 1));
+	}
+
+	nprocs = tst_ncpus_available();
+	for (i = 0; i < 3; i++)
+		pids[i] = fork_hog_child(cg_leaf[i], nprocs,
+					 CPU_HOG_CLOCK_WALL);
+
+	wait_children(pids, 3);
+
+	for (i = 0; i < 3; i++) {
+		SAFE_CG_LINES_SCANF(cg_leaf[i], "cpu.stat",
+				    "usage_usec %ld", &usage[i]);
+	}
+
+	if (usage[1] <= usage[0] || usage[2] <= usage[1]) {
+		tst_res(TFAIL,
+			"CPU usage not monotonic with weight: %ld %ld %ld", usage[0], usage[1], usage[2]);
+		goto cleanup;
+	}
+
+	for (i = 0; i < 2; i++) {
+		delta = usage[i + 1] - usage[i];
+		if (!values_close(delta, usage[0], 35)) {
+			tst_res(TFAIL,
+				"weight delta %ld not close to base %ld (idx=%d)",
+				delta, usage[0], i);
+			goto cleanup;
+		}
+	}
+
+	tst_res(TPASS, "weight overprovisioned: usage %ld %ld %ld",
+		usage[0], usage[1], usage[2]);
+
+cleanup:
+	for (i = 2; i >= 0; i--) {
+		if (cg_leaf[i]) {
+			SAFE_CG_PRINTF(tst_cg_drain, "cgroup.procs",
+				       "%d", getpid());
+			cg_leaf[i] = tst_cg_group_rm(cg_leaf[i]);
+		}
+	}
+	cg_parent = tst_cg_group_rm(cg_parent);
+}
+
+static void test_cpucg_weight_underprovisioned(void)
+{
+	int i;
+	pid_t pids[3];
+	long usage[3];
+
+	if (tst_ncpus_available() < 4) {
+		tst_res(TCONF, "Need at least 4 CPUs for underprovisioned test");
+		return;
+	}
+
+	cg_parent = tst_cg_group_mk(tst_cg, "cpucg_test_1");
+
+	for (i = 0; i < 3; i++) {
+		cg_leaf[i] = tst_cg_group_mk(cg_parent, "cpucg_child_%d", i);
+		SAFE_CG_PRINTF(cg_leaf[i], "cpu.weight", "%d", 50 * (i + 1));
+	}
+
+	for (i = 0; i < 3; i++)
+		pids[i] = fork_hog_child(cg_leaf[i], 1, CPU_HOG_CLOCK_WALL);
+
+	wait_children(pids, 3);
+
+	for (i = 0; i < 3; i++) {
+		SAFE_CG_LINES_SCANF(cg_leaf[i], "cpu.stat",
+				    "usage_usec %ld", &usage[i]);
+	}
+
+	if (!values_close(usage[0], usage[1], 15) ||
+	    !values_close(usage[0], usage[2], 15)) {
+		tst_res(TFAIL,
+			"Underprovisioned usages not equal: %ld %ld %ld", usage[0], usage[1], usage[2]);
+		goto cleanup;
+	}
+
+	tst_res(TPASS, "weight underprovisioned: usage %ld %ld %ld",
+		usage[0], usage[1], usage[2]);
+
+cleanup:
+	for (i = 2; i >= 0; i--) {
+		if (cg_leaf[i]) {
+			SAFE_CG_PRINTF(tst_cg_drain, "cgroup.procs",
+				       "%d", getpid());
+			cg_leaf[i] = tst_cg_group_rm(cg_leaf[i]);
+		}
+	}
+	cg_parent = tst_cg_group_rm(cg_parent);
+}
+
+static void test_cpucg_nested_weight_overprovisioned(void)
+{
+	int i, nprocs;
+	pid_t pids[3];
+	long usage[3], nested_leaf_usage, child_usage;
+
+	cg_parent = tst_cg_group_mk(tst_cg, "cpucg_nested_test");
+	cg_child = tst_cg_group_mk(cg_parent, "cpucg_child");
+
+	SAFE_CG_PRINT(cg_child, "cpu.weight", "1000");
+
+	cg_leaf[0] = tst_cg_group_mk(cg_parent, "cpucg_leaf_0");
+	SAFE_CG_PRINT(cg_leaf[0], "cpu.weight", "1000");
+
+	for (i = 1; i < 3; i++) {
+		cg_leaf[i] = tst_cg_group_mk(cg_child, "cpucg_leaf_%d", i);
+		SAFE_CG_PRINT(cg_leaf[i], "cpu.weight", "5000");
+	}
+
+	nprocs = tst_ncpus_available();
+	for (i = 0; i < 3; i++)
+		pids[i] = fork_hog_child(cg_leaf[i], nprocs,
+					 CPU_HOG_CLOCK_WALL);
+
+	wait_children(pids, 3);
+
+	for (i = 0; i < 3; i++) {
+		SAFE_CG_LINES_SCANF(cg_leaf[i], "cpu.stat",
+				    "usage_usec %ld", &usage[i]);
+	}
+
+	nested_leaf_usage = usage[1] + usage[2];
+	if (!values_close(usage[0], nested_leaf_usage, 15)) {
+		tst_res(TFAIL,
+			"Nested weight over: leaf0=%ld not close to leaf1+leaf2=%ld", usage[0], nested_leaf_usage);
+		goto cleanup;
+	}
+
+	SAFE_CG_LINES_SCANF(cg_child, "cpu.stat",
+			    "usage_usec %ld", &child_usage);
+	if (!values_close(child_usage, nested_leaf_usage, 1)) {
+		tst_res(TFAIL,
+			"Child usage=%ld not close to nested leaf usage=%ld",
+			child_usage, nested_leaf_usage);
+		goto cleanup;
+	}
+
+	tst_res(TPASS,
+		"nested weight overprovisioned: leaf0=%ld leaf1+leaf2=%ld",
+		usage[0], nested_leaf_usage);
+
+cleanup:
+	SAFE_CG_PRINTF(tst_cg_drain, "cgroup.procs", "%d", getpid());
+	for (i = 2; i >= 0; i--) {
+		if (cg_leaf[i])
+			cg_leaf[i] = tst_cg_group_rm(cg_leaf[i]);
+	}
+	if (cg_child)
+		cg_child = tst_cg_group_rm(cg_child);
+	if (cg_parent)
+		cg_parent = tst_cg_group_rm(cg_parent);
+}
+
+static void test_cpucg_nested_weight_underprovisioned(void)
+{
+	int i, nprocs;
+	pid_t pids[3];
+	long usage[3], nested_leaf_usage, child_usage;
+
+	if (tst_ncpus_available() < 4) {
+		tst_res(TCONF,
+			"Need at least 4 CPUs for nested underprovisioned test");
+		return;
+	}
+
+	cg_parent = tst_cg_group_mk(tst_cg, "cpucg_nested_test_2");
+	cg_child = tst_cg_group_mk(cg_parent, "cpucg_child");
+
+	SAFE_CG_PRINT(cg_child, "cpu.weight", "1000");
+
+	cg_leaf[0] = tst_cg_group_mk(cg_parent, "cpucg_leaf_0");
+	SAFE_CG_PRINT(cg_leaf[0], "cpu.weight", "1000");
+
+	for (i = 1; i < 3; i++) {
+		cg_leaf[i] = tst_cg_group_mk(cg_child, "cpucg_leaf_%d", i);
+		SAFE_CG_PRINT(cg_leaf[i], "cpu.weight", "5000");
+	}
+
+	nprocs = tst_ncpus_available() / 4;
+	if (nprocs < 1)
+		nprocs = 1;
+
+	for (i = 0; i < 3; i++)
+		pids[i] = fork_hog_child(cg_leaf[i], nprocs,
+					 CPU_HOG_CLOCK_WALL);
+
+	wait_children(pids, 3);
+
+	for (i = 0; i < 3; i++) {
+		SAFE_CG_LINES_SCANF(cg_leaf[i], "cpu.stat",
+				    "usage_usec %ld", &usage[i]);
+	}
+
+	nested_leaf_usage = usage[1] + usage[2];
+	if (!values_close(usage[0] * 2, nested_leaf_usage, 15)) {
+		tst_res(TFAIL,
+			"Nested weight under: leaf0=%ld leaf1+leaf2=%ld, leaf0*2=%ld not close to leaf1+leaf2",
+			usage[0], nested_leaf_usage, usage[0] * 2);
+		goto cleanup;
+	}
+
+	SAFE_CG_LINES_SCANF(cg_child, "cpu.stat",
+			    "usage_usec %ld", &child_usage);
+	if (!values_close(child_usage, nested_leaf_usage, 1)) {
+		tst_res(TFAIL,
+			"Child usage=%ld not close to nested leaf usage=%ld",
+			child_usage, nested_leaf_usage);
+		goto cleanup;
+	}
+
+	tst_res(TPASS,
+		"nested weight underprovisioned: leaf0=%ld leaf1+leaf2=%ld",
+		usage[0], nested_leaf_usage);
+
+cleanup:
+	SAFE_CG_PRINTF(tst_cg_drain, "cgroup.procs", "%d", getpid());
+	for (i = 2; i >= 0; i--) {
+		if (cg_leaf[i])
+			cg_leaf[i] = tst_cg_group_rm(cg_leaf[i]);
+	}
+	if (cg_child)
+		cg_child = tst_cg_group_rm(cg_child);
+	if (cg_parent)
+		cg_parent = tst_cg_group_rm(cg_parent);
+}
+
+static void run(unsigned int n)
+{
+	switch (n) {
+	case 0:
+		test_cpucg_weight_overprovisioned();
+		break;
+	case 1:
+		test_cpucg_weight_underprovisioned();
+		break;
+	case 2:
+		test_cpucg_nested_weight_overprovisioned();
+		break;
+	case 3:
+		test_cpucg_nested_weight_underprovisioned();
+		break;
+	}
+}
+
+static void cleanup(void)
+{
+	int i;
+
+	SAFE_CG_PRINTF(tst_cg_drain, "cgroup.procs", "%d", getpid());
+	for (i = 2; i >= 0; i--) {
+		if (cg_leaf[i])
+			cg_leaf[i] = tst_cg_group_rm(cg_leaf[i]);
+	}
+	if (cg_child)
+		cg_child = tst_cg_group_rm(cg_child);
+	if (cg_parent)
+		cg_parent = tst_cg_group_rm(cg_parent);
+}
+
+static struct tst_test test = {
+	.cleanup = cleanup,
+	.test = run,
+	.tcnt = 4,
+	.forks_child = 1,
+	.timeout = 60,
+	.needs_root = 1,
+	.needs_cgroup_ver = TST_CG_V2,
+	.needs_cgroup_ctrls = (const char *const []){ "cpu", NULL },
+	.needs_cgroup_nsdelegate = 0,
+};
diff --git a/testcases/kernel/controllers/cpu/cgroup_cpu05.c b/testcases/kernel/controllers/cpu/cgroup_cpu05.c
new file mode 100644
index 000000000..8da943777
--- /dev/null
+++ b/testcases/kernel/controllers/cpu/cgroup_cpu05.c
@@ -0,0 +1,175 @@
+// SPDX-License-Identifier: GPL-2.0-or-later
+/*
+ * Copyright (c) 2025 Richard Palethorpe <rpalethorpe@suse.com>
+ */
+
+/*\
+ * Conversion of kselftest cpu.max tests from
+ * tools/testing/selftests/cgroup/test_cpu.c.
+ *
+ * Includes:
+ * - test_cpucg_max: creates a cgroup with cpu.max quota and verifies
+ *   a process is properly throttled.
+ * - test_cpucg_max_nested: verifies a process inside a nested cgroup
+ *   whose parent has cpu.max set is properly throttled.
+ */
+
+#define _GNU_SOURCE
+#include <sys/wait.h>
+#include <unistd.h>
+
+#include "tst_test.h"
+#include "cgroup_cpu_common.h"
+
+#define USEC_PER_SEC 1000000L
+
+static struct tst_cg_group *cg_parent, *cg_child;
+
+static void test_cpucg_max(void)
+{
+	long quota_usec = 1000;
+	long period_usec = 100000;
+	long duration_seconds = 1;
+	long usage_usec;
+	long n_periods, remainder_usec, expected_usage_usec;
+	long duration_usec = duration_seconds * USEC_PER_SEC;
+	int status;
+
+	cg_parent = tst_cg_group_mk(tst_cg, "cpucg_max_test");
+
+	SAFE_CG_PRINTF(cg_parent, "cpu.max", "%ld %ld", quota_usec, period_usec);
+
+	if (!SAFE_FORK()) {
+		struct cpu_hog_func_param param = {
+			.nprocs = 1,
+			.ts = {
+				.tv_sec = duration_seconds,
+				.tv_nsec = 0,
+			},
+			.clock_type = CPU_HOG_CLOCK_WALL,
+		};
+
+		SAFE_CG_PRINTF(cg_parent, "cgroup.procs", "%d", getpid());
+		exit(hog_cpus_timed(&param));
+	}
+
+	SAFE_WAITPID(-1, &status, 0);
+
+	SAFE_CG_LINES_SCANF(cg_parent, "cpu.stat",
+			    "usage_usec %ld", &usage_usec);
+
+	/*
+	 * The following calculation applies only since
+	 * the cpu hog is set to run as per wall-clock time
+	 */
+	n_periods = duration_usec / period_usec;
+	remainder_usec = duration_usec - n_periods * period_usec;
+	expected_usage_usec = n_periods * quota_usec +
+			      MIN(remainder_usec, quota_usec);
+
+	if (!values_close(usage_usec, expected_usage_usec, 10)) {
+		tst_res(TFAIL,
+			"cpu.max: usage=%ld expected=%ld",
+			usage_usec, expected_usage_usec);
+		goto cleanup;
+	}
+
+	tst_res(TPASS, "cpu.max: usage=%ld close to expected=%ld",
+		usage_usec, expected_usage_usec);
+
+cleanup:
+	cg_parent = tst_cg_group_rm(cg_parent);
+}
+
+static void test_cpucg_max_nested(void)
+{
+	long quota_usec = 1000;
+	long period_usec = 100000;
+	long duration_seconds = 1;
+	long usage_usec;
+	long n_periods, remainder_usec, expected_usage_usec;
+	long duration_usec = duration_seconds * USEC_PER_SEC;
+	int status;
+
+	cg_parent = tst_cg_group_mk(tst_cg, "cpucg_max_parent");
+	cg_child = tst_cg_group_mk(cg_parent, "cpucg_max_child");
+
+	SAFE_CG_PRINTF(cg_parent, "cpu.max", "%ld %ld", quota_usec, period_usec);
+
+	if (!SAFE_FORK()) {
+		struct cpu_hog_func_param param = {
+			.nprocs = 1,
+			.ts = {
+				.tv_sec = duration_seconds,
+				.tv_nsec = 0,
+			},
+			.clock_type = CPU_HOG_CLOCK_WALL,
+		};
+
+		SAFE_CG_PRINTF(cg_child, "cgroup.procs", "%d", getpid());
+		exit(hog_cpus_timed(&param));
+	}
+
+	SAFE_WAITPID(-1, &status, 0);
+
+	SAFE_CG_LINES_SCANF(cg_child, "cpu.stat",
+			    "usage_usec %ld", &usage_usec);
+
+	/*
+	 * The following calculation applies only since
+	 * the cpu hog is set to run as per wall-clock time
+	 */
+	n_periods = duration_usec / period_usec;
+	remainder_usec = duration_usec - n_periods * period_usec;
+	expected_usage_usec = n_periods * quota_usec +
+			      MIN(remainder_usec, quota_usec);
+
+	if (!values_close(usage_usec, expected_usage_usec, 10)) {
+		tst_res(TFAIL,
+			"cpu.max nested: usage=%ld expected=%ld",
+			usage_usec, expected_usage_usec);
+		goto cleanup;
+	}
+
+	tst_res(TPASS, "cpu.max nested: usage=%ld close to expected=%ld",
+		usage_usec, expected_usage_usec);
+
+cleanup:
+	if (cg_child)
+		cg_child = tst_cg_group_rm(cg_child);
+	if (cg_parent)
+		cg_parent = tst_cg_group_rm(cg_parent);
+}
+
+static void run(unsigned int n)
+{
+	switch (n) {
+	case 0:
+		test_cpucg_max();
+		break;
+	case 1:
+		test_cpucg_max_nested();
+		break;
+	}
+}
+
+static void cleanup(void)
+{
+	SAFE_CG_PRINTF(tst_cg_drain, "cgroup.procs", "%d", getpid());
+	if (cg_child)
+		cg_child = tst_cg_group_rm(cg_child);
+	if (cg_parent)
+		cg_parent = tst_cg_group_rm(cg_parent);
+}
+
+static struct tst_test test = {
+	.cleanup = cleanup,
+	.test = run,
+	.tcnt = 2,
+	.forks_child = 1,
+	.timeout = 30,
+	.needs_root = 1,
+	.needs_cgroup_ver = TST_CG_V2,
+	.needs_cgroup_ctrls = (const char *const []){ "cpu", NULL },
+	.needs_cgroup_nsdelegate = 0,
+};
diff --git a/testcases/kernel/controllers/cpu/cgroup_cpu_common.h b/testcases/kernel/controllers/cpu/cgroup_cpu_common.h
new file mode 100644
index 000000000..a957aa409
--- /dev/null
+++ b/testcases/kernel/controllers/cpu/cgroup_cpu_common.h
@@ -0,0 +1,130 @@
+// SPDX-License-Identifier: GPL-2.0-or-later
+/*
+ * Copyright (c) 2025 Richard Palethorpe <rpalethorpe@suse.com>
+ */
+/*\
+ * Common helpers for cgroup cpu controller tests.
+ *
+ * Converted from kselftest
+ * tools/testing/selftests/cgroup/test_cpu.c
+ */
+
+#ifndef CGROUP_CPU_COMMON_H__
+#define CGROUP_CPU_COMMON_H__
+
+#include <pthread.h>
+#include <time.h>
+#include <stdlib.h>
+
+#include "tst_test.h"
+
+#ifndef NSEC_PER_SEC
+#define NSEC_PER_SEC 1000000000L
+#endif
+
+enum hog_clock_type {
+	CPU_HOG_CLOCK_PROCESS,
+	CPU_HOG_CLOCK_WALL,
+};
+
+struct cpu_hog_func_param {
+	int nprocs;
+	struct timespec ts;
+	enum hog_clock_type clock_type;
+};
+
+static inline void *hog_cpu_thread_func(void *arg)
+{
+	(void)arg;
+
+	while (1)
+		;
+
+	return NULL;
+}
+
+static inline struct timespec
+timespec_sub(const struct timespec *lhs, const struct timespec *rhs)
+{
+	struct timespec zero = { .tv_sec = 0, .tv_nsec = 0 };
+	struct timespec ret;
+
+	if (lhs->tv_sec < rhs->tv_sec)
+		return zero;
+
+	ret.tv_sec = lhs->tv_sec - rhs->tv_sec;
+
+	if (lhs->tv_nsec < rhs->tv_nsec) {
+		if (ret.tv_sec == 0)
+			return zero;
+
+		ret.tv_sec--;
+		ret.tv_nsec = NSEC_PER_SEC - rhs->tv_nsec + lhs->tv_nsec;
+	} else {
+		ret.tv_nsec = lhs->tv_nsec - rhs->tv_nsec;
+	}
+
+	return ret;
+}
+
+/*
+ * CPU hog function that creates nprocs spinning threads.
+ * To be called in a forked child process already in the target cgroup.
+ * Returns 0 on success, -1 on error.
+ */
+static inline int hog_cpus_timed(void *arg)
+{
+	const struct cpu_hog_func_param *param =
+		(struct cpu_hog_func_param *)arg;
+	struct timespec ts_run = param->ts;
+	struct timespec ts_remaining = ts_run;
+	struct timespec ts_start;
+	struct timespec ts_total;
+	int ret, i;
+	pthread_t tid;
+
+	ret = clock_gettime(CLOCK_MONOTONIC, &ts_start);
+	if (ret != 0)
+		return -1;
+
+	for (i = 0; i < param->nprocs; i++) {
+		ret = pthread_create(&tid, NULL, &hog_cpu_thread_func, NULL);
+		if (ret != 0)
+			return -1;
+	}
+
+	while (ts_remaining.tv_sec > 0 || ts_remaining.tv_nsec > 0) {
+		ret = nanosleep(&ts_remaining, NULL);
+		if (ret && errno != EINTR)
+			return -1;
+
+		if (param->clock_type == CPU_HOG_CLOCK_PROCESS) {
+			ret = clock_gettime(CLOCK_PROCESS_CPUTIME_ID,
+					    &ts_total);
+			if (ret != 0)
+				return -1;
+		} else {
+			struct timespec ts_current;
+
+			ret = clock_gettime(CLOCK_MONOTONIC, &ts_current);
+			if (ret != 0)
+				return -1;
+
+			ts_total = timespec_sub(&ts_current, &ts_start);
+		}
+
+		ts_remaining = timespec_sub(&ts_run, &ts_total);
+	}
+
+	return 0;
+}
+
+/*
+ * Check if two values differ by less than err percent.
+ */
+static inline int values_close(long a, long b, int err)
+{
+	return labs(a - b) <= ((a + b) / 100) * err;
+}
+
+#endif /* CGROUP_CPU_COMMON_H__ */
-- 
2.25.1


-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
