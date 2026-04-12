Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 24829E937E3
	for <ltp@archiver.kernel.org>; Sun, 12 Apr 2026 13:42:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=lists.linux.it;
 i=@lists.linux.it; q=dns/txt; s=picard; t=1776001330; h=to : date :
 message-id : mime-version : subject : list-id : list-unsubscribe :
 list-archive : list-post : list-help : list-subscribe : from :
 reply-to : content-type : content-transfer-encoding : sender : from;
 bh=cNN8UMrC0Hpilmi7D9nn5hFtPaiJme+QDwEtdPTh7X8=;
 b=YbeddYVCUpprP5MC6LX79WAtDqctNI+LEtljt2+FAUUe5/hp21dLfkWZyQhmC0BQvuvb6
 imEuHD79UXoCrHAcC2uVL03I/MAu5paFqStssLc9zFS9W/CYWhDR48yy8IrY/Rm8aJk7unJ
 WazDpU1YHJvST9H86TDDO35u9k2nKBc=
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id B75813E213C
	for <ltp@archiver.kernel.org>; Sun, 12 Apr 2026 15:42:10 +0200 (CEST)
Received: from in-5.smtp.seeweb.it (in-5.smtp.seeweb.it
 [IPv6:2001:4b78:1:20::5])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id A6D613E213C
 for <ltp@lists.linux.it>; Sun, 12 Apr 2026 15:41:44 +0200 (CEST)
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.129.124])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-5.smtp.seeweb.it (Postfix) with ESMTPS id 7E9F260074B
 for <ltp@lists.linux.it>; Sun, 12 Apr 2026 15:41:43 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1776001301;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding;
 bh=naFlAFVhA+9TkyhG4nLdXdkVbJwqb2GGgJyx+rsyqWg=;
 b=XeHaagsQODrmVhkTsAdqcwVVVgPGPzEsRSxM6GnTtOqmY3YgsJiN6463ci6MBZWVfMLwc9
 e7FQsjLInTFzS4Vl6j+0rAgFoAfmomDp401EIM3+bHUoReWWo7du+zn+Py9rqm4DjBxwWc
 2unqn9dWDq/WuZaruYyWQ0lFMmmP/ak=
