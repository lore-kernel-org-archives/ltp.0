Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BBF5BC4450A
	for <ltp@archiver.kernel.org>; Thu, 16 Jul 2026 13:32:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=lists.linux.it;
 i=@lists.linux.it; q=dns/txt; s=picard; t=1784208739; h=to : date :
 message-id : in-reply-to : references : mime-version : subject :
 list-id : list-unsubscribe : list-archive : list-post : list-help :
 list-subscribe : from : reply-to : content-type :
 content-transfer-encoding : sender : from;
 bh=Wnufa49KlZTIfuatLshzcIG6OXn5j/Tn0J2Bv+AThGk=;
 b=L6LsQ2lr5NKMNVPpPhQC32L6b4bkSHEEhFvNWYZ4yVshAHXmehK31TnqEe8qy+xNyLSf/
 fKs167KiDl3YkYatZSeKIt2sdm6g+dTvMff9Oi3JdjTgMTunMOecQrrFZ+ZysP28jaPhkFc
 mc90a7U5un9M02Rcto/2hF8ZihTHwmc=
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 48CAC3E5613
	for <ltp@archiver.kernel.org>; Thu, 16 Jul 2026 15:32:19 +0200 (CEST)
Received: from in-2.smtp.seeweb.it (in-2.smtp.seeweb.it [217.194.8.2])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id C27CD3E268A
 for <ltp@lists.linux.it>; Thu, 16 Jul 2026 15:31:26 +0200 (CEST)
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.129.124])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-2.smtp.seeweb.it (Postfix) with ESMTPS id EB20C600973
 for <ltp@lists.linux.it>; Thu, 16 Jul 2026 15:31:25 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1784208684;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=lfx7BQWBqCMwBrr/NPwAMT/Li8vS5m2gUqsePIUXJrU=;
 b=TZMes1NCbLTSarXxC9UYNUrV1akTDFt+7VMN0R372VuSjCAGwZHRLVgzmhGAFDhHpT/Z4g
 j90gRyqFj0zWt10GnqHe07tTjSbhCkWtV5cVXhGpejbYcxJatB4Gd/nO8Fjri3VQJWdaXY
 YW8vgT2DWNiTVETLnEmL7SQc5BP0J/4=
