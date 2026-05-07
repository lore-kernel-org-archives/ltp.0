Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8B688CD3427
	for <ltp@archiver.kernel.org>; Thu,  7 May 2026 11:20:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=lists.linux.it;
 i=@lists.linux.it; q=dns/txt; s=picard; t=1778152819; h=to : date :
 message-id : in-reply-to : references : mime-version : subject :
 list-id : list-unsubscribe : list-archive : list-post : list-help :
 list-subscribe : from : reply-to : content-type :
 content-transfer-encoding : sender : from;
 bh=Q+7Gn417XpQ23Hl6FbUz//4gO/C1pNY8QgMJ3QH6G6g=;
 b=ThrYy8jazKpU+HBN4T75E3ydA1U/R/nJpEyoH+yORyK0YCmC5h4WuHgGgHhk+yAcOkmhE
 fC4BRPYpNFoba6WKpyeZcAn6z36xSOpnlwWxDO7JjYNuC8aP3Xp8fSshegwT3tY+ZuLI2Ge
 jnb4fAl6hvzkz1Fx/FEykI6AgtGrtBE=
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 4291D3E5F59
	for <ltp@archiver.kernel.org>; Thu,  7 May 2026 13:20:19 +0200 (CEST)
Received: from in-2.smtp.seeweb.it (in-2.smtp.seeweb.it [217.194.8.2])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 387473E2C3A
 for <ltp@lists.linux.it>; Thu,  7 May 2026 13:18:25 +0200 (CEST)
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.133.124])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-2.smtp.seeweb.it (Postfix) with ESMTPS id 7FB916003BE
 for <ltp@lists.linux.it>; Thu,  7 May 2026 13:18:24 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1778152703;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=eHBqIgy/mYybB9jOyH8Z9pAqtx9EeDqkLT5ySLDvnRE=;
 b=SoqXoqWz3CoNrJPbfnKN0EAa/9+tyWKJclqP6LGa5qYPnQ50udmZYaIA6bhEsIyqC08DOp
 /0oGlcx5Vmv4hNutP5ZbNXElvLnjQkTP/KG9qN76N2xAJ746S1ozKuDeN8Z7wZqUhC0uOy
 xH8aHXTnSfCW81iSH8NGSE+aa3bKOz0=
