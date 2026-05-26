Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4416BCD5BB1
	for <ltp@archiver.kernel.org>; Tue, 26 May 2026 15:27:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=lists.linux.it;
 i=@lists.linux.it; q=dns/txt; s=picard; t=1779809248; h=to : date :
 message-id : in-reply-to : references : mime-version : subject :
 list-id : list-unsubscribe : list-archive : list-post : list-help :
 list-subscribe : from : reply-to : content-type :
 content-transfer-encoding : sender : from;
 bh=pDxW/7J7s2x9Y9/nDYKVNa1HDpvak7czlNSp0fUlb7E=;
 b=nLKWiYTkFxKomeQ6v0gsI00r4Y45Uq4jBGak1gLlqpdJbbPS7nbNwTA8CMoUvVbhLzCyO
 WnZ/YzeuNsfrkwGcDeCFDI9ugEUVNa96eQAdSUoKXIHCnHB698BO9xL6AI+dE5ZUWZxtuBo
 B2Lan4cDeaZuroqE0g60/MIj3yPC4p0=
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id F0B683E62D1
	for <ltp@archiver.kernel.org>; Tue, 26 May 2026 17:27:27 +0200 (CEST)
Received: from in-4.smtp.seeweb.it (in-4.smtp.seeweb.it [217.194.8.4])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 663B43E62C5
 for <ltp@lists.linux.it>; Tue, 26 May 2026 17:26:27 +0200 (CEST)
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.129.124])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-4.smtp.seeweb.it (Postfix) with ESMTPS id 9E0CB100054D
 for <ltp@lists.linux.it>; Tue, 26 May 2026 17:26:26 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1779809185;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=+lMmNuA9eRCpk+tVDd4VKqSdMEd6Z8Q2DAUFYHo+AT4=;
 b=B/+CW20RPoUqsm5Y16g+yZJx92B8E/s2KVr0yLKLKuI/5A1gxMacw4LVl9QsYWKwVDWS/b
 eFE+gVXnH26n2vodhfUZ0kXIqDcIvLk+8Ml1LczK4d/pYf9brTvQxwIeZ7zvhrpWGRsoZF
 95stAttbp86pPa2wbju6dQKW9YQ+eeE=
