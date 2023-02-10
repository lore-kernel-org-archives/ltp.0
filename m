Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8F882C05027
	for <ltp@archiver.kernel.org>; Fri, 10 Feb 2023 08:44:28 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 776433CC06A
	for <ltp@archiver.kernel.org>; Fri, 10 Feb 2023 09:44:26 +0100 (CET)
Received: from in-6.smtp.seeweb.it (in-6.smtp.seeweb.it
 [IPv6:2001:4b78:1:20::6])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-384))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id EF0C93C4D54
 for <ltp@lists.linux.it>; Fri, 10 Feb 2023 09:44:15 +0100 (CET)
Received: from mail-pl1-x644.google.com (mail-pl1-x644.google.com
 [IPv6:2607:f8b0:4864:20::644])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-6.smtp.seeweb.it (Postfix) with ESMTPS id 3CF6B14010F0
 for <ltp@lists.linux.it>; Fri, 10 Feb 2023 09:44:15 +0100 (CET)
Received: by mail-pl1-x644.google.com with SMTP id u9so5782461plf.3
 for <ltp@lists.linux.it>; Fri, 10 Feb 2023 00:44:15 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20210112;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to;
 bh=ZizZ2n9R70hniBk464JFs3KDVnyMp0yGo1DHQLmQVUk=;
 b=VAGbH9Nf9ZgKJ65Uu8i3+QTuYpMm+QZxyQzbg5VOOjmuaUrjwI9y8Iq/f+gC4FgqKZ
 d0M3dEDB/lviI4W/Gg7YqCcW/th4Snq79BourTkgEvk8XZqOTenWg5N0fZS9Oa+XBZDX
 OH6jPhJPOSTtYCmohHOH6lxouqYcp/LF2FfqHLlMPhhtG7xaZqd9gQkFKme7ofNaMxGc
 AeRtUaBXc/FppOzLOsWahCMeK54OqYIuk8Wk6qKoXdeBU7wqeIIUT82IwmGKsSVZOoKB
 89ViDZ/OyNmjvQAjhpSpOZzTH8GBbtT1Cf8UL78SSAPbHCWFwzVKjm4blQO5H6LxefVx
 g7zw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20210112;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=ZizZ2n9R70hniBk464JFs3KDVnyMp0yGo1DHQLmQVUk=;
 b=TdC9Q18XPcGnTaWYq8Au3fm6TN3USiVK8zp4LuIvEDLMtU8KVSCX3rUEPkBWo4NxhK
 AKyb9U1hBjYqCHS+vM9t4keTNE4mNKBMDvvJpQwbwVFMPL4wtIYEQFwSbbCpedlMdexx
 4fKi3A1ccQaRmrnkzuHuKcnAWytFkiiiaj05LjhSok+eTdlHndObNF982GYDik1S5UKH
 7Lt2LjveDas6QwGnqDbcxnl2h17Qsp9BJeaYl0teLtgy4x6dpgx9QmXQEvaSDowhkjHx
 smm5Pv7bMT0exA3ISepEMFLnxktwOPE/XuGoAYdNhD0XP65ZNPjUcIUmZNoRHaPXU41D
 ppHw==
X-Gm-Message-State: AO0yUKWc8XXqTfq0Kr0B1npAkKvp6imSpcNh8VaQ7jcSm5w+uOJAqrBe
 YKvSWj6DEM1xiUqvSshXrSCKsMQkW957ruLZKrogdpni
X-Google-Smtp-Source: AK7set8wDcuCqGvN0joMOvh/9Tq+zQmBUEofmYMobCr3M+9rTxPlMRGBxm8PyMos+7z3AbKlvvzI5g==
X-Received: by 2002:a17:902:e484:b0:189:cef2:88e3 with SMTP id
 i4-20020a170902e48400b00189cef288e3mr11096635ple.57.1676018653468; 
 Fri, 10 Feb 2023 00:44:13 -0800 (PST)
Received: from localhost.localdomain ([218.66.91.195])
 by smtp.gmail.com with ESMTPSA id
 jg18-20020a17090326d200b001991cff52a8sm2866142plb.28.2023.02.10.00.44.12
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 10 Feb 2023 00:44:13 -0800 (PST)
From: xiaoshoukui <xiaoshoukui@gmail.com>
To: ltp@lists.linux.it
Date: Fri, 10 Feb 2023 03:44:08 -0500
Message-Id: <20230210084408.8360-1-xiaoshoukui@gmail.com>
X-Mailer: git-send-email 2.20.1
MIME-Version: 1.0
X-Virus-Scanned: clamav-milter 0.102.4 at in-6.smtp.seeweb.it
X-Virus-Status: Clean
Subject: [LTP] [PATCH 1/1 1/1] Add ioctl_loop08 test for LOOP_GET_STATUS
 lock imbalance
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

From: xiaoshoukui <xiaoshoukui@ruijie.com.cn>

Signed-off-by: xiaoshoukui <xiaoshoukui@ruijie.com.cn>
---
 testcases/kernel/syscalls/ioctl/Makefile      |   1 +
 .../kernel/syscalls/ioctl/ioctl_loop08.c      | 132 ++++++++++++++++++
 2 files changed, 133 insertions(+)
 create mode 100644 testcases/kernel/syscalls/ioctl/ioctl_loop08.c

