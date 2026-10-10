Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4B26CCA6017
	for <ltp@archiver.kernel.org>; Sat, 10 Oct 2026 09:42:36 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 79A713E537A
	for <ltp@archiver.kernel.org>; Sat, 10 Oct 2026 11:42:34 +0200 (CEST)
Received: from in-2.smtp.seeweb.it (in-2.smtp.seeweb.it
 [IPv6:2001:4b78:1:20::2])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 94E073E27F1
 for <ltp@lists.linux.it>; Sat, 10 Oct 2026 11:42:18 +0200 (CEST)
Received: from mail-lj1-x236.google.com (mail-lj1-x236.google.com
 [IPv6:2a00:1450:4864:20::236])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-2.smtp.seeweb.it (Postfix) with ESMTPS id D5C34600212
 for <ltp@lists.linux.it>; Sat, 10 Oct 2026 11:42:17 +0200 (CEST)
Received: by mail-lj1-x236.google.com with SMTP id
 38308e7fff4ca-3a771ad2a9aso20213221fa.0
 for <ltp@lists.linux.it>; Sat, 10 Oct 2026 02:42:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1791625337; x=1792230137; darn=lists.linux.it;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=Y3ee3UhOAwwAOdv8iDuS06UjgnAFWalebbi3lja/fPc=;
 b=SsjVxeEw4DcAJiT0HfJAw3k+7IRomtIOPHDVPipYVFN2JZ7XrwSYzNPmky27xnV9AG
 GvOMX9CZiqmmx88m18+XXPFBKbF1J+Rfg4BSZdxz3Si8gOIcheX36SdHLyU3B8/suA53
 TNu+yKmdO1MgRrdYDZPCxMuUuzrtnXK+kIZEx/hYo9BHkxDNgnQtmx2JDjoIOQcvGCeq
 rnt/vQDqxt1d4Gy7OIyKwOrqSDwBqJfa0yYYusEYen9PGdmQQ8g6bo0NeMLmnh/INYZz
 QYKq1OOx5J4tWQh4udqYdDrXr3loQydksAI1LgkmCARpERQK1O3ssFn759OZT/o9wm2q
 dIBQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1791625337; x=1792230137;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to:content-type;
 bh=Y3ee3UhOAwwAOdv8iDuS06UjgnAFWalebbi3lja/fPc=;
 b=ugjGSiPux7+MsM7PvjQaiQvQoGoAGe1CdwH4GRWZa5k4z2BVNYXs6XpsH1rX8oYV7e
 w3N9k4+yLfOSKkzKTXyG3rSKCn1dikdgIG+6PpFK0qltG3PO9HiGG7XUOLgo2Hbpe3m3
 sqlYFAeWZCoOJ9hEY6c0MPSrA2D355Q3R7yp5Jo4KDrRi+Ln6GvjPAQDeDQm/MdLBAqh
 GzUO1SN/LsjBDUu19zHql1tQF/lBgRxOYklO49gMSO3//ZXZC/2VTWEBvicqcU+71omy
 G1Bzh1of7o/6FQoyDAaQxtocda6wa4tc8eHFg9ySyzOpExt6nvBp5TXdGszj7OOwP9eF
 QZzw==
X-Gm-Message-State: AFq9FYIRSU28EWd0dXQRG5rJvaveyZOuAZ8kgwvJ51grWqWwEYDeQ+Uj
 rEQ/uDgPl39Due30RQkOIqFeEfKR2lftMSd0oiww5VvOR2+wDBL2ENtM/WxxTt5uPvOHqQ==
X-Gm-Gg: AYBFou2Xv5+jbQ4bWYKvbgqyiZVONvg757VqthFPhNq9axHhFw1G7oThm47hIu9lQ+V
 /DDz5Kp6oo8lzMffs6W9bgjrb75nPEJTYmDvriMTfW7+KCJKPJ0+Ca8bXtNervj60PL/GUYOJdg
 QNMyqvmFQvmtta7tDMUTMRr42s5CbMpV1Cika3m0dt/S6ZN0yTVsJCLDXCphepICKNi1It0B//x
 HJCE6TG+dLNmCSIWkuyRseQ7SwvUZCa0fQKApbC4MTI6K52jq3z54j9UnIel5qV1OdN6xCc84Zh
 0xBRJinsamDjwUZzyspXEXPSGYJ7WnRGGwbKTre4ocjmaVTKWtnUhJmpy3ct1ajFLO4d2a6ZBea
 MoT0P53PbB9po4d/pP5w6Gw2nVZjS30ql2xkd198GCqh4s48wPLt7hoLWU/g08OucCjgBhQrea9
 +BNcyhrS/OntkTmgOjUk/VNYPTYnTXGP3fojt9zU4zJSfTjlFAF2icDcQb9pBf0vV8OQBmUK8FE
 8+hBdnLeljStxSJtJaVwfX0DW+Nl9xzRtuglGKD
