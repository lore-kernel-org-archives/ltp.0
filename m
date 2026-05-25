Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 54884CD5BB1
	for <ltp@archiver.kernel.org>; Mon, 25 May 2026 19:05:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=lists.linux.it;
 i=@lists.linux.it; q=dns/txt; s=picard; t=1779735952; h=to : date :
 message-id : in-reply-to : references : mime-version : subject :
 list-id : list-unsubscribe : list-archive : list-post : list-help :
 list-subscribe : from : reply-to : content-type :
 content-transfer-encoding : sender : from;
 bh=VQWu09+PqS2RPb3gbGdfFXsWzvq0s0jHqUj/Kk2l920=;
 b=H7uQcWDkBsAp2VigK4owVedgNWjO0DU4ZKlPp2NhCyj7D/CTslqzc4gmFU4M7kuqOeK/o
 La3YMQzZRKRBFosa0wltHV+nJkVFMOJg4vnq4DC3ZGM+otMnJS+z2VXTu1/kWL++ZrPp9A3
 DuFBC+YZ0tVt4Y8Kgu0rfuF2/DLsXeo=
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id D7A333E160C
	for <ltp@archiver.kernel.org>; Mon, 25 May 2026 21:05:52 +0200 (CEST)
Received: from in-5.smtp.seeweb.it (in-5.smtp.seeweb.it
 [IPv6:2001:4b78:1:20::5])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 156D93E2D73
 for <ltp@lists.linux.it>; Mon, 25 May 2026 21:03:58 +0200 (CEST)
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.129.124])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-5.smtp.seeweb.it (Postfix) with ESMTPS id 8E439600726
 for <ltp@lists.linux.it>; Mon, 25 May 2026 21:03:57 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1779735836;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=mgi5DvA0EA/SqHZX+OjDrQtkgzvBx5e5m3m8nkJEd4M=;
 b=aD0Tyes42P+ukCbo1jCrblWDs9ONt4M6RqIQtuNWv5u736LWoe7B0ExTRJ57KowR9Dw6+B
 zzInI1yjksVR61MHEA/av4//m28pceHLGMA6pr/Ax3UCYOlARFlQD4rAocbkgc6gE4l12X
 4XucVRg3yk3xBQXoAOklpqJ/qZyBafo=
