Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C9B36CD342C
	for <ltp@archiver.kernel.org>; Wed,  6 May 2026 11:37:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=lists.linux.it;
 i=@lists.linux.it; q=dns/txt; s=picard; t=1778067476; h=to : date :
 message-id : in-reply-to : references : mime-version : subject :
 list-id : list-unsubscribe : list-archive : list-post : list-help :
 list-subscribe : from : reply-to : content-type :
 content-transfer-encoding : sender : from;
 bh=57JaBidUnUs14ex7n2wgzK7IH0wjeKFz3KfSm0faSj0=;
 b=Br1x98NvrXKLK8ez2t5zE7O7KcjgmMFDPlay4+v8M3sSwdA0/uMOVV0sKrQQFs6lBjGBx
 Fo8HJynyrjkGEzfEAQStIVmLuXxaJB5FZKZX0gQKyTdhymL2Z6eTKANqdYyb5AgDgmMrISm
 BiJajLEMQUExNGpJa++LQByxosq4XZs=
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 7BBA83E6160
	for <ltp@archiver.kernel.org>; Wed,  6 May 2026 13:37:56 +0200 (CEST)
Received: from in-6.smtp.seeweb.it (in-6.smtp.seeweb.it [217.194.8.6])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id DFF673E2CC3
 for <ltp@lists.linux.it>; Wed,  6 May 2026 13:37:05 +0200 (CEST)
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.129.124])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-6.smtp.seeweb.it (Postfix) with ESMTPS id 4A113140021F
 for <ltp@lists.linux.it>; Wed,  6 May 2026 13:37:04 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1778067423;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=boRpSodahmLV5XmWvqUBV470KiLLTYCyzmrJ9VSdi1Q=;
 b=CyrxIYeGOkLCOLtdbqjgJGc3d6wg19rK3x2JwFQJ8dGeaMv6MH19KOeZhg8Gct3XBrN3yV
 3ZczuLCBCJ9GXmUsPHGW6GSL6g/WixAyl0rX5is9Ok94bR/DHi8y2PQIlQqr4YMYlm2BNK
 PMtP84Fmnio7ZNxftno5BqwmuQ1WAio=
