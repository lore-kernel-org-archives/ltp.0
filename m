Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D7556CD98F0
	for <ltp@archiver.kernel.org>; Sun, 21 Jun 2026 15:10:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=lists.linux.it;
 i=@lists.linux.it; q=dns/txt; s=picard; t=1782054645; h=to : date :
 message-id : in-reply-to : references : mime-version : subject :
 list-id : list-unsubscribe : list-archive : list-post : list-help :
 list-subscribe : from : reply-to : content-type :
 content-transfer-encoding : sender : from;
 bh=x7WJX71c8MG9zEmI+8nLQRDOxHNxOVHN6Qcrrp/t7DM=;
 b=dIRsT+JIi++53G4p3IZfqJvLdhD9+KDd027iALTtMkSgYccRV4P7SOhku1dFehNrZhJAA
 RRmWl+VbXkgEZd2Wh2y5Qp8xhWKzO4C3gnT88b5EL8nQr694hMpvq4aPk+34wDBQqmXDtcm
 +zZSxGrISq7KKYeqXviKxMnlgcZKMug=
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 2AB6E3E54CE
	for <ltp@archiver.kernel.org>; Sun, 21 Jun 2026 17:10:45 +0200 (CEST)
Received: from in-4.smtp.seeweb.it (in-4.smtp.seeweb.it [217.194.8.4])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1) server-digest SHA384)
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id CF3F43E540C
 for <ltp@lists.linux.it>; Sun, 21 Jun 2026 17:10:05 +0200 (CEST)
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.133.124])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-4.smtp.seeweb.it (Postfix) with ESMTPS id D35E31000406
 for <ltp@lists.linux.it>; Sun, 21 Jun 2026 17:10:00 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1782054599;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=hTLYwAKU6N2hg1qzYCQblTmfWjUCinKEYbAFcpw0AtU=;
 b=aHM5k3KjjFg/X3ijdLs3k/JQ/OFIEOR7UyZvCKn8ZYa8pDLmvfGOmk2zE7HZ9dOr6l8O69
 EkI1j/+iMpvMuKD8b3j+lOibj56UXjsB9UEQMXhiT0Vuw2tsnvCQ+4XiTYJVJVCgAzq/9m
 XF3TdaUHwbNzCCpgToA6XI+glRD+o84=
