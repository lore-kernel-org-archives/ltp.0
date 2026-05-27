Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 23A86CD4F54
	for <ltp@archiver.kernel.org>; Wed, 27 May 2026 09:27:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=lists.linux.it;
 i=@lists.linux.it; q=dns/txt; s=picard; t=1779874031; h=to : date :
 message-id : in-reply-to : references : mime-version : subject :
 list-id : list-unsubscribe : list-archive : list-post : list-help :
 list-subscribe : from : reply-to : content-type :
 content-transfer-encoding : sender : from;
 bh=K38O+36wOjadXBL1dK6tJKnxaf/N+50ssFdvb0PKYI4=;
 b=bHVZHRFadD19EWH6LzSrw/2ZKAx1tD/Rn1nGDrbI8ALVxTCz5MlSTHLyM7u17OkT8gVli
 33f1INqlvFjEWlyxi8XtfNQZNlmKVaQHsi3jwzc/6bc5Ye7yOgJQ/zrDDEALucE1CqaZquC
 Oe1j4c06kXCt7DPHdMTeIIrSOwagS0s=
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 7FDAC3CB964
	for <ltp@archiver.kernel.org>; Wed, 27 May 2026 11:27:11 +0200 (CEST)
Received: from in-5.smtp.seeweb.it (in-5.smtp.seeweb.it
 [IPv6:2001:4b78:1:20::5])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id D1A363C985D
 for <ltp@lists.linux.it>; Wed, 27 May 2026 11:26:27 +0200 (CEST)
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.129.124])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-5.smtp.seeweb.it (Postfix) with ESMTPS id 420DF600915
 for <ltp@lists.linux.it>; Wed, 27 May 2026 11:26:26 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1779873985;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=gtpn6ylvYyJnPI4V0/btrH6aGawzW6Gkqz3NYfgAy8g=;
 b=cYPP43yV0iY+e4SfYLpvFTungjBV8f07oAbXilum9zvC9o/vefXffrCr/rjLfLOHi88P+Q
 UuJoFSkdem0MSKPp3GcUB5Dys8DzEm3bcVpgsjaHoTeGJc5y3cz2iMPH9ReyRjxU5dotQ2
 0u5MHlKSWozIGkYOyymSzLfu2+2FnI4=
