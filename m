Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 38443CD5BBF
	for <ltp@archiver.kernel.org>; Mon, 25 May 2026 10:05:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=lists.linux.it;
 i=@lists.linux.it; q=dns/txt; s=picard; t=1779703552; h=to : date :
 message-id : in-reply-to : references : mime-version : subject :
 list-id : list-unsubscribe : list-archive : list-post : list-help :
 list-subscribe : from : reply-to : content-type :
 content-transfer-encoding : sender : from;
 bh=7rrD11sSeYMtUHmZm2R1tMjI++oOxZFjDf115gAsgbg=;
 b=XQFrZ4+LckVErEH4LBogAKhQ8xKg9rToYF2MPPtmZi4pp4fQWhLSUxUaZWZi4urZTJDO+
 Y4v/hW1I/KMGlLJ1YslaVfPxgKjFe3vXCv4RFUWc/B7XcY0sMQCFZHxuJSI6GyE5WRFj5DW
 ZNIwHZdN/G1d2NB+seHx0CwMt+/jiJY=
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 38FDF3CD5B2
	for <ltp@archiver.kernel.org>; Mon, 25 May 2026 12:05:52 +0200 (CEST)
Received: from in-7.smtp.seeweb.it (in-7.smtp.seeweb.it [217.194.8.7])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 41E2F3E528C
 for <ltp@lists.linux.it>; Mon, 25 May 2026 12:05:03 +0200 (CEST)
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.129.124])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-7.smtp.seeweb.it (Postfix) with ESMTPS id 98E60200358
 for <ltp@lists.linux.it>; Mon, 25 May 2026 12:05:02 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1779703501;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=jFf1ZjWExBcGxb9AL3EjZuiGw9E9XUaLravazcw60mM=;
 b=XAmgN0NVdSyEcPJRHzZo8Oy7klNjxPqdWmY/NpmFOgPRqtRsdG2xq40Wd8WY9nF599CSj2
 sY7yu65mdWooPBw2aaX0VM7RZZWtmnHDFJkoqg4tnRBL41P8tLBkbl5tKQvAI/PjfTI9na
 y2MNeuxW0TtXxk/TKgNbgkuHMab7dSc=
