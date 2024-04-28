Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 464C9C19F53
	for <ltp@archiver.kernel.org>; Sun, 28 Apr 2024 07:46:16 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id B71243D0381
	for <ltp@archiver.kernel.org>; Sun, 28 Apr 2024 09:46:14 +0200 (CEST)
Received: from in-7.smtp.seeweb.it (in-7.smtp.seeweb.it [217.194.8.7])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id B49D53C20CA
 for <ltp@lists.linux.it>; Sun, 28 Apr 2024 09:45:58 +0200 (CEST)
Authentication-Results: in-7.smtp.seeweb.it; spf=pass (sender SPF authorized)
 smtp.mailfrom=uniontech.com (client-ip=54.92.39.34; helo=smtpbgjp3.qq.com;
 envelope-from=lufei@uniontech.com; receiver=lists.linux.it)
Received: from smtpbgjp3.qq.com (smtpbgjp3.qq.com [54.92.39.34])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by in-7.smtp.seeweb.it (Postfix) with ESMTPS id 2449C2001CF
 for <ltp@lists.linux.it>; Sun, 28 Apr 2024 09:45:54 +0200 (CEST)
X-QQ-mid: bizesmtp83t1714290345t4okzsoq
X-QQ-Originating-IP: +xRPUFK79W0Ohcht/UoQIZdsvVDHVomCdsj3CR5ix70=
Received: from localhost.localdomain ( [125.76.217.162])
 by bizesmtp.qq.com (ESMTP) with 
 id ; Sun, 28 Apr 2024 15:45:11 +0800 (CST)
X-QQ-SSF: 01400000000000C0B000000A0000000
X-QQ-FEAT: qYgaZJPlkQ7pHKUDXYAGxechjWF+7san/DKWYSPYsWRNmpUqzuMDShPoHRU1N
 J0sK/PXrAzOGli9C/+oOXGyi7d2MkGfSKIifO8jywslh2Zvuh/Y68PJX/yJ3ykqBBYTWZY8
 wH3hIcqBA+MaWVdJhnBC5p+B+9NYkvyqDlpo43q96QwCMW8i7K0r+lbPhznwfwZWePS9f6m
 pTeZh2+DLedaCzgC0/TNt3m2+FVQPqUU0Lf0MIFF3Hy1Q1nyQz2hu9G7ac/kemVbotV4Hex
 WcwVDYR4xyFssjXB5VdC/RtlM4cU4/subX3xDurDNiIdBDfW53AEP55HEc3kdIBVrFW06W9
 G3wMMM+ShwOIiBYd6b3yI8xpeqIJv+WHqUeL5tG34ocqlJbRBETM1P/uy+AlKsceUsykM8V
X-QQ-GoodBg: 2
X-BIZMAIL-ID: 9796043827662619907
From: lufei <lufei@uniontech.com>
To: jstancek@redhat.com,
	ltp@lists.linux.it
Date: Sun, 28 Apr 2024 15:44:57 +0800
Message-Id: <20240428074457.2629906-2-lufei@uniontech.com>
X-Mailer: git-send-email 2.39.3
In-Reply-To: <20240428074457.2629906-1-lufei@uniontech.com>
References: <20240419070717.2506101-1-lufei@uniontech.com>
 <20240428074457.2629906-1-lufei@uniontech.com>
MIME-Version: 1.0
X-QQ-SENDSIZE: 520
Feedback-ID: bizesmtp:uniontech.com:qybglogicsvrgz:qybglogicsvrgz6a-0
X-Virus-Scanned: clamav-milter 1.0.3 at in-7.smtp.seeweb.it
X-Virus-Status: Clean
Subject: [LTP] [PATCH] Add case about arch_prctl syscall.
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

Add testcase about arch_prctl syscall.

Signed-off-by: Lu Fei <lufei@uniontech.com>
---
 configure.ac                                  |  1 +
 runtest/syscalls                              |  2 +
 .../kernel/syscalls/arch_prctl/.gitignore     |  1 +
 testcases/kernel/syscalls/arch_prctl/Makefile |  8 +++
 .../kernel/syscalls/arch_prctl/arch_prctl01.c | 51 +++++++++++++++++++
 5 files changed, 63 insertions(+)
 create mode 100644 testcases/kernel/syscalls/arch_prctl/.gitignore
 create mode 100644 testcases/kernel/syscalls/arch_prctl/Makefile
 create mode 100644 testcases/kernel/syscalls/arch_prctl/arch_prctl01.c

