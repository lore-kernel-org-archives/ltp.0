Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 588A8CD98E1
	for <ltp@archiver.kernel.org>; Tue, 16 Jun 2026 18:30:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=lists.linux.it;
 i=@lists.linux.it; q=dns/txt; s=picard; t=1781634655; h=to : date :
 message-id : in-reply-to : references : mime-version : subject :
 list-id : list-unsubscribe : list-archive : list-post : list-help :
 list-subscribe : from : reply-to : content-type :
 content-transfer-encoding : sender : from;
 bh=oU4JpKvaL43WVUWh0R96iBn15CtMoVViBwvbMfIzNAo=;
 b=HQ4KWMzhq4CHJ3WkI6Z6f+8Bf6qhtk4d5nFV1oN+KUp1dNAiAVKcXxnDT7aZFZxJQUKxx
 y6bZxCm3uXn0HEGP0U0nwpl5tbSlct/OWP1z6Kaldbz5sE7S4MbkUf2nwGvzc9UU4MiN5+F
 ut9I1lJ4KOU2eiZ4g2ofloUI4hRQqks=
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 126CF3E6C5F
	for <ltp@archiver.kernel.org>; Tue, 16 Jun 2026 20:30:55 +0200 (CEST)
Received: from in-7.smtp.seeweb.it (in-7.smtp.seeweb.it [217.194.8.7])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id EEC4D3E2AAB
 for <ltp@lists.linux.it>; Tue, 16 Jun 2026 20:30:34 +0200 (CEST)
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.133.124])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-7.smtp.seeweb.it (Postfix) with ESMTPS id 1EF32200901
 for <ltp@lists.linux.it>; Tue, 16 Jun 2026 20:30:33 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1781634632;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=QGhXSG5+y9+42hjKy+pnULBWSTLUbdwTJL/4e9v0pJg=;
 b=QFjL5pAjPrH++0aLFPbZrgUd73rKBpo+5y/dBKr9dqMvsx2SV1xi9wd57hkgxrANUUyzB4
 XkzHbOzDpODQxlN4nnkg0kORr6B3x/esP0r3axpdYyLz+lLTc3bFNaUp7yMkeiFvGWODnk
 sSPyN0uDalV7HJyoMvDUnZGjazEF/gw=
