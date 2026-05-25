Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6759BCD5BC9
	for <ltp@archiver.kernel.org>; Mon, 25 May 2026 19:05:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=lists.linux.it;
 i=@lists.linux.it; q=dns/txt; s=picard; t=1779735908; h=to : date :
 message-id : in-reply-to : references : mime-version : subject :
 list-id : list-unsubscribe : list-archive : list-post : list-help :
 list-subscribe : from : reply-to : content-type :
 content-transfer-encoding : sender : from;
 bh=QGYkSXUWXS5HRDk8D4FI24AKcEdeIbiMgwLe1QknOFY=;
 b=liWn6zyfT31DP/9Cu2dYzZeh4kvQLbtEITHeRp95IeNkNlJlt4L5KHss5SqCLfbbKkztn
 KeF1R/n7KzthuLg0vkJfi6vk79ESi/MPMQNM0mo0cfP/C7rlg8gn9XUhYUpcuDvd8XYFBNs
 2aZJDHyWvmV0y96kzZgY8nxC88BucO8=
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 0FEF73E1EA9
	for <ltp@archiver.kernel.org>; Mon, 25 May 2026 21:05:08 +0200 (CEST)
Received: from in-7.smtp.seeweb.it (in-7.smtp.seeweb.it
 [IPv6:2001:4b78:1:20::7])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 6B4503E63B9
 for <ltp@lists.linux.it>; Mon, 25 May 2026 21:03:54 +0200 (CEST)
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.133.124])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-7.smtp.seeweb.it (Postfix) with ESMTPS id B4E23200746
 for <ltp@lists.linux.it>; Mon, 25 May 2026 21:03:53 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1779735832;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=onA1d5xVvqwwQCCB8gTU99a7fqj2lPvgsFKxNvbpW24=;
 b=bL7ZZNb7ld5cydKecCbuJG8DnJHXf9iNr0RhoAp1X8b9ujqrtapTsOHYT95LVao4PXwgKo
 y34HjMkSm8Is4ERvlqlGNa3oyWNEwg6anj7l2rucVGYleQT5tB4bk5xQ6CVhLzyGdjSXQG
 +OCIRq9sGCPvf659IA6ZajtQM+pYGbA=