Received: from mail-wm1-f69.google.com (mail-wm1-f69.google.com
 [209.85.128.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-675-LOkTFytzMFCkbzuBf-yz2A-1; Mon, 25 May 2026 15:03:54 -0400
X-MC-Unique: LOkTFytzMFCkbzuBf-yz2A-1
X-Mimecast-MFC-AGG-ID: LOkTFytzMFCkbzuBf-yz2A_1779735833
Received: by mail-wm1-f69.google.com with SMTP id
 5b1f17b1804b1-48fd3dbd16aso78705415e9.0
 for <ltp@lists.linux.it>; Mon, 25 May 2026 12:03:54 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1779735833; x=1780340633;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=mgi5DvA0EA/SqHZX+OjDrQtkgzvBx5e5m3m8nkJEd4M=;
 b=hjbDpiA9epE3TYQtzV4Z8TZG569TPacHC49IQP2DQICFeu0EE5coe2LRtLnhIjwgtV
 anY792I1Y+1A5zM7IkCxjM4KrtKGwDiSfDxcrMl6PaHAniWcxl4yz0v3do0m23/l1nkN
 WokmhwuUR+Ejpsw9/MqK+kuGeXi2KZWG2dAR2LU4xan/WmU1yFv8L0kpRobZryndxdkJ
 +5fuHi/V4qfwCKZkLVa+o1SvQqz1qBRzXi8c5zA7IXAgi13ddXNBSv0agWFbJpD0eXtL
 /8aSFag5CRKmjG0/23u7etOS3WeUeAXzkqP+wChkcmEyqTKZXAaglqPqRsGc9xhQokRG
 jWGw==
X-Gm-Message-State: AOJu0YwJBqo7w6+4lVxEvAJFVOkMNtJfMt8fyf0LZodYjFX6hkeaWyuv
 p31PIKM3E69TGj9Jxi1GdXspWdxrtyoq3x7epUrAmeAghnX4nrL6B3/XT30+W3RszGgxBa1b/tZ
 RZXyl3CWASYUzASzFPY6QiSh/d/rBtEt6wIahYyN0mJ6SEVvho3JrILEgmLs7fSKivc/JqSWjtQ
 3eXmonX3eMqY1rT42GJvWTEkvKQUuyAHPZfQZ9
X-Gm-Gg: Acq92OFl//HS2DusQDM11h5XaJc+1FvUKs/IbL43tbXK1p7w/aEzerpzqzd4zd4ITUD
 TjROR49Ef6kgOkqBVuO2dMBDhMzhVMHUKRZunmRuFprao1HO2Di3l3Ob/g2dEQ6bTzduA4Y0btV
 A/dEXd6wbgdpsuMMgRxzmSvV2y6YPctRMHFNMVRHKqeD7igabl9MSCrP83qO3yTddRvptjhFLsB
 OoMYxttOE5yIrrd/0C1KP/7MhKXEAbo2MngK0EV4rwZwbdbQDSthk/ruq2vT+XlqsapXIixhcfS
 HZrf9HRcAMTcxz151bEki+GNb5cmbURUf3nslOwaWiwR/CSzEhrLYqzjsK3TJKT47FQKJ2ciGUX
 EMKldA/hX+ppS14BC1fXwqKc+T1O1rL1OJXf1jhcWXIFmvJMOrum7h8kR98YVijFLdx9UFCY7
X-Received: by 2002:a05:600c:34c5:b0:490:601f:d775 with SMTP id
 5b1f17b1804b1-490601fd89emr110604725e9.5.1779735833421; 
 Mon, 25 May 2026 12:03:53 -0700 (PDT)
X-Received: by 2002:a05:600c:34c5:b0:490:601f:d775 with SMTP id
 5b1f17b1804b1-490601fd89emr110604265e9.5.1779735833011; 
 Mon, 25 May 2026 12:03:53 -0700 (PDT)
Received: from fedora.redhat.com (89-138-3-119.bb.netvision.net.il.
 [89.138.3.119]) by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-4904527f7f7sm397695995e9.7.2026.05.25.12.03.52
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 25 May 2026 12:03:52 -0700 (PDT)
To: ltp@lists.linux.it
Date: Mon, 25 May 2026 22:03:44 +0300
Message-ID: <20260525190344.60330-5-mmenashe@redhat.com>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <20260525190344.60330-1-mmenashe@redhat.com>
References: <20260525190344.60330-1-mmenashe@redhat.com>
MIME-Version: 1.0
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: Uf27U2iLEmNLnMhMTD061WUWOKDQJ8AAYgnNw9XxxtM_1779735833
X-Mimecast-Originator: redhat.com
X-Virus-Scanned: clamav-milter 1.0.9 at in-5.smtp.seeweb.it
X-Virus-Status: Clean
Subject: [LTP] [PATCH v9 4/4] futex_cmp_requeue03: Add EFAULT error coverage
 test
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
 .../syscalls/futex/futex_cmp_requeue03.c      | 95 +++++++++++++++++++
 3 files changed, 97 insertions(+)
 create mode 100644 testcases/kernel/syscalls/futex/futex_cmp_requeue03.c

diff --git a/runtest/syscalls b/runtest/syscalls
index 2b1f6a763..d2e7f2b98 100644
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
index 000000000..44887001f
--- /dev/null
+++ b/testcases/kernel/syscalls/futex/futex_cmp_requeue03.c
@@ -0,0 +1,95 @@
+// SPDX-License-Identifier: GPL-2.0-or-later
+/*
+ * Copyright (C) 2026 Red Hat, Inc. Michael Menasherov <mmenashe@redhat.com>
+ */
+
+/*\
+ * Check that futex(FUTEX_CMP_REQUEUE) returns EFAULT when uaddr or
+ * uaddr2 points to unmapped memory, or when uaddr points to memory
+ * without read permission (PROT_NONE).
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
+		*tc->uaddr2, 1, 1, 0), tc->exp_errno, "%s", tc->desc);
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
+		MAP_PRIVATE | MAP_ANONYMOUS, -1, 0);
+	SAFE_MUNMAP((void *)unmapped_addr, pagesize);
+
+	prot_none_addr = SAFE_MMAP(NULL, pagesize, PROT_NONE,
+		MAP_PRIVATE | MAP_ANONYMOUS, -1, 0);
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
