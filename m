Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D31FFCD4F3C
	for <ltp@archiver.kernel.org>; Tue, 19 May 2026 18:32:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=lists.linux.it;
 i=@lists.linux.it; q=dns/txt; s=picard; t=1779215537; h=to : date :
 message-id : in-reply-to : references : mime-version : subject :
 list-id : list-unsubscribe : list-archive : list-post : list-help :
 list-subscribe : from : reply-to : content-type :
 content-transfer-encoding : sender : from;
 bh=RyE/8hTQctoxy6zuUNEwhViRQptILJMZ5znsgM0oKs4=;
 b=j/7d83VZOzOv1jOkpMj17qyhmVn/jGF5NpnbU514TT+GKaQTeSvcD0FkDM1ehMEwDZslE
 PSRKHfm741uJs848yEamMfRmrezEzP2vAS0fyi9lPrNFZdYWmHnk17t15TZGqlyXLuXmhET
 w+SjiH2AQACCfe9kH1dtQP8Q4aYcRZ4=
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 788183C71D2
	for <ltp@archiver.kernel.org>; Tue, 19 May 2026 20:32:17 +0200 (CEST)
Received: from in-2.smtp.seeweb.it (in-2.smtp.seeweb.it
 [IPv6:2001:4b78:1:20::2])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id A59403C71F6
 for <ltp@lists.linux.it>; Tue, 19 May 2026 20:30:53 +0200 (CEST)
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.129.124])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-2.smtp.seeweb.it (Postfix) with ESMTPS id E75AD600820
 for <ltp@lists.linux.it>; Tue, 19 May 2026 20:30:52 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1779215451;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=88FFrRZ6+XvgcNYWTHf0dTDC/TFqYeh8UzvvenTvpcs=;
 b=JeXlRSrjgv7nBmxbRCSyiE+rq8ttb/nOmXjgV8apBxoAf3bgEApL8Z23Rd4EfT1OxAKtFp
 9jAbt956FN3Sn8cd6wryLj1S3Fp3GHz90h0MPkcdNc2yGmX1Zjat5sRGvrzRLWqglTNfvk
 CK60Wp1fLV4I2uc7nC2wckhdm0WSJLo=
