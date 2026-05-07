Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 41FA3CD343F
	for <ltp@archiver.kernel.org>; Thu,  7 May 2026 11:19:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=lists.linux.it;
 i=@lists.linux.it; q=dns/txt; s=picard; t=1778152797; h=to : date :
 message-id : in-reply-to : references : mime-version : subject :
 list-id : list-unsubscribe : list-archive : list-post : list-help :
 list-subscribe : from : reply-to : content-type :
 content-transfer-encoding : sender : from;
 bh=Bf/Uvu6omqErBOKvCdN2IeGrafuctcxk7MU7tqUeeTU=;
 b=RCwvdBliwhZXXNUAHvThLqG3DJPgz8GZiaQKFbe3H3MoulS0GkZR/V7SqC9/yTQLRNRLu
 Wp6JuZJH5El4mgcB2UH1CO+Ldmegs4Utr5fJ4emGKVSS9GSU1h4A4XIEp5FxeE5brdlqhGO
 iOy9Lc8UTb08aO4a0W4TlpMsSeGuFhQ=
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id ED9903E2688
	for <ltp@archiver.kernel.org>; Thu,  7 May 2026 13:19:56 +0200 (CEST)
Received: from in-2.smtp.seeweb.it (in-2.smtp.seeweb.it
 [IPv6:2001:4b78:1:20::2])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 5D6063E2C3A
 for <ltp@lists.linux.it>; Thu,  7 May 2026 13:18:23 +0200 (CEST)
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.129.124])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-2.smtp.seeweb.it (Postfix) with ESMTPS id BDD58600050
 for <ltp@lists.linux.it>; Thu,  7 May 2026 13:18:22 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1778152701;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=Q+DRJLTO4Atw3WkmQqAaderDSQXvqb5bmyDiQ9WuBrQ=;
 b=YsOs6KmaXLIm2F/NV3VBKpKEikRzRce3DaSrf/d6GhWcRqfHaHzrWjTbRWTtAIHdFUyNz6
 MifFMchl5krqfc0Z2f4F8FEDJ9mdUy9jCNq+IYk0rhlXYXvKtTk3hQ28J0SXj2HC84BPVh
 i0Q9EhxREiYfQoscUfU8XBgKjZ/+k+s=
