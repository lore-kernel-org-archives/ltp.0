Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 35858EA719B
	for <ltp@archiver.kernel.org>; Sun, 19 Apr 2026 13:01:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=lists.linux.it;
 i=@lists.linux.it; q=dns/txt; s=picard; t=1776603697; h=to : date :
 message-id : mime-version : subject : list-id : list-unsubscribe :
 list-archive : list-post : list-help : list-subscribe : from :
 reply-to : content-type : content-transfer-encoding : sender : from;
 bh=qgds83nVlFrwkdBUue0Myj7TVzEnz70wR712yRaqwE0=;
 b=djQ9G716cooQcTZxjM44iXaJhffvXsoNSazK5GZhZAZqAYrZ+81hfM8gS0iwJfRgvKu52
 m8aw1klI1Y123ypqaqy8HiVS1JjkR99GFCL48F+TEcwQfG9S1YO5m/iieeKELwxTyvnyiKU
 BSCUiE2+7EqquqJH5tiWKOinpDcVtEM=
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 5BEAD3E2947
	for <ltp@archiver.kernel.org>; Sun, 19 Apr 2026 15:01:37 +0200 (CEST)
Received: from in-4.smtp.seeweb.it (in-4.smtp.seeweb.it
 [IPv6:2001:4b78:1:20::4])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id A8DF13C041A
 for <ltp@lists.linux.it>; Sun, 19 Apr 2026 15:01:12 +0200 (CEST)
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.133.124])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-4.smtp.seeweb.it (Postfix) with ESMTPS id 7EC8D10001A6
 for <ltp@lists.linux.it>; Sun, 19 Apr 2026 15:01:10 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1776603669;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding;
 bh=y2vuzX9gKGB/X3ta3qI4VnLTEdIAOGUqsXCkf4lvhjU=;
 b=T/A80tyUJ9qCG8myPihRkv/WYWiYSQ55Qn4j4nm4NNw96k0isVdXf2bxaV5plnWsOzjBJ9
 ef26EEArfOlq1JHFfb6kZ5UTq5VYr+4Q+4bVp90hAJhQUc9Sbo3OCygSPXBveOeuFieY7w
 tCJcIWkjGV/EKbhAkBejECvTVgMroR8=