Received: from mail-wr1-f70.google.com (mail-wr1-f70.google.com
 [209.85.221.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-676-NnL3oYH1P1WoKm518U20sg-1; Tue, 16 Jun 2026 14:30:30 -0400
X-MC-Unique: NnL3oYH1P1WoKm518U20sg-1
X-Mimecast-MFC-AGG-ID: NnL3oYH1P1WoKm518U20sg_1781634630
Received: by mail-wr1-f70.google.com with SMTP id
 ffacd0b85a97d-45ef66cc579so2425071f8f.3
 for <ltp@lists.linux.it>; Tue, 16 Jun 2026 11:30:30 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1781634629; x=1782239429;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=QGhXSG5+y9+42hjKy+pnULBWSTLUbdwTJL/4e9v0pJg=;
 b=WS6ejbEP2GCdQufju+fVgWm7p9uZaIdW6uvAtR1PZ8Nnc6Y2p8nj6TDziPMjI6QSuG
 eLleOWfmIJ7TG9BfsZSt3IsH9n8oVvJ+dTK6agRey+P85uFXsqPb8vVq3R/wV9q0w1nM
 YwdZsQO5/6I5ZgJXkAauEzwjQEnjIqx6QGVc8KASQYmazuWvAR2QTD8LFQQJJk85QxMT
 9uNqyToYoT7hSEWJgF7hggOBUENoakM7XJygj98nwUK2KqYav/2gnW+ATfGtBvNKuNlV
 WamC6zXofRWsfqw2l8yeZRzLXxO0lSvHgEFg5AeET3cHmxX7JThSWkfjbVesq7IA9Au7
 j0zg==
X-Gm-Message-State: AOJu0Yx7WUoNSsclIBaGvUzgECh9klg4+RFzFckJ3HW967+59tEklXp9
 YOGS28KBkBahVKKVhvaTVvjnxKOds6+V82XSPMG2847nRaKlD1+mVfqteDJN5XWiwaPApe1Mnft
 cgqeRfoXbU2hCIUaxtLit/mw4c1hWreIvdXaNws+GkMxxHXIvDzuxNQO6OiSZOwXjXi1aDGx+A8
 fe7+2TF5EGKoM4bVJivTL4y4fVzzDfXcfCz4ED
X-Gm-Gg: Acq92OGoQEDc8S+Ni06AJlW7TTqNwzxI4ObpqONWqpB4gnCco1gO8tx6CbKtI2LSaX8
 +yOWGJowrdyh8Dg7ANG7XI/3ZM9g+FFAT2XfDIGtOuOaa/WWBV87T8OlwijNK1sZcbG0WT/6xvL
 1QHKhWWhT8E/IsgwV7new0N7xo1TtNVhu3ylEi8vqngtUU9phQemKIDAWkwzhu9t64NtaO6iUIx
 dl0+q0O+G74eJtXZaBvkcppQr7s1XxoXvYAA+yf6f55nCzd27rqgeGZlFoFO/elm0E5hIKcP1Lu
 kicPjSZgOJ0joh4aNaVAUaVQqSPkY2Fma7O4vS9Xo/U7IMNGVe45mcHRiHsSdO0zACjEZvCmMsI
 wLSfsdp0SHQaPXVaZuExwKio2StX90uGD5AVlJ//+Y35v/9B95IOjflTWQ57dlVgqSm/3+M4=
X-Received: by 2002:a05:600c:3e0d:b0:490:b642:ce29 with SMTP id
 5b1f17b1804b1-492333a0bfcmr10935335e9.8.1781634629643; 
 Tue, 16 Jun 2026 11:30:29 -0700 (PDT)
X-Received: by 2002:a05:600c:3e0d:b0:490:b642:ce29 with SMTP id
 5b1f17b1804b1-492333a0bfcmr10934885e9.8.1781634629223; 
 Tue, 16 Jun 2026 11:30:29 -0700 (PDT)
Received: from fedora.redhat.com (85.64.196.200.dynamic.barak-online.net.
 [85.64.196.200]) by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-49233438eebsm8244805e9.0.2026.06.16.11.30.28
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 16 Jun 2026 11:30:28 -0700 (PDT)
To: ltp@lists.linux.it
Date: Tue, 16 Jun 2026 21:30:24 +0300
Message-ID: <20260616183025.26554-2-mmenashe@redhat.com>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <20260616183025.26554-1-mmenashe@redhat.com>
References: <20260616183025.26554-1-mmenashe@redhat.com>
MIME-Version: 1.0
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: Hm0f4vJGUX_Ad-Az0dFrASB_sJfKKWIsYFjntXOd9js_1781634630
X-Mimecast-Originator: redhat.com
X-Virus-Scanned: clamav-milter 1.0.9 at in-7.smtp.seeweb.it
X-Virus-Status: Clean
Subject: [LTP] [PATCH v15 1/2] futex_wake05: Add EFAULT error coverage test
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
 .../kernel/syscalls/futex/futex_wake05.c      | 101 ++++++++++++++++++
 3 files changed, 103 insertions(+)
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
index 000000000..162bc4e04
--- /dev/null
+++ b/testcases/kernel/syscalls/futex/futex_wake05.c
@@ -0,0 +1,101 @@
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
+ * For the unmapped and PROT_NONE cases, opflags=0 (no FUTEX_PRIVATE_FLAG)
+ * ensures futex_wake() takes the shared-futex path in get_futex_key()
+ * which must resolve the physical page. For PROT_NONE memory this page
+ * lookup fails with EFAULT, even though futex_wake() never reads *uaddr.
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
