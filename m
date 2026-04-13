Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 59FAAF34C52
	for <ltp@archiver.kernel.org>; Mon, 13 Apr 2026 13:41:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=lists.linux.it;
 i=@lists.linux.it; q=dns/txt; s=picard; t=1776087666; h=to : date :
 message-id : mime-version : subject : list-id : list-unsubscribe :
 list-archive : list-post : list-help : list-subscribe : from :
 reply-to : content-type : content-transfer-encoding : sender : from;
 bh=ebQB9tMwY5dAb80+BUf89zqH+Yr5kGjO+MHM1rlyKc0=;
 b=F5O/NSngkY+UxqycCiLVDR1s/rYEE65GE8lCBgMiGjCBS6RlWl0VUzZKbB9RqNgDov50C
 pPJhfPsLHr1p5wei1d0djkRFaa5SpzNbnJMcpFbEJdO5BwkA6wuwkPfTjRShQ4+VdGfvxin
 t+vcHbmXMvx7l/luFPnKG3GeiZeE5xU=
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id DF1823E4B31
	for <ltp@archiver.kernel.org>; Mon, 13 Apr 2026 15:41:06 +0200 (CEST)
Received: from in-4.smtp.seeweb.it (in-4.smtp.seeweb.it
 [IPv6:2001:4b78:1:20::4])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id D81DB3E2699
 for <ltp@lists.linux.it>; Mon, 13 Apr 2026 15:40:42 +0200 (CEST)
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.133.124])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-4.smtp.seeweb.it (Postfix) with ESMTPS id DF3D010008F6
 for <ltp@lists.linux.it>; Mon, 13 Apr 2026 15:40:41 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1776087640;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding;
 bh=KJQTBegNi7DjChlWYvPLOgQU5+8vsQIFrvFlXvtL/Vw=;
 b=MO2l8gSGZNLgZ/nIbxgic5D32YZP7Mz06NrRSZ8idDwT+wkhTqMPzd1BYeGZy3G4UIOPSU
 y6JhY+p+Nx1l6f6mu3QytWtaMvprUjZLIcQFBttz8MWwJBUwElA59KoXfVUdrPC7glI3Q0
 C05B3npd/APBBaTXNoHCA1o0cSivv+I=
