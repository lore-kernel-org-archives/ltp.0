Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 70FFFC433F5
	for <ltp@archiver.kernel.org>; Wed,  9 Feb 2022 09:18:22 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 61ADB3C9B5B
	for <ltp@archiver.kernel.org>; Wed,  9 Feb 2022 10:18:20 +0100 (CET)
Received: from in-7.smtp.seeweb.it (in-7.smtp.seeweb.it
 [IPv6:2001:4b78:1:20::7])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 2708E3C6912
 for <ltp@lists.linux.it>; Wed,  9 Feb 2022 10:18:01 +0100 (CET)
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.220.28])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-7.smtp.seeweb.it (Postfix) with ESMTPS id 1987C200C6E
 for <ltp@lists.linux.it>; Wed,  9 Feb 2022 10:17:59 +0100 (CET)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
 (No client certificate requested)
 by smtp-out1.suse.de (Postfix) with ESMTPS id 603F32111A;
 Wed,  9 Feb 2022 09:17:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
 t=1644398279; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=/5Ly7+0TxJYC0MF+VNujMj1A1e48CUVioV3aZ39G6kk=;
 b=WTNUehy+FFqUyvQ0qX9zv1ySBxYf/ji3gsNdHkZdDKFJn5GgB5v4bHLVLbwVNmXzjcymCj
 zdLoB95/FMEomWPqJxEdQgOyzOViLSparJpuZuo6827Losmb5cPx3njbbIXhCdf9VjyP/M
 R1gMLjTfT+FpPAA7X9sqGUFQ28K0hX0=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_ed25519; t=1644398279;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=/5Ly7+0TxJYC0MF+VNujMj1A1e48CUVioV3aZ39G6kk=;
 b=0lC5jBtFT6UvtRILlVQxSiPjzkCbBu0l/Qk9Zav6Ytu1olEyw0NBZg34PER+dZVkSLYpNT
 AEXOWHtT5GMofADg==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
 (No client certificate requested)
 by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 379E013D1E;
 Wed,  9 Feb 2022 09:17:59 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
 by imap2.suse-dmz.suse.de with ESMTPSA id +Ke4C8eGA2J+PQAAMHmgww
 (envelope-from <andrea.cervesato@suse.de>); Wed, 09 Feb 2022 09:17:59 +0000
From: Andrea Cervesato <andrea.cervesato@suse.de>
To: ltp@lists.linux.it
Date: Wed,  9 Feb 2022 10:17:56 +0100
Message-Id: <20220209091756.17245-2-andrea.cervesato@suse.de>
X-Mailer: git-send-email 2.35.1
In-Reply-To: <20220209091756.17245-1-andrea.cervesato@suse.de>
References: <20220209091756.17245-1-andrea.cervesato@suse.de>
MIME-Version: 1.0
X-Virus-Scanned: clamav-milter 0.102.4 at in-7.smtp.seeweb.it
X-Virus-Status: Clean
Subject: [LTP] [PATCH v5 3/3] Add futex_waitv testing suite
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
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: ltp-bounces+ltp=archiver.kernel.org@lists.linux.it
Sender: "ltp" <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>

Signed-off-by: Andrea Cervesato <andrea.cervesato@suse.de>
---
In v5 there's a better approch to futex_waitv testing.
futex_variant() has been kept as function and added FUTEX_VARIANTS for counting
the test variants.

 testcases/kernel/syscalls/futex/.gitignore    |   3 +
 testcases/kernel/syscalls/futex/Makefile      |  14 ++-
 testcases/kernel/syscalls/futex/futex2test.h  |  30 +++++
 testcases/kernel/syscalls/futex/futex_utils.h |  38 +++---
 .../kernel/syscalls/futex/futex_waitv01.c     | 119 ++++++++++++++++++
 .../kernel/syscalls/futex/futex_waitv02.c     | 106 ++++++++++++++++
 .../kernel/syscalls/futex/futex_waitv03.c     | 119 ++++++++++++++++++
 testcases/kernel/syscalls/futex/futextest.h   |  47 +------
 8 files changed, 415 insertions(+), 61 deletions(-)
 create mode 100644 testcases/kernel/syscalls/futex/futex2test.h
 create mode 100644 testcases/kernel/syscalls/futex/futex_waitv01.c
 create mode 100644 testcases/kernel/syscalls/futex/futex_waitv02.c
 create mode 100644 testcases/kernel/syscalls/futex/futex_waitv03.c

