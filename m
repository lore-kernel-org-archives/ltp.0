Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CD4BACD98E4
	for <ltp@archiver.kernel.org>; Tue, 16 Jun 2026 18:31:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=lists.linux.it;
 i=@lists.linux.it; q=dns/txt; s=picard; t=1781634679; h=to : date :
 message-id : in-reply-to : references : mime-version : subject :
 list-id : list-unsubscribe : list-archive : list-post : list-help :
 list-subscribe : from : reply-to : content-type :
 content-transfer-encoding : sender : from;
 bh=CllV7sPiM/r3LB873zKIVy6jCq2uRz1GQauo/5o79CE=;
 b=GY+FPeBbgCQ4Tr9qE6Rfz38cXWpCwqGRq8PYeC0gLzGyuC+oBuQCMNS8Ej5PXp5UXIitX
 jUdPL860iw44QDvvb7Ia4Y4a+oZ0la1xONzZqwF3YfATLE7/HFbUOpvFw350PrBrYv3sX1x
 t3ALJJT3+zHGxOv6C0TyCZh7aZBhRIs=
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 29CC63E6C61
	for <ltp@archiver.kernel.org>; Tue, 16 Jun 2026 20:31:19 +0200 (CEST)
Received: from in-7.smtp.seeweb.it (in-7.smtp.seeweb.it [217.194.8.7])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 842D23E59A3
 for <ltp@lists.linux.it>; Tue, 16 Jun 2026 20:30:36 +0200 (CEST)
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.133.124])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-7.smtp.seeweb.it (Postfix) with ESMTPS id F1D6E200901
 for <ltp@lists.linux.it>; Tue, 16 Jun 2026 20:30:35 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1781634634;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=uGD2v7UIHFxefjBiLjrbVIAsygD+p2yJt4e81RzLLWQ=;
 b=GbfTHsPhNd9vAgIVkIRV2X3537Ygqkr4tt4OJsgEtH+Xbib+LTY6niVopUhN20e6m36MkX
 N8o0CqsJL1ucsnqnPfCvAwCNSzF4neXQag4cPMzjfEZAmJ/oSr75jYhbvI3Zd+X0kAY3oP
 zE1KAIC9BmZZWzFlfpGUFnYPkceQvDU=
