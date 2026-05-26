Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 04051CD5BC8
	for <ltp@archiver.kernel.org>; Tue, 26 May 2026 19:06:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=lists.linux.it;
 i=@lists.linux.it; q=dns/txt; s=picard; t=1779822396; h=to : date :
 message-id : in-reply-to : references : mime-version : subject :
 list-id : list-unsubscribe : list-archive : list-post : list-help :
 list-subscribe : from : reply-to : content-type :
 content-transfer-encoding : sender : from;
 bh=xEAOwCFak1IA3WjzBDfO+wU/nqrMZ9ncmlW4ZwjdUY4=;
 b=kc3/2smaZVky5LmwYZsYGbOnZsUa1gmCZKSF6QBHsUkFhreo43Y3W3AJGGnUQz+Ymz0fN
 28RG0kBSmn6/7rOPXDePLlLgJYnF3TsUO32JQBUtDf2PCITdX7ybYIn6peAUC6A+EgNxfGb
 /zQEZKjcxzAGcTuru3fftdMQ7kOvA/I=
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id AE34A3C7080
	for <ltp@archiver.kernel.org>; Tue, 26 May 2026 21:06:36 +0200 (CEST)
Received: from in-2.smtp.seeweb.it (in-2.smtp.seeweb.it
 [IPv6:2001:4b78:1:20::2])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 6CDC43C1E1C
 for <ltp@lists.linux.it>; Tue, 26 May 2026 21:04:46 +0200 (CEST)
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.129.124])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-2.smtp.seeweb.it (Postfix) with ESMTPS id B9DAE600942
 for <ltp@lists.linux.it>; Tue, 26 May 2026 21:04:45 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1779822284;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=HKXAgI64hHJfRS/fLSPGxTPa2sEV5pqcCjZ8bzR/S1Y=;
 b=dzBRT+7ofPqWeQIEAaQ7glrGs5eUWHrdtqUY6rYVaizF52/sqaNMSUWUWEQKRkm/cUnfLB
 ZhAkorKs1XnLH+HjZCqK8OU1HHUl99MnAW1hF1owA8+OdnIqsbcHb82GtZCjHnXCqZW+b0
 j1wNI4KxPZftjawXAviS9Hbwz6reQcE=
Received: from mail-wr1-f70.google.com (mail-wr1-f70.google.com
 [209.85.221.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-281-WcSkG8KMNm-sHDsdSBxXiQ-1; Tue, 26 May 2026 15:04:42 -0400
X-MC-Unique: WcSkG8KMNm-sHDsdSBxXiQ-1
X-Mimecast-MFC-AGG-ID: WcSkG8KMNm-sHDsdSBxXiQ_1779822281
Received: by mail-wr1-f70.google.com with SMTP id
 ffacd0b85a97d-44a71109b94so7417514f8f.3
 for <ltp@lists.linux.it>; Tue, 26 May 2026 12:04:41 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1779822281; x=1780427081;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=HKXAgI64hHJfRS/fLSPGxTPa2sEV5pqcCjZ8bzR/S1Y=;
 b=sl40GfdALK6dYEAFyOK5blpsdp9TMyk01v8PY6ohibwg/byItHzb94K1gbVrOiwTB1
 ACt9scpWlqtxyDEXZMTTk15eV75PxWOR8ulGaFyBn8vaA0yAD0hhxQ5g0Dmn5yx25YKD
 CQpy5iMZnNPwBEmZ41oRNEBpbKXFmdAndRaitzHniZQOx5sZJC8fQzEeXUuFNkOQD7LZ
 Gx5PM5w+5XGMpZ5sl4S0pCcxscx9WCAUUJXt9vokavnu/iu9fj+Q3ib0nd6qOS/eyKbD
 ToWg7UK2VEQGhhSJwIJAMLTrlH4oRqgYaIkyx/x51cbXC7y0WIa49t5/HR8rYSgHXqDe
 7hGg==
X-Gm-Message-State: AOJu0YyedtNWC8H5BlctDDgkfDSQjysx7mGMQLloeYcJ97iyDHd2HXRC
 unyFqpxKiFkDeW/8zQ1c4UqSKj8o1YqJbfZB/wgvoATavypREM2i8LPlMx9EgehUumNRrbKXcQ/
 /9XrQoss0hUt5s+GU5gTpBoQYRiauc/Lx13dS8F4RaydwsyipiLfyG0ykFMaMHedl1kpgpvD86x
 xyAJCSCyaqvxjJIwQrFWDV9YQd3nnhOnjhdJ89
X-Gm-Gg: Acq92OF0XVfT/jSrA0XLM2kOAph5w4XSmr+8r9OunRe9cs4W1BilGGE/pR5tz1/kk/3
 Bb80QGMotf8xU1bRg57lnmXdjJlMz9cZX/dwdEi2oj21TOTjTsFLG2YJWAP9GECB5/3xOx2O9nt
 yImFp++78sKWK4joSXaVPuaWTAFE2Qm7p270DjmmOZg8kYVMAgLSCNWFmyITtbmnlV5yJpYszew
 C2DfbkfRz6iPAH/V1yecOjLjXe9DfOToFeHozU1AZHflHdhlwfKG1PrJmN4wttbLqcBn/kOScBG
 srE+R5g+W3SVU+iX9p9fR7O9aZckTj3BnWyrzqAtONF02uAi60D3Vf8W84d2ObuDWUnn9o+V+fK
 kTCs1QH2VPqkecWULP4fOmpjXe/k5Yg/QvT7Rb+/bYByKMhT59ZPBQp5v3QaYyfOghMkOrbtU
X-Received: by 2002:a05:600c:a402:b0:48e:6db3:ff3a with SMTP id
 5b1f17b1804b1-490426d079cmr234184295e9.16.1779822280560; 
 Tue, 26 May 2026 12:04:40 -0700 (PDT)
X-Received: by 2002:a05:600c:a402:b0:48e:6db3:ff3a with SMTP id
 5b1f17b1804b1-490426d079cmr234183905e9.16.1779822279872; 
 Tue, 26 May 2026 12:04:39 -0700 (PDT)
Received: from fedora.redhat.com (89-138-3-119.bb.netvision.net.il.
 [89.138.3.119]) by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-45edb5b1a28sm204398f8f.26.2026.05.26.12.04.38
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 26 May 2026 12:04:39 -0700 (PDT)
To: ltp@lists.linux.it
Date: Tue, 26 May 2026 22:04:30 +0300
Message-ID: <20260526190430.129798-5-mmenashe@redhat.com>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <20260526190430.129798-1-mmenashe@redhat.com>
References: <20260526190430.129798-1-mmenashe@redhat.com>
MIME-Version: 1.0
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: p3TPFJ0gnTfUXOt9yOcTBHR7l9OdRRU_C9qQtQMH8Os_1779822281
X-Mimecast-Originator: redhat.com
X-Virus-Scanned: clamav-milter 1.0.9 at in-2.smtp.seeweb.it
X-Virus-Status: Clean
Subject: [LTP] [PATCH v12 4/4] futex_cmp_requeue03: Add EFAULT error
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
 testcases/kernel/syscalls/futex/.gitignore    |  1 +
 .../syscalls/futex/futex_cmp_requeue03.c      | 99 +++++++++++++++++++
 2 files changed, 100 insertions(+)
 create mode 100644 testcases/kernel/syscalls/futex/futex_cmp_requeue03.c

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
index 000000000..28058ebc1
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
