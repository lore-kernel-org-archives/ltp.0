Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3D74DCD342C
	for <ltp@archiver.kernel.org>; Wed,  6 May 2026 15:19:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=lists.linux.it;
 i=@lists.linux.it; q=dns/txt; s=picard; t=1778080764; h=to : date :
 message-id : in-reply-to : references : mime-version : subject :
 list-id : list-unsubscribe : list-archive : list-post : list-help :
 list-subscribe : from : reply-to : content-type :
 content-transfer-encoding : sender : from;
 bh=yCtyfw2ros8gbjIo/c8ZIqeQkWIze9dUuURGXcWD9rk=;
 b=jVg8LqMbvRxKStJl+Tt8MBEiNf91TXL8n1dMlWw5gIoniiA925B7ZgqaKuSdrDxx5DPCl
 NCsbX/X+t7mmU7S2u3QqknWlt7IwLgeKEAsjSd3xDz9hpr5u4LaQw0mE2yQfdD28NqaUzLz
 N0o7LC85KX6Uga/u4x3JUW2n5vi0sk4=
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 4A61D3E2C53
	for <ltp@archiver.kernel.org>; Wed,  6 May 2026 17:19:24 +0200 (CEST)
Received: from in-2.smtp.seeweb.it (in-2.smtp.seeweb.it [217.194.8.2])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1) server-digest SHA384)
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 6F69D3E6170
 for <ltp@lists.linux.it>; Wed,  6 May 2026 17:18:11 +0200 (CEST)
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.129.124])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-2.smtp.seeweb.it (Postfix) with ESMTPS id E261D6009C9
 for <ltp@lists.linux.it>; Wed,  6 May 2026 17:18:10 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1778080689;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=vYQ/WewAFNhUMCHobRPJdYCGasGG3KdqaQo//tQluCs=;
 b=d4A1cB6eXFkGpYvT6m762dr+sNLnrhQ1errZd5kG2+MIyezU1sUGS7yS39uftlRh2RVW/8
 oFEASbZRIhI9kL46cnZ9sec0qnLZa2RducUZmFaHYGMBIjz0y5Ql730qpZEa+8DCEemimb
 W4WA2pZu1h7FoVg7lUDnQ+d2aNknOyU=
