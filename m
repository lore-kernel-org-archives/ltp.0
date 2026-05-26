Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 13268CD5BC8
	for <ltp@archiver.kernel.org>; Tue, 26 May 2026 15:27:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=lists.linux.it;
 i=@lists.linux.it; q=dns/txt; s=picard; t=1779809268; h=to : date :
 message-id : in-reply-to : references : mime-version : subject :
 list-id : list-unsubscribe : list-archive : list-post : list-help :
 list-subscribe : from : reply-to : content-type :
 content-transfer-encoding : sender : from;
 bh=o9+DOwpqBhtuUtgAI7y7TS3uZ7Tush21L9HBFThjKBU=;
 b=baCONR8ImMeLYmP1eoBkqOUIKm3nMVeQPdfZ2pAl/cyG5lZ1ODS01DYLu8beXOAsKtD4m
 Oeces+uTJglhG89K8aS4qwv81UNjEil9MBIbqnp7k1waHG1KiVbKFcsRXzpk09451Kffkm3
 LZ6i6CFlkrP2cJyGKcydCQvNwgnG7gg=
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id B63F93E62CE
	for <ltp@archiver.kernel.org>; Tue, 26 May 2026 17:27:48 +0200 (CEST)
Received: from in-5.smtp.seeweb.it (in-5.smtp.seeweb.it [217.194.8.5])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 7D8E43E62CD
 for <ltp@lists.linux.it>; Tue, 26 May 2026 17:26:27 +0200 (CEST)
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.133.124])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-5.smtp.seeweb.it (Postfix) with ESMTPS id D3BD46005CC
 for <ltp@lists.linux.it>; Tue, 26 May 2026 17:26:26 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1779809185;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=qVL+GfmTqXo5grG6x96gnIh1exHJ+i4hSjeT25jdG40=;
 b=CuDpCmcXIA8AevCBEZCZgTb9MAiEEhL0cuykmIBXbmQ2edJ5q5r88oc4Ed1FFcMQTnGiE4
 LYQTnaOcll8YtWG4k+RGQiB/EhuQNfS+112XM94MhscGPf2e0fB5itTqYMkI0++hxevARe
 9u2KyvU9zflVXPMFb9KYo75ZMDZ7HG4=
Received: from mail-wr1-f71.google.com (mail-wr1-f71.google.com
 [209.85.221.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-400-Tk99T57ONv6OU17geMbehg-1; Tue, 26 May 2026 11:26:19 -0400
X-MC-Unique: Tk99T57ONv6OU17geMbehg-1
X-Mimecast-MFC-AGG-ID: Tk99T57ONv6OU17geMbehg_1779809178
Received: by mail-wr1-f71.google.com with SMTP id
 ffacd0b85a97d-44f56d5523eso9558712f8f.1
 for <ltp@lists.linux.it>; Tue, 26 May 2026 08:26:18 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1779809178; x=1780413978;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=qVL+GfmTqXo5grG6x96gnIh1exHJ+i4hSjeT25jdG40=;
 b=J3KXafmkEcsRdd0uY2SfaVNR/x1KGqrNaQ7el61K9oqFWYhQPnWSd4hgZEbf1WjCd6
 2dbJcOLf4uF7zSmjKVyjIIYIvsLHLyMiVfN+1ne/GCBIQWVO0DrfgKZVahiNpxQaEjXn
 z8P251Ix9+pZstNXa+vLpRl/hBdt82QNJqQlJutxwnF0urkDe71TEuE6TrGddoT5RXFU
 ++rzX8KHOWalC5YYq7+MhCZuwhgyZ400zIILBKfP6d0kFtTfI9KLxt42lCwkRiD6gS9F
 UKuODugEi6NV/3xnTjNb/d/2kPMAmXXZIDcYGl7AW5+DmohXbOvimOHAhiQwdJePaJNt
 Mbvg==
X-Gm-Message-State: AOJu0YyR6or5mSfcoKkcy+cFNQUZSbR1i8EcqG8QXk5oAMiU3r22X7iL
 QmSPUKy0H9bFhrH7+7zGLs0VSQpbTDUJ2BYrXo8xxg5T2Z4EZsW+YVEA1FCDeWvLMPD8auewS18
 CEB9IGDwEKf0H2wcGi5k783tkRVk0AUEk/SDfS5VJaJEhoiDZrJ49dW44UYfR/SBJvwvnMBf0nz
 PCNn+qdsHOwq4G3KFcu74uyQT96aS3e5F6HmR+
X-Gm-Gg: Acq92OFA5hxKtteWRd7HHn/N1EBauBAWILagzpRcW6+SPHQrWmtYE3HWOauT8vTrcQI
 zG22bxH0enhmG2YluR/fg+LVhPs6JhAJ9NqhU/pXK305EbbcXnYmYA0dwdG8Nsf1/kFXnuMGOI6
 OS22okxjBTHfRu0BzERCKCEgSifBTMhIcRn+hPFIAc0RHLECpz9NFoncrabjQiiupPrJr9eFCnv
 tlrfwTMktfkKtSlbJkr/dqcabA8F/xOYwBxmVKwy8nyxehL0mk4cK8khnptVSSb7+Cnh4UJG93Q
 qo02IHRFrymNm0wXMwbnaTDaOVpcZLluaddKdJEsd5Ze8nENUAYz/tna0LMxtbtd5SloJhBo4/A
 gadbfh4Px9Jmxoq0TVoijMWzPD4mw7jEK0P+44dxXKTwr6+RCbSXdiCPwHsXfhQ==
X-Received: by 2002:a05:600c:83c6:b0:490:5872:e641 with SMTP id
 5b1f17b1804b1-4905872e758mr223810035e9.18.1779809177913; 
 Tue, 26 May 2026 08:26:17 -0700 (PDT)
X-Received: by 2002:a05:600c:83c6:b0:490:5872:e641 with SMTP id
 5b1f17b1804b1-4905872e758mr223808945e9.18.1779809177266; 
 Tue, 26 May 2026 08:26:17 -0700 (PDT)
Received: from fedora.redhat.com (89-138-3-119.bb.netvision.net.il.
 [89.138.3.119]) by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-4904561a160sm384735795e9.9.2026.05.26.08.26.16
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 26 May 2026 08:26:16 -0700 (PDT)
To: ltp@lists.linux.it
Date: Tue, 26 May 2026 18:26:10 +0300
Message-ID: <20260526152613.109485-2-mmenashe@redhat.com>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <20260526152613.109485-1-mmenashe@redhat.com>
References: <20260526152613.109485-1-mmenashe@redhat.com>
MIME-Version: 1.0
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: maqdT5TGfVZuiIOf8eEH_s7XFpuNrA4XMQ-kbJh5Bi4_1779809178
X-Mimecast-Originator: redhat.com
X-Virus-Scanned: clamav-milter 1.0.9 at in-5.smtp.seeweb.it
X-Virus-Status: Clean
Subject: [LTP] [PATCH v11 1/4] futex_wait06: Add EFAULT error coverage test
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
index 000000000..b57e8a99b
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