Received: from mail-wr1-f70.google.com (mail-wr1-f70.google.com
 [209.85.221.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-279-EEgyW8YkOty9WAt2QwdJzg-1; Wed, 06 May 2026 07:37:02 -0400
X-MC-Unique: EEgyW8YkOty9WAt2QwdJzg-1
X-Mimecast-MFC-AGG-ID: EEgyW8YkOty9WAt2QwdJzg_1778067421
Received: by mail-wr1-f70.google.com with SMTP id
 ffacd0b85a97d-44bf1ac8893so4008851f8f.0
 for <ltp@lists.linux.it>; Wed, 06 May 2026 04:37:01 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1778067420; x=1778672220;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=boRpSodahmLV5XmWvqUBV470KiLLTYCyzmrJ9VSdi1Q=;
 b=Osq0UYITUxRQ+F/YvJiqEKxKPJkM6s2DHgfGLOoEyStNrOcLMPO6sO0Qdc1m0FSEUU
 +X4yK/kHD+n0835rHUb8+pkDP6yrsoduCkNldTvT0aHI55VYsDZuxqHS/auVBqk9v5as
 XxNkv3hWWJl5On7csnxYmB5biKR2OyNH9QN9RIGnUdB5zJz2btMhfw8CwnZWyh3mnw2s
 rABdcs4qNHUEdkNWe+XPk9m5dOg8qgj7tW6PBKFuNmtfkkytxNkqO0HG2PB6JQSMk0l/
 5Wfbb3WYozZvCZwN+vFAZQtvDKvmWAGjxVycEMlIZpnpOYSBzvrM1A51tmKluQ1KuqdG
 fAlg==
X-Gm-Message-State: AOJu0YypljzmZ+AMmb0SLVUWSKIbUIkscJ/pT9e3LCTYNbyJGkYvGdtc
 NpMFyDitXaftnpet9KiHDCXcqJqlRhrz8nF/7lkqecxN+lX6EjpGFIRQSX3fjHpzzxQL2QOt1/l
 pGyvyEs+HLxLPrf1XhEf1LoHnO27LZZrmxjrI50o4qybTZPOdm3vHFDGwYuAd4gBD8aollKiJr6
 DFEqv2PUoUa3XgO7MynKQlb//vnWYnx2B3UOnc
X-Gm-Gg: AeBDietHHDzuXc4P10+JNsbrHp2F9fo90ysS/HgpG/32Ypy3/XPqqPzX3OQodcL1l81
 AvPs9p0wEbDRxHyYiHwTLH9wI5VUGRUTCvY3JHYNRN9ijYDGz6DXhctdBGkGvpWZffgE/WCQjwN
 TaV68oLjK59/OfpueXVsZP+edyY/LExpfdhyJ7Eh+0J+mQp5MXqdu5iUsZxEIQKaaSvbC6DIvxo
 aVC9xs7/gOaCBcbxTVmoU8OAYTsFYOAkRsSYhs4fEeWqmKPf3zhbwvasUUXLt/HADog1VhQ1e4t
 68DZyQJ/wtZEYcHWbqHa3UfiduzTqfKnYZIy3u88WbaoKKRpFMPGTCRB9GQFft7mHwHr+B4u5Gn
 05fX1kUEaeLCCUxGgzbCIJszAnkRqe/8eMjdKBW6Ai7r74qC1UJnB5trinqTTlI60aFUBhw/Bs+
 GmnGu62Q==
X-Received: by 2002:a05:6000:18a5:b0:43d:1dfe:350a with SMTP id
 ffacd0b85a97d-4515ce1c991mr5486635f8f.22.1778067420073; 
 Wed, 06 May 2026 04:37:00 -0700 (PDT)
X-Received: by 2002:a05:6000:18a5:b0:43d:1dfe:350a with SMTP id
 ffacd0b85a97d-4515ce1c991mr5486584f8f.22.1778067419604; 
 Wed, 06 May 2026 04:36:59 -0700 (PDT)
Received: from fedora.redhat.com (85.65.168.167.dynamic.barak-online.net.
 [85.65.168.167]) by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-45055960022sm11919938f8f.26.2026.05.06.04.36.58
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 06 May 2026 04:36:58 -0700 (PDT)
To: ltp@lists.linux.it
Date: Wed,  6 May 2026 14:36:52 +0300
Message-ID: <20260506113655.10797-2-mmenashe@redhat.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260506113655.10797-1-mmenashe@redhat.com>
References: <20260506113655.10797-1-mmenashe@redhat.com>
MIME-Version: 1.0
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: TYMFNK0i1HLOVq5Sf7oJ_RkOjQU44WqORICa_rzwIyE_1778067421
X-Mimecast-Originator: redhat.com
X-Virus-Scanned: clamav-milter 1.0.9 at in-6.smtp.seeweb.it
X-Virus-Status: Clean
Subject: [LTP] [PATCH 1/4] futex_wait06: Add EFAULT error coverage test
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
 runtest/syscalls                              |  4 +
 testcases/kernel/syscalls/futex/.gitignore    |  1 +
 .../kernel/syscalls/futex/futex_wait06.c      | 73 +++++++++++++++++++
 3 files changed, 78 insertions(+)
 create mode 100644 testcases/kernel/syscalls/futex/futex_wait06.c

diff --git a/runtest/syscalls b/runtest/syscalls
index 6ba0227a8..621355e04 100644
--- a/runtest/syscalls
+++ b/runtest/syscalls
@@ -699,6 +699,7 @@ io_setup02 io_setup02
 io_submit01 io_submit01
 io_submit02 io_submit02
 io_submit03 io_submit03
+io_submit04 io_submit04
 
 keyctl01 keyctl01
 keyctl02 keyctl02
@@ -926,6 +927,7 @@ mremap03 mremap03
 mremap04 mremap04
 mremap05 mremap05
 mremap06 mremap06
+mremap07 mremap07
 
 mseal01 mseal01
 mseal02 mseal02
@@ -1899,6 +1901,8 @@ membarrier01 membarrier01
 
 io_uring01 io_uring01
 io_uring02 io_uring02
+io_uring03 io_uring03
 
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
