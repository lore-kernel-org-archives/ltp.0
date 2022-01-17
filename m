Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D0525C433F5
	for <ltp@archiver.kernel.org>; Mon, 17 Jan 2022 20:24:11 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id F3AFB3C9658
	for <ltp@archiver.kernel.org>; Mon, 17 Jan 2022 21:24:08 +0100 (CET)
Received: from in-2.smtp.seeweb.it (in-2.smtp.seeweb.it [217.194.8.2])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id E905E3C3344
 for <ltp@lists.linux.it>; Mon, 17 Jan 2022 21:23:57 +0100 (CET)
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.220.29])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-2.smtp.seeweb.it (Postfix) with ESMTPS id 40A9D653A6B
 for <ltp@lists.linux.it>; Mon, 17 Jan 2022 21:23:57 +0100 (CET)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
 (No client certificate requested)
 by smtp-out2.suse.de (Postfix) with ESMTPS id CF97F1F3C0;
 Mon, 17 Jan 2022 20:23:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
 t=1642451036; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=UiaqTrOBzgnmNtRWJH/Cxi0pUSB9+D56h/T/IAZJMec=;
 b=LGkkhJYjzGGfKI1b6FORzKhwH4hUs6kQKzJJd1RWMAsM6t6g3rUQXbmpQtY3ybr/YCSNP5
 tfzUHXVyvwZP+tQ2Fw/kGYi/MDe9MZhKatT1n5GnZyOJRfxADBsDwrGwZkJLU0RGLKCGZ+
 TcjnN9g9hpJOKxkkEgmeE3aXZ4dyKu0=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_ed25519; t=1642451036;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=UiaqTrOBzgnmNtRWJH/Cxi0pUSB9+D56h/T/IAZJMec=;
 b=cWOghjlHs2ZlSUY4vSMvVxeg5X5XSEhVJwwNS8fyHysEz57//0ztiAeiUu8n/91fmAl0d4
 6hhqZFs/cmP/BNDg==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
 (No client certificate requested)
 by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 9CEC413E9C;
 Mon, 17 Jan 2022 20:23:56 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
 by imap2.suse-dmz.suse.de with ESMTPSA id GGN/I1zQ5WHSUAAAMHmgww
 (envelope-from <andrea.cervesato@suse.de>); Mon, 17 Jan 2022 20:23:56 +0000
