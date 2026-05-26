Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 383B1CD5BB1
	for <ltp@archiver.kernel.org>; Tue, 26 May 2026 21:51:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=lists.linux.it;
 i=@lists.linux.it; q=dns/txt; s=picard; t=1779832273; h=to : date :
 message-id : in-reply-to : references : mime-version : subject :
 list-id : list-unsubscribe : list-archive : list-post : list-help :
 list-subscribe : from : reply-to : content-type :
 content-transfer-encoding : sender : from;
 bh=vUQqCyOEF+r4jCmSbAhYpu1Z6AKQHpL1HaZBgtKyYB8=;
 b=QJSD/KV872YMEULAUbkDbzqtM7+QGFYazkOpnCbe+tyAl7ljxG10T1cz1JhKmX00miq8j
 JEGycg1ID1QB0ZMsqY1AYNV6aHpGDGOQE2IU5/fn4uAiXnSaem8JIJouwZu31QmVmnt61Gj
 NsH1HN6g9h3MuQo4Jsp9mc/MEQYku9I=
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id D037D3C70A4
	for <ltp@archiver.kernel.org>; Tue, 26 May 2026 23:51:13 +0200 (CEST)
Received: from in-2.smtp.seeweb.it (in-2.smtp.seeweb.it [217.194.8.2])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1) server-digest SHA384)
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 4373E3C7105
 for <ltp@lists.linux.it>; Tue, 26 May 2026 23:49:39 +0200 (CEST)
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.133.124])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-2.smtp.seeweb.it (Postfix) with ESMTPS id BDEE8600941
 for <ltp@lists.linux.it>; Tue, 26 May 2026 23:49:38 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1779832177;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=uZAj81vg7UdQnS+0iskttImribHHfAO+YYWNW2506Rs=;
 b=gG6m/7ciSe1gD+X1oPIrU/IsD1valjN+xgC5trI02h7KhElCJhQBh3mIhLfk4Zf8ucduCL
 aicuhY8JYTUwvTsQLBImTGu4ayzHCoBGWCoROqutEkBua3bEh7euZXeTYscKm2dlMERb98
 3cW1iABf9Sb2HZflCwEYY8uzQwOVVg8=
