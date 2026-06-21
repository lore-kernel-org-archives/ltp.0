Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8AF1BCD98F2
	for <ltp@archiver.kernel.org>; Sun, 21 Jun 2026 15:11:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=lists.linux.it;
 i=@lists.linux.it; q=dns/txt; s=picard; t=1782054663; h=to : date :
 message-id : in-reply-to : references : mime-version : subject :
 list-id : list-unsubscribe : list-archive : list-post : list-help :
 list-subscribe : from : reply-to : content-type :
 content-transfer-encoding : sender : from;
 bh=zE5l96fTg2Mwv+ofXlh8Vfh8XQeBQv3zG0GrTS0Oxqg=;
 b=j4OkG1wr+ztt3C9jFm8UB6lCZ8t3IhT28LBwxnRihGDGbfe6KE6RSW0fMZaHGVVkJtBSj
 yH0K8YEuRdNJ5TLK1y7ZL/G2Xpvmwmpu53AF+71GDwG01TPitGYUjpfO4IiEbxppNpJeWBR
 YfzJSl80dK/I8Dtnt89BXMTa2bIsx9g=
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id B2DF43E5542
	for <ltp@archiver.kernel.org>; Sun, 21 Jun 2026 17:11:03 +0200 (CEST)
Received: from in-5.smtp.seeweb.it (in-5.smtp.seeweb.it [217.194.8.5])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 9770C3E2F58
 for <ltp@lists.linux.it>; Sun, 21 Jun 2026 17:10:05 +0200 (CEST)
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.129.124])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-5.smtp.seeweb.it (Postfix) with ESMTPS id D4C7260057C
 for <ltp@lists.linux.it>; Sun, 21 Jun 2026 17:10:01 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1782054600;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=Jt6i0qdqkmuGl7HrIvmsDuepXV3AG2PS3+Gn8SqQhBI=;
 b=ITUPA4yqg0DZoApYb85jiGYK+9A79MJ3z3HcCCgXs7At5FYh1P+f97AWN7MuG2HQlFRZwd
 AWwUbLuLqkJcctjns580ld2pdTW/QvwOzsdbHbrIpR5PbYBGwb4AQ1X+D5TayVAJirQrYs
 XIk/aGXzf820CaI+ocqbELt4nFjp7Oo=
Received: from mail-wm1-f71.google.com (mail-wm1-f71.google.com
 [209.85.128.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-695-Vw12BYcLOkewAUTNIWfxVA-1; Sun, 21 Jun 2026 11:09:58 -0400
X-MC-Unique: Vw12BYcLOkewAUTNIWfxVA-1
X-Mimecast-MFC-AGG-ID: Vw12BYcLOkewAUTNIWfxVA_1782054597
Received: by mail-wm1-f71.google.com with SMTP id
 5b1f17b1804b1-49245e10b73so10209165e9.3
 for <ltp@lists.linux.it>; Sun, 21 Jun 2026 08:09:58 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1782054597; x=1782659397;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=Jt6i0qdqkmuGl7HrIvmsDuepXV3AG2PS3+Gn8SqQhBI=;
 b=iAK93sDeTNKzeX28X6GobTPJ7xJmvv6t6w4R92QJqTNklMsUyF1cLeRZAz2/aTZqSC
 DodlguxwcU4/LaUWU8/Xc6V0VdluXehAtXoJw1So8GasvquM6v2FYJ+1A/1tSdoczRvQ
 E84I6Gzy5U/x6owj0d/7jqvYGwL0gSV19/Qs+sMxXucwHGZcN6lbAXASmMl+pN+VUni5
 L0asVPVTVS6f9lN4WNVuek4wTl4lUr3voJk80WK938lRkPO7qmrg8bAU1nzn6uDT2ZvP
 Samf09YhYizZQ159BJ4MaIhO9GjwJbd53mGA6z/9Mlx2lyDroPXIysHl0oph2Jq28hLH
 4pMg==
X-Gm-Message-State: AOJu0YwFcLZwO63bFZhdzH+iXRNeQTl8FwOKwvjRmxuYKs7E9m+inXEt
 g1Z06TZgLumZs60ssTcNsszaxMbEX9JKTbsSOckBZuDQB0QcA7a6lvWhbkqucFqq6jG2/RGoXWZ
 2J7bJ83kC2lDo69dS8tfui6Nlf+76kYERNTbY7HDo9vVI7v6PmXcetvPh1DoZvv1P/TRPZHjsoA
 BnViG04BtH365lIYOiQHQj0rZqP9Rqb/BZAwNw
X-Gm-Gg: AfdE7cl/kJZiKKMD0p/31zI9RYtp35BIOLD5GOFaxMaE+MB08FvcH7u66ryRGNvJOPc
 ih0vam50W2T2390oQy8Y/p6m8CdhNkxNG/FCGhV0Yvft9R9p/B+9JZqWQdqBFeWtAZd8ie03Zum
 KmtRI/HWl/THQG+ubG8pRcxPDhWg3IaGsWBXtjX/X+gpYCB3keZ/7u+ml23dhnVMsyHeQrFm1eC
 WwYV6AJ78/uhcLgR1GUHOco5tixZZnzqoGqrwMxoQEuUls+HI1yJMdW7kAeIEaxQocYtieVohPz
 wKZ7c2SlSNnuYs3vx0Lw4TkcwInnnImmUhMJjfr0szzVvjjzxOa/LK/BSpQnv/ekLWtqiy+S95u
 hc01AWTgtIJJwVWJ+zdWKTv+M32QNr5/+ZqS+m6Ku+CrQYPpnAmp+1b6OXQ==
X-Received: by 2002:a05:600c:3e15:b0:492:30f2:963a with SMTP id
 5b1f17b1804b1-49242189520mr152346955e9.0.1782054597380; 
 Sun, 21 Jun 2026 08:09:57 -0700 (PDT)
X-Received: by 2002:a05:600c:3e15:b0:492:30f2:963a with SMTP id
 5b1f17b1804b1-49242189520mr152346485e9.0.1782054596932; 
 Sun, 21 Jun 2026 08:09:56 -0700 (PDT)
Received: from fedora.redhat.com (85.64.227.60.dynamic.barak-online.net.
 [85.64.227.60]) by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-46666788302sm15380926f8f.20.2026.06.21.08.09.56
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sun, 21 Jun 2026 08:09:56 -0700 (PDT)
To: ltp@lists.linux.it
Date: Sun, 21 Jun 2026 18:09:51 +0300
Message-ID: <20260621150951.66407-3-mmenashe@redhat.com>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <20260621150951.66407-1-mmenashe@redhat.com>
References: <20260621150951.66407-1-mmenashe@redhat.com>
MIME-Version: 1.0
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: 32PIfpjpsE05m9JOSUyjJd85sWikuhe2RCBykj8mMII_1782054597
X-Mimecast-Originator: redhat.com
X-Virus-Scanned: clamav-milter 1.0.9 at in-5.smtp.seeweb.it
X-Virus-Status: Clean
Subject: [LTP] [PATCH v16 2/2] futex_cmp_requeue03: Add EFAULT error
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
 .../syscalls/futex/futex_cmp_requeue03.c      | 108 ++++++++++++++++++
 3 files changed, 110 insertions(+)
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
index 000000000..c71c8f4cb
--- /dev/null
+++ b/testcases/kernel/syscalls/futex/futex_cmp_requeue03.c
@@ -0,0 +1,108 @@
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
+	{
+		.desc = "uaddr2 PROT_NONE",
+		.uaddr = &futex_ptr,
+		.uaddr2 = &prot_none_addr,
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
