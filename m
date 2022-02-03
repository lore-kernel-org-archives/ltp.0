Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4A474C433F5
	for <ltp@archiver.kernel.org>; Thu,  3 Feb 2022 06:12:38 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id B79CB3C98F1
	for <ltp@archiver.kernel.org>; Thu,  3 Feb 2022 07:12:35 +0100 (CET)
Received: from in-6.smtp.seeweb.it (in-6.smtp.seeweb.it
 [IPv6:2001:4b78:1:20::6])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 7FC273C8D54
 for <ltp@lists.linux.it>; Thu,  3 Feb 2022 07:12:25 +0100 (CET)
Received: from mail-wr1-x42d.google.com (mail-wr1-x42d.google.com
 [IPv6:2a00:1450:4864:20::42d])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-6.smtp.seeweb.it (Postfix) with ESMTPS id 5FD0A1400549
 for <ltp@lists.linux.it>; Thu,  3 Feb 2022 07:12:25 +0100 (CET)
Received: by mail-wr1-x42d.google.com with SMTP id s18so2863303wrv.7
 for <ltp@lists.linux.it>; Wed, 02 Feb 2022 22:12:25 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20210112;
 h=from:to:cc:subject:date:message-id:mime-version
 :content-transfer-encoding;
 bh=IOCBW7/6jl3ABsnnbE012TsjwR2bzhz9cOb9ezQP7NI=;
 b=IVmBuyQzOo7muRjUB3MXUKAjmQX7ONjH7Pzj58iJ+4t4Bbb0jms4Utm7v1A7GISBH8
 kmesqHOljl44F3vzLfDq3iQbGG7DPs7yklHuVZIlw0UurrLDZnyxGRKnlyOqs4X8o3Kh
 iv0IieM8AehmK0CaP1uX2z2ytW2eFz2qqconZ/0RAc6k5NScJXj3u/avUhThNBS22Xad
 7yiHHuEGrP1UkhYu2tMaxk5jJwRCpHpJ8Dgwn9koXp12Tc7JMl9ezfNVTeIvqzrN6yIm
 VD5C2aJgU3B5QkIEPAiVU5xDTkW63JSd8AVFvAYXqHGmKJJr5yP57d6ObgxGQMHqiU1O
 GkOg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20210112;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
 :content-transfer-encoding;
 bh=IOCBW7/6jl3ABsnnbE012TsjwR2bzhz9cOb9ezQP7NI=;
 b=OiR28ZrjKvdTH8rvf4zDw/mkjCu0Qwq7AowMuhJnk8ajvL2BGn+IBbW3LGV929Wlns
 QjfjTX1RFxUL+i6Mm/Ycn9iN7oN5WRObAxf7yrWF9UUAO5koxUMmGG0NKtfrNpuh0D0o
 S/pVEiIx4vp2D1VO5TpwggsRunSD8gQLLBhK0jMkSx4YnZCJak8q8qSBvxUf03Dlh3qO
 tKObrGtAAgyh7KjZy/9WkBzA6izbJNM0MnwC9cqDDUbqYeVaLO0oVLSzbwbkJM2jRrBI
 Rw9XOkTGNhtFksNRZMkFVowpR0pvy/rGU5ym9+uOzZQYCaqRP3iguUrVDmziXUhJK1wh
 EuNg==
X-Gm-Message-State: AOAM532kOSdIVAoc0xmNRv2MuSV3B6elqyiVgbUtEjnKT58ochIonJj+
 qlnooIwHWlNR7E5jzQccAAs=
X-Google-Smtp-Source: ABdhPJyFL/lGtf7m/580J7M3qBmMa58lQwUOmcG2t10Ci1Tdbl0FLyUVL37UZUgvoJhUK1FnFdHPVg==
X-Received: by 2002:a5d:4564:: with SMTP id a4mr4007769wrc.29.1643868744778;
 Wed, 02 Feb 2022 22:12:24 -0800 (PST)
Received: from localhost.localdomain ([77.137.71.153])
 by smtp.gmail.com with ESMTPSA id o10sm7841600wri.69.2022.02.02.22.12.23
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 02 Feb 2022 22:12:24 -0800 (PST)
From: Amir Goldstein <amir73il@gmail.com>
To: Petr Vorel <pvorel@suse.cz>
Date: Thu,  3 Feb 2022 08:12:22 +0200
Message-Id: <20220203061222.625948-1-amir73il@gmail.com>
X-Mailer: git-send-email 2.35.1
MIME-Version: 1.0
X-Virus-Scanned: clamav-milter 0.102.4 at in-6.smtp.seeweb.it
X-Virus-Status: Clean
Subject: [LTP] [PATCH] syscalls/inotify: New test for IN_DELETE regression
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
Cc: Ivan Delalande <colona@arista.com>, Jan Kara <jack@suse.cz>,
 ltp@lists.linux.it
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: ltp-bounces+ltp=archiver.kernel.org@lists.linux.it
Sender: "ltp" <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>

Check that files cannot be opened after IN_DELETE was reported
on them.

This test is based on the reproducer provided by Ivan Delalande
for a regression reported in kernel v5.13:
https://lore.kernel.org/linux-fsdevel/YeNyzoDM5hP5LtGW@visor/

Reported-by: Ivan Delalande <colona@arista.com>
Signed-off-by: Amir Goldstein <amir73il@gmail.com>
---

Hi Petr,

The fix for this regression was applied to stable kernels
5.4.y, 5.10.y, 5.15.y, 5.16.y.
The mentioned git tag is only the upstream commit.
Feel free to add the stable git tags if you think they are needed.

