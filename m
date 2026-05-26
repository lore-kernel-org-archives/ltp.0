Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BDA47CD5BB1
	for <ltp@archiver.kernel.org>; Tue, 26 May 2026 19:06:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=lists.linux.it;
 i=@lists.linux.it; q=dns/txt; s=picard; t=1779822368; h=to : date :
 message-id : in-reply-to : references : mime-version : subject :
 list-id : list-unsubscribe : list-archive : list-post : list-help :
 list-subscribe : from : reply-to : content-type :
 content-transfer-encoding : sender : from;
 bh=mLxDdg36d9nhZZAm2Rehff42NnpJbgbhWItDSwok9+U=;
 b=oK7Dlat3fcuQZFNvLZKe3oTd744Hn+OAk8S97YaLZdMTF/YfYdo0Z0UaJxQtm6MaN2WcI
 nntMyRj1kC6JEKGXWkdqhqv7+7TDd6gzBFAJMo+raht0/WAMYwu65ZpwM5HK1zFKpXQhqs/
 KgonRZ0LWUh326UMVLmZjSbtqY1Kf48=
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 7C5153C732C
	for <ltp@archiver.kernel.org>; Tue, 26 May 2026 21:06:08 +0200 (CEST)
Received: from in-7.smtp.seeweb.it (in-7.smtp.seeweb.it [217.194.8.7])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 968E63C6FF5
 for <ltp@lists.linux.it>; Tue, 26 May 2026 21:04:43 +0200 (CEST)
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.133.124])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-7.smtp.seeweb.it (Postfix) with ESMTPS id E47A320092C
 for <ltp@lists.linux.it>; Tue, 26 May 2026 21:04:42 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1779822281;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=rq/6ENYd/zTEhytCu2erYOftk0+gjkvzJKVyNXcFHoc=;
 b=LpS5gquyUwOwNHdxmEugMKUrn132L3DgB6gYMUbAYgYqf7NCsbafbX5Ovddm6VhAauGYxB
 S0yhvjpSBhW6TnkARUU6QTbaYyaMmlneo1iw17NmlPLEs7oqV/FfQ0wFMnLS+xVNHb/pF0
 SpuQ40YOQLBVtuON50lmx7HDvVf9Kxw=