diff --git a/configure.ac b/configure.ac
index 1d7e862d8..0dcaddc0f 100644
--- a/configure.ac
+++ b/configure.ac
@@ -41,6 +41,7 @@ AC_CHECK_DECLS([SEM_STAT_ANY],,,[#include <sys/sem.h>])
 
 AC_CHECK_HEADERS_ONCE([ \
     asm/ldt.h \
+    asm/prctl.h \
     cpuid.h \
     emmintrin.h \
     ifaddrs.h \
diff --git a/runtest/syscalls b/runtest/syscalls
index 7794f1465..505b4243d 100644
--- a/runtest/syscalls
+++ b/runtest/syscalls
@@ -31,6 +31,8 @@ alarm05 alarm05
 alarm06 alarm06
 alarm07 alarm07
 
+arch_prctl01 arch_prctl01
+
 bind01 bind01
 bind02 bind02
 bind03 bind03
diff --git a/testcases/kernel/syscalls/arch_prctl/.gitignore b/testcases/kernel/syscalls/arch_prctl/.gitignore
new file mode 100644
index 000000000..24871e249
--- /dev/null
+++ b/testcases/kernel/syscalls/arch_prctl/.gitignore
@@ -0,0 +1 @@
+/arch_prctl01
diff --git a/testcases/kernel/syscalls/arch_prctl/Makefile b/testcases/kernel/syscalls/arch_prctl/Makefile
new file mode 100644
index 000000000..272949d57
--- /dev/null
+++ b/testcases/kernel/syscalls/arch_prctl/Makefile
@@ -0,0 +1,8 @@
+# SPDX-License-Identifier: GPL-2.0-or-later
+# Copyright (c) UnionTech Software Technology Co.,Ltd. 2024
+
+top_srcdir		?= ../../../..
+
+include $(top_srcdir)/include/mk/testcases.mk
+
+include $(top_srcdir)/include/mk/generic_leaf_target.mk
diff --git a/testcases/kernel/syscalls/arch_prctl/arch_prctl01.c b/testcases/kernel/syscalls/arch_prctl/arch_prctl01.c
new file mode 100644
index 000000000..5fe7ea131
--- /dev/null
+++ b/testcases/kernel/syscalls/arch_prctl/arch_prctl01.c
@@ -0,0 +1,51 @@
+// SPDX-License-Identifier: GPL-2.0-or-later
+/*
+ * Copyright (c) UnionTech Software Technology Co.,Ltd., 2024
+ * Author: Lu Fei <lufei@uniontech.com>
+ */
+
+/*\
+ * [Description]
+ *
+ * Simple test on arch_prctl to set and get cpuid instruction of test thread.
+ */
+
+#include "tst_test.h"
+#include "lapi/syscalls.h"
+#include <stdlib.h>
+#ifdef HAVE_ASM_PRCTL_H
+#include <asm/prctl.h>
+
+static int arch_prctl_get(int code)
+{
+	return tst_syscall(__NR_arch_prctl, code, NULL);
+}
+
+static int arch_prctl_set(int code, unsigned long addr)
+{
+	return tst_syscall(__NR_arch_prctl, code, addr);
+}
+
+static void run(unsigned int index)
+{
+	// index == 0 for disable cpuid, 1 for enable cpuid.
+	TST_EXP_PASS(arch_prctl_set(ARCH_SET_CPUID, index));
+
+	TEST(arch_prctl_get(ARCH_GET_CPUID));
+
+	if (TST_RET == index)
+		tst_res(TPASS, "get cpuid succeed.");
+	else
+		tst_res(TFAIL, "get cpuid failed.");
+}
+
+static struct tst_test test = {
+	.test = run,
+	.tcnt = 2,
+	.min_kver = "4.12",
+	.supported_archs = (const char *const []){"x86_64", "x86", NULL}
+};
+
+#else /* HAVE_ASM_PRCTL_H */
+TST_TEST_TCONF("missing <asm/prctl.h>");
+#endif
-- 
2.39.3


-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