Received: from mail-wr1-f71.google.com (mail-wr1-f71.google.com
 [209.85.221.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-122-KvIt1OEIOhub6ujLXpH3VQ-1; Tue, 16 Jun 2026 14:30:32 -0400
X-MC-Unique: KvIt1OEIOhub6ujLXpH3VQ-1
X-Mimecast-MFC-AGG-ID: KvIt1OEIOhub6ujLXpH3VQ_1781634631
Received: by mail-wr1-f71.google.com with SMTP id
 ffacd0b85a97d-4625e71d3ccso4987f8f.0
 for <ltp@lists.linux.it>; Tue, 16 Jun 2026 11:30:31 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1781634631; x=1782239431;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=uGD2v7UIHFxefjBiLjrbVIAsygD+p2yJt4e81RzLLWQ=;
 b=F2TyNtnjoEl4JRvnGVVGeP3WDLosLcrCCyo+VHX/UpoWbfD5dHsxd+LyMYjmaRT54o
 LCh752eGWCYz67eF2yS3DfTqknU50DpRpZNHELA5REWCXajcqYgplpo5EuxSiPRTcteX
 VS/O5smDdtFWcs3z8MMk54jaWqmOEQM+stxyT3lhaw3Z+9/1FSKCOEwn+V71rFNgP4Ho
 PMz67Nz4Yb+/Om1BVoSQXGOvIMpLhAlAhZvzum4TZ3yAxamQuKAndGvqzcxUz/12OLUR
 F+kc2pcEs6KR3V7BHyhxEzBFkecUoN8Gt+b7Ub/DWY+4ObXeRMkkrM53qEeBYJvezjAY
 socw==
X-Gm-Message-State: AOJu0YzCZMWFj++JlOlnGeEthjzpea8k7+dCmvrP0GkupQNMmdfLvRgJ
 x6WfOErG8bXw7nkf51y8HgYNTHDzwB1ymPoN+S82W5NoJ3j4dpOq1RSPmIYZtS4tFJSliHC/T+w
 jVw3H08prHHKLgqW2Tev8+CONqgIkfGC8CbhOnd6479xafm8LjjFsWWcJ5WeQBwoAPPzegQE0vs
 6FfYp8+x3GqIYnowShqgh52Q/kYL50fIWbBMeA
X-Gm-Gg: Acq92OGnl/Z6T7Y0dSEsmrJ50R4GkR4z8+fhlLZKokJVvuQ2TYyj34k8OfljyfJDS6p
 V6N1V/buA2SjeucN9pHefmdXWY757ovYMMypPtI7PBCFpE9DbhZdtJMYL8QzHNzHW1I+D0mj5gD
 zQYbQaIAn0vOq6yTE0hFBtjPiO0KCym3BBg1wqS49u+XFh+cLpSPI/IvbOtrQAJj1tySwZfObnt
 V1luoXO3CZ6uNTobuPU1mrl+N3XMtBbFmdfkqq+HgfrObALsd4Ec6SQqMrgWFFscIbyY1oUxMxR
 YEWvVKmz9I34t729RRzE/vgY30M4oWOkMQr2mhgqWdzcz6neW5+mB7pjRhqKEl1qEGgf0LT6f1V
 2h+QFI8RgNgFwmUZJGv/sCwSCytWBKXYKjsaWQi0dYsgrnrZvS7e3+WegroYKET7L/1mMgsA=
X-Received: by 2002:a05:600c:c0c3:20b0:490:b4a8:e031 with SMTP id
 5b1f17b1804b1-492332c1259mr9359025e9.4.1781634630767; 
 Tue, 16 Jun 2026 11:30:30 -0700 (PDT)
X-Received: by 2002:a05:600c:c0c3:20b0:490:b4a8:e031 with SMTP id
 5b1f17b1804b1-492332c1259mr9358705e9.4.1781634630381; 
 Tue, 16 Jun 2026 11:30:30 -0700 (PDT)
Received: from fedora.redhat.com (85.64.196.200.dynamic.barak-online.net.
 [85.64.196.200]) by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-49233438eebsm8244805e9.0.2026.06.16.11.30.29
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 16 Jun 2026 11:30:29 -0700 (PDT)
To: ltp@lists.linux.it
Date: Tue, 16 Jun 2026 21:30:25 +0300
Message-ID: <20260616183025.26554-3-mmenashe@redhat.com>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <20260616183025.26554-1-mmenashe@redhat.com>
References: <20260616183025.26554-1-mmenashe@redhat.com>
MIME-Version: 1.0
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: Boi6aUQ5hIRXaue5Dilnz4F39p5gZAk7Sm2F61yR340_1781634631
X-Mimecast-Originator: redhat.com
X-Virus-Scanned: clamav-milter 1.0.9 at in-7.smtp.seeweb.it
X-Virus-Status: Clean
Subject: [LTP] [PATCH v15 2/2] futex_cmp_requeue03: Add EFAULT error
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
 .../syscalls/futex/futex_cmp_requeue03.c      | 102 ++++++++++++++++++
 3 files changed, 104 insertions(+)
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
index 000000000..6063ddd86
--- /dev/null
+++ b/testcases/kernel/syscalls/futex/futex_cmp_requeue03.c
@@ -0,0 +1,102 @@
+// SPDX-License-Identifier: GPL-2.0-or-later
+/*
+ * Copyright (C) 2026 Red Hat, Inc.
+ * Copyright (C) 2026 Michael Menasherov <mmenashe@redhat.com>
+ */
+
+/*\
+ * Check that futex(FUTEX_CMP_REQUEUE) returns EFAULT when uaddr or
+ * uaddr2 points to unmapped memory, or when uaddr points to memory
+ * without read permission (PROT_NONE).
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
+	int exp_errno;
+} testcases[] = {
+	{
+		.desc = "uaddr unmapped",
+		.uaddr = &unmapped_addr,
+		.uaddr2 = &futex_ptr,
+		.exp_errno = EFAULT,
+	},
+	{
+		.desc = "uaddr2 unmapped",
+		.uaddr = &futex_ptr,
+		.uaddr2 = &unmapped_addr,
+		.exp_errno = EFAULT,
+	},
+	{
+		.desc = "uaddr PROT_NONE",
+		.uaddr = &prot_none_addr,
+		.uaddr2 = &futex_ptr,
+		.exp_errno = EFAULT,
+	},
+};
+
+static void run(unsigned int n)
+{
+	struct futex_test_variants *tv = &variants[tst_variant];
+	struct testcase *tc = &testcases[n];
+
+	TST_EXP_FAIL(futex_cmp_requeue(tv->fntype, *tc->uaddr, futex_var,
+				       *tc->uaddr2, 1, 1, 0), tc->exp_errno, "%s", tc->desc);
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
2.54.0


-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