diff --git a/testcases/kernel/syscalls/ioctl/Makefile b/testcases/kernel/syscalls/ioctl/Makefile
index c2ff6c8e7..b61c61189 100644
--- a/testcases/kernel/syscalls/ioctl/Makefile
+++ b/testcases/kernel/syscalls/ioctl/Makefile
@@ -12,3 +12,4 @@ FILTER_OUT_MAKE_TARGETS	+= ioctl02
 endif
 
 include $(top_srcdir)/include/mk/generic_leaf_target.mk
+CFLAGS+=-pthread
diff --git a/testcases/kernel/syscalls/ioctl/ioctl_loop08.c b/testcases/kernel/syscalls/ioctl/ioctl_loop08.c
new file mode 100644
index 000000000..a6cd31805
--- /dev/null
+++ b/testcases/kernel/syscalls/ioctl/ioctl_loop08.c
@@ -0,0 +1,132 @@
+// SPDX-License-Identifier: GPL-2.0-or-later
+/*
+ * Copyright (c) 2022 xiaoshoukui <xiaoshoukui@ruijie.com.cn>
+ */
+
+/*\
+ * [Description]
+ *
+ * This is a basic ioctl test about loopdevice LOOP_GET_STATUS
+ * and LOOP_GET_STATUS64.
+ * Commit 2d1d4c1e591f made loop_get_status() drop lo_ctx_mutex before
+ * returning, but the loop_get_status_old(), loop_get_status64(), and
+ * loop_get_status_compat() wrappers don't call loop_get_status() if the
+ * passed argument is NULL. The callers expect that the lock is dropped, so
+ * make sure we drop it in that case, too.
+ *
+ * Fixed by commit:
+ *
+ *  commit bdac616db9bbadb90b7d6a406144571015e138f7
+ *  Author: Omar Sandoval <osandov@fb.com>
+ *  Date:   Fri Apr 06 09:57:03 2018 -0700
+ *
+ *    loop: fix LOOP_GET_STATUS lock imbalance
+ */
+
+#include <stdio.h>
+#include <unistd.h>
+#include <sys/types.h>
+#include <stdlib.h>
+#include "lapi/loop.h"
+#include "tst_test.h"
+#include <pthread.h>
+
+#define MAX_MSGSIZE 4096
+
+static const char lock_imbalance[] = "lock held when returning to user space";
+
+static struct tcase {
+	int ioctl_flag;
+	char *message;
+} tcases[] = {
+	{ LOOP_GET_STATUS,
+	 "Testing LOOP_GET_STATUS lock imbalance" },
+
+	{ LOOP_GET_STATUS64,
+	 "Testing LOOP_GET_STATUS64 lock imbalance" },
+};
+
+static int find_kmsg(const char *text_to_find)
+{
+	int f, msg_found = 0;
+	char msg[MAX_MSGSIZE + 1];
+
+	f = SAFE_OPEN("/dev/kmsg", O_RDONLY | O_NONBLOCK);
+
+	while (1) {
+		TEST(read(f, msg, MAX_MSGSIZE));
+		if (TST_RET < 0) {
+			if (TST_ERR == EAGAIN)
+				/* there are no more messages */
+				break;
+			else if (TST_ERR == EPIPE)
+				/* current message was overwritten */
+				continue;
+			else
+				tst_brk(TBROK | TTERRNO,
+					"err reading /dev/kmsg");
+		} else {
+			/* lines from kmsg are not NULL terminated */
+			msg[TST_RET] = '\0';
+			if (strstr(msg, text_to_find) != NULL) {
+				msg_found = 1;
+				break;
+			}
+		}
+	}
+	SAFE_CLOSE(f);
+
+	if (msg_found)
+		return 0;
+	else
+		return -1;
+}
+
+static void *ioctl_thread(void *arg)
+{
+	char dev_path[1024];
+	int dev_num, dev_fd;
+	struct tcase *tc = (struct tcase *)arg;
+
+	tst_res(TINFO, "%s", tc->message);
+	dev_num = tst_find_free_loopdev(dev_path, sizeof(dev_path));
+	if (dev_num < 0)
+		tst_brk(TBROK, "Failed to find free loop device");
+	dev_fd = SAFE_OPEN(dev_path, O_RDWR);
+	if (tc->ioctl_flag == LOOP_GET_STATUS)
+		ioctl(dev_fd, LOOP_GET_STATUS, NULL);
+	else
+		ioctl(dev_fd, LOOP_GET_STATUS64, NULL);
+	if (dev_fd > 0)
+		SAFE_CLOSE(dev_fd);
+}
+
+static void verify_ioctl_loop(void)
+{
+	struct tcase *tc = &tcases[0];
+	pthread_t th1, th2;
+
+	pthread_create(&th1, NULL, ioctl_thread, tc);
+	usleep(500000);
+	pthread_create(&th2, NULL, ioctl_thread, tc + 1);
+	usleep(500000);
+	if (!find_kmsg(lock_imbalance))
+		tst_res(TFAIL, "Trigger lock imbalance");
+	else
+		tst_res(TPASS, "Nothing bad happened, probably");
+}
+
+static struct tst_test test = {
+	.test_all = verify_ioctl_loop,
+	.needs_root = 1,
+	.needs_kconfigs = (const char *[]) {
+					    "CONFIG_LOCKDEP=y",
+					    NULL },
+	.tags = (const struct tst_tag[]) {
+					  { "linux-git", "bdac616db9bb "},
+					  {}
+					   },
+	.needs_drivers = (const char *const[]) {
+						"loop",
+						NULL }
+};
-- 
2.20.1


-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
