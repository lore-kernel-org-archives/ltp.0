Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4CE5BCD5BB1
	for <ltp@archiver.kernel.org>; Tue, 26 May 2026 15:28:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=lists.linux.it;
 i=@lists.linux.it; q=dns/txt; s=picard; t=1779809290; h=to : date :
 message-id : in-reply-to : references : mime-version : subject :
 list-id : list-unsubscribe : list-archive : list-post : list-help :
 list-subscribe : from : reply-to : content-type :
 content-transfer-encoding : sender : from;
 bh=kt45qrYfOd8MmDssLAt+vMgjn+8GbEy4syjaDuoUmlA=;
 b=DkSHUYTXtHtDFw216fWGG4n5dUEiq2L61+LVCMp0u+2+qmGXgO/NQsHh/2+M9VEFFbM50
 g+DyRKSESKQLtpr1mgy/uzfKmD7lma1KoH7kfY/Sv+yEho6Gm+NgtcZ148hcYz4GX3bxwT6
 lTnCS3h3rG1nfIcGHKSsnQVJbzaL91g=
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 0881D3E62C7
	for <ltp@archiver.kernel.org>; Tue, 26 May 2026 17:28:10 +0200 (CEST)
Received: from in-5.smtp.seeweb.it (in-5.smtp.seeweb.it
 [IPv6:2001:4b78:1:20::5])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1) server-digest SHA384)
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id A0E263E62C5
 for <ltp@lists.linux.it>; Tue, 26 May 2026 17:26:26 +0200 (CEST)
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.133.124])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-5.smtp.seeweb.it (Postfix) with ESMTPS id 036CE600070
 for <ltp@lists.linux.it>; Tue, 26 May 2026 17:26:25 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1779809184;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=CAwRuhInQxcqzTtK6KvtRVW3ra89mnQc53iNw+ezv1Q=;
 b=fPc7zh6cf9E2Ktji87ZmQTkzGMjBGm+DaUAMrygr55jCSEZZoysIHuoiFGh66Hk9oZ2PHp
 hGbP4ltaJF1xrHPZCOQOnrpHRwcRklKoZbX5dfF/3mGST8Ou7mqoQ1qS2iQhJT3Nb3/n5P
 esupWIcHIXuYgeLkwh0QuQ9pKztBNyo=
