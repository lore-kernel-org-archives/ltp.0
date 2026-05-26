Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8AFE0CD5BC8
	for <ltp@archiver.kernel.org>; Tue, 26 May 2026 09:08:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=lists.linux.it;
 i=@lists.linux.it; q=dns/txt; s=picard; t=1779786527; h=to : date :
 message-id : in-reply-to : references : mime-version : subject :
 list-id : list-unsubscribe : list-archive : list-post : list-help :
 list-subscribe : from : reply-to : content-type :
 content-transfer-encoding : sender : from;
 bh=zvR+4aY75SCzan5C8rKQGBe50pd7qamcLoFDo6PmFHs=;
 b=BfY8wmL7Rm8EdjJkFuH6l8XrDz32TCqp/Sbf7aMFHuxa1RRSAoyfE7KOVEzkZN1+73WCU
 DsWCs9y6BrrIZhW6Ak4RV8EXuUCTqdR295oD+2Ao2cOPSCFeXOFHBMkiTGXOa8Jld92Y7nx
 kop0Hm/CCZdB57/cDmcsC1cCvMXb13A=
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 179CC3E524A
	for <ltp@archiver.kernel.org>; Tue, 26 May 2026 11:08:47 +0200 (CEST)
Received: from in-5.smtp.seeweb.it (in-5.smtp.seeweb.it [217.194.8.5])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 2E0313E5248
 for <ltp@lists.linux.it>; Tue, 26 May 2026 11:07:44 +0200 (CEST)
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.133.124])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-5.smtp.seeweb.it (Postfix) with ESMTPS id 36423600934
 for <ltp@lists.linux.it>; Tue, 26 May 2026 11:07:42 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1779786461;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=fWYnVuXUqS/M1EKBcXOQqwDBAxrYblmuzkfDOCRBoeM=;
 b=MoIJCKcKYJGd33ARbkrUK2Ooc9LeOXasL5LnuvTsFG8TcNIYTPCJqDYXznNOlIV1Mj8ZGN
 NFwgoBvU76FyJg5znsTuCHMMN4ZFMj8HRviWFPOE5ZroNR8tMY0TZcfDmJcfWshvs0NnlA
 +SrK1JEzz5biA5Igr35DJU5Fv8tVA6Y=
Received: from mail-wr1-f70.google.com (mail-wr1-f70.google.com
 [209.85.221.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-676-4eCW7_YIPMegweAZTxRMYw-1; Tue, 26 May 2026 05:07:39 -0400
X-MC-Unique: 4eCW7_YIPMegweAZTxRMYw-1
X-Mimecast-MFC-AGG-ID: 4eCW7_YIPMegweAZTxRMYw_1779786458
Received: by mail-wr1-f70.google.com with SMTP id
 ffacd0b85a97d-447f2ce5556so7692028f8f.2
 for <ltp@lists.linux.it>; Tue, 26 May 2026 02:07:39 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1779786458; x=1780391258;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=fWYnVuXUqS/M1EKBcXOQqwDBAxrYblmuzkfDOCRBoeM=;
 b=HV1gr7/+7GneBw22Lt7E8I57Kbw0Vw7Bxqy4Qr28Ebn3C7D8iY0Avyq69dHfMUQc5I
 RMN7p++vWkcILs2eomU0gfLvq2KTZVny4DsZlV7M1wpinjS4PbvPK4C4nsH32c2QpFaV
 Zh2cN2crHkY5zG3wduFVSoQ0s8+FOXQQ1Q0I5kjM/FrdWQ8pTsgw+d2Y7oPrwbvBAPm7
 q0DPobdHsDGXk+kyj2YMO97veRCehGYKDzeWMPS6Eamqec9e2Ug9rYc6WvOLB5Sw/e3U
 ixoWngVUzmMhrvAwH9jlaAsELuzchgWF+LhNuqc9Rl714wJSzMpuXF0XCYA7BkLKM2Fk
 NJjg==
X-Gm-Message-State: AOJu0Yw0kFpWH7jcLJp/vLQiGzTWH8/jxkBWcW0cb3B7/HECBDoCyy3f
 BVVQj+LgtzXuDW0QuLmLmvL3iy/6zWFLs86/fm/BLS0FGSPRwDR6V6h8pa6rFMs8SEH+TAHlTIf
 t282e6JlZMf+O1HK/kKm/NK0kw7dI9la3E131kkVRA4hDnUBV6RGgbOIq90CkV9o6oxjRSJGk6U
 SijiP+GeqVor1n49tj8COWxxAm4wsPEuP/1MeR
X-Gm-Gg: Acq92OES7rZxeaEvOkLrp5f++mwzDyrX3C7qu4cUPalEAWhAX17qmIMo5MaR28o/hDd
 njII1bb6ZGO5b0CTK1HXLwx7VAOqJ8sXlaRzTn+PMdZP8SEqR+40+reGENwvImCQnLm6QBtQdVf
 YCAgfF2+BQTgrnCFSgth5COXUKDasVCfg4rk3Y/8WHGennOHlzWikj5hpWT4aola5TU1RkMSbOV
 e4xPcsl4vcROTb+2PrYcoGIKrCH4f+WB3vyFqUTcGmLQERg8L9w21wMBbKtEj9m0C7GnjNnRHXK
 LP6upxxx9ESY5+W/sNjefqO0ELe+Q1ufbqYtULLRJb/6aOw3p5dfh3EfWeh+rjVIMpnviVJnL3X
 GdAEG2mMwSqE+QCOU0WeoPa+4L+yygeCf6lqFNKIaXGfNfurx4xPgz9+BEeXusg==
X-Received: by 2002:a05:6000:400c:b0:45e:64b3:af44 with SMTP id
 ffacd0b85a97d-45eb38afcf8mr29816614f8f.36.1779786458212; 
 Tue, 26 May 2026 02:07:38 -0700 (PDT)
X-Received: by 2002:a05:6000:400c:b0:45e:64b3:af44 with SMTP id
 ffacd0b85a97d-45eb38afcf8mr29816511f8f.36.1779786457580; 
 Tue, 26 May 2026 02:07:37 -0700 (PDT)
Received: from fedora.redhat.com (89-138-3-119.bb.netvision.net.il.
 [89.138.3.119]) by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-45eb6c9f58dsm33274647f8f.5.2026.05.26.02.07.35
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 26 May 2026 02:07:36 -0700 (PDT)
To: ltp@lists.linux.it
Date: Tue, 26 May 2026 12:07:28 +0300
Message-ID: <20260526090730.22455-3-mmenashe@redhat.com>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <20260526090730.22455-1-mmenashe@redhat.com>
References: <20260526090730.22455-1-mmenashe@redhat.com>
MIME-Version: 1.0
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: CJnMC_VSSFkz4RpC-VQf0VejNhOwL5_NOoF4mAb2OSA_1779786458
X-Mimecast-Originator: redhat.com
X-Virus-Scanned: clamav-milter 1.0.9 at in-5.smtp.seeweb.it
X-Virus-Status: Clean
Subject: [LTP] [PATCH v10 2/4] futex_wait07: Add EINTR error coverage test
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
