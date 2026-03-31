Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id EB3ACFF60FF
	for <ltp@archiver.kernel.org>; Tue, 31 Mar 2026 10:02:19 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 89FD13E2A40
	for <ltp@archiver.kernel.org>; Tue, 31 Mar 2026 12:02:18 +0200 (CEST)
Received: from in-7.smtp.seeweb.it (in-7.smtp.seeweb.it
 [IPv6:2001:4b78:1:20::7])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id CA47B3CAE45
 for <ltp@lists.linux.it>; Tue, 31 Mar 2026 12:01:59 +0200 (CEST)
Received: from smtpbgbr1.qq.com (smtpbgbr1.qq.com [54.207.19.206])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by in-7.smtp.seeweb.it (Postfix) with ESMTPS id 29BB720116C
 for <ltp@lists.linux.it>; Tue, 31 Mar 2026 12:01:56 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=uniontech.com;
 s=onoh2408; t=1774951311;
 bh=8MX4lqbgVZK5tmosGbcC/P11GneNnqNxzOlAebP9Nvg=;
 h=From:To:Subject:Date:Message-Id:MIME-Version;
 b=OLaleyDBMffS0tItToU3SybNbGjOiPEJS2CvkqjGBFlSvI2RUaiTGX7u40aX/mn77
 fvlyqjhCqMjCqOsY4Y+SfPOBo2ll8Lzj+AmLFxIiB6W/n/ACQTmPgaj+bKgFoijXkg
 YO9hfnjFm3mj2yHdpXabaieG3YtTeUlpea247H5g=
X-QQ-mid: zesmtpsz7t1774951305tfc298e9e
X-QQ-Originating-IP: MKdFGiYr46yqxjefu65jRXbCw/VsvlmUCCuDyqxu9tM=
Received: from localhost.localdomain ( [1.85.7.34])
 by bizesmtp.qq.com (ESMTP) with 
 id ; Tue, 31 Mar 2026 18:01:43 +0800 (CST)
X-QQ-SSF: 0000000000000000000000000000000
X-QQ-GoodBg: 0
X-BIZMAIL-ID: 13304817964270224312
EX-QQ-RecipientCnt: 4
From: lufei <lufei@uniontech.com>
To: ltp@lists.linux.it
Date: Tue, 31 Mar 2026 18:01:38 +0800
Message-Id: <20260331100138.58202-1-lufei@uniontech.com>
X-Mailer: git-send-email 2.39.3
In-Reply-To: <20260331015538.53326-1-lufei@uniontech.com>
References: <20260331015538.53326-1-lufei@uniontech.com>
MIME-Version: 1.0
X-QQ-SENDSIZE: 520
Feedback-ID: zesmtpsz:uniontech.com:qybglogicsvrgz:qybglogicsvrgz3a-1
X-QQ-XMAILINFO: NWLpwLZrMWrI3jeNjqtsyDDP69veXFHyKgaJoW9wSRNMgHc2SwBbmaTU
 aLvXzciHaLniJ/9w+br22SzEeER8YR6PZHnqHdPRbGrXPfFaHJdOAj7WnlsSPRyds8OH7O0
 r7qg+D47OrvUiFjm3CVf4fI+i5uAaC7qgPQdhuO2fEZPw+YH35ksw+wcNV2R/4FONOYFUqu
 zxhH7qOGiC3ofjzvMqeZEpAE7phwjiSq9K+tQm8pA5QWbhqdAyXS65d8TctyjLOlYsyBovj
 +YxOWaMKJR9VOY2K69nrAYvkD0AGW2nlyW9nmLp2fW5x+UCDiaMFJ2VCt8x8jaipwWQVY1s
 SBt0AgVF4r6ZA8qy2sONxQW66Vk89kGLrwPZd0vyvHsaaSHzNXIEnYNM5pHKZOQPJQPcmEU
 v2VJ0Yf9chZgSIMTkcsd0Ra0fhDHCmg9/GE6t2V3KroYVM4L9Ja5XzaqV+abFf7cILdtXwO
 UfWPKI4CJM3ZEHf+W9/P6vP482HyH/j3Jyf5INDD4sUkQJomc6PtwwzKcA4HLNt3FBMZI1u
 iZojqepylcVaJC+sG4tRhbMDpk9eQ+mfzrDeGEEr3Ledh0VkSFOdGCE1CV/uRv+LtvFHvyz
 Rsm32G4WyFgeTxHpW1Ui3HYca/WbkpqBOvg5jNJruSc4UhLGYa3eJKyzy1/8fI6zRiX1lhV
 vEEQ19H/CPgbSAGxekqrbmyKxnKkpFDnU3mqJMxgkouFV9sXkvSRdXvapsDycGov1+evWmo
 QjB3JB02xWPBiv+xEhC0cV8RZ5ykXt23hCsZSGB4pg3+dVnpJJtiuYa2TetI1gxJV8X+CKY
 Wh22g6HVIVuk8okL7+3XtyXsPFxjCTEAFTcaZDptVn0lxN3oi8dADar1p11sZGwg9Ddh+/I
 14tcKzD5SJGet781wUNNfCCJ/YK8kgHP6ZKje9Hkp2T8vrGVLlDHj4KR0h3ApsatIDD/PLY
 Bfa9JNL8pdj32H6DGWcEH6/5/9MxeLU1nNs609RXEDA7jVpIPQcQI3PVGIkC2UUBwrR33HT
 JJgUWj6xHPy7ILuxvA2DrPrgOI/ruW0xK1pQ8wVQOKWYEtx8R/