Received: from mail-wm1-f72.google.com (mail-wm1-f72.google.com
 [209.85.128.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-659-Nm-_ikc8MoyKWHyT0LnNmg-1; Thu, 07 May 2026 07:18:20 -0400
X-MC-Unique: Nm-_ikc8MoyKWHyT0LnNmg-1
X-Mimecast-MFC-AGG-ID: Nm-_ikc8MoyKWHyT0LnNmg_1778152699
Received: by mail-wm1-f72.google.com with SMTP id
 5b1f17b1804b1-488c2aa6becso5712505e9.2
 for <ltp@lists.linux.it>; Thu, 07 May 2026 04:18:20 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1778152698; x=1778757498;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=Q+DRJLTO4Atw3WkmQqAaderDSQXvqb5bmyDiQ9WuBrQ=;
 b=XPYP5fIYoSJmI6Z3t+UX+WArdW+DUTATY4lrAowb0b1SVlT0GBlIaYYrw+ssyNoOOS
 t7MNz24cjSpzQnKiP4hlMbzc8aQtrhK1HpWpetxR3xLRprA/rUJmV3mehdvYixf6YFlV
 T9fT7JHN3/UZJKSNJu7MOu2VSos24a1Cyhok7ZV67nW5sd9Ti7k7YyGiV34IXfllVafK
 ACHGw+52jNdZyIWRpNMUBHI9toSkumYq97HUHkaw9sKtoUlUx1+Zjj72I8UfpeHIT+k8
 kQ4kQU925QqrnxV8die32KgHFxG34Yoc9wkrqtH5aZvnfB16gCgSh0GneSlmiDhg5NjP
 Kfpw==
X-Gm-Message-State: AOJu0YwTmSAADU2Ygn0yqZ6kJL2/RwZTz/4388B/Gs/lvui1nALbIOZk
 uJQZ+kAlAOd0n9yUtX3Utg5aFukB/1sge6AcPaX4orIVIi9LrMFzpMUOCiet3rMVWPjbFMIDfme
 Lf/jAnZ/I8sIl+agHkbTMeF4z9r3Pu230lvjYmOG3/weePI6N+mdj02Rbq/NuIfGNPhvusmH8ps
 K/1WJ+UhcRJIUItWghhZIZBemeEPCVKQ9T2mDZ
X-Gm-Gg: AeBDievhqVotFRhRqDoaSpFUToHW3mF5veRxIpvgi2sdN5irtVriyHFCUsGkQqlrbh4
 KmvP1Ps1iTXTt6kLBuyyZReQgjFSBtGKhTUBLHMbYeOWg031L01RL/ELLCxCiV76iqo1Y9kOIFm
 KjmDokkThmEnVNQDutS6Ejadp9A1nfR9g03HeAxEszYFfcLBOnOVxDZ6Wbz0uc9HONzuYgLW+s6
 yFDnfkbnY3P0HfwEUo5iXdf/JvDbDK9y6VG9Z+DALQSiQujqIL9BJfM4+TMb627TIQrMOFxWQgv
 /j+VOpriZwv9lc4vVw+fYuVUZIRMFVaVuqRqxnLvRPbIuGc405xCqQHyXbPcORR8JgHUJ7aIaa3
 oPnCUTMHZSuRcq/uL7tTqn3+vXfe0eOxG+wq5/Bdlw83AwDgQ9orLx73ttqrqrfOrmhw=
X-Received: by 2002:a05:600c:a10d:b0:48a:53ea:13df with SMTP id
 5b1f17b1804b1-48e51f21f39mr86075035e9.2.1778152698555; 
 Thu, 07 May 2026 04:18:18 -0700 (PDT)
X-Received: by 2002:a05:600c:a10d:b0:48a:53ea:13df with SMTP id
 5b1f17b1804b1-48e51f21f39mr86074585e9.2.1778152697919; 
 Thu, 07 May 2026 04:18:17 -0700 (PDT)
Received: from fedora.redhat.com (85.65.168.167.dynamic.barak-online.net.
 [85.65.168.167]) by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-48e530cf964sm74515835e9.1.2026.05.07.04.18.15
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 07 May 2026 04:18:15 -0700 (PDT)
To: ltp@lists.linux.it
Date: Thu,  7 May 2026 14:18:08 +0300
Message-ID: <20260507111809.28934-4-mmenashe@redhat.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260507111809.28934-1-mmenashe@redhat.com>
References: <20260507111809.28934-1-mmenashe@redhat.com>
MIME-Version: 1.0
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: OmqF9900HUae46sGlw7-JcfT30O-ZXA1gDssHVzOYBA_1778152699
X-Mimecast-Originator: redhat.com
X-Virus-Scanned: clamav-milter 1.0.9 at in-2.smtp.seeweb.it
X-Virus-Status: Clean
Subject: [LTP] [PATCH v4 3/4] futex_wake05: Add EFAULT error coverage test
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

futex(FUTEX_WAKE) has no existing test for EFAULT. Add coverage for
the cases where uaddr points to unmapped or PROT_NONE memory.

Signed-off-by: Michael Menasherov <mmenashe@redhat.com>
---
 runtest/syscalls                              |  1 +
 testcases/kernel/syscalls/futex/.gitignore    |  1 +
 .../kernel/syscalls/futex/futex_wake05.c      | 85 +++++++++++++++++++
 3 files changed, 87 insertions(+)
 create mode 100644 testcases/kernel/syscalls/futex/futex_wake05.c

diff --git a/runtest/syscalls b/runtest/syscalls
index 75b7754db..4d85a1d26 100644
--- a/runtest/syscalls
+++ b/runtest/syscalls
@@ -1907,3 +1907,4 @@ io_uring03 io_uring03
 perf_event_open03 perf_event_open03
 futex_wait06 futex_wait06
 futex_wait07 futex_wait07
+futex_wake05 futex_wake05
diff --git a/testcases/kernel/syscalls/futex/.gitignore b/testcases/kernel/syscalls/futex/.gitignore
index 74ac9a926..c11546e07 100644
--- a/testcases/kernel/syscalls/futex/.gitignore
+++ b/testcases/kernel/syscalls/futex/.gitignore
@@ -15,3 +15,4 @@
 /futex_waitv03
 /futex_wait06
 /futex_wait07
+/futex_wake05
diff --git a/testcases/kernel/syscalls/futex/futex_wake05.c b/testcases/kernel/syscalls/futex/futex_wake05.c
new file mode 100644
index 000000000..654bf96b5
--- /dev/null
+++ b/testcases/kernel/syscalls/futex/futex_wake05.c
@@ -0,0 +1,85 @@
+// SPDX-License-Identifier: GPL-2.0-or-later
+/*
+ * Copyright (C) 2026 Red Hat, Inc.
+ */
+
+/*\
+ * Check that futex(FUTEX_WAKE) returns EFAULT when uaddr points to
+ * unmapped or PROT_NONE memory.
+ *
+ * PROT_NONE memory triggers EFAULT because the kernel cannot look up
+ * the futex key for an inaccessible page.
+ */
+
+#include <errno.h>
+#include <sys/mman.h>
+#include "futextest.h"
+
+static futex_t *prot_none_addr;
+
+static struct futex_test_variants variants[] = {
+#if (__NR_futex != __LTP__NR_INVALID_SYSCALL)
+	{ .fntype = FUTEX_FN_FUTEX, .desc = "syscall with old kernel spec"},
+#endif
+
+#if (__NR_futex_time64 != __LTP__NR_INVALID_SYSCALL)
+	{ .fntype = FUTEX_FN_FUTEX64, .desc = "syscall time64 with kernel spec"},
+#endif
+};
+
+static struct testcase {
+	const char *desc;
+	futex_t *addr;
+	int exp_errno;
+} testcases[2];
+
+static void run(unsigned int n)
+{
+	struct futex_test_variants *tv = &variants[tst_variant];
+	struct testcase *tc = &testcases[n];
+
+	TST_EXP_FAIL(futex_wake(tv->fntype, tc->addr, 1, 0),
+		tc->exp_errno, "%s", tc->desc);
+}
+
+static void setup(void)
+{
+	struct futex_test_variants *tv = &variants[tst_variant];
+	size_t pagesize = getpagesize();
+	futex_t *unmapped;
+
+	tst_res(TINFO, "Testing variant: %s", tv->desc);
+	futex_supported_by_kernel(tv->fntype);
+
+	unmapped = SAFE_MMAP(NULL, pagesize, PROT_READ | PROT_WRITE,
+		MAP_PRIVATE | MAP_ANONYMOUS, -1, 0);
+	SAFE_MUNMAP(unmapped, pagesize);
+
+	prot_none_addr = SAFE_MMAP(NULL, pagesize, PROT_NONE,
+		MAP_PRIVATE | MAP_ANONYMOUS, -1, 0);
+
+	testcases[0] = (struct testcase){
+		.desc = "uaddr unmapped",
+		.addr = unmapped,
+		.exp_errno = EFAULT,
+	};
+	testcases[1] = (struct testcase){
+		.desc = "uaddr PROT_NONE",
+		.addr = prot_none_addr,
+		.exp_errno = EFAULT,
+	};
+}
+
+static void cleanup(void)
+{
+	if (prot_none_addr)
+		SAFE_MUNMAP(prot_none_addr, getpagesize());
+}
+
+static struct tst_test test = {
+	.setup = setup,
+	.cleanup = cleanup,
+	.test = run,
+	.tcnt = ARRAY_SIZE(testcases),
+	.test_variants = ARRAY_SIZE(variants),
+};
-- 
2.53.0


-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
