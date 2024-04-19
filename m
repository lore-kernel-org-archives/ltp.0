Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8AD4AC4345F
	for <ltp@archiver.kernel.org>; Fri, 19 Apr 2024 07:07:49 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id E3CDA3CFD80
	for <ltp@archiver.kernel.org>; Fri, 19 Apr 2024 09:07:47 +0200 (CEST)
Received: from in-2.smtp.seeweb.it (in-2.smtp.seeweb.it
 [IPv6:2001:4b78:1:20::2])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 7C9BC3CFC8C
 for <ltp@lists.linux.it>; Fri, 19 Apr 2024 09:07:31 +0200 (CEST)
Authentication-Results: in-2.smtp.seeweb.it; spf=pass (sender SPF authorized)
 smtp.mailfrom=uniontech.com (client-ip=15.184.224.54; helo=smtpbg154.qq.com;
 envelope-from=lufei@uniontech.com; receiver=lists.linux.it)
Received: from smtpbg154.qq.com (smtpbg154.qq.com [15.184.224.54])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by in-2.smtp.seeweb.it (Postfix) with ESMTPS id 58D9560322F
 for <ltp@lists.linux.it>; Fri, 19 Apr 2024 09:07:28 +0200 (CEST)
X-QQ-mid: bizesmtpsz4t1713510439txwlea7
X-QQ-Originating-IP: slAgHV/9QL6Kvf7Ob6m8F9E2sNxqkbUeu69GgtFsiAk=
Received: from localhost.localdomain ( [125.76.217.162])
 by bizesmtp.qq.com (ESMTP) with 
 id ; Fri, 19 Apr 2024 15:07:18 +0800 (CST)
X-QQ-SSF: 01400000000000C0B000000A0000000
X-QQ-FEAT: zT6n3Y95oi0PIei9JsOhYZNmtPXnxcCLlXRMZz//0I7xX3uYGZp4i4WEZIS2n
 EKvQvUGiUFpYkR1qMYN4fGmtwReMhfYN1HUbDiwaVjMvEr1Rha3F036smkMqsJgMnDeyaXL
 bwrjQafwFA+mZqbNTOwZX9C++NIuC4KqEvqXTUOHkD4izM2CiZqf7xgjm7Psm321C1qcP5/
 vtolL7r7g4BQ/VVZ4ZYOq656W2MhO0TJhRdAcOcB01GWxSlcPhmDxwBFjsI+UGxqZe92y2o
 p+AX8EQ8ezjUXqJySCJMjIfIcTOHFtveQWI9dn49gQEfi9i1u8Cnc5QBrPQoTdKWuovxpfm
 4KLPhb1tZmEsQMo9XKkskkSW4K3KLwpqi5H1pnZ7AS/ENtnM7CFDLs9xNxJR3sSQNe0WZTY
X-QQ-GoodBg: 2
X-BIZMAIL-ID: 7472301369956579254
From: lufei <lufei@uniontech.com>
To: ltp@lists.linux.it
Date: Fri, 19 Apr 2024 15:07:17 +0800
Message-Id: <20240419070717.2506101-1-lufei@uniontech.com>
X-Mailer: git-send-email 2.39.3
MIME-Version: 1.0
X-QQ-SENDSIZE: 520
Feedback-ID: bizesmtpsz:uniontech.com:qybglogicsvrgz:qybglogicsvrgz6a-0
X-Virus-Scanned: clamav-milter 1.0.3 at in-2.smtp.seeweb.it
X-Virus-Status: Clean
Subject: [LTP] [PATCH v2] Add case about arch_prctl syscall.
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
 .../kernel/syscalls/arch_prctl/.gitignore     |  1 +
 testcases/kernel/syscalls/arch_prctl/Makefile |  8 +++
 .../kernel/syscalls/arch_prctl/arch_prctl01.c | 56 +++++++++++++++++++
 4 files changed, 66 insertions(+)
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
index 000000000..06b3d99b8
--- /dev/null
+++ b/testcases/kernel/syscalls/arch_prctl/arch_prctl01.c
@@ -0,0 +1,56 @@
+// SPDX-License-Identifier: GPL-2.0-or-later
+/* 
+ * Copyright (c) UnionTech Software Technology Co.,Ltd., 2024
+ * Author: Lu Fei <lufei@uniontech.com>
+ */
+
+/* 
+ * [Description]
+ *
+ * Simple test on arch_prctl to set and get cpuid instruction of test thread.
+ */
+
+# include "tst_test.h"
+# include "lapi/syscalls.h"
+# include <stdlib.h>
+# ifdef HAVE_ASM_PRCTL_H
+# include <asm/prctl.h>
+
+static int arch_prctl_get(int code, unsigned long *addr) {
+	return tst_syscall(__NR_arch_prctl, code, *addr);
+}
+
+static int arch_prctl_set(int code, unsigned long addr) {
+	return tst_syscall(__NR_arch_prctl, code, addr);
+}
+
+static int tc[] = {0,1};
+
+static void run(unsigned int index){
+
+	unsigned long *addr = malloc(sizeof(long));
+
+	TEST(arch_prctl_set(ARCH_SET_CPUID, tc[index]));
+
+	if (TST_RET == 0)
+		tst_res(TPASS, "set %s cpuid",tc[index] ? "enable" : "disable");
+	else
+		tst_res(TFAIL, "failed to set cpuid");
+
+	TEST(arch_prctl_get(ARCH_GET_CPUID, addr));
+
+	if (TST_RET == tc[index])
+		tst_res(TPASS, "get cpuid succeed.");
+	else
+		tst_res(TFAIL, "get cpuid failed.");
+}
+
+static struct tst_test test = {
+    .test = run,
+    .tcnt = 2,
+    .min_kver = "4.11",
+};
+
+#else /* HAVE_ASM_PRCTL_H */
+TST_TEST_TCONF("missing <asm/prctl.h>");
+#endif
-- 
2.39.3


-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
