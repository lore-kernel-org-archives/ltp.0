Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5A3D3CD3436
	for <ltp@archiver.kernel.org>; Wed,  6 May 2026 11:38:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=lists.linux.it;
 i=@lists.linux.it; q=dns/txt; s=picard; t=1778067521; h=to : date :
 message-id : in-reply-to : references : mime-version : subject :
 list-id : list-unsubscribe : list-archive : list-post : list-help :
 list-subscribe : from : reply-to : content-type :
 content-transfer-encoding : sender : from;
 bh=NfZjeVeH0lU8RK8MWYx6gzEY3+Br0e9TCZpOcdZBoxs=;
 b=ptnXarek62ZbgLqVNDLT/1EuKqbtupZwsjxuiKXi0wod80qhlAJ2x0LkF2pzX6V/LlxbW
 VTjJfos5t/naZPjeekBNuCSdqhfWjxrnK4kSa3S3UyUYub5RF5AZV1j96PnL5RZq5/oaqVV
 Aw3SN/LUd0BTYU/QSaKeU80UVlUH1SQ=
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 11BDA3E615B
	for <ltp@archiver.kernel.org>; Wed,  6 May 2026 13:38:41 +0200 (CEST)
Received: from in-4.smtp.seeweb.it (in-4.smtp.seeweb.it [217.194.8.4])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 006D43E615B
 for <ltp@lists.linux.it>; Wed,  6 May 2026 13:37:07 +0200 (CEST)
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.129.124])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-4.smtp.seeweb.it (Postfix) with ESMTPS id 6BDD710009F4
 for <ltp@lists.linux.it>; Wed,  6 May 2026 13:37:07 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1778067426;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=w6PM+iazZHiaNtQstutOpMmLJDrpEeOwSs1KfuxQnzw=;
 b=McAj3zhklrvNaSkWt1RE10zE5svdoNFAbGDDL4TMZpQS7bwShwWcFQtf8ASxmUkLZiGuWK
 YzudceH6JBVwv74ImS/dAZjyDcwBqwyhwmL7C0fEEIgC5Y5Tvx3plJ12zUOSvJAWJHVGr9
 8dgz7x6Y2tVR7VmtxWb+qI4VZNdHsQU=
