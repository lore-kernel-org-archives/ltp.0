Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B98A7C433F5
	for <ltp@archiver.kernel.org>; Wed, 19 Jan 2022 09:13:29 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 2B8E13C968F
	for <ltp@archiver.kernel.org>; Wed, 19 Jan 2022 10:13:26 +0100 (CET)
Received: from in-3.smtp.seeweb.it (in-3.smtp.seeweb.it [217.194.8.3])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 1EF093C875F
 for <ltp@lists.linux.it>; Wed, 19 Jan 2022 10:13:15 +0100 (CET)
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.220.29])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-3.smtp.seeweb.it (Postfix) with ESMTPS id 573461A00CA3
 for <ltp@lists.linux.it>; Wed, 19 Jan 2022 10:13:14 +0100 (CET)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
 (No client certificate requested)
 by smtp-out2.suse.de (Postfix) with ESMTPS id EAB711F384;
 Wed, 19 Jan 2022 09:13:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
 t=1642583593; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=WtFStwh671oAP1VRqGqLe1XIO17xbxvqYipUK9jpmS4=;
 b=cxbaTkQ4aahID+ZgpWxYoYisjDpvNzlmERlmLjti28QG40n2jNK1+8ibjH8kgfan1Dg11R
 dTgKSgPkCIBJ84zA4Zh1i7b3Z+2R5wZjnbVKiKrN4sqpg7CvZFDcu2N8UUX7lDGro1/OQW
 NyGsDXCFFM2s9Uz6La2L9BfYV2Dmv0M=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_ed25519; t=1642583593;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=WtFStwh671oAP1VRqGqLe1XIO17xbxvqYipUK9jpmS4=;
 b=QSgCuYilQ6T9Qx2OzwLI4ka9sw51x8AgyWzk1FH1Payd5PpAn7bKIdhNL+gpThn3A0RXcY
 mJgX96znoLyM3HAw==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
 (No client certificate requested)
 by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id C4E7E13B2D;
 Wed, 19 Jan 2022 09:13:13 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
 by imap2.suse-dmz.suse.de with ESMTPSA id APTnLSnW52HfHQAAMHmgww
 (envelope-from <andrea.cervesato@suse.de>); Wed, 19 Jan 2022 09:13:13 +0000
From: Andrea Cervesato <andrea.cervesato@suse.de>
To: ltp@lists.linux.it
Date: Wed, 19 Jan 2022 10:13:11 +0100
Message-Id: <20220119091311.22150-3-andrea.cervesato@suse.de>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20220119091311.22150-1-andrea.cervesato@suse.de>
References: <20220119091311.22150-1-andrea.cervesato@suse.de>
MIME-Version: 1.0
X-Virus-Scanned: clamav-milter 0.102.4 at in-3.smtp.seeweb.it
X-Virus-Status: Clean
Subject: [LTP] [PATCH v2 2/2] Add futex_waitv testing suite
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
 testcases/kernel/syscalls/futex/Makefile      |  14 +-
 .../kernel/syscalls/futex/futex_waitv01.c     | 129 ++++++++++++++++++
 .../kernel/syscalls/futex/futex_waitv02.c     | 104 ++++++++++++++
 .../kernel/syscalls/futex/futex_waitv03.c     | 112 +++++++++++++++
 5 files changed, 360 insertions(+), 2 deletions(-)
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
diff --git a/testcases/kernel/syscalls/futex/futex_waitv01.c b/testcases/kernel/syscalls/futex/futex_waitv01.c
new file mode 100644
index 000000000..ccf1699de
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
+#include "tst_test.h"
+#include "futextest.h"
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
+	tv = futex_variants[tst_variant];
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
+	res = tst_futex_waitv(waitv, numfutex, 0, &to, CLOCK_MONOTONIC);
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
+	res = tst_futex_waitv(waitv, numfutex, 0, &to, CLOCK_MONOTONIC);
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
+	res = tst_futex_waitv(waitv, numfutex, 0, &to, CLOCK_MONOTONIC);
+	if (res == EINVAL)
+		tst_res(TFAIL, "futex_waitv private returned: %d %s", res, tst_strerrno(res));
+	else
+		tst_res(TPASS, "futex_waitv NULL address in waitv.uaddr");
+
+	/* Testing a NULL address for *waiters */
+	init_timeout(&to);
+
+	res = tst_futex_waitv(NULL, numfutex, 0, &to, CLOCK_MONOTONIC);
+	if (res == EINVAL)
+		tst_res(TFAIL, "futex_waitv private returned: %d %s", res, tst_strerrno(res));
+	else
+		tst_res(TPASS, "futex_waitv NULL address in *waiters");
+
+	/* Testing an invalid clockid */
+	init_timeout(&to);
+
+	res = tst_futex_waitv(NULL, numfutex, 0, &to, CLOCK_TAI);
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
+	.test_variants = ARRAY_SIZE(futex_variants),
+	.options = (struct tst_option[]){
+		{"n:", &str_numfutex, "Number of futex (default 30)"},
+		{},
+	},
+};
diff --git a/testcases/kernel/syscalls/futex/futex_waitv02.c b/testcases/kernel/syscalls/futex/futex_waitv02.c
new file mode 100644
index 000000000..a19568993
--- /dev/null
+++ b/testcases/kernel/syscalls/futex/futex_waitv02.c
@@ -0,0 +1,104 @@
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
+#include "tst_test.h"
+#include "tst_safe_pthread.h"
+#include "futextest.h"
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
+	tv = futex_variants[tst_variant];
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
+	tv = futex_variants[tst_variant];
+
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
+	ret = tst_futex_waitv(waitv, numfutex, 0, &to, CLOCK_MONOTONIC);
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
+	.test_variants = ARRAY_SIZE(futex_variants),
+	.options = (struct tst_option[]){
+		{"n:", &str_numfutex, "Number of futex (default 30)"},
+		{},
+	},
+};
diff --git a/testcases/kernel/syscalls/futex/futex_waitv03.c b/testcases/kernel/syscalls/futex/futex_waitv03.c
new file mode 100644
index 000000000..3f18a15a2
--- /dev/null
+++ b/testcases/kernel/syscalls/futex/futex_waitv03.c
@@ -0,0 +1,112 @@
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
+#include <sys/shm.h>
+#include "tst_test.h"
+#include "tst_safe_pthread.h"
+#include "futextest.h"
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
+	tv = futex_variants[tst_variant];
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
+	tv = futex_variants[tst_variant];
+
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
+	ret = tst_futex_waitv(waitv, numfutex, 0, &to, CLOCK_MONOTONIC);
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
+	.test_variants = ARRAY_SIZE(futex_variants),
+	.options = (struct tst_option[]){
+		{"n:", &str_numfutex, "Number of futex (default 30)"},
+		{},
+	},
+};
-- 
2.34.1


-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
