Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1F6B6CD5BB1
	for <ltp@archiver.kernel.org>; Mon, 25 May 2026 19:05:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=lists.linux.it;
 i=@lists.linux.it; q=dns/txt; s=picard; t=1779735930; h=to : date :
 message-id : in-reply-to : references : mime-version : subject :
 list-id : list-unsubscribe : list-archive : list-post : list-help :
 list-subscribe : from : reply-to : content-type :
 content-transfer-encoding : sender : from;
 bh=rMmIXOUwSIpY8T7AgHAEUh7Z+ibkIt05xqIw2cvFmqQ=;
 b=NqUmXw2QGKaTrdK+XkXNqrL+16iMTvYLt/D/OlMjCnnSAxyomg1jI+RDEWVPgvEYK0TJ8
 4F9LRHsnOX0fgPxCxmpeIHizAi7vueyx20i9HR5yP/EOEPXgsdH7weJ9BOSqirDXoRrjOH8
 ZFgSQiZj1tpvFr5Np3puVPd1Sj5NPC8=
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 85D4F3E63B6
	for <ltp@archiver.kernel.org>; Mon, 25 May 2026 21:05:30 +0200 (CEST)
Received: from in-5.smtp.seeweb.it (in-5.smtp.seeweb.it
 [IPv6:2001:4b78:1:20::5])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id CB1743E64A6
 for <ltp@lists.linux.it>; Mon, 25 May 2026 21:03:56 +0200 (CEST)
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.129.124])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-5.smtp.seeweb.it (Postfix) with ESMTPS id 39A36600720
 for <ltp@lists.linux.it>; Mon, 25 May 2026 21:03:55 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1779735834;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=yc/U8Nth3LliIlNb7Ea8LTzSBPg00XiuyBK3PH0/yW8=;
 b=gBVo2RbmJLtR37BVNFvjqDrox+GGphyK/plpnlCGZLfaPaX5Xmx2ss1HzGD3jhijxef0G/
 KIffr0F2UYQW3E1QifdwTa8iLBi9A3HN7Z+PIi+2N2oE6ZylE3gG5zzdAl99gXNw+3AqTB
 NEjD1z9OUjs1vKI9O2szyvDTXswuFv0=
Received: from mail-wm1-f71.google.com (mail-wm1-f71.google.com
 [209.85.128.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-629-zgiojG96NJGEqBO8hVPSPA-1; Mon, 25 May 2026 15:03:53 -0400
X-MC-Unique: zgiojG96NJGEqBO8hVPSPA-1
X-Mimecast-MFC-AGG-ID: zgiojG96NJGEqBO8hVPSPA_1779735832
Received: by mail-wm1-f71.google.com with SMTP id
 5b1f17b1804b1-49047e9ca88so25799665e9.3
 for <ltp@lists.linux.it>; Mon, 25 May 2026 12:03:53 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1779735832; x=1780340632;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=yc/U8Nth3LliIlNb7Ea8LTzSBPg00XiuyBK3PH0/yW8=;
 b=D8iaZTOigNKL6REsWCGTb2M4k4HBomkDk5q95rmZq8F3rMhSYzj42J3ykmyR/GSEZ9
 vH7radjcQLuBBrpgRGa5+9Zby0dt+zD9m+ZranPy+qUSSBoTpLx69YRC5jBrnV56nOYy
 5v+6dARG1Q7zb8D+xZtnftWq8MI80j2pM/oL0zzDE0W58fngd0UWuMDNr31Wx3zWry8y
 c9AWhZVwewl5AqdW2ZbEKUi74UNkPMD/XzLJLsy5nFBHFXCr43X/aRFQNfCZ84TdNSWP
 nt3GErUC4PU1TnYoEzqJEWmYhLvCmeEOKxmayHyamP8LlgPz+PjnMu8l1A3eEvDI2z5k
 GJzw==
X-Gm-Message-State: AOJu0Yz+pIgIKpraNF3wGXGCEkmrSfg4tS4HLSBx6a3R49sJaqcJ+oRb
 8n3CQanzznuaT+4ylOTUSdh8RsYYTeESySEx83F/NNTy1hp5R30NSWxqfjRDVqPj6m7Wf/lBy8e
 XQJ01lYEtifhuqSCOdCq2f6aEhU04dslX0sUDsRVfyqzAEZzJnuROU5tQPYqebnKo5QzvpWTIFo
 /Ytc0B7GXQXcR7CC/R39ZhrB4S8S4Z/8WPDm2z
X-Gm-Gg: Acq92OGicSBBOBBtkmyIWxvva8agi2BC9YG3k9dr00ev/kaTd0cOwxPl3ZGfaUNArvp
 R0+YhrEBbA5RNtVQ8vFgsH19ZPEqcfnN6uH9HAjnV1ieNSKmGk5989AXeeSsKyzdrGLE9tri7Jc
 NJF1rMt61kel7TUqXKQOaKVBYcHK/EBuh/PoL+5k9bKd1addxEdqZdVs+O/IFR5hHNOM2DvHKFQ
 QvKlrMbtw1w5WS0qAlLOxPBiM+9AJiPbd7Vrcw2NQtGBuBblxNus2CKOp7B63EKtMOyXHGNkmm4
 N8xn2Q3RO2AcfNwjtcC4UUG+1Kb6nVfq7EjaCooua0XQTuZQAkBLxwaL5mxSLI3lpzb20EWDNm2
 zo9AB6H3UchIsZ3XAg7Yd00m9TQwpXtsp2N73wGhrv8GikZvKZSFdQQltRywNVw==
X-Received: by 2002:a05:600c:154d:b0:490:44eb:c1e4 with SMTP id
 5b1f17b1804b1-49044ebc273mr239309595e9.26.1779735832343; 
 Mon, 25 May 2026 12:03:52 -0700 (PDT)
X-Received: by 2002:a05:600c:154d:b0:490:44eb:c1e4 with SMTP id
 5b1f17b1804b1-49044ebc273mr239309105e9.26.1779735831806; 
 Mon, 25 May 2026 12:03:51 -0700 (PDT)
Received: from fedora.redhat.com (89-138-3-119.bb.netvision.net.il.
 [89.138.3.119]) by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-4904527f7f7sm397695995e9.7.2026.05.25.12.03.48
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 25 May 2026 12:03:49 -0700 (PDT)
To: ltp@lists.linux.it
Date: Mon, 25 May 2026 22:03:43 +0300
Message-ID: <20260525190344.60330-4-mmenashe@redhat.com>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <20260525190344.60330-1-mmenashe@redhat.com>
References: <20260525190344.60330-1-mmenashe@redhat.com>
MIME-Version: 1.0
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: GmZnVw3H6pEbUFs-2zZfk_Y4y5KNcxNLfNjKBxWFGdg_1779735832
X-Mimecast-Originator: redhat.com
X-Virus-Scanned: clamav-milter 1.0.9 at in-5.smtp.seeweb.it
X-Virus-Status: Clean
Subject: [LTP] [PATCH v9 3/4] futex_wake05: Add EFAULT error coverage test
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