Received: from mail-wm1-f70.google.com (mail-wm1-f70.google.com
 [209.85.128.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-194-HGNe9fEzMZmZbmZoeIAdKA-1; Tue, 26 May 2026 15:04:40 -0400
X-MC-Unique: HGNe9fEzMZmZbmZoeIAdKA-1
X-Mimecast-MFC-AGG-ID: HGNe9fEzMZmZbmZoeIAdKA_1779822279
Received: by mail-wm1-f70.google.com with SMTP id
 5b1f17b1804b1-49045243094so64428875e9.2
 for <ltp@lists.linux.it>; Tue, 26 May 2026 12:04:40 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1779822279; x=1780427079;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=rq/6ENYd/zTEhytCu2erYOftk0+gjkvzJKVyNXcFHoc=;
 b=GNoJmI9jZmxNUjGe5yUph4PRHj5xc0y0k55Nj+o8EnzHXepzPfK23JBcjQdoszuoAr
 o2mSjv5cTlgW6PL/sybbvrEVFOSKMATR4YVI3XU9cxTNZv+eX3p5RJ1LQAo6BQYU5mOe
 pbaCgxin49mrnYLgLxrFbCxyQxmfK6b3NCF/jz7Z1jLG6zz2TtjIReGZ4DxUJ7jQB6Wg
 +pl2Ytt0Dlso35vHIGMM/pDvrrQV6hcdtnXGqwsYC30yi2PsmiVRNX9yICwxPXtptaMn
 ksiw7GYwZxC8LfZH5wk5H45rxLkCEWHqw5QpKUjS5ZaCMbDSdbxOUpnnRQ+STMCa+9tC
 mh3w==
X-Gm-Message-State: AOJu0Yy17RXotajbBrnUirGlUtZ5IsnxUlFazdmc0vz13HsT5zChLAh8
 kcfZF1NSPXecWGecoycyhJCrEEBTtkPxLK8hH0Pn/9e6BcaLRFwYEsbqHYF7bbihtJe+p/iPQsz
 CquU9Qnlmu3xNuNiL9nuLjO0vvgAZkrWjmf8UkVLpH0ndp9I18upD3NeaReqiBeNO/Wvv85QJp1
 9rCYffH0jtKiRIOeMVO9rsmVXP8yL1xAYMsY+q
X-Gm-Gg: Acq92OGyySfdygSYG12RSqDmOmgVTm84NfeLvnY2UBUJ6sTrXbByMrwzI6HH7Zv8guu
 42UK35wSIb/ft5ithd2jPJ/F6hkBRZAMAzvcLacOftYKyqYEQM6Ntd06sHf5bto/iScU61d9S57
 tOjW5X3+ucU9x6bbD56wkTLzIG7/4fsBUsI2H1OOgnILEJQO6X583JrWSlw41EH5/U8Oq+W3QMl
 rCTlJ3dH7ytgHTi/4CGvuUwTOtbCRMzoqBN8Y7gb0/wAUyCW/3UH8wOLoUAdyPXdBnB+WM73Y/3
 9KZNpVg3HVX+3OMrKL7W7B0Bxnt7G12M1qfUP7nIxJcxNOyTqX1RAY/jJy90Sc53DQs8XK+2yMp
 sLEKIrg3O8gF+v6nzR/orKyk6ER3W5bCOVyoe430R6XhEUE8hAVgEfruh/lGW8w==
X-Received: by 2002:a05:600c:a011:b0:490:50ff:7943 with SMTP id
 5b1f17b1804b1-49050ff7b15mr265317815e9.5.1779822279112; 
 Tue, 26 May 2026 12:04:39 -0700 (PDT)
X-Received: by 2002:a05:600c:a011:b0:490:50ff:7943 with SMTP id
 5b1f17b1804b1-49050ff7b15mr265317305e9.5.1779822278666; 
 Tue, 26 May 2026 12:04:38 -0700 (PDT)
Received: from fedora.redhat.com (89-138-3-119.bb.netvision.net.il.
 [89.138.3.119]) by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-45edb5b1a28sm204398f8f.26.2026.05.26.12.04.37
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 26 May 2026 12:04:38 -0700 (PDT)
To: ltp@lists.linux.it
Date: Tue, 26 May 2026 22:04:29 +0300
Message-ID: <20260526190430.129798-4-mmenashe@redhat.com>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <20260526190430.129798-1-mmenashe@redhat.com>
References: <20260526190430.129798-1-mmenashe@redhat.com>
MIME-Version: 1.0
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: re5tTZKhlLOljYUPakyEZqB1hJ4CbnoehCmLqwoNKmo_1779822279
X-Mimecast-Originator: redhat.com
X-Virus-Scanned: clamav-milter 1.0.9 at in-7.smtp.seeweb.it
X-Virus-Status: Clean
Subject: [LTP] [PATCH v12 3/4] futex_wake05: Add EFAULT error coverage test
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
 testcases/kernel/syscalls/futex/.gitignore    |  1 +
 .../kernel/syscalls/futex/futex_wake05.c      | 88 +++++++++++++++++++
 2 files changed, 89 insertions(+)
 create mode 100644 testcases/kernel/syscalls/futex/futex_wake05.c

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
index 000000000..8b1d50f9a
--- /dev/null
+++ b/testcases/kernel/syscalls/futex/futex_wake05.c
@@ -0,0 +1,88 @@
+// SPDX-License-Identifier: GPL-2.0-or-later
+/*
+ * Copyright (C) 2026 Red Hat, Inc.
+ * Copyright (C) 2026 Michael Menasherov <mmenashe@redhat.com>
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
+		     tc->exp_errno, "%s", tc->desc);
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
+				  MAP_PRIVATE | MAP_ANONYMOUS, -1, 0);
+	SAFE_MUNMAP((void *)unmapped_addr, pagesize);
+
+	prot_none_addr = SAFE_MMAP(NULL, pagesize, PROT_NONE,
+				   MAP_PRIVATE | MAP_ANONYMOUS, -1, 0);
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
