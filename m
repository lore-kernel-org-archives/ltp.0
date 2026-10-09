Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 443BDCA601D
	for <ltp@archiver.kernel.org>; Fri,  9 Oct 2026 15:50:17 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id B513E3E9C90
	for <ltp@archiver.kernel.org>; Fri,  9 Oct 2026 17:50:15 +0200 (CEST)
Received: from in-3.smtp.seeweb.it (in-3.smtp.seeweb.it
 [IPv6:2001:4b78:1:20::3])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 0A3F13E2F43
 for <ltp@lists.linux.it>; Fri,  9 Oct 2026 17:49:59 +0200 (CEST)
Received: from mail-wm1-x336.google.com (mail-wm1-x336.google.com
 [IPv6:2a00:1450:4864:20::336])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-3.smtp.seeweb.it (Postfix) with ESMTPS id 81ACA1A00219
 for <ltp@lists.linux.it>; Fri,  9 Oct 2026 17:49:58 +0200 (CEST)
Received: by mail-wm1-x336.google.com with SMTP id
 5b1f17b1804b1-4a02718da81so32201075e9.1
 for <ltp@lists.linux.it>; Fri, 09 Oct 2026 08:49:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1791560998; x=1792165798; darn=lists.linux.it;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=A90Z4KBX8ZyRiIwHBT0lPBQVfP9MXiuwXrDdyJUcA3o=;
 b=apTXArDAu8qqjhgNhnRfFHrjNY7XJ+c4J7z3JI4zIGbvba4U060iF0LYCsnr5+Q18W
 DDPKtgcLMZtlft2QR/6gthbR+AT9hN4r7RA2AWoMwuXJJkKDf4n6ex2Ctk3QzM9j0E4U
 yviHIy1f5gI0z/pgqxxpYMCMOYLQArFVFrgzUqHilgS+pLD7YyzzbdDP72UaWA+AEFsI
 MVccueaaRg0H9op3rrDaIZl9g4vTeyTWYmgZav6jqvjmAIIg7r/r7LIUpAT1zMdwDNJ9
 T5swhkS15FvFy9icO8Idan9V/cQhgRNb9vGWcP2LYGTuEzQyb5jcODLwcEyC10YdfgXr
 xHgQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1791560998; x=1792165798;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to:content-type;
 bh=A90Z4KBX8ZyRiIwHBT0lPBQVfP9MXiuwXrDdyJUcA3o=;
 b=Jx/ANIFZWHt2h9PwBtbP7p8s00+ZnZst47E2Fic+umrDI1uZhPKEYaWmPHDgckuFna
 8VqafufflWOeYE1dUZfZvA8D2B3AU0HQ3fPKnNTItTD78XoE0se4qGhVYShE4BBq67/I
 qKi7mA4F+x0Xg8XWehGiYxkfAOQdXyicFDjl8YuX6JBjecEjHWfWHbGXp/R+SRl/7B0r
 IGLvI469bx0q0LR2GPPXqZOaXPDctv5v5LPppUFQA++yz0WaRdz61w8cIeJgIZIHBalD
 TucUvYYjbHvrR+AE0M2uP36TT97HGZe2wlyhgJN4zziKS63qW8rkwvP8DF9jMb9AiPBR
 ANLA==
X-Gm-Message-State: AFuF++lcJ4h7J47cB+2rWArhlrUEBiGcZHeWYlSs0B+2NQbrcspZjaHQ
 TOY3oseEcahSAwuHYVaurP8RweCt2q2t4tTeb7rUQp6VOHFkLZF/NA0Mfy9v1bcoQ2Q9pQ==
