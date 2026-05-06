Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 588B4CD342C
	for <ltp@archiver.kernel.org>; Wed,  6 May 2026 11:38:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=lists.linux.it;
 i=@lists.linux.it; q=dns/txt; s=picard; t=1778067499; h=to : date :
 message-id : in-reply-to : references : mime-version : subject :
 list-id : list-unsubscribe : list-archive : list-post : list-help :
 list-subscribe : from : reply-to : content-type :
 content-transfer-encoding : sender : from;
 bh=YIDZ+VjQ+QTpGPSpe41L7vB6AHlBhvlGEcwIqgUwq/k=;
 b=HMZU5t2xrJIOu8eXFeTCtXJL1/7VazUvlgegJ0yn5MaLu5KVoLISJSELWnwte7T1Yp4mp
 KrLlwz/1/IBbmnyINalhU6OHEwHc+P1DcUOJqzPPoAQGEvaMTvnm28oqF3OuRj+xmTSmHVX
 4ag0ycpY6MYXqMbLGfU176/ONuKCVKQ=
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 0224D3E6153
	for <ltp@archiver.kernel.org>; Wed,  6 May 2026 13:38:19 +0200 (CEST)
Received: from in-4.smtp.seeweb.it (in-4.smtp.seeweb.it [217.194.8.4])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 734463E2CC3
 for <ltp@lists.linux.it>; Wed,  6 May 2026 13:37:06 +0200 (CEST)
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.129.124])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-4.smtp.seeweb.it (Postfix) with ESMTPS id CA46810009F7
 for <ltp@lists.linux.it>; Wed,  6 May 2026 13:37:05 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1778067424;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=ELO5/95huPjkbBSpOBLFHod6zNbd5CTogwmcbz0btZ8=;
 b=SL0k30oBSEF+O00iAXycOeiWVl3ajeZ8tAFVCnCBorV9raX3AccptBzNjuUFNMs9Jqz06U
 ae/YUcMaGmaWxG038Nto1tnoKkZi9ZymBczF+l+J4zkcuV6Fb3Ld7S3+0wxpOxvzT1IJhF
 kH64k8DfvwjSrPqDAyPsoQYSIByUx4k=
