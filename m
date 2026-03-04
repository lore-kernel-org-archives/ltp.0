Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E855FEB7EA2
	for <ltp@archiver.kernel.org>; Wed,  4 Mar 2026 08:10:48 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 6C1C03DAC03
	for <ltp@archiver.kernel.org>; Wed,  4 Mar 2026 09:10:47 +0100 (CET)
Received: from in-6.smtp.seeweb.it (in-6.smtp.seeweb.it [217.194.8.6])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 24A333CB04A
 for <ltp@lists.linux.it>; Wed,  4 Mar 2026 09:10:27 +0100 (CET)
Received: from smtpbgau1.qq.com (smtpbgau1.qq.com [54.206.16.166])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by in-6.smtp.seeweb.it (Postfix) with ESMTPS id 8C10F1400C60
 for <ltp@lists.linux.it>; Wed,  4 Mar 2026 09:10:25 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=uniontech.com;
 s=onoh2408; t=1772611821;
 bh=buvOpGcdaNzZfJxND8Ns3GIWEgZd3TOxzXw2scQv7hI=;
 h=From:To:Subject:Date:Message-Id:MIME-Version;
 b=bTcxMTf7qeMrMaFy4zZPDQjrQRlsSuYeAmt4afcFzzGusfUxMzmLW2sB6bpgCmRTJ
 l+nNpf2643PD34uvgzQjvNE7Z9h4IW+iyi45h9Nps96iWtIfVtyD+gJjHoCojqaa+d
 0Cnj0F9FQhiX28Yq6mE4gAnPCN2/CUU+W/8thSiE=
X-QQ-mid: esmtpgz14t1772611817t2e41f96b
X-QQ-Originating-IP: BkKPulIFZnVtFRhYtwtqpVCfdNv01aYbLkCPAR2yg2s=
Received: from localhost.localdomain ( [1.85.7.34])
 by bizesmtp.qq.com (ESMTP) with 
 id ; Wed, 04 Mar 2026 16:10:15 +0800 (CST)
X-QQ-SSF: 0000000000000000000000000000000
X-QQ-GoodBg: 0
X-BIZMAIL-ID: 4670611906790112208
EX-QQ-RecipientCnt: 2
From: lufei <lufei@uniontech.com>
To: ltp@lists.linux.it
Date: Wed,  4 Mar 2026 16:05:38 +0800
Message-Id: <20260304080538.1793-1-lufei@uniontech.com>
X-Mailer: git-send-email 2.39.3
MIME-Version: 1.0
X-QQ-SENDSIZE: 520
Feedback-ID: esmtpgz:uniontech.com:qybglogicsvrgz:qybglogicsvrgz3a-1
X-QQ-XMAILINFO: M+Fb8ImTgT7r7ZDCuqQi9wGTjLvGOvhyW8a4dykUk7JJGgFzsDPvLebx
 wc+oVIGmj/fu/Fc1ZcyjQPF1I+tSnEFRLub4gUl07sd/NGV0MhcvDhVT+BHp9yyagt+Ma2r
 Pp5tYVUnjlZvdbsH8zhGPrRl2LhIFwGx04EvAPGqa0i2LCzkIj/5vhu8UYEoy3lZcJ9NjCP
 VF9UyEX0EPfY9QpWvAL190SzpIvhdvgPOTfO0Bg7zIyhteCZ1e0EjXCJkIKKSLpb6RVxDNz
 DoLJ8k7736ippg4eP4jEHE+V7/CSAaopCZTmIYoeKjHggm6Bg9vt5rJOEHS/cPOHcA5IEKj
 Qhu1pufE9k2vi38A/nukUuJ3Il/rGC2RXNfNgnfM/yQ0vqPneCvQrt9M7SWhsLJYpIPSjqG
 tdFjmXYHo+FFIDwkFEw501FZkn7SvuRCWiUVpZJ2lTHxHaabFyEUzP4ru4v8XdfhB+Xgx38
 mOKpFW+eUMRTrU5CcLIlR1VuPqDm0Sj0tg9yQ8t6mY+ymeFeloGaGNa1PnJDIcjlH9zfINA
 8p5Vruq0JMbVl1fkHTWLRDxQYiW4K3FB0M2FNCYExqou2i/fKb5YOhacOrwetDRvbeyRoK7
 usPt1ZO2dwo/VEF4aZSE0gmQNphUF4g/e5MzAfBqs7iViTtwB/KAsx920ml3QFqFQ/e3vMe
 tv1hQo2HQZgIRgtHg7ul6VYVrIuf8XoDUzOfTgKXu3b8tGFqiMt03Au4e+QogP1WRyzcGPT
 LU50a9HY0a4xw4/qkT7CJKEnF4VMSy9pAzn8cTVH+COjaANqM1FNzHs5soGVKT+XGbstiPL
 INEa1qe5+0JlGSBdgR7VbmVgo2JXKFk+2AfBpmG6doM2MyCrOq9+dPvpxYqVW2NvsZLhFey
 NW1m/t0YP/WqjLTKx5QF38AO6mrVmM+ltmKLRGizV0lBigI1nQsp3sJRXuyMu+P5si6iVRg
 r1vpIu3hZ+x4eseZNvfVl2JP6fTqPS/cBWaTTxuMyt4Mc6bY41MM9PmU0v+qutIuASHY9Fm
 BqBN9FFdC6semvpcctmAjW/f3GJYLj45kvQWgjYA==