Received: from mail-wm1-f72.google.com (mail-wm1-f72.google.com
 [209.85.128.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-28-N3WgP3MaP4OATNZVLl61Aw-1; Sun, 21 Jun 2026 11:09:57 -0400
X-MC-Unique: N3WgP3MaP4OATNZVLl61Aw-1
X-Mimecast-MFC-AGG-ID: N3WgP3MaP4OATNZVLl61Aw_1782054596
Received: by mail-wm1-f72.google.com with SMTP id
 5b1f17b1804b1-490a060eb84so21872965e9.0
 for <ltp@lists.linux.it>; Sun, 21 Jun 2026 08:09:57 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1782054596; x=1782659396;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=hTLYwAKU6N2hg1qzYCQblTmfWjUCinKEYbAFcpw0AtU=;
 b=saz4L2abjSlxXfHAlNqhp89R74kKwmZY+2PRh3d6M2GD/2D4NKblQJnLfDplpYyj49
 qDwJGYJV5u1jR55D7sT2E0dsxkODOj8X22TJoaXdHoBZNCfbnbB5+e3agLnlWyAGDmVG
 ++fW9I4cCnxJd6aJXqUuffg4bOgcYmbJp7SRiz215eBr7jla/0DmDIBgTK2N14y9X2E9
 1tSxYdusLJ++zGBiO5ieg+hfNwApjUcd7MZqhJduohfMm79Axiu6eE/uSHBLMYsvC9+b
 ITipMv85OkbEjvJznS8Kh/htqecWeecm9xxQyBfVCjuExUmNQ8anYfICgohgWghVV9fB
 Ec4Q==
X-Gm-Message-State: AOJu0YxjP45BJcvMGx/URJBjg9c0ATIrbSJp6igigFaVKUpHXyCneWzV
 99ddmsvDIjhEPFXz30xz4p8mIaNjwOLnm4Nf7aYi+nd+I0AIeY8H/XRrXGx3g+Gtb2D6iuLYzsI
 lcQ7nM2rpqKRv2pjUadfhLR3lI2SfnRPi7hB9IJ14y3xvgJhVo8MnurI2ZIM+QAU/sadfzO3HNe
 vzIvTgEWSIDsRM3aB1JH+PTW0w/+yfdRAW2m5U
X-Gm-Gg: AfdE7clMj85BqISzgLw7Et3FIat/R2dmNwYmhAB22QocIvXgL8vpdhZCQyK7qtxK0rd
 YvwC3J/D6B3180U75Yx8LSywa6P28CDItjGRnDLQatWgTITNk2foG6vrfU9x+J/S9M3oy7N69PR
 mNG89aB2Ii20nWmp5UpHoR3JYVCTNpym2mOovKAivZuIQyXcbPrIQFj1wPZCVRmbdBIG5LNxCGI
 Pv2lNklY7L7CqLTsdzdbNWf9eFmWbUOL0kCHTwTa+5MJiUcKQurU+DWfH4RCU4yInJUYiV+MbRe
 gtoD+RdB47Mfx35K/MlrqCdz+ZCt91MYRw1VXl/3pig3Rk/Bc4nmhYFJgGyf0JZ5iWknBJ9dCXR
 ijTrHyjEWrqXQ24PqyaFLuNu/royLhad1DRSvtmJrBaonZVILArE20PV0uQ==
X-Received: by 2002:a05:600c:4713:b0:492:4667:8c40 with SMTP id
 5b1f17b1804b1-49246678e86mr117368215e9.8.1782054596195; 
 Sun, 21 Jun 2026 08:09:56 -0700 (PDT)
X-Received: by 2002:a05:600c:4713:b0:492:4667:8c40 with SMTP id
 5b1f17b1804b1-49246678e86mr117367875e9.8.1782054595758; 
 Sun, 21 Jun 2026 08:09:55 -0700 (PDT)
Received: from fedora.redhat.com (85.64.227.60.dynamic.barak-online.net.
 [85.64.227.60]) by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-46666788302sm15380926f8f.20.2026.06.21.08.09.54
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sun, 21 Jun 2026 08:09:55 -0700 (PDT)
To: ltp@lists.linux.it
Date: Sun, 21 Jun 2026 18:09:50 +0300
Message-ID: <20260621150951.66407-2-mmenashe@redhat.com>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <20260621150951.66407-1-mmenashe@redhat.com>
References: <20260621150951.66407-1-mmenashe@redhat.com>
MIME-Version: 1.0
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: m1kBG8HPd57lFdMZm1if_WKWb8ZOmMjhRTe0_ltey-o_1782054596
X-Mimecast-Originator: redhat.com
X-Virus-Scanned: clamav-milter 1.0.9 at in-4.smtp.seeweb.it
X-Virus-Status: Clean
Subject: [LTP] [PATCH v16 1/2] futex_wake05: Add EFAULT error coverage test
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
unmapped, PROT_NONE, and kernel-space uaddr, each exercising a
different code path in the kernel's address validation.

Signed-off-by: Michael Menasherov <mmenashe@redhat.com>
---
 runtest/syscalls                              |   1 +
 testcases/kernel/syscalls/futex/.gitignore    |   1 +
 .../kernel/syscalls/futex/futex_wake05.c      | 100 ++++++++++++++++++
 3 files changed, 102 insertions(+)
 create mode 100644 testcases/kernel/syscalls/futex/futex_wake05.c

diff --git a/runtest/syscalls b/runtest/syscalls
index a021c79da..67509826f 100644
--- a/runtest/syscalls
+++ b/runtest/syscalls
@@ -1878,6 +1878,7 @@ futex_wake01 futex_wake01
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
index 000000000..597426f0a
--- /dev/null
+++ b/testcases/kernel/syscalls/futex/futex_wake05.c
@@ -0,0 +1,100 @@
+// SPDX-License-Identifier: GPL-2.0-or-later
+/*
+ * Copyright (C) 2026 Red Hat, Inc.
+ * Copyright (C) 2026 Michael Menasherov <mmenashe@redhat.com>
+ */
+
+/*\
+ * Check that futex(FUTEX_WAKE) returns EFAULT when uaddr points to
+ * unmapped, PROT_NONE, or kernel-space memory.
+ *
+ * For opflags=0 (no FUTEX_PRIVATE_FLAG) futex_wake() takes the
+ * shared-futex path in get_futex_key() which must resolve the physical
+ * page.
+ *
+ * The three cases exercise different code paths: a kernel-space address
+ * is rejected by the kernel's user-space address check before physical
+ * page resolution; unmapped memory fails at find_vma() (no VMA exists);
+ * PROT_NONE memory fails at get_user_pages_fast() (VMA exists but page
+ * is inaccessible).
+ */
+
+#include <errno.h>
+#include <sys/mman.h>
+
+#include "futextest.h"
+
+static futex_t *unmapped_addr;
+static futex_t *prot_none_addr;
+static futex_t *kernel_addr = (futex_t *)-1L;
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
+	{
+		.desc = "uaddr kernel address",
+		.addr = &kernel_addr,
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