Received: from mail-wr1-f70.google.com (mail-wr1-f70.google.com
 [209.85.221.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-55-xhmpCVDCPwqiAuwf37i5dQ-1; Wed, 06 May 2026 07:37:04 -0400
X-MC-Unique: xhmpCVDCPwqiAuwf37i5dQ-1
X-Mimecast-MFC-AGG-ID: xhmpCVDCPwqiAuwf37i5dQ_1778067423
Received: by mail-wr1-f70.google.com with SMTP id
 ffacd0b85a97d-44b186b715aso3016451f8f.0
 for <ltp@lists.linux.it>; Wed, 06 May 2026 04:37:04 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1778067423; x=1778672223;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=w6PM+iazZHiaNtQstutOpMmLJDrpEeOwSs1KfuxQnzw=;
 b=XbQVSU4iuByoQIu4mhWyoaI8vVY/foZLiMXn3SFuRDOdBE9GoGcvu3WzNYgSkEMMOy
 ylgg75jypojaWokqlQxnvQ5vTnTHBkZHeg0Xqs0VcZn0P284ZBSH4ltHCljKhKgunG2X
 yGb7qseL0NkOKpyHUS6xLa4wEhCfvWuJzYryOgw0T7Knj898FVyKhOwRfq8UHKpcbbkO
 5zhX01Ee9bKhpS8Le2qsv45rMYcvdJQLKl0VZDYJDgZhf8X4uFYLmKKXQLExR39SdTrH
 Uy9afjQPqWGQViUx1ym9bD2f08r0qyvSKAlO4f2Dh44K9tKewlMEeq1LH+th7ZptO1Ff
 Kq1Q==
X-Gm-Message-State: AOJu0Yxya92LqSG5MSFJFXw+hc7GuITy9gACTAdR8BESGrHOY3XL0/wz
 qrpk1Kowzqfo14cKpxH0ZgniERYvzTvRk9csMetGwsIUVsPfwRbCs4HoMVkltxVLosPkmDHGxXH
 y3RnF82bGsi9Cm5FiNM/9M0QymQ90sd64J7V+nZR5yMmP75ps/yD0IO+dUB/FHyKjYH2mxybGLp
 LM6B1SY3kgq6hOsoW+hDWuuBtT9xxRGZk9gFAL
X-Gm-Gg: AeBDietiQ+iEzpfh5LbfeKCzIOTVY7DnXGoXOh3K7ytUIrYZhR+d0IUa7WhFs7F2urE
 fJUXDhYaBF89W6Jy0ZuQ6ScWWguQ6Lnm0rWWUi+kHjYP19RtdDtALJaDfTocWeClQFv8i2v5eRw
 CXmFKu8h1KmeibIUGEcimEmjexAkmDud0lU4kzwls3iR7PlynLzfu9jv4JZf0ZcX2V1IEyOoeG/
 aDmgEKE/p1s77/UlrOy571WnJ4IGg2Qm7VymzN93zcuQmGG8T7UmdPNN63bi8NBmAoS1dFD2iPU
 seqhhnF42FznPrwrNvChFG+8E6cBtk9wZUwL47wQKugZdYS3YaS+iXk7xefxmr4JIkuOH5Trs+N
 D+TG5d3xY3jVt/Yu3sjOtHWHjVxfHR0TbmvsQlBQvC8gn2J9nsN8T9JUmLzKyamiuPmMzjldYDS
 eCGNdp4g==
X-Received: by 2002:a05:6000:22c4:b0:44f:d9da:2c40 with SMTP id
 ffacd0b85a97d-4515cf125d1mr5204337f8f.21.1778067423000; 
 Wed, 06 May 2026 04:37:03 -0700 (PDT)
X-Received: by 2002:a05:6000:22c4:b0:44f:d9da:2c40 with SMTP id
 ffacd0b85a97d-4515cf125d1mr5204278f8f.21.1778067422502; 
 Wed, 06 May 2026 04:37:02 -0700 (PDT)
Received: from fedora.redhat.com (85.65.168.167.dynamic.barak-online.net.
 [85.65.168.167]) by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-45055960022sm11919938f8f.26.2026.05.06.04.37.00
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 06 May 2026 04:37:01 -0700 (PDT)
To: ltp@lists.linux.it
Date: Wed,  6 May 2026 14:36:54 +0300
Message-ID: <20260506113655.10797-4-mmenashe@redhat.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260506113655.10797-1-mmenashe@redhat.com>
References: <20260506113655.10797-1-mmenashe@redhat.com>
MIME-Version: 1.0
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: Fh27kP2vOCIERnwNdU1wyyt-MAphf9tGVP6Fv28y9hk_1778067423
X-Mimecast-Originator: redhat.com
X-Virus-Scanned: clamav-milter 1.0.9 at in-4.smtp.seeweb.it
X-Virus-Status: Clean
Subject: [LTP] [PATCH 3/4] futex_wake05: Add EFAULT error coverage test
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
 .../kernel/syscalls/futex/futex_wake05.c      | 86 +++++++++++++++++++
 3 files changed, 88 insertions(+)
 create mode 100644 testcases/kernel/syscalls/futex/futex_wake05.c

diff --git a/runtest/syscalls b/runtest/syscalls
index 75b7754db..4d85a1d26 100644
--- a/runtest/syscalls
+++ b/runtest/syscalls
@@ -1907,3 +1907,4 @@ io_uring03 io_uring03
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
index 000000000..1e9bd6435
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
+	futex_t *addr;
+	int exp_errno;
+} testcases[2];
+
+static void run(unsigned int n)
+{
+	struct futex_test_variants *tv = &variants[tst_variant];
+	struct testcase *tc = &testcases[n];
+
+	TST_EXP_FAIL(futex_wake(tv->fntype, tc->addr, 1, 0),
+		tc->exp_errno, "%s", tc->desc);
+}
+
+static void setup(void)
+{
+	struct futex_test_variants *tv = &variants[tst_variant];
+	size_t pagesize = getpagesize();
+	futex_t *unmapped;
+
+	tst_res(TINFO, "Testing variant: %s", tv->desc);
+	futex_supported_by_kernel(tv->fntype);
+
+	unmapped = SAFE_MMAP(NULL, pagesize, PROT_READ | PROT_WRITE,
+		MAP_PRIVATE | MAP_ANONYMOUS, -1, 0);
+	SAFE_MUNMAP(unmapped, pagesize);
+
+	prot_none_addr = SAFE_MMAP(NULL, pagesize, PROT_NONE,
+		MAP_PRIVATE | MAP_ANONYMOUS, -1, 0);
+
+	testcases[0] = (struct testcase){
+		.desc = "uaddr unmapped",
+		.addr = unmapped,
+		.exp_errno = EFAULT,
+	};
+	testcases[1] = (struct testcase){
+		.desc = "uaddr PROT_NONE",
+		.addr = prot_none_addr,
+		.exp_errno = EFAULT,
+	};
+}
+
+static void cleanup(void)
+{
+	if (prot_none_addr)
+		SAFE_MUNMAP(prot_none_addr, getpagesize());
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
2.53.0


-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
