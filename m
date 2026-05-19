Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E88C7CD4F3C
	for <ltp@archiver.kernel.org>; Tue, 19 May 2026 18:32:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=lists.linux.it;
 i=@lists.linux.it; q=dns/txt; s=picard; t=1779215564; h=to : date :
 message-id : in-reply-to : references : mime-version : subject :
 list-id : list-unsubscribe : list-archive : list-post : list-help :
 list-subscribe : from : reply-to : content-type :
 content-transfer-encoding : sender : from;
 bh=Do1Qf0jIo8GQVfEFjRWTTH/aaHoWiv68yMssiXMEtRY=;
 b=LaJ1WsDB3kNCVTbsNvHO5Gk6MKD98JvxZz3PSELOaGe9xQqZubIuNYKLUiv5IhNFGpHU2
 EjB4xNCGJNbZIZSjaa9Q/rRd1H13Bx5yEpXVAYqlHK+lF2DfpYPkQhFV8XbiboZkruaPLCn
 6PEQzXLOc9sgOLdk17zzfGl0Y8k0bPA=
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 96A123C71E0
	for <ltp@archiver.kernel.org>; Tue, 19 May 2026 20:32:44 +0200 (CEST)
Received: from in-4.smtp.seeweb.it (in-4.smtp.seeweb.it
 [IPv6:2001:4b78:1:20::4])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 6A56A3C719C
 for <ltp@lists.linux.it>; Tue, 19 May 2026 20:30:54 +0200 (CEST)
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.129.124])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-4.smtp.seeweb.it (Postfix) with ESMTPS id EBF85100044F
 for <ltp@lists.linux.it>; Tue, 19 May 2026 20:30:53 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1779215452;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=xTbMkHCKZG4QvjGcnckhNgr16fg0d4weksQsNP05kMk=;
 b=cZurGzEC4iPC4Po76Q7q1FkeXCZO83nj32C5ucR27xLQ4AYDDZF/MI9/NyQI+bZQA1Z5lq
 AEUW1EI7ldM2kHaLh/k+tVky3muMFA7bvQ4yX+giAETk3E/40oFgBH86nzpaUts/iPUzOw
 VKPQ1So/A7t+TuQLhVyOGKkbcGYP2OU=
