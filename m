Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C1D31CD5BC8
	for <ltp@archiver.kernel.org>; Tue, 26 May 2026 09:09:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=lists.linux.it;
 i=@lists.linux.it; q=dns/txt; s=picard; t=1779786576; h=to : date :
 message-id : in-reply-to : references : mime-version : subject :
 list-id : list-unsubscribe : list-archive : list-post : list-help :
 list-subscribe : from : reply-to : content-type :
 content-transfer-encoding : sender : from;
 bh=Rz2y4m7MGX7y/MoSKRpiPkkma3gjhjX+eBJXjvlZmvc=;
 b=Pdq68/dHLczeNeHPW196ywLH/MgpE52Ny0d25py788OEWvjcetSIe6iyusK9+SGTGHU8G
 464LtusiBd2D3b4j+of7YaZHrbU4//urpZ50LD6G5t1RvttcLDY91seym7ClbCq3pGInMQK
 rS2BCfGYhZxEr0q6gAWMtYp1o+xW1TA=
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 53AB93E523B
	for <ltp@archiver.kernel.org>; Tue, 26 May 2026 11:09:36 +0200 (CEST)
Received: from in-4.smtp.seeweb.it (in-4.smtp.seeweb.it [217.194.8.4])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id EDECD3E5249
 for <ltp@lists.linux.it>; Tue, 26 May 2026 11:07:47 +0200 (CEST)
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.133.124])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-4.smtp.seeweb.it (Postfix) with ESMTPS id 3D5341000607
 for <ltp@lists.linux.it>; Tue, 26 May 2026 11:07:46 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1779786465;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=hCjGCjkdYB5+matJnCx/PQBSDVG4p+jiPRg9biqKEIc=;
 b=ChlATe8UOQytrJDCmh9sRy0/4nqiMxn2OaPP4Sak1yK+Mq4+0YM65/Jj7jrzmcev5bPNk/
 hIR+zD+o2E/PGQNcaiShJrvgszMJNogphigebWOdB181/EuHXHHAG/iUG/SnoflOtHgI0e
 a8r/mFNsSw1h7usnZP1wqtEXA5OUTrc=
Received: from mail-wr1-f70.google.com (mail-wr1-f70.google.com
 [209.85.221.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-322--8wUBq1MOBSFx7T0AWWG2g-1; Tue, 26 May 2026 05:07:41 -0400
X-MC-Unique: -8wUBq1MOBSFx7T0AWWG2g-1
X-Mimecast-MFC-AGG-ID: -8wUBq1MOBSFx7T0AWWG2g_1779786460
Received: by mail-wr1-f70.google.com with SMTP id
 ffacd0b85a97d-45ea19f2564so5132258f8f.2
 for <ltp@lists.linux.it>; Tue, 26 May 2026 02:07:41 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1779786460; x=1780391260;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=hCjGCjkdYB5+matJnCx/PQBSDVG4p+jiPRg9biqKEIc=;
 b=c6tBv1SXWTBWLRGyUev6bPxxwg5D0QaRdKSgbV3cPRCsjTVWDSYkBzJJfvgofxpuYh
 SXSpvIkFPng4YzVhO/Ob7jiFJMw4e59GQNpCFn7iEUvQTtyigZIYE93lCiHlvSjAB3PG
 3rxdy4m0nf9yR7f6sO072VDhSead8aju8FErpc7mcjj1UL7Sa10LFp8ytyqmezRlKjcD
 /CvKuZcR6PDH/b/kc7ds9rXBGVJQU6b9aX/bmAmYlOLOLOH620nMtEYJ+VDVLqzi5cO6
 FzBrRnF3jqtm4hYJ7xxM9qHV+SGa3Dm/SJC8eNvBsQS7gsaJ729m9GUCzdM9FRKsXPdG
 HKeQ==
X-Gm-Message-State: AOJu0Yw+wwL33etpfLRGIp0Y0Zovgq8ubthpbu0os1KlvigoJ2ohoP/g
 aA5n0Tjemf7QJncqkzY+q/N3Gva/5KY08Icw8C3D8qvoasdLlfq0CzqfdYz5ZjoknGH7XSSjpcC
 Tgd3dLyxqDgBa5U9d83UUK8OcVu1GFiA/NBg93kVzS9NsPpxEkJzydP0F2+W4sVKKwOwmxYA5Iq
 +2GKN3soKx5W9sOtvBrX6EU8t8t1CdSQbz6xQ6
X-Gm-Gg: Acq92OFHWvst9rf+eXdUXEVU3afKhhPq+u2vzL17BMKX6ACJCpDIx1Z6ayA7i5zmfwD
 vtzv2yqA97zMYiXItd+oS+cUjnNGf1WZSLIUHjOeN+8L/H+VLSmfFpTFTwSjl2XiIFXfyoTrbbq
 4gc/4U2cz4Gt6OmRWdXxAN3CHEaRFdiM5oBQBAmsr9WBeZ+jWJf++ezFx2COZyH8SH0A/4MyXI9
 ENuWVDJBuS7CS2xeRtpyMEMGKn208RAknmUIBc/iDHMV4m+qGWKOCqAQLZjgWRzMXr8leuiEErk
 brbfZ6Zr5/RC30BtEqj3MfcyglK6aA67O9VG584SxjViFUyr7beo63W2qAkFM5hSZbV0VkF6XdI
 M6iNLFV7q3d9TGUPR7y/xmB5lA0mNwWPA8tqaKse6uFmw23UJNCxleq6uFEqntg==
X-Received: by 2002:a05:6000:1446:b0:43d:7a97:78af with SMTP id
 ffacd0b85a97d-45eb38e04e3mr30843511f8f.42.1779786459912; 
 Tue, 26 May 2026 02:07:39 -0700 (PDT)
X-Received: by 2002:a05:6000:1446:b0:43d:7a97:78af with SMTP id
 ffacd0b85a97d-45eb38e04e3mr30843454f8f.42.1779786459333; 
 Tue, 26 May 2026 02:07:39 -0700 (PDT)
Received: from fedora.redhat.com (89-138-3-119.bb.netvision.net.il.
 [89.138.3.119]) by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-45eb6c9f58dsm33274647f8f.5.2026.05.26.02.07.37
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 26 May 2026 02:07:38 -0700 (PDT)
To: ltp@lists.linux.it
Date: Tue, 26 May 2026 12:07:29 +0300
Message-ID: <20260526090730.22455-4-mmenashe@redhat.com>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <20260526090730.22455-1-mmenashe@redhat.com>
References: <20260526090730.22455-1-mmenashe@redhat.com>
MIME-Version: 1.0
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: LB6uvF7fFnF3hVgeE-k9Ah0yaD6D6Z6rf5tS-oWD47c_1779786460
X-Mimecast-Originator: redhat.com
X-Virus-Scanned: clamav-milter 1.0.9 at in-4.smtp.seeweb.it
X-Virus-Status: Clean
Subject: [LTP] [PATCH v10 3/4] futex_wake05: Add EFAULT error coverage test
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
