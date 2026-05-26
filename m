Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3BEE3CD5BB1
	for <ltp@archiver.kernel.org>; Tue, 26 May 2026 19:05:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=lists.linux.it;
 i=@lists.linux.it; q=dns/txt; s=picard; t=1779822304; h=to : date :
 message-id : in-reply-to : references : mime-version : subject :
 list-id : list-unsubscribe : list-archive : list-post : list-help :
 list-subscribe : from : reply-to : content-type :
 content-transfer-encoding : sender : from;
 bh=1MxST4vdOUyUwpE9JntP03Q4HhJqFWR3hMQN4i13FIY=;
 b=Ahdh65hOYh2rUsegpMgHAD9782fNplkXQUkkqOAzNVkPA4Fb/gdRl/PHZWW4f0pirqzc7
 DPkQ751skBt+7GyNwhv9hkHi59ALB4SEg0H5POjjUtGa1rU+JYpc9LaoL1xpk6o19Tu21/3
 0/NntXwftzX8fHQqIhr00Cv/wM4faPc=
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 7BA753C5E23
	for <ltp@archiver.kernel.org>; Tue, 26 May 2026 21:05:04 +0200 (CEST)
Received: from in-2.smtp.seeweb.it (in-2.smtp.seeweb.it [217.194.8.2])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id D8EA93C1E1C
 for <ltp@lists.linux.it>; Tue, 26 May 2026 21:04:39 +0200 (CEST)
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.133.124])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-2.smtp.seeweb.it (Postfix) with ESMTPS id 330846008A5
 for <ltp@lists.linux.it>; Tue, 26 May 2026 21:04:38 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1779822276;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=svi13SlRaGYLoWDp07POzIHGeWX7qaPJnjI/poriOMs=;
 b=GVM7G73IKxkCCBb4bFAoCvbnuChdT06vU+tr5UxB6FSV6bf52EIsL1UbnWt6ZHF8Ogijn0
 nXFDwAdsQfSa6GliK90sZou2j+oQ7Zol1kVOtfzJg3TEfBk3Fo6XHi9eHBTEF6gaQU0UyJ
 vRq5Z/tQ6a+b0B+p5O6vZIFgI5O8OCg=