Received: from mail-wm1-f70.google.com (mail-wm1-f70.google.com
 [209.85.128.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-516-gGk5Fv54PrCirdLLwaPpCw-1; Mon, 13 Apr 2026 09:40:38 -0400
X-MC-Unique: gGk5Fv54PrCirdLLwaPpCw-1
X-Mimecast-MFC-AGG-ID: gGk5Fv54PrCirdLLwaPpCw_1776087637
Received: by mail-wm1-f70.google.com with SMTP id
 5b1f17b1804b1-488d56f87e8so24584835e9.0
 for <ltp@lists.linux.it>; Mon, 13 Apr 2026 06:40:38 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1776087637; x=1776692437;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=KJQTBegNi7DjChlWYvPLOgQU5+8vsQIFrvFlXvtL/Vw=;
 b=hi0jJmCTpcaqaviS0eeuLrlK+8j0YvzEvmT8rmkc7rwNUbIMucRARq+wDT9MneDsqA
 3mkk+Gihquaf5oa03rIIifQaDQObX9vKKA+fZL3IFJl887JzS9e7AMGFMtbv3jB4psog
 shr9Cs7aDWN0T75qS/F8281AJGJ5QqFR/RUrt/3h6Z+hEGuIqvdPq/YBXiGr9OGXtyrA
 90MrdJMRatMNtwrwuGU4VRqUzJpDU793Vt4//8LDR3hmW059yVVGV6rCvrd9xcuQ1/Cf
 4/ek7nOf5/IsFwzT2MVg84YhZrq6sWshjaK3Xc3EqgJF/sf0lX3VBoS52alVSxLMCiDu
 U2Ow==
X-Gm-Message-State: AOJu0YxT1qce/ZvNNkX370F6G0vYu7ZkR0DKcCP+B95vat4LrsNnMMN2
 pEOWXxVx1k3didUHclMBKPF0eIHN3W7tP2gfmWZhumoFLJ8majN1lyZ9Uyh6M/eGoY81AsGeVC3
 S2S1UGMoV/4AX4sar9qAEUMIx06xrc8Th7HIQFjvdLYC/KpI6LkPv8aRhdkir19fPKhGZIKvzJY
 Xg3In55cp2SlTOAen2WMlof7VJ/yslgvVzCQq2
X-Gm-Gg: AeBDievvsEdei7Ujj/UXf9sulFz2DGZu40u+0whPXvPUObfyNrE+wBWFGY2qJI6gX0n
 Ftg+zlnTCVxk5ym7POW6b/xnApBN/Lezi9RSlX8TxEWYrc9CK/UlM0NLM/fvtLGisPsQBmf0wrj
 Ec85M6ChbGql7n+VC60pXhCWy9P/ej1YT9P+ROKgf110pyhifJV9ARp2ZGFk4ssoiTEUJEQp7Oh
 iuVEHRKbSt9kJIxEZR11UaPPKSVcpbbqRCFNSb1qngCgY+nP8RzgWplTdjy/yQmJpVPU/2fGNmF
 PO2Sena6lN1bmAsBRCmZ7Q7LHjg5bFzdfQAqMaPTNxOY7Eu2fi6oiGAhC3yz8xRP6YQo4wapI8D
 5/wAiVx00a7S2jKQ5le7hidq2WB0eDfaDMWE03ingqxJuq9zOMpYbokJ+pygm/Zx+q2A=
X-Received: by 2002:a05:600c:c084:b0:485:4006:960c with SMTP id
 5b1f17b1804b1-488d685b86bmr133489035e9.16.1776087636561; 
 Mon, 13 Apr 2026 06:40:36 -0700 (PDT)
X-Received: by 2002:a05:600c:c084:b0:485:4006:960c with SMTP id
 5b1f17b1804b1-488d685b86bmr133488565e9.16.1776087635788; 
 Mon, 13 Apr 2026 06:40:35 -0700 (PDT)
Received: from fedora.redhat.com (46-116-192-140.bb.netvision.net.il.
 [46.116.192.140]) by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-43d6ffd3880sm17533762f8f.7.2026.04.13.06.40.33
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 13 Apr 2026 06:40:34 -0700 (PDT)
To: ltp@lists.linux.it
Date: Mon, 13 Apr 2026 16:40:29 +0300
Message-ID: <20260413134029.43754-1-mmenashe@redhat.com>
X-Mailer: git-send-email 2.53.0
MIME-Version: 1.0
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: jzPxj1lGFv79A5a800RlruxrCDAwLaicUMRih9IZLXY_1776087637
X-Mimecast-Originator: redhat.com
X-Virus-Scanned: clamav-milter 1.0.9 at in-4.smtp.seeweb.it
X-Virus-Status: Clean
Subject: [LTP] [PATCH v2] futex: Add error coverage tests for wait,
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
v2: Use TST_EXP_FAIL macro as requested.
    Store address directly in testcase structs and not using flags.
    Use SAFE_MMAP and not raw as requested, also added a sign off.
 runtest/syscalls                              |   4 +
 testcases/kernel/syscalls/futex/.gitignore    |   4 +
 .../syscalls/futex/futex_cmp_requeue03.c      |  96 ++++++++++++++
 .../kernel/syscalls/futex/futex_wait06.c      |  73 +++++++++++
 .../kernel/syscalls/futex/futex_wait07.c      | 117 ++++++++++++++++++
 .../kernel/syscalls/futex/futex_wake05.c      |  86 +++++++++++++
 6 files changed, 380 insertions(+)
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
diff --git a/testcases/kernel/syscalls/futex/futex_wait07.c b/testcases/kernel/syscalls/futex/futex_wait07.c
new file mode 100644
index 000000000..a3c1c153d
--- /dev/null
+++ b/testcases/kernel/syscalls/futex/futex_wait07.c
@@ -0,0 +1,117 @@
+// SPDX-License-Identifier: GPL-2.0-or-later
+/*
+ * Copyright (C) 2026 Red Hat, Inc.
+ */
+
+/*\
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
