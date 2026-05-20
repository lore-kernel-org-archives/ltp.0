Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 63B1CCD4F5E
	for <ltp@archiver.kernel.org>; Wed, 20 May 2026 07:45:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=lists.linux.it;
 i=@lists.linux.it; q=dns/txt; s=picard; t=1779263127; h=to : date :
 message-id : in-reply-to : references : mime-version : subject :
 list-id : list-unsubscribe : list-archive : list-post : list-help :
 list-subscribe : from : reply-to : content-type :
 content-transfer-encoding : sender : from;
 bh=rYj6M5pUQMUzcOaCUURL9dh3FsnFUjvkwJv14IcOxqc=;
 b=RckRV01MIT595srwfjoz6OZW0/rtxNWvv93Zq+LUlo0T9YWwWKwyioH5822BTqyvAfwwE
 ZvSZTasI01Ruhw34Y4/5h/nMtvmqU8EFcg7cHShWfhQTYWckscw+D3mXvKrPDuBybZlJO6s
 VNRH3nwJbgyDHIz49gdAStJxh9gjAAk=
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id B47143C72F7
	for <ltp@archiver.kernel.org>; Wed, 20 May 2026 09:45:27 +0200 (CEST)
Received: from in-7.smtp.seeweb.it (in-7.smtp.seeweb.it
 [IPv6:2001:4b78:1:20::7])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1) server-digest SHA384)
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 760543C70F0
 for <ltp@lists.linux.it>; Wed, 20 May 2026 09:44:41 +0200 (CEST)
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.133.124])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-7.smtp.seeweb.it (Postfix) with ESMTPS id 629A02009E4
 for <ltp@lists.linux.it>; Wed, 20 May 2026 09:44:37 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1779263076;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=7b2hEjhnxXjHGlZndRdKXqBAdfYfvXxzhKB6QDrT50k=;
 b=YsER6w7hN2wjiVbgBJuDdZjttAeaAmQEP8nJn4TyNkElb5hE2GMgxNFcgouLCV8qyUzpPk
 8JM1XBzik1+RzgnHNk8eIthZkpYfvoUr8SASEg9JwTeJhyALXHiYP1XcST/WF8D2mk5fbD
 i5nxCi6hdPgh/ZH5BqkIVKsh/KQT5Ck=