diff --git a/testcases/kernel/syscalls/futex/.gitignore b/testcases/kernel/syscalls/futex/.gitignore
index 54cd02b02..9d08ba7d3 100644
--- a/testcases/kernel/syscalls/futex/.gitignore
+++ b/testcases/kernel/syscalls/futex/.gitignore
@@ -10,3 +10,6 @@
 /futex_wake02
 /futex_wake03
 /futex_wake04
+/futex_waitv01
+/futex_waitv02
+/futex_waitv03
diff --git a/testcases/kernel/syscalls/futex/Makefile b/testcases/kernel/syscalls/futex/Makefile
index 5713c615d..7228496bc 100644
--- a/testcases/kernel/syscalls/futex/Makefile
+++ b/testcases/kernel/syscalls/futex/Makefile
@@ -3,8 +3,18 @@
 
 top_srcdir		?= ../../../..
 
-futex_cmp_requeue01 futex_cmp_requeue02 futex_wait02 futex_wake03 futex_wait05 futex_wait_bitset01: LDLIBS += -lrt
-futex_wait03 futex_wake02 futex_wake04: CFLAGS += -pthread
+futex_cmp_requeue01: LDLIBS+=-lrt
+futex_cmp_requeue02: LDLIBS+=-lrt
+futex_wait02: LDLIBS+=-lrt
+futex_wake03: LDLIBS+=-lrt
+futex_wait05: LDLIBS+=-lrt
+futex_wait_bitset01: LDLIBS+=-lrt
+
+futex_wait03: CFLAGS+=-pthread
+futex_wake02: CFLAGS+=-pthread
+futex_wake04: CFLAGS+=-pthread
+futex_waitv02: CFLAGS+=-pthread
+futex_waitv03: CFLAGS+=-pthread
 
 include $(top_srcdir)/include/mk/testcases.mk
 include $(top_srcdir)/include/mk/generic_leaf_target.mk
diff --git a/testcases/kernel/syscalls/futex/futex2test.h b/testcases/kernel/syscalls/futex/futex2test.h
new file mode 100644
index 000000000..ce97f47c1
--- /dev/null
+++ b/testcases/kernel/syscalls/futex/futex2test.h
@@ -0,0 +1,30 @@
+/* SPDX-License-Identifier: GPL-2.0-or-later */
+/*
+ * Futex2 library addons for futex tests
+ *
+ * Copyright 2021 Collabora Ltd.
+ * Copyright (C) 2021 SUSE LLC Andrea Cervesato <andrea.cervesato@suse.com>
+ */
+
+#ifndef FUTEX2TEST_H
+#define FUTEX2TEST_H
+
+#include <stdint.h>
+#include "lapi/syscalls.h"
+#include "futextest.h"
+
+/**
+ * futex_waitv - Wait at multiple futexes, wake on any
+ * @waiters:    Array of waiters
+ * @nr_waiters: Length of waiters array
+ * @flags: Operation flags
+ * @timo:  Optional timeout for operation
+ */
+static inline int futex_waitv(volatile struct futex_waitv *waiters,
+			      unsigned long nr_waiters, unsigned long flags,
+			      struct timespec *timo, clockid_t clockid)
+{
+	return tst_syscall(__NR_futex_waitv, waiters, nr_waiters, flags, timo, clockid);
+}
+
+#endif /* _FUTEX2TEST_H */
diff --git a/testcases/kernel/syscalls/futex/futex_utils.h b/testcases/kernel/syscalls/futex/futex_utils.h
index 156895efb..7ce13e627 100644
--- a/testcases/kernel/syscalls/futex/futex_utils.h
+++ b/testcases/kernel/syscalls/futex/futex_utils.h
@@ -1,20 +1,7 @@
+// SPDX-License-Identifier: GPL-2.0-or-later
 /*
  * Copyright (C) 2015 Cyril Hrubis <chrubis@suse.cz>
- *
- * Licensed under the GNU GPLv2 or later.
- * This program is free software;  you can redistribute it and/or modify
- * it under the terms of the GNU General Public License as published by
- * the Free Software Foundation; either version 2 of the License, or
- * (at your option) any later version.
- *
- * This program is distributed in the hope that it will be useful,
- * but WITHOUT ANY WARRANTY;  without even the implied warranty of
- * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See
- * the GNU General Public License for more details.
- *
- * You should have received a copy of the GNU General Public License
- * along with this program;  if not, write to the Free Software Foundation,
- * Inc., 51 Franklin Street, Fifth Floor, Boston, MA 02110-1301 USA
+ * Copyright (C) 2021 SUSE LLC Andrea Cervesato <andrea.cervesato@suse.com>
  */
 
 #ifndef FUTEX_UTILS_H__
