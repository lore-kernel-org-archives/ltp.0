Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D520BCD4F54
	for <ltp@archiver.kernel.org>; Wed, 20 May 2026 07:45:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=lists.linux.it;
 i=@lists.linux.it; q=dns/txt; s=picard; t=1779263156; h=to : date :
 message-id : in-reply-to : references : mime-version : subject :
 list-id : list-unsubscribe : list-archive : list-post : list-help :
 list-subscribe : from : reply-to : content-type :
 content-transfer-encoding : sender : from;
 bh=ZDAVbgI/gRy5pDSjCY4FqjthboxAf2Yf2SZZ8bM5wxI=;
 b=RSmcCr7Rwq6+s/a4bHO9Oicee8GefwTw9+Wug4JmKNG6mCKxTXSs578b8X0ktEHVpfKo6
 XZ4xbQ/mJhbMtSMdq89gvhyDbPk6IrcZCUJGCvcMQUBTUbxLHbw8s6yRW2zJ43lpgPrEFZh
 qRszFuEXmWkVRzjb/dr7a6t+lQmngEQ=
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id E237D3C72D9
	for <ltp@archiver.kernel.org>; Wed, 20 May 2026 09:45:56 +0200 (CEST)
Received: from in-7.smtp.seeweb.it (in-7.smtp.seeweb.it [217.194.8.7])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 8EF313C72E2
 for <ltp@lists.linux.it>; Wed, 20 May 2026 09:44:43 +0200 (CEST)
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.129.124])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-7.smtp.seeweb.it (Postfix) with ESMTPS id A3B8F2009BC
 for <ltp@lists.linux.it>; Wed, 20 May 2026 09:44:42 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1779263081;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=ZUPEmUKD75xsoyaTPA9BWbbC+zAZDM+0xXCG2s7ymDE=;
 b=DavFUIYGtMUxnRFHPeqELLk7+Jqz6zcW0bdC5ZBHgep9khXqky3QOWr9KDbMAoVAat33tW
 eHNIfG5Il8KSg9vFrfSwaeibfXGaPPjna4PDcAATWSPnwQR5JxGluyZAiS6bHfIkAhYyJo
 exzaCQDr9TBN0bvyA1T1McwwN4U4Iz8=