Received: from mail-wr1-f72.google.com (mail-wr1-f72.google.com
 [209.85.221.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-651-DUntwQX4OkSz_RD0mFx9LA-1; Sun, 12 Apr 2026 09:41:39 -0400
X-MC-Unique: DUntwQX4OkSz_RD0mFx9LA-1
X-Mimecast-MFC-AGG-ID: DUntwQX4OkSz_RD0mFx9LA_1776001299
Received: by mail-wr1-f72.google.com with SMTP id
 ffacd0b85a97d-43d03ae4f2aso2563822f8f.1
 for <ltp@lists.linux.it>; Sun, 12 Apr 2026 06:41:39 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1776001298; x=1776606098;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=naFlAFVhA+9TkyhG4nLdXdkVbJwqb2GGgJyx+rsyqWg=;
 b=s162A+nIJwx9FPdyInVLQzuSealER1romk+BSptytPSVvMynbUTojHQx+Bx+PisgZC
 5ij7Q49KBwBPrD3CLHcSWh3yu07RdzRPym7gml6CXs2K5ARG9Kgv0JXtbZxIG98j8gHK
 NGUHic5Y6jr4ce6ossDEDBO6XE/zIx5dTROySUoqb0CY5FVNLG1JBJ1n61UpntStTHh4
 fXv4pxoxDQvU2FIUJF47CjZZLnvD2K+/77AaGPg3koOLU2JuURtCRecCAEFm7T9ss4xc
 dsfhD0aTB7ocAszxpdhEHbLGJRPrsD5nHnkB4wFmrYf3+WahGDRKDcL5UBDz3wRmLKaM
 M5NA==
X-Gm-Message-State: AOJu0YxYkvfp7olKKc6o7fD3UpDoigHv5SKpGnUhlotkuU39Ajbytnzu
 xMZfcWrWKTwe5hkFmsxCU4Ccc5Wjg/NWpqTbkSO7vqaWtbQHmxpFvDdO8R6LaUQJZG83hVmjyw/
 F6gBzStvo62VpoHCpSBpIrkhhjqLfsLR1HMaIvuwo2uVhJ3bqkX4Mh9hlllKAEW7K5dbAzvRGHt
 jihr15EGAMm4B6rnae+xcCCU+eUL5T4zoDz7cS
X-Gm-Gg: AeBDietaybbCD45Xcm/K6wN781NwRYA+sp219QOVwksneddmSN/xxqhAWCl8NB6n+VS
 yvXKZ5axS+hoIgpdnWb9pNMY7Dp1py6KH87gjAqPyvu2x/7RUMMyFR0DbPqQu9mklbm7CehZaa9
 /dU11FdTUi+4uduQB1t2z7u174+jDXT1FQigxjeSeQe5QuOn1gyXNu1ZvS0d7rvazi9FQdxmiP2
 xoYjUtdfQxt+HO9pnYXo1sLRqNT4tSBMRLWAqWOtWQr8tuQ8k1Mx6o3Xygox9fwasFtlrFY6wCk
 OrFEUGwwsnyg1xf6yeDBdc3o90qVrk1cz3dHnSKhJceKkFaI+Hpd+TwGx8GQmFioW6v4V10e8mO
 22XDmU8ZGVoJEnjgp2YM7DjstAFT8cP7nsXtEbiC/e/uaUpdnI7KG4GCpBa01HyBmSBY=
X-Received: by 2002:a05:600c:4e4d:b0:485:3193:6ddb with SMTP id
 5b1f17b1804b1-488d6808507mr136096055e9.3.1776001298102; 
 Sun, 12 Apr 2026 06:41:38 -0700 (PDT)
X-Received: by 2002:a05:600c:4e4d:b0:485:3193:6ddb with SMTP id
 5b1f17b1804b1-488d6808507mr136095545e9.3.1776001297484; 
 Sun, 12 Apr 2026 06:41:37 -0700 (PDT)
Received: from fedora.redhat.com (46-116-192-140.bb.netvision.net.il.
 [46.116.192.140]) by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-43d762decf6sm6090319f8f.8.2026.04.12.06.41.36
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sun, 12 Apr 2026 06:41:36 -0700 (PDT)
To: ltp@lists.linux.it
Date: Sun, 12 Apr 2026 16:40:46 +0300
Message-ID: <20260412134046.31161-1-mmenashe@redhat.com>
X-Mailer: git-send-email 2.53.0
MIME-Version: 1.0
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: 5GrrKZDwKGhJytchxgdKKvY4EF01LbQQHwBd96Ely1U_1776001299
X-Mimecast-Originator: redhat.com
X-Virus-Scanned: clamav-milter 1.0.9 at in-5.smtp.seeweb.it
X-Virus-Status: Clean
Subject: [LTP] [PATCH] futex: Add error coverage tests for wait,
 wake and cmp_requeue
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

Improve error handling coverage for futex syscalls by adding tests
for missing error conditions that were previously untested.

futex_wait06 verifies EFAULT is returned when uaddr or timeout
points to unmapped memory.

futex_wait07 verifies EINTR is returned when futex_wait() is
interrupted by a signal.

futex_wake05 verifies EFAULT is returned when uaddr points to
unmapped or PROT_NONE memory.

futex_cmp_requeue03 verifies EFAULT is returned when uaddr or
uaddr2 points to unmapped memory, and EACCES or EFAULT when uaddr
points to memory without read permission (PROT_NONE). The EACCES
behavior was introduced in kernel 5.9.
---
 runtest/syscalls                              |   4 +
 testcases/kernel/syscalls/futex/.gitignore    |   4 +
 .../syscalls/futex/futex_cmp_requeue03.c      | 102 ++++++++++++++++
 .../kernel/syscalls/futex/futex_wait06.c      |  81 +++++++++++++
 .../kernel/syscalls/futex/futex_wait07.c      | 114 ++++++++++++++++++
 .../kernel/syscalls/futex/futex_wake05.c      |  85 +++++++++++++
 6 files changed, 390 insertions(+)
 create mode 100644 testcases/kernel/syscalls/futex/futex_cmp_requeue03.c
 create mode 100644 testcases/kernel/syscalls/futex/futex_wait06.c
 create mode 100644 testcases/kernel/syscalls/futex/futex_wait07.c
 create mode 100644 testcases/kernel/syscalls/futex/futex_wake05.c

diff --git a/runtest/syscalls b/runtest/syscalls
index 6ba0227a8..6c12dc225 100644
--- a/runtest/syscalls
+++ b/runtest/syscalls
@@ -1859,11 +1859,14 @@ perf_event_open02 perf_event_open02
 
 futex_cmp_requeue01 futex_cmp_requeue01
 futex_cmp_requeue02 futex_cmp_requeue02
+futex_cmp_requeue03 futex_cmp_requeue03
 futex_wait01 futex_wait01
 futex_wait02 futex_wait02
 futex_wait03 futex_wait03
 futex_wait04 futex_wait04
 futex_wait05 futex_wait05
+futex_wait06 futex_wait06
+futex_wait07 futex_wait07
 futex_waitv01 futex_waitv01
 futex_waitv02 futex_waitv02
 futex_waitv03 futex_waitv03
@@ -1871,6 +1874,7 @@ futex_wake01 futex_wake01
 futex_wake02 futex_wake02
 futex_wake03 futex_wake03
 futex_wake04 futex_wake04
+futex_wake05 futex_wake05
 futex_wait_bitset01 futex_wait_bitset01
 
 memfd_create01 memfd_create01
diff --git a/testcases/kernel/syscalls/futex/.gitignore b/testcases/kernel/syscalls/futex/.gitignore
index 9d08ba7d3..c47d39b5b 100644
--- a/testcases/kernel/syscalls/futex/.gitignore
+++ b/testcases/kernel/syscalls/futex/.gitignore
@@ -1,15 +1,19 @@
 /futex_cmp_requeue01
 /futex_cmp_requeue02
+/futex_cmp_requeue03
 /futex_wait01
 /futex_wait02
 /futex_wait03
 /futex_wait04
 /futex_wait05
+/futex_wait06
+/futex_wait07
 /futex_wait_bitset01
 /futex_wake01
 /futex_wake02
 /futex_wake03
 /futex_wake04
+/futex_wake05
 /futex_waitv01
 /futex_waitv02
 /futex_waitv03
diff --git a/testcases/kernel/syscalls/futex/futex_cmp_requeue03.c b/testcases/kernel/syscalls/futex/futex_cmp_requeue03.c
new file mode 100644
index 000000000..66b18614d
--- /dev/null
+++ b/testcases/kernel/syscalls/futex/futex_cmp_requeue03.c
@@ -0,0 +1,102 @@
+// SPDX-License-Identifier: GPL-2.0-or-later
+/*
+ * Copyright (C) 2024 Red Hat, Inc.
+ *
+ * Check that futex(FUTEX_CMP_REQUEUE) returns EFAULT when uaddr or
+ * uaddr2 points to unmapped memory, and EACCES when uaddr points to
+ * memory without read permission (PROT_NONE).
+ */
+
+#include <errno.h>
+#include <sys/mman.h>
+
+#include "futextest.h"
+
+static futex_t futex = FUTEX_INITIALIZER;
+static void *unmapped_addr;
+static void *prot_none_addr;
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
+	/* 1 = uaddr is bad, 0 = uaddr2 is bad */
+	int bad_uaddr;
+	/* 1 = PROT_NONE address, 0 = unmapped address */
+	int use_prot_none;
+} testcases[] = {
+	{ "uaddr unmapped", 1, 0 },
+	{ "uaddr2 unmapped", 0, 0 },
+	{ "uaddr PROT_NONE", 1, 1 },
+};
+
+static void run(unsigned int n)
+{
+	struct futex_test_variants *tv = &variants[tst_variant];
+	struct testcase *tc = &testcases[n];
+	futex_t *bad;
+	futex_t *uaddr, *uaddr2;
+	int res;
+
+	if (tc->use_prot_none)
+		bad = (futex_t *)prot_none_addr;
+	else
+		bad = (futex_t *)unmapped_addr;
+
+	/* Assign bad address to uaddr or uaddr2, keep the other valid. */
+	if (tc->bad_uaddr) {
+		uaddr = bad;
+		uaddr2 = &futex;
+	} else {
+		uaddr = &futex;
+		uaddr2 = bad;
+	}
+
+	res = futex_cmp_requeue(tv->fntype, uaddr, futex, uaddr2, 1, 1, 0);
+	if (res != -1) {
+		tst_res(TFAIL, "futex_cmp_requeue() succeeded unexpectedly for '%s'", tc->desc);
+		return;
+	}
+	if (errno != EFAULT && errno != EACCES) {
+		tst_res(TFAIL | TERRNO, "futex_cmp_requeue() failed with unexpected error for '%s', expected EFAULT or EACCES",tc->desc);
+		return;
+	}
+	tst_res(TPASS | TERRNO, "futex_cmp_requeue() failed as expected for '%s'", tc->desc);
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
+	unmapped_addr = SAFE_MMAP(NULL, pagesize, PROT_READ | PROT_WRITE, MAP_PRIVATE | MAP_ANONYMOUS, -1, 0);
+	SAFE_MUNMAP(unmapped_addr, pagesize);
+	/* PROT_NONE = mapped but no read permission, triggers EACCES or EFAULT */
+	prot_none_addr = SAFE_MMAP(NULL, pagesize, PROT_NONE, MAP_PRIVATE | MAP_ANONYMOUS, -1, 0);
+}
+
+static void cleanup(void)
+{
+	if (prot_none_addr) {
+		SAFE_MUNMAP(prot_none_addr, getpagesize());
+	}
+}
+
+static struct tst_test test = {
+	.setup = setup,
+	.cleanup = cleanup,
+	.test = run,
+	.tcnt = ARRAY_SIZE(testcases),
+	.test_variants = ARRAY_SIZE(variants),
+};
diff --git a/testcases/kernel/syscalls/futex/futex_wait06.c b/testcases/kernel/syscalls/futex/futex_wait06.c
new file mode 100644
index 000000000..1b9db0241
--- /dev/null
+++ b/testcases/kernel/syscalls/futex/futex_wait06.c
@@ -0,0 +1,81 @@
+// SPDX-License-Identifier: GPL-2.0-or-later
+/*
+ * Copyright (C) 2024 Red Hat, Inc.
+ *
+ * Check that futex(FUTEX_WAIT) returns EFAULT when:
+ * 1) uaddr points to unmapped memory
+ * 2) timeout points to unmapped memory
+ */
+#include <errno.h>
+#include <sys/mman.h>
+
+#include "futextest.h"
+
+static futex_t futex = FUTEX_INITIALIZER;
+static void *bad_addr;
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
+} testcases[] = {
+	{ "uaddr points to unmapped memory" },
+	{ "timeout points to unmapped memory" },
+};
+
+static void run(unsigned int n)
+{
+	struct futex_test_variants *tv = &variants[tst_variant];
+	struct testcase *tc = &testcases[n];
+	int res;
+
+	if (n == 0) {
+		res = futex_syscall(tv->fntype, (futex_t *)bad_addr, FUTEX_WAIT, 0, NULL, NULL, 0, 0);
+	} else if (n == 1) {
+		res = futex_syscall(tv->fntype, &futex, FUTEX_WAIT, futex, bad_addr, NULL, 0, 0);
+	} else {
+		tst_brk(TBROK, "Invalid test case %u", n);
+		return;
+	}
+
+	if (res != -1) {
+		tst_res(TFAIL, "futex_wait() succeeded unexpectedly for '%s'", tc->desc);
+		return;
+	}
+
+	if (errno != EFAULT) {
+		tst_res(TFAIL | TERRNO, "futex_wait() expected EFAULT for '%s', got", tc->desc);
+		return;
+	}
+
+	tst_res(TPASS | TERRNO, "futex_wait() failed as expected for '%s'", tc->desc);
+}
+
+static void setup(void)
+{
+	struct futex_test_variants *tv = &variants[tst_variant];
+
+	tst_res(TINFO, "Testing variant: %s", tv->desc);
+	futex_supported_by_kernel(tv->fntype);
+	bad_addr = mmap(NULL, getpagesize(), PROT_NONE, MAP_PRIVATE | MAP_ANONYMOUS, -1, 0);
+
+	if (bad_addr == MAP_FAILED) {
+		tst_brk(TBROK | TERRNO, "mmap() failed");
+	}
+	SAFE_MUNMAP(bad_addr, getpagesize());
+}
+
+static struct tst_test test = {
+	.setup = setup,
+	.test = run,
+	.tcnt = ARRAY_SIZE(testcases),
+	.test_variants = ARRAY_SIZE(variants),
+};
diff --git a/testcases/kernel/syscalls/futex/futex_wait07.c b/testcases/kernel/syscalls/futex/futex_wait07.c
new file mode 100644
index 000000000..bfaacd03b
--- /dev/null
+++ b/testcases/kernel/syscalls/futex/futex_wait07.c
@@ -0,0 +1,114 @@
+// SPDX-License-Identifier: GPL-2.0-or-later
+/*
+ * Copyright (C) 2024 Red Hat, Inc.
+ * Check that futex(FUTEX_WAIT) returns EINTR when interrupted by a signal.
+ * A child process blocks on futex_wait() with a long timeout. The parent
+ * waits for the child to enter sleep state, then sends SIGUSR1 to it.
+ * The child verifies it received EINTR and exits accordingly.
+ */
+
+#include <errno.h>
+#include <signal.h>
+#include <sys/wait.h>
+
+#include "futextest.h"
+
+static futex_t *futex;
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
+/* We need a handler so SIGUSR1 is caught instead of killing the process.
+ * The empty body is needed, just receiving the signal is enough to
+ * interrupt futex_wait() and make it return into EINTR -1 status.
+ */
+static void sigusr1_handler(int sig LTP_ATTRIBUTE_UNUSED)
+{
+}
+
+static void do_child(void)
+{
+	struct futex_test_variants *tv = &variants[tst_variant];
+	struct sigaction sa;
+	struct tst_ts timeout;
+	int res;
+
+	/* Set up the signal handler for SIGUSR1 */
+	sa.sa_handler = sigusr1_handler;
+	sa.sa_flags = 0;
+	SAFE_SIGEMPTYSET(&sa.sa_mask);
+	SAFE_SIGACTION(SIGUSR1, &sa, NULL);
+
+	/* Create a timeout for 5 sec for this variant.
+	 * if no one wakes the child before 5 sec, futex_wait() will return
+	 * on its own with ETIMEDOUT and will not wait any longer
+	 */
+	timeout = tst_ts_from_ms(tv->tstype, 5000);
+	res = futex_wait(tv->fntype, futex, *futex, &timeout, 0);
+
+	if (res != -1) {
+		tst_res(TFAIL, "futex_wait() should have failed with EINTR but returned success instead");
+		exit(1);
+	}
+	if (errno != EINTR) {
+		tst_res(TFAIL | TERRNO, "futex_wait() expected EINTR but got something else, errno");
+		exit(1);
+	}
+	tst_res(TPASS | TERRNO, "futex_wait() returned EINTR as expected");
+	exit(0);
+}
+
+static void run(void)
+{
+	pid_t child;
+	int status;
+
+	child = SAFE_FORK();
+
+	if (child == 0) {
+		do_child();
+	}
+	/* Wait until child is sleeping before sending signal */
+	TST_PROCESS_STATE_WAIT(child, 'S', 0);
+	/* Wake up the child so it will return EINTR -1 status */
+	SAFE_KILL(child, SIGUSR1);
+	SAFE_WAITPID(child, &status, 0);
+	/* Check if the child finished everything as it should */
+	if (!WIFEXITED(status) || WEXITSTATUS(status) != 0) {
+		tst_res(TFAIL, "child exited abnormally");
+	}
+}
+
+static void setup(void)
+{
+	struct futex_test_variants *tv = &variants[tst_variant];
+
+	tst_res(TINFO, "Testing variant: %s", tv->desc);
+	futex_supported_by_kernel(tv->fntype);
+
+	/* Futex needs to be in a shared memory so the parent and the child can access into it */
+	futex = SAFE_MMAP(NULL, sizeof(*futex), PROT_READ | PROT_WRITE, MAP_ANONYMOUS | MAP_SHARED, -1, 0);
+	*futex = FUTEX_INITIALIZER;
+}
+
+static void cleanup(void)
+{
+	if (futex) {
+		SAFE_MUNMAP((void *)futex, sizeof(*futex));
+	}
+}
+
+static struct tst_test test = {
+	.setup = setup,
+	.cleanup = cleanup,
+	.test_all = run,
+	.test_variants = ARRAY_SIZE(variants),
+	.forks_child = 1,
+};
diff --git a/testcases/kernel/syscalls/futex/futex_wake05.c b/testcases/kernel/syscalls/futex/futex_wake05.c
new file mode 100644
index 000000000..891beb347
--- /dev/null
+++ b/testcases/kernel/syscalls/futex/futex_wake05.c
@@ -0,0 +1,85 @@
+// SPDX-License-Identifier: GPL-2.0-or-later
+/*
+ * Copyright (C) 2024 Red Hat, Inc.
+ *
+ * Check that futex(FUTEX_WAKE) returns EFAULT when:
+ * 1) uaddr points to unmapped memory
+ * 2) uaddr points to memory without read permission (PROT_NONE)
+ */
+
+#include <errno.h>
+#include <sys/mman.h>
+#include "futextest.h"
+
+static void *unmapped_addr;
+static void *prot_none_addr;
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
+	int opflags;
+	int exp_errno;
+} testcases[] = {
+	{ "uaddr unmapped", 0, EFAULT },
+	{ "uaddr PROT_NONE", 0, EFAULT },
+};
+
+static void run(unsigned int n)
+{
+	struct futex_test_variants *tv = &variants[tst_variant];
+	struct testcase *tc = &testcases[n];
+	futex_t *addr;
+	int res;
+
+	if (n == 0)
+		addr = (futex_t *)unmapped_addr;
+	else
+		addr = (futex_t *)prot_none_addr;
+	res = futex_wake(tv->fntype, addr, 1, tc->opflags);
+	if (res != -1) {
+		tst_res(TFAIL, "futex_wake() succeeded unexpectedly for '%s'", tc->desc);
+		return;
+	}
+	if (errno != tc->exp_errno) {
+		tst_res(TFAIL | TERRNO, "futex_wake() failed with unexpected error for '%s', we expected: %s", tc->desc, tst_strerrno(tc->exp_errno));
+		return;
+	}
+	tst_res(TPASS | TERRNO, "futex_wake() failed as expected for '%s'", tc->desc);
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
+	unmapped_addr = SAFE_MMAP(NULL, pagesize, PROT_READ | PROT_WRITE, MAP_PRIVATE | MAP_ANONYMOUS, -1, 0);
+	SAFE_MUNMAP(unmapped_addr, pagesize);
+	prot_none_addr = SAFE_MMAP(NULL, pagesize, PROT_NONE, MAP_PRIVATE| MAP_ANONYMOUS, -1, 0);
+}
+
+static void cleanup(void)
+{
+	if (prot_none_addr) {
+		SAFE_MUNMAP(prot_none_addr, getpagesize());
+	}
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