Received: from mail-wm1-f69.google.com (mail-wm1-f69.google.com
 [209.85.128.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-628-akJuRuXtMmCzcWLXqsiktw-1; Tue, 26 May 2026 11:26:23 -0400
X-MC-Unique: akJuRuXtMmCzcWLXqsiktw-1
X-Mimecast-MFC-AGG-ID: akJuRuXtMmCzcWLXqsiktw_1779809182
Received: by mail-wm1-f69.google.com with SMTP id
 5b1f17b1804b1-48fe40b61a3so69916285e9.3
 for <ltp@lists.linux.it>; Tue, 26 May 2026 08:26:22 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1779809182; x=1780413982;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=CAwRuhInQxcqzTtK6KvtRVW3ra89mnQc53iNw+ezv1Q=;
 b=atb82VVsFP1yncEQxFGIvVdjLoqhrpi86vDvonA/IAdEbcZi7/QlP6GFQ+RhCve0uZ
 EDmxHJ2lGqs/iItOOA6B+0YMFaGBn3PunFr2tdhrSOIfqb4RSqfwtYoygjKKvG5xCA/Z
 wF0M4rzYS9W/v6ZafUTbNKmpdv76LmbkI/rqp9mIFQ2jxJpMctXj6qlN1EMu70RTzkwN
 Gc4ESrQ6IY24TAE+l5mPWogJ76YClVr06CMx26PIeuYED9Uf2p8fejA/uBQF4ZEtnLQ5
 Z9A8rqIZzdwbOV0A4Tn5p4Q6xEuD9S3GOQ+NAf/LuGdReTQwuaRdSuDTwsHKlxD7EO9K
 DIOQ==
X-Gm-Message-State: AOJu0YxCmf62L2sRuS9vB5ox/4hZZtP9/2RdbaNULfgPY7WFzXfDxAxL
 XxP5o/ADsVMK7lNNeXCbnpCGATwDyY0UsUDZqMRb6V8LPNd9eYFPIGZXAbQ4Ud0GgBiHd8xXQ+1
 xXS02hmAijvyPQpwu5GJOHFCIg6tCl92MeVMoD0ePDf9wSCJ7w5RshP9Vh8jVUDfeuT1AceDG0V
 B7esEDMAnbZh3rT5UZAUfE9cFG9YP9F6V1wS0B
X-Gm-Gg: Acq92OElqofl1GBA0iH844z0xr9xi27kNUReNH/2h3hmF8sWYPgga+X1Uy93q4OcVRs
 +i0dVVXJuxcsD7ZcK4U2nkUR/vto4xAgiXjKxY9hluKTR7mVRfA21qHDEij7SF0dGSkB0MKVp05
 LQjzW+X8D18KJXJ7BPIH+/P7Gq3eZsd8keow03tkE2KdKuoO8Xe+hEBG6CB+7MfOnPZVXhpDO2g
 Iew/5O5rn2WCvdTCSsn6f69uh90lzIydnVmMIeNWkX8U03CjWNcdtouxhk18qap7mafSDXDox8U
 SelkPoTKRC4i8me2M9IIEdeu21aNaSN5DLW69eiyohae/nadiddWfbs4ubZIIbo7sXSY0lQT6Oa
 qEJ4ZYglG7k+lg9ZDn5Mrdr0f7VViUi2oW63YnDEak1R+cImsNCBwhxECXg1pfg==
X-Received: by 2002:a05:600c:3541:b0:490:6e12:542c with SMTP id
 5b1f17b1804b1-4906e125469mr106450435e9.23.1779809181847; 
 Tue, 26 May 2026 08:26:21 -0700 (PDT)
X-Received: by 2002:a05:600c:3541:b0:490:6e12:542c with SMTP id
 5b1f17b1804b1-4906e125469mr106449735e9.23.1779809181322; 
 Tue, 26 May 2026 08:26:21 -0700 (PDT)
Received: from fedora.redhat.com (89-138-3-119.bb.netvision.net.il.
 [89.138.3.119]) by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-4904561a160sm384735795e9.9.2026.05.26.08.26.20
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 26 May 2026 08:26:20 -0700 (PDT)
To: ltp@lists.linux.it
Date: Tue, 26 May 2026 18:26:13 +0300
Message-ID: <20260526152613.109485-5-mmenashe@redhat.com>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <20260526152613.109485-1-mmenashe@redhat.com>
References: <20260526152613.109485-1-mmenashe@redhat.com>
MIME-Version: 1.0
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: KWYmMu3HVzq3E-BsswYQPBQ4VBLSSQktGoS1Zhp4CLY_1779809182
X-Mimecast-Originator: redhat.com
X-Virus-Scanned: clamav-milter 1.0.9 at in-5.smtp.seeweb.it
X-Virus-Status: Clean
Subject: [LTP] [PATCH v11 4/4] futex_cmp_requeue03: Add EFAULT error
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
 .../syscalls/futex/futex_cmp_requeue03.c      | 98 +++++++++++++++++++
 3 files changed, 100 insertions(+)
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
index 000000000..01936551d
--- /dev/null
+++ b/testcases/kernel/syscalls/futex/futex_cmp_requeue03.c
@@ -0,0 +1,98 @@
+// SPDX-License-Identifier: GPL-2.0-or-later
+/*
+ * Copyright (C) 2026 Red Hat, Inc. Michael Menasherov <mmenashe@redhat.com>
+ */
+
+/*\
+ * Check that futex(FUTEX_CMP_REQUEUE) returns EFAULT when uaddr or
+ * uaddr2 points to unmapped memory, or when uaddr points to memory
+ * without read permission (PROT_NONE).
+ *
+ * uaddr2 is only reached after *uaddr == val passes; both are
+ * FUTEX_INITIALIZER so the comparison succeeds.
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
