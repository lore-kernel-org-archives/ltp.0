Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4EBB4CD5BC8
	for <ltp@archiver.kernel.org>; Tue, 26 May 2026 21:51:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=lists.linux.it;
 i=@lists.linux.it; q=dns/txt; s=picard; t=1779832296; h=to : date :
 message-id : in-reply-to : references : mime-version : subject :
 list-id : list-unsubscribe : list-archive : list-post : list-help :
 list-subscribe : from : reply-to : content-type :
 content-transfer-encoding : sender : from;
 bh=pPSiTng7jKqoq3nJw8ZG+Kfym9Pz9m3bCOcfUhFDxiE=;
 b=a3EcK+zYb3Mk++lgm890KgrVQmJkeZBFdOotj1RrB3zMEhVH0ywuwXssfNFQ0b6cLkkEq
 gEBbSGx4GPbZHtTyaaZRhJiy+MyjPNtWrzxrCGRDoghccSsrEHYDlPqr/CZUuHhSAs9+/tc
 bwBS4zZkMV3BAbiH+dvQJhNLIzcpLgY=
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id C5C8B3C71CE
	for <ltp@archiver.kernel.org>; Tue, 26 May 2026 23:51:36 +0200 (CEST)
Received: from in-3.smtp.seeweb.it (in-3.smtp.seeweb.it [217.194.8.3])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id B987D3C72DC
 for <ltp@lists.linux.it>; Tue, 26 May 2026 23:49:41 +0200 (CEST)
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.133.124])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-3.smtp.seeweb.it (Postfix) with ESMTPS id 1CD5F1A00909
 for <ltp@lists.linux.it>; Tue, 26 May 2026 23:49:40 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1779832179;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=mF4BRl+NEaH/ygV98vMGAieF0wjZiGVTjz5XX/wtHrU=;
 b=JEOBR8eI1i19nsBMjwC3jL3ku/IsgSZ6dEzf0m+yb4jvnl4LWM/NSc/K3S9bVnmwrfVvCI
 obCIlQmcwwK0SvDuMvaxnNTWzvV4fwraGWEwJjPDhBxosbThdWSaIieKpKZ5qchoiYlQ70
 +O6k29bWqnBWJuNYd5ZWMDla41mCTtY=
