Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B82B6C636D4
	for <ltp@archiver.kernel.org>; Wed, 15 Feb 2023 05:57:52 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 4C0223CC3D3
	for <ltp@archiver.kernel.org>; Wed, 15 Feb 2023 06:57:49 +0100 (CET)
Received: from in-6.smtp.seeweb.it (in-6.smtp.seeweb.it [217.194.8.6])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-384))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id D0E753CB073
 for <ltp@lists.linux.it>; Wed, 15 Feb 2023 06:57:38 +0100 (CET)
Received: from mail-pf1-x442.google.com (mail-pf1-x442.google.com
 [IPv6:2607:f8b0:4864:20::442])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-6.smtp.seeweb.it (Postfix) with ESMTPS id 199DC1400B8B
 for <ltp@lists.linux.it>; Wed, 15 Feb 2023 06:57:38 +0100 (CET)
Received: by mail-pf1-x442.google.com with SMTP id ct17so6298881pfb.12
 for <ltp@lists.linux.it>; Tue, 14 Feb 2023 21:57:38 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20210112;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to;
 bh=gABn0MZ+pkGK3glSWvoRIvgsBPfvDBquS3oddQctAu8=;
 b=qy5x1ujO4LBS+83QiyNpeG/dJyUCMtdYviAlByZUAdeT7i5nwNbpl0XCzgzpUVy7NA
 HL//YfdoX0jO2ofsg6E0hv5Kh0S8uXtlSTyugEdg928AsKy7nBKZOCET7UKvAmhlcg+t
 tDlIrODyx39uTDtRO4FM+RJT65Tl+XslCIJCojTp0CLb6tZJc70rFRmmWom+eQTrnfEf
 zHkC02fKDLd0A8JaxjdtP+iYQynbgqAmwZS34zdNMdqR63w86ZjRClfz4JaXGU0HcqRv
 vUPqW5HMF4DkW+iPI7q1939tABZCwJfutQqgpsmNYRgKj/oIwU6mERNMvPOB6bLpbSmI
 5l9g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20210112;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=gABn0MZ+pkGK3glSWvoRIvgsBPfvDBquS3oddQctAu8=;
 b=6HEwpKwsR9aZvQgc2jj2OBSkNAMdtC4FXwYV/NK3mtzyNpC7A2L7fSBqGtk69/TNeJ
 wEyGD3NsV4rHN0SqefIKrASkc0xYAGkTwJG+TBnsKvGpBTErFRt2rNZD+ld08icFlbEX
 bM3jhWtIKoem5M4atCT/pqnNvFCekxKqecqjoQLp8gvs3VefKFEabgA7WzzF3hTRcl/b
 /t5DwZ6Eq7uyslXtMAKqhRTpPw4fr/5TdZQOMRsFdQGAH800aZGtus5p5dWtd5zDJI+h
 22emXbm9f435TGZEbNuTp4/mhfYTGHA0tpNH7fuqna67SaVrxLp9bDWzhpeWLZVBQb9J
 N+DA==
X-Gm-Message-State: AO0yUKWMbbhG1JGOc4TUlwRvzwkBoQYyeS/tjtwxoEUw/yQAJb4qN1So
 4IPalGsa0rWV2leZ2t2S0KJF0RkUs8f+FrqSGA0=
X-Google-Smtp-Source: AK7set/KzaTjnH26FlJP7fovYn439EqYQ2Namz2y48SSndRtIGwbOovjKP2gGUM2wyNmJQQYKEOZoA==
X-Received: by 2002:a62:1d58:0:b0:5a8:a250:bc16 with SMTP id
 d85-20020a621d58000000b005a8a250bc16mr715359pfd.3.1676440656168; 
 Tue, 14 Feb 2023 21:57:36 -0800 (PST)
Received: from localhost.localdomain ([218.66.91.195])
 by smtp.gmail.com with ESMTPSA id
 2-20020aa79142000000b00575caf80d08sm10881324pfi.31.2023.02.14.21.57.34
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 14 Feb 2023 21:57:35 -0800 (PST)
From: xiaoshoukui <xiaoshoukui@gmail.com>
To: ltp@lists.linux.it
Date: Wed, 15 Feb 2023 00:57:27 -0500
Message-Id: <20230215055727.20793-1-xiaoshoukui@gmail.com>
X-Mailer: git-send-email 2.20.1
MIME-Version: 1.0
X-Virus-Scanned: clamav-milter 0.102.4 at in-6.smtp.seeweb.it
X-Virus-Status: Clean
Subject: [LTP] [PATCH v2] Add ioctl_loop08 test for LOOP_GET_STATUS lock
 imbalance
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

---
 .../kernel/syscalls/ioctl/ioctl_loop08.c      | 147 ++++++++++++++++++
 1 file changed, 147 insertions(+)
 create mode 100644 testcases/kernel/syscalls/ioctl/ioctl_loop08.c

diff --git a/testcases/kernel/syscalls/ioctl/ioctl_loop08.c b/testcases/kernel/syscalls/ioctl/ioctl_loop08.c
new file mode 100644
index 000000000..047273576
--- /dev/null
+++ b/testcases/kernel/syscalls/ioctl/ioctl_loop08.c
@@ -0,0 +1,147 @@
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
+static void do_child(void)
+{
+	char dev_path[1024];
+	int dev_num, dev_fd;
+	unsigned int i;
+
+	for (i = 0; i < ARRAY_SIZE(tcases); i++) {
+		tst_res(TINFO, "%s", tcases[i].message);
+		dev_num = tst_find_free_loopdev(dev_path, sizeof(dev_path));
+
+		if (dev_num < 0)
+			tst_brk(TBROK, "Failed to find free loop device");
+
+		dev_fd = SAFE_OPEN(dev_path, O_RDWR);
+
+		if (tcases[i].ioctl_flag == LOOP_GET_STATUS)
+			ioctl(dev_fd, LOOP_GET_STATUS, NULL);
+		else
+			ioctl(dev_fd, LOOP_GET_STATUS64, NULL);
+
+		if (dev_fd > 0)
+			SAFE_CLOSE(dev_fd);
+
+	}
+
+	exit(0);
+
+}
+
+static void verify_ioctl_loop(void)
+{
+	int ret, pid;
+
+	pid = SAFE_FORK();
+	if (!pid)
+		do_child();
+
+	ret = TST_PROCESS_STATE_WAIT(pid, 'D', 5000);
+
+	if (!ret && !find_kmsg(lock_imbalance))
+		tst_res(TFAIL, "Trigger ioctl loop lock imbalance");
+	else
+		tst_res(TPASS, "Nothing bad happened, probably");
+
+}
+
+static struct tst_test test = {
+	.test_all = verify_ioctl_loop,
+	.needs_root = 1,
+	.needs_kconfigs = (const char *[]) {
+		"CONFIG_LOCKDEP=y",
+		NULL
+	},
+	.tags = (const struct tst_tag[]) {
+		{"linux-git", "bdac616db9bb "},
+		{}
+	},
+	.needs_drivers = (const char *const[]) {
+		"loop",
+		NULL
+	},
+	.forks_child = 1,
+	.timeout = 60,
+};
-- 
2.20.1


-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
