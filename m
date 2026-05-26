Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 94BC2CD5BD1
	for <ltp@archiver.kernel.org>; Tue, 26 May 2026 09:08:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=lists.linux.it;
 i=@lists.linux.it; q=dns/txt; s=picard; t=1779786485; h=to : date :
 message-id : in-reply-to : references : mime-version : subject :
 list-id : list-unsubscribe : list-archive : list-post : list-help :
 list-subscribe : from : reply-to : content-type :
 content-transfer-encoding : sender : from;
 bh=cpqVHyZUeLozGjrp0ynzV+5wAWYVlTbePlVQ+67QlTk=;
 b=fuSryK2EHqAkhyiBT35WL4aHfD5LltNBjLKkUEoNqkiDJRtZfNlbV7/yI6mBexxRBiyRz
 1gnndcvYtJfuqtVejcoSvCs99z+VnBssAxLNEvhW6MXOjKvl+T1HlWix2FnirHA2AJ1Uyj1
 aAS5yosXO1dD4pzux2HNBQaEuWYxzQ8=
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 149F03E524A
	for <ltp@archiver.kernel.org>; Tue, 26 May 2026 11:08:05 +0200 (CEST)
Received: from in-3.smtp.seeweb.it (in-3.smtp.seeweb.it
 [IPv6:2001:4b78:1:20::3])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id CD24A3CDE35
 for <ltp@lists.linux.it>; Tue, 26 May 2026 11:07:41 +0200 (CEST)
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.133.124])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-3.smtp.seeweb.it (Postfix) with ESMTPS id 2253B1A00812
 for <ltp@lists.linux.it>; Tue, 26 May 2026 11:07:40 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1779786458;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=PnaQB1+XACpyXMQD86kyWnXvkbbQ9Bvdlxw/R+dcCaI=;
 b=TXK6CuQhdRqM+1Fh6K7nxfRTHU/sBOHqd+21lZLbG6ALNmZHccEDkuvnaYAWy4t/y3cket
 eMiZkQ3CsTK6Js/Roxklx8tONON5vhTX+Tzy90eK5GUoIcO/tXkwg6HsHEtAwFjPIqK+Nb
 3os0HsKoEL1oOPmQARtCb+ZK1O3UyEo=
Received: from mail-wm1-f72.google.com (mail-wm1-f72.google.com
 [209.85.128.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-168-4pKmZe_iM2eFgQrreiUdpQ-1; Tue, 26 May 2026 05:07:37 -0400
X-MC-Unique: 4pKmZe_iM2eFgQrreiUdpQ-1
X-Mimecast-MFC-AGG-ID: 4pKmZe_iM2eFgQrreiUdpQ_1779786456
Received: by mail-wm1-f72.google.com with SMTP id
 5b1f17b1804b1-490402ae2c1so41407735e9.0
 for <ltp@lists.linux.it>; Tue, 26 May 2026 02:07:36 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1779786456; x=1780391256;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=PnaQB1+XACpyXMQD86kyWnXvkbbQ9Bvdlxw/R+dcCaI=;
 b=T6QsOXQo0SExt2SIZpnvfXzOmSFL3U0xOzSVPLgiHQcHWCfYzaH+NZabup1B8Y0ln/
 4zAl58IquFPKEaU2Rav4YkczxqNFYfz+yJB43kpCviWb+1HONCGd97Rmj1t+zaEwhJJv
 ryq3g4iqHXi4vD8KOte2aRaQoRA42F50GqBJyVO1IpfF9PPNLe2u0Np+6IhogAoI6QP5
 iq9ChZ92EMmXD5LGR/GEGZETYq0rnJ+tJu5b6UnjUQQx2i02dy7vbtqXRzKABSQC60CB
 DIRGlQNqp211hiG4oxlyHwUxsa+Z3AvIgRn9ituO2snJ9ail5Uc//fadFXZqK8bYxvE5
 yhUw==
X-Gm-Message-State: AOJu0Yx+VLw/T7LDKV5A8VuYf0YcND2CkiCJBfsaKwOB8xNbzj8v0At1
 5WfltH2srBaKyK3ZhtBWBa6k06qgU/X8xk90rDNd2Niqoa/J5vAjk6SSXPH4wLGeuz6+cTEfZK2
 WgCZoFwBf5Wvw0ZL9fIzCUwlL1NaZ0mDysLrVFIsSeCYcvHPqyje/GLHnMtIiTPCTbVUorN7eQW
 PV+AAtjsGtCNCsNdaHRupTGno1ZOgli5Lj73Sh
X-Gm-Gg: Acq92OHmFycAjy/jAOP+X5dlE0u0r2spZNiCqcGWYkXUA35CRVDaHwWOV1Dd/B7ydim
 5pWXroWQWZoClm+Xa4IfkEMANu67H65ggcajsrM4J2oYV0BjEhTZPo3JNNq9FyvXIVs4Sq0NeyX
 n4ZDO2d6UUQ03fr3McCc/Mu1NkHfI4SEMq8Vd37ZRLjGSUQ2TyDG8kALNx2Vz+lAZ87cTi6ecHP
 vafct6hYXWfUvhhVhQxIuFB9iw2S/n+a6wlFi9Jeal9oqnrjbd1iVQ1Xga2i80SuSjtj1iN7Khu
 0O7YMx1csDZNoRxxcVrm26YRpD4ZfBhCi+2yKqQt314YQFI2lDoTbcmIuHFrXllBjbEO1NPTTsp
 pfa/3fH+Q7pZMoud9/QfIkTqu5d4KjlLQWf3j2LFM8XWZ4FaHGa5RdQNZkPkF3w==
X-Received: by 2002:a05:600c:4342:b0:490:4035:323 with SMTP id
 5b1f17b1804b1-490403503b0mr187710725e9.9.1779786455833; 
 Tue, 26 May 2026 02:07:35 -0700 (PDT)
X-Received: by 2002:a05:600c:4342:b0:490:4035:323 with SMTP id
 5b1f17b1804b1-490403503b0mr187710305e9.9.1779786455398; 
 Tue, 26 May 2026 02:07:35 -0700 (PDT)
Received: from fedora.redhat.com (89-138-3-119.bb.netvision.net.il.
 [89.138.3.119]) by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-45eb6c9f58dsm33274647f8f.5.2026.05.26.02.07.34
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 26 May 2026 02:07:34 -0700 (PDT)
To: ltp@lists.linux.it
Date: Tue, 26 May 2026 12:07:27 +0300
Message-ID: <20260526090730.22455-2-mmenashe@redhat.com>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <20260526090730.22455-1-mmenashe@redhat.com>
References: <20260526090730.22455-1-mmenashe@redhat.com>
MIME-Version: 1.0
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: vLQUfEmV47C9zOZEfCKI8SBCoJzTTkCOmBFfBldZNZw_1779786456
X-Mimecast-Originator: redhat.com
X-Virus-Scanned: clamav-milter 1.0.9 at in-3.smtp.seeweb.it
X-Virus-Status: Clean
Subject: [LTP] [PATCH v10 1/4] futex_wait06: Add EFAULT error coverage test
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
index f790e8f84..7d5ea849e 100644
--- a/runtest/syscalls
+++ b/runtest/syscalls
@@ -1868,6 +1868,7 @@ futex_wait02 futex_wait02
 futex_wait03 futex_wait03
 futex_wait04 futex_wait04
 futex_wait05 futex_wait05
+futex_wait06 futex_wait06
 futex_waitv01 futex_waitv01
 futex_waitv02 futex_waitv02
 futex_waitv03 futex_waitv03
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