Received: from mail-wm1-f70.google.com (mail-wm1-f70.google.com
 [209.85.128.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-591-TPyO0PzyOqqQOenteq6Wqg-1; Tue, 19 May 2026 14:30:50 -0400
X-MC-Unique: TPyO0PzyOqqQOenteq6Wqg-1
X-Mimecast-MFC-AGG-ID: TPyO0PzyOqqQOenteq6Wqg_1779215449
Received: by mail-wm1-f70.google.com with SMTP id
 5b1f17b1804b1-48fd396daedso25211255e9.0
 for <ltp@lists.linux.it>; Tue, 19 May 2026 11:30:50 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1779215449; x=1779820249;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=xTbMkHCKZG4QvjGcnckhNgr16fg0d4weksQsNP05kMk=;
 b=h1BKn2Q2HMtECxPiATSre5D6aPQ95WirYMzWWWyWcaRiXIrbKrRcoQ5UBx7cZLLc/y
 ECBgoeAB5FQ+vPIqv7VY+nbt3/RBgOdcrKKEM3MJRGXDhGRbV4Y+jHTPrsIA6r9lVo//
 gnUIUkclTmduzzFkt7cNGdZQbGJ6UbDD/n1hi4HlHIq5tx9hIn3eZ9dkmwDiXvEMRkRl
 veUh688hsL7t7jVInPWpi7zWb8bdp6Vx2H5lIXVp5+71EwHv7ZrK0bBchwXstzG55bXC
 3ePtjVVxUR/3oiT83m4iqh4doSx6Ognmokdjgt5hHbyL7P9uJlcc/HyTOOM52t3sMW9V
 Tw9Q==
X-Gm-Message-State: AOJu0Yw+xATnjrSgdbH8Cgxk6AtyfKyjHYA2McHOjLhjzl8Ei1Oa0vCM
 hXzkMEBNDeIrI2UM9Y7oQucaxPQyxu54XBy/ltcRzbmNvAjjx8DPFG6ttRlmv/QZZlP81P+Wqqp
 W6XqITVz98J9DI4qLdzzJ5bD0o/0ppJG8Javy+waAEbJsCOhHCNddHpqLBnj76VIHor3YcVJyHk
 vCahAEDDV1vFh/xn4+knjidrpRh2EB2N11TOk6
X-Gm-Gg: Acq92OEtEIs5djEAGx4o8VcRe02AjDAcIyCS7dGBzHOUK/WxKqzvem/oqYY7sBymhGX
 0Uxw1TIXM45KkBo9FD82e15py63soMHQwcSTkmChCeBXBt5/RmYrTV5KMFw4PElAUVCd0b+bT9j
 wi6pZCyrcI1kwVSpoPSnkNA1Q3IxX6HU860sP7PlNW4UwXNn5dXTrDRdmNrSfKjIRuVbpIfm4Nu
 IvsFIzGz0ekIvsTlMFXzRufSTnZ26oiL0DsDXM05j2zt+VA622tC4Byxs8BspP1U0cLEaHAj+7S
 mo/bL8tVMtKnXbzfHntx8eD5JSxDfFLMRmdl5y9mk/lm7/EgPxzw7zEgN0RYg4/9O0Mjhuxh600
 zEis5qRm+MYuEK/HzZ/lWqsYBAzUSDQi1Fstwt9uEefdh3JqW8DUeLec7d99Avgqo
X-Received: by 2002:a05:600c:8b45:b0:489:1ba8:5bf0 with SMTP id
 5b1f17b1804b1-48fe63253f3mr310322745e9.21.1779215449474; 
 Tue, 19 May 2026 11:30:49 -0700 (PDT)
X-Received: by 2002:a05:600c:8b45:b0:489:1ba8:5bf0 with SMTP id
 5b1f17b1804b1-48fe63253f3mr310322395e9.21.1779215449069; 
 Tue, 19 May 2026 11:30:49 -0700 (PDT)
Received: from fedora.redhat.com (89-139-213-92.bb.netvision.net.il.
 [89.139.213.92]) by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-45da0a19a0csm45128468f8f.20.2026.05.19.11.30.47
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 19 May 2026 11:30:48 -0700 (PDT)
To: ltp@lists.linux.it
Date: Tue, 19 May 2026 21:30:31 +0300
Message-ID: <20260519183031.114591-5-mmenashe@redhat.com>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <20260519183031.114591-1-mmenashe@redhat.com>
References: <20260519183031.114591-1-mmenashe@redhat.com>
MIME-Version: 1.0
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: HzwQKV3dGhNtXEXx7FAocfvqrAuctHczHWf9E1Hnv90_1779215449
X-Mimecast-Originator: redhat.com
X-Virus-Scanned: clamav-milter 1.0.9 at in-4.smtp.seeweb.it
X-Virus-Status: Clean
Subject: [LTP] [PATCH v5 4/4] futex_cmp_requeue03: Add EFAULT error coverage
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
 runtest/syscalls                              |   1 +
 testcases/kernel/syscalls/futex/.gitignore    |   1 +
 .../syscalls/futex/futex_cmp_requeue03.c      | 100 ++++++++++++++++++
 3 files changed, 102 insertions(+)
 create mode 100644 testcases/kernel/syscalls/futex/futex_cmp_requeue03.c

diff --git a/runtest/syscalls b/runtest/syscalls
index 92e01452e..3a516d538 100644
--- a/runtest/syscalls
+++ b/runtest/syscalls
@@ -1910,3 +1910,4 @@ perf_event_open03 perf_event_open03
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
index 000000000..626fd4bed
--- /dev/null
+++ b/testcases/kernel/syscalls/futex/futex_cmp_requeue03.c
@@ -0,0 +1,100 @@
+// SPDX-License-Identifier: GPL-2.0-or-later
+/*
+ * Copyright (C) 2026 Red Hat, Inc.
+ */
+
+/*\
+ * Check that futex(FUTEX_CMP_REQUEUE) returns EFAULT when uaddr or
+ * uaddr2 points to unmapped memory, or when uaddr points to memory
+ * without read permission (PROT_NONE).
+ *
+ * The EACCES behavior for PROT_NONE was introduced in kernel 5.9.
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
+		.exp_errno = EACCES,
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
+
+	if (tst_kvercmp(5, 9, 0) < 0)
+		testcases[2].exp_errno = EFAULT;
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