Received: from mail-pf1-f199.google.com (mail-pf1-f199.google.com
 [209.85.210.199]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-98-Sd74zOTTOvKbqnb_0gj5Ng-1; Sun, 19 Apr 2026 09:01:08 -0400
X-MC-Unique: Sd74zOTTOvKbqnb_0gj5Ng-1
X-Mimecast-MFC-AGG-ID: Sd74zOTTOvKbqnb_0gj5Ng_1776603667
Received: by mail-pf1-f199.google.com with SMTP id
 d2e1a72fcca58-82f896eb6faso2313144b3a.3
 for <ltp@lists.linux.it>; Sun, 19 Apr 2026 06:01:07 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1776603666; x=1777208466;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=y2vuzX9gKGB/X3ta3qI4VnLTEdIAOGUqsXCkf4lvhjU=;
 b=cvr/ufXpr5nslvNkgEsh8FtEnLfWbs/attlJGtcHcCZJwXzoYgwTYVr017ThCTxSS8
 bgcfRYSVrWvsUJfK59+vH3a7tdZeh/wiqSN/H/nf7Cdk5r3D+lpPp9Du1SdzsCGnZkVJ
 OuAo4ybSWj1w/2EgkG/mASCKx5kmflxJ6gzkKf/boQGA5r1cU1i800y6S7XLBthdJdvJ
 hIOaVXFb4YlGLxFURK/hpCQFEx+n5u2/6CV6lSYjvHdfWqIFwc/NkLKyxyEHP5QELP7a
 d6pscc8/u9C9peUuvIFBVJ+d0j8AAR22l/+B1JrkzHAGqDxfz7PnLHV18zTOINongElf
 QqYw==
X-Gm-Message-State: AOJu0YyEmsHUC6UZLTadXLoKw32eMwKFvKsvod2tCLm33FVKyg4bcQLe
 d+hiODSwEMEWpOcIWMT8dMkyADmbxW3MFlwb47dAMb+ySmUvTxap2n9xAY1f9sHlDvakT31EuzO
 rRHv3BTsNnmUmQrk1dcJAFymBVzjPqOK7OS/SWT6KZOg+Cdj5QwrL2SQVGc18XrBewOcsJV5xhz
 XnV8JuGc5+O+nTU53FnvgFSnL4dCAjhL3KVfU1
X-Gm-Gg: AeBDiev82aFM3vCO4u+VEzEwv7nanONkR9XXJFqn7i7qWWJjD2TkcB97OuoURZVUuHu
 e86/zC2FgGeBjgyfPwumRmKEVNHQ4h4ujmevx95AqzxxcjgZp6sZxIzSQhsmZWa0xT2lfbf9RX1
 FtuKbUx98n6jxDIgG0Umnr3Vr1TZtY0drVFzUloNYsWJZlEXFy/qJnejjzuTIDuZkSW0aiWYyB4
 /KdTt99+2MSyHB68hK/+MxaWFNbHVLwX+J2DsKhrIr1lANCG+J70m4LMs+Dj/J2yMdXWRP0wpHI
 gahPly9I56fdg2fS8ifIhqPnDc8RtFpXL1pWsfkLzu9l2eN27OpyUE2QBECygU6SvPC1BG6ZpHP
 xpDUeELVlx1gdOaQOgqlZabmN2zZrPbb3BTk4au8XlWy4pnPc2Fc83qXlniTK6vruOe/hXE6Z2p
 Rwww==
X-Received: by 2002:a05:6a00:3498:b0:82c:20be:57e6 with SMTP id
 d2e1a72fcca58-82f8c81273emr10048599b3a.11.1776603665938; 
 Sun, 19 Apr 2026 06:01:05 -0700 (PDT)
X-Received: by 2002:a05:6a00:3498:b0:82c:20be:57e6 with SMTP id
 d2e1a72fcca58-82f8c81273emr10048525b3a.11.1776603665055; 
 Sun, 19 Apr 2026 06:01:05 -0700 (PDT)
Received: from fedora.redhat.com (46-116-192-140.bb.netvision.net.il.
 [46.116.192.140]) by smtp.gmail.com with ESMTPSA id
 d2e1a72fcca58-82f8e9fbb85sm8958336b3a.22.2026.04.19.06.01.00
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sun, 19 Apr 2026 06:01:03 -0700 (PDT)
To: ltp@lists.linux.it
Date: Sun, 19 Apr 2026 16:00:53 +0300
Message-ID: <20260419130053.13996-1-mmenashe@redhat.com>
X-Mailer: git-send-email 2.53.0
MIME-Version: 1.0
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: 4KM7p9vTm0QdHP1aXW2gE7Z4LLS8Fj2_LVz7BiRbvSw_1776603667
X-Mimecast-Originator: redhat.com
X-Virus-Scanned: clamav-milter 1.0.9 at in-4.smtp.seeweb.it
X-Virus-Status: Clean
Subject: [LTP] [PATCH v3] futex: Add error coverage tests for wait,
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

Signed-off-by: Michael Menasherov <mmenashe@redhat.com>
---
v3:
- Fix copyright year 2024 -> 2026
- Use /*\ comment format for test catalog
- Use TST_EXP_FAIL instead of manual error checks
- Add kernel version check for EACCES in futex_cmp_requeue03
- Restructure testcases to use direct pointers instead of flag fields
- Remove obvious comments in futex_wait07
- Remove manual SAFE_WAITPID, let library collect child
- Remove curly braces around single-line if bodies
- Replace raw mmap() with SAFE_MMAP() in futex_wait06

 runtest/syscalls                              |  4 +
 testcases/kernel/syscalls/futex/.gitignore    |  4 +
 .../syscalls/futex/futex_cmp_requeue03.c      | 96 +++++++++++++++++++
 .../kernel/syscalls/futex/futex_wait06.c      | 73 ++++++++++++++
 .../kernel/syscalls/futex/futex_wait07.c      | 91 ++++++++++++++++++
 .../kernel/syscalls/futex/futex_wake05.c      | 86 +++++++++++++++++
 6 files changed, 354 insertions(+)
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
index 000000000..c3063389a
--- /dev/null
+++ b/testcases/kernel/syscalls/futex/futex_wait07.c
@@ -0,0 +1,91 @@
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
+
+	sa.sa_handler = sigusr1_handler;
+	sa.sa_flags = 0;
+	SAFE_SIGEMPTYSET(&sa.sa_mask);
+	SAFE_SIGACTION(SIGUSR1, &sa, NULL);
+
+	timeout = tst_ts_from_ms(tv->tstype, 5000);
+	TST_EXP_FAIL(futex_wait(tv->fntype, futex, *futex, &timeout, 0), EINTR);
+	exit(0);
+}
+
+static void run(void)
+{
+	pid_t child;
+
+	child = SAFE_FORK();
+
+	if (child == 0)
+		do_child();
+
+	TST_PROCESS_STATE_WAIT(child, 'S', 0);
+	SAFE_KILL(child, SIGUSR1);
+}
+
+static void setup(void)
+{
+	struct futex_test_variants *tv = &variants[tst_variant];
+
+	tst_res(TINFO, "Testing variant: %s", tv->desc);
+	futex_supported_by_kernel(tv->fntype);
+
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