Received: from mail-wr1-f70.google.com (mail-wr1-f70.google.com
 [209.85.221.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-226-HC2av3APP4-tOIzYxaYSMw-1; Tue, 26 May 2026 17:49:38 -0400
X-MC-Unique: HC2av3APP4-tOIzYxaYSMw-1
X-Mimecast-MFC-AGG-ID: HC2av3APP4-tOIzYxaYSMw_1779832177
Received: by mail-wr1-f70.google.com with SMTP id
 ffacd0b85a97d-4518f777225so7838342f8f.1
 for <ltp@lists.linux.it>; Tue, 26 May 2026 14:49:37 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1779832177; x=1780436977;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=mF4BRl+NEaH/ygV98vMGAieF0wjZiGVTjz5XX/wtHrU=;
 b=Amj+RudNMhbpHurCe+MX1USMqoyTbYquO3TF6RwLGf9YeS+CZOiVE3lk2atIDS1j6b
 SaswGxcV0qtxip1i1kBpRxUR7a/KHADM8Kdtv3HvYiGqcfxBxl+CPq8+LZoJ6zzBmHJe
 1Dm0fJPWG5gxqlFnIHm2zw3FJm/RbXEWOpYWs4xJ+M8hm2RWvV+hDMnV/HsXgx6RTtdx
 lL8ESd63GDqcO/PDkfBJy6caKy6jZ7a1oHtIGL3MTTHH7xaCh8J5rpeEQvsYBArDi2uI
 E/Z/TeFPaHow25d5HTF1WcCgyHzGxNU66J5gWsaN0M5MZvd3VOyKNEUSrfMYTr+D+0pO
 dzpQ==
X-Gm-Message-State: AOJu0YyT/T3bqDvJMCz2LVGNBCs8STyiIByzxSirMED0GZvpdv3wUurn
 9b53jrXMt+gU1K0CbpEm04EZZprAImtfAuevL7GWsxKlGREtvMTaVfpVSREn81fgWHU9uZnu6rq
 LmXm7JHjXYbf/vQkLJhHTTLAzZ8U0iWd9Y0YGyrDv/D5pUObIPow9pxvf/kaxlf3vvaHxghRDvw
 +L5iYtSaUn5Mqcpa8uZVeSmNwzDc36yv8o2Hdw
X-Gm-Gg: Acq92OHt4R23WgWfPcW6O0sAI1FFnJvxnC2pv1rMnd0SuG+uNingmyr2ZhTRG2oiBbF
 aSpawVdtMg3V0STLWC7apLFi/qc9QKs+Snu+7AJEMrx/kE5Vc0FDT7KKIRmmWlI0680zycQ1afV
 esdNDf/KX+WslFV0oc7bLp30MjeEBhwwYnAeTrTYnhY84MrSe2vy8psekZ5dbwUTzoLzSe9D+cp
 +FBM3LSXdDzmT3hn4aeHECqqxctIvu60TIAAkgsmEx2JA3mMz0q5/VsgMe9CJhSE8MppkF7rHqt
 G+IruUd8mLKBDvBSdXM39janWyeaY40AYlJ1tMMDGmBvr6i0zwFmwBcrYSggYuHE8mn1Xkk58PT
 Buqx2TzKJ27TpQzGnCUiMG/5+VoV7ZV0y42T0pmaNVYQYtkcbLB4BLImNXNr6SNRauxRR4zUv
X-Received: by 2002:a05:600c:6095:b0:490:51b9:2309 with SMTP id
 5b1f17b1804b1-49051b924b1mr285170365e9.29.1779832176914; 
 Tue, 26 May 2026 14:49:36 -0700 (PDT)
X-Received: by 2002:a05:600c:6095:b0:490:51b9:2309 with SMTP id
 5b1f17b1804b1-49051b924b1mr285169925e9.29.1779832176505; 
 Tue, 26 May 2026 14:49:36 -0700 (PDT)
Received: from fedora.redhat.com (89-138-3-119.bb.netvision.net.il.
 [89.138.3.119]) by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-45edb54a6cdsm1211123f8f.2.2026.05.26.14.49.34
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 26 May 2026 14:49:35 -0700 (PDT)
To: ltp@lists.linux.it
Date: Wed, 27 May 2026 00:49:27 +0300
Message-ID: <20260526214927.150812-5-mmenashe@redhat.com>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <20260526214927.150812-1-mmenashe@redhat.com>
References: <20260526214927.150812-1-mmenashe@redhat.com>
MIME-Version: 1.0
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: jd4-wdnqr_8wSikgmlWL145FE0smEA67HNZW6rDiOxw_1779832177
X-Mimecast-Originator: redhat.com
X-Virus-Scanned: clamav-milter 1.0.9 at in-3.smtp.seeweb.it
X-Virus-Status: Clean
Subject: [LTP] [PATCH v13 4/4] futex_cmp_requeue03: Add EFAULT error
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
 runtest/syscalls                              |  1 +
 testcases/kernel/syscalls/futex/.gitignore    |  1 +
 .../syscalls/futex/futex_cmp_requeue03.c      | 99 +++++++++++++++++++
 3 files changed, 101 insertions(+)
 create mode 100644 testcases/kernel/syscalls/futex/futex_cmp_requeue03.c

diff --git a/runtest/syscalls b/runtest/syscalls
index 8c4d9be6c..87bd5aeac 100644
--- a/runtest/syscalls
+++ b/runtest/syscalls
@@ -1863,6 +1863,7 @@ perf_event_open02 perf_event_open02
 
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
index 000000000..a53286625
--- /dev/null
+++ b/testcases/kernel/syscalls/futex/futex_cmp_requeue03.c
@@ -0,0 +1,99 @@
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
