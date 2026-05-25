Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7C5C1CD5BC9
	for <ltp@archiver.kernel.org>; Mon, 25 May 2026 14:46:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=lists.linux.it;
 i=@lists.linux.it; q=dns/txt; s=picard; t=1779720382; h=to : date :
 message-id : in-reply-to : references : mime-version : subject :
 list-id : list-unsubscribe : list-archive : list-post : list-help :
 list-subscribe : from : reply-to : content-type :
 content-transfer-encoding : sender : from;
 bh=jI4D2WwpBnktESbkdBL9L6oHtO6ESQJcBoR7riqH2yc=;
 b=VCUPfGTxVcp51+rskVNGwPTp0jN+zcmJs+g1/w1+nA07pN1zHIsKCtmB2y+qVLVKLxA00
 SF6KEW+ZOsXE5jHEq579QIYhA//7/O/oHDbS3h8cTOZd1KWNRoA+Gy0WHRflNrZg4ul5Ayr
 p8aO3eTSITXpFeKLGZUnklBe6I/ocLU=
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 26B503E62D7
	for <ltp@archiver.kernel.org>; Mon, 25 May 2026 16:46:22 +0200 (CEST)
Received: from in-7.smtp.seeweb.it (in-7.smtp.seeweb.it
 [IPv6:2001:4b78:1:20::7])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id AADA73E52C9
 for <ltp@lists.linux.it>; Mon, 25 May 2026 16:44:44 +0200 (CEST)
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.133.124])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-7.smtp.seeweb.it (Postfix) with ESMTPS id A170D200743
 for <ltp@lists.linux.it>; Mon, 25 May 2026 16:44:43 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1779720282;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=/7oYfHDvYGHMS5OK6yAehsp0jjT+n9CjVWeT53MIvtw=;
 b=RE8g3U3F3iqD0GGbvuNnqkAGjLuZez5fhf63shs0FGeTV6uucfiDhGxRY5csYnpAoL65p9
 bg7TSHpA/UJyj56ls+AUJ2VLpVmFs2p2R5GV7T5tjRIKjJ2W0/UAzT65/DCfl+Q6VSi+SB
 7203vNkz2Of3rDb9l5ovOqAGGcF/0RI=
Received: from mail-wr1-f72.google.com (mail-wr1-f72.google.com
 [209.85.221.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-42-yX6mHKZhM2-tWPVQN5JeVg-1; Mon, 25 May 2026 10:44:40 -0400
X-MC-Unique: yX6mHKZhM2-tWPVQN5JeVg-1
X-Mimecast-MFC-AGG-ID: yX6mHKZhM2-tWPVQN5JeVg_1779720279
Received: by mail-wr1-f72.google.com with SMTP id
 ffacd0b85a97d-45e73a4f1dfso6923369f8f.0
 for <ltp@lists.linux.it>; Mon, 25 May 2026 07:44:40 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1779720279; x=1780325079;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=/7oYfHDvYGHMS5OK6yAehsp0jjT+n9CjVWeT53MIvtw=;
 b=ScTHfms1Nb3iI4qjOv7oyV9Py6OYmKVZ5H2nFV5DemUnwTSYoCrs1tYKBWA6kCTzyD
 lX4KUAUPt4tVcP1T96ExN15KFigShtyG3uaxQc0naOz8dsB1RIHDDN2wwdNhfuVOLGqu
 GZQ01+O3Jw6xpOUvRqjMoQOa03sCWL2AS94wahgpXkLPOb3gIZ+R8YFmvBlzo5Zit0qb
 VZeXcb3XmBtxWEBWdXfBMK8MY+gOAl6v6jtjCCIlr/i42YJEr33Zr6OnBJ4vmmh2muKm
 /qRZCrW4W0LwNfsnxKDsdIvBNOM7mMxElwUq23pKVz8SVJPuJ1tiAcx7quLn1Hde0Th0
 JBiw==
X-Gm-Message-State: AOJu0YwvFi3kxmeHGh3BDrBMI1LN9ahpL8yCd7U6/hvp0vQ7ah4AvUov
 ot4eHIiNYHyfJdKSVEpQaOqfyZnFA1fSGr91ISbAR/dSokN/+V2h+1Vut8TaPw2UzP6IvGb/62M
 nyFoSiYBaVyomolDloggMRSNnqNsaDlDz7OYqeFBLmb/qm/utkWhWdJIfEiyl7vAgFNh+3bsd1D
 DWZeJgMcytqtRd9e1HTcAV1K95SYtOBTeMgQE0
X-Gm-Gg: Acq92OHvlIfmLoYHazfZd71bj0O9wjVkxfWb5txZCRwQW/fpY3UjlI/dChxQobbcIc2
 ttPpGREGCVBocB6EX9Vi9xx705sxsMWmZO40IomZsZmZKrxQ3zi/xDcBAJa1Qd6a7623OXghJFB
 UK2qHgcz5gAt6VkBZN7O50ccWeU/ugIeqBcYQI6P7e3FNrt9P5a4taUa8wHH+IXoT9hOVkhPvLu
 ZDc/jsEBvthMvqR1xiOTQMJ15DgAwCvbJ2JGCxOuFV/nvwBVHKe8QT5lG5X+1hZdDXlX8gIa0Mf
 onWuL30Xac3H44kx1daStyRXgJwRkEX2fsPpHus1+i+gG2tFVHxOqBgD9GJMQIcJeR5HkU0hh5f
 D1kFisMcv13ZdItp0KI/3gqTq2XqKhlcXZ69EZqNscme3LDLZ+elPaMwhzc9emg==
X-Received: by 2002:a5d:5d82:0:b0:454:a12c:6cdb with SMTP id
 ffacd0b85a97d-45eb36b0b6cmr25020759f8f.2.1779720279162; 
 Mon, 25 May 2026 07:44:39 -0700 (PDT)
X-Received: by 2002:a5d:5d82:0:b0:454:a12c:6cdb with SMTP id
 ffacd0b85a97d-45eb36b0b6cmr25020697f8f.2.1779720278659; 
 Mon, 25 May 2026 07:44:38 -0700 (PDT)
Received: from fedora.redhat.com (89-138-3-119.bb.netvision.net.il.
 [89.138.3.119]) by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-45eb6ccd211sm35116518f8f.10.2026.05.25.07.44.37
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 25 May 2026 07:44:37 -0700 (PDT)
To: ltp@lists.linux.it
Date: Mon, 25 May 2026 17:44:17 +0300
Message-ID: <20260525144417.23327-5-mmenashe@redhat.com>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <20260525144417.23327-1-mmenashe@redhat.com>
References: <20260525144417.23327-1-mmenashe@redhat.com>
MIME-Version: 1.0
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: gWEc1hEuXt935FioP4hxP_1ML44BiMWuCEiUYWOeRqE_1779720279
X-Mimecast-Originator: redhat.com
X-Virus-Scanned: clamav-milter 1.0.9 at in-7.smtp.seeweb.it
X-Virus-Status: Clean
Subject: [LTP] [PATCH v8 4/4] futex_cmp_requeue03: Add EFAULT error coverage
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
index 2b1f6a763..3c5f07691 100644
--- a/runtest/syscalls
+++ b/runtest/syscalls
@@ -1879,6 +1879,7 @@ futex_wait_bitset01 futex_wait_bitset01
 futex_wait06 futex_wait06
 futex_wait07 futex_wait07
 futex_wake05 futex_wake05
+futex_cmp_requeue03 futex_cmp_requeue03
 
 memfd_create01 memfd_create01
 memfd_create02 memfd_create02
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
