Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 77EAECD4F5E
	for <ltp@archiver.kernel.org>; Wed, 20 May 2026 07:46:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=lists.linux.it;
 i=@lists.linux.it; q=dns/txt; s=picard; t=1779263201; h=to : date :
 message-id : in-reply-to : references : mime-version : subject :
 list-id : list-unsubscribe : list-archive : list-post : list-help :
 list-subscribe : from : reply-to : content-type :
 content-transfer-encoding : sender : from;
 bh=RyE/8hTQctoxy6zuUNEwhViRQptILJMZ5znsgM0oKs4=;
 b=iZXRltddljiAkplFJ7Cz6+6IwwbjjpOQ8mutTv6d1LohuVnZmeDJSOFwebLdI67AHeQp3
 umcJ0E1aTMgrvcMAA5nGB89ToRmShOEf/Beooyxna13k6axgKPhGqZgUoYj/G1gJFNYvIhE
 uHLgZio1y/8PfA2CdfDCUMCWoAgEjaY=
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 6910F3C730C
	for <ltp@archiver.kernel.org>; Wed, 20 May 2026 09:46:41 +0200 (CEST)
Received: from in-7.smtp.seeweb.it (in-7.smtp.seeweb.it [217.194.8.7])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 195643C72E3
 for <ltp@lists.linux.it>; Wed, 20 May 2026 09:44:53 +0200 (CEST)
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.133.124])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-7.smtp.seeweb.it (Postfix) with ESMTPS id 07C0D2009C4
 for <ltp@lists.linux.it>; Wed, 20 May 2026 09:44:49 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1779263085;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=88FFrRZ6+XvgcNYWTHf0dTDC/TFqYeh8UzvvenTvpcs=;
 b=cMM3ZiBFuo84gfHcQKzp0T4AEFWvZG3m576x4HELKbzpNRxpjx7HlzfjPSHXSBKf53a3i0
 Z7xeAZ7wW/3kS7MeSYbl2kbKT2w5NH9pGMTNNs0lSvmxJ01FTFDbIUL6N0VJot3RtTsJGV
 kqJF1Ftc1Mxjv+p5ydzeD5HwnJBRM1o=
Received: from mail-wm1-f70.google.com (mail-wm1-f70.google.com
 [209.85.128.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-312-D3PwJy0aOX-QpMB55icPxA-1; Wed, 20 May 2026 03:44:38 -0400
X-MC-Unique: D3PwJy0aOX-QpMB55icPxA-1
X-Mimecast-MFC-AGG-ID: D3PwJy0aOX-QpMB55icPxA_1779263077
Received: by mail-wm1-f70.google.com with SMTP id
 5b1f17b1804b1-48fe6894f3fso26440835e9.2
 for <ltp@lists.linux.it>; Wed, 20 May 2026 00:44:37 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1779263076; x=1779867876;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=88FFrRZ6+XvgcNYWTHf0dTDC/TFqYeh8UzvvenTvpcs=;
 b=o4JnXFxPgV0jaHKxHnAVdkxrhiHEKnoes7tMiqKKPj5hyzubJLQSmvlzYgNTHsdux+
 jPQqF8YHywUUIiVwnR422p33C/1TcjusGtu0f1V8toV7HNbiOaRWe1Sf0CR9HJQz29kV
 m3TYS+WhNDQ5zkv9hOVeplZFqKyIuH8KGuvnAf42Hs8tKSRvns84ONellZjOA9IzwOpu
 VZpLOyl/gIBQjP8OtQNZnD5mwqnI04+q/RMXy2PfcqiT6EsWUxuq50nTb8wLAZc9rm09
 DwMMV1i+88hfnlsa444u4G+aEdzgsh8xd3TeF154NFvlo5ANdYE283jL267z6vimRCLR
 tHiQ==
X-Gm-Message-State: AOJu0YxZZaFKOn/Yj2hbKIFctatp/Or6M1Ec4UyqPdnFIzvI1Ny080CX
 VucFJhDd6HHspqW/ejqQKbDvxLBFNP8RWvlxfmwv94es/T3M5BGu2sbAKDHPGID5ALfk7sMPfKN
 A+c0PM7Kb4KAQmjBje684rWQ0jayyqoRJ2z/eMvFhsClOwxzk8GsZucVukyx6FgKEo1zR3zjsaD
 CJE58mKagXmZZAGJK75lPObvz0USC509T3uedJ
X-Gm-Gg: Acq92OGHXYyJuWZUBliJQv6CwtSd2IC/pXILTHisQv+vzhxdu3O2pw4nZOvuFHn1byZ
 Z9QRtH+jQ/85YDI4Y26p9UUNB29REH0o1+kfcfh8GSeBzApw9ObOKXOWtv+W4d05P8QYSvo6xR0
 C0WAh0MMuM+H6vTPPTc70y6upM82350tHvQkgtEFXsMm7jj4CG+KqIiM6yfyTivINe+W2mRqu5n
 DMi9Z0PZnpjJM7kUkxT+i1KMt+KaYF4hrsBV1PdknWdr8sTK9z1CvRsUDk2w+JGD7n5d6BsZa4F
 p3d6eblE1OwKXKCFum36cRv30k6QPkp3PZWKw7MYHXjLN7/6owJbR5cFCFM9CJuq5PLnUnurrB9
 EnMAHOtDCibdKMkBuXcDlN+aR3qC7jFA=
X-Received: by 2002:a05:600c:870c:b0:490:320:949 with SMTP id
 5b1f17b1804b1-490032009f3mr216041355e9.27.1779263076547; 
 Wed, 20 May 2026 00:44:36 -0700 (PDT)
X-Received: by 2002:a05:600c:870c:b0:490:320:949 with SMTP id
 5b1f17b1804b1-490032009f3mr216040835e9.27.1779263076046; 
 Wed, 20 May 2026 00:44:36 -0700 (PDT)
Received: from fedora.tlv.redhat.com ([5.28.174.82])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-48feb8d838dsm127721625e9.1.2026.05.20.00.44.34
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 20 May 2026 00:44:35 -0700 (PDT)
To: ltp@lists.linux.it
Date: Wed, 20 May 2026 10:44:26 +0300
Message-ID: <20260520074427.39155-4-mmenashe@redhat.com>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <20260520074427.39155-1-mmenashe@redhat.com>
References: <20260520074427.39155-1-mmenashe@redhat.com>
MIME-Version: 1.0
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: YLQkdQjhN4jFGVETMKFinIq35b8ygD_GwwmhRY6gTMc_1779263077
X-Mimecast-Originator: redhat.com
X-Virus-Scanned: clamav-milter 1.0.9 at in-7.smtp.seeweb.it
X-Virus-Status: Clean
Subject: [LTP] [PATCH v6 3/4] futex_wake05: Add EFAULT error coverage test
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