X-Gm-Gg: AYBFou0BzIKSPN6yo4NM9qkMrytOwST+z910ZPksxgTIxSMyzP44q3ZmqZZX4mUAjHW
 QQuNrEQJMUt8N2yu1l+D0GiqTYbvJ3zgwmvQxavfqKPTpbs+5ZANs+OLmK6RtCZYZ2AwOgcZU0J
 DpLGbOz5jyxVy4xXG5yA7Enwo4oEUwvxPofw7LH/ULKBZsScFwslF1tiFl5OPcUUy4npmI2w+rs
 A+wrPEoxGWjuKF1cx+Fdaq6+zD9GLAsqijGF9w8XH/zeTMVUWnVkaOaTjehVcuSplrcq621+MYi
 EfTdupSkvudilfHblEZy7LvT5MI7o9BBR7PxQty/1tHgwhD/AyHLTVWuc6UCTqtyyKvOCrIkO7N
 aVi4004MZJwLmRrPiTfFtdfOaSsRSVWQLKQzNWS7H94j+/9OKKfudC6Uy/LCo9zF0L+5X5krgB8
 hAoO3nEHancROxrvoWhkEaYArdIC9AMP8guqoD4r2neTIqPi1YjEp3hlGfmosFeRhCSvFSO/8JJ
 gOuKCPRB6W2abywDtlaCyvhXhYTZ3Mbw4G1NaWl
X-Received: by 2002:a05:600c:8706:b0:4a0:1efa:c74a with SMTP id
 5b1f17b1804b1-4a18e4b0f6amr44338915e9.20.1791560997743; 
 Fri, 09 Oct 2026 08:49:57 -0700 (PDT)
Received: from chestnykh (broadband-46-242-13-70.ip.moscow.rt.ru.
 [46.242.13.70]) by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-4a18bf2e0dbsm68290475e9.11.2026.10.09.08.49.56
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 09 Oct 2026 08:49:57 -0700 (PDT)
From: dm.chestnykh@gmail.com
To: ltp@lists.linux.it
Date: Fri,  9 Oct 2026 18:52:24 +0300
Message-ID: <20261009155224.9042-1-dm.chestnykh@gmail.com>
X-Mailer: git-send-email 2.56.0
In-Reply-To: <20261008194725.1198-1-dm.chestnykh@gmail.com>
References: <20261008194725.1198-1-dm.chestnykh@gmail.com>
MIME-Version: 1.0
X-Virus-Scanned: clamav-milter 1.0.9 at in-3.smtp.seeweb.it
X-Virus-Status: Clean
Subject: [LTP] [PATCH v2] arch_prctl: add ARCH_GET_FS, ARCH_GET_GS tests
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
 configure.ac                                  |  1 +
 include/lapi/arch_prctl.h                     |  9 ++
 runtest/syscalls                              |  1 +
 .../kernel/syscalls/arch_prctl/.gitignore     |  1 +
 .../kernel/syscalls/arch_prctl/arch_prctl02.c | 87 +++++++++++++++++++
 5 files changed, 99 insertions(+)
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
index 000000000..180c64b27
--- /dev/null
+++ b/testcases/kernel/syscalls/arch_prctl/arch_prctl02.c
@@ -0,0 +1,87 @@
+// SPDX-License-Identifier: GPL-2.0-or-later
+/*
+ * Copyright (c) 2026 Dmitry Chestnykh <dm.chestnykh@gmail.com>
+ * Author: Dmitry Chestnykh <dm.chestnykh@gmail.com>
+ */
+
+/*\
+ *  Simple test on arch_prctl to get FS_BASE and GS_BASE
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
+static bool tag;
+
+static void setup(void)
+{
+    unsigned long v = 0;
+
+#ifdef AT_HWCAP2
+	v = getauxval(AT_HWCAP2);
+#endif
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
+	TST_EXP_PASS_SILENT(arch_prctl_get(ARCH_GET_FS, &fs_prctl));
+	if (TST_PASS)
+		TST_EXP_EQ_LU(fs_prctl, fs);
+	else
+		tst_res(TFAIL, "got wrong fs register value");
+
+	TST_EXP_PASS_SILENT(arch_prctl_get(ARCH_GET_GS, &gs_prctl));
+	if (TST_PASS)
+		TST_EXP_EQ_LU(gs_prctl, gs);
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