X-QQ-XMRINFO: NyFYKkN4Ny6FuXrnB5Ye7Aabb3ujjtK+gg==
X-QQ-RECHKSPAM: 0
X-Virus-Scanned: clamav-milter 1.0.9 at in-6.smtp.seeweb.it
X-Virus-Status: Clean
Subject: [LTP] [PATCH 1/2] Rewrite ftrace_regression01.sh with new C API
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

This is regression test for panic bug while using userstacktrace,
set userstacktrace in loop and check if success.

Signed-off-by: lufei <lufei@uniontech.com>
---
 .../kernel/tracing/ftrace_test/.gitignore     |  2 +
 .../tracing/ftrace_test/ftrace_regression.h   | 34 ++++++++
 .../tracing/ftrace_test/ftrace_regression01.c | 85 +++++++++++++++++++
 .../ftrace_test/ftrace_regression01.sh        | 83 ------------------
 4 files changed, 121 insertions(+), 83 deletions(-)
 create mode 100644 testcases/kernel/tracing/ftrace_test/.gitignore
 create mode 100644 testcases/kernel/tracing/ftrace_test/ftrace_regression.h
 create mode 100644 testcases/kernel/tracing/ftrace_test/ftrace_regression01.c
 delete mode 100755 testcases/kernel/tracing/ftrace_test/ftrace_regression01.sh

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
index 000000000..c19d3d8fd
--- /dev/null
+++ b/testcases/kernel/tracing/ftrace_test/ftrace_regression.h
@@ -0,0 +1,34 @@
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
+#include <string.h>
+
+#define FTRACE_FILE_CONTAINS_BUF_SIZE (1024 * 1024)
+
+/**
+ * file_contains - Check if a file contains the given string
+ * path: Path to the file
+ * str: String to search for
+ *
+ * Returns: 1 if file contains str, 0 otherwise
+ */
+static inline int file_contains(const char *path, const char *str)
+{
+	char buf[FTRACE_FILE_CONTAINS_BUF_SIZE];
+
+	buf[0] = '\0';
+	SAFE_FILE_SCANF(path, "%1048575[^\x01]", buf);
+	return strstr(buf, str) != NULL;
+}
+
+#endif /* FTRACE_REGRESSION_H */
+
diff --git a/testcases/kernel/tracing/ftrace_test/ftrace_regression01.c b/testcases/kernel/tracing/ftrace_test/ftrace_regression01.c
new file mode 100644
index 000000000..1aafb9122
--- /dev/null
+++ b/testcases/kernel/tracing/ftrace_test/ftrace_regression01.c
@@ -0,0 +1,85 @@
+// SPDX-License-Identifier: GPL-2.0-or-later
+/*
+ * Copyright (c) 2015 Red Hat Inc.
+ * Copyright (c) 2026 lufei <lufei@uniontech.com>
+ */
+
+/*\
+ * [Description]
+ *
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
+#include <stdio.h>
+#include "ftrace_regression.h"
+
+#define DEBUGFS_DIR "debugfs"
+#define STACK_TRACER_PATH "/proc/sys/kernel/stack_tracer_enabled"
+#define TRACE_OPTIONS DEBUGFS_DIR "/tracing/trace_options"
+#define EXC_PAGE_FAULT DEBUGFS_DIR "/tracing/events/exceptions/page_fault_kernel/enable"
+#define MM_PAGE_FAULT DEBUGFS_DIR "/tracing/events/kmem/mm_kernel_pagefault/enable"
+
+#define LOOP 10
+
+static const char *page_fault_path;
+
+static void setup(void)
+{
+	SAFE_MKDIR(DEBUGFS_DIR, 0755);
+	SAFE_MOUNT(NULL, DEBUGFS_DIR, "debugfs", 0, NULL);
+
+	if (access(EXC_PAGE_FAULT, F_OK) == 0)
+		page_fault_path = EXC_PAGE_FAULT;
+	else if (access(MM_PAGE_FAULT, F_OK) == 0)
+		page_fault_path = MM_PAGE_FAULT;
+	else
+		tst_brk(TCONF, "Page fault event not available");
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
+		if (!file_contains(TRACE_OPTIONS, "userstacktrace"))
+			tst_brk(TBROK, "Failed to set userstacktrace");
+
+		SAFE_FILE_PRINTF(page_fault_path, "1");
+	}
+
+	tst_res(TPASS, "Finished running the test");
+}
+
+static void cleanup(void)
+{
+	SAFE_UMOUNT(DEBUGFS_DIR);
+}
+
+static struct tst_test test = {
+	.needs_root = 1,
+	.needs_tmpdir = 1,
+	.setup = setup,
+	.test_all = run,
+	.cleanup = cleanup,
+	.save_restore = (const struct tst_path_val[]) {
+		{STACK_TRACER_PATH, NULL, TST_SR_TCONF},
+		{}
+	},
+	.tags = (const struct tst_tag[]) {
+		{"linux-git", "1dbd195"},
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
-- 
2.39.3


-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