Received: from mail-wr1-f72.google.com (mail-wr1-f72.google.com
 [209.85.221.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-684-jmmgx57OOSmj96UQCKwsLQ-1; Tue, 26 May 2026 15:04:35 -0400
X-MC-Unique: jmmgx57OOSmj96UQCKwsLQ-1
X-Mimecast-MFC-AGG-ID: jmmgx57OOSmj96UQCKwsLQ_1779822274
Received: by mail-wr1-f72.google.com with SMTP id
 ffacd0b85a97d-45ea38c03a1so4785115f8f.1
 for <ltp@lists.linux.it>; Tue, 26 May 2026 12:04:35 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1779822274; x=1780427074;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=svi13SlRaGYLoWDp07POzIHGeWX7qaPJnjI/poriOMs=;
 b=mS0lfblzq8Ji5KSBO7wsByB0oCbyPJjNUqD6YSah0QoP5NsMbdrSnXWUO5M7ReNtg7
 MINlNXZfldD5DZGzrL47lYyL0xH41NBC6ucB0Fb7jjsy05ZFVW18RmciKviw4bXe6/+5
 A9JdAKdQ7XeKR3mwzQTSsxyQMVTB7mzgVDYlck2xDXShUO5e1CmkLXTzdiCKjwo92wGk
 qc52qYtwBJktDlBjBMZ0PuM7riRWWxFIZtMaIai+ZEbUYdXcTZFGAY/gt8ZlBqQG8uiv
 Run2AzSbci0ckef1jrX4Z0jo/rhBcdI1sIFysvhgJOI2WCv7zt5GlzbC1TmAsHh0W+za
 +rPg==
X-Gm-Message-State: AOJu0YzkBsJs3/OUH5payBQ3MepIYoxRhgh8jwx1wKD0dHnDrehNEUKm
 3q4wrDShTw2Une9MwSxmrFTShB+wKvIx8a1e2/cI8D0AERNGGUpt6GFaX+HeREkSPiBVD/gv8Fz
 J1uu5NSBARachcWi0getw3+3eDi35l1Tu4MDd+2cqrazt8aB2o0zVUlhwVs0oqw/YmiWxOVvkg2
 dW6OPd/23tak/ZOyhV7p/lJVSKrW85sr8K4VMq
X-Gm-Gg: Acq92OG5xibvuX66DR8FUYyi2HBTKWQ90ksZ0daTL2PdnVuXCIf8U2uTlgbyrcquOOz
 pYCtB1MTadKcGV1Y2w8K0L1GYOc0TVs+caCmXrLIx63BrPKmGL62BJtd4IC1BYaMJSdhelVw4/4
 +SfyGICNUDZXazTLTzE7uiStYWi7QnCvnodqzTUuKnwfpPkZ9qxASlO+RNktBkN9f7zIKmEV3y+
 4aoS3FRkCVRnzYkG3DlG+fn7xLOD+IfZagrMwdP+LxXGK4c0RHdAnWcca3eDSNILT3W5/T1ULAU
 edF3rhSNzXlVa+F8oT7APHAJGKLt93/fvvuJbvyx0vnP44qS9YhG4LeDwb+tXf8AwsBpxSzeHAl
 wFqDssHQLbZGaMmdCcnCuEEFNUUV9PbIFHfu95isnPvlYhB1D3Gket+9p/sruuqgjGQS29FHo
X-Received: by 2002:a05:6000:4310:b0:45e:a19f:22e0 with SMTP id
 ffacd0b85a97d-45eb367ebf9mr34277873f8f.10.1779822273986; 
 Tue, 26 May 2026 12:04:33 -0700 (PDT)
X-Received: by 2002:a05:6000:4310:b0:45e:a19f:22e0 with SMTP id
 ffacd0b85a97d-45eb367ebf9mr34277814f8f.10.1779822273521; 
 Tue, 26 May 2026 12:04:33 -0700 (PDT)
Received: from fedora.redhat.com (89-138-3-119.bb.netvision.net.il.
 [89.138.3.119]) by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-45edb5b1a28sm204398f8f.26.2026.05.26.12.04.32
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 26 May 2026 12:04:33 -0700 (PDT)
To: ltp@lists.linux.it
Date: Tue, 26 May 2026 22:04:27 +0300
Message-ID: <20260526190430.129798-2-mmenashe@redhat.com>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <20260526190430.129798-1-mmenashe@redhat.com>
References: <20260526190430.129798-1-mmenashe@redhat.com>
MIME-Version: 1.0
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: WCEXtWn3q2PwIXKHzQbNbi2D4b7r5aqQaGJpDiNA5Fg_1779822274
X-Mimecast-Originator: redhat.com
X-Virus-Scanned: clamav-milter 1.0.9 at in-2.smtp.seeweb.it
X-Virus-Status: Clean
Subject: [LTP] [PATCH v12 1/4] futex_wait06: Add EFAULT error coverage test
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
 runtest/syscalls                              |  4 +
 testcases/kernel/syscalls/futex/.gitignore    |  1 +
 .../kernel/syscalls/futex/futex_wait06.c      | 75 +++++++++++++++++++
 3 files changed, 80 insertions(+)
 create mode 100644 testcases/kernel/syscalls/futex/futex_wait06.c

diff --git a/runtest/syscalls b/runtest/syscalls
index f790e8f84..87bd5aeac 100644
--- a/runtest/syscalls
+++ b/runtest/syscalls
@@ -1863,11 +1863,14 @@ perf_event_open02 perf_event_open02
 
 futex_cmp_requeue01 futex_cmp_requeue01
 futex_cmp_requeue02 futex_cmp_requeue02
+futex_cmp_requeue03 futex_cmp_requeue03
 futex_wait01 futex_wait01
 futex_wait02 futex_wait02
 futex_wait03 futex_wait03
 futex_wait04 futex_wait04
 futex_wait05 futex_wait05
+futex_wait06 futex_wait06
+futex_wait07 futex_wait07
 futex_waitv01 futex_waitv01
 futex_waitv02 futex_waitv02
 futex_waitv03 futex_waitv03
@@ -1875,6 +1878,7 @@ futex_wake01 futex_wake01
 futex_wake02 futex_wake02
 futex_wake03 futex_wake03
 futex_wake04 futex_wake04
+futex_wake05 futex_wake05
 futex_wait_bitset01 futex_wait_bitset01
 
 memfd_create01 memfd_create01
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
index 000000000..a54c0a3c5
--- /dev/null
+++ b/testcases/kernel/syscalls/futex/futex_wait06.c
@@ -0,0 +1,75 @@
+// SPDX-License-Identifier: GPL-2.0-or-later
+/*
+ * Copyright (C) 2026 Red Hat, Inc.
+ * Copyright (C) 2026 Michael Menasherov <mmenashe@redhat.com>
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
+	int bad_uaddr;
+	int bad_timeout;
+} testcases[] = {
+	{
+		.desc = "uaddr points to unmapped memory",
+		.bad_uaddr = 1,
+	},
+	{
+		.desc = "timeout points to unmapped memory",
+		.bad_timeout = 1,
+	},
+};
+
+static void run(unsigned int n)
+{
+	struct futex_test_variants *tv = &variants[tst_variant];
+	struct testcase *tc = &testcases[n];
+	struct tst_ts ts = tst_ts_from_ms(tv->tstype, 5000);
+	futex_t *uaddr = tc->bad_uaddr ? bad : &futex;
+	void *timeout = tc->bad_timeout ? (void *)bad : tst_ts_get(&ts);
+
+	TST_EXP_FAIL(futex_syscall(tv->fntype, uaddr, FUTEX_WAIT, futex,
+				   timeout, NULL, 0, 0), EFAULT, "%s", tc->desc);
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
+			MAP_PRIVATE | MAP_ANONYMOUS, -1, 0);
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
