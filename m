Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 45F50CA601E
	for <ltp@archiver.kernel.org>; Fri,  9 Oct 2026 18:33:26 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 704D53EA8DC
	for <ltp@archiver.kernel.org>; Fri,  9 Oct 2026 20:33:24 +0200 (CEST)
Received: from in-5.smtp.seeweb.it (in-5.smtp.seeweb.it
 [IPv6:2001:4b78:1:20::5])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 959583E2E3E
 for <ltp@lists.linux.it>; Fri,  9 Oct 2026 20:33:06 +0200 (CEST)
Received: from mail-lf1-x12a.google.com (mail-lf1-x12a.google.com
 [IPv6:2a00:1450:4864:20::12a])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-5.smtp.seeweb.it (Postfix) with ESMTPS id 780DC6002B8
 for <ltp@lists.linux.it>; Fri,  9 Oct 2026 20:33:06 +0200 (CEST)
Received: by mail-lf1-x12a.google.com with SMTP id
 2adb3069b0e04-5bb7ae22913so3153297e87.3
 for <ltp@lists.linux.it>; Fri, 09 Oct 2026 11:33:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1791570786; x=1792175586; darn=lists.linux.it;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=F7E5CiktXtt0g+emKhyfvKdQKfWhOfR/SXS+ir+Q2LM=;
 b=P8fdpxz1FKGkdEBh0PuwtDQ7FmsXK80hz6llHuqt9mj7SOhmWCtyGMwaQ1Hra+aCeR
 D6c2AONyoGFEMRRXfnmsXSE5fCqHDeDaQAk7Wct07OtnXuhZbrjSBnDMCIcPNeQ3btgf
 bqbSpf1E9ZSp4YSJik1nGM1uuvb+GCOP8zkcZLLjVepcLoMWbq1ReMUfZDCADqxHLbEA
 punFN8IMnajBBai0JDetBUQPWtRWe092P9voermlz0+B+3IkWCKFk89kafHMo9vxiJIc
 lchI2Wa8/zjxwcDXTGSEQ86Gip8ph/ctbCJRvxNKmMDaCW+yMqwaBnjNbpa0gseECyCH
 Xm0w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1791570786; x=1792175586;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to:content-type;
 bh=F7E5CiktXtt0g+emKhyfvKdQKfWhOfR/SXS+ir+Q2LM=;
 b=tzdlZDXgmplZ4s+sP3o7xSlkUcNXF/Jh+1wQEeNaVCQqysRIjsdhsqFelG6gPS6lHr
 GSLAfcBomeMT7G898/GoXvAwaRRqV2tnNRDkNyv2/8NbTnlZDZ2Ozr/pPSIEIDgZ5gNJ
 /lqX8IsZleCBscAAe8qqbjtM7VuDBXDSW8zl1ri73iJOGICXgyvRhOAwNyra8C/9nWq1
 iVu0/SMmVxihzlOcw1M0ev9TPvuJrXmyS1KF7WEbECBm8ilHs8m66TV8UsZ4FHV742YE
 KORthSNK1Z7DZFFzt1vPEKFC6fbxvsJlWrkstveelBdg4bZ/wjTL5sQXGpKiEJEpRp9m
 uDNw==
X-Gm-Message-State: AFq9FYI206aQ51vTWTKiqivgx6xP5wIFbJnRLGYKCuOI3reEai6PHJLp
 LDddR+fIt9YZDwxslZ7u9DPUwk/m36Oab+AjfPIJS3CWbBJGwtyRRxmJi45xsKoze3yGcg==
X-Gm-Gg: AYBFou3Urm6Evu3ogeElNT2DJ+9hatotZ6Z/U0CYwVoxGzFYLGu4yX394hyeyClfk+I
 HwXWI/jyc3iPm7u8lR/UKTJpys1WA6fui9VBkfSmLq4HLgvfTkPJ7CG1GT1w5GeGo9RLgoS87Ef
 0BkK56BkNng6bSn7h4yOCH70MrYoneTREUaJMC63Y0GsR1yYo5yrnlseiUarZhF680t74g8Jf23
 EKSX8Xcb7jAWEcftNb2eUxf5+FVCDevicVc70ytGjXaB0OQQTSLBtp2Wy6CPrzSyVL1YLD0TUel
 PfoiiHqAF4EL3Xm1V9JlQe8GwT8/EEC+Kb4sMRwWCtK1u89J/UpUDU9m2hGvf5kcJ8EmZxjU2eY
 WTO59QcnnsKTrNV7RaRHX/qKmzp53eUIpakxXsyA5v3s6QB9Tg8sbpFdBryF0NPv5dZPSdnNhIk
 6EXlgDhHbURjjH3YgOieeoNksOeOMWBn79bw/DZYLkwUO6LF1HSNqkMrAGUfCLkoGtCBYl8/8V8
 LGNOXGAYCNhImxFCar996CmzD31ZtAPe3T0CVBC
X-Received: by 2002:a05:6512:1155:b0:5bc:cc96:67cc with SMTP id
 2adb3069b0e04-5bcde39f469mr1066254e87.13.1791570785337; 
 Fri, 09 Oct 2026 11:33:05 -0700 (PDT)
Received: from chestnykh (broadband-46-242-13-70.ip.moscow.rt.ru.
 [46.242.13.70]) by smtp.gmail.com with ESMTPSA id
 2adb3069b0e04-5bcdde3655bsm868692e87.6.2026.10.09.11.33.02
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 09 Oct 2026 11:33:03 -0700 (PDT)
From: dm.chestnykh@gmail.com
To: ltp@lists.linux.it
Date: Fri,  9 Oct 2026 21:35:30 +0300
Message-ID: <20261009183530.3114-1-dm.chestnykh@gmail.com>
X-Mailer: git-send-email 2.56.0
In-Reply-To: <20261009155224.9042-1-dm.chestnykh@gmail.com>
References: <20261009155224.9042-1-dm.chestnykh@gmail.com>
MIME-Version: 1.0
X-Virus-Scanned: clamav-milter 1.0.9 at in-5.smtp.seeweb.it
X-Virus-Status: Clean
Subject: [LTP] [PATCH v3] arch_prctl: add ARCH_GET_FS, ARCH_GET_GS tests
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
 .../kernel/syscalls/arch_prctl/arch_prctl02.c | 122 ++++++++++++++++++
 5 files changed, 134 insertions(+)
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
index 000000000..6992e93a3
--- /dev/null
+++ b/testcases/kernel/syscalls/arch_prctl/arch_prctl02.c
@@ -0,0 +1,122 @@
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
+	unsigned long gs_prctl;
+	unsigned long gs, orig_gs;
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
+		unsigned long test_gs = 0xabababab;
+		TST_EXP_PASS_SILENT(set_gs(test_gs));
+		if (TST_PASS) {
+			TEST_GS_BASE();
+		}
+	}
+
+	set_gs(orig_gs);
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
