Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D2113CD5BDE
	for <ltp@archiver.kernel.org>; Wed, 27 May 2026 09:27:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=lists.linux.it;
 i=@lists.linux.it; q=dns/txt; s=picard; t=1779874052; h=to : date :
 message-id : in-reply-to : references : mime-version : subject :
 list-id : list-unsubscribe : list-archive : list-post : list-help :
 list-subscribe : from : reply-to : content-type :
 content-transfer-encoding : sender : from;
 bh=XY9pS8BwFaBAQxtSwqivwNApw4GcLd6IoNSyNx1WNf4=;
 b=Ob5VIlKAnuX08ZdlOIRDwxJSKPfp0xTTwLnl3nwvRJEECiT+3nYqjLCgo4I8nN2gEUavI
 Vxhfm56Nic95REF2alXvqTI170Iwxf2V3aMFrygVurdM8m1oOs4W4qA8ZOXHAK4Y3tBTLj+
 sNzj3oBPZsdgun8ZoGQE6kKuuy01/LE=
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 50C073C9D72
	for <ltp@archiver.kernel.org>; Wed, 27 May 2026 11:27:32 +0200 (CEST)
Received: from in-4.smtp.seeweb.it (in-4.smtp.seeweb.it
 [IPv6:2001:4b78:1:20::4])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 418F03C9EB3
 for <ltp@lists.linux.it>; Wed, 27 May 2026 11:26:29 +0200 (CEST)
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.129.124])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-4.smtp.seeweb.it (Postfix) with ESMTPS id 9B941100048F
 for <ltp@lists.linux.it>; Wed, 27 May 2026 11:26:28 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1779873987;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=wZ/4Y9eOIyJGRzYJlFpzLDL0FgTKa9zlQiQYuBOJGUM=;
 b=SLe77tkU7N10fOQr0t3X59L6eEG0QElhWtJu7NHdaec6o7hLJNGL09nfZonMVgggnwUWpS
 ef4jSjJEMyxPNYlYaKpVHRlQ2RbufJ3p/ovrPDV91gInXnRS3RZDxZ8CyHkxfb2GrQNAcV
 5rlmh8DLs7HCJsnVQ3bjMEgOeNcVLKo=
