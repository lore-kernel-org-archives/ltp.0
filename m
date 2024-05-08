Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 647DFC10F1A
	for <ltp@archiver.kernel.org>; Wed,  8 May 2024 01:59:47 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id A3DB33CDE05
	for <ltp@archiver.kernel.org>; Wed,  8 May 2024 03:59:45 +0200 (CEST)
Received: from in-2.smtp.seeweb.it (in-2.smtp.seeweb.it [217.194.8.2])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id DC0F13CBEF0
 for <ltp@lists.linux.it>; Wed,  8 May 2024 03:59:28 +0200 (CEST)
Authentication-Results: in-2.smtp.seeweb.it; spf=pass (sender SPF authorized)
 smtp.mailfrom=uniontech.com (client-ip=18.132.163.193; helo=smtpbg150.qq.com;
 envelope-from=lufei@uniontech.com; receiver=lists.linux.it)
Received: from smtpbg150.qq.com (smtpbg150.qq.com [18.132.163.193])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by in-2.smtp.seeweb.it (Postfix) with ESMTPS id BDE73634A38
 for <ltp@lists.linux.it>; Wed,  8 May 2024 03:59:25 +0200 (CEST)
X-QQ-mid: bizesmtpsz8t1715133558t6q27id
X-QQ-Originating-IP: sT9Qad+zcJXGnL8OP7XtDartcxTVn0+ZBONLdrT3m5M=
Received: from localhost.localdomain ( [125.76.217.162])
 by bizesmtp.qq.com (ESMTP) with 
 id ; Wed, 08 May 2024 09:59:03 +0800 (CST)
X-QQ-SSF: 01400000000000C0B000000A0000000
X-QQ-FEAT: MqaDhgBJ9QpuLAYjyl2aGOCQcM9w3HNXjP5PPC6sGuJQg2uc7UzKSMvr1Xygh
 gD1+GVIO56O+VDomVHmWtDm0mH9kJxL9hPRYwT0jGjnm/RcN07zQDJjG6XMtvkUBnDe0xGd
 TlcXdQ8DFXJ9vK2KOwkC1dQlpaRZJINsKSrqhByq5rr+BWyAYdyCMZiaHvK7oXxWQ8RbOD5
 CIKCaZ6dNWFGMTCIdFv6yt/Rst6JhG1pp4pbVnLl8B87/kqBQvNwvfxNIx9q1sfsqnAz9RY
 xpLKbHTneA3sU1rLoWYsTe/eAGse/Oc7ekflj95rrtpDfSx0JBBljLfAdefIG7ymAQa2eJU
 8I/+amMBOzx87UtUGUUg89JhcnbSrSd2zSK6aRG7E/CicMvTb+C2h8nCoCiPuzt78Wv39Y+
 q9Dn+paXos8=
X-QQ-GoodBg: 2
X-BIZMAIL-ID: 9208710240694505904
From: lufei <lufei@uniontech.com>
To: ltp@lists.linux.it
Date: Wed,  8 May 2024 09:58:52 +0800
Message-Id: <20240508015852.3362-2-lufei@uniontech.com>
X-Mailer: git-send-email 2.39.3
In-Reply-To: <20240508015852.3362-1-lufei@uniontech.com>
References: <20240507043235.1692-2-lufei@uniontech.com>
 <20240508015852.3362-1-lufei@uniontech.com>
MIME-Version: 1.0
X-QQ-SENDSIZE: 520
Feedback-ID: bizesmtpsz:uniontech.com:qybglogicsvrgz:qybglogicsvrgz6a-0
X-Virus-Scanned: clamav-milter 1.0.3 at in-2.smtp.seeweb.it
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
 testcases/kernel/syscalls/arch_prctl/Makefile |  8 ++
 .../kernel/syscalls/arch_prctl/arch_prctl01.c | 82 +++++++++++++++++++
 5 files changed, 94 insertions(+)
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
index 000000000..e30b5667a
--- /dev/null
+++ b/testcases/kernel/syscalls/arch_prctl/arch_prctl01.c
@@ -0,0 +1,82 @@
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
+static bool tag;
+
+static void setup(void)
+{
+	FILE *f;
+	char flag_mid[] = " cpuid_fault ";
+	char flag_end[] = " cpuid_fault\n";
+	char *line = NULL;
+	size_t len = 0;
+
+	tag = false;
+
+	f = SAFE_FOPEN("/proc/cpuinfo", "r");
+
+	while (getline(&line, &len, f) != -1)
+		if (strncmp(line, "flags", strlen("flags")) == 0 &&
+				(strstr(line, flag_mid) != NULL ||
+				 strstr(line, flag_end) != NULL)) {
+			tag = true;
+			break;
+		}
+}
+
+static void run(unsigned int index)
+{
+	if (tag)
+		TST_EXP_PASS(arch_prctl_set(ARCH_SET_CPUID, index));
+	else
+		TST_EXP_FAIL(arch_prctl_set(ARCH_SET_CPUID, index), ENODEV);
+
+	// if cpu has cpuid_fault flag, ARCH_GET_CPUID returns what has been
+	// set: index, otherwise, returns default status: 1
+	int exp = tag ? index : 1;
+
+	TEST(arch_prctl_get(ARCH_GET_CPUID));
+	if (TST_RET == exp)
+		tst_res(TPASS, "get cpuid succeed.");
+	else
+		tst_res(TFAIL, "get wrong cpuid status");
+}
+
+static struct tst_test test = {
+	.test = run,
+	.setup = setup,
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