Thanks,
Amir,

 runtest/syscalls                              |   1 +
 testcases/kernel/syscalls/inotify/.gitignore  |   1 +
 testcases/kernel/syscalls/inotify/inotify11.c | 137 ++++++++++++++++++
 3 files changed, 139 insertions(+)
 create mode 100644 testcases/kernel/syscalls/inotify/inotify11.c

diff --git a/runtest/syscalls b/runtest/syscalls
index 3b2deb64e..2f05dcfa1 100644
--- a/runtest/syscalls
+++ b/runtest/syscalls
@@ -585,6 +585,7 @@ inotify07 inotify07
 inotify08 inotify08
 inotify09 inotify09
 inotify10 inotify10
+inotify11 inotify11
 
 fanotify01 fanotify01
 fanotify02 fanotify02
diff --git a/testcases/kernel/syscalls/inotify/.gitignore b/testcases/kernel/syscalls/inotify/.gitignore
index da9bfc767..593cf6c04 100644
--- a/testcases/kernel/syscalls/inotify/.gitignore
+++ b/testcases/kernel/syscalls/inotify/.gitignore
@@ -8,3 +8,4 @@
 /inotify08
 /inotify09
 /inotify10
+/inotify11
diff --git a/testcases/kernel/syscalls/inotify/inotify11.c b/testcases/kernel/syscalls/inotify/inotify11.c
new file mode 100644
index 000000000..88ac4d2d7
--- /dev/null
+++ b/testcases/kernel/syscalls/inotify/inotify11.c
@@ -0,0 +1,137 @@
+// SPDX-License-Identifier: GPL-2.0-or-later
+/*
+ * Copyright (c) 2022 CTERA Networks. All Rights Reserved.
+ *
+ * Started by Amir Goldstein <amir73il@gmail.com>
+ * based on reproducer from Ivan Delalande <colona@arista.com>
+ *
+ * DESCRIPTION
+ * Test opening files after receiving IN_DELETE.
+ *
+ * Kernel v5.13 has a regression allowing files to be open after IN_DELETE.
+ *
+ * The problem has been fixed by commit:
+ *  a37d9a17f099 "fsnotify: invalidate dcache before IN_DELETE event".
+ */
+
+#include "config.h"
+
+#include <stdio.h>
+#include <unistd.h>
+#include <stdlib.h>
+#include <fcntl.h>
+#include <poll.h>
+#include <time.h>
+#include <signal.h>
+#include <sys/time.h>
+#include <sys/wait.h>
+#include <sys/syscall.h>
+
+#include "tst_test.h"
+#include "inotify.h"
+
+#if defined(HAVE_SYS_INOTIFY_H)
+#include <sys/inotify.h>
+
+/* Number of files to test */
+#define CHURN_FILES 9999
+
+#define EVENT_MAX 32
+/* Size of the event structure, not including the name */
+#define EVENT_SIZE	(sizeof(struct inotify_event))
+#define EVENT_BUF_LEN	(EVENT_MAX * (EVENT_SIZE + 16))
+
+static pid_t pid;
+
+char event_buf[EVENT_BUF_LEN];
+
+void churn(void)
+{
+	char path[10];
+	int i;
+
+	for (i = 0; i <= CHURN_FILES; ++i) {
+		snprintf(path, sizeof(path), "%d", i);
+		SAFE_FILE_PRINTF(path, "1");
+		SAFE_UNLINK(path);
+	}
+}
+
+static void verify_inotify(void)
+{
+	int nevents = 0, opened = 0;
+	struct inotify_event *event;
+	int inotify_fd;
+
+	pid = SAFE_FORK();
+	if (pid == 0) {
+		churn();
+		return;
+	}
+
+	inotify_fd = SAFE_MYINOTIFY_INIT();
+	SAFE_MYINOTIFY_ADD_WATCH(inotify_fd, ".", IN_DELETE);
+
+	while (!opened && nevents < CHURN_FILES) {
+		int i, fd, len;
+
+		len = read(inotify_fd, event_buf, EVENT_BUF_LEN);
+		if (len == -1)
+			tst_brk(TBROK | TERRNO, "read failed");
+
+		for (i = 0; i < len; i += EVENT_SIZE + event->len) {
+			event = (struct inotify_event *)&event_buf[i];
+
+			if (!(event->mask & IN_DELETE))
+				continue;
+
+			nevents++;
+
+			/* Open file after IN_DELETE should fail */
+			fd = open(event->name, O_RDONLY);
+			if (fd < 0)
+				continue;
+
+			tst_res(TFAIL, "File %s opened after IN_DELETE", event->name);
+			SAFE_CLOSE(fd);
+			opened = 1;
+			break;
+		}
+	}
+
+	SAFE_CLOSE(inotify_fd);
+
+	if (!nevents)
+		tst_res(TFAIL, "Didn't get any IN_DELETE events");
+	else if (!opened)
+		tst_res(TPASS, "Got %d IN_DELETE events", nevents);
+
+	/* Kill the child creating / deleting files and wait for it */
+	SAFE_KILL(pid, SIGKILL);
+	pid = 0;
+	SAFE_WAIT(NULL);
+}
+
+static void cleanup(void)
+{
+	if (pid) {
+		SAFE_KILL(pid, SIGKILL);
+		SAFE_WAIT(NULL);
+	}
+}
+
+static struct tst_test test = {
+	.timeout = 10,
+	.needs_tmpdir = 1,
+	.forks_child = 1,
+	.cleanup = cleanup,
+	.test_all = verify_inotify,
+	.tags = (const struct tst_tag[]) {
+		{"linux-git", "a37d9a17f099"},
+		{}
+	}
+};
+
+#else
+	TST_TEST_TCONF("system doesn't have required inotify support");
+#endif
-- 
2.35.1


-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