Received: from mail-wr1-f69.google.com (mail-wr1-f69.google.com
 [209.85.221.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-687-XSHiw3HcMw-ZGY3XCRvexQ-1; Wed, 06 May 2026 11:18:07 -0400
X-MC-Unique: XSHiw3HcMw-ZGY3XCRvexQ-1
X-Mimecast-MFC-AGG-ID: XSHiw3HcMw-ZGY3XCRvexQ_1778080686
Received: by mail-wr1-f69.google.com with SMTP id
 ffacd0b85a97d-44ffa15dc73so1728596f8f.1
 for <ltp@lists.linux.it>; Wed, 06 May 2026 08:18:07 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1778080685; x=1778685485;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=vYQ/WewAFNhUMCHobRPJdYCGasGG3KdqaQo//tQluCs=;
 b=Sl26ud3w31LpIu4oa4XOiYrPoR+XYawgHfdhfcpR93+6ALtYCjX/CLNrBGnK+5OuW+
 VjZbk/mPJbDJRqN99JRtjulyAsRK/Le1Ys9oP9IJf5zN2NETbH7cHlYml/DYiw4eZX1F
 vpERkribaaKKZmXvZY+z8qhWTF4QTeq3Mly7DDaaurJ3Ih3GNe5VEqJl17YVy30VE8fu
 16zPGEtLHptp6+8j8m6GfNTbFxFmuH8V7yTGvZ7mHh3RZAzCBpnBTp0psPNwTy/wOs41
 6laTs9m2ujdCDyC4X4neffoJsshxAF+eDRHzfGMVJyvU6RjuYdLOOYWdIke5FwFpASDu
 /Jdw==
X-Gm-Message-State: AOJu0YzFqd0yTQDMdspm5NsKL2kLsFr23MF/+KvV0Lkas1/iL70jRtOf
 EGNJLBLaoe6NNvu69N73NElDCh7O9J9/rto3Us30NEUa3eCDM6RF0ZGxkea/JWTfyrgsaIJkccK
 92dYuDC1zVkxhKVPwbs8w+OyPHlPaNbBcapO94tY8gTC+yeYbgqgLWlIzMtQx8rhE0S3x1w14Sj
 TKzHVUKJ2/cGX1P5YSAozM4VhxypjyGzwRKSF/
X-Gm-Gg: AeBDiesIOXMjnFTyoVtaXX8F1TmXIyCJXBPCake4vfEacX33gcZjkyJxrCfzetVnzIq
 ssP7j+r3Qyg6PXIILdyrAVrGUakmgYmaOikeR7lfaKgF0wwEfKu8fF8jXqrkekCgQE6jsl07ipf
 AytBwGSdSkDCBFXFK985xQyOaZWYC6a/K9/6CIDJld197WKCUCyjQRlgiIodQJW9VmkuBbk77mL
 e16jDEi7cFTs7zFtPQlQKBpaac8wKHSOzSXWwLebd0FyGKAOeuUzMuFK4GYX8XirsAmbeb7eHYn
 pML9pk0VjCBfIs8gkHl1iJgaQ2Y5CIfWblZCNK9klkuyHAC7KQAn5n1wU4JXPp2S3DsDr1WkWhK
 faPW2zhCFeMnEW6fb0gVt6QYp5bMgByW+qQOJ5R/KP0Nc8THAZnVU644quM+kLaDNZM9fuHwnXo
 3u10k19A==
X-Received: by 2002:a05:600c:a118:b0:48a:58e1:6d02 with SMTP id
 5b1f17b1804b1-48e51f35b3emr48296265e9.19.1778080685353; 
 Wed, 06 May 2026 08:18:05 -0700 (PDT)
X-Received: by 2002:a05:600c:a118:b0:48a:58e1:6d02 with SMTP id
 5b1f17b1804b1-48e51f35b3emr48295955e9.19.1778080684886; 
 Wed, 06 May 2026 08:18:04 -0700 (PDT)
Received: from fedora.redhat.com (85.65.168.167.dynamic.barak-online.net.
 [85.65.168.167]) by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-4505238e174sm13323519f8f.1.2026.05.06.08.18.04
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 06 May 2026 08:18:04 -0700 (PDT)
To: ltp@lists.linux.it
Date: Wed,  6 May 2026 18:17:58 +0300
Message-ID: <20260506151801.20401-2-mmenashe@redhat.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260506151801.20401-1-mmenashe@redhat.com>
References: <20260506151801.20401-1-mmenashe@redhat.com>
MIME-Version: 1.0
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: z-s6zpK0g_Ih9x5ZTbfAKp9WDeT-JDBVJxYihyrjS4w_1778080686
X-Mimecast-Originator: redhat.com
X-Virus-Scanned: clamav-milter 1.0.9 at in-2.smtp.seeweb.it
X-Virus-Status: Clean
Subject: [LTP] [ltp v2 1/4] futex_wait06: Add EFAULT error coverage test
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

---
 runtest/syscalls                              |  1 +
 testcases/kernel/syscalls/futex/.gitignore    |  1 +
 .../kernel/syscalls/futex/futex_wait06.c      | 73 +++++++++++++++++++
 3 files changed, 75 insertions(+)
 create mode 100644 testcases/kernel/syscalls/futex/futex_wait06.c

diff --git a/runtest/syscalls b/runtest/syscalls
index df5dc02b5..621355e04 100644
--- a/runtest/syscalls
+++ b/runtest/syscalls
@@ -1905,3 +1905,4 @@ io_uring03 io_uring03
 
 # Tests below may cause kernel memory leak
 perf_event_open03 perf_event_open03
+futex_wait06 futex_wait06
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
index 000000000..8bb563fb2
--- /dev/null
+++ b/testcases/kernel/syscalls/futex/futex_wait06.c
@@ -0,0 +1,73 @@
+// SPDX-License-Identifier: GPL-2.0-or-later
+/*
+ * Copyright (C) 2026 Red Hat, Inc.
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
+	futex_t *uaddr;
+	void *timeout;
+} testcases[2];
+
+static void run(unsigned int n)
+{
+	struct futex_test_variants *tv = &variants[tst_variant];
+	struct testcase *tc = &testcases[n];
+
+	TST_EXP_FAIL(futex_syscall(tv->fntype, tc->uaddr, FUTEX_WAIT, futex,
+		tc->timeout, NULL, 0, 0), EFAULT, "%s", tc->desc);
+}
+
+static void setup(void)
+{
+	struct futex_test_variants *tv = &variants[tst_variant];
+	void *bad;
+
+	tst_res(TINFO, "Testing variant: %s", tv->desc);
+	futex_supported_by_kernel(tv->fntype);
+
+	bad = SAFE_MMAP(NULL, getpagesize(), PROT_READ | PROT_WRITE,
+		MAP_PRIVATE | MAP_ANONYMOUS, -1, 0);
+	SAFE_MUNMAP(bad, getpagesize());
+
+	testcases[0] = (struct testcase){
+		.desc = "uaddr points to unmapped memory",
+		.uaddr = bad,
+		.timeout = NULL,
+	};
+	testcases[1] = (struct testcase){
+		.desc = "timeout points to unmapped memory",
+		.uaddr = &futex,
+		.timeout = bad,
+	};
+}
+
+static struct tst_test test = {
+	.setup = setup,
+	.test = run,
+	.tcnt = ARRAY_SIZE(testcases),
+	.test_variants = ARRAY_SIZE(variants),
+};
-- 
2.53.0


-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