Received: from mail-wm1-f72.google.com (mail-wm1-f72.google.com
 [209.85.128.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-575-TaOqG3TQMACE4yvWrQ2BKg-1; Mon, 25 May 2026 06:04:59 -0400
X-MC-Unique: TaOqG3TQMACE4yvWrQ2BKg-1
X-Mimecast-MFC-AGG-ID: TaOqG3TQMACE4yvWrQ2BKg_1779703498
Received: by mail-wm1-f72.google.com with SMTP id
 5b1f17b1804b1-48fdacf2616so48536145e9.3
 for <ltp@lists.linux.it>; Mon, 25 May 2026 03:04:59 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1779703498; x=1780308298;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=jFf1ZjWExBcGxb9AL3EjZuiGw9E9XUaLravazcw60mM=;
 b=WepI/32rRlp/+ooSKe7hSlUmhMPXX+xRT8YjNGTxhwelR5noLGoYVqAbpifGTlTYDV
 8vWrs03mHZibVHX3EuzwGM6eWYNOo29RAgJW7afZCTletVaS28WrQ0tq4fg7GIdQ51EG
 d3iGkngo4IPyziUOyV6q/H8zvTzVHYPDOcR3nEWWJr8ucRwkn66zocsQeFnK0YtItHwP
 oJnDxPEdRO3FB9gxh2x46+cVx6lpHZEcPlsJyK4HvIOGo+yTp6pF81mj1RzT3quiogSf
 XEx9GhhU6g6WoJ56/4GVk8BfrS1B6AxpVSxmTUL4VTBUsQGIITFgKgtMez6qAdNUMGTO
 jEcA==
X-Gm-Message-State: AOJu0YyIoIOvtOV9zIjA8iDysYFHDh7QRl2N94V75a6o0HuU7XSS+QDo
 y1Y2yg9kHZntrVheTiXivGHQxrcMnAlLNVJsAI0kG60f/frpDcsL0Upi2OrU738yFGm0A0xXRU4
 hBr2x9StKvH1gq6SWoo/ue9nCXb5rP3jSQGSLJRj3Kl0ptCnXtBVQo3zDk7Av0xBB/GEZQemDog
 JOq2jPCXJ/XngR8MopeuYnoe1Q+dNY7sFfvV8Y
X-Gm-Gg: Acq92OF9QDlx3n67qH86i5ihmpd5h7OPE2iaTnXlSuuNnhqS3dJdVbPRWn6HHuitNiR
 2aJxd0XyLbmt1wM4p/wd8BLiW0hbvDQiioeAMjYSrxpWjLmZsE+sZdzFVef+W12r3j+iOgtmNgT
 FRUFck1FcVZ0xRw8UOO49IS6fF4AL++5HGN4T8hjno3qA6B1QSP62As+Yg800Eajaco9nmSK511
 Cb8tlfgYoOxSVqoUYx1RQxVwcZ28vdUZ9WSTLOPsonWoMCi43h4hbfdaZB+fa9T9VNycDDVnpHw
 pVIEewdbf0TmwUidXuvCgIjVG2QRbWVvF23bRDneq7N2mwvHuMmNAedztg3JTSHQAJ+aBELiIN+
 zuwRvENrSxYudSN96bJB2oL/waNqSWe75vgoETAZMLiaq3aFP7aTXPiu7PuL7ec0Vmf8=
X-Received: by 2002:a05:600c:3b13:b0:490:598a:226b with SMTP id
 5b1f17b1804b1-490598a2290mr106011125e9.28.1779703498422; 
 Mon, 25 May 2026 03:04:58 -0700 (PDT)
X-Received: by 2002:a05:600c:3b13:b0:490:598a:226b with SMTP id
 5b1f17b1804b1-490598a2290mr106010515e9.28.1779703497931; 
 Mon, 25 May 2026 03:04:57 -0700 (PDT)
Received: from fedora.redhat.com (46-116-113-151.bb.netvision.net.il.
 [46.116.113.151]) by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-490454a0b9asm236519805e9.11.2026.05.25.03.04.56
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 25 May 2026 03:04:57 -0700 (PDT)
To: ltp@lists.linux.it
Date: Mon, 25 May 2026 13:04:50 +0300
Message-ID: <20260525100452.336518-3-mmenashe@redhat.com>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <20260525100452.336518-1-mmenashe@redhat.com>
References: <20260525100452.336518-1-mmenashe@redhat.com>
MIME-Version: 1.0
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: F0-gUuAOCjEJmYwBY1kgb5xptYoLWlmJk_SnyyI9-f0_1779703498
X-Mimecast-Originator: redhat.com
X-Virus-Scanned: clamav-milter 1.0.9 at in-7.smtp.seeweb.it
X-Virus-Status: Clean
Subject: [LTP] [PATCH v7 2/4] futex_wait07: Add EINTR error coverage test
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

futex(FUTEX_WAIT) has no existing test for EINTR. Add coverage for
the case where the wait is interrupted by a signal before the futex
word changes.

Signed-off-by: Michael Menasherov <mmenashe@redhat.com>
---
 runtest/syscalls                              |  1 +
 testcases/kernel/syscalls/futex/.gitignore    |  1 +
 .../kernel/syscalls/futex/futex_wait07.c      | 87 +++++++++++++++++++
 3 files changed, 89 insertions(+)
 create mode 100644 testcases/kernel/syscalls/futex/futex_wait07.c

diff --git a/runtest/syscalls b/runtest/syscalls
index e8ef890f3..e428deda1 100644
--- a/runtest/syscalls
+++ b/runtest/syscalls
@@ -1908,3 +1908,4 @@ io_uring03 io_uring03
 # Tests below may cause kernel memory leak
 perf_event_open03 perf_event_open03
 futex_wait06 futex_wait06
+futex_wait07 futex_wait07
diff --git a/testcases/kernel/syscalls/futex/.gitignore b/testcases/kernel/syscalls/futex/.gitignore
index 56596dcb4..74ac9a926 100644
--- a/testcases/kernel/syscalls/futex/.gitignore
+++ b/testcases/kernel/syscalls/futex/.gitignore
@@ -14,3 +14,4 @@
 /futex_waitv02
 /futex_waitv03
 /futex_wait06
+/futex_wait07
diff --git a/testcases/kernel/syscalls/futex/futex_wait07.c b/testcases/kernel/syscalls/futex/futex_wait07.c
new file mode 100644
index 000000000..43808a8fc
--- /dev/null
+++ b/testcases/kernel/syscalls/futex/futex_wait07.c
@@ -0,0 +1,87 @@
+// SPDX-License-Identifier: GPL-2.0-or-later
+/*
+ * Copyright (C) 2026 Red Hat, Inc. Michael Menasherov <mmenashe@redhat.com>
+ */
+
+/*\
+ * Check that futex(FUTEX_WAIT) returns EINTR when interrupted by a signal.
+ * A child process blocks on futex_wait() with a long timeout. The parent
+ * waits for the child to enter sleep state, then sends SIGUSR1 to it.
+ * The child verifies it received EINTR and exits accordingly.
+ */
+
+#include <errno.h>
+#include <signal.h>
+
+#include "futextest.h"
+
+static futex_t *futex;
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
+/* Empty handler: receiving the signal is sufficient to interrupt futex_wait(). */
+static void sigusr1_handler(int sig LTP_ATTRIBUTE_UNUSED)
+{
+}
+
+static void do_child(void)
+{
+	struct futex_test_variants *tv = &variants[tst_variant];
+	struct sigaction sa;
+	struct tst_ts timeout;
+
+	sa.sa_handler = sigusr1_handler;
+	sa.sa_flags = 0;
+	SAFE_SIGEMPTYSET(&sa.sa_mask);
+	SAFE_SIGACTION(SIGUSR1, &sa, NULL);
+
+	timeout = tst_ts_from_ms(tv->tstype, 5000);
+	TST_EXP_FAIL(futex_wait(tv->fntype, futex, *futex, &timeout, 0), EINTR);
+	exit(0);
+}
+
+static void run(void)
+{
+	pid_t child;
+
+	child = SAFE_FORK();
+
+	if (child == 0)
+		do_child();
+
+	TST_PROCESS_STATE_WAIT(child, 'S', 0);
+	SAFE_KILL(child, SIGUSR1);
+}
+
+static void setup(void)
+{
+	struct futex_test_variants *tv = &variants[tst_variant];
+
+	tst_res(TINFO, "Testing variant: %s", tv->desc);
+	futex_supported_by_kernel(tv->fntype);
+
+	futex = SAFE_MMAP(NULL, sizeof(*futex), PROT_READ | PROT_WRITE, MAP_ANONYMOUS | MAP_SHARED, -1, 0);
+	*futex = FUTEX_INITIALIZER;
+}
+
+static void cleanup(void)
+{
+	if (futex)
+		SAFE_MUNMAP((void *)futex, sizeof(*futex));
+}
+
+static struct tst_test test = {
+	.setup = setup,
+	.cleanup = cleanup,
+	.test_all = run,
+	.test_variants = ARRAY_SIZE(variants),
+	.forks_child = 1,
+};
-- 
2.54.0


-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