X-QQ-XMRINFO: MPJ6Tf5t3I/ylTmHUqvI8+Wpn+Gzalws3A==
X-QQ-RECHKSPAM: 0
X-Virus-Scanned: clamav-milter 1.0.9 at in-7.smtp.seeweb.it
X-Virus-Status: Clean
Subject: [LTP] [PATCH v4] Rewrite ftrace_regression tests with new C API
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
Cc: lufei <lufei@uniontech.com>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: ltp-bounces+ltp=archiver.kernel.org@lists.linux.it
Sender: "ltp" <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>

Rewritten from old shell scripts.

ftrace_regression01: regression test for panic bug while using
userstacktrace, set userstacktrace in loop and check if success.

ftrace_regression02: for checking signal:signal_generate gives
2 more fields: grp res.

Signed-off-by: lufei <lufei@uniontech.com>
---
 runtest/tracing                               |  4 +-
 .../kernel/tracing/ftrace_test/.gitignore     |  2 +
 .../tracing/ftrace_test/ftrace_regression.h   | 61 ++++++++++++++
 .../tracing/ftrace_test/ftrace_regression01.c | 82 ++++++++++++++++++
 .../ftrace_test/ftrace_regression01.sh        | 83 -------------------
 .../tracing/ftrace_test/ftrace_regression02.c | 56 +++++++++++++
 .../ftrace_test/ftrace_regression02.sh        | 63 --------------
 7 files changed, 203 insertions(+), 148 deletions(-)
 create mode 100644 testcases/kernel/tracing/ftrace_test/.gitignore
 create mode 100644 testcases/kernel/tracing/ftrace_test/ftrace_regression.h
 create mode 100644 testcases/kernel/tracing/ftrace_test/ftrace_regression01.c
 delete mode 100755 testcases/kernel/tracing/ftrace_test/ftrace_regression01.sh
 create mode 100644 testcases/kernel/tracing/ftrace_test/ftrace_regression02.c
 delete mode 100755 testcases/kernel/tracing/ftrace_test/ftrace_regression02.sh

diff --git a/runtest/tracing b/runtest/tracing
index 674e2ad97..2a4a92c5f 100644
--- a/runtest/tracing
+++ b/runtest/tracing
@@ -1,6 +1,6 @@
 #DESCRIPTION:Tracing testing
