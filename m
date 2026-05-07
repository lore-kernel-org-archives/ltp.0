Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A901FCD343F
	for <ltp@archiver.kernel.org>; Thu,  7 May 2026 11:18:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=lists.linux.it;
 i=@lists.linux.it; q=dns/txt; s=picard; t=1778152724; h=to : date :
 message-id : in-reply-to : references : mime-version : subject :
 list-id : list-unsubscribe : list-archive : list-post : list-help :
 list-subscribe : from : reply-to : content-type :
 content-transfer-encoding : sender : from;
 bh=/QDGo4Zg68veGI9N/RlVv9I7p7ED6JIx9xjc59WIAYA=;
 b=h0FeBcWC/8kBZOVOCAcyLrrEcSO2/SiqWIrAQif6St45jKXLRjKtjRc76zOicKGXh4aXN
 WJeCW+MZyF6KkzPoVWFy02u/zBVWpobEpzJt9dVJQb1cnNgHdu6e56KELPrlkeN/DjJ7F+b
 diJm4CEqKazH+WFyJRxAvyxJHfK+COw=
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id AB9B73E2C43
	for <ltp@archiver.kernel.org>; Thu,  7 May 2026 13:18:44 +0200 (CEST)
Received: from in-2.smtp.seeweb.it (in-2.smtp.seeweb.it
 [IPv6:2001:4b78:1:20::2])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id E36243E24B3
 for <ltp@lists.linux.it>; Thu,  7 May 2026 13:18:19 +0200 (CEST)
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.133.124])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-2.smtp.seeweb.it (Postfix) with ESMTPS id 51EA8600853
 for <ltp@lists.linux.it>; Thu,  7 May 2026 13:18:18 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1778152697;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=ierHUqVkm+dDLserKBctsMm2rT+nsoK15Dn1M6vE4KU=;
 b=OOSD4rbyq9dPlV4UBti/UpoPCh2URb6iZe9j+C60foSZxatrRIOXNaIdzvV6nZPGTUfkg1
 KiSYhgrv32grLGJuUEVCpuR6pdoXqJwV8TcbrstnVwRpcr2/mfn8XeE9oHTQ/NIuWNMSJs
 bn1y2XgLqaUDVpn2fJBecNIruuyW7o4=
Received: from mail-wm1-f71.google.com (mail-wm1-f71.google.com
 [209.85.128.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-124-hIqCADNiNtWGEX0U_3h_EA-1; Thu, 07 May 2026 07:18:16 -0400
X-MC-Unique: hIqCADNiNtWGEX0U_3h_EA-1
X-Mimecast-MFC-AGG-ID: hIqCADNiNtWGEX0U_3h_EA_1778152695
Received: by mail-wm1-f71.google.com with SMTP id
 5b1f17b1804b1-48a589c7879so14230645e9.1
 for <ltp@lists.linux.it>; Thu, 07 May 2026 04:18:15 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1778152694; x=1778757494;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=ierHUqVkm+dDLserKBctsMm2rT+nsoK15Dn1M6vE4KU=;
 b=YUSJgKY7J3EhY8nag0nSplTcnOmfawISnFoiaVHNM3KdhwQ/nR0Siqnkor1r81drR4
 73Zk4q5qzPHQE51HiRknTgJUKQIyDq/yLUv1nvkI59JAV0VvkVYLJOJtlqe5gP5gKyhP
 SQUGGcYbhjFP15Od24fw7aLtWKSFLRt1vDYn2TFfsTBeA3T5htGmGprzTgq6KUUpln1J
 bfaYylVTWXHKGD0bj3L63iMrl71rcT6lrdqZiPFsFr7QW5zHRNihubJIY/fqk8M2yDFc
 vjejrmN3XM6MdhQZBgADLWTkUo/uXNKbqXz12R8ImbwFGKnLy9JRkrbbrFNfmbXpfooD
 sNpQ==
X-Gm-Message-State: AOJu0YyIFNKhZ9zA+WMPthVzhIG04+GPOSyIwda4+X/iIPUMCJiBbCXP
 9y88OmgFpuWblbgVbTZGA3Ur8ZCaO7p7qnZy5lGK0Rn52+YZACHZlRrKzfVg3NKXrVB16Aehl6o
 XPuYzOQfAQfcIS3icx2ZWw23EfKAiKGuL+VwEtTHaGCP5E/TUvyxglNuIi5XBT/jgIH4bLT+EOJ
 qUya7haERAz+AjqbdLs9tUATZMV5CaCtB+dtwS
X-Gm-Gg: AeBDietFqLKGK3nm2fNQAgFHZOifPCtURG0Pmp7rzgJD0szgpco0y2gS5r8HCPCWgy4
 N2RBkjRNVgBBdApbpRWCfIzrIpPbjIxtFI67Tj/gIZer2uWxOfL/1O4jEZ66G5Ro9rlC6gAJlpo
 WE36vq7Wi0Lu5TISlEzVVGgHYg1gRoNoayVuUbv4OUc41v5/wRlvexuHAvWPQWbe8MXmxqnTK8V
 EgvYwgWyQg83prDakclzBOwjZLb52LBpWbXC2MILMviorhJuJcIxAYGKUX++w7LU4UmiFDclTog
 6Qle2QaLHYgUBtBvNX2rb2bQtqwC8/V3p68zDqBxc8UygVlVK1owBcSEcl/wv3pjfUlKObjp9mZ
 QcpQY7z4qMyxYzlvTJfM+almiVNjkbN/MCC2ro0d2D+nXVgg4p20rhXtUxXBKvlCkqHngRmGVvy
 mR/g==
X-Received: by 2002:a05:600c:444f:b0:489:32b:ac0b with SMTP id
 5b1f17b1804b1-48e5dfd6a6amr37954555e9.6.1778152694317; 
 Thu, 07 May 2026 04:18:14 -0700 (PDT)
X-Received: by 2002:a05:600c:444f:b0:489:32b:ac0b with SMTP id
 5b1f17b1804b1-48e5dfd6a6amr37953815e9.6.1778152693625; 
 Thu, 07 May 2026 04:18:13 -0700 (PDT)
Received: from fedora.redhat.com (85.65.168.167.dynamic.barak-online.net.
 [85.65.168.167]) by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-48e530cf964sm74515835e9.1.2026.05.07.04.18.12
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 07 May 2026 04:18:13 -0700 (PDT)
To: ltp@lists.linux.it
Date: Thu,  7 May 2026 14:18:06 +0300
Message-ID: <20260507111809.28934-2-mmenashe@redhat.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260507111809.28934-1-mmenashe@redhat.com>
References: <20260507111809.28934-1-mmenashe@redhat.com>
MIME-Version: 1.0
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: b3Ulu_plSIRRkza1f6VUk8aMnGqp9iaMSy8CC5utvow_1778152695
X-Mimecast-Originator: redhat.com
X-Virus-Scanned: clamav-milter 1.0.9 at in-2.smtp.seeweb.it
X-Virus-Status: Clean
Subject: [LTP] [PATCH v4 1/4] futex_wait06: Add EFAULT error coverage test
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
