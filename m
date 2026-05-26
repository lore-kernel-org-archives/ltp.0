Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9D678CD5BC8
	for <ltp@archiver.kernel.org>; Tue, 26 May 2026 09:09:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=lists.linux.it;
 i=@lists.linux.it; q=dns/txt; s=picard; t=1779786548; h=to : date :
 message-id : in-reply-to : references : mime-version : subject :
 list-id : list-unsubscribe : list-archive : list-post : list-help :
 list-subscribe : from : reply-to : content-type :
 content-transfer-encoding : sender : from;
 bh=mu+F8Ogo09xJ5Lmu8EUXEPk0UPlp8b3ZViU3lPGchiQ=;
 b=ouSUEAdqCudfPip12HFRWRfIQgppM4BYDnmHL7C+s5MfCUvDUpjpDCAabOVJXbuTUCaIc
 Q+XJAKFM/90VIDcYxXvI9egmaeTj/YpjB2bKPBwHyirdb+BobrkiTq56TB9Ce22Cf5m8prm
 e0hdriaK747gg5a9h68w65j8kSFM7iI=
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 523F93E2069
	for <ltp@archiver.kernel.org>; Tue, 26 May 2026 11:09:08 +0200 (CEST)
Received: from in-4.smtp.seeweb.it (in-4.smtp.seeweb.it [217.194.8.4])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 26B8F3E523C
 for <ltp@lists.linux.it>; Tue, 26 May 2026 11:07:46 +0200 (CEST)
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.129.124])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-4.smtp.seeweb.it (Postfix) with ESMTPS id 716911000900
 for <ltp@lists.linux.it>; Tue, 26 May 2026 11:07:45 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1779786464;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=Mq/SUoWuHTKzmVm0bFcmUPSVSJsLhtHqpC+QvOcmieg=;
 b=iJbRFZcokXgJw0/qWP2fotj54dLaKj9e5dYeU+ee1Zs8017DXfWd+xCaot7UvEcOTE8rFS
 +pdNTD81oWPem1YVzX4soCxxVIM7dtSDO1QLDJn6JLE8IdVv21uG+2w6hDu+JfEEFq9lGV
 +/ME4L/0y84MDJufBAmmfF/y0JldFDI=
