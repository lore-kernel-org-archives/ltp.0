Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5BF2ACA6012
	for <ltp@archiver.kernel.org>; Fri,  9 Oct 2026 08:47:45 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 95E033E490C
	for <ltp@archiver.kernel.org>; Fri,  9 Oct 2026 10:47:43 +0200 (CEST)
Received: from in-6.smtp.seeweb.it (in-6.smtp.seeweb.it
 [IPv6:2001:4b78:1:20::6])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 7EAD33E24F7
 for <ltp@lists.linux.it>; Thu,  8 Oct 2026 21:45:04 +0200 (CEST)
Received: from mail-lf1-x129.google.com (mail-lf1-x129.google.com
 [IPv6:2a00:1450:4864:20::129])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-6.smtp.seeweb.it (Postfix) with ESMTPS id E11EF1400338
 for <ltp@lists.linux.it>; Thu,  8 Oct 2026 21:45:03 +0200 (CEST)
Received: by mail-lf1-x129.google.com with SMTP id
 2adb3069b0e04-5ba3adf78f5so4310436e87.3
 for <ltp@lists.linux.it>; Thu, 08 Oct 2026 12:45:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1791488703; x=1792093503; darn=lists.linux.it;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
 bh=jk0gsHGjOrqFpygrQXa/odhw13x5iMsOTMcoB8fsgDk=;
 b=gXII+svTGsmCLg4EsR58ttk3VGCbIcn1rWwUxhl0tRvZ94V5TLVa3b9DL6+3lHrJ16
 yYEOqSLaEh15ghg6Bf2+HnUp24ZbkXifLR3haxoVp9GZCUU9CmHndjNm5pT+Ph+v9uAL
 RDE76ZzPF/cR60sqcfrUdhDsyTtNzZbNhT4Uq8jcL6i/891RdSrPoVcf06nmzivh4rL3
 d9a/I1HNEClmhBAUB/WP4SKtA0vCM1iFhlnCETg9JRMDt1lJzluUOuL3ALavzFrcKDeD
 qa33vaVEJow2f/hgvB3yG4Q4Wh6x274l1UtLZJvEqfle1lOaQroX93BeaVsDlgOulmjn
 +Dtw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1791488703; x=1792093503;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=jk0gsHGjOrqFpygrQXa/odhw13x5iMsOTMcoB8fsgDk=;
 b=hVdLMci2j4KUb19x9KcXJFgebL5Yh3tuc1Ap3Dsq7tWDyCxQQitMbOrUMGHrxSlzHy
 HZUqSR8Ya/+RzWp52PJ1BOWsFGz+LqTBXZ40gCgdZjozmdXYIK89GO73vH8NwBJ0dVeH
 xiXNRWU070Gef6f4ghmPM1bmGHK/8agmT9ilFj6uet9SFcfESFYyGsRhVovDf01SiAzp
 I0ktLfxBMCtyUb4/3lMzssddrfTJfHU8R5SB5coQ6VclyxksXmlkC8Dsz+ZL/c7MC/As
 5OBhP+8wHlwKw4VqBXtTuCo+qcKNPzB7ACDLMDUUwtIAlW0FRBXXi3uoB1HV3XqVKzc8
 r0tQ==
X-Gm-Message-State: AFq9FYJR6kLSeQhBCyXjzo63irkSYv8Jm9WSIbHxKeEBjnusW+UVOwqc
 Gndn10qgS/h0QgKmrYR92n708Yq4zQnqKGqljmfSLMjbQbMh2PqhN++0tpROSUceS5rg6w==
X-Gm-Gg: AYBFou01PRcQjmg87/AvL8pmjsergqiPH0RyU0/dLZQfzPPSaclEogif2cXy3kPtkXd
 IhsjFdiH/nayZXWyByi4JeuUtW6j3i1x1uyR8PNBe5E79loaTEgDClSEaqTEWB83MGEtXfqr/cK
 0R6km+dRa8L/mJ1tbKzB8w/ucdhh1InIIwIFFLLxP3rYA3zvn2+w5MxmA6rt7alUG07PCWhwKjp
 ERsoCpqgandEwCdi3158WUAozcjRdGPu5YHFTBzJagzPkTcSl9NPK3bI7ECOYB7k1ufi8oCXKN2
 +Icsu06FdR9ZIji1MAHK8p5M6f40DIwOp8/RrDNwQMBya1/wG5uLZ2SNi0cZPdkSwv1pqxoYx/e
 4Ce0X9tYN7q1LhPvuoDJjWgx4dahGh4+tkHM4For4+rxDZvO/IJpGkiJddDVebbxqWX41xigNZ5
 y4lncjb6YQzyD2QE6R4B9fSHlHfwalCvMZTD0PFXqhDHpjApOdX9flRcKxAkykb3mHVa6AVCP3O
 3nmkZyFt2NS0Utp1i/Vr2bs7bAuUJYrYUv6wGYdLvUzI26HGoE=
X-Received: by 2002:a05:6512:6cb:b0:5b6:1a7c:aa0d with SMTP id
 2adb3069b0e04-5bcd0727e7dmr2389623e87.37.1791488702612; 
 Thu, 08 Oct 2026 12:45:02 -0700 (PDT)