Received: from mail-wm1-f71.google.com (mail-wm1-f71.google.com
 [209.85.128.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-676-i6Kwk-CVOb6Y7y8F0cEJ7g-1; Thu, 07 May 2026 07:18:22 -0400
X-MC-Unique: i6Kwk-CVOb6Y7y8F0cEJ7g-1
X-Mimecast-MFC-AGG-ID: i6Kwk-CVOb6Y7y8F0cEJ7g_1778152701
Received: by mail-wm1-f71.google.com with SMTP id
 5b1f17b1804b1-48d0889c1ecso5168985e9.0
 for <ltp@lists.linux.it>; Thu, 07 May 2026 04:18:21 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1778152700; x=1778757500;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=eHBqIgy/mYybB9jOyH8Z9pAqtx9EeDqkLT5ySLDvnRE=;
 b=FMcC/FuKfECPos60nPKM2O91baEmcXA6CHQV7PGw9uGG2x6PWNT50OLJ6tzcKBS67I
 lLjWuEz0QceMrmO6XcYOp3sUIqCYGMDe8y08qmLEf0k/BwQuc1pqDF7HmR7BygQurvMz
 fIFvbdAovYeeQba0TfmhnABVtlupOELPUhJWlH4s12PazM3D82qBLbwWgyjX7xEOjeyJ
 Xst/4Q6jwyeiw2SBPN5iOZkXJIlneliW5ha4kDE85MMGmmdr+muLJofK6caIZnmArdLm
 Gy6f2kLbYwmWOY+SOMPt3uudHyT08X0FsEIwyFMSHVrzrEUBWC97GcrTnrUOP7Tq659r
 u3ew==
X-Gm-Message-State: AOJu0YxTYlkds/9MEA5eS7XmojIdlz9/Y4x/SyHotydnMTTIEJOPGgB/
 8ZrdhVw/FITfmJzFufXwsm3gFOwF4B+CnVkwo+17vmZIto0VAMPm+LMKYMOP9Dx7cfYR32lck8s
 VSj5MxYFhIMnNpGH8EX2dNJ/bIInJz/p0+2ORxtIoydTc+kWR96ACiAEQMiz7Qqcwz98DT8F34X
 zz8HCvE8Xq7jZzjIeMg+xainPKynEjFz/pNcEz
X-Gm-Gg: AeBDietwcRDKrYdgF9ez2tdnO7/KWmCDASWFiWCJzYMndUli3Em5Oj7a3dNmQZ4QRuR
 GCQhJO5zYeN10TlKa/8Wz7w0ACrrWoLASQ+yDgHs8kL7KxP+TrM3DST2LI/B/v/fZVNRzbLg7g4
 qQaPzANydpeWtprw4B6AuBZtsUyzwvETqI61Q8HWs0Q8sIacclmjLmca6wbhDwEw0V/RqnJ3pj9
 kW739WhFeoZd6kvjHrHO/UCoBF2n/GYMGdO/v79ayhwxd/qz2jG/qOuSsxIuN+CcinhWhEArsWM
 DXpchk2GZHwKRQfdNULvLBcKF0PBYE7N4W7hcgsNZe2yQJewlyLBHbFMvwaLDCutPhUMxSCgEa5
 xnB+GQ2GUVkBriNWU7p5H/HVYiVynsNAzAgWWKRm795KI1q6qRH2+dJ+/aqzGNMwGWHyffrPCIF
 mFBr1fiQ==
X-Received: by 2002:a05:600c:5291:b0:489:a4:e58a with SMTP id
 5b1f17b1804b1-48e51f3818fmr125878055e9.19.1778152700494; 
 Thu, 07 May 2026 04:18:20 -0700 (PDT)
X-Received: by 2002:a05:600c:5291:b0:489:a4:e58a with SMTP id
 5b1f17b1804b1-48e51f3818fmr125877555e9.19.1778152699912; 
 Thu, 07 May 2026 04:18:19 -0700 (PDT)
Received: from fedora.redhat.com (85.65.168.167.dynamic.barak-online.net.
 [85.65.168.167]) by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-48e530cf964sm74515835e9.1.2026.05.07.04.18.18
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 07 May 2026 04:18:18 -0700 (PDT)
To: ltp@lists.linux.it
Date: Thu,  7 May 2026 14:18:09 +0300
Message-ID: <20260507111809.28934-5-mmenashe@redhat.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260507111809.28934-1-mmenashe@redhat.com>
References: <20260507111809.28934-1-mmenashe@redhat.com>
MIME-Version: 1.0
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: toIxmJBpqTfkfEqegbBBZ26Slu4-geMqAx_gCYz7IjA_1778152701
X-Mimecast-Originator: redhat.com
X-Virus-Scanned: clamav-milter 1.0.9 at in-2.smtp.seeweb.it
X-Virus-Status: Clean
Subject: [LTP] [PATCH v4 4/4] futex_cmp_requeue03: Add EFAULT error coverage
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
 .../syscalls/futex/futex_cmp_requeue03.c      | 94 +++++++++++++++++++
 3 files changed, 96 insertions(+)
 create mode 100644 testcases/kernel/syscalls/futex/futex_cmp_requeue03.c

diff --git a/runtest/syscalls b/runtest/syscalls
index 4d85a1d26..65baa44dc 100644
--- a/runtest/syscalls
+++ b/runtest/syscalls
@@ -1908,3 +1908,4 @@ perf_event_open03 perf_event_open03
 futex_wait06 futex_wait06
 futex_wait07 futex_wait07
 futex_wake05 futex_wake05
+futex_cmp_requeue03 futex_cmp_requeue03
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
index 000000000..4c3c6e358
--- /dev/null
+++ b/testcases/kernel/syscalls/futex/futex_cmp_requeue03.c
@@ -0,0 +1,94 @@
+// SPDX-License-Identifier: GPL-2.0-or-later
+/*
+ * Copyright (C) 2026 Red Hat, Inc.
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
+	futex_t *uaddr;
+	futex_t *uaddr2;
+	int exp_errno;
+} testcases[3];
+
+static void run(unsigned int n)
+{
+	struct futex_test_variants *tv = &variants[tst_variant];
+	struct testcase *tc = &testcases[n];
+
+	TST_EXP_FAIL(futex_cmp_requeue(tv->fntype, tc->uaddr, futex_var,
+		tc->uaddr2, 1, 1, 0), tc->exp_errno, "%s", tc->desc);
+}
+
+static void setup(void)
+{
+	struct futex_test_variants *tv = &variants[tst_variant];
+	size_t pagesize = getpagesize();
+	futex_t *unmapped;
+
+	tst_res(TINFO, "Testing variant: %s", tv->desc);
+	futex_supported_by_kernel(tv->fntype);
+
+	unmapped = SAFE_MMAP(NULL, pagesize, PROT_READ | PROT_WRITE,
+		MAP_PRIVATE | MAP_ANONYMOUS, -1, 0);
+	SAFE_MUNMAP(unmapped, pagesize);
+
+	prot_none_addr = SAFE_MMAP(NULL, pagesize, PROT_NONE,
+		MAP_PRIVATE | MAP_ANONYMOUS, -1, 0);
+
+	testcases[0] = (struct testcase){
+		.desc = "uaddr unmapped",
+		.uaddr = unmapped,
+		.uaddr2 = &futex_var,
+		.exp_errno = EFAULT,
+	};
+	testcases[1] = (struct testcase){
+		.desc = "uaddr2 unmapped",
+		.uaddr = &futex_var,
+		.uaddr2 = unmapped,
+		.exp_errno = EFAULT,
+	};
+	testcases[2] = (struct testcase){
+		.desc = "uaddr PROT_NONE",
+		.uaddr = prot_none_addr,
+		.uaddr2 = &futex_var,
+		.exp_errno = EFAULT,
+	};
+}
+
+static void cleanup(void)
+{
+	if (prot_none_addr)
+		SAFE_MUNMAP(prot_none_addr, getpagesize());
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
2.53.0


-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
