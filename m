Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 38068CD3436
	for <ltp@archiver.kernel.org>; Wed,  6 May 2026 11:39:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=lists.linux.it;
 i=@lists.linux.it; q=dns/txt; s=picard; t=1778067543; h=to : date :
 message-id : in-reply-to : references : mime-version : subject :
 list-id : list-unsubscribe : list-archive : list-post : list-help :
 list-subscribe : from : reply-to : content-type :
 content-transfer-encoding : sender : from;
 bh=r0hBWmJS8ZoabB4RfleNIE2iO8B5EkXOTgPL7Nk3mZM=;
 b=g+KeiyfTcYpU0231qg5A7rLBh/cOTkz5SeNGPFlZh1Fs52cXHs/P4zRVeJhvJYKAHYUOR
 otcb5YlUiXsWeEuqw3KR6yqg7e1wt36MJHfnMsPiGw4RMqJEN6SJjDK96m4ZVjGHP88U5Yd
 u/wRYOdjiPiXYoDdlQ9EDJXU6HO8oVE=
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id D2F793E6153
	for <ltp@archiver.kernel.org>; Wed,  6 May 2026 13:39:03 +0200 (CEST)
Received: from in-7.smtp.seeweb.it (in-7.smtp.seeweb.it
 [IPv6:2001:4b78:1:20::7])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id A04EC3E6159
 for <ltp@lists.linux.it>; Wed,  6 May 2026 13:37:09 +0200 (CEST)
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.133.124])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-7.smtp.seeweb.it (Postfix) with ESMTPS id 19BB1200AD7
 for <ltp@lists.linux.it>; Wed,  6 May 2026 13:37:08 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1778067427;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=CW08z9pGHyXYfeAAgPmQjnqzWN3yJZ9FozyxaxroIh8=;
 b=CkOiFT3ypEsfEyolvSiSGnEyGWlSbms7XfktJI8GAowPGAefX0dfCF0K1ofLEXKtdkOsKb
 lwZo8ChwHgim3nEBsGP18+QYs3/dFQ/DCOm14J06zB11iK+d1z7V/uUc0AkbYfrEDNe8KM
 6QK+fptQemQbiCMPHlIAwyVIKTYddAw=
