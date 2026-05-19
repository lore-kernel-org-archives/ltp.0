Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 06001CD4F5B
	for <ltp@archiver.kernel.org>; Tue, 19 May 2026 18:31:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=lists.linux.it;
 i=@lists.linux.it; q=dns/txt; s=picard; t=1779215472; h=to : date :
 message-id : in-reply-to : references : mime-version : subject :
 list-id : list-unsubscribe : list-archive : list-post : list-help :
 list-subscribe : from : reply-to : content-type :
 content-transfer-encoding : sender : from;
 bh=rYj6M5pUQMUzcOaCUURL9dh3FsnFUjvkwJv14IcOxqc=;
 b=FI+xuhf/AZ0E+jO5Kbu6nB324Kc0ISib6151muAxjdntLay/HmRBirSiFFsjDOi7obTyT
 Eeb9RB1+ngKMduqGM5bZiRoRLjv7NJolVK75yCu6iW+GJI4nEpDEjG2fl5p7u1QuRaXk9o1
 A/E59bWORgp7tt7YbzoCf+S0c1jFLys=
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 8E03F3C71CE
	for <ltp@archiver.kernel.org>; Tue, 19 May 2026 20:31:12 +0200 (CEST)
Received: from in-4.smtp.seeweb.it (in-4.smtp.seeweb.it [217.194.8.4])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1) server-digest SHA384)
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 1542B3C5742
 for <ltp@lists.linux.it>; Tue, 19 May 2026 20:30:49 +0200 (CEST)
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.133.124])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-4.smtp.seeweb.it (Postfix) with ESMTPS id 7C60B100041C
 for <ltp@lists.linux.it>; Tue, 19 May 2026 20:30:47 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1779215446;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=7b2hEjhnxXjHGlZndRdKXqBAdfYfvXxzhKB6QDrT50k=;
 b=HAC5bGuj16UyFkhJjwcpQwiMFa42l8mn+fOnC3VJbO/Q/46haFyj5v7L1IP0+moE/fTc6P
 yFiFdkVt/h+UpMtSjYTsBkzcGjvDd9ag1n/ug0Js8rtMmUHoFf8NkaPYEf2d4uL5X/AxpW
 mXDHxUjULdNS+8RXeVIpmgJHeZsHhxg=
Received: from mail-wr1-f72.google.com (mail-wr1-f72.google.com
 [209.85.221.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-292-8kuqZnrzP--VDxKXHhJsdQ-1; Tue, 19 May 2026 14:30:43 -0400
X-MC-Unique: 8kuqZnrzP--VDxKXHhJsdQ-1
X-Mimecast-MFC-AGG-ID: 8kuqZnrzP--VDxKXHhJsdQ_1779215442
Received: by mail-wr1-f72.google.com with SMTP id
 ffacd0b85a97d-44dad1b938fso2371166f8f.1
 for <ltp@lists.linux.it>; Tue, 19 May 2026 11:30:43 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1779215442; x=1779820242;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=7b2hEjhnxXjHGlZndRdKXqBAdfYfvXxzhKB6QDrT50k=;
 b=kR6qc7ivk5KsGyDMeI5ekrpbAXRRH15wpqDBta8GVRVEL1sZ92dQUFjxNGZCnsBB0l
 ohLI/oNAueJmYb49jgAZEOBIvhj8utcLh4YChBhqK8LM5rpUZ1fOG4BgRAqEOsSZC8dK
 fHmQuVNXWiqUCz4CPkNG7+V+ZqncuxU98ZYOdmuRqrN1I+7KNae4IRcqXIBRgL89pmwj
 8bOZlRfhqkge3taXqJovjZQ/W9YLKqw/jK/+WfFw1o+UY2h+2OY1fa54GWX4ul9/SJ4u
 mTNVapNb5qd5z82SifIFp7rGtGowBq+UNdJh9unIpv1Awr7VQBV20mrBlPEM2Dkwq8yD
 ga+w==
X-Gm-Message-State: AOJu0YxYkmg+lNctQqv2SXOOjbj6HvN7Evqw7rdUcNQtFxEimpoAIoDD
 fFhGi1auF93gDQQM/J0PP8CKgx89/jsNJaC9DwRb1PKZwTw1l/Muy8XX5d9/q71sTLDsxvjW9Ph
 qzcNx8e2JAuaF/UaPC6Xg/rc6835zKN/wJsarE3H3rPKrKRxC8yS6aCwobWDp01I+xXROb8JHzZ
 yul+FEGSTb4pfLv0vrs9roIfNCFGtft3p8fOUv
X-Gm-Gg: Acq92OFD/VDB3dxQpRMJhn0hMhYFLn/4QcxsGffKPFbEdhL7LYvrJSsK2Xc8vZfploe
 Aqy96rV3x4p3k2XBLNEwB4euJ65WMCy1Ijl0lWgeTuV28aoWSWEDJ1hGzGjAR9rT4GD5ytjpqjb
 ezQo02jMrHSCACnvoEFdh2BYPMwmBLcsYhQt/lfjx2dA2CeeYbDKlf9lbrIHqraXSdTw+Otu7sx
 l980ZRJvh5bj26sBB/m1NosKUwRP+fPtUuGbafMn/beZNlngeAEnghHq1q/+UphPzMhbQ4q3NBm
 5dsWhMpSNWE4pILrxTvwswem2haZ+tP8F/x2KdSvNcecNPKgxon0ddaiyE1OfmAysRDXd0DQVWm
 ycpxvx+LLYDqLUIgiYPFPRlI3QQAQe4Xzv5tduUVISHHW1bLt8tCjL07SUdBO3kuXQ+AzSyfJgK
 c=
X-Received: by 2002:a05:6000:4205:b0:455:7c9f:a49e with SMTP id
 ffacd0b85a97d-45e5c5bfbc8mr33128143f8f.25.1779215441678; 
 Tue, 19 May 2026 11:30:41 -0700 (PDT)
X-Received: by 2002:a05:6000:4205:b0:455:7c9f:a49e with SMTP id
 ffacd0b85a97d-45e5c5bfbc8mr33128104f8f.25.1779215441166; 
 Tue, 19 May 2026 11:30:41 -0700 (PDT)
Received: from fedora.redhat.com (89-139-213-92.bb.netvision.net.il.
 [89.139.213.92]) by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-45da0a19a0csm45128468f8f.20.2026.05.19.11.30.39
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 19 May 2026 11:30:40 -0700 (PDT)
To: ltp@lists.linux.it
Date: Tue, 19 May 2026 21:30:28 +0300
Message-ID: <20260519183031.114591-2-mmenashe@redhat.com>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <20260519183031.114591-1-mmenashe@redhat.com>
References: <20260519183031.114591-1-mmenashe@redhat.com>
MIME-Version: 1.0
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: 1poLR5AdVByq-TH0kfNJLXV_y7kc6gE7DPRp0jOW26k_1779215442
X-Mimecast-Originator: redhat.com
X-Virus-Scanned: clamav-milter 1.0.9 at in-4.smtp.seeweb.it
X-Virus-Status: Clean
Subject: [LTP] [PATCH v5 1/4] futex_wait06: Add EFAULT error coverage test
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
