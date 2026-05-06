Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A708BCD342C
	for <ltp@archiver.kernel.org>; Wed,  6 May 2026 15:18:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=lists.linux.it;
 i=@lists.linux.it; q=dns/txt; s=picard; t=1778080736; h=to : date :
 message-id : in-reply-to : references : mime-version : subject :
 list-id : list-unsubscribe : list-archive : list-post : list-help :
 list-subscribe : from : reply-to : content-type :
 content-transfer-encoding : sender : from;
 bh=YIDZ+VjQ+QTpGPSpe41L7vB6AHlBhvlGEcwIqgUwq/k=;
 b=pkrJ1AZ+CwwvSbORsat/7wds0dIs1PJkQkITtK+DPD7P0CTHz3qZ8dcFONdMk+aCd9Kp0
 P1UHcceaQJPsM5d4mGv/6+G+gHfsRGQpShUHp5n4fLDbHiBfdSriicbtk0cVtzaZ8HqxoDm
 diny3QbkeF5Qunffw3/nQyMpnLh4I4Y=
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 63B1B3E6167
	for <ltp@archiver.kernel.org>; Wed,  6 May 2026 17:18:56 +0200 (CEST)
Received: from in-6.smtp.seeweb.it (in-6.smtp.seeweb.it
 [IPv6:2001:4b78:1:20::6])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 699FF3E6158
 for <ltp@lists.linux.it>; Wed,  6 May 2026 17:18:11 +0200 (CEST)
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.133.124])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-6.smtp.seeweb.it (Postfix) with ESMTPS id DA4391400C7A
 for <ltp@lists.linux.it>; Wed,  6 May 2026 17:18:10 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1778080689;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=ELO5/95huPjkbBSpOBLFHod6zNbd5CTogwmcbz0btZ8=;
 b=iFheVkOzxOq8VC8yb/AWyT+2O5i5TKPZwN8LTTR7saboTSLSQpgwa8IZXKVZTdD2pxOmIu
 +fKjGVITLTcv975SiDQqyLi+yt68SAQz2tXC9NtpptI1wWKfIBICIezf8toEeW3GKnrlV8
 PFS2ATb/BCt23SOYRnt9Jc/nNsoz4GY=
Received: from mail-wr1-f69.google.com (mail-wr1-f69.google.com
 [209.85.221.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-616-WjVS6h7EPFm1cQEH5qrbJA-1; Wed, 06 May 2026 11:18:08 -0400
X-MC-Unique: WjVS6h7EPFm1cQEH5qrbJA-1
X-Mimecast-MFC-AGG-ID: WjVS6h7EPFm1cQEH5qrbJA_1778080687
Received: by mail-wr1-f69.google.com with SMTP id
 ffacd0b85a97d-43ff19e54beso4549097f8f.2
 for <ltp@lists.linux.it>; Wed, 06 May 2026 08:18:08 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1778080687; x=1778685487;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=ELO5/95huPjkbBSpOBLFHod6zNbd5CTogwmcbz0btZ8=;
 b=IMSxGy/YGRht7UJtJuBIVdvbzHtU3sHvvBRJOG0yqIaT10prWl3FDLJS5VMikAoWeb
 gu5+F9ZRTha+tc72GWOKomvrJIValUq86/aB/d5QhIMiZfhRpOOUfVPVJ9Q6AnlWcD/t
 pP7P6VaxSULggltziQDrxxR6Lufaa+uv102aOlO4wia+EP8jItnDKOa+zW53plcM+tc2
 icezxR8UxUJEA6By7tp8wL8gwuJWJ5w7wvXwIHgP3DLcQ5viLvVAiEfVTkgi+65WmNrs
 lNUHdUk08iwYfNgdjQKKqsQ+hsrJpDMteWc4xHR+I0kxsbUVt2tgNPcXajZzjdA10efs
 zGsQ==
X-Gm-Message-State: AOJu0YxUvbNk0utdu90TGMSYEpQ+F89p4csdn3B2+/IYOYMl4TafSykk
 UGEjQwZUZm/DTylQYq8P9Q76QMRUu8YJ7+R/wNKVEXuHPV4W25Jxbh/3EwclytN96+THU3MB/39
 90cMfGttjvLLHBAtYcv1ItBECHO0Llked3c3ECoLCiHVSzb5DmTz70Rz/NdfUADA3XT16gpkGo7
 2lk8mt+WTDtvByddhwXQYPgwGechplNnJtNeWo
X-Gm-Gg: AeBDietQWqtYL3n+zVZe017h3P67/dxrwnnLhElz/OMGnEum5qQNetI9F6LWCVwaXkz
 kDIPjpYUN9j1fSySnqgBfS/RgSKZxA0vZUaMig6Hy4arv4WZAygrjrYGaQdV2JYv4c/ZoJRGG9U
 TyRhgsqzkIkmvxG+R6TstKx263gMpko5e7MJiuQJA9Cir5IhPPfDUrWAP3GdEQrG2/ck3UtGrqB
 O2LdAWc8JPFznuvCRYDBReNvKzdLtCLD0tilhU2Dceps5vZzaHDU4kAKztWSO9VqyE6JRNvZE84
 tGYFK3wUBXPPl/BKQxgw5xhKCHKN9Fzw95Do7HeYjlIs3ajAcrSMwe+mzTleFJpSVTaQfLSqmrS
 HTAwmPBYrFJ9OxjLNtv6r8ZSbL90LNrXeHrOjVXlvuSA1ruB3eZDVjBxvoIaq5fYprUWxeN5zH4
 p+CgMosg==
X-Received: by 2002:a05:6000:1acb:b0:441:2aee:d561 with SMTP id
 ffacd0b85a97d-4515d4d111dmr6894354f8f.28.1778080686702; 
 Wed, 06 May 2026 08:18:06 -0700 (PDT)
X-Received: by 2002:a05:6000:1acb:b0:441:2aee:d561 with SMTP id
 ffacd0b85a97d-4515d4d111dmr6894270f8f.28.1778080686086; 
 Wed, 06 May 2026 08:18:06 -0700 (PDT)
Received: from fedora.redhat.com (85.65.168.167.dynamic.barak-online.net.
 [85.65.168.167]) by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-4505238e174sm13323519f8f.1.2026.05.06.08.18.05
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 06 May 2026 08:18:05 -0700 (PDT)
To: ltp@lists.linux.it
Date: Wed,  6 May 2026 18:17:59 +0300
Message-ID: <20260506151801.20401-3-mmenashe@redhat.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260506151801.20401-1-mmenashe@redhat.com>
References: <20260506151801.20401-1-mmenashe@redhat.com>
MIME-Version: 1.0
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: xzQcvW13WlWceWGl_HfFr2EtOuHErPMdPCRuwPHvh_o_1778080687
X-Mimecast-Originator: redhat.com
X-Virus-Scanned: clamav-milter 1.0.9 at in-6.smtp.seeweb.it
X-Virus-Status: Clean
Subject: [LTP] [ltp v2 2/4] futex_wait07: Add EINTR error coverage test
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