@@ -23,6 +10,27 @@
 #include <stdio.h>
 #include <stdlib.h>
 
+#if __NR_futex != __LTP__NR_INVALID_SYSCALL && __NR_futex_time64 != __LTP__NR_INVALID_SYSCALL
+# define FUTEX_VARIANTS 2
+#else
+# define FUTEX_VARIANTS 1
+#endif
+
+static inline struct futex_test_variants futex_variant(void)
+{
+	struct futex_test_variants variants[] = {
+	#if (__NR_futex != __LTP__NR_INVALID_SYSCALL)
+		{ .fntype = FUTEX_FN_FUTEX, .desc = "syscall with old kernel spec" },
+	#endif
+
+	#if (__NR_futex_time64 != __LTP__NR_INVALID_SYSCALL)
+		{ .fntype = FUTEX_FN_FUTEX64, .desc = "syscall time64 with kernel spec" },
+	#endif
+	};
+
+	return variants[tst_variant];
+}
+
 /*
  * Wait for nr_threads to be sleeping
  */
diff --git a/testcases/kernel/syscalls/futex/futex_waitv01.c b/testcases/kernel/syscalls/futex/futex_waitv01.c
new file mode 100644
index 000000000..601fee8df
--- /dev/null
+++ b/testcases/kernel/syscalls/futex/futex_waitv01.c
@@ -0,0 +1,119 @@
+// SPDX-License-Identifier: GPL-2.0-or-later
+/*
+ * Copyright (C) 2021 SUSE LLC Andrea Cervesato <andrea.cervesato@suse.com>
+ */
+
+/*\
+ * [Description]
+ *
+ * This test verifies EINVAL for futex_waitv syscall.
+ */
+
+#include <time.h>
+#include "tst_test.h"
+#include "lapi/futex.h"
+#include "futex2test.h"
+#include "tst_safe_clocks.h"
+
+static uint32_t *futex;
+static struct futex_waitv *waitv;
+
+static void setup(void)
+{
+	futex = SAFE_MALLOC(sizeof(uint32_t));
+	*futex = FUTEX_INITIALIZER;
+}
+
+static void init_timeout(struct timespec *to)
+{
+	SAFE_CLOCK_GETTIME(CLOCK_MONOTONIC, to);
+	to->tv_sec++;
+}
+
+static void init_waitv(void)
+{
+	waitv->uaddr = (uintptr_t)&futex;
+	waitv->flags = FUTEX_32 | FUTEX_PRIVATE_FLAG;
+	waitv->val = 0;
+}
+
+static void test_invalid_flags(void)
+{
+	struct timespec to;
+
+	init_waitv();
+	init_timeout(&to);
+
+	/* Testing a waiter without FUTEX_32 flag */
+	waitv->flags = FUTEX_PRIVATE_FLAG;
+
+	TST_EXP_FAIL(futex_waitv(waitv, 1, 0, &to, CLOCK_MONOTONIC), EINVAL,
+		     "futex_waitv with invalid flags");
+}
+
+static void test_unaligned_address(void)
+{
+	struct timespec to;
+
+	init_waitv();
+	init_timeout(&to);
+
+	waitv->uaddr = 1;
+
+	TST_EXP_FAIL(futex_waitv(waitv, 1, 0, &to, CLOCK_MONOTONIC), EINVAL,
+		     "futex_waitv with unligned address");
+}
+
+static void test_null_address(void)
+{
+	struct timespec to;
+
+	init_waitv();
+	init_timeout(&to);
+
+	waitv->uaddr = 0x00000000;
+
+	TST_EXP_FAIL(futex_waitv(waitv, 1, 0, &to, CLOCK_MONOTONIC), EFAULT,
+		     "futex_waitv address is NULL");
+}
+
+static void test_null_waiters(void)
+{
+	struct timespec to;
+
+	init_timeout(&to);
+
+	TST_EXP_FAIL(futex_waitv(NULL, 1, 0, &to, CLOCK_MONOTONIC), EINVAL,
+		     "futex_waitv waiters are NULL");
+}
+
+static void test_invalid_clockid(void)
+{
+	struct timespec to;
+
+	init_waitv();
+	init_timeout(&to);
+
+	TST_EXP_FAIL(futex_waitv(waitv, 1, 0, &to, CLOCK_TAI), EINVAL,
+		     "futex_waitv invalid clockid");
+}
+
+static void run(void)
+{
+	test_invalid_flags();
+	test_unaligned_address();
+	test_null_address();
+	test_null_waiters();
+	test_invalid_clockid();
+}
+
+static struct tst_test test = {
+	.test_all = run,
+	.setup = setup,
+	.min_kver = "5.16",
+	.bufs =
+		(struct tst_buffers[]){
+			{ &waitv, .size = sizeof(struct futex_waitv) },
+			{},
+		},
+};
diff --git a/testcases/kernel/syscalls/futex/futex_waitv02.c b/testcases/kernel/syscalls/futex/futex_waitv02.c
new file mode 100644
index 000000000..2897f6c78
--- /dev/null
+++ b/testcases/kernel/syscalls/futex/futex_waitv02.c
@@ -0,0 +1,106 @@
+// SPDX-License-Identifier: GPL-2.0-or-later
+/*
+ * Copyright (C) 2021 SUSE LLC Andrea Cervesato <andrea.cervesato@suse.com>
+ */
+
+/*\
+ * [Description]
+ *
+ * This test verifies futex_waitv syscall using private data.
+ */
+
+#define _GNU_SOURCE
+#include <unistd.h>
+#include <time.h>
+#include "tst_test.h"
+#include "lapi/futex.h"
+#include "lapi/syscalls.h"
+#include "futex2test.h"
+#include "futex_utils.h"
+#include "tst_safe_pthread.h"
+#include "tst_safe_clocks.h"
+
+static char *str_numfutex;
+static int numfutex = 30;
+
+static uint32_t *futexes;
+static struct futex_waitv *waitv;
+
+static void setup(void)
+{
+	struct futex_test_variants tv = futex_variant();
+	int i;
+
+	tst_res(TINFO, "Testing variant: %s", tv.desc);
+	futex_supported_by_kernel(tv.fntype);
+
+	if (tst_parse_int(str_numfutex, &numfutex, 1, FUTEX_WAITV_MAX))
+		tst_brk(TBROK, "Invalid number of futexes '%s'", str_numfutex);
+
+	futexes = SAFE_MALLOC(sizeof(uint32_t) * numfutex);
+	memset(futexes, FUTEX_INITIALIZER, sizeof(uint32_t) * numfutex);
+
+	waitv = SAFE_MALLOC(sizeof(struct futex_waitv) * numfutex);
+	memset(waitv, 0, sizeof(struct futex_waitv) * numfutex);
+
+	for (i = 0; i < numfutex; i++) {
+		waitv[i].uaddr = (uintptr_t)&futexes[i];
+		waitv[i].flags = FUTEX_32 | FUTEX_PRIVATE_FLAG;
+		waitv[i].val = 0;
+	}
+}
+
+static void *threaded(void *arg)
+{
+	struct futex_test_variants tv = futex_variant();
+	int tid = *(int *)arg;
+
+	TST_THREAD_STATE_WAIT(tid, 'S', 0);
+
+	TEST(futex_wake(tv.fntype, (void *)(uintptr_t)waitv[numfutex - 1].uaddr,
+			1, FUTEX_PRIVATE_FLAG));
+	if (TST_RET < 0) {
+		tst_brk(TBROK, "futex_wake private returned: %ld %s", TST_RET,
+			tst_strerrno(TST_ERR));
+	}
+
+	return NULL;
+}
+
+static void run(void)
+{
+	struct timespec to;
+	int ret, tid;
+	pthread_t t;
+
+	tid = tst_syscall(__NR_gettid);
+
+	SAFE_PTHREAD_CREATE(&t, NULL, threaded, (void *)&tid);
+
+	/* setting absolute timeout for futex2 */
+	SAFE_CLOCK_GETTIME(CLOCK_MONOTONIC, &to);
+	to.tv_sec++;
+
+	ret = futex_waitv(waitv, numfutex, 0, &to, CLOCK_MONOTONIC);
+	if (ret < 0)
+		tst_brk(TBROK, "futex_waitv returned: %d %s", ret,
+			tst_strerrno(-ret));
+	else if (ret != numfutex - 1)
+		tst_res(TFAIL, "futex_waitv returned: %d, expecting %d", ret,
+			numfutex - 1);
+
+	SAFE_PTHREAD_JOIN(t, NULL);
+	tst_res(TPASS, "futex_waitv returned correctly");
+}
+
+static struct tst_test test = {
+	.test_all = run,
+	.setup = setup,
+	.min_kver = "5.16",
+	.test_variants = FUTEX_VARIANTS,
+	.options =
+		(struct tst_option[]){
+			{ "n:", &str_numfutex, "Number of futex (default 30)" },
+			{},
+		},
+};
diff --git a/testcases/kernel/syscalls/futex/futex_waitv03.c b/testcases/kernel/syscalls/futex/futex_waitv03.c
new file mode 100644
index 000000000..773cc5af3
--- /dev/null
+++ b/testcases/kernel/syscalls/futex/futex_waitv03.c
@@ -0,0 +1,119 @@
+// SPDX-License-Identifier: GPL-2.0-or-later
+/*
+ * Copyright (C) 2021 SUSE LLC Andrea Cervesato <andrea.cervesato@suse.com>
+ */
+
+/*\
+ * [Description]
+ *
+ * This test verifies futex_waitv syscall using shared data.
+ */
+
+#define _GNU_SOURCE
+#include <unistd.h>
+#include <time.h>
+#include <sys/shm.h>
+#include "tst_test.h"
+#include "lapi/futex.h"
+#include "lapi/syscalls.h"
+#include "futex2test.h"
+#include "futex_utils.h"
+#include "tst_safe_pthread.h"
+#include "tst_safe_clocks.h"
+#include "tst_safe_sysv_ipc.h"
+
+static char *str_numfutex;
+static int numfutex = 30;
+
+static struct futex_waitv *waitv;
+
+static void setup(void)
+{
+	struct futex_test_variants tv = futex_variant();
+	int shm_id;
+	int i;
+
+	tst_res(TINFO, "Testing variant: %s", tv.desc);
+	futex_supported_by_kernel(tv.fntype);
+
+	if (tst_parse_int(str_numfutex, &numfutex, 1, FUTEX_WAITV_MAX))
+		tst_brk(TBROK, "Invalid number of futexes '%s'", str_numfutex);
+
+	waitv = SAFE_MALLOC(sizeof(struct futex_waitv) * numfutex);
+	memset(waitv, 0, sizeof(struct futex_waitv) * numfutex);
+
+	for (i = 0; i < numfutex; i++) {
+		shm_id = SAFE_SHMGET(IPC_PRIVATE, 4096, IPC_CREAT | 0666);
+		waitv[i].uaddr = (uintptr_t)SAFE_SHMAT(shm_id, NULL, 0);
+		waitv[i].flags = FUTEX_32;
+		waitv[i].val = 0;
+	}
+}
+
+static void cleanup(void)
+{
+	int i;
+
+	for (i = 0; i < numfutex; i++) {
+		if (!waitv[i].uaddr)
+			continue;
+
+		SAFE_SHMDT((void *)(uintptr_t)waitv[i].uaddr);
+	}
+}
+
+static void *threaded(void *arg)
+{
+	struct futex_test_variants tv = futex_variant();
+	int tid = *(int *)arg;
+
+	TST_THREAD_STATE_WAIT(tid, 'S', 0);
+
+	TEST(futex_wake(tv.fntype, (void *)(uintptr_t)waitv[numfutex - 1].uaddr,
+			1, 0));
+	if (TST_RET < 0) {
+		tst_brk(TBROK, "futex_wake private returned: %ld %s", TST_RET,
+			tst_strerrno(TST_ERR));
+	}
+
+	return NULL;
+}
+
+static void run(void)
+{
+	struct timespec to;
+	int tid;
+	pthread_t t;
+
+	tid = tst_syscall(__NR_gettid);
+
+	SAFE_PTHREAD_CREATE(&t, NULL, threaded, (void *)&tid);
+
+	/* setting absolute timeout for futex2 */
+	SAFE_CLOCK_GETTIME(CLOCK_MONOTONIC, &to);
+	to.tv_sec++;
+
+	TEST(futex_waitv(waitv, numfutex, 0, &to, CLOCK_MONOTONIC));
+	if (TST_RET < 0)
+		tst_brk(TBROK, "futex_waitv returned: %ld %s", TST_RET,
+			tst_strerrno(TST_ERR));
+	else if (TST_RET != numfutex - 1)
+		tst_res(TFAIL, "futex_waitv returned: %ld, expecting %d",
+			TST_RET, numfutex - 1);
+
+	SAFE_PTHREAD_JOIN(t, NULL);
+	tst_res(TPASS, "futex_waitv returned correctly");
+}
+
+static struct tst_test test = {
+	.test_all = run,
+	.setup = setup,
+	.cleanup = cleanup,
+	.min_kver = "5.16",
+	.test_variants = FUTEX_VARIANTS,
+	.options =
+		(struct tst_option[]){
+			{ "n:", &str_numfutex, "Number of futex (default 30)" },
+			{},
+		},
+};
diff --git a/testcases/kernel/syscalls/futex/futextest.h b/testcases/kernel/syscalls/futex/futextest.h
index 3f2f36fef..fd10885f3 100644
--- a/testcases/kernel/syscalls/futex/futextest.h
+++ b/testcases/kernel/syscalls/futex/futextest.h
@@ -10,58 +10,17 @@
  *      Darren Hart <dvhltc@us.ibm.com>
  */
 
