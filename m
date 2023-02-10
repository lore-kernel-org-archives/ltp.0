Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3DEEBC61DA4
	for <ltp@archiver.kernel.org>; Tue, 14 Feb 2023 08:53:58 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 7A98D3CC5C5
	for <ltp@archiver.kernel.org>; Tue, 14 Feb 2023 09:53:55 +0100 (CET)
Received: from in-5.smtp.seeweb.it (in-5.smtp.seeweb.it [217.194.8.5])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-384) server-digest SHA384)
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id A9E343C632B
 for <ltp@lists.linux.it>; Fri, 10 Feb 2023 09:05:13 +0100 (CET)
Received: from mail-pj1-x1043.google.com (mail-pj1-x1043.google.com
 [IPv6:2607:f8b0:4864:20::1043])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-5.smtp.seeweb.it (Postfix) with ESMTPS id B3B3E600C60
 for <ltp@lists.linux.it>; Fri, 10 Feb 2023 09:05:12 +0100 (CET)
Received: by mail-pj1-x1043.google.com with SMTP id o13so4489013pjg.2
 for <ltp@lists.linux.it>; Fri, 10 Feb 2023 00:05:12 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20210112;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to;
 bh=ZizZ2n9R70hniBk464JFs3KDVnyMp0yGo1DHQLmQVUk=;
 b=aZvKdR+7p43UaiP28wMAMZISv+0/acCZGuoQjq/8UvukXWS1PaaCnf5k2EwS/fyqU8
 X1G5DIwbBQgrtUk4n5UjVmQGH7ZwEef99pIvii9f209CJDcDoD8pz2x9iSdmQPdeVC1W
 3L/zhgon/2yL5Ba/rT7RfdU2efBOyGzqulpxzhtIEzJAfrYRTpar8TBLwKnDdeadCBL5
 XfVgWfqhfk/6oAaed7gnedTM/by23IBOR34GA/nV2SN4opMawvKXeneiYUVw2nlVawV4
 DVM5tbsy6Nswb9mjU2zaMsZE1jqnUvMXekGWTZQGDZMGJ9MWkgHg0urOiERSohA8zeEm
 hSLQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20210112;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=ZizZ2n9R70hniBk464JFs3KDVnyMp0yGo1DHQLmQVUk=;
 b=wQVYi2w7zivkjOWS9EP+NXQ7zmsOMoPPDoCzlCpFhX8YDVX35cIEQC1msyMK0XagGq
 /lZE6ylWhjFm9TgUdrt/iJB6SmebP9wavrOOAOERheTNMDyFHzrQSUqyuuaXEg7yvNUv
 q1PcZCaFlAsrGHhWOvyqpiuD4+X4Q4+xOEfSOuYm0EoL68vbFR5l5UVHnIvZIk2xP3IQ
 gMzGJWj/8j9M8o69mPTnRrRr8T/W3cRUSHiMUEdwufVhgwLdWnW3Wy2HfJvpr1taBB6T
 aNs1em+TaRY81BXxaWnFoc7QCLoR1TxcNUc+XQYzwzBeGUuyr3b1LxfE7w/QmySMrClI
 IYNA==
X-Gm-Message-State: AO0yUKUEF/SiMDcerl97FRIf0xKwBq7WoyZoOpC9ORHg0dORwMhQ5vZ/
 jOViDIHfWQxuvhGaqxCpxMNtlJTPeq588uNyaOpob01/
X-Google-Smtp-Source: AK7set81gEk5O3xa3Ef4tF4AajKOe9STSdZgzMkL3y5qPBmKWhRd0A9nbT7pCPFWn2VKDZokslc5rQ==
X-Received: by 2002:a17:902:ea0e:b0:199:4362:93df with SMTP id
 s14-20020a170902ea0e00b00199436293dfmr11712046plg.12.1676016310957; 
 Fri, 10 Feb 2023 00:05:10 -0800 (PST)
Received: from localhost ([218.66.91.195]) by smtp.gmail.com with ESMTPSA id
 ik22-20020a170902ab1600b0019a7363e752sm701724plb.276.2023.02.10.00.05.10
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 10 Feb 2023 00:05:10 -0800 (PST)
From: xiaoshoukui <xiaoshoukui@gmail.com>
To: ltp@lists.linux.it
Date: Fri, 10 Feb 2023 03:05:04 -0500
Message-Id: <20230210080504.7131-1-xiaoshoukui@gmail.com>
X-Mailer: git-send-email 2.20.1
MIME-Version: 1.0
X-Virus-Scanned: clamav-milter 0.102.4 at in-5.smtp.seeweb.it
X-Virus-Status: Clean
X-Mailman-Approved-At: Tue, 14 Feb 2023 09:53:33 +0100
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