Received: from mail-wm1-f69.google.com (mail-wm1-f69.google.com
 [209.85.128.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-269-YFV3fLSdPh-woppOQbk3Rg-1; Tue, 26 May 2026 11:26:22 -0400
X-MC-Unique: YFV3fLSdPh-woppOQbk3Rg-1
X-Mimecast-MFC-AGG-ID: YFV3fLSdPh-woppOQbk3Rg_1779809181
Received: by mail-wm1-f69.google.com with SMTP id
 5b1f17b1804b1-49045f93baeso31177905e9.1
 for <ltp@lists.linux.it>; Tue, 26 May 2026 08:26:21 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1779809181; x=1780413981;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=+lMmNuA9eRCpk+tVDd4VKqSdMEd6Z8Q2DAUFYHo+AT4=;
 b=LYzMdoyYbY7OjPCYdXOKUuK+tRuYkZuoXCZpcJ1awUNP62geBODIvPTdizRW4snWiK
 Vum0j7Qf3azOztemPmBbgelalfQCVcbaUnCW2miZKZud6ncAZTEyJCLo8NnbkIfTz3eB
 Yiwcn51+eki4Fpwxm7CIEBXUy8CPuZiT9YhvWKA9h41CQ2d+WFEzsNkuooOkd1ziWX5d
 UhA9b9Niiy9YfjG6r8MGLnH9MDPRXuV08q3Su9rt06IK+JMm4y+gh0/y0pP/sn6Dy2wt
 vuMg545EoTb1X6Dhlh8Z0lnsubvQUFRcYMhakPWgy6qtAXiyQkElFcOm2fBBvL5B+5Fj
 PXCA==
X-Gm-Message-State: AOJu0YxaAVfGu5KkqsuJONVUhpBdqOVJ8ngu4sVHHRlcFknYHWXKFlax
 ibfW78imLAHWhEl4CJNCmy+VW21BqdGVCQNtHNjkjbJCYOj2l8ipXFWnTtBJnhVLYPO/MtowwmE
 TIltd0yrYREmNIWgkIYwKAsyMpmxHQwVWZQ8ZTr6MHYAlNmGKfpbt8BwiGMzChIy63ykW+wYeH0
 xuivY43KRfwL/Ufk93tEOWM2VNbB/4rxPfoO28
X-Gm-Gg: Acq92OEcr4exMoza6s7KV1QRj1v84jwErmd5l+tbJiPl3WVpxRwhZsPwNXjvqG4grEj
 srKcYA6m7bZYgFKI90abMsP+YmvyG3791PxP7+34MJc45udqgcFn3OGe1ACULJ2WN6eiU97azwr
 E5rekMDDUAErXlZOLqVJsWP7OKPzZWATQxc5f+dB8vVKFmkQnhmKCr1uCZ4bZcsrYt+QYNTRxza
 0RxsWUqxpCpZk7N/zqfUBS01J4VxnBhzR3lE3O8sIMVKBXuR3Dbj7aqVpeb8Lh30DfuzXm+H/p3
 X9aEhbfVNtVTQrexDpEV78HEAsS6+sWfMnZnwy/CsTsy6q71yU3+to9XNVAszArzidjxDET7ZsE
 dUPSIWgsW4QJsKfqhTFXqdsJFS6owmMAYlqZSM8Ol5lD6enIlFrLrHP2O147YwQ==
X-Received: by 2002:a05:600c:a402:b0:48a:5546:61a1 with SMTP id
 5b1f17b1804b1-490426b4da5mr262924825e9.15.1779809180610; 
 Tue, 26 May 2026 08:26:20 -0700 (PDT)
X-Received: by 2002:a05:600c:a402:b0:48a:5546:61a1 with SMTP id
 5b1f17b1804b1-490426b4da5mr262924285e9.15.1779809180171; 
 Tue, 26 May 2026 08:26:20 -0700 (PDT)
Received: from fedora.redhat.com (89-138-3-119.bb.netvision.net.il.
 [89.138.3.119]) by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-4904561a160sm384735795e9.9.2026.05.26.08.26.19
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 26 May 2026 08:26:19 -0700 (PDT)
To: ltp@lists.linux.it
Date: Tue, 26 May 2026 18:26:12 +0300
Message-ID: <20260526152613.109485-4-mmenashe@redhat.com>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <20260526152613.109485-1-mmenashe@redhat.com>
References: <20260526152613.109485-1-mmenashe@redhat.com>
MIME-Version: 1.0
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: aNGRvZV3ZNeKsjBe42CrhgznUKrJZVsMaVWjGOgwh8Q_1779809181
X-Mimecast-Originator: redhat.com
X-Virus-Scanned: clamav-milter 1.0.9 at in-4.smtp.seeweb.it
X-Virus-Status: Clean
Subject: [LTP] [PATCH v11 3/4] futex_wake05: Add EFAULT error coverage test
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

futex(FUTEX_WAKE) has no existing test for EFAULT. Add coverage for
the cases where uaddr points to unmapped or PROT_NONE memory.

Signed-off-by: Michael Menasherov <mmenashe@redhat.com>
---
 runtest/syscalls                              |  1 +
 testcases/kernel/syscalls/futex/.gitignore    |  1 +
 .../kernel/syscalls/futex/futex_wake05.c      | 87 +++++++++++++++++++
 3 files changed, 89 insertions(+)
 create mode 100644 testcases/kernel/syscalls/futex/futex_wake05.c

diff --git a/runtest/syscalls b/runtest/syscalls
index e6c5d5112..8c4d9be6c 100644
--- a/runtest/syscalls
+++ b/runtest/syscalls
@@ -1877,6 +1877,7 @@ futex_wake01 futex_wake01
 futex_wake02 futex_wake02
 futex_wake03 futex_wake03
 futex_wake04 futex_wake04
+futex_wake05 futex_wake05
 futex_wait_bitset01 futex_wait_bitset01
 
 memfd_create01 memfd_create01
diff --git a/testcases/kernel/syscalls/futex/.gitignore b/testcases/kernel/syscalls/futex/.gitignore
index 74ac9a926..c11546e07 100644
--- a/testcases/kernel/syscalls/futex/.gitignore
+++ b/testcases/kernel/syscalls/futex/.gitignore
@@ -15,3 +15,4 @@
 /futex_waitv03
 /futex_wait06
 /futex_wait07
+/futex_wake05
diff --git a/testcases/kernel/syscalls/futex/futex_wake05.c b/testcases/kernel/syscalls/futex/futex_wake05.c
new file mode 100644
index 000000000..bcdf669d2
--- /dev/null
+++ b/testcases/kernel/syscalls/futex/futex_wake05.c
@@ -0,0 +1,87 @@
+// SPDX-License-Identifier: GPL-2.0-or-later
+/*
+ * Copyright (C) 2026 Red Hat, Inc. Michael Menasherov <mmenashe@redhat.com>
+ */
+
+/*\
+ * Check that futex(FUTEX_WAKE) returns EFAULT when uaddr points to
+ * unmapped or PROT_NONE memory.
+ *
+ * The test uses opflags=0 (no FUTEX_PRIVATE_FLAG), so futex_wake() takes
+ * the shared-futex path in get_futex_key() which must resolve the physical
+ * page. For PROT_NONE memory this page lookup fails with EFAULT, even though
+ * futex_wake() never reads *uaddr.
+ */
+
+#include <errno.h>
+#include <sys/mman.h>
+#include "futextest.h"
+
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
+	futex_t **addr;
+	int exp_errno;
+} testcases[] = {
+	{
+		.desc = "uaddr unmapped",
+		.addr = &unmapped_addr,
+		.exp_errno = EFAULT,
+	},
+	{
+		.desc = "uaddr PROT_NONE",
+		.addr = &prot_none_addr,
+		.exp_errno = EFAULT,
+	},
+};
+
+static void run(unsigned int n)
+{
+	struct futex_test_variants *tv = &variants[tst_variant];
+	struct testcase *tc = &testcases[n];
+
+	TST_EXP_FAIL(futex_wake(tv->fntype, *tc->addr, 1, 0),
+		     tc->exp_errno, "%s", tc->desc);
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
