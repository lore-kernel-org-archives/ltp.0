Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 851FDCD5BC8
	for <ltp@archiver.kernel.org>; Tue, 26 May 2026 15:27:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=lists.linux.it;
 i=@lists.linux.it; q=dns/txt; s=picard; t=1779809227; h=to : date :
 message-id : in-reply-to : references : mime-version : subject :
 list-id : list-unsubscribe : list-archive : list-post : list-help :
 list-subscribe : from : reply-to : content-type :
 content-transfer-encoding : sender : from;
 bh=zvR+4aY75SCzan5C8rKQGBe50pd7qamcLoFDo6PmFHs=;
 b=GbARkFg2cl90BpNCtEr5W+jl/BcdINcCcyBRwNC4pRunHSAvi9VkI8amYNHtQ7EmOIFTJ
 z22BdOO4CWEd5HCPuVmcic9wu2mY3LmLki7We5dGaIuTzd+V2bb4Td7Npy1DlUad5tgSLIa
 uN6GNre3S4n/ZrS5z2aKTDzllkrBiMg=
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id EE2F83E62C5
	for <ltp@archiver.kernel.org>; Tue, 26 May 2026 17:27:06 +0200 (CEST)
Received: from in-5.smtp.seeweb.it (in-5.smtp.seeweb.it [217.194.8.5])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 9905F3E62B3
 for <ltp@lists.linux.it>; Tue, 26 May 2026 17:26:24 +0200 (CEST)
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.129.124])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-5.smtp.seeweb.it (Postfix) with ESMTPS id D4903600801
 for <ltp@lists.linux.it>; Tue, 26 May 2026 17:26:23 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1779809182;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=fWYnVuXUqS/M1EKBcXOQqwDBAxrYblmuzkfDOCRBoeM=;
 b=Kv0Jx2dPLglPTKMfqXfasGG3WLyN/scaMTjNeuffpNpQBS1UpK/W5JvXnLGlPJ9aAR2SjA
 3ne/00v3leKPiXSbxNC90wmPV9+i2bqDp2WWLvxhTiX73zVGI2WUoEL26encmZKNzkKkVf
 GER8wdQ/tptHgzS/Vzzdm/z4+zwDWsg=
Received: from mail-wm1-f69.google.com (mail-wm1-f69.google.com
 [209.85.128.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-567-esUxBzV2N--XtyYbWAOiOw-1; Tue, 26 May 2026 11:26:20 -0400
X-MC-Unique: esUxBzV2N--XtyYbWAOiOw-1
X-Mimecast-MFC-AGG-ID: esUxBzV2N--XtyYbWAOiOw_1779809179
Received: by mail-wm1-f69.google.com with SMTP id
 5b1f17b1804b1-4904ee02e72so29704175e9.1
 for <ltp@lists.linux.it>; Tue, 26 May 2026 08:26:20 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1779809179; x=1780413979;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=fWYnVuXUqS/M1EKBcXOQqwDBAxrYblmuzkfDOCRBoeM=;
 b=LJdZjibExYg+JBEFI3L+O3rRhywHmPf8z6plyHxDhqik0YGTYkLVADxuL5peiSdgAt
 Y0K8x9G4d4IH/szCdjk+ulutsChnzC/aNq3NBQgWrjhy+IDlIkeGT+JryizwwW5rPQWC
 iJYUkJsSQd6QZKKLLhtf1ORh5VOCdZsOhT5RyKLnWAZ0BkMqV2Y2gn8bALao0yRXHOLq
 N5GC5DvJ0R4GzVyn9fI+x7uTMulsOK6EsZyQIDZ+NA90vyfXYk8f5HE7pIL6X4zOL4xd
 VmbRrN8wG4G6XS4MwJu19tfhHeTimaK1kg5DojQnhjQbX/KYbf8Vo6w1tWaBUW2SWl1d
 YOEA==
X-Gm-Message-State: AOJu0Yw2iHuFN0VfYu1XIVikwZM7mrVF5R/i2Un7Z9xCArH3e1Ie6Tde
 GtDyOnkek8dBYHrwPe+lTpkHw/3dwNpsW8AzPCtI5lJIEF6UTEgbOMEnh9qSLBGPfQt48dZb739
 ZwbUK2h8wgsZ/C8nszE0nw/9x9FPeeZzmH8znsG9cTZBxCQ7UFZVarCu9pZuAKRLnV+JC0UB0zW
 3dM2ecSc3Xpjk4Logz7tEJBVelopTam60RpZkK
X-Gm-Gg: Acq92OEcM561ZmHqGJdAXMKhfAGrjwZ86+bxFUJjeIVOf+8HD+v4LFp1cYWO2jurggn
 h+oIDeVszqa2Dbi4vytilpieJCbNDZvR/pwVf2lcYQ08WKVWwgjJjI7fT2RXvNzMsyhCSi9Zi87
 CIEDwjbwgUIcnfkUplVJDlOk5BeswPuDolUWNNvb67ZTxVuZFVfhGAlcjfNBQSoEdQLS3748ErA
 4ICfffuQ51n2GxxixcNZ5JAVx/ADh0TlwLwm5OkJJqRDFbZvhSVVnonc3cacXMAImMskCWCuEKJ
 UBRaiYCoDk0nx+Ye5jba17WhmN7Kq7244tI9ya7vpjbzFpUzZ36jh/1+TGtHPVDJUa6gG0WLP6J
 3l2d97p6qCIjmYwIT5nx8D8gCbiK9l9eC4SnBnMhEiMy/dNdztRXoGPYDp4K2qA==
X-Received: by 2002:a05:600c:c16a:b0:490:6237:5200 with SMTP id
 5b1f17b1804b1-49062375334mr178107695e9.10.1779809179436; 
 Tue, 26 May 2026 08:26:19 -0700 (PDT)
X-Received: by 2002:a05:600c:c16a:b0:490:6237:5200 with SMTP id
 5b1f17b1804b1-49062375334mr178106985e9.10.1779809178913; 
 Tue, 26 May 2026 08:26:18 -0700 (PDT)
Received: from fedora.redhat.com (89-138-3-119.bb.netvision.net.il.
 [89.138.3.119]) by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-4904561a160sm384735795e9.9.2026.05.26.08.26.17
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 26 May 2026 08:26:17 -0700 (PDT)
To: ltp@lists.linux.it
Date: Tue, 26 May 2026 18:26:11 +0300
Message-ID: <20260526152613.109485-3-mmenashe@redhat.com>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <20260526152613.109485-1-mmenashe@redhat.com>
References: <20260526152613.109485-1-mmenashe@redhat.com>
MIME-Version: 1.0
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: PrFlyUPcEPMWvfR6dQWYmRDFyz8OzozqJhProEULUss_1779809179
X-Mimecast-Originator: redhat.com
X-Virus-Scanned: clamav-milter 1.0.9 at in-5.smtp.seeweb.it
X-Virus-Status: Clean
Subject: [LTP] [PATCH v11 2/4] futex_wait07: Add EINTR error coverage test
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