Received: from mail-wr1-f71.google.com (mail-wr1-f71.google.com
 [209.85.221.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-595-mnd432lLPl-CzipyOrlUFg-1; Wed, 27 May 2026 05:26:26 -0400
X-MC-Unique: mnd432lLPl-CzipyOrlUFg-1
X-Mimecast-MFC-AGG-ID: mnd432lLPl-CzipyOrlUFg_1779873985
Received: by mail-wr1-f71.google.com with SMTP id
 ffacd0b85a97d-45e7c7289c3so8953325f8f.1
 for <ltp@lists.linux.it>; Wed, 27 May 2026 02:26:25 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1779873985; x=1780478785;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=wZ/4Y9eOIyJGRzYJlFpzLDL0FgTKa9zlQiQYuBOJGUM=;
 b=Kw66aUNUVaOjc9Zzmc6lsDGnbOXauZiwNvOa04Tr+AgcGWCtSJ9JPi9Zpq7dKj3xA9
 ZEcTaDu0BcZYjGkUaqZJC+ydAGcs2cf23DTp+EjLlvQMV+4Mc65pgyrQUzwJwbcty6dL
 WQZVuWhXQWyBw3bqVpwozLpB8aahVzebbuylRKjHVodxNDBaPkh5kKIZ8sQKfdb5CQUx
 YcwotZWmpbxDuHrJ6svKnIzZhto1exQ9GrJ6tPCOw2tz573MrYdHwLm3QBuXJ4MNzIdk
 84GovPPC5O1C+W8EjlOoyUFqej0E3K+ho1iYR0TMTA3pWDM4CfEwa5NH+iNbJVoZh82Q
 Ihnw==
X-Gm-Message-State: AOJu0YyysXptzbjwGrmkdt3V+WK/NjNVCYKMtdWLGNtScrA4Ir838Ln7
 sYwimAyt+wDi2XeL8M95RjgOTdoGVv2ooU1ZvdhdZ9OGliiZE0nvWpIKSwzomneke9pWFKE/hFP
 QGbaCvboQZgr0Oy3WaNoA4FUL9+HqjMtMqhJhgxxe6/iCJ+MbBTPJHF/6N15EmvYQbqROH4jRFe
 ARGFnByUWVRrpTqcnuS9Kia0volHCc2tOmC25i
X-Gm-Gg: Acq92OEUGvUY0W/qCdVq0KhHybr+MPe3X4lwvxFxPCSnEz/zH+/Ta/cfhfOZ00g+0QG
 ICoaWnxZTxSma+0M/h81E7+XsK2L5EcSlQpyHpZ1SIavJVTNZmlD9vWq8a1Teu2yTnoFkSuaafB
 fDb3QIpKzc0EQf9g5se0aunAH8wx3caM5US15kQNf0nBZHlliCjo0I79wdh/6bJHlk27ARzFLsq
 gKTZnT1W8u2FXG8ogM/EfZaTfAB+O3Qna2hTwQOhCz65z5lLYwrNa1l6mCmbjzkAkeWGpHJYAe1
 RNaLPit2+vg5CkFcOud1uL0hCAQEJUijKnwCfU2IIzoQWGrF1ts2HFJGwnLFjbvdyVv327VrUsx
 LIBb1suh0p0Zt7rq6arr67EwQCe7BYk2rzWhdI+J/yx4fCAcUlV6Vp0b6Vbn+5g==
X-Received: by 2002:a05:6000:2608:b0:45d:2b7e:a20 with SMTP id
 ffacd0b85a97d-45eb3131940mr33287212f8f.14.1779873984894; 
 Wed, 27 May 2026 02:26:24 -0700 (PDT)
X-Received: by 2002:a05:6000:2608:b0:45d:2b7e:a20 with SMTP id
 ffacd0b85a97d-45eb3131940mr33287169f8f.14.1779873984436; 
 Wed, 27 May 2026 02:26:24 -0700 (PDT)
Received: from fedora.redhat.com (89-138-3-119.bb.netvision.net.il.
 [89.138.3.119]) by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-45edb5a281dsm4552653f8f.24.2026.05.27.02.26.22
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 27 May 2026 02:26:23 -0700 (PDT)
To: ltp@lists.linux.it
Date: Wed, 27 May 2026 12:26:16 +0300
Message-ID: <20260527092618.14824-3-mmenashe@redhat.com>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <20260527092618.14824-1-mmenashe@redhat.com>
References: <20260527092618.14824-1-mmenashe@redhat.com>
MIME-Version: 1.0
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: oz8I-1Dk5Q6nf9paHFlGL-A8Sb0-S2DeiXWbkCHfXiM_1779873985
X-Mimecast-Originator: redhat.com
X-Virus-Scanned: clamav-milter 1.0.9 at in-4.smtp.seeweb.it
X-Virus-Status: Clean
Subject: [LTP] [PATCH v14 2/4] futex_wait07: Add EINTR error coverage test
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
 .../kernel/syscalls/futex/futex_wait07.c      | 89 +++++++++++++++++++
 3 files changed, 91 insertions(+)
 create mode 100644 testcases/kernel/syscalls/futex/futex_wait07.c

diff --git a/runtest/syscalls b/runtest/syscalls
index 7d5ea849e..e6c5d5112 100644
--- a/runtest/syscalls
+++ b/runtest/syscalls
@@ -1869,6 +1869,7 @@ futex_wait03 futex_wait03
 futex_wait04 futex_wait04
 futex_wait05 futex_wait05
 futex_wait06 futex_wait06
+futex_wait07 futex_wait07
 futex_waitv01 futex_waitv01
 futex_waitv02 futex_waitv02
 futex_waitv03 futex_waitv03
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
index 000000000..5a8a3c49f
--- /dev/null
+++ b/testcases/kernel/syscalls/futex/futex_wait07.c
@@ -0,0 +1,89 @@
+// SPDX-License-Identifier: GPL-2.0-or-later
+/*
+ * Copyright (C) 2026 Red Hat, Inc.
+ * Copyright (C) 2026 Michael Menasherov <mmenashe@redhat.com>
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
+	SAFE_WAITPID(child, NULL, 0);
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
