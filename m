Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 32753CA9EBE
	for <ltp@archiver.kernel.org>; Sat, 10 Oct 2026 06:36:15 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 75E383E2D90
	for <ltp@archiver.kernel.org>; Sat, 10 Oct 2026 08:36:13 +0200 (CEST)
Received: from in-5.smtp.seeweb.it (in-5.smtp.seeweb.it [217.194.8.5])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id BC2233E28AA
 for <ltp@lists.linux.it>; Sat, 10 Oct 2026 08:35:57 +0200 (CEST)
Received: from mail-lj1-x232.google.com (mail-lj1-x232.google.com
 [IPv6:2a00:1450:4864:20::232])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-5.smtp.seeweb.it (Postfix) with ESMTPS id B3AED60070F
 for <ltp@lists.linux.it>; Sat, 10 Oct 2026 08:35:56 +0200 (CEST)
Received: by mail-lj1-x232.google.com with SMTP id
 38308e7fff4ca-3a1981228f8so3620321fa.1
 for <ltp@lists.linux.it>; Fri, 09 Oct 2026 23:35:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1791614156; x=1792218956; darn=lists.linux.it;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=eE1B21pAVsqagRmm8EntcP9uGHeW5OJZyeFBa7TuBds=;
 b=fVMnoOKVEOFsyO2wlM0ZjkHHuFHhwyIsNWyeT/whoWKXlzaskG/7jUqA3Rn9Dxqixh
 uaHqDA+oMbIlgwninwkh7U3rRmz4SwRpFiDO+4+/25CaKXdf0Mu4JseBRQxYP1PXfeo+
 5/ZJfdeNMJSOGcz7BTeJFNuSQ/vENSs95C67Dom4x1jsjpJreLZZh7vsEp1if81en/jg
 50m9Ffpej77Pw+w2LL2WARs1QQBnJJCUPnlgUHwxKuAJvphRb/RjvGT/AoPYz1IP81UM
 v6EZShSZgF667hAePqBtTW5yWYMzYPTPYoCj/sEQsOd0Fgon2E4SQpQM1UVtYEViTSG1
 wL3w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1791614156; x=1792218956;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to:content-type;
 bh=eE1B21pAVsqagRmm8EntcP9uGHeW5OJZyeFBa7TuBds=;
 b=e/18asz6S/Q/RtFeqNUY6i029Gij6rbEPcZEYWszbZBu3QMhMeOpqw01I2vmfjEnBL
 qO/jhCbhTK3cJQXmhMMi4TeGTVBdk/4oElmceWEyVwNakUoKbH+n2lokwo2ebwxx4sO4
 WdKuYPTts8mAa6dj8EspO3tHaVJ59OfEi4hOGViG+rzj8WqJTJjydceGaDGSFoRXdXqx
 te4x8HIOlm5TZ3AF+8lbZ4ePwWhpYJLKZb5Fwe2S119DlvpRoffitdCpm4Xa4txoTqNU
 38DAReeyvJ+YPrOHwrD7fcC05qg6r7AYeHzKX3rPJUUI6VpoB9iG34t4hxBC8kEKsyx7
 5Q2A==
X-Gm-Message-State: AFq9FYICqsOn0KYic6ywEScEmYp4xuPVbd+s89hJMaWhGXpjOVTcNCDC
 CMJ5Q70SMddHmUVshE9X+O7keAYUAITeXTV/sdpkXHi5lzirqzqbY2+iju65GcTBR88HWw==
X-Gm-Gg: AYBFou20eowKw9nHYowewa9so1CfL5wlVRz9LyOyDBoQvtRye7JCl5Sp9CT8slEeSUw
 iRR2DM6jAvmj6VuffuXNIjV9abV2S0lJ9Fl7rDUXEr4slLHo2fI1prrupQsUL40Y92CaT3QLd6S
 0W3msv9OiG2RJckPGOpIRYp3gay6NVosLPRdcmWym7CPBDgXuPqZoVxt+LFsAUTJQM579XRwi5O
 xo/dSqYqJLTnmpB6BE+YhQ+f1cULz5/eAX4IZn70eky3y2PlrGaPDRlYkmPXhPk7EaN5ihQSu32
 JIPsU7fkQqGiSnJgXmbJb1YxsFe1WaTGLQLbJbXImMxK0oU9HsSHY1XZyDTx1LsMobEgoJI3BXl
 pF01nBNXIaD4KTjiefvCjUbITEU0WEbnWHMv4PD7XSk0qfW/Pdz6nvBMLQgZxBpR47mI0RB/14l
 ncb+RHiYVoEB52watRqjV8vFQgmxxsaSYKCav2VhU0SEy/qP2YyK7ACq7wuyGFBev4Pqn+EfAsM
 W1hTheZ7lWWPTKTIEumZX2RfXSpfLCoq2uXbe2O
X-Received: by 2002:a05:651c:1990:b0:3a1:51e6:fe5c with SMTP id
 38308e7fff4ca-3a9c54b7c5cmr9182611fa.13.1791614155565; 
 Fri, 09 Oct 2026 23:35:55 -0700 (PDT)
Received: from chestnykh (broadband-46-242-13-70.ip.moscow.rt.ru.
 [46.242.13.70]) by smtp.gmail.com with ESMTPSA id
 38308e7fff4ca-3a9c3cd783csm13044711fa.32.2026.10.09.23.35.54
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 09 Oct 2026 23:35:54 -0700 (PDT)
From: dm.chestnykh@gmail.com
To: ltp@lists.linux.it
Date: Sat, 10 Oct 2026 09:38:24 +0300
Message-ID: <20261010063824.2073-1-dm.chestnykh@gmail.com>
X-Mailer: git-send-email 2.56.0
In-Reply-To: <20261009183921.3408-1-dm.chestnykh@gmail.com>
References: <20261009183921.3408-1-dm.chestnykh@gmail.com>
MIME-Version: 1.0
X-Virus-Scanned: clamav-milter 1.0.9 at in-5.smtp.seeweb.it
X-Virus-Status: Clean
Subject: [LTP] [PATCH v5] arch_prctl: add ARCH_GET_FS, ARCH_GET_GS tests
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
index 000000000..15a1be2bc
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
+	unsigned long long gs, gs_prctl;
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
+		unsigned long long test_gs = 0xabababab;
+
+		TST_EXP_PASS_SILENT(set_gs(test_gs));
+		if (TST_PASS)
+			TEST_GS_BASE();
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