Received: from mail-wr1-f71.google.com (mail-wr1-f71.google.com
 [209.85.221.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-486-6pchAz0rNoi5cEuodE-kJw-1; Tue, 26 May 2026 17:49:36 -0400
X-MC-Unique: 6pchAz0rNoi5cEuodE-kJw-1
X-Mimecast-MFC-AGG-ID: 6pchAz0rNoi5cEuodE-kJw_1779832175
Received: by mail-wr1-f71.google.com with SMTP id
 ffacd0b85a97d-4497a0e3acaso9272113f8f.0
 for <ltp@lists.linux.it>; Tue, 26 May 2026 14:49:35 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1779832175; x=1780436975;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=uZAj81vg7UdQnS+0iskttImribHHfAO+YYWNW2506Rs=;
 b=JzEdNVEfQqDjzffJjGBgNiyCA99dAA4c68GAf0i149Y6GdD2yUjGaxKxq9NjlHlmXl
 Hj0CSJONZ8OgY1U8RwahGiqyRQHhM0C8tPr33jdinXy+yv9gKPHS8KWB19ym7QW6MzkT
 HC8PcCrfkxTI+UNhZCfA7bS1gQI3u5J/WjYJ7R/YHpWoNNCM9R1IaPlHrUAQkGtSEYd5
 ZNnIn7un4v8RMWGuvNqkz05xq7oGuCMPLyHyqGsUBTE+kDjx24Tv2X/W7E2HhLebTAhW
 6voL3V39VfZIRxz5qwHuwFOGJ7vojxiMNpuKNQZusaikGec7/gANnTMWMbAeAlFVxrMF
 1BMA==
X-Gm-Message-State: AOJu0YzcsvWFPIBl8QqIDAZyPHc9ArjqoQEgQeazisXuYfHoaLXTe0Aw
 +VCYinyauDwDxED0TWQMc2pPDL0Qezcg33nOktxkgiA6hYtNVYRN0a0AbZhwD9iF2qs6Pa7+hch
 ZE9BtQHY8P57L+PuUz2f8pP4sqw/TuHBpBmKlv6PF0S9rEitriymZIJaCBIgK1RhQqX8KVZotda
 kA1AbahAQCYO2FATbHUAb+qIkKeWiBwHGHBg3y
X-Gm-Gg: Acq92OF/GNiB2bR8mGDT5kuUT9Vp8BHnD5eydWgYTapN/Cck7H5nq+RL7L2ljx9PnLd
 A7MGuZPnZAXQMRXm0T9ueyoD0KYCkyrk+Mvgn5vJYF0K57LWZYcISLsjYt9FYyICUOLjQAax9UU
 qxsgKeABfjVTVoGlG+O7hZEBfBJ+x128X01srixjESCQ99f/8tLRSX7Ta6QXYQNlFODZ+D7d4qI
 EZnhUL1S7erZdV1gmTIOt99JunWiaYpWGqqgOsAQk52+0AxEruuKDpdq3/r3c/KZTi9u2SqkYCe
 RuysAieT6dx/KL4kIGQhXXIAFYeDcQMIuQdkWFkJziAretSfanEBMwKGrBh4Om1tzQxbd1vrllS
 6S+2dgBuDXDGomr1tkIVRkek46pSURG7Ne+0hJj79/uWrfqYFFMp4H0hxNfC18s4o8BI62qTZ
X-Received: by 2002:a05:6000:184d:b0:43d:1bf6:927 with SMTP id
 ffacd0b85a97d-45eb369cf5cmr32463470f8f.14.1779832174829; 
 Tue, 26 May 2026 14:49:34 -0700 (PDT)
X-Received: by 2002:a05:6000:184d:b0:43d:1bf6:927 with SMTP id
 ffacd0b85a97d-45eb369cf5cmr32463424f8f.14.1779832174370; 
 Tue, 26 May 2026 14:49:34 -0700 (PDT)
Received: from fedora.redhat.com (89-138-3-119.bb.netvision.net.il.
 [89.138.3.119]) by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-45edb54a6cdsm1211123f8f.2.2026.05.26.14.49.33
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 26 May 2026 14:49:33 -0700 (PDT)
To: ltp@lists.linux.it
Date: Wed, 27 May 2026 00:49:26 +0300
Message-ID: <20260526214927.150812-4-mmenashe@redhat.com>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <20260526214927.150812-1-mmenashe@redhat.com>
References: <20260526214927.150812-1-mmenashe@redhat.com>
MIME-Version: 1.0
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: igxmwgX4_uMUT9jyHqRSwHtLuGAhI6dsGJbAkDxi2zQ_1779832175
X-Mimecast-Originator: redhat.com
X-Virus-Scanned: clamav-milter 1.0.9 at in-2.smtp.seeweb.it
X-Virus-Status: Clean
Subject: [LTP] [PATCH v13 3/4] futex_wake05: Add EFAULT error coverage test
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
 .../kernel/syscalls/futex/futex_wake05.c      | 89 +++++++++++++++++++
 3 files changed, 91 insertions(+)
 create mode 100644 testcases/kernel/syscalls/futex/futex_wake05.c

diff --git a/runtest/syscalls b/runtest/syscalls
index e6c5d5112..8c4d9be6c 100644
--- a/runtest/syscalls
+++ b/runtest/syscalls
@@ -1877,6 +1877,7 @@ futex_wake01 futex_wake01
 futex_wake02 futex_wake02
 futex_wake03 futex_wake03
 futex_wake04 futex_wake04
+futex_wake05 futex_wake05
 futex_wait_bitset01 futex_wait_bitset01
 
 memfd_create01 memfd_create01
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
index 000000000..5b0f4ac17
--- /dev/null
+++ b/testcases/kernel/syscalls/futex/futex_wake05.c
@@ -0,0 +1,89 @@
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
+
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
