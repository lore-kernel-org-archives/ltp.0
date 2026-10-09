Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 71989CA601E
	for <ltp@archiver.kernel.org>; Fri,  9 Oct 2026 18:37:15 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 568C93E9EFC
	for <ltp@archiver.kernel.org>; Fri,  9 Oct 2026 20:37:13 +0200 (CEST)
Received: from in-2.smtp.seeweb.it (in-2.smtp.seeweb.it [217.194.8.2])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1) server-digest SHA384)
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 67AB83E9C90
 for <ltp@lists.linux.it>; Fri,  9 Oct 2026 20:36:57 +0200 (CEST)
Received: from mail-lf1-x12c.google.com (mail-lf1-x12c.google.com
 [IPv6:2a00:1450:4864:20::12c])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-2.smtp.seeweb.it (Postfix) with ESMTPS id D3C82601937
 for <ltp@lists.linux.it>; Fri,  9 Oct 2026 20:36:56 +0200 (CEST)
Received: by mail-lf1-x12c.google.com with SMTP id
 2adb3069b0e04-5ba41ea31ccso4417244e87.0
 for <ltp@lists.linux.it>; Fri, 09 Oct 2026 11:36:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1791571016; x=1792175816; darn=lists.linux.it;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=buNd5l+Ln/e+Cm1Ucju9sdmizZO6PGc44r55wOseRuY=;
 b=KDTdC/SuNjWKmWk+jXPBbDx8/R6ZqD+U77uzu/PgMCUqRyOqr9XlxDQnmDAOmc6VTx
 BwcikpVBPMPl8ARY1LHkm9JsTpu4aaHJVJo6PnZMuzqhWJnLWNNaYmUnfSkwINb9SJXn
 Qn04jo9Iw+5++z8DHg7u6vtFilmE9VJ8NRpeICktGNpZ/RfCEYP+pfSQM0e9sOXrq5/c
 C1h6ChvLI8XMOmUrz9K8LfSoaLc1N/xSBtrwcLyobGACJKyPpJO0kbknLWp6UWKR1IEd
 g8Mo28ZyGq8NiIuqOgCy0kcAC7Enh59HtDbBr5CxNm+Hj8zTsoh0q8zPby4SRL1Ye3EN
 p9eg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1791571016; x=1792175816;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to:content-type;
 bh=buNd5l+Ln/e+Cm1Ucju9sdmizZO6PGc44r55wOseRuY=;
 b=DDV7I1CmPwXZzgZbgBeohgXSVs9aVIUdL+lzz/IR0gGdSP/MSQsPhUWItc/jyTm0eE
 U3yHQgkr3KrHr1Nz81czILzcWFgJtTdkHKeBc5lS90N+0m4UweYt+OTf0ycinOYvdpm/
 wMlqda/MpWqZ9u703TG0QWECmDiBraR9XBYuUdOl38+Pr8jOTa4OGooo3rq4Hri4x5HU
 epKMxbuN4zmPjITAhmRgA3AxzCVKjzfA0PEupa6OPrEXC6cpMGnXKiFNTqCRlL4t+4Rt
 11Rw58FDf5QpRkJTH9JeZx0EMxVs/w6gotn7S5UTXm7kDVQSH58VjryEQjqYA2L+2st2
 cYWw==
X-Gm-Message-State: AFq9FYK3ITmtw1uUaG8SHMx15YV564aRmhj8tqwzyP9AoZQb1+t6IEfV
 tLp2LOIddvCqwSnZfFv0TE7XqpRSy7UstylSY365vW5F5Yh+Og8TNL0ybfpq+5SbQ+cGZg==
