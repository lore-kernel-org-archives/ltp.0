Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CBA8ECD5BBF
	for <ltp@archiver.kernel.org>; Mon, 25 May 2026 10:06:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=lists.linux.it;
 i=@lists.linux.it; q=dns/txt; s=picard; t=1779703602; h=to : date :
 message-id : in-reply-to : references : mime-version : subject :
 list-id : list-unsubscribe : list-archive : list-post : list-help :
 list-subscribe : from : reply-to : content-type :
 content-transfer-encoding : sender : from;
 bh=mlid8M1xsgQ8FWQf+lj1E4gPhzb3YBOYm1YTRwjtKKk=;
 b=eENM969iaehnbSudlqTTyRZTI38l3fobHxOmTpRUqd3ko1+bObvp4YtVygEtwclLPbnLK
 Ioin4CFMrZ1idt2tvCRD4S2ZCxl1+BW9pnB9e0d39ola0mQ1jpBJU1kk+QkYss9cW+Wvaqu
 oRno2Ojnc2leKDgU7BjbX641PmA7H60=
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 699073E528B
	for <ltp@archiver.kernel.org>; Mon, 25 May 2026 12:06:42 +0200 (CEST)
Received: from in-2.smtp.seeweb.it (in-2.smtp.seeweb.it [217.194.8.2])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id AE7793E5291
 for <ltp@lists.linux.it>; Mon, 25 May 2026 12:05:05 +0200 (CEST)
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.129.124])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-2.smtp.seeweb.it (Postfix) with ESMTPS id ADB2160062C
 for <ltp@lists.linux.it>; Mon, 25 May 2026 12:05:04 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1779703503;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=yNFCTjlUTtl99skcLnvVdat6pBs7xDmirkjEwusjvKQ=;
 b=S3ihzQ0lKDqS8YNWLeM/k0Q71JVffrqjFkattxlWQcrl7Z1j4WJCa/kjQVdk8hlsG9+Nsw
 6kzsckU7v/i7s8BYvnfhEGlUj2d8dllYdwvpgL0KEXMmh12YXHXcy4gRQhtkSLqmc58xUt
 Af4TcseqwOmoH65dZUj+1XfwNIn25E8=
Received: from mail-wm1-f71.google.com (mail-wm1-f71.google.com
 [209.85.128.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-341-FGe0IZdKNkaDZCSC0LWqdA-1; Mon, 25 May 2026 06:05:01 -0400
X-MC-Unique: FGe0IZdKNkaDZCSC0LWqdA-1
X-Mimecast-MFC-AGG-ID: FGe0IZdKNkaDZCSC0LWqdA_1779703500
Received: by mail-wm1-f71.google.com with SMTP id
 5b1f17b1804b1-48fe44ce385so74927755e9.0
 for <ltp@lists.linux.it>; Mon, 25 May 2026 03:05:01 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1779703500; x=1780308300;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=yNFCTjlUTtl99skcLnvVdat6pBs7xDmirkjEwusjvKQ=;
 b=d2W1vS4YtTfW3QUaYlEMggz1gPLG8eCw9pmbELOE3hCkxg2OJ1s6jqHsNUu8HuIYOV
 OTcqdjtAaYhYpVWZISxGktwFJEM94afM0+ZLKSi9/+ouKo/cRTbxneGu1C/Izz27CQol
 lxLKZsIjRQw93KDbGNFzuFCqh+QlskvuXcAhkfRw7D25bKcjjzsgeXSymV/4l/h+PJj9
 6HVcbsW6pTaudXMHJzeF7iccXCoLmCpRU7ZsYMAR01gkUWR4nB09823S9rNZWMueLspb
 6W4QjbOErARSfe1MmxAv1CgqAlbzZZpIUNuPUP6Xfc8aCOzE6NXHbQWljZBXi9UkiWVh
 XxFQ==
X-Gm-Message-State: AOJu0YxEOwhqdmM0oxlmxuQ3n4mw26gjExs9AAPZUp7Fc4fc23Nsvalt
 yAe9GD4tFwZ0J6WtsJenZzpVEAGNAikpCOLTsVSAoJHvCT8jDxaK2Dgezrd/NEvxxH9HIRoscc7
 uRghTDIJAbKjNFqHJC0keMHDw2wYN40NOfTc7QIqdchugB/DaeHRjNVy2ZJlWQ5FP2tVpM3xGQC
 7UcdUJ86gwa8ek/wD3SHtMredsT0B3P66mBjNc
X-Gm-Gg: Acq92OGp/NpGkM8zz5cpWELiAcAVPiCJ21FQ+tE00r4vrK2Pn+4bdQIVNqIdNRzcfWU
 wYJku8NVQ2+kWUpNq5Ph40iY2frgoHyUxvDjAUMjg785Z3Ie1rrzbIDh5Coqd7hN4p31MdoepKc
 rpZqn2SSS6/eAzBM+DdS9NvTbbidS9I9Na2V5bj9f0cB9yGx/Nfba7+FEMS3F2wGkelmlBfQ6Yp
 CkMcW8IjjMlwWPHDxFciUDGer8TOxZjuNtR+PEDLpfFglOCyMJq/QpUcBtxf7lG8hsScG+JAJnF
 zs5qH/gu3KgtWHjnjygBEtoVWh1Z4ON0VRJW5AUbVCrvq3Q+aDQU9e1iECiShuHdyfWAaCOMZcg
 yz4g2D0fSbAAme1PPyJprHpNBrYxAKZtElKR/Bp1fhzTa2k3kq4WfSutnAGzmNSQ+yJY=
X-Received: by 2002:a05:600c:4f0f:b0:490:50e4:7224 with SMTP id
 5b1f17b1804b1-49050e474d4mr182796765e9.3.1779703500467; 
 Mon, 25 May 2026 03:05:00 -0700 (PDT)
X-Received: by 2002:a05:600c:4f0f:b0:490:50e4:7224 with SMTP id
 5b1f17b1804b1-49050e474d4mr182796225e9.3.1779703500017; 
 Mon, 25 May 2026 03:05:00 -0700 (PDT)
Received: from fedora.redhat.com (46-116-113-151.bb.netvision.net.il.
 [46.116.113.151]) by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-490454a0b9asm236519805e9.11.2026.05.25.03.04.58
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 25 May 2026 03:04:58 -0700 (PDT)
To: ltp@lists.linux.it
Date: Mon, 25 May 2026 13:04:51 +0300
Message-ID: <20260525100452.336518-4-mmenashe@redhat.com>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <20260525100452.336518-1-mmenashe@redhat.com>
References: <20260525100452.336518-1-mmenashe@redhat.com>
MIME-Version: 1.0
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: EHrC0kzYLIoHTvFJ8GhG9cVKiYlB9cEItindtkW6h4s_1779703500
X-Mimecast-Originator: redhat.com
X-Virus-Scanned: clamav-milter 1.0.9 at in-2.smtp.seeweb.it
X-Virus-Status: Clean
Subject: [LTP] [PATCH v7 3/4] futex_wake05: Add EFAULT error coverage test
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
index 000000000..999571b95
--- /dev/null
+++ b/testcases/kernel/syscalls/futex/futex_wake05.c
@@ -0,0 +1,85 @@
+// SPDX-License-Identifier: GPL-2.0-or-later
+/*
+ * Copyright (C) 2026 Red Hat, Inc. Michael Menasherov <mmenashe@redhat.com>
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
