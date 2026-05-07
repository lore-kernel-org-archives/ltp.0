Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id F2252CD3427
	for <ltp@archiver.kernel.org>; Thu,  7 May 2026 11:19:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=lists.linux.it;
 i=@lists.linux.it; q=dns/txt; s=picard; t=1778152768; h=to : date :
 message-id : in-reply-to : references : mime-version : subject :
 list-id : list-unsubscribe : list-archive : list-post : list-help :
 list-subscribe : from : reply-to : content-type :
 content-transfer-encoding : sender : from;
 bh=RNCWNRt1ue9TowkArDUqtPMeiHweURzVnxOsyGISuls=;
 b=i6q6JkJRa3VpOfkUuVrIduH++6WUtuDhQ4J4dID07oiPYyrSmPfG788LZRm9fm4OT5EYD
 5oayTu6sHCTf6QQaHgFTy3AFhAeP6KlqgusXusMJDGBO/T+7uUh+JdmUjqQG2KWQlzPXsV1
 l31cdWQ3YrXuEL9JeAcOqt/5EMefSCE=
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 2F2713E5F59
	for <ltp@archiver.kernel.org>; Thu,  7 May 2026 13:19:28 +0200 (CEST)
Received: from in-7.smtp.seeweb.it (in-7.smtp.seeweb.it [217.194.8.7])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1) server-digest SHA384)
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 6B5FC3E24B3
 for <ltp@lists.linux.it>; Thu,  7 May 2026 13:18:20 +0200 (CEST)
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.133.124])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-7.smtp.seeweb.it (Postfix) with ESMTPS id CE3BD200751
 for <ltp@lists.linux.it>; Thu,  7 May 2026 13:18:19 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1778152698;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=A6OeZNKBrR14BPhooCA6n97UA8FdZ+5MbeNw4F7+Fak=;
 b=NFupco9d6CtWocF3ScMuLY8fsV2e4cWDQ1PxvrKtFVxpAAMvgyzoGm2accvhsgdM4toigQ
 nxUrSHdkUu1JluDvtM/DN7uU5IpFf/Tw+XJLwQk9WElMo52Kk6lqj56/3FQZemqruN8Ofx
 ufDLn8DUf2PDt8eCj31ecCZ9b4ozLXs=
Received: from mail-wr1-f72.google.com (mail-wr1-f72.google.com
 [209.85.221.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-646-7_CF4PSzPii8J3Is6LZb_Q-1; Thu, 07 May 2026 07:18:17 -0400
X-MC-Unique: 7_CF4PSzPii8J3Is6LZb_Q-1
X-Mimecast-MFC-AGG-ID: 7_CF4PSzPii8J3Is6LZb_Q_1778152696
Received: by mail-wr1-f72.google.com with SMTP id
 ffacd0b85a97d-43d7d0947aeso464737f8f.3
 for <ltp@lists.linux.it>; Thu, 07 May 2026 04:18:17 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1778152695; x=1778757495;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=A6OeZNKBrR14BPhooCA6n97UA8FdZ+5MbeNw4F7+Fak=;
 b=rAF0nMTYBQK3c5+i8jsqdeUKPYlQZKs4XnV/hCDg85Z2JzNf+UlX/mSX2l4sKgX8Jz
 kmJEX492zm40tVMDVD9iMNRA/cYo799DKO/bC2tYqOsJRk3GTTc532vtX5Sp6tgn7LKX
 zwbucAVugcW1R3QuptVuECLT5nMtkFdkAcpnemVko1+6dIpXMWsai6Rp3P9/9MUedF5Z
 RxBhxnbbTDf675N8cvaEOwMsGOZt72ryLUTLRTaCD+z3EG6N/u08x0d+JF/2HMrcDEaC
 I6nMWGcS3izoO7Y3lugyqzzmvxnsQN/tQp4cJ1dRiIpAo/WPjlgtzwrt+I/dmgIe4me9
 lJxw==
X-Gm-Message-State: AOJu0Ywb9qco8s2RXZJN+oGxMklQ21oeyH3D5JZA5bzpwfL7jnAQLdjc
 qTGsZXQnEePAwxX9psMB07JN8Xb4QCM0VnhsX6kNYe+Yk/EOfuMZHyBQvHZqTUApZn8bAZk7J4d
 k/vvxrChu6dgs8o1Mt5gi3A7VbQKHnteIJ5W2CKm1aQkYaLa9xbQUSgblxgSnj+jqUDAL1P2+7Z
 fsjgbJwoyoiNRIgaXvjsCyZbLEY+K+PWTNAuTt
X-Gm-Gg: AeBDiet5aMSMS5ErMUB2jcypaQroLqtKRpylvr/tcvU7DOfkVHLDHmZKNNuooDTceNZ
 oBFENRJkMthPQeqWYnaVPccBN4Mo1PebHbgnSx9ddZNfBEGKCGdTW97qGUrcFpX6BKZSBzd4AvT
 qWHDHoPz1PuvvVaFGA0LwTxq/AXc0QAere2qMwRiCdyYUOU7bPT3M5ZNH+7Dmc64NMV09bnRyXG
 WMTYtPEd+5Vdci2kb3YSbXjc+hL726ex2Z9N92rquMuAwCOzVMf50l7TRIpJCIGKwBG1OPxnGNg
 KUfQqnISASP+OUFP0CFolg2wpJ/ixeZcXe+peLXEhkyo396dSUCRnGei+s/m3KBeyAabU+mroYc
 x1xbhiYUnW9D9lDAZViD7Zn3/6hshlOWyfrpiYGwMKZTrNqVf1nYTzg8TOwjn5QLJgk5AXttOF6
 0dNdkNAWToH3xX2LUJ
X-Received: by 2002:a05:600c:34c8:b0:486:fd5c:2b35 with SMTP id
 5b1f17b1804b1-48e51f2f85emr141925695e9.13.1778152695452; 
 Thu, 07 May 2026 04:18:15 -0700 (PDT)
X-Received: by 2002:a05:600c:34c8:b0:486:fd5c:2b35 with SMTP id
 5b1f17b1804b1-48e51f2f85emr141925075e9.13.1778152694958; 
 Thu, 07 May 2026 04:18:14 -0700 (PDT)
Received: from fedora.redhat.com (85.65.168.167.dynamic.barak-online.net.
 [85.65.168.167]) by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-48e530cf964sm74515835e9.1.2026.05.07.04.18.13
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 07 May 2026 04:18:14 -0700 (PDT)
To: ltp@lists.linux.it
Date: Thu,  7 May 2026 14:18:07 +0300
Message-ID: <20260507111809.28934-3-mmenashe@redhat.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260507111809.28934-1-mmenashe@redhat.com>
References: <20260507111809.28934-1-mmenashe@redhat.com>
MIME-Version: 1.0
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: yD3hsNJ3I_G4j7ObNdFTQ1L435hcyiEfoIBOABrUz-I_1778152696
X-Mimecast-Originator: redhat.com
X-Virus-Scanned: clamav-milter 1.0.9 at in-7.smtp.seeweb.it
X-Virus-Status: Clean
Subject: [LTP] [PATCH v4 2/4] futex_wait07: Add EINTR error coverage test
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
 .../kernel/syscalls/futex/futex_wait07.c      | 88 +++++++++++++++++++
 3 files changed, 90 insertions(+)
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
index 000000000..9bf35e506
--- /dev/null
+++ b/testcases/kernel/syscalls/futex/futex_wait07.c
@@ -0,0 +1,88 @@
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
