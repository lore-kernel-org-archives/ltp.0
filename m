Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4AD71CD5BB1
	for <ltp@archiver.kernel.org>; Mon, 25 May 2026 14:45:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=lists.linux.it;
 i=@lists.linux.it; q=dns/txt; s=picard; t=1779720317; h=to : date :
 message-id : in-reply-to : references : mime-version : subject :
 list-id : list-unsubscribe : list-archive : list-post : list-help :
 list-subscribe : from : reply-to : content-type :
 content-transfer-encoding : sender : from;
 bh=y+E0Lx4Id1nXobPZGShI49eLEc3CQWHv27OMi3/g+fw=;
 b=qExyVQ8D73IoBqYz2YhKxc4LxXUEwXdEVT6WhbthZpLUWULoHg3PnTiV5yzDFqR9dl3H3
 9HkR48nt8hRp14AH/HhOveBQGVT2KHOWZNQqZ+1cpv6vxQR4E7bfX59wd+mtK75zRmgtmK1
 wM5tXlL0dR6X61w0txAI5kmbWpeds7Q=
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id D66A53E1169
	for <ltp@archiver.kernel.org>; Mon, 25 May 2026 16:45:17 +0200 (CEST)
Received: from in-6.smtp.seeweb.it (in-6.smtp.seeweb.it [217.194.8.6])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 0EE743E52B8
 for <ltp@lists.linux.it>; Mon, 25 May 2026 16:44:34 +0200 (CEST)
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.129.124])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-6.smtp.seeweb.it (Postfix) with ESMTPS id 30719140055D
 for <ltp@lists.linux.it>; Mon, 25 May 2026 16:44:32 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1779720271;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=fxC/SWJRQKWHlJ8jwF9sVBmDgPs4Gc/iFyFRNpJyVcI=;
 b=cBNaD3K+0SYjI2w4lw8zLXmO8DpwWUpsWYrOn4M8EchctE0zlPWJ5UXwA1JNxzNzR3EvQn
 tH5dhcWabWqVZBPn7eMJnmsPTBLW2ErIIS44Be4feLVjqmRdz0Bcjdpbdts6bpAteEBRFC
 DsQfw6B7YsEFP/2YkSGDd3hhMqZ2Q10=