Received: from mail-wm1-f70.google.com (mail-wm1-f70.google.com
 [209.85.128.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-512-Z2eIt0vhNbiALoSM-yWKFg-1; Mon, 25 May 2026 15:03:49 -0400
X-MC-Unique: Z2eIt0vhNbiALoSM-yWKFg-1
X-Mimecast-MFC-AGG-ID: Z2eIt0vhNbiALoSM-yWKFg_1779735828
Received: by mail-wm1-f70.google.com with SMTP id
 5b1f17b1804b1-49051422d55so22216225e9.2
 for <ltp@lists.linux.it>; Mon, 25 May 2026 12:03:49 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1779735828; x=1780340628;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=onA1d5xVvqwwQCCB8gTU99a7fqj2lPvgsFKxNvbpW24=;
 b=fgCwRoLsQkIQvcFfYDJx7MqnfWQxBUV5AfYriWLpvEr2Kv3iId8B0UjuSwIf6TuXeK
 zb+wVYxSU41bocgWa9+24TqBsVX6vUaZKEUiArMqTP0uqnyJyvi3xW9+Mxn2DrJhvPLf
 3SRQQlL/gnbi+1Z99TTW0BeytWlOUU6Yx7ywTox7VSEkE9vNc1NwyWJnSVBa3jkScghM
 JDcVm4z/CwsXX38ZrBzNkRmQGktU/TASvKorQ893YFeGnwcrLnBCRtI0OTaEEn1Fut2x
 RfZZbpRZGumotEh/7XGChKpcsuBDktbp0eV7eQf1QGWYJZSQpDVWxh0/3/Of/ipGSp9L
 Ei0w==
X-Gm-Message-State: AOJu0YxClt2memqw5fhvn7HWqlYaUDNvMb+o4afVO7kdPCic1NwkndOQ
 EcEVuLPjY9Zk6jTtpcJm0EGtt3F48It3jefaRxGWI2esbk5RIE6jb76GNz0xPXqQdebG8sldpUT
 CHK35klh25kdgQexzMvx+GftP1o3Oq68q0cgTn4xfRv5y4oi9/qq84HIWUMvBkmjFM8GEUtFRGE
 UObiJO9IQpXr2i9/OSFoF1J3bBiKl9GoSS7FH5
X-Gm-Gg: Acq92OHX5fFAhYluoQpZjGf7ToxtSTZ69Wdj2D4a1GagtGaXlen2R2qglhR9YVuVzGj
 NCCR6XDCDwMeMKguUrvCrloXdnpB6LAanQOmvhKwCMLYvWd4r/etHYqSanb5NiU8Xxrf6H2+Pdq
 CJ0UN9mF911SPWj9V67242cqIboEJqdPNRuBUq3xprHVgKPDRJOurvffRPH19fEvWUSKdFLoGlL
 3b/BAQ16jucNeYGPTYCPWprc8jcgWyUgF1u2dX9VmZg9gPiE764K8wnwADEP3kEFeeKXBuCEiHH
 zIjNhXK36C051pcRtudD/secIoHfiWCBZzo9IRTEwUOKwsS6DsL55Le6ZjBVGuwVsiTzDiu/lRV
 nv7dswQrJKpeLJTyP7xpW8yffuSOt3ymzlHx/Dw7zt0gk6S0zFaRUaKDozZufLg==
X-Received: by 2002:a05:600c:46cb:b0:489:1c1f:35f1 with SMTP id
 5b1f17b1804b1-49042482762mr264320025e9.4.1779735827814; 
 Mon, 25 May 2026 12:03:47 -0700 (PDT)
X-Received: by 2002:a05:600c:46cb:b0:489:1c1f:35f1 with SMTP id
 5b1f17b1804b1-49042482762mr264319485e9.4.1779735827377; 
 Mon, 25 May 2026 12:03:47 -0700 (PDT)
Received: from fedora.redhat.com (89-138-3-119.bb.netvision.net.il.
 [89.138.3.119]) by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-4904527f7f7sm397695995e9.7.2026.05.25.12.03.46
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 25 May 2026 12:03:46 -0700 (PDT)
To: ltp@lists.linux.it
Date: Mon, 25 May 2026 22:03:41 +0300
Message-ID: <20260525190344.60330-2-mmenashe@redhat.com>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <20260525190344.60330-1-mmenashe@redhat.com>
References: <20260525190344.60330-1-mmenashe@redhat.com>
MIME-Version: 1.0
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: EDsuiGax8RWUDJmjXoaZ8c0CIQI_M6hIo_KS3wY4qbA_1779735828
X-Mimecast-Originator: redhat.com
X-Virus-Scanned: clamav-milter 1.0.9 at in-7.smtp.seeweb.it
X-Virus-Status: Clean
Subject: [LTP] [PATCH v9 1/4] futex_wait06: Add EFAULT error coverage test
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
 .../kernel/syscalls/futex/futex_wait06.c      | 74 +++++++++++++++++++
 3 files changed, 76 insertions(+)
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
index 000000000..0d0880443
--- /dev/null
+++ b/testcases/kernel/syscalls/futex/futex_wait06.c
@@ -0,0 +1,74 @@
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
+	int bad_uaddr;
+	int bad_timeout;
+} testcases[] = {
+	{
+		.desc = "uaddr points to unmapped memory",
+		.bad_uaddr = 1,
+	},
+	{
+		.desc = "timeout points to unmapped memory",
+		.bad_timeout = 1,
+	},
+};
+
+static void run(unsigned int n)
+{
+	struct futex_test_variants *tv = &variants[tst_variant];
+	struct testcase *tc = &testcases[n];
+	struct tst_ts ts = tst_ts_from_ms(tv->tstype, 5000);
+	futex_t *uaddr = tc->bad_uaddr ? bad : &futex;
+	void *timeout = tc->bad_timeout ? (void *)bad : tst_ts_get(&ts);
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