Received: from mail-wr1-f72.google.com (mail-wr1-f72.google.com
 [209.85.221.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-668-JwFUc4lQOmCbwGy9muB9Rw-1; Wed, 20 May 2026 03:44:35 -0400
X-MC-Unique: JwFUc4lQOmCbwGy9muB9Rw-1
X-Mimecast-MFC-AGG-ID: JwFUc4lQOmCbwGy9muB9Rw_1779263074
Received: by mail-wr1-f72.google.com with SMTP id
 ffacd0b85a97d-44696b11265so6112372f8f.0
 for <ltp@lists.linux.it>; Wed, 20 May 2026 00:44:34 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1779263073; x=1779867873;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=7b2hEjhnxXjHGlZndRdKXqBAdfYfvXxzhKB6QDrT50k=;
 b=YdE+r5x1HA0m5E2vA8jNjZiHwSriRvN37BN8trWiMwZxPZPhDa3zpYveEwGiDrYXbW
 eYAzolNsL9xGYETfX+gWaRoBgVPLTAGlLq/3ZRDrcj7z6tjzsPOkcXjhVJF9KxaneU+h
 S9+dOBKFvKTDzsBYwx24D7xYCrVd5E3ilYCnClCyf6nz1IBIK9mpu8AaX0KJOlNZBw9D
 JcPsrohhQ7WLRYnRJovEqVa/z54hGKyCxBvlr+GW6LVq4BKtrMTYE9CNNFcONHkuXs3x
 UXSWC5RfoFTkyOaw1sraYTCprTbKLzZGsiy3Z8Q5GEJ6ArMSHwnfA3TqIdptMknuyj/2
 5Mqg==
X-Gm-Message-State: AOJu0YxL4UzMmK4xI8Ovwpxrb5Hr/Lz5M9XBqgTkAJD9ML6V84dof7ZT
 Xz6R0ZPpAiFrft96PF0ZFYWPX1tzsGi7QHCoyDfic0neZ/wuGWiSQWmG4I1gkmOV6kO18e+nPU4
 4efXKYrmAGarOnQ88BV+R4pQyFeMaebBHza1H66XDXwKe4kBrbo2ncR1R9/0rU1HRVXQPTADkLv
 IQ6daspWE9xcwUxgp0BBZeXV4yG/vClOSLZLAC
X-Gm-Gg: Acq92OGhdFZTHRLW51QBtCaMGhWcJefE5KcDVF4YilXRt76xSs15xWh1Xt/ZXEYK8sN
 r2UzaQTRI9u24xc2i71Jf45oFUE09w//lbjsBIl1MOe+uPq+SGHQe5koiX3TYmsXGzXRWVdh18Q
 2LxkIdH2CMpL/kZthAonYRMAkoPphuIjysd815BqfMbgp+xfbmWtaTze/eVb5R2qhSpOosWUmgd
 FmKwslV7hTQq8PUsIqAlofA1IpwPSv6gOZQTeFCmixnsM2xt7QVs31fpmOSqQWR03mhoTSWJDvq
 GHphw200pYn3RAf8L7O+rdKRl++I1B6f8TjHQPiSBsVX3Zd+5YAUU3kAvSgv/23swqyaeL23OZk
 kjJCbIJGtqh6ndiBQHEAfmzaLmi3i+6ObYmN3wkwiiQ==
X-Received: by 2002:a05:600c:c087:b0:488:d6eb:e63c with SMTP id
 5b1f17b1804b1-48fe61f2768mr260761015e9.15.1779263073227; 
 Wed, 20 May 2026 00:44:33 -0700 (PDT)
X-Received: by 2002:a05:600c:c087:b0:488:d6eb:e63c with SMTP id
 5b1f17b1804b1-48fe61f2768mr260760725e9.15.1779263072744; 
 Wed, 20 May 2026 00:44:32 -0700 (PDT)
Received: from fedora.tlv.redhat.com ([5.28.174.82])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-48feb8d838dsm127721625e9.1.2026.05.20.00.44.31
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 20 May 2026 00:44:31 -0700 (PDT)
To: ltp@lists.linux.it
Date: Wed, 20 May 2026 10:44:24 +0300
Message-ID: <20260520074427.39155-2-mmenashe@redhat.com>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <20260520074427.39155-1-mmenashe@redhat.com>
References: <20260520074427.39155-1-mmenashe@redhat.com>
MIME-Version: 1.0
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: GKLCZbSCBTyqL4uRvuS24TZH7IuFhA368po6b22QLPo_1779263074
X-Mimecast-Originator: redhat.com
X-Virus-Scanned: clamav-milter 1.0.9 at in-7.smtp.seeweb.it
X-Virus-Status: Clean
Subject: [LTP] [PATCH v6 1/4] futex_wait06: Add EFAULT error coverage test
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

futex(FUTEX_WAIT) has no existing test for EFAULT. Add coverage for
the cases where uaddr points to unmapped memory and where the timeout
pointer is invalid.

Signed-off-by: Michael Menasherov <mmenashe@redhat.com>
---
 runtest/syscalls                              |  1 +
 testcases/kernel/syscalls/futex/.gitignore    |  1 +
 .../kernel/syscalls/futex/futex_wait06.c      | 75 +++++++++++++++++++
 3 files changed, 77 insertions(+)
 create mode 100644 testcases/kernel/syscalls/futex/futex_wait06.c

diff --git a/runtest/syscalls b/runtest/syscalls
index f790e8f84..e8ef890f3 100644
--- a/runtest/syscalls
+++ b/runtest/syscalls
@@ -1907,3 +1907,4 @@ io_uring03 io_uring03
 
 # Tests below may cause kernel memory leak
 perf_event_open03 perf_event_open03
+futex_wait06 futex_wait06
diff --git a/testcases/kernel/syscalls/futex/.gitignore b/testcases/kernel/syscalls/futex/.gitignore
index 9d08ba7d3..56596dcb4 100644
--- a/testcases/kernel/syscalls/futex/.gitignore
+++ b/testcases/kernel/syscalls/futex/.gitignore
@@ -13,3 +13,4 @@
 /futex_waitv01
 /futex_waitv02
 /futex_waitv03
+/futex_wait06
diff --git a/testcases/kernel/syscalls/futex/futex_wait06.c b/testcases/kernel/syscalls/futex/futex_wait06.c
new file mode 100644
index 000000000..44f2f7acd
--- /dev/null
+++ b/testcases/kernel/syscalls/futex/futex_wait06.c
@@ -0,0 +1,75 @@
+// SPDX-License-Identifier: GPL-2.0-or-later
+/*
+ * Copyright (C) 2026 Red Hat, Inc.
+ */
+
+/*\
+ * Check that futex(FUTEX_WAIT) returns EFAULT when:
+ *
+ * 1) uaddr points to unmapped memory
+ * 2) timeout points to unmapped memory
+ */
+#include <errno.h>
+#include <sys/mman.h>
+
+#include "futextest.h"
+
+static futex_t futex = FUTEX_INITIALIZER;
+static futex_t *bad;
+
+static struct futex_test_variants variants[] = {
+#if (__NR_futex != __LTP__NR_INVALID_SYSCALL)
+	{ .fntype = FUTEX_FN_FUTEX, .tstype = TST_KERN_OLD_TIMESPEC, .desc = "syscall with old kernel spec"},
+#endif
+
+#if (__NR_futex_time64 != __LTP__NR_INVALID_SYSCALL)
+	{ .fntype = FUTEX_FN_FUTEX64, .tstype = TST_KERN_TIMESPEC, .desc = "syscall time64 with kernel spec"},
+#endif
+};
+
+static struct testcase {
+	const char *desc;
+	futex_t **uaddr;
+	void **timeout;
+} testcases[] = {
+	{
+		.desc = "uaddr points to unmapped memory",
+		.uaddr = &bad,
+		.timeout = NULL,
+	},
+	{
+		.desc = "timeout points to unmapped memory",
+		.uaddr = NULL,
+		.timeout = (void **)&bad,
+	},
+};
+
+static void run(unsigned int n)
+{
+	struct futex_test_variants *tv = &variants[tst_variant];
+	struct testcase *tc = &testcases[n];
+	futex_t *uaddr = tc->uaddr ? *tc->uaddr : &futex;
+	void *timeout = tc->timeout ? *tc->timeout : NULL;
+
+	TST_EXP_FAIL(futex_syscall(tv->fntype, uaddr, FUTEX_WAIT, futex,
+		timeout, NULL, 0, 0), EFAULT, "%s", tc->desc);
+}
+
+static void setup(void)
+{
+	struct futex_test_variants *tv = &variants[tst_variant];
+
+	tst_res(TINFO, "Testing variant: %s", tv->desc);
+	futex_supported_by_kernel(tv->fntype);
+
+	bad = SAFE_MMAP(NULL, getpagesize(), PROT_READ | PROT_WRITE,
+		MAP_PRIVATE | MAP_ANONYMOUS, -1, 0);
+	SAFE_MUNMAP((void *)bad, getpagesize());
+}
+
+static struct tst_test test = {
+	.setup = setup,
+	.test = run,
+	.tcnt = ARRAY_SIZE(testcases),
+	.test_variants = ARRAY_SIZE(variants),
+};
-- 
2.54.0


-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