Received: from mail-wm1-f72.google.com (mail-wm1-f72.google.com
 [209.85.128.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-563-CxIjMVi7PJ-3FROjveZ5KA-1; Wed, 27 May 2026 05:26:24 -0400
X-MC-Unique: CxIjMVi7PJ-3FROjveZ5KA-1
X-Mimecast-MFC-AGG-ID: CxIjMVi7PJ-3FROjveZ5KA_1779873983
Received: by mail-wm1-f72.google.com with SMTP id
 5b1f17b1804b1-4905428aad6so35318785e9.1
 for <ltp@lists.linux.it>; Wed, 27 May 2026 02:26:24 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1779873983; x=1780478783;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=gtpn6ylvYyJnPI4V0/btrH6aGawzW6Gkqz3NYfgAy8g=;
 b=gGLurp1Dij4HEuu8iUL6JEvpXmChyg5Ya+pD+Ijt0iXLaQjA7vHBOsxftDjuCitJHF
 nGjnmsOyZ6zcmkSxqDLDL6zQdYds6LzDDu+kC05ehtCjCByri+bsatN7dHkCStxed9Ug
 SqANJX8z8h5u2q6AJy+5kv8HhI0woyFbdXwfgxw6Jew4twb4KNmc6czOzIV50FR1/AI6
 jPhCNt2gEDw5VtaW58Nf4Pa4o758zomWSTGRDXmutZm4TCLstLt55qAsmZQ6i7Iny5w5
 VlwAB8sP/+hXRDNGzngP+QKldj/ocq4SnaibNUxevicAxZlTqKz+lmwtARxTNv8KqKOD
 9JaQ==
X-Gm-Message-State: AOJu0YwZqZBiiYhTN8t8sq6E/5ELWSvg1+Rg/ZuAhqaeeG50NrvQMyVX
 FZhtShluWcuue7FdvFpw4lxmAcmVe5MQNkpJZPdyd/IKyVadit0IN5sBvBlmuePVOf/bFhB8CTu
 MIHz+FLHzlh/z/BThV3hwJEUoaSJt6K9keaIHUKVOaYxCJ97BxSJRmV1mNK5u10px2l+PM/rPoL
 y+y0rlvR+Faq7PQx2QvMScD1qXnmEbiDanTans
X-Gm-Gg: Acq92OG3mETZ2oCLTSSpuu1Rg7UH+01QrrJ9Jqe61spRuRN2JrqOjQA5N8GHmZr8h7D
 dPiKDnmnjHBvPR1ZfV4gklZZAEjIGJHVAK7djxyOcRnHFckLBpmJfiLdHfg+tOYgtMLhviiu8gO
 3/y7GQcvAD0N5dqDjU7lorVebn/8lFHTAdWTwehM5cwDh2CU30BEiftze6puXg88sb+x/tTt5+/
 Msg960RoxW/kRhOsLJerD3BJSfzc1aUSXPhak5zsNILH/vb0Uql+5hKQhFCskU/A5fVpE7ukawo
 kjL/OZGqTrryb/6jg8gZ/uzt2wV0CErs0YN6953+xUGqrHNEqiG2rDeBbrs+7UtS6k+Mfnot+mx
 ftBABcnkpYeC9pRzlJZMIbQmugBMNaipra3HcRzK+tEenJ7ZMe/p6tcNQElup9w==
X-Received: by 2002:a05:600c:a402:b0:490:3d62:eb0 with SMTP id
 5b1f17b1804b1-490426d7019mr303158125e9.24.1779873983154; 
 Wed, 27 May 2026 02:26:23 -0700 (PDT)
X-Received: by 2002:a05:600c:a402:b0:490:3d62:eb0 with SMTP id
 5b1f17b1804b1-490426d7019mr303157775e9.24.1779873982759; 
 Wed, 27 May 2026 02:26:22 -0700 (PDT)
Received: from fedora.redhat.com (89-138-3-119.bb.netvision.net.il.
 [89.138.3.119]) by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-45edb5a281dsm4552653f8f.24.2026.05.27.02.26.21
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 27 May 2026 02:26:21 -0700 (PDT)
To: ltp@lists.linux.it
Date: Wed, 27 May 2026 12:26:15 +0300
Message-ID: <20260527092618.14824-2-mmenashe@redhat.com>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <20260527092618.14824-1-mmenashe@redhat.com>
References: <20260527092618.14824-1-mmenashe@redhat.com>
MIME-Version: 1.0
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: Fhs2Yemy7bzA1gtaslmenLsc01JwKbTIpE2X7SWi9C4_1779873983
X-Mimecast-Originator: redhat.com
X-Virus-Scanned: clamav-milter 1.0.9 at in-5.smtp.seeweb.it
X-Virus-Status: Clean
Subject: [LTP] [PATCH v14 1/4] futex_wait06: Add EFAULT error coverage test
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
 .../kernel/syscalls/futex/futex_wait06.c      | 75 +++++++++++++++++++
 3 files changed, 77 insertions(+)
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
index 000000000..a54c0a3c5
--- /dev/null
+++ b/testcases/kernel/syscalls/futex/futex_wait06.c
@@ -0,0 +1,75 @@
+// SPDX-License-Identifier: GPL-2.0-or-later
+/*
+ * Copyright (C) 2026 Red Hat, Inc.
+ * Copyright (C) 2026 Michael Menasherov <mmenashe@redhat.com>
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
+				   timeout, NULL, 0, 0), EFAULT, "%s", tc->desc);
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
+			MAP_PRIVATE | MAP_ANONYMOUS, -1, 0);
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