Received: from mail-wr1-f71.google.com (mail-wr1-f71.google.com
 [209.85.221.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-589-Gy9Q5XH7OVOsxUzbCAyAjA-1; Tue, 26 May 2026 05:07:42 -0400
X-MC-Unique: Gy9Q5XH7OVOsxUzbCAyAjA-1
X-Mimecast-MFC-AGG-ID: Gy9Q5XH7OVOsxUzbCAyAjA_1779786461
Received: by mail-wr1-f71.google.com with SMTP id
 ffacd0b85a97d-44d83e45febso7379691f8f.0
 for <ltp@lists.linux.it>; Tue, 26 May 2026 02:07:42 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1779786461; x=1780391261;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=Mq/SUoWuHTKzmVm0bFcmUPSVSJsLhtHqpC+QvOcmieg=;
 b=FDT2MddePSKCNrQC4CG5OtSJT6gAU0O9Bq3f7nG7luZqP5sKyQgHsNZROrQX3izDla
 MfXOZ1lG3jMkBnvjpOEpr7HfjG/PudhEyQvlItOctqkn20h8XTnBzibojtk0BfPb+Gdx
 2rVIz7uuuFuLsZ9qGFlRKXyTy5u0cTlnCvnzapkLfiUrhlQJ/jEcJ7vg7/xgBZuGU2pU
 aBbOZzZaeDBfjSQoMwJJmNB52qRLQufzFlI9NuRBrCoozv0d/ipiba7VGdQPMW8pfqIL
 xtacKG4L0DF1QncucKXZ4mXMHkOZaaNJCOvEfVt/+bXx16hS2SUtqnNKjCDLKWZt8I0M
 Ia0A==
X-Gm-Message-State: AOJu0YwVotIj1F1pBHhhG+Qf+4R4bOdfLGluhrj7u1UV+xBe4a/pKR6q
 G5xLXed07SbsunN1Hn7fCroxB3jf9gvo7LnsO8g3RW1bRByDyddqYd6YS2VHXicRx7tLeOVOATS
 K/DX7HaPztSh1a3xep9u1GEDWGmJ5YKqtumY3oG0YV+SdJWLuPJia3yYmT6z4hKq8EyV6KIkyuG
 W8eI/bpzyry1c0x9ZOXChsYMDOoisrE1QOv5xJ
X-Gm-Gg: Acq92OFNWGJmzE2O+RxjU8z1uObFRIQM5pNr09VgmXxV+NTBClsUCu+6cJC/1YIcIeY
 grue+Hg88t8FDC46mFSWGHsCkCnV5ZsPj+IN66lHFNgUamAHJ2RB2ueKLmWZIR/f/VS4373HBet
 yeZDvL/I0/sm8Om0lI5tjJvPQH1B8JBIao6eCRbCIaqkeoo2qgCZiDZjPnJp6Cr45c1sUQVBqYA
 9c/xsVmUrRVDKq28mrUS0gh6X/ZMHliE896I5OvRRMICbe1/21XSAJ8sj2PXrJFVFoblG6/irKZ
 HAwGyWSF/zJsLep4Ajhk1FyZrxhtRxqEberUsO/lPRX6mM+EAFl2HDUjKiTknUZ3jAmBkX31AxK
 xPXoV/FF4HZAel1qdOqV7HD7raXHpUwKuis+a41ncRGVw705BVFGnDSZDVT111A==
X-Received: by 2002:a05:6000:4a0c:b0:45d:2efc:dc6e with SMTP id
 ffacd0b85a97d-45eb334073fmr24972465f8f.20.1779786461507; 
 Tue, 26 May 2026 02:07:41 -0700 (PDT)
X-Received: by 2002:a05:6000:4a0c:b0:45d:2efc:dc6e with SMTP id
 ffacd0b85a97d-45eb334073fmr24972406f8f.20.1779786461090; 
 Tue, 26 May 2026 02:07:41 -0700 (PDT)
Received: from fedora.redhat.com (89-138-3-119.bb.netvision.net.il.
 [89.138.3.119]) by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-45eb6c9f58dsm33274647f8f.5.2026.05.26.02.07.39
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 26 May 2026 02:07:40 -0700 (PDT)
To: ltp@lists.linux.it
Date: Tue, 26 May 2026 12:07:30 +0300
Message-ID: <20260526090730.22455-5-mmenashe@redhat.com>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <20260526090730.22455-1-mmenashe@redhat.com>
References: <20260526090730.22455-1-mmenashe@redhat.com>
MIME-Version: 1.0
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: tT7lMHvAOsC4dBPYk9A0XfFykCAYOcIVoDR3_CxntCA_1779786461
X-Mimecast-Originator: redhat.com
X-Virus-Scanned: clamav-milter 1.0.9 at in-4.smtp.seeweb.it
X-Virus-Status: Clean
Subject: [LTP] [PATCH v10 4/4] futex_cmp_requeue03: Add EFAULT error
 coverage test
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

futex(FUTEX_CMP_REQUEUE) has no existing test for EFAULT. Add coverage
for the cases where uaddr or uaddr2 points to unmapped or inaccessible
(PROT_NONE) memory.

Signed-off-by: Michael Menasherov <mmenashe@redhat.com>
---
 runtest/syscalls                              |  1 +
 testcases/kernel/syscalls/futex/.gitignore    |  1 +
 .../syscalls/futex/futex_cmp_requeue03.c      | 98 +++++++++++++++++++
 3 files changed, 100 insertions(+)
 create mode 100644 testcases/kernel/syscalls/futex/futex_cmp_requeue03.c

diff --git a/runtest/syscalls b/runtest/syscalls
index 8c4d9be6c..87bd5aeac 100644
--- a/runtest/syscalls
+++ b/runtest/syscalls
@@ -1863,6 +1863,7 @@ perf_event_open02 perf_event_open02
 
 futex_cmp_requeue01 futex_cmp_requeue01
 futex_cmp_requeue02 futex_cmp_requeue02
+futex_cmp_requeue03 futex_cmp_requeue03
 futex_wait01 futex_wait01
 futex_wait02 futex_wait02
 futex_wait03 futex_wait03
diff --git a/testcases/kernel/syscalls/futex/.gitignore b/testcases/kernel/syscalls/futex/.gitignore
index c11546e07..231b6bd25 100644
--- a/testcases/kernel/syscalls/futex/.gitignore
+++ b/testcases/kernel/syscalls/futex/.gitignore
@@ -16,3 +16,4 @@
 /futex_wait06
 /futex_wait07
 /futex_wake05
+/futex_cmp_requeue03
diff --git a/testcases/kernel/syscalls/futex/futex_cmp_requeue03.c b/testcases/kernel/syscalls/futex/futex_cmp_requeue03.c
new file mode 100644
index 000000000..221b63b82
--- /dev/null
+++ b/testcases/kernel/syscalls/futex/futex_cmp_requeue03.c
@@ -0,0 +1,98 @@
+// SPDX-License-Identifier: GPL-2.0-or-later
+/*
+ * Copyright (C) 2026 Red Hat, Inc. Michael Menasherov <mmenashe@redhat.com>
+ */
+
+/*\
+ * Check that futex(FUTEX_CMP_REQUEUE) returns EFAULT when uaddr or
+ * uaddr2 points to unmapped memory, or when uaddr points to memory
+ * without read permission (PROT_NONE).
+ *
+ * uaddr2 is only reached after *uaddr == val passes; both are
+ * FUTEX_INITIALIZER so the comparison succeeds.
+ */
+
+#include <errno.h>
+#include <sys/mman.h>
+
+#include "futextest.h"
+
+static futex_t futex_var = FUTEX_INITIALIZER;
+static futex_t *futex_ptr = &futex_var;
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
+	futex_t **uaddr;
+	futex_t **uaddr2;
+	int exp_errno;
+} testcases[] = {
+	{
+		.desc = "uaddr unmapped",
+		.uaddr = &unmapped_addr,
+		.uaddr2 = &futex_ptr,
+		.exp_errno = EFAULT,
+	},
+	{
+		.desc = "uaddr2 unmapped",
+		.uaddr = &futex_ptr,
+		.uaddr2 = &unmapped_addr,
+		.exp_errno = EFAULT,
+	},
+	{
+		.desc = "uaddr PROT_NONE",
+		.uaddr = &prot_none_addr,
+		.uaddr2 = &futex_ptr,
+		.exp_errno = EFAULT,
+	},
+};
+
+static void run(unsigned int n)
+{
+	struct futex_test_variants *tv = &variants[tst_variant];
+	struct testcase *tc = &testcases[n];
+
+	TST_EXP_FAIL(futex_cmp_requeue(tv->fntype, *tc->uaddr, futex_var,
+		*tc->uaddr2, 1, 1, 0), tc->exp_errno, "%s", tc->desc);
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