X-Received: by 2002:a05:651c:43c2:20b0:3a9:7605:6c4b with SMTP id
 38308e7fff4ca-3a9c55ac7e5mr6194441fa.9.1791625336698; 
 Sat, 10 Oct 2026 02:42:16 -0700 (PDT)
Received: from chestnykh (broadband-46-242-13-70.ip.moscow.rt.ru.
 [46.242.13.70]) by smtp.gmail.com with ESMTPSA id
 38308e7fff4ca-3a9c3cebd07sm13820541fa.38.2026.10.10.02.42.13
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sat, 10 Oct 2026 02:42:14 -0700 (PDT)
From: dm.chestnykh@gmail.com
To: ltp@lists.linux.it
Date: Sat, 10 Oct 2026 12:44:39 +0300
Message-ID: <20261010094439.26053-1-dm.chestnykh@gmail.com>
X-Mailer: git-send-email 2.56.0
In-Reply-To: <20261010064240.2467-1-dm.chestnykh@gmail.com>
References: <20261010064240.2467-1-dm.chestnykh@gmail.com>
MIME-Version: 1.0
X-Virus-Scanned: clamav-milter 1.0.9 at in-2.smtp.seeweb.it
X-Virus-Status: Clean
Subject: [LTP] [PATCH v7] arch_prctl: add ARCH_GET_FS, ARCH_GET_GS tests
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
Cc: Dmitry Chestnykh <dm.chestnykh@gmail.com>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: ltp-bounces+ltp=archiver.kernel.org@lists.linux.it
Sender: "ltp" <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>

From: Dmitry Chestnykh <dm.chestnykh@gmail.com>

Signed-off-by: Dmitry Chestnykh <dm.chestnykh@gmail.com>
---
 configure.ac                                  |   1 +
 include/lapi/arch_prctl.h                     |   9 ++
 runtest/syscalls                              |   1 +
 .../kernel/syscalls/arch_prctl/.gitignore     |   1 +
 .../kernel/syscalls/arch_prctl/arch_prctl02.c | 124 ++++++++++++++++++
 5 files changed, 136 insertions(+)
 create mode 100644 testcases/kernel/syscalls/arch_prctl/arch_prctl02.c