Received: from chestnykh (broadband-46-242-13-70.ip.moscow.rt.ru.
 [46.242.13.70]) by smtp.gmail.com with ESMTPSA id
 2adb3069b0e04-5bcdd2e26a7sm60857e87.82.2026.10.08.12.44.59
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 08 Oct 2026 12:45:00 -0700 (PDT)
From: dm.chestnykh@gmail.com
To: ltp@lists.linux.it
Date: Thu,  8 Oct 2026 22:47:25 +0300
Message-ID: <20261008194725.1198-1-dm.chestnykh@gmail.com>
X-Mailer: git-send-email 2.56.0
MIME-Version: 1.0
X-Virus-Scanned: clamav-milter 1.0.9 at in-6.smtp.seeweb.it
X-Virus-Status: Clean
X-Mailman-Approved-At: Fri, 09 Oct 2026 10:47:27 +0200
Subject: [LTP] [PATCH] arch_prctl: add ARCH_GET_FS, ARCH_GET_GS tests
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
 .../kernel/syscalls/arch_prctl/.gitignore     |  1 +
 testcases/kernel/syscalls/arch_prctl/Makefile |  2 +
 .../kernel/syscalls/arch_prctl/arch_prctl02.c | 81 +++++++++++++++++++
 3 files changed, 84 insertions(+)
 create mode 100644 testcases/kernel/syscalls/arch_prctl/arch_prctl02.c

diff --git a/testcases/kernel/syscalls/arch_prctl/.gitignore b/testcases/kernel/syscalls/arch_prctl/.gitignore
index 24871e249..72187b8b4 100644
--- a/testcases/kernel/syscalls/arch_prctl/.gitignore
+++ b/testcases/kernel/syscalls/arch_prctl/.gitignore
@@ -1 +1,2 @@
 /arch_prctl01
+/arch_prctl02
diff --git a/testcases/kernel/syscalls/arch_prctl/Makefile b/testcases/kernel/syscalls/arch_prctl/Makefile
index 272949d57..c4413a81f 100644
--- a/testcases/kernel/syscalls/arch_prctl/Makefile
+++ b/testcases/kernel/syscalls/arch_prctl/Makefile
@@ -6,3 +6,5 @@ top_srcdir		?= ../../../..
 include $(top_srcdir)/include/mk/testcases.mk

 include $(top_srcdir)/include/mk/generic_leaf_target.mk
+
+CFLAGS += -mfsgsbase
diff --git a/testcases/kernel/syscalls/arch_prctl/arch_prctl02.c b/testcases/kernel/syscalls/arch_prctl/arch_prctl02.c
new file mode 100644
index 000000000..124dd13b9
--- /dev/null
+++ b/testcases/kernel/syscalls/arch_prctl/arch_prctl02.c
@@ -0,0 +1,81 @@
+// SPDX-License-Identifier: GPL-2.0-or-later
+/*
+ * Author: Dmitry Chestnykh <dm.chestnykh@gmail.com>
+ */
+
+/*\
+ * Simple test on arch_prctl to get FS_BASE and GS_BASE
+ */
+
+#include "tst_test.h"
+#include "lapi/syscalls.h"
+#include "lapi/arch_prctl.h"
+#include <stdlib.h>
+#include <string.h>
+
+#include <sys/auxv.h>
+#ifndef HWCAP2_FSGSBASE
+#if defined(__has_include) && __has_include(<asm/hwcap2.h>)
+#include <asm/hwcap2.h>
+#else
+#warning "Cannot obtain HWCAP2_FSGSBASE from system headers"
+#define HWCAP2_FSGSBASE (1UL << 1)
+#endif /* defined(__has_include) && __has_include(<asm/hwcap2.h>) */
+#endif /* HWCAP2_FSGSBASE */
+
+static int arch_prctl_get(int code, unsigned long *out)
+{
+	return tst_syscall(__NR_arch_prctl, code, out);
+}
+
+static bool tag;
+
+static void setup(void)
+{
+	unsigned long v = getauxval(AT_HWCAP2);
+
+	tag = v & HWCAP2_FSGSBASE ? true : false;
+}
+
+#define READ_FS_BASE() ({                              \
+	unsigned long long __res;                          \
+	asm volatile("rdfsbase %0" : "=r"(__res));         \
+	__res;                                             \
+})
+
+#define READ_GS_BASE() ({                              \
+	unsigned long long __res;                          \
+	asm volatile("rdgsbase %0" : "=r"(__res));         \
+	__res;                                             \
+})
+
+static void run(unsigned int index)
+{
+	(void)index;
+	if (!tag)
+		tst_brk(TCONF, "rdfsbase/rdgsbase are not supported/enabled");
+
+	unsigned long fs = READ_FS_BASE();
+	unsigned long gs = READ_GS_BASE();
+	unsigned long fs_prctl, gs_prctl;
+
+	TEST(arch_prctl_get(ARCH_GET_FS, &fs_prctl));
+	if (TST_RET == 0 && fs_prctl == fs)
+		tst_res(TPASS, "get fs succeed");
+	else
+		tst_res(TFAIL, "got wrong fs register value");
+
+	TEST(arch_prctl_get(ARCH_GET_GS, &gs_prctl));
+	if (TST_RET == 0 && gs_prctl == gs)
+		tst_res(TPASS, "get gs succeed");
+	else
+		tst_res(TFAIL, "got wrong gs register value");
+}
+
+static struct tst_test test = {
+	.test = run,
+	.setup = setup,
+	.tcnt = 1,
+	.min_kver = "5.9",
+	.supported_archs = (const char *const []){"x86_64", NULL}
+};
--
2.56.0


-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
