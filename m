Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B34F0CA9EC1
	for <ltp@archiver.kernel.org>; Sat, 10 Oct 2026 06:40:33 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 11EEA3E2D49
	for <ltp@archiver.kernel.org>; Sat, 10 Oct 2026 08:40:32 +0200 (CEST)
Received: from in-7.smtp.seeweb.it (in-7.smtp.seeweb.it [217.194.8.7])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 4F9463C23B2
 for <ltp@lists.linux.it>; Sat, 10 Oct 2026 08:40:15 +0200 (CEST)
Received: from mail-lf1-x134.google.com (mail-lf1-x134.google.com
 [IPv6:2a00:1450:4864:20::134])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-7.smtp.seeweb.it (Postfix) with ESMTPS id 8DAC2200045
 for <ltp@lists.linux.it>; Sat, 10 Oct 2026 08:40:14 +0200 (CEST)
Received: by mail-lf1-x134.google.com with SMTP id
 2adb3069b0e04-5ba3b1199f6so278257e87.3
 for <ltp@lists.linux.it>; Fri, 09 Oct 2026 23:40:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1791614414; x=1792219214; darn=lists.linux.it;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=xOuyqhzwUZ7m99sAEZ/QOXTHA4+bwE2qpv8p5/njB+c=;
 b=hF6qyeRNoc3YkBY3Wc7sXeE9fsaSGuiX0PcilM8mfAJdj8lnIk1LcWvJuSLZokE9PZ
 IpGqIfHOUXiPP/DzNO+RDzebRexnZweEvJBPCDIVwuL4Y/kTUPMp5T4qOVWnM+lMth1Y
 Td5HZmFNNvaOGAsCDzTc2JKuqxgVQt1PZo5h5IYkz0DjxAo0evE4F0jqFggz8t/KUsNw
 2vmgV6UL/hFMFBivoEV4iRCkhSSMTTwyV5qhvCK78ApIOzwtAq72ryvH1psfQNKR7Xo5
 auoAWP00Lj9FvB5lWdFfUDRgSfZKCsE5Qd2MLeMeU2uy6o4nCfX3zv1oKlppGUlMFbSl
 mvgw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1791614414; x=1792219214;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to:content-type;
 bh=xOuyqhzwUZ7m99sAEZ/QOXTHA4+bwE2qpv8p5/njB+c=;
 b=SyLgvjCB398BY9ZHCNah902jGkhuIOyIrHFOqmXgKfcYoC1QzZgCXbacGQ0C9yvVXl
 8+8Sr/mzAayXZEq+pvL9/gmcIWL1j4F1XAC19p3uOfbYcFqRzvDKvsgZYD2VZGVCmDZe
 AvRoXs0NBn0NgPq7D/c2qrl03Jse4I7Fb6kOsDKtdFvBmmlZmnGph+tNsQjGogALGYQ3
 NF6V069GWrxNIuzklk3MAzJruMVVzQHYPvnSYbBxeq+wm/0lRgHqy//79D56tat9wqnZ
 UgcFJX9ALpjTPy/30ezd0ju4CTAEQ7xLNLM2+QMcLqSzCMfktdcYP2qYN6LgzasNIqt1
 Raiw==
X-Gm-Message-State: AFq9FYL1AMwO9TAY/2V5Hf2gFZXdwF4DE5P1XXXzBKGOyJ4mh3T4Gqni
 6Tk5+97kX9E8jdKpd1KPsljh4V3bMfdsW+h7/+ji3LFXE4w1seqQyBWnaohIs3+QlbZuSA==
X-Gm-Gg: AYBFou03MntSMbr16+w1jGNTutFNeAeubCGdu0NpGhg8Yz0TC2VC3tx3wGqoB5hn5/d
 ETZtQ91w9B+P5u+jPFDWdEUN9Fd6sY/B6hdC4p38C+lbA89Tb8/WIM/W1IOitHPO97grdPzaD+K
 rBng2kfFLbPmte0d/IqDFWTLEnKaIGbZ5SwYrwW5cu6/hMtxbGNR3NfaPfRXEcBP+97JMrYiEA+
 Xp2BSkfEQ5mEEHSdx4sVlFHaYQuWAV0eldtF16AJ+xW0NQD+Ij01VDfLok2/OV1SzQS3OY+IgyY
 55ODx5h3qHPRaHPJ1Rb2oNZspvrv8s+yxj45J5Ny0iDyc3zUhSNrFneUvFsBuHUZUhsWKoTNS4n
 Pvt1YMeG5GVT9nG7NYwU1zhYkIK5yw+5K6992XzAW0jznHZSkmd3MC9LasgiOkkqZdCpqDz8mer
 USwVatlfjXxOLMiH5AFIDhhu6PI+0kNGDsPgmwhxV1520YrzEDq55cVHcCzef9RUGeyZs+49jBO
 zw1EiWBnejv0e0O0wJsFCKWN5IDyikEUf/Ec+yNn7H4oCJKum8=
X-Received: by 2002:a05:6512:3f21:b0:5ba:4472:75d4 with SMTP id
 2adb3069b0e04-5bcde6afa8cmr1520045e87.10.1791614413591; 
 Fri, 09 Oct 2026 23:40:13 -0700 (PDT)
Received: from chestnykh (broadband-46-242-13-70.ip.moscow.rt.ru.
 [46.242.13.70]) by smtp.gmail.com with ESMTPSA id
 2adb3069b0e04-5bcdde9c8f8sm1240458e87.37.2026.10.09.23.40.11
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 09 Oct 2026 23:40:11 -0700 (PDT)
From: dm.chestnykh@gmail.com
To: ltp@lists.linux.it
Date: Sat, 10 Oct 2026 09:42:40 +0300
Message-ID: <20261010064240.2467-1-dm.chestnykh@gmail.com>
X-Mailer: git-send-email 2.56.0
In-Reply-To: <20261010063824.2073-1-dm.chestnykh@gmail.com>
References: <20261010063824.2073-1-dm.chestnykh@gmail.com>
MIME-Version: 1.0
X-Virus-Scanned: clamav-milter 1.0.9 at in-7.smtp.seeweb.it
X-Virus-Status: Clean
Subject: [LTP] [PATCH v6] arch_prctl: add ARCH_GET_FS, ARCH_GET_GS tests
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
index 000000000..81295234d
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
+		unsigned long long test_gs = 0xabababab;
+
+		TST_EXP_PASS_SILENT(set_gs(test_gs));
+		if (TST_PASS)
+			TEST_GS_BASE();
+
+		set_gs(orig_gs);
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
