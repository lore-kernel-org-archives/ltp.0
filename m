Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E7913C10F1A
	for <ltp@archiver.kernel.org>; Tue,  7 May 2024 04:33:20 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id AD6673CDBBA
	for <ltp@archiver.kernel.org>; Tue,  7 May 2024 06:33:18 +0200 (CEST)
Received: from in-7.smtp.seeweb.it (in-7.smtp.seeweb.it [217.194.8.7])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 025CF3C0562
 for <ltp@lists.linux.it>; Tue,  7 May 2024 06:33:02 +0200 (CEST)
Authentication-Results: in-7.smtp.seeweb.it; spf=pass (sender SPF authorized)
 smtp.mailfrom=uniontech.com (client-ip=54.204.34.130;
 helo=smtpbguseast2.qq.com; envelope-from=lufei@uniontech.com;
 receiver=lists.linux.it)
Received: from smtpbguseast2.qq.com (smtpbguseast2.qq.com [54.204.34.130])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by in-7.smtp.seeweb.it (Postfix) with ESMTPS id F2441208DF2
 for <ltp@lists.linux.it>; Tue,  7 May 2024 06:32:56 +0200 (CEST)
X-QQ-mid: bizesmtp85t1715056369ty89zu2k
X-QQ-Originating-IP: i2vvEm2roVVMWkXQ/MPTRB9yGLNSR++WYCgC200afn4=
Received: from localhost.localdomain ( [125.76.217.162])
 by bizesmtp.qq.com (ESMTP) with 
 id ; Tue, 07 May 2024 12:32:44 +0800 (CST)
X-QQ-SSF: 01400000000000C0B000000A0000000
X-QQ-FEAT: 7Lv6dviieSToyMp8DVYrre01UoEzotcLsAiGO8toH0sFl+PVFnsxrSVnZ89w9
 36dXNZVtWFk0bgi1omdzRh9M2HA8/XsIgrjI4riZKRnvn/d26OCLoPWAYhNKcAyV4uNu1dY
 y7sHYnFkEJ1kBvCYI3xBlJaaaFxjsJ4oF+VdQLmuQm4/lQuE2SBMfsmOJaSvGUK+J40jORQ
 go/KPy4Zo/legfiIU0KjL+f8hkdaqcvcEYkwSP2LWhvbvHP7Wi+6miBa4lqmHCwSZ9NGzEi
 aMH2n3/65H1hQLXkIDcuO6/VwNRCQYqZ7lJPM0u4cth3eHpfaNi8GDmHx9/EsUXPS3YPUkg
 9HqLdNB1zV8B0IOAWAcvbu13xett0mj/S3dyEOyGTNhJIIp6Y654up//bUZ/72oegxgifyI
 K+D3/mAPtbA=
X-QQ-GoodBg: 2
X-BIZMAIL-ID: 12567400672246159846
From: lufei <lufei@uniontech.com>
To: chrubis@suse.cz,
	ltp@lists.linux.it
Date: Tue,  7 May 2024 12:32:35 +0800
Message-Id: <20240507043235.1692-2-lufei@uniontech.com>
X-Mailer: git-send-email 2.39.3
In-Reply-To: <20240507043235.1692-1-lufei@uniontech.com>
References: <20240506070336.2711930-2-lufei@uniontech.com>
 <20240507043235.1692-1-lufei@uniontech.com>
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
 configure.ac                                  |   1 +
 runtest/syscalls                              |   2 +
 .../kernel/syscalls/arch_prctl/.gitignore     |   1 +
 testcases/kernel/syscalls/arch_prctl/Makefile |   8 ++
 .../kernel/syscalls/arch_prctl/arch_prctl01.c | 103 ++++++++++++++++++
 5 files changed, 115 insertions(+)
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
index 000000000..cce204f2d
--- /dev/null
+++ b/testcases/kernel/syscalls/arch_prctl/arch_prctl01.c
@@ -0,0 +1,103 @@
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
+#include "tst_safe_stdio.h"
+#include "lapi/syscalls.h"
+#include <stdlib.h>
+#include <string.h>
+#include <errno.h>
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
+static struct tcase {
+	const int input;
+	int set_exp;
+	int get_exp;
+	const int tst_errno;
+} tcases[] = {
+	{0, 0, 0, ENODEV},
+	{1, 0, 1, ENODEV},
+};
+
+static void setup(void)
+{
+	FILE *f;
+	char flag_mid[] = " cpuid_fault ";
+	char flag_end[] = " cpuid_fault\n";
+	char *line = NULL;
+	size_t len = 0;
+	bool tag = 0;
+
+	f = SAFE_FOPEN("/proc/cpuinfo", "r");
+
+	while (getline(&line, &len, f) != -1)
+		if (strncmp(line, "flags", strlen("flags")) == 0 &&
+				(strstr(line, flag_mid) != NULL ||
+				 strstr(line, flag_end) != NULL)) {
+			tag = 1;
+			break;
+		}
+	if (!tag)
+		for (unsigned long i = 0; i < ARRAY_SIZE(tcases); i++) {
+			tcases[i].set_exp = -1;
+			// get default value
+			tcases[i].get_exp = 1;
+		}
+}
+
+static void run(unsigned int index)
+{
+	struct tcase tc = tcases[index];
+
+	TEST(arch_prctl_set(ARCH_SET_CPUID, tc.input));
+
+	if (TST_RET == tc.set_exp)
+		if (tc.set_exp == -1)
+			tst_res((TST_ERR == tc.tst_errno ? TPASS : TFAIL),
+				"set cpuid, expect: %s, get: %s",
+				tst_strerrno(tc.tst_errno),
+				tst_strerrno(TST_ERR));
+		else
+			tst_res(TPASS, "set cpuid succeed.");
+	else
+		tst_res(TFAIL, "set cpuid failed.");
+
+	TEST(arch_prctl_get(ARCH_GET_CPUID));
+
+	if (TST_RET == tc.get_exp)
+		tst_res(TPASS, "get cpuid succeed.");
+	else
+		tst_res(TFAIL, "get cpuid failed.");
+}
+
+static struct tst_test test = {
+	.test = run,
+	.setup = setup,
+	.tcnt = ARRAY_SIZE(tcases),
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