Received: from mail-wr1-f72.google.com (mail-wr1-f72.google.com
 [209.85.221.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-523-G1lBrbmVNtWKLamVxG_LWg-1; Tue, 19 May 2026 14:30:49 -0400
X-MC-Unique: G1lBrbmVNtWKLamVxG_LWg-1
X-Mimecast-MFC-AGG-ID: G1lBrbmVNtWKLamVxG_LWg_1779215448
Received: by mail-wr1-f72.google.com with SMTP id
 ffacd0b85a97d-45e80183514so2121363f8f.3
 for <ltp@lists.linux.it>; Tue, 19 May 2026 11:30:49 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1779215448; x=1779820248;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=88FFrRZ6+XvgcNYWTHf0dTDC/TFqYeh8UzvvenTvpcs=;
 b=Orhsc3bBEPt9xrW7x6sG67nRQrSeQagV3zxcYaNFhcw/oAywnMedk93jTq6ajLMQvx
 H6nGjPoA3r5BUcPKv1NDkueBlGHZPXahqD+/RN7n1nQ7gAeCqrqPjL+msbgtOOGr0+rG
 C0f2Muf5uTqcIlrZ1oQl5f23ZTYsRptYZ7Zy1dnE13VJ6IhIngRu392EZR9YLm27aMx7
 RVxgmosFMBmMDT2npDk8iCtSSGq/zJUsFsnCCwCMxOaGD8nDGKaLf2jDhQU1L93R/tC3
 fcQ5FzADJByyPj8G3UQWd5R7bveOUSjUglacx4xMRfL9M8Y03LZ7bAPyx3R+SXymQP+M
 5tFg==
X-Gm-Message-State: AOJu0YzefQVcl3HK133ugG8bQh7jQW/U84adzGwnPUA8+/AahibwzPXh
 ODcbTFERwFCMlZquzbsB5qZkrYtpze6LW1rkoW+SMgT/YUY4lqI2yRJUAXxPrdH2p0iEdxwT7SD
 gBMhzhgJcmX9LsQTZlaYNpjLaRF4L++Kx74ZSDqeznpno4y+woFy4yrW5nMopATvI+PLUNEmjSn
 hzCCtM5DSrCDMg9X/9BKi40BE2XpRE212vM0FK
X-Gm-Gg: Acq92OGSghcRdjKRp4NqK9o1olz/Vdy+EzFBUL12hoz/mQkUg91s2Zuf5T798NFLoVZ
 MWNTg4HPC0ThO1IB+EmvIjJzaxCalBgfPaeKg/hZm3kNA2mnLT2J+r746zM9FN0axCXPD0zGz0D
 P54zyFTED+U6ao5e5M6ejE2ry3fj3L/MIoJtAMC8IBxfTCLuvGMiQvZ4lUeu9L3rUpWYJsErebW
 zEiP7mHqKyVyiidLRBLRgCSNloEaTt3sBjn4ZEO0bXwMB+eOnui/Lq4VsaT2sFYloeDmOUlQw1x
 ftOq2qExG5RpAe9NxBOlXesYLQqBvOnUNvjczny/PzSfCwaNze4czjqLF/+msd2ASqAWGUqMZHp
 slOv9TVPRazZdo9Z9f9sx+Xzj7QfYKdRl/wrM6ZhbCHSbqPoS+bK2ZVZhOkXOH+eA
X-Received: by 2002:a05:6000:2601:b0:456:e27d:d6aa with SMTP id
 ffacd0b85a97d-45e5c5b3975mr33631449f8f.2.1779215447665; 
 Tue, 19 May 2026 11:30:47 -0700 (PDT)
X-Received: by 2002:a05:6000:2601:b0:456:e27d:d6aa with SMTP id
 ffacd0b85a97d-45e5c5b3975mr33631409f8f.2.1779215447149; 
 Tue, 19 May 2026 11:30:47 -0700 (PDT)
Received: from fedora.redhat.com (89-139-213-92.bb.netvision.net.il.
 [89.139.213.92]) by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-45da0a19a0csm45128468f8f.20.2026.05.19.11.30.44
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 19 May 2026 11:30:44 -0700 (PDT)
To: ltp@lists.linux.it
Date: Tue, 19 May 2026 21:30:30 +0300
Message-ID: <20260519183031.114591-4-mmenashe@redhat.com>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <20260519183031.114591-1-mmenashe@redhat.com>
References: <20260519183031.114591-1-mmenashe@redhat.com>
MIME-Version: 1.0
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: 8DrUHArY37fK00LKe6P_Mr5DY2E2k4Qn6hQIgegWfpI_1779215448
X-Mimecast-Originator: redhat.com
X-Virus-Scanned: clamav-milter 1.0.9 at in-2.smtp.seeweb.it
X-Virus-Status: Clean
Subject: [LTP] [PATCH v5 3/4] futex_wake05: Add EFAULT error coverage test
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
 .../kernel/syscalls/futex/futex_wake05.c      | 86 +++++++++++++++++++
 3 files changed, 88 insertions(+)
 create mode 100644 testcases/kernel/syscalls/futex/futex_wake05.c

diff --git a/runtest/syscalls b/runtest/syscalls
index e428deda1..92e01452e 100644
--- a/runtest/syscalls
+++ b/runtest/syscalls
@@ -1909,3 +1909,4 @@ io_uring03 io_uring03
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
index 000000000..0540ebdc0
--- /dev/null
+++ b/testcases/kernel/syscalls/futex/futex_wake05.c
@@ -0,0 +1,86 @@
+// SPDX-License-Identifier: GPL-2.0-or-later
+/*
+ * Copyright (C) 2026 Red Hat, Inc.
+ */
+
+/*\
+ * Check that futex(FUTEX_WAKE) returns EFAULT when uaddr points to
+ * unmapped or PROT_NONE memory.
+ *
+ * Note: FUTEX_WAKE never reads *uaddr, so PROT_NONE triggers EFAULT
+ * (not EACCES). The EACCES behavior only applies to syscalls that read
+ * *uaddr (e.g. FUTEX_WAIT, FUTEX_CMP_REQUEUE).
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