Received: from mail-wr1-f72.google.com (mail-wr1-f72.google.com
 [209.85.221.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-357-hLXv4i5nMqeMFDkx6lB3nQ-1; Wed, 20 May 2026 03:44:39 -0400
X-MC-Unique: hLXv4i5nMqeMFDkx6lB3nQ-1
X-Mimecast-MFC-AGG-ID: hLXv4i5nMqeMFDkx6lB3nQ_1779263078
Received: by mail-wr1-f72.google.com with SMTP id
 ffacd0b85a97d-44cc3c9b2feso4338651f8f.1
 for <ltp@lists.linux.it>; Wed, 20 May 2026 00:44:39 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1779263078; x=1779867878;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=ZUPEmUKD75xsoyaTPA9BWbbC+zAZDM+0xXCG2s7ymDE=;
 b=Q2vArUtzautgC/lXTQAIk387IQZp4oKLJrcU6q2WJuSqxY7s/VWbtxtanf5t2QZlYL
 uFhhDONSYa1IdtF0/a2e15/Ld7kZzaxizmYi7B/wu3wrASsoSOQ4RTwvnZTVpU5+ciPu
 D1JV3v1aup86MGxzHLNuCvIzQiMEEDFcWBTWslkGpnaMU8W9eTQU9pSNOLhO+KM+isHI
 027+jM5htkc7z06ujbIhEHZbxqcUU9haxVQxvCus3gdTRF2BvZ7yB+pnOBqiy1MJ9GlL
 T4D0PUx1ZdrB/rRYuRtiSoXZAVOiwLlIOmnQ44hnQ8O7Fw+emw7n0W+3ROkM4fKN9yLM
 zXnQ==
X-Gm-Message-State: AOJu0Yz9ti4V1V3lnDCEXlfgXAUskBveb2vWlrWIJWIwjzV+zWg491IR
 SZleewMl0CBEqsI68eSoObnwHCcJ+BjkIpwMhuA+9E93bVM6UdyH09PsvXWrXWNPflAYahVSOys
 hl+N3JtZmSQA741/CCMlGDPa/0ExXHjhd/MW5N463k/DIFbr06xlv8yfldAEXNlr0TxijgMbwk2
 daZmQVAcPFrsTsVKrePnINDA7xYEYZ7SJxN0te
X-Gm-Gg: Acq92OG4gmxwkGV9orzPrH/18Cj5sYxSreNeXoBi+lLh1KkiMjyNJ69XEV+78KSktD9
 HwQZM3k9S1xLMJ2fWCZSYx0iXUJpUs7Z0YEbAst8it+bRQvRDQilAIah7UuKIpF4awd4jfeo5Xp
 EEiqZ+VTOCMOXHsvZgq1jcttPmPjKA6cdzBFukWRUu5/hcnI+ZRxcqs7SPgVyxLQdMiViOc4ZAb
 Cp8GyM/IcBVcpk6+3F3N0Ncgh+/v69WgH4x+Fnc2MyFOGN2xY2QrZdPnvRqBtc8lRqMTP+p2yWj
 QeUABG0H3ASnIdPi4qjalPfBWFF1qQ0xufqmb3Kg+oTEPdH9t2IObqHenblvYmoM3dXJsO8dEW8
 +/nRjFL2GGJFqT4c6Q14+CGtMEnfs2Jk=
X-Received: by 2002:a05:600c:8905:b0:48e:5d91:cffb with SMTP id
 5b1f17b1804b1-48fe60e7d6emr293494785e9.10.1779263077833; 
 Wed, 20 May 2026 00:44:37 -0700 (PDT)
X-Received: by 2002:a05:600c:8905:b0:48e:5d91:cffb with SMTP id
 5b1f17b1804b1-48fe60e7d6emr293494365e9.10.1779263077445; 
 Wed, 20 May 2026 00:44:37 -0700 (PDT)
Received: from fedora.tlv.redhat.com ([5.28.174.82])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-48feb8d838dsm127721625e9.1.2026.05.20.00.44.36
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 20 May 2026 00:44:36 -0700 (PDT)
To: ltp@lists.linux.it
Date: Wed, 20 May 2026 10:44:27 +0300
Message-ID: <20260520074427.39155-5-mmenashe@redhat.com>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <20260520074427.39155-1-mmenashe@redhat.com>
References: <20260520074427.39155-1-mmenashe@redhat.com>
MIME-Version: 1.0
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: I_R4BtuGtN3MbG6mHgqiZ9x69ZpKMmJVElohEriHhlg_1779263078
X-Mimecast-Originator: redhat.com
X-Virus-Scanned: clamav-milter 1.0.9 at in-7.smtp.seeweb.it
X-Virus-Status: Clean
Subject: [LTP] [PATCH v6 4/4] futex_cmp_requeue03: Add EFAULT error coverage
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
 .../syscalls/futex/futex_cmp_requeue03.c      | 98 +++++++++++++++++++
 3 files changed, 100 insertions(+)
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
index 000000000..f3c9ae1b9
--- /dev/null
+++ b/testcases/kernel/syscalls/futex/futex_cmp_requeue03.c
@@ -0,0 +1,98 @@
+// SPDX-License-Identifier: GPL-2.0-or-later
+/*
+ * Copyright (C) 2026 Red Hat, Inc.
+ */
+
+/*\
+ * Check that futex(FUTEX_CMP_REQUEUE) returns EFAULT when uaddr or
+ * uaddr2 points to unmapped memory, or EACCES (EFAULT on kernels < 5.9)
+ * when uaddr points to PROT_NONE memory.
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
