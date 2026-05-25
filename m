Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9163ECD5BB1
	for <ltp@archiver.kernel.org>; Mon, 25 May 2026 14:46:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=lists.linux.it;
 i=@lists.linux.it; q=dns/txt; s=picard; t=1779720360; h=to : date :
 message-id : in-reply-to : references : mime-version : subject :
 list-id : list-unsubscribe : list-archive : list-post : list-help :
 list-subscribe : from : reply-to : content-type :
 content-transfer-encoding : sender : from;
 bh=rMmIXOUwSIpY8T7AgHAEUh7Z+ibkIt05xqIw2cvFmqQ=;
 b=ZZqP5wHWy9ihbuxufh2IzIOyq1wpPKqb5FK8eQteYyMy0SX28khc6SpcvY41rBRCm42UH
 0UxcX8RDf8nhDIydpXnDUWf//L9qfg8n/Dyo79c04KEaDQPbtWQscX+TogxcLqbHKIP5wbK
 E9fb8pGPWgf6izz+FjqtKMp8YCttwY4=
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id D2A4C3E62D7
	for <ltp@archiver.kernel.org>; Mon, 25 May 2026 16:46:00 +0200 (CEST)
Received: from in-4.smtp.seeweb.it (in-4.smtp.seeweb.it [217.194.8.4])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id E761B3E62E0
 for <ltp@lists.linux.it>; Mon, 25 May 2026 16:44:42 +0200 (CEST)
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.129.124])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-4.smtp.seeweb.it (Postfix) with ESMTPS id 51498100076A
 for <ltp@lists.linux.it>; Mon, 25 May 2026 16:44:41 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1779720280;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=yc/U8Nth3LliIlNb7Ea8LTzSBPg00XiuyBK3PH0/yW8=;
 b=QeWLXAbD2PejJPUNBDshOAgohqDUaRw8+krdf/9VIWcKagRjjCz9fInff7awvNIuwM192A
 cvjcwyymTEXeQpx6MfsvGWRHJMHB77INVSOrqjftmhg7XHv+H16Y89GrR97+atpa3jqyxh
 Q4yVVJSnB+/JtL2TbAXDCaoY/O9kKBg=