Received: from mail-wm1-f71.google.com (mail-wm1-f71.google.com
 [209.85.128.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-219-ljqfjmgNPa2w2nctMOwoFA-1; Wed, 06 May 2026 07:37:03 -0400
X-MC-Unique: ljqfjmgNPa2w2nctMOwoFA-1
X-Mimecast-MFC-AGG-ID: ljqfjmgNPa2w2nctMOwoFA_1778067422
Received: by mail-wm1-f71.google.com with SMTP id
 5b1f17b1804b1-48a7994e8ddso59704375e9.0
 for <ltp@lists.linux.it>; Wed, 06 May 2026 04:37:02 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1778067421; x=1778672221;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=ELO5/95huPjkbBSpOBLFHod6zNbd5CTogwmcbz0btZ8=;
 b=bqadyekFcOXMHNbnow7RraRwL4wqk/kUQm8kkYKzcYxUAYoBrO/nx+FCkcO+fzfgPW
 9Da0qCsU52SwELgQjmwuOudrT3UsFLTx9U/REazlf/VvddUitQ1XzxDr5J02cri1WDIa
 h8kvmWcNg1Kzl2XtdAstIxsVKemybISDmc64aGC9BnNwi0KpMCzQw90W7WAwC+Q6IS8I
 3G3Q3rZmr3ljZ49JZiymle/t6T6ZxLehdrGnJmT/siuO5eoO165KWC71lQ4YlaXO37kX
 uxM8ZaeNBxXqPRxkbEBu1TVLufDgwxu40EjsfIVaPKVrrCDk7hCPQ8yaEgYeR6khZ7V9
 lFyA==
X-Gm-Message-State: AOJu0Ywy27cv/ddGxdsiCGgFqNsshRtazptN1564bSRNXYtxDTGK0iBt
 jBJ+qzqIfhzfV3u2EkjVeIYAxVxVxBRh8CpYfo1NsPaOeK769+wYwpguHH8Ul/H5quMo8E6chKn
 UhJWhYxg8RyYEe2AGF5FHlH7zsu2BDBdoz+ltgjx0rfMHBgd7WYH9K3AmTJ39xpu4iaAXQi0esg
 srWbNBRp5E47oxL+hZHjIdiOMrwg0rhQmc7X/c
X-Gm-Gg: AeBDieuUEC2p7w79Xy4gu3d+fGXry+WHAMwBEuZssFxl21xEyIIjXWD358bD5C/0xqW
 Or/7YegcEmiDF06198TgEGw4xoKTk1S4RABnrZ0gnyke6ElhrIAULmPb5gd6qLbU+qqHdeVgf1f
 YMTcOZbfqYfyRVv3Dz/hZ/b/EaNoJccZ39HwPkftvo8y+9uVs/Bx0n6k0bt0T3Hzv0ZpZ1FB7Xv
 C4gUZ+mAjM3QTaWgCgscfozwY9QomOojBbicUmQxx4VVwwTg+tmfOijF72HyPJ2iLTVyikFe4kx
 1woINwzDl+6f48Bfy8A+ZMglpOftAiCFM7EZL0LNf0Akx+TOMtvNRGG6krD6lBS3ljnwlLI7kTl
 fE27Rwq+ydaYcrlPSSjLXv4LAl2pzBBBDbnMeISUTaQy8oZfororokjSTGKvX/3/zNMyu/7mbdm
 6DdrH0wg==
X-Received: by 2002:a05:600c:5308:b0:48a:906a:9050 with SMTP id
 5b1f17b1804b1-48e51e20759mr51473935e9.10.1778067421230; 
 Wed, 06 May 2026 04:37:01 -0700 (PDT)
X-Received: by 2002:a05:600c:5308:b0:48a:906a:9050 with SMTP id
 5b1f17b1804b1-48e51e20759mr51473295e9.10.1778067420605; 
 Wed, 06 May 2026 04:37:00 -0700 (PDT)
Received: from fedora.redhat.com (85.65.168.167.dynamic.barak-online.net.
 [85.65.168.167]) by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-45055960022sm11919938f8f.26.2026.05.06.04.36.59
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 06 May 2026 04:37:00 -0700 (PDT)
To: ltp@lists.linux.it
Date: Wed,  6 May 2026 14:36:53 +0300
Message-ID: <20260506113655.10797-3-mmenashe@redhat.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260506113655.10797-1-mmenashe@redhat.com>
References: <20260506113655.10797-1-mmenashe@redhat.com>
MIME-Version: 1.0
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: RCkzh0K5IsMX4WqJTsNzgIYkHGGBOaoQqcubA5ni-gg_1778067422
X-Mimecast-Originator: redhat.com
X-Virus-Scanned: clamav-milter 1.0.9 at in-4.smtp.seeweb.it
X-Virus-Status: Clean
Subject: [LTP] [PATCH 2/4] futex_wait07: Add EINTR error coverage test
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

---
 runtest/syscalls                              |  1 +
 testcases/kernel/syscalls/futex/.gitignore    |  1 +
 .../kernel/syscalls/futex/futex_wait07.c      | 91 +++++++++++++++++++
 3 files changed, 93 insertions(+)
 create mode 100644 testcases/kernel/syscalls/futex/futex_wait07.c

diff --git a/runtest/syscalls b/runtest/syscalls
index 621355e04..75b7754db 100644
--- a/runtest/syscalls
+++ b/runtest/syscalls
@@ -1906,3 +1906,4 @@ io_uring03 io_uring03
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
index 000000000..c3063389a
--- /dev/null
+++ b/testcases/kernel/syscalls/futex/futex_wait07.c
@@ -0,0 +1,91 @@
+// SPDX-License-Identifier: GPL-2.0-or-later
+/*
+ * Copyright (C) 2026 Red Hat, Inc.
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
+/* We need a handler so SIGUSR1 is caught instead of killing the process.
+ * The empty body is needed, just receiving the signal is enough to
+ * interrupt futex_wait() and make it return into EINTR -1 status.
+ */
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
+	if (futex) {
+		SAFE_MUNMAP((void *)futex, sizeof(*futex));
+	}
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
2.53.0


-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