-ftrace_regression01	ftrace_regression01.sh
-ftrace_regression02	ftrace_regression02.sh
+ftrace_regression01	ftrace_regression01
+ftrace_regression02	ftrace_regression02
 ftrace-stress-test	ftrace_stress_test.sh 90
 dynamic_debug01		dynamic_debug01.sh
 fanotify25 fanotify25
diff --git a/testcases/kernel/tracing/ftrace_test/.gitignore b/testcases/kernel/tracing/ftrace_test/.gitignore
new file mode 100644
index 000000000..b0153e9fa
--- /dev/null
+++ b/testcases/kernel/tracing/ftrace_test/.gitignore
@@ -0,0 +1,2 @@
+ftrace_regression01
+ftrace_regression02
diff --git a/testcases/kernel/tracing/ftrace_test/ftrace_regression.h b/testcases/kernel/tracing/ftrace_test/ftrace_regression.h
new file mode 100644
index 000000000..0efae7268
--- /dev/null
+++ b/testcases/kernel/tracing/ftrace_test/ftrace_regression.h
@@ -0,0 +1,61 @@
+/* SPDX-License-Identifier: GPL-2.0-or-later
+ *
+ * Copyright (c) 2026 lufei <lufei@uniontech.com>
+ *
+ * Shared header for ftrace regression tests.
+ */
+
+#ifndef FTRACE_REGRESSION_H
+#define FTRACE_REGRESSION_H
+
+#include "tst_test.h"
+#include "tst_safe_file_ops.h"
+#include "tst_safe_stdio.h"
+
+#include <regex.h>
+#include <stdio.h>
+
+#define FTRACE_LINE_BUF_SIZE 1024
+#define DEBUGFS_DIR "debugfs"
+
+/**
+ * file_contains - Check if a file contains specific regex pattern.
+ */
+static inline int file_contains(const char *path, const char *pattern)
+{
+	FILE *fp = SAFE_FOPEN(path, "r");
+	char *buf = SAFE_MALLOC(FTRACE_LINE_BUF_SIZE);
+	bool found = false;
+
+	regex_t re;
+
+	if (regcomp(&re, pattern, REG_EXTENDED | REG_NOSUB) != 0) {
+		SAFE_FCLOSE(fp);
+		return found;
+	}
+
+	while (fgets(buf, FTRACE_LINE_BUF_SIZE, fp)) {
+		if (regexec(&re, buf, 0, NULL, 0) == 0) {
+			found = true;
+			break;
+		}
+	}
+
+	regfree(&re);
+	SAFE_FCLOSE(fp);
+	free(buf);
+	return found;
+}
+
+static inline void mount_debugfs(void)
+{
+	SAFE_MKDIR(DEBUGFS_DIR, 0755);
+	SAFE_MOUNT(NULL, DEBUGFS_DIR, "debugfs", 0, NULL);
+}
+
+static inline void umount_debugfs(void)
+{
+	SAFE_UMOUNT(DEBUGFS_DIR);
+}
+
+#endif /* FTRACE_REGRESSION_H */
diff --git a/testcases/kernel/tracing/ftrace_test/ftrace_regression01.c b/testcases/kernel/tracing/ftrace_test/ftrace_regression01.c
new file mode 100644
index 000000000..be2327582
--- /dev/null
+++ b/testcases/kernel/tracing/ftrace_test/ftrace_regression01.c
@@ -0,0 +1,82 @@
+// SPDX-License-Identifier: GPL-2.0-or-later
+/*
+ * Copyright (c) 2015 Red Hat Inc.
+ * Copyright (c) 2026 lufei <lufei@uniontech.com>
+ */
+
+/*\
+ * Regression test for panic while using userstacktrace.
+ *
+ * BUG: unable to handle kernel paging request at 00000000417683c0
+ *      IP: [<ffffffff8105c834>] update_curr+0x124/0x1e0
+ *      Thread overran stack, or stack corrupted
+ *      Oops: 0000 [#1] SMP
+ *      last sysfs file: ../system/cpu/cpu15/cache/index2/shared_cpu_map
+ *
+ * The bug was fixed by:
+ *      1dbd195 (tracing: Fix preempt count leak)
+ */
+
+#include <unistd.h>
+#include "ftrace_regression.h"
+
+#define STACK_TRACER_PATH "/proc/sys/kernel/stack_tracer_enabled"
+#define TRACE_OPTIONS DEBUGFS_DIR "/tracing/trace_options"
+#define EXC_PAGE_FAULT DEBUGFS_DIR "/tracing/events/exceptions/page_fault_kernel/enable"
+#define MM_PAGE_FAULT DEBUGFS_DIR "/tracing/events/kmem/mm_kernel_pagefault/enable"
+
+#define LOOP 10
+
+static const char *page_fault_path;
+static int page_fault_origin;
+
+static void setup(void)
+{
+	mount_debugfs();
+
+	if (access(EXC_PAGE_FAULT, F_OK) == 0)
+		page_fault_path = EXC_PAGE_FAULT;
+	else if (access(MM_PAGE_FAULT, F_OK) == 0)
+		page_fault_path = MM_PAGE_FAULT;
+	else
+		tst_brk(TCONF, "Page fault event not available");
+
+	SAFE_FILE_SCANF(page_fault_path, "%d", &page_fault_origin);
+}
+
+static void run(void)
+{
+	int i;
+
+	for (i = 0; i < LOOP; i++) {
+		SAFE_FILE_PRINTF(STACK_TRACER_PATH, "1");
+		SAFE_FILE_PRINTF(TRACE_OPTIONS, "userstacktrace");
+
+		if (!file_contains(TRACE_OPTIONS, "^userstacktrace"))
+			tst_brk(TBROK, "Failed to set userstacktrace");
+
+		SAFE_FILE_PRINTF(page_fault_path, "1");
+	}
+
+	SAFE_FILE_PRINTF(page_fault_path, "%d", page_fault_origin);
+
+	tst_res(TPASS, "Test passed for setting userstacktrace "
+			"bug(preempt count leak) not reproduced"
+			);
+}
+
+static struct tst_test test = {
+	.needs_root = 1,
+	.needs_tmpdir = 1,
+	.setup = setup,
+	.test_all = run,
+	.cleanup = umount_debugfs,
+	.save_restore = (const struct tst_path_val[]) {
+		{STACK_TRACER_PATH, NULL, TST_SR_TCONF},
+		{}
+	},
+	.tags = (const struct tst_tag[]) {
+		{"linux-git", "1dbd1951f39e"},
+		{}
+	},
+};
diff --git a/testcases/kernel/tracing/ftrace_test/ftrace_regression01.sh b/testcases/kernel/tracing/ftrace_test/ftrace_regression01.sh
deleted file mode 100755
index d6969cfc6..000000000
--- a/testcases/kernel/tracing/ftrace_test/ftrace_regression01.sh
+++ /dev/null
@@ -1,83 +0,0 @@
-#! /bin/sh
-
-###########################################################################
-##                                                                       ##
-## Copyright (c) 2015, Red Hat Inc.                                      ##
-##                                                                       ##
-## This program is free software: you can redistribute it and/or modify  ##
-## it under the terms of the GNU General Public License as published by  ##
-## the Free Software Foundation, either version 3 of the License, or     ##
-## (at your option) any later version.                                   ##
-##                                                                       ##
-## This program is distributed in the hope that it will be useful,       ##
-## but WITHOUT ANY WARRANTY; without even the implied warranty of        ##
-## MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE. See the          ##
-## GNU General Public License for more details.                          ##
-##                                                                       ##
-## You should have received a copy of the GNU General Public License     ##
-## along with this program. If not, see <http://www.gnu.org/licenses/>.  ##
-##                                                                       ##
-## Author: Li Wang <liwang@redhat.com>                                   ##
-##                                                                       ##
-###########################################################################
-##                                                                       ##
-## Summary:  panic while using userstacktrace                            ##
-##                                                                       ##
-## BUG: unable to handle kernel paging request at 00000000417683c0       ##
-##      IP: [<ffffffff8105c834>] update_curr+0x124/0x1e0                 ##
-##      PGD 41a796067 PUD 0                                              ##
-##      Thread overran stack, or stack corrupted                         ##
-##      Oops: 0000 [#1] SMP                                              ##
-##      last sysfs file: ../system/cpu/cpu15/cache/index2/shared_cpu_map ##
-##                                                                       ##
-## The bug was fixed by:                                                 ##
-##      1dbd195 (tracing: Fix preempt count leak)                        ##
-##                                                                       ##
-###########################################################################
-
-export TCID="ftrace_regression01"
-export TST_TOTAL=1
-
-. ftrace_lib.sh
-
-LOOP=10
-
-TSTACK_TRACE_PATH="/proc/sys/kernel/stack_tracer_enabled"
-EXC_PAGE_FAULT_ENABLE="$TRACING_PATH/events/exceptions/page_fault_kernel/enable"
-MM_PAGE_FAULT_ENABLE="$TRACING_PATH/events/kmem/mm_kernel_pagefault/enable"
-
-ftrace_userstacktrace_test()
-{
-	if [ ! -e "$TSTACK_TRACE_PATH" ]; then
-		tst_brkm TCONF "Stack Tracer is not cofigured in This kernel"
-	fi
-
-	for i in $(seq $LOOP); do
-		echo 1 >  $TSTACK_TRACE_PATH
-		echo userstacktrace > $TRACING_PATH/trace_options
-		grep -q "^userstacktrace"  $TRACING_PATH/trace_options
-		if [ $? -ne 0 ]; then
-			tst_brkm TBROK "Failed to set userstacktrace"
-		fi
-
-		if [ -f "$EXC_PAGE_FAULT_ENABLE" ]; then
-			exc_page_fault_enable=`cat $EXC_PAGE_FAULT_ENABLE`
-			echo 1 > $EXC_PAGE_FAULT_ENABLE
-		else
-			mm_page_fault_enable=`cat $MM_PAGE_FAULT_ENABLE`
-			echo 1 > $MM_PAGE_FAULT_ENABLE
-		fi
-	done
-
-	if [ -f "$EXC_PAGE_FAULT_ENABLE" ]; then
-		echo "$exc_page_fault_enable" > $EXC_PAGE_FAULT_ENABLE
-	else
-		echo "$mm_page_fault_enable" > $MM_PAGE_FAULT_ENABLE
-	fi
-
-	tst_resm TPASS "Finished running the test"
-}
-
-ftrace_userstacktrace_test
-
-tst_exit
diff --git a/testcases/kernel/tracing/ftrace_test/ftrace_regression02.c b/testcases/kernel/tracing/ftrace_test/ftrace_regression02.c
new file mode 100644
index 000000000..b4aac7ad0
--- /dev/null
+++ b/testcases/kernel/tracing/ftrace_test/ftrace_regression02.c
@@ -0,0 +1,56 @@
+// SPDX-License-Identifier: GPL-2.0-or-later
+/*
+ * Copyright (c) 2015 Red Hat Inc.
+ * Copyright (c) 2026 lufei <lufei@uniontech.com>
+ */
+
+/*\
+ * Check signal:signal_generate gives 2 more fields: grp=[0-9] res=[0-9]
+ */
+
+#include "ftrace_regression.h"
+
+#define SET_EVENT DEBUGFS_DIR "/tracing/set_event"
+#define TRACING_ON DEBUGFS_DIR "/tracing/tracing_on"
+#define TRACE_FILE DEBUGFS_DIR "/tracing/trace"
+
+#define LOOP 100
+
+static void run(void)
+{
+	int i;
+	const char *const cmd_ls[] = {"ls", "-l", "/proc", NULL};
+
+	SAFE_FILE_PRINTF(SET_EVENT, "signal:signal_generate");
+	SAFE_FILE_PRINTF(TRACING_ON, "1");
+	SAFE_FILE_PRINTF(TRACE_FILE, "\n");
+
+	// to generate trace
+	for (i = 0; i < LOOP; i++)
+		SAFE_CMD(cmd_ls, "/dev/null", "/dev/null");
+
+	if (file_contains(TRACE_FILE, "grp=[0-9]") &&
+			file_contains(TRACE_FILE, "res=[0-9]"))
+		tst_res(TPASS, "Pattern grp=[0-9] res=[0-9] reported after "
+			       "setting signal:signal_generate");
+	else
+		tst_res(TFAIL, "Pattern grp=[0-9] res=[0-9] not found in trace");
+}
+
+static struct tst_test test = {
+	.needs_root = 1,
+	.needs_tmpdir = 1,
+	.setup = mount_debugfs,
+	.test_all = run,
+	.cleanup = umount_debugfs,
+	.needs_cmds = (struct tst_cmd[]) {
+		{.cmd = "ls"},
+		{}
+	},
+	.tags = (const struct tst_tag[]) {
+		{"linux-git", "6c303d3ab39f"},
+		{"linux-git", "163566f60bfe"},
+		{}
+	},
+};
+
diff --git a/testcases/kernel/tracing/ftrace_test/ftrace_regression02.sh b/testcases/kernel/tracing/ftrace_test/ftrace_regression02.sh
deleted file mode 100755
index 3c32f219e..000000000
--- a/testcases/kernel/tracing/ftrace_test/ftrace_regression02.sh
+++ /dev/null
@@ -1,63 +0,0 @@
-#! /bin/sh
-
-###########################################################################
-##                                                                       ##
-## Copyright (c) 2015, Red Hat Inc.                                      ##
-##                                                                       ##
-## This program is free software: you can redistribute it and/or modify  ##
-## it under the terms of the GNU General Public License as published by  ##
-## the Free Software Foundation, either version 3 of the License, or     ##
-## (at your option) any later version.                                   ##
-##                                                                       ##
-## This program is distributed in the hope that it will be useful,       ##
-## but WITHOUT ANY WARRANTY; without even the implied warranty of        ##
-## MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE. See the          ##
-## GNU General Public License for more details.                          ##
-##                                                                       ##
-## You should have received a copy of the GNU General Public License     ##
-## along with this program. If not, see <http://www.gnu.org/licenses/>.  ##
-##                                                                       ##
-## Author: Li Wang <liwang@redhat.com>                                   ##
-##                                                                       ##
-###########################################################################
-##                                                                       ##
-## Summary: check signal:signal_generate gives 2 more fields: grp res    ##
-##                                                                       ##
-## This testcase is writing for signal events change:                    ##
-##       6c303d3 tracing: let trace_signal_generate() report more info...##
-##       163566f tracing: send_sigqueue() needs trace_signal_generate()  ##
-##                                                                       ##
-###########################################################################
-
-export TCID="ftrace_regression02"
-export TST_TOTAL=1
-
-. ftrace_lib.sh
-
-ftrace_signal_test()
-{
-	# Set envent
-	echo 'signal:signal_generate' > $TRACING_PATH/set_event
-	echo 1 > $TRACING_PATH/tracing_on
-	echo > $TRACING_PATH/trace
-
-	# just to generate trace
-	for i in $(seq 100); do
-		ls -l /proc > /dev/null 2>&1
-	done
-
-	grep -q 'grp=[0-9] res=[0-9]' $TRACING_PATH/trace
-	if [ $? -eq 0 ]; then
-		tst_resm TPASS "finished running the test."
-	else
-		tst_resm TFAIL "running the test failed, please check log message."
-	fi
-}
-
-if tst_kvcmp -lt "3.2"; then
-	tst_brkm TCONF "The test should be run in kernels >= 3.2.0 Skip the test..."
-fi
-
-ftrace_signal_test
-
-tst_exit
-- 
2.39.3


-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