From: Andrea Cervesato <andrea.cervesato@suse.de>
To: ltp@lists.linux.it
Date: Mon, 17 Jan 2022 21:23:54 +0100
Message-Id: <20220117202354.20785-3-andrea.cervesato@suse.de>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20220117202354.20785-1-andrea.cervesato@suse.de>
References: <20220117202354.20785-1-andrea.cervesato@suse.de>
MIME-Version: 1.0
X-Virus-Scanned: clamav-milter 0.102.4 at in-2.smtp.seeweb.it
X-Virus-Status: Clean
Subject: [LTP] [PATCH v1 2/2] Add futex_waitv tests suite
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
 testcases/kernel/syscalls/futex/.gitignore    |   3 +
 testcases/kernel/syscalls/futex/futex2test.h  |  23 ++++
 .../kernel/syscalls/futex/futex_waitv01.c     | 129 ++++++++++++++++++
 .../kernel/syscalls/futex/futex_waitv02.c     | 103 ++++++++++++++
 .../kernel/syscalls/futex/futex_waitv03.c     | 111 +++++++++++++++
 5 files changed, 369 insertions(+)
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
diff --git a/testcases/kernel/syscalls/futex/futex2test.h b/testcases/kernel/syscalls/futex/futex2test.h
new file mode 100644
index 000000000..634efae3b
--- /dev/null
+++ b/testcases/kernel/syscalls/futex/futex2test.h
@@ -0,0 +1,23 @@
+/* SPDX-License-Identifier: GPL-2.0-or-later */
+/*
+ * Futex2 library addons for futex tests
+ *
+ * Copyright 2021 Collabora Ltd.
+ * Copyright (C) 2021 SUSE LLC Andrea Cervesato <andrea.cervesato@suse.com>
+ */
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
+static inline int futex_waitv(volatile struct futex_waitv *waiters, unsigned long nr_waiters,
+			      unsigned long flags, struct timespec *timo, clockid_t clockid)
+{
+	return tst_syscall(__NR_futex_waitv, waiters, nr_waiters, flags, timo, clockid);
+}
diff --git a/testcases/kernel/syscalls/futex/futex_waitv01.c b/testcases/kernel/syscalls/futex/futex_waitv01.c
new file mode 100644
index 000000000..807aaaa27
--- /dev/null
+++ b/testcases/kernel/syscalls/futex/futex_waitv01.c
@@ -0,0 +1,129 @@
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
+#include <stdlib.h>
+#include <time.h>
+#include <lapi/futex.h>
+#include "futex2test.h"
+#include "tst_test.h"
+
+static char *str_numfutex;
+static int numfutex = 30;
+
+static uint32_t *futexes;
+static struct futex_waitv *waitv;
+
+static void setup(void)
+{
+	struct futex_test_variants tv;
+	int i;
+
+	tv = futex_variants();
+
+	tst_res(TINFO, "Testing variant: %s", tv.desc);
+	futex_supported_by_kernel(tv.fntype);
+
+	if (tst_parse_int(str_numfutex, &numfutex, 1, FUTEX_WAITV_MAX))
+		tst_brk(TBROK, "Invalid number of futexes '%s'", str_numfutex);
+
+	futexes = SAFE_MALLOC(sizeof(uint32_t) * numfutex);
+	memset(futexes, 0, numfutex);
+
+	waitv = SAFE_MALLOC(sizeof(struct futex_waitv) * numfutex);
+	for (i = 0; i < numfutex; i++) {
+		waitv[i].uaddr = (uintptr_t)&futexes[i];
+		waitv[i].flags = FUTEX_32 | FUTEX_PRIVATE_FLAG;
+		waitv[i].val = 0;
+	}
+}
+
+static void cleanup(void)
+{
+	free(futexes);
+	free(waitv);
+}
+
+static void init_timeout(struct timespec *to)
+{
+	if (clock_gettime(CLOCK_MONOTONIC, to))
+		tst_brk(TBROK, "gettime64 failed");
+
+	to->tv_sec++;
+}
+
+static void run(void)
+{
+	struct timespec to;
+	int res;
+
+	/* Testing a waiter without FUTEX_32 flag */
+	waitv[0].flags = FUTEX_PRIVATE_FLAG;
+
+	init_timeout(&to);
+
+	res = futex_waitv(waitv, numfutex, 0, &to, CLOCK_MONOTONIC);
+	if (res == EINVAL)
+		tst_res(TFAIL, "futex_waitv private returned: %d %s", res, tst_strerrno(res));
+	else
+		tst_res(TPASS, "futex_waitv without FUTEX_32");
+
+	/* Testing a waiter with an unaligned address */
+	waitv[0].flags = FUTEX_PRIVATE_FLAG | FUTEX_32;
+	waitv[0].uaddr = 1;
+
+	init_timeout(&to);
+
+	res = futex_waitv(waitv, numfutex, 0, &to, CLOCK_MONOTONIC);
+	if (res == EINVAL)
+		tst_res(TFAIL, "futex_waitv private returned: %d %s", res, tst_strerrno(res));
+	else
+		tst_res(TPASS, "futex_waitv with an unaligned address");
+
+	/* Testing a NULL address for waiters.uaddr */
+	waitv[0].uaddr = 0x00000000;
+
+	init_timeout(&to);
+
+	res = futex_waitv(waitv, numfutex, 0, &to, CLOCK_MONOTONIC);
+	if (res == EINVAL)
+		tst_res(TFAIL, "futex_waitv private returned: %d %s", res, tst_strerrno(res));
+	else
+		tst_res(TPASS, "futex_waitv NULL address in waitv.uaddr");
+
+	/* Testing a NULL address for *waiters */
+	init_timeout(&to);
+
+	res = futex_waitv(NULL, numfutex, 0, &to, CLOCK_MONOTONIC);
+	if (res == EINVAL)
+		tst_res(TFAIL, "futex_waitv private returned: %d %s", res, tst_strerrno(res));
+	else
+		tst_res(TPASS, "futex_waitv NULL address in *waiters");
+
+	/* Testing an invalid clockid */
+	init_timeout(&to);
+
+	res = futex_waitv(NULL, numfutex, 0, &to, CLOCK_TAI);
+	if (res == EINVAL)
+		tst_res(TFAIL, "futex_waitv private returned: %d %s", res, tst_strerrno(res));
+	else
+		tst_res(TPASS, "futex_waitv invalid clockid");
+}
+
+static struct tst_test test = {
+	.test_all = run,
+	.setup = setup,
+	.cleanup = cleanup,
+	.min_kver = "5.16",
+	.options = (struct tst_option[]){
+		{"n:", &str_numfutex, "Number of futex (default 30)"},
+		{},
+	},
+};
diff --git a/testcases/kernel/syscalls/futex/futex_waitv02.c b/testcases/kernel/syscalls/futex/futex_waitv02.c
new file mode 100644
index 000000000..9868ddd4e
--- /dev/null
+++ b/testcases/kernel/syscalls/futex/futex_waitv02.c
@@ -0,0 +1,103 @@
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
+#include <stdlib.h>
+#include <time.h>
+#include <lapi/futex.h>
+#include "futex2test.h"
+#include "tst_test.h"
+#include "tst_safe_pthread.h"
+
+static char *str_numfutex;
+static int numfutex = 30;
+
+static uint32_t *futexes;
+static struct futex_waitv *waitv;
+
+static void setup(void)
+{
+	struct futex_test_variants tv;
+	int i;
+
+	tv = futex_variants();
+
+	tst_res(TINFO, "Testing variant: %s", tv.desc);
+	futex_supported_by_kernel(tv.fntype);
+
+	if (tst_parse_int(str_numfutex, &numfutex, 1, FUTEX_WAITV_MAX))
+		tst_brk(TBROK, "Invalid number of futexes '%s'", str_numfutex);
+
+	futexes = SAFE_MALLOC(sizeof(uint32_t) * numfutex);
+	memset(futexes, 0, numfutex);
+
+	waitv = SAFE_MALLOC(sizeof(struct futex_waitv) * numfutex);
+	for (i = 0; i < numfutex; i++) {
+		waitv[i].uaddr = (uintptr_t)&futexes[i];
+		waitv[i].flags = FUTEX_32 | FUTEX_PRIVATE_FLAG;
+		waitv[i].val = 0;
+	}
+}
+
+static void cleanup(void)
+{
+	free(futexes);
+	free(waitv);
+}
+
+static void *threaded(void *arg)
+{
+	struct futex_test_variants tv;
+	int ret, pid = *(int *)arg;
+
+	tv = futex_variants();
+	TST_PROCESS_STATE_WAIT(pid, 'S', 0);
+
+	ret = futex_wake(tv.fntype, (void *)(uintptr_t)waitv[numfutex - 1].uaddr, 1, FUTEX_PRIVATE_FLAG);
+	if (ret < 0)
+		tst_brk(TBROK, "futex_wake private returned: %d %s", ret, tst_strerrno(-ret));
+
+	return NULL;
+}
+
+static void run(void)
+{
+	struct timespec to;
+	int ret, pid = getpid();
+	pthread_t t;
+
+	SAFE_PTHREAD_CREATE(&t, NULL, threaded, (void *)&pid);
+
+	/* setting absolute timeout for futex2 */
+	if (clock_gettime(CLOCK_MONOTONIC, &to))
+		tst_brk(TBROK, "gettime64 failed");
+
+	to.tv_sec++;
+
+	ret = futex_waitv(waitv, numfutex, 0, &to, CLOCK_MONOTONIC);
+	if (ret < 0)
+		tst_brk(TBROK, "futex_waitv returned: %d %s", ret, tst_strerrno(-ret));
+	else if (ret != numfutex - 1)
+		tst_res(TFAIL, "futex_waitv returned: %d, expecting %d", ret, numfutex - 1);
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
+	.options = (struct tst_option[]){
+		{"n:", &str_numfutex, "Number of futex (default 30)"},
+		{},
+	},
+};
diff --git a/testcases/kernel/syscalls/futex/futex_waitv03.c b/testcases/kernel/syscalls/futex/futex_waitv03.c
new file mode 100644
index 000000000..bc0b4c192
--- /dev/null
+++ b/testcases/kernel/syscalls/futex/futex_waitv03.c
@@ -0,0 +1,111 @@
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
+#include <stdlib.h>
+#include <time.h>
+#include <lapi/futex.h>
+#include <sys/shm.h>
+#include "futex2test.h"
+#include "tst_test.h"
+#include "tst_safe_pthread.h"
+
+static char *str_numfutex;
+static int numfutex = 30;
+
+static struct futex_waitv *waitv;
+
+static void setup(void)
+{
+	struct futex_test_variants tv;
+	int shm_id;
+	int i;
+
+	tv = futex_variants();
+
+	tst_res(TINFO, "Testing variant: %s", tv.desc);
+	futex_supported_by_kernel(tv.fntype);
+
+	if (tst_parse_int(str_numfutex, &numfutex, 1, FUTEX_WAITV_MAX))
+		tst_brk(TBROK, "Invalid number of futexes '%s'", str_numfutex);
+
+	waitv = SAFE_MALLOC(sizeof(struct futex_waitv) * numfutex);
+	for (i = 0; i < numfutex; i++) {
+		shm_id = shmget(IPC_PRIVATE, 4096, IPC_CREAT | 0666);
+		if (shm_id < 0)
+			tst_brk(TBROK, "shmget");
+
+		unsigned int *shared_data = shmat(shm_id, NULL, 0);
+
+		waitv[i].uaddr = (uintptr_t)shared_data;
+		waitv[i].flags = FUTEX_32;
+		waitv[i].val = 0;
+	}
+}
+
+static void cleanup(void)
+{
+	int i;
+
+	for (i = 0; i < numfutex; i++)
+		shmdt((void *)(uintptr_t)waitv[i].uaddr);
+
+	free(waitv);
+}
+
+static void *threaded(void *arg)
+{
+	struct futex_test_variants tv;
+	int ret, pid = *(int *)arg;
+
+	tv = futex_variants();
+	TST_PROCESS_STATE_WAIT(pid, 'S', 0);
+
+	ret = futex_wake(tv.fntype, (void *)(uintptr_t)waitv[numfutex - 1].uaddr, 1, 0);
+	if (ret < 0)
+		tst_brk(TBROK, "futex_wake private returned: %d %s", ret, tst_strerrno(-ret));
+
+	return NULL;
+}
+
+static void run(void)
+{
+	struct timespec to;
+	int ret, pid = getpid();
+	pthread_t t;
+
+	SAFE_PTHREAD_CREATE(&t, NULL, threaded, (void *)&pid);
+
+	/* setting absolute timeout for futex2 */
+	if (clock_gettime(CLOCK_MONOTONIC, &to))
+		tst_brk(TBROK, "gettime64 failed");
+
+	to.tv_sec++;
+
+	ret = futex_waitv(waitv, numfutex, 0, &to, CLOCK_MONOTONIC);
+	if (ret < 0)
+		tst_brk(TBROK, "futex_waitv returned: %d %s", ret, tst_strerrno(-ret));
+	else if (ret != numfutex - 1)
+		tst_res(TFAIL, "futex_waitv returned: %d, expecting %d", ret, numfutex - 1);
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
+	.options = (struct tst_option[]){
+		{"n:", &str_numfutex, "Number of futex (default 30)"},
+		{},
+	},
+};
-- 
2.34.1


-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