Received: from mail-wr1-f72.google.com (mail-wr1-f72.google.com
 [209.85.221.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-199-sHpIHYaTNp2KyWBPL6uBCQ-1; Mon, 25 May 2026 10:44:39 -0400
X-MC-Unique: sHpIHYaTNp2KyWBPL6uBCQ-1
X-Mimecast-MFC-AGG-ID: sHpIHYaTNp2KyWBPL6uBCQ_1779720278
Received: by mail-wr1-f72.google.com with SMTP id
 ffacd0b85a97d-43d7a5b9678so6183993f8f.2
 for <ltp@lists.linux.it>; Mon, 25 May 2026 07:44:39 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1779720278; x=1780325078;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=yc/U8Nth3LliIlNb7Ea8LTzSBPg00XiuyBK3PH0/yW8=;
 b=VeB0IwktBIx6nQs6Ty2S1Qq/RRnrsq726th86+ehf3t0NGPtp5sxnqKWHeRnCpCFuR
 37gKzQ0UH8KevfpBYWZKJVPFZWoPEpwPQ340drlN02XM+s0JAaCH+1g6eKrTB4he4Nx/
 S9F9l/pV7sgLuS8ePD13BgAwqkuJo/ORX3JPwRTdrg/H3fMuw6o6kl2ZQqHIAj9zbUFH
 8MK1+iDDqlG07U4pBEG3lHqQkvjKsKSL6A5X7s0eLRd0tYT8ZmnyLmoNb4w1uAunDPpL
 V14Rj0yaf3gtAbQXHvovWS0+G2VxQ5Y44VabPhfscqmAtagUhKAnlhau7gEpsxjB5awR
 saiA==
X-Gm-Message-State: AOJu0YyxzQQkaGPChv3nyHr58F5j5YFWja22M+oDLwwQhgsiV/T5QJd2
 1c2DW9A5I9fs28DRDYAMwpKYOn2X/zgyu9y5QEqGzA7gQXu/oQOxXMHoRKHd7bEVprf5ho5mlBi
 OkVpudz25c+I9wilOuw+Urxfi7U9SCqFCc4LfdVRavT/AZdEX9RiF7LSZRQIpTCNyuZJDA7hGci
 ZHtWe+54f1EIKbJAXUvjpg0ze3kIuJxqqqkWq+
X-Gm-Gg: Acq92OGsVJYR/yxzPPJzaF4aQT4eaBOYh1xRs1P6ZH2Ki85kNQ2RpTWYT54DHl2c115
 WY4c8ZiEd2Pel0FNKhovqWN8XfsWut+T+95f4uXXP5OfJSsiYrHk2ZJ4VXu5AcY7YtlAI4S0JfU
 TW7u+f0JLkVqqxUZt+LWFDhY9CponENzVHYkLEwnmgclbZpaAU9ydQZqzPZm3grDSLzNlMs3fdA
 zXAozbIyXGf5VzxfkOzOWyLLg+KvHSkHiYbIwWj1L3HwZmzUErTi53bsJiF4FtHesmrrSlX6PaS
 FVBi+ddNnR2BZ1vzCM0d/5nESzznWcNrZo1fqjUndb21b2xbxR91+UdY0TxJZ8QQQWFYYpYY1xA
 4rW8u8SAJbu/FlY8Z5FAp6vHXM1s7+Qkn5eOKQcpT56TJO7vBGN+d6/2GsunbLQ==
X-Received: by 2002:a05:6000:1ace:b0:43d:7946:bae5 with SMTP id
 ffacd0b85a97d-45eb38c9d14mr25339638f8f.42.1779720277789; 
 Mon, 25 May 2026 07:44:37 -0700 (PDT)
X-Received: by 2002:a05:6000:1ace:b0:43d:7946:bae5 with SMTP id
 ffacd0b85a97d-45eb38c9d14mr25339536f8f.42.1779720276900; 
 Mon, 25 May 2026 07:44:36 -0700 (PDT)
Received: from fedora.redhat.com (89-138-3-119.bb.netvision.net.il.
 [89.138.3.119]) by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-45eb6ccd211sm35116518f8f.10.2026.05.25.07.44.30
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 25 May 2026 07:44:31 -0700 (PDT)
To: ltp@lists.linux.it
Date: Mon, 25 May 2026 17:44:16 +0300
Message-ID: <20260525144417.23327-4-mmenashe@redhat.com>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <20260525144417.23327-1-mmenashe@redhat.com>
References: <20260525144417.23327-1-mmenashe@redhat.com>
MIME-Version: 1.0
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: dTzYRfA9ECJSoZZG_Vq_UnTb6AzMJS8nsZSGWC-ifuY_1779720278
X-Mimecast-Originator: redhat.com
X-Virus-Scanned: clamav-milter 1.0.9 at in-4.smtp.seeweb.it
X-Virus-Status: Clean
Subject: [LTP] [PATCH v8 3/4] futex_wake05: Add EFAULT error coverage test
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
 .../kernel/syscalls/futex/futex_wake05.c      | 87 +++++++++++++++++++
 3 files changed, 89 insertions(+)
 create mode 100644 testcases/kernel/syscalls/futex/futex_wake05.c

diff --git a/runtest/syscalls b/runtest/syscalls
index c5f96adb4..2b1f6a763 100644
--- a/runtest/syscalls
+++ b/runtest/syscalls
@@ -1878,6 +1878,7 @@ futex_wake04 futex_wake04
 futex_wait_bitset01 futex_wait_bitset01
 futex_wait06 futex_wait06
 futex_wait07 futex_wait07
+futex_wake05 futex_wake05
 
 memfd_create01 memfd_create01
 memfd_create02 memfd_create02
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
index 000000000..b2b280c88
--- /dev/null
+++ b/testcases/kernel/syscalls/futex/futex_wake05.c
@@ -0,0 +1,87 @@
+// SPDX-License-Identifier: GPL-2.0-or-later
+/*
+ * Copyright (C) 2026 Red Hat, Inc. Michael Menasherov <mmenashe@redhat.com>
+ */
+
+/*\
+ * Check that futex(FUTEX_WAKE) returns EFAULT when uaddr points to
+ * unmapped or PROT_NONE memory.
+ *
+ * The test uses opflags=0 (no FUTEX_PRIVATE_FLAG), so futex_wake() takes
+ * the shared-futex path in get_futex_key() which must resolve the physical
+ * page. For PROT_NONE memory this page lookup fails with EFAULT, even though
+ * futex_wake() never reads *uaddr.
+ */
+
+#include <errno.h>
+#include <sys/mman.h>
+#include "futextest.h"
+
+static futex_t *unmapped_addr;
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
+	futex_t **addr;
+	int exp_errno;
+} testcases[] = {
+	{
+		.desc = "uaddr unmapped",
+		.addr = &unmapped_addr,
+		.exp_errno = EFAULT,
+	},
+	{
+		.desc = "uaddr PROT_NONE",
+		.addr = &prot_none_addr,
+		.exp_errno = EFAULT,
+	},
+};
+
+static void run(unsigned int n)
+{
+	struct futex_test_variants *tv = &variants[tst_variant];
+	struct testcase *tc = &testcases[n];
+
+	TST_EXP_FAIL(futex_wake(tv->fntype, *tc->addr, 1, 0),
+		tc->exp_errno, "%s", tc->desc);
+}
+
+static void setup(void)
+{
+	struct futex_test_variants *tv = &variants[tst_variant];
+	size_t pagesize = getpagesize();
+
+	tst_res(TINFO, "Testing variant: %s", tv->desc);
+	futex_supported_by_kernel(tv->fntype);
+
+	unmapped_addr = SAFE_MMAP(NULL, pagesize, PROT_READ | PROT_WRITE,
+		MAP_PRIVATE | MAP_ANONYMOUS, -1, 0);
+	SAFE_MUNMAP((void *)unmapped_addr, pagesize);
+
+	prot_none_addr = SAFE_MMAP(NULL, pagesize, PROT_NONE,
+		MAP_PRIVATE | MAP_ANONYMOUS, -1, 0);
+}
+
+static void cleanup(void)
+{
+	if (prot_none_addr)
+		SAFE_MUNMAP((void *)prot_none_addr, getpagesize());
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
2.54.0


-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