X-Gm-Gg: AYBFou0dzIGs/oC02yML+RriyjkfkIPDhr7eRI/PNqm2r5rz27fuqAexqBLNlx0HV5S
 7StpoRd8wmXbJ/atTPa33TQIjXFCKM+frwGSZDLBy6xzZS6MSpPHwRIoeVZOn0RawviBwgCDGa4
 RfEnM9PSi4MWpTGqB3YNlGoXyq5RWsPe8w0zp07D56Ts6NR/JZ9U4YPOQM6fAMXr41E4PyjM+Cs
 Jwp6LWYzN5ug9Wf/C8APY4fAWsXmekCFnSuKTTPl8LkSxkt4KED/eIxK1ljywtIBIwj79n/0zgJ
 sNNgsy4GfqAfTJn7xfKw15CCUITjX7P3j4ciD9wthLA7oksnYHcib7viwo5V6AKntHAYPpui64s
 GFAA1XLNhxTcP0wHs9lm7edQUmCpRTHiLOfxVOtmq38RTaHE1arPZjHA66xX9tlYhCaOPuVQlL9
 G5jgTNa3vgcTYiAeri3C1lfGX4zdjvErg/fRGdUZfPX2TfdYu/grf2geGDIYW9laj+un1oTBj1A
 DpS3a+P3GLqzC9ZCOZ5tMekiJ2t4zG+LkRJ648P
X-Received: by 2002:a05:6512:438d:b0:5bc:e906:ad3 with SMTP id
 2adb3069b0e04-5bce9060f28mr11808e87.14.1791571015881; 
 Fri, 09 Oct 2026 11:36:55 -0700 (PDT)
Received: from chestnykh (broadband-46-242-13-70.ip.moscow.rt.ru.
 [46.242.13.70]) by smtp.gmail.com with ESMTPSA id
 38308e7fff4ca-3a9c3cd5a35sm8783761fa.31.2026.10.09.11.36.53
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 09 Oct 2026 11:36:53 -0700 (PDT)
From: dm.chestnykh@gmail.com
To: ltp@lists.linux.it
Date: Fri,  9 Oct 2026 21:39:21 +0300
Message-ID: <20261009183921.3408-1-dm.chestnykh@gmail.com>
X-Mailer: git-send-email 2.56.0
In-Reply-To: <20261009183530.3114-1-dm.chestnykh@gmail.com>
References: <20261009183530.3114-1-dm.chestnykh@gmail.com>
MIME-Version: 1.0
X-Virus-Scanned: clamav-milter 1.0.9 at in-2.smtp.seeweb.it
X-Virus-Status: Clean
Subject: [LTP] [PATCH v4] arch_prctl: add ARCH_GET_FS, ARCH_GET_GS tests
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
 .../kernel/syscalls/arch_prctl/arch_prctl02.c | 119 ++++++++++++++++++
 5 files changed, 131 insertions(+)
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
index 000000000..a69ee00ad
--- /dev/null
+++ b/testcases/kernel/syscalls/arch_prctl/arch_prctl02.c
@@ -0,0 +1,119 @@
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
+static int arch_prctl_get(int code, unsigned long *out)
+{
+	return tst_syscall(__NR_arch_prctl, code, out);
+}
+
+static int set_gs(unsigned long val)
+{
+	return tst_syscall(__NR_arch_prctl, ARCH_SET_GS, val);
+}
+
+static bool tag;
+
+static void setup(void)
+{
+	unsigned long v = 0;
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
+	unsigned long fs = READ_FS_BASE();
+	unsigned long fs_prctl;
+	TST_EXP_PASS_SILENT(arch_prctl_get(ARCH_GET_FS, &fs_prctl));
+	if (TST_PASS)
+		TST_EXP_EQ_LU(fs_prctl, fs);
+}
+
+static void test_gs(void)
+{
+	unsigned long gs, gs_prctl;
+#define TEST_GS_BASE() do { \
+	gs = READ_GS_BASE(); \
+	TST_EXP_PASS_SILENT(arch_prctl_get(ARCH_GET_GS, &gs_prctl)); \
+	if (TST_PASS) { \
+		TST_EXP_EQ_LU(gs_prctl, gs); \
+	} \
+} while (0)
+
+	TEST_GS_BASE();
+
+	if (gs == 0) {
+		unsigned long test_gs = 0xabababab;
+		TST_EXP_PASS_SILENT(set_gs(test_gs));
+		if (TST_PASS) {
+			TEST_GS_BASE();
+		}
+	}
+
+}
+
+static struct tcase {
+	unsigned idx;
+	void (*test_fn)(void);
+} tcases[] = {
+	{0, test_fs},
+	{1, test_gs}
+};
+
+static void run(unsigned index)
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