diff --git a/configure.ac b/configure.ac
index e979de0e7..9db3e06ad 100644
--- a/configure.ac
+++ b/configure.ac
@@ -53,6 +53,7 @@ AC_CHECK_HEADERS_ONCE([ \
     aio.h \
     asm/ldt.h \
     asm/prctl.h \
+    asm/hwcap2.h \
     cpuid.h \
     emmintrin.h \
     ifaddrs.h \
diff --git a/include/lapi/arch_prctl.h b/include/lapi/arch_prctl.h
index a4e7f8458..6d8376e58 100644
--- a/include/lapi/arch_prctl.h
+++ b/include/lapi/arch_prctl.h
@@ -19,4 +19,13 @@
 # define ARCH_SET_CPUID 0x1012
 #endif

+#ifdef __x86_64__
+# ifdef HAVE_ASM_HWCAP2_H
+#  include <asm/hwcap2.h>
+# endif /* HAVE_ASM_HWCAP2_H */
+# ifndef HWCAP2_FSGSBASE
+#  define HWCAP2_FSGSBASE (1UL << 1)
+# endif /* HWCAP2_FSGSBASE */
+#endif /* __x86_64__ */
+
 #endif /* LAPI_ARCH_PRCTL_H__ */
diff --git a/runtest/syscalls b/runtest/syscalls
index accdf2df9..f2f2a0602 100644
--- a/runtest/syscalls
+++ b/runtest/syscalls
@@ -32,6 +32,7 @@ alarm06 alarm06
 alarm07 alarm07

 arch_prctl01 arch_prctl01
+arch_prctl02 arch_prctl02

 bind01 bind01
 bind02 bind02
diff --git a/testcases/kernel/syscalls/arch_prctl/.gitignore b/testcases/kernel/syscalls/arch_prctl/.gitignore
index 24871e249..72187b8b4 100644
--- a/testcases/kernel/syscalls/arch_prctl/.gitignore
+++ b/testcases/kernel/syscalls/arch_prctl/.gitignore
@@ -1 +1,2 @@
 /arch_prctl01
+/arch_prctl02
diff --git a/testcases/kernel/syscalls/arch_prctl/arch_prctl02.c b/testcases/kernel/syscalls/arch_prctl/arch_prctl02.c
new file mode 100644
index 000000000..67bd27639
--- /dev/null
+++ b/testcases/kernel/syscalls/arch_prctl/arch_prctl02.c
@@ -0,0 +1,124 @@
+// SPDX-License-Identifier: GPL-2.0-or-later
+/*
+ * Copyright (c) 2026 Dmitry Chestnykh <dm.chestnykh@gmail.com>
+ * Author: Dmitry Chestnykh <dm.chestnykh@gmail.com>
+ */
+
+/*\
+ * Test that ``ARCH_GET_FS`` and ``ARCH_GET_GS`` return the same bases read independently
+ * by RDFSBASE and RDGSBASE.
+ */
+
+#include "tst_test.h"
+#include "lapi/syscalls.h"
+#include "lapi/arch_prctl.h"
+#include <stdlib.h>
+#include <string.h>
+
+#ifdef __x86_64__
+
+#ifdef HAVE_GETAUXVAL
+# include <sys/auxv.h>
+#endif
+
+static int arch_prctl_get(int code, unsigned long long *out)
+{
+	return tst_syscall(__NR_arch_prctl, code, out);
+}
+
+static int set_gs(unsigned long long val)
+{
+	return tst_syscall(__NR_arch_prctl, ARCH_SET_GS, val);
+}
+
+static bool tag;
+
+static void setup(void)
+{
+	unsigned long long v = 0;
+
+#ifdef AT_HWCAP2
+	v = getauxval(AT_HWCAP2);
+#endif
+	tag = v & HWCAP2_FSGSBASE ? true : false;
+}
+
+#define READ_FS_BASE() ({                              \
+	unsigned long long __res_fs;                       \
+	asm volatile("rdfsbase %0" : "=r"(__res_fs));      \
+	__res_fs;                                          \
+})
+
+#define READ_GS_BASE() ({                              \
+	unsigned long long __res_gs;                       \
+	asm volatile("rdgsbase %0" : "=r"(__res_gs));      \
+	__res_gs;                                          \
+})
+
+static void test_fs(void)
+{
+	unsigned long long fs = READ_FS_BASE();
+	unsigned long long fs_prctl;
+
+	TST_EXP_PASS_SILENT(arch_prctl_get(ARCH_GET_FS, &fs_prctl));
+	if (TST_PASS)
+		TST_EXP_EQ_LU(fs_prctl, fs);
+}
+
+static void test_gs(void)
+{
+	unsigned long long gs, gs_prctl, orig_gs;
+#define TEST_GS_BASE() do { \
+	gs = READ_GS_BASE(); \
+	TST_EXP_PASS_SILENT(arch_prctl_get(ARCH_GET_GS, &gs_prctl)); \
+	if (TST_PASS) { \
+		TST_EXP_EQ_LU(gs_prctl, gs); \
+	} \
+} while (0)
+
+	TEST_GS_BASE();
+	orig_gs = gs;
+
+	if (gs == 0) {
+		unsigned long long test_gs = 0x1ababababULL;
+
+		TST_EXP_PASS_SILENT(set_gs(test_gs));
+		if (TST_PASS)
+			TEST_GS_BASE();
+
+		TST_EXP_PASS_SILENT(set_gs(orig_gs));
+		if (!TST_PASS)
+			tst_brk(TBROK | TTERRNO, "Failed to restore GS base");
+	}
+}
+
+static struct tcase {
+	unsigned int idx;
+	void (*test_fn)(void);
+} tcases[] = {
+	{0, test_fs},
+	{1, test_gs}
+};
+
+static void run(unsigned int index)
+{
+	if (!tag)
+		tst_brk(TCONF, "rdfsbase/rdgsbase are not supported/enabled");
+
+	struct tcase *tc = &tcases[index];
+	(*tc->test_fn)();
+}
+
+static struct tst_test test = {
+	.test = run,
+	.setup = setup,
+	.tcnt = ARRAY_SIZE(tcases),
+	.min_kver = "5.9",
+	.supported_archs = (const char *const []){"x86_64", NULL}
+};
+
+#else
+
+TST_TEST_TCONF("Tests needs x86_64 CPU");
+
+#endif /* __x86_64__ */
--
2.56.0


-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