Received: from mail-wm1-f71.google.com (mail-wm1-f71.google.com
 [209.85.128.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-627-tWgFDuKEOn2aBFi5ZgVk8Q-1; Mon, 25 May 2026 10:44:29 -0400
X-MC-Unique: tWgFDuKEOn2aBFi5ZgVk8Q-1
X-Mimecast-MFC-AGG-ID: tWgFDuKEOn2aBFi5ZgVk8Q_1779720269
Received: by mail-wm1-f71.google.com with SMTP id
 5b1f17b1804b1-490402ae2c1so34138035e9.0
 for <ltp@lists.linux.it>; Mon, 25 May 2026 07:44:29 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1779720268; x=1780325068;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=fxC/SWJRQKWHlJ8jwF9sVBmDgPs4Gc/iFyFRNpJyVcI=;
 b=E2v5QQonR+5xYEZKkC7USVSkycX+eBtGmxHqkTeR7XZg2xW7PH3bpSn/F/vV8wtL+R
 dZ5SbEvcs5dC2KRvuhrZdsgLgecbwwYlINRLDRH4PILHazQ3DR5RH+ElqzQZ02nEJnjg
 89Z6pr3bMp3vyo6sWlpAbB9rBtbWYNT2wofQS30EuYdomAjw5MGYy//bI5IDVcYoXfDs
 z0oyBrKlBZ6Z5ww17ZMWkoWJ3Q92rtu5jkc6Jkgb7rMpHtRas5cthMwa9r7sGGl2xUJC
 vPtDYLFKX02UbTZUeAVAFoolGMUEWZMFc+KcRbFfq6b38Les+hNO1J7hJvu48ZeC40/6
 09LA==
X-Gm-Message-State: AOJu0YwnR9BD3jJCL+OCaIV2UdpwujjDKFZqpqb+zLY1/cqUZHluys1Q
 9qHBdBcvMJ4AwI3+ay6jbebzAWVdl6SqH9vWAaC4YkVeIMI/Cua+lYTXjasiY2cJNJFhhYU6H9+
 Jf4gKzGA4Tm1apymDRLRFFVq1ZxzmggVcnAkO0FmSOll9tsIuAZr64SLl6EXgHSAGiHUrrSGqrW
 Ct35nrTsB4B4NQXnoJHdghXkWkQo8ST3TMosP4
X-Gm-Gg: Acq92OH8dr5VtecUxR5PutRQfJM4k7isnzIVhjwJhTBhTH7Pe55a7bNLhUu1HTMGtcS
 ysWBuiXLibYUEUkRzldvBaBAejyI3O8WyXkjmsN8Q23cmwGWCS6b71D+QhqTpSZ0gSUeQ6u1/KN
 fn4NTN2utMERo0oS7P5LqwGQhuF1iW9FEWp8C1mPHd4G6oLKQ9NbwnLIuIPpNAq2e7cCjRnRUL1
 bGnJiUtaDDJJrSuM/4idxtZdeb+LnHnOf2DXHlILEREpBdKZJl505ONZUAHmFXGcmEwF6UJ1mNC
 NNmmA88CQEtZBLfX0UX8vjjlpZYH0gwhTH7qEYQfBO+QHx0U4G3b0Ra4W2pA/yMFV+diZUz89sO
 dgsmE5aYJGREb0kbjctpzf5+gDjzMt3pvNIjI5b4SgpLvLdhosyTSKjtnw5eKaA==
X-Received: by 2002:a05:600c:6b12:b0:488:7d5b:125d with SMTP id
 5b1f17b1804b1-49035f2e4f2mr198759905e9.7.1779720268521; 
 Mon, 25 May 2026 07:44:28 -0700 (PDT)
X-Received: by 2002:a05:600c:6b12:b0:488:7d5b:125d with SMTP id
 5b1f17b1804b1-49035f2e4f2mr198759455e9.7.1779720267945; 
 Mon, 25 May 2026 07:44:27 -0700 (PDT)
Received: from fedora.redhat.com (89-138-3-119.bb.netvision.net.il.
 [89.138.3.119]) by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-45eb6ccd211sm35116518f8f.10.2026.05.25.07.44.21
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 25 May 2026 07:44:22 -0700 (PDT)
To: ltp@lists.linux.it
Date: Mon, 25 May 2026 17:44:14 +0300
Message-ID: <20260525144417.23327-2-mmenashe@redhat.com>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <20260525144417.23327-1-mmenashe@redhat.com>
References: <20260525144417.23327-1-mmenashe@redhat.com>
MIME-Version: 1.0
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: 8IxDVkM16MX2ou4Dr1j6pCtNc9SvnZylbVqDxdHlORI_1779720269
X-Mimecast-Originator: redhat.com
X-Virus-Scanned: clamav-milter 1.0.9 at in-6.smtp.seeweb.it
X-Virus-Status: Clean
Subject: [LTP] [PATCH v8 1/4] futex_wait06: Add EFAULT error coverage test
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
 runtest/syscalls                              |  1 +
 testcases/kernel/syscalls/futex/.gitignore    |  1 +
 .../kernel/syscalls/futex/futex_wait06.c      | 75 +++++++++++++++++++
 3 files changed, 77 insertions(+)
 create mode 100644 testcases/kernel/syscalls/futex/futex_wait06.c

diff --git a/runtest/syscalls b/runtest/syscalls
index f790e8f84..8d93c0e40 100644
--- a/runtest/syscalls
+++ b/runtest/syscalls
@@ -1876,6 +1876,7 @@ futex_wake02 futex_wake02
 futex_wake03 futex_wake03
 futex_wake04 futex_wake04
 futex_wait_bitset01 futex_wait_bitset01
+futex_wait06 futex_wait06
 
 memfd_create01 memfd_create01
 memfd_create02 memfd_create02
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
index 000000000..2cf509ee1
--- /dev/null
+++ b/testcases/kernel/syscalls/futex/futex_wait06.c
@@ -0,0 +1,75 @@
+// SPDX-License-Identifier: GPL-2.0-or-later
+/*
+ * Copyright (C) 2026 Red Hat, Inc. Michael Menasherov <mmenashe@redhat.com>
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
+	futex_t **uaddr;
+	void **timeout;
+} testcases[] = {
+	{
+		.desc = "uaddr points to unmapped memory",
+		.uaddr = &bad,
+		.timeout = NULL,
+	},
+	{
+		.desc = "timeout points to unmapped memory",
+		.uaddr = NULL,
+		.timeout = (void **)&bad,
+	},
+};
+
+static void run(unsigned int n)
+{
+	struct futex_test_variants *tv = &variants[tst_variant];
+	struct testcase *tc = &testcases[n];
+	futex_t *uaddr = tc->uaddr ? *tc->uaddr : &futex;
+	void *timeout = tc->timeout ? *tc->timeout : NULL;
+
+	TST_EXP_FAIL(futex_syscall(tv->fntype, uaddr, FUTEX_WAIT, futex,
+		timeout, NULL, 0, 0), EFAULT, "%s", tc->desc);
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
+		MAP_PRIVATE | MAP_ANONYMOUS, -1, 0);
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
