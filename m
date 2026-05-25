Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 62A33CD5BBF
	for <ltp@archiver.kernel.org>; Mon, 25 May 2026 10:06:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=lists.linux.it;
 i=@lists.linux.it; q=dns/txt; s=picard; t=1779703574; h=to : date :
 message-id : in-reply-to : references : mime-version : subject :
 list-id : list-unsubscribe : list-archive : list-post : list-help :
 list-subscribe : from : reply-to : content-type :
 content-transfer-encoding : sender : from;
 bh=bhECRAcbyBx1jDGmP1qnkgIpUD50ewTAXmPUpSgpSXc=;
 b=fMlzsfZqx1rvNj8ildLDVQQFscFAILdvSf5qUzlzRTWbP1dekiONbLpxvJerofL7y409H
 j9gnP1Waz9xkCGAZcS9seVi2lhOqsKhlIJii+nt92Rd9b9cFgmdDTgi6GcC1qvnM+DvC9RE
 2jCKMNi9o33xVfdwwxvj/rGej063p44=
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 0C3043E27B9
	for <ltp@archiver.kernel.org>; Mon, 25 May 2026 12:06:14 +0200 (CEST)
Received: from in-6.smtp.seeweb.it (in-6.smtp.seeweb.it
 [IPv6:2001:4b78:1:20::6])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 7229F3E528C
 for <ltp@lists.linux.it>; Mon, 25 May 2026 12:05:02 +0200 (CEST)
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.129.124])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-6.smtp.seeweb.it (Postfix) with ESMTPS id D06F7140013E
 for <ltp@lists.linux.it>; Mon, 25 May 2026 12:05:01 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1779703500;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=m9wS0px4YJrLXBXGdI1Nka3xRt/qYny2TqUCNtt11GQ=;
 b=UQktmhBL3Uh/MJlipd0T5LDUsqqn2S2MnwGLhn6Y+Rc9xpbxItGNnna4ey0QuOdsDiAgFo
 f8huV6qwMEu/BQvzIkL6XF7gRpVL22naqfBblHnzj8mzr+6XQoeULLVg9UADeOJGy2PmlX
 tVHn1yD9GIWCGr6XbQZWPq2MJMj2738=
Received: from mail-wm1-f70.google.com (mail-wm1-f70.google.com
 [209.85.128.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-639-sXa6cOHrP8e3CVb_05wKGg-1; Mon, 25 May 2026 06:04:58 -0400
X-MC-Unique: sXa6cOHrP8e3CVb_05wKGg-1
X-Mimecast-MFC-AGG-ID: sXa6cOHrP8e3CVb_05wKGg_1779703497
Received: by mail-wm1-f70.google.com with SMTP id
 5b1f17b1804b1-4905428aad6so14385285e9.1
 for <ltp@lists.linux.it>; Mon, 25 May 2026 03:04:58 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1779703497; x=1780308297;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=m9wS0px4YJrLXBXGdI1Nka3xRt/qYny2TqUCNtt11GQ=;
 b=sOUkzfjF2ot2IaAxYTdZKtVUp3C6EoHrhYUgQPKdcx/TAgS0YT4esvklFD3SM0IGdr
 4JTeJbFfZtFc9m80Ezy6f4cbnWb5qI3Np4JgkuAAkJdO6YNi+3NTbIycRdbZv3eN+H0j
 qQUTYoABMXBbT6d+yOfL+LjZPYWB3yEJjYwqd3808wRdxMmmoD/ci+GkzQXXo4OD9OL2
 vYhD/biF2Ky1mhhlGZOyWEaJHtsHWWJ9yBSSOw+9S1UR2Us8EcK2qPE9aDMgwyP1oMFc
 VE1PySk8KEtnB5cG4V753fgQtKWhor/+vJO/WFIzc4Hpv2TEubt0ygs2SeXQ1KsN7f5I
 KeKA==
X-Gm-Message-State: AOJu0YxscpFmMx4KCgmEsi1rNDteAGSgqhQpHAl8wKuwPapIFzV4NDB2
 Su3M9lPS7TFge9mczbFDnFHLHaKVZYFDSRNikWNACalrzOvMTu0QHob8b0fFGVb1nf0MUW/zmJk
 u/W4J2MhMOWytpmPtvlKCoFzK1E2ukn2OTLwXvJ1/VcCMP4v7IGYbtal8x4rWyk944SNClSUJKu
 R3OcGbd4Yy40TdFTaRowBX20RLVfPXsBzvRLua
X-Gm-Gg: Acq92OE5q8w968WBUHZjMLBMPK4gRO0qWyjb7ncLYLlHqu9cEs+ya/RiiKSqyUSaUZI
 36jkHVXerMLqzoODptB/+dcB1heMaBwIrfZkS4JmPJCiV8JiWGuvvqiyPqRdv9XQ+4q5FmCuY+T
 xLd6HyNvCVAGFfhRFpGkG7jXVzayExqE1A+49Z+9qAvqyALAOwMuI20i3ROunV+ahq+lHfPcdqT
 ZxwJOZEkT+yTIkxrnbwJeJminAhrZKX/RNeMQbrtdjAFmzomZ2b2yrKC43d7o/bvRec40yl5bsy
 JyBU5IHDuRGRl7tKdS64EnFzb1bV5kfryhHfIfZVr6digDoduwz5df8NYOtpZPXyxHKd87OLE89
 4nsm6p7QCjkaWhPdnrqdYNHSS/hOg6Igw3LJsP6bTderW4PdOljGFg06lfVH5xuMQElZia4BnqM
 rbcw==
X-Received: by 2002:a05:600c:19cb:b0:490:507c:bdb1 with SMTP id
 5b1f17b1804b1-490507cbed4mr165515215e9.15.1779703497154; 
 Mon, 25 May 2026 03:04:57 -0700 (PDT)
X-Received: by 2002:a05:600c:19cb:b0:490:507c:bdb1 with SMTP id
 5b1f17b1804b1-490507cbed4mr165514415e9.15.1779703496678; 
 Mon, 25 May 2026 03:04:56 -0700 (PDT)
Received: from fedora.redhat.com (46-116-113-151.bb.netvision.net.il.
 [46.116.113.151]) by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-490454a0b9asm236519805e9.11.2026.05.25.03.04.55
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 25 May 2026 03:04:56 -0700 (PDT)
To: ltp@lists.linux.it
Date: Mon, 25 May 2026 13:04:49 +0300
Message-ID: <20260525100452.336518-2-mmenashe@redhat.com>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <20260525100452.336518-1-mmenashe@redhat.com>
References: <20260525100452.336518-1-mmenashe@redhat.com>
MIME-Version: 1.0
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: CZiio4wNqA2MpTkWYJ51lteXWP-3koQW9zL47_Yh-LE_1779703497
X-Mimecast-Originator: redhat.com
X-Virus-Scanned: clamav-milter 1.0.9 at in-6.smtp.seeweb.it
X-Virus-Status: Clean
Subject: [LTP] [PATCH v7 1/4] futex_wait06: Add EFAULT error coverage test
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
index 000000000..2cf509ee1
--- /dev/null
+++ b/testcases/kernel/syscalls/futex/futex_wait06.c
@@ -0,0 +1,75 @@
+// SPDX-License-Identifier: GPL-2.0-or-later
+/*
+ * Copyright (C) 2026 Red Hat, Inc. Michael Menasherov <mmenashe@redhat.com>
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