Received: from mail-wr1-f72.google.com (mail-wr1-f72.google.com
 [209.85.221.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-581-o41FmTksN72XS97xIRTgbQ-1; Thu, 16 Jul 2026 09:31:18 -0400
X-MC-Unique: o41FmTksN72XS97xIRTgbQ-1
X-Mimecast-MFC-AGG-ID: o41FmTksN72XS97xIRTgbQ_1784208676
Received: by mail-wr1-f72.google.com with SMTP id
 ffacd0b85a97d-473941177b0so5455837f8f.1
 for <ltp@lists.linux.it>; Thu, 16 Jul 2026 06:31:17 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1784208676; x=1784813476;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to:content-type;
 bh=lfx7BQWBqCMwBrr/NPwAMT/Li8vS5m2gUqsePIUXJrU=;
 b=KE3mMQtmns09YpYOdl9HPBJBFZUWaBM34TH/k+Ttm7PLicY+1WpJt1LVfENANqStyR
 ZltL5jMFJTTmH1ZAw22lL5jtLbfex01W2RLnzKAmD8GCPVSximqbKV5rlTCW2w1jyRs8
 mjnneV3reH+H3ybhso6p8GiAysrfcPqI8dlceO1LDLx5ta3aPNPl8hQCK/k+3XWoy85R
 +s/Ws/on7TWSxEeQuyrfDZ73D9RI/w9IA+9CN9xodVHpQkdDSUEn1tR85EXqBmSWPiy8
 y5vd7Ykg8d/wFwDZgnQP1sZlVSz3ZYXUjH1hGMdF2MLI8P2LRiwiWzmyMsnB8aGdgEgB
 nW3w==
X-Gm-Message-State: AOJu0YxIXRr2rWiH76rnMnIO9Ko6NpYCJp72cxe4yWhgwb7NYoMp/rfn
 wEhtkafzuxb71GB8CBoueUSgojVrduZ3ptfb9PzZurmSj5F9JAcWW5v0EePCyzItQDmc6qZzIPC
 n/V5DuaCQL9jS2a6nAwBy823xb3LgAWr1ZybXWiCR2euRYdgBuu8+XIpyZc9bUTiYgvrSlSjyZs
 ChLjxErjpRV0tkXJ9k5aVvUiQEA+9LIIyM8Cj3
X-Gm-Gg: AfdE7cnzxXPk60AecQrVum7XbyNEsdAM8eAkWJVaTHdcMbQahS6ijN460w7fUn4I9Kq
 dmvH1NnytMbm/3aY+nZuwU3OR6JU8lfKQcNbfv07NOiBYQnV4hVsmh2tbs368zLY3t/38W8zKJ2
 CsebO9xkQdmrTjOh6UrzpoRE/pm44YT5bRsMMYGIu65t/3KI1Q53NthpTGOngzkWQU71JoucWKg
 1NLSOOE9w7AzR5hzqfVEwWbEjeIHJ4rxkLiZQpotgly17pJyHDjRJaBO9yH3YusVZIOfkthqbt1
 5T98OvCEIw3IE728VHUWpTcSiBIWv4HfeHMVH/xPDNO1QAvO25RTyoPfE1vWC+S4SYiTnO4vr13
 o+aOAEC38jFeCvTdFPsXr77YOdVM3GqrWc1WYl4WZUHfRb/piNQ==
X-Received: by 2002:a05:6000:2510:b0:473:987f:c0ec with SMTP id
 ffacd0b85a97d-47f4fd11eafmr8548345f8f.36.1784208676033; 
 Thu, 16 Jul 2026 06:31:16 -0700 (PDT)
X-Received: by 2002:a05:6000:2510:b0:473:987f:c0ec with SMTP id
 ffacd0b85a97d-47f4fd11eafmr8548263f8f.36.1784208675336; 
 Thu, 16 Jul 2026 06:31:15 -0700 (PDT)
Received: from fedora.redhat.com (85.64.193.120.dynamic.barak-online.net.
 [85.64.193.120]) by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-47f4635c86csm24900918f8f.16.2026.07.16.06.31.13
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 16 Jul 2026 06:31:14 -0700 (PDT)
To: ltp@lists.linux.it
Date: Thu, 16 Jul 2026 16:31:08 +0300
Message-ID: <20260716133108.13003-3-mmenashe@redhat.com>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <20260716133108.13003-1-mmenashe@redhat.com>
References: <20260716133108.13003-1-mmenashe@redhat.com>
MIME-Version: 1.0
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: 2ZWtJ8cTYsWbxtXxcJm57tmk2g0MiKbKIaz3VfHCL1g_1784208676
X-Mimecast-Originator: redhat.com
X-Virus-Scanned: clamav-milter 1.0.9 at in-2.smtp.seeweb.it
X-Virus-Status: Clean
Subject: [LTP] [PATCH v17 2/2] futex_cmp_requeue03: Add EFAULT error
 coverage test
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
From: Michael Menasherov via ltp <ltp@lists.linux.it>
Reply-To: Michael Menasherov <mmenashe@redhat.com>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: ltp-bounces+ltp=archiver.kernel.org@lists.linux.it
Sender: "ltp" <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>

futex(FUTEX_CMP_REQUEUE) has no existing test for EFAULT. Add coverage
for the cases where uaddr or uaddr2 points to unmapped or inaccessible
(PROT_NONE) memory.

Signed-off-by: Michael Menasherov <mmenashe@redhat.com>
---
 runtest/syscalls                              |   1 +
 testcases/kernel/syscalls/futex/.gitignore    |   1 +
 .../syscalls/futex/futex_cmp_requeue03.c      | 103 ++++++++++++++++++
 3 files changed, 105 insertions(+)
 create mode 100644 testcases/kernel/syscalls/futex/futex_cmp_requeue03.c

diff --git a/runtest/syscalls b/runtest/syscalls
index 67509826f..0cb4e3dba 100644
--- a/runtest/syscalls
+++ b/runtest/syscalls
@@ -1864,6 +1864,7 @@ perf_event_open02 perf_event_open02
 
 futex_cmp_requeue01 futex_cmp_requeue01
 futex_cmp_requeue02 futex_cmp_requeue02
+futex_cmp_requeue03 futex_cmp_requeue03
 futex_wait01 futex_wait01
 futex_wait02 futex_wait02
 futex_wait03 futex_wait03
diff --git a/testcases/kernel/syscalls/futex/.gitignore b/testcases/kernel/syscalls/futex/.gitignore
index c11546e07..231b6bd25 100644
--- a/testcases/kernel/syscalls/futex/.gitignore
+++ b/testcases/kernel/syscalls/futex/.gitignore
@@ -16,3 +16,4 @@
 /futex_wait06
 /futex_wait07
 /futex_wake05
+/futex_cmp_requeue03
diff --git a/testcases/kernel/syscalls/futex/futex_cmp_requeue03.c b/testcases/kernel/syscalls/futex/futex_cmp_requeue03.c
new file mode 100644
index 000000000..43311bd9b
--- /dev/null
+++ b/testcases/kernel/syscalls/futex/futex_cmp_requeue03.c
@@ -0,0 +1,103 @@
+// SPDX-License-Identifier: GPL-2.0-or-later
+/*
+ * Copyright (C) 2026 Red Hat, Inc.
+ * Copyright (C) 2026 Michael Menasherov <mmenashe@redhat.com>
+ */
+
+/*\
+ * Check that futex(FUTEX_CMP_REQUEUE) returns EFAULT when uaddr or
+ * uaddr2 points to unmapped memory, or when uaddr or uaddr2 points to
+ * memory without read permission (PROT_NONE).
+ *
+ * The test uses opflags=0 (no FUTEX_PRIVATE_FLAG) so get_futex_key()
+ * takes the shared-futex path and resolves the physical page; this
+ * lookup fails with EFAULT for unmapped and PROT_NONE addresses.
+ * get_futex_key() is called for both uaddr and uaddr2 before the
+ * *uaddr == val check; futex_var and val are both FUTEX_INITIALIZER.
+ */
+
+#include <errno.h>
+#include <sys/mman.h>
+
+#include "futextest.h"
+
+static futex_t futex_var = FUTEX_INITIALIZER;
+static futex_t *futex_ptr = &futex_var;
+static futex_t *unmapped_addr;
+static futex_t *prot_none_addr;
+
+static struct futex_test_variants variants[] = {
+#if (__NR_futex != __LTP__NR_INVALID_SYSCALL)
+	{ .fntype = FUTEX_FN_FUTEX, .desc = "syscall with old kernel spec"},
+#endif
+
+#if (__NR_futex_time64 != __LTP__NR_INVALID_SYSCALL)
+	{ .fntype = FUTEX_FN_FUTEX64, .desc = "syscall time64 with kernel spec"},
+#endif
+};
+
+static struct testcase {
+	const char *desc;
+	futex_t **uaddr;
+	futex_t **uaddr2;
+} testcases[] = {
+	{
+		.desc = "uaddr unmapped",
+		.uaddr = &unmapped_addr,
+		.uaddr2 = &futex_ptr,
+	},
+	{
+		.desc = "uaddr2 unmapped",
+		.uaddr = &futex_ptr,
+		.uaddr2 = &unmapped_addr,
+	},
+	{
+		.desc = "uaddr PROT_NONE",
+		.uaddr = &prot_none_addr,
+		.uaddr2 = &futex_ptr,
+	},
+	{
+		.desc = "uaddr2 PROT_NONE",
+		.uaddr = &futex_ptr,
+		.uaddr2 = &prot_none_addr,
+	},
+};
+
+static void run(unsigned int n)
+{
+	struct futex_test_variants *tv = &variants[tst_variant];
+	struct testcase *tc = &testcases[n];
+
+	TST_EXP_FAIL(futex_cmp_requeue(tv->fntype, *tc->uaddr, futex_var,
+				       *tc->uaddr2, 1, 1, 0), EFAULT, "%s", tc->desc);
+}
+
+static void setup(void)
+{
+	struct futex_test_variants *tv = &variants[tst_variant];
+	size_t pagesize = getpagesize();
+
+	tst_res(TINFO, "Testing variant: %s", tv->desc);
+	futex_supported_by_kernel(tv->fntype);
+
+	unmapped_addr = SAFE_MMAP(NULL, pagesize, PROT_READ | PROT_WRITE,
+				  MAP_PRIVATE | MAP_ANONYMOUS, -1, 0);
+	SAFE_MUNMAP((void *)unmapped_addr, pagesize);
+
+	prot_none_addr = SAFE_MMAP(NULL, pagesize, PROT_NONE,
+				   MAP_PRIVATE | MAP_ANONYMOUS, -1, 0);
+}
+
+static void cleanup(void)
+{
+	if (prot_none_addr)
+		SAFE_MUNMAP((void *)prot_none_addr, getpagesize());
+}
+
+static struct tst_test test = {
+	.setup = setup,
+	.cleanup = cleanup,
+	.test = run,
+	.tcnt = ARRAY_SIZE(testcases),
+	.test_variants = ARRAY_SIZE(variants),
+};
-- 
2.55.0


-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