Received: from mail-wr1-f72.google.com (mail-wr1-f72.google.com
 [209.85.221.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-616-NJBUsIOONRmGQVxeLB0Ykw-1; Wed, 06 May 2026 07:37:06 -0400
X-MC-Unique: NJBUsIOONRmGQVxeLB0Ykw-1
X-Mimecast-MFC-AGG-ID: NJBUsIOONRmGQVxeLB0Ykw_1778067425
Received: by mail-wr1-f72.google.com with SMTP id
 ffacd0b85a97d-44d9ace59efso2392792f8f.1
 for <ltp@lists.linux.it>; Wed, 06 May 2026 04:37:06 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1778067424; x=1778672224;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=CW08z9pGHyXYfeAAgPmQjnqzWN3yJZ9FozyxaxroIh8=;
 b=aKDorU8WVkprTiHEKazxJogalPTSkV84XpveQ7CgVLFPGs4xWmcwzlKzPlGmj7OLhK
 /7tLm7cFPJtKW3U70SH0U6mtgqfu/XRizAJ5kjUZRdUXXE+TFbDHb5skg136P66aQWyp
 qLkIUz74fKfFOeIYbuuttdT4WY5QRnk5Rb4U2V5m770flEy7iRA7WWhEOBfQjXRQTfvn
 dDUip+OIAi8l3t5fkTpyJT1ct8Fa0Fp/vL6R7E3eQxvf0G5Q08QM+WoVQFf+3ccKPwr9
 Mf7+zWuZuL6V/QP1MY35XCovrz6MJsetXZbDJDJ7FYVCFwa0AvQzkWiQmEg4o2HVXe1Y
 HRTw==
X-Gm-Message-State: AOJu0YxMJgR5eKLcFg1J7S8EaIztHgVbclz2tb/zAgWbWJNG22Uu3486
 C+oOtI4OAYiM/1Bm/wLa2GUcbGCI27ze2AA8q1fe7Dpk+AWd/aPs6cErAmf6YcB4NZYLDwOBsWU
 AkYQefBackx2VgOgUoX7yz40xLhjrKNJuUxR0o2WsW2vbot4zdNhfc+KCuWruPeZb9GVhzmpray
 WdGTHj12oThZ4/mD7eE2ln9oIRENDTH3y/V6f3
X-Gm-Gg: AeBDiesw2ml6qEgi0VOTwHuavjamTEtqPimNdgDsC4FejXiQvU/PAeclxE1gBfNqqsW
 ES2iEO3/yFN+UmIo0weezkOkPNFa7Dx3kmI/9z9Osn5GsQIeYYa4DmjNrgnl2XjWKKa31gxyE65
 RNtqh+4yYC+RXXb1QpdlvG6OjtEotsx6lXCZdXwbLT9kQa1ckA/J0qQJJdgd0EQEJaasmYnTnk0
 QP3zNymxEQhb8U1jU5KBl87AORWNgRMTJzvmUPJWY81MrsD+OrAZB4XpmT/lOjHM1mefztmT4PD
 K3XBov4j2xvynMHIokzcgtFbpOjdtWHUMUYivc5o39Ddv5khKT4JW6RVmZCB7YSyU4+fWpJicCu
 tpuB3dRiaueRDSmlEMPfVoDd5A6WLpe7wh20U/EguhSOIYkFC2508euqtN0yE0wEqgDR9Klgm97
 V4JC0sKw==
X-Received: by 2002:a5d:5d02:0:b0:43e:aa88:f1a1 with SMTP id
 ffacd0b85a97d-4515d4d1107mr5341563f8f.30.1778067424010; 
 Wed, 06 May 2026 04:37:04 -0700 (PDT)
X-Received: by 2002:a5d:5d02:0:b0:43e:aa88:f1a1 with SMTP id
 ffacd0b85a97d-4515d4d1107mr5341511f8f.30.1778067423513; 
 Wed, 06 May 2026 04:37:03 -0700 (PDT)
Received: from fedora.redhat.com (85.65.168.167.dynamic.barak-online.net.
 [85.65.168.167]) by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-45055960022sm11919938f8f.26.2026.05.06.04.37.02
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 06 May 2026 04:37:03 -0700 (PDT)
To: ltp@lists.linux.it
Date: Wed,  6 May 2026 14:36:55 +0300
Message-ID: <20260506113655.10797-5-mmenashe@redhat.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260506113655.10797-1-mmenashe@redhat.com>
References: <20260506113655.10797-1-mmenashe@redhat.com>
MIME-Version: 1.0
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: fKJz12QZjjwohHKCn_HlNwvQqNa1dwOFX2rlNnTbvi0_1778067425
X-Mimecast-Originator: redhat.com
X-Virus-Scanned: clamav-milter 1.0.9 at in-7.smtp.seeweb.it
X-Virus-Status: Clean
Subject: [LTP] [PATCH 4/4] futex_cmp_requeue03: Add EFAULT and EACCES error
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

---
 runtest/syscalls                              |  1 +
 testcases/kernel/syscalls/futex/.gitignore    |  1 +
 .../syscalls/futex/futex_cmp_requeue03.c      | 96 +++++++++++++++++++
 3 files changed, 98 insertions(+)
 create mode 100644 testcases/kernel/syscalls/futex/futex_cmp_requeue03.c

diff --git a/runtest/syscalls b/runtest/syscalls
index 4d85a1d26..65baa44dc 100644
--- a/runtest/syscalls
+++ b/runtest/syscalls
@@ -1908,3 +1908,4 @@ perf_event_open03 perf_event_open03
 futex_wait06 futex_wait06
 futex_wait07 futex_wait07
 futex_wake05 futex_wake05
+futex_cmp_requeue03 futex_cmp_requeue03
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
index 000000000..099d5e35c
--- /dev/null
+++ b/testcases/kernel/syscalls/futex/futex_cmp_requeue03.c
@@ -0,0 +1,96 @@
+// SPDX-License-Identifier: GPL-2.0-or-later
+/*
+ * Copyright (C) 2026 Red Hat, Inc.
+ */
+
+/*\
+ * Check that futex(FUTEX_CMP_REQUEUE) returns EFAULT when uaddr or
+ * uaddr2 points to unmapped memory, and EACCES (or EFAULT on older kernels)
+ * when uaddr points to memory without read permission (PROT_NONE).
+ *
+ * The EACCES behavior for PROT_NONE was introduced in kernel 5.9.
+ */
+
+#include <errno.h>
+#include <sys/mman.h>
+
+#include "futextest.h"
+
+static futex_t futex_var = FUTEX_INITIALIZER;
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
+	futex_t *uaddr;
+	futex_t *uaddr2;
+	int exp_errno;
+} testcases[3];
+
+static void run(unsigned int n)
+{
+	struct futex_test_variants *tv = &variants[tst_variant];
+	struct testcase *tc = &testcases[n];
+
+	TST_EXP_FAIL(futex_cmp_requeue(tv->fntype, tc->uaddr, futex_var,
+		tc->uaddr2, 1, 1, 0), tc->exp_errno, "%s", tc->desc);
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
+		.uaddr = unmapped,
+		.uaddr2 = &futex_var,
+		.exp_errno = EFAULT,
+	};
+	testcases[1] = (struct testcase){
+		.desc = "uaddr2 unmapped",
+		.uaddr = &futex_var,
+		.uaddr2 = unmapped,
+		.exp_errno = EFAULT,
+	};
+	testcases[2] = (struct testcase){
+		.desc = "uaddr PROT_NONE",
+		.uaddr = prot_none_addr,
+		.uaddr2 = &futex_var,
+		.exp_errno = tst_kvercmp(5, 9, 0) >= 0 ? EACCES : EFAULT,
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