-#ifndef _FUTEXTEST_H
-#define _FUTEXTEST_H
+#ifndef FUTEXTEST_H
+#define FUTEXTEST_H
 
 #include <unistd.h>
 #include <sys/syscall.h>
 #include <sys/types.h>
-#include <linux/futex.h>
 #include "lapi/futex.h"
 #include "tst_timer.h"
 
 #define FUTEX_INITIALIZER 0
 
-#ifndef FUTEX_CMP_REQUEUE
-# define FUTEX_CMP_REQUEUE	4
-#endif
-#ifndef FUTEX_WAKE_OP
-# define FUTEX_WAKE_OP		5
-#endif
-#ifndef FUTEX_LOCK_PI
-# define FUTEX_LOCK_PI		6
-#endif
-#ifndef FUTEX_UNLOCK_PI
-# define FUTEX_UNLOCK_PI	7
-#endif
-#ifndef FUTEX_WAIT_BITSET
-# define FUTEX_WAIT_BITSET	9
-#endif
-#ifndef FUTEX_WAKE_BITSET
-# define FUTEX_WAKE_BITSET	10
-#endif
-#ifndef FUTEX_WAIT_REQUEUE_PI
-# define FUTEX_WAIT_REQUEUE_PI	11
-#endif
-#ifndef FUTEX_CMP_REQUEUE_PI
-# define FUTEX_CMP_REQUEUE_PI	12
-#endif
-#ifndef FUTEX_PRIVATE_FLAG
-# define FUTEX_PRIVATE_FLAG	128
-#endif
-#ifndef FUTEX_WAIT_REQUEUE_PI_PRIVATE
-# define FUTEX_WAIT_REQUEUE_PI_PRIVATE	(FUTEX_WAIT_REQUEUE_PI | \
-					 FUTEX_PRIVATE_FLAG)
-#endif
-#ifndef FUTEX_REQUEUE_PI_PRIVATE
-# define FUTEX_CMP_REQUEUE_PI_PRIVATE	(FUTEX_CMP_REQUEUE_PI | \
-					 FUTEX_PRIVATE_FLAG)
-#endif
-
-#ifndef FUTEX_CLOCK_REALTIME
-# define FUTEX_CLOCK_REALTIME 256
-#endif
-
 enum futex_fn_type {
 	FUTEX_FN_FUTEX,
 	FUTEX_FN_FUTEX64,
@@ -318,4 +277,4 @@ futex_set(futex_t *uaddr, u_int32_t newval)
 	return newval;
 }
 
-#endif
+#endif /* _FUTEXTEST_H */
-- 
2.35.1


-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
