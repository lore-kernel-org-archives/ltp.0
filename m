Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C7D2DC43334
	for <ltp@archiver.kernel.org>; Mon, 13 Jun 2022 14:38:57 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 970ED3C9420
	for <ltp@archiver.kernel.org>; Mon, 13 Jun 2022 16:38:54 +0200 (CEST)
Received: from in-2.smtp.seeweb.it (in-2.smtp.seeweb.it
 [IPv6:2001:4b78:1:20::2])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-384))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id AA4AF3C93E8
 for <ltp@lists.linux.it>; Mon, 13 Jun 2022 16:38:34 +0200 (CEST)
Received: from mail-wm1-x334.google.com (mail-wm1-x334.google.com
 [IPv6:2a00:1450:4864:20::334])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-2.smtp.seeweb.it (Postfix) with ESMTPS id D77B3600640
 for <ltp@lists.linux.it>; Mon, 13 Jun 2022 16:38:33 +0200 (CEST)
Received: by mail-wm1-x334.google.com with SMTP id
 r123-20020a1c2b81000000b0039c1439c33cso3223193wmr.5
 for <ltp@lists.linux.it>; Mon, 13 Jun 2022 07:38:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20210112;
 h=from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=IW5AdrwJFJkTCOddg+sOCkT4UMYNnOvVEDncLamUJ+k=;
 b=jsNA/tfaLPOM6Qtgp5DHLwRQo1uHMWs36NpA3cDegXedNOFEcgDAwTAWNpxNM0nvxi
 5BaAINL9oP9BYmfO+wcT1ibAd4J3wuW7Zn8Y63A2YnjK6nq8EVKGcl72LAGYICwPNA5E
 evt9qeA6wcriHLmL3IK3zmC4bY/x/LdUTinqqenc+Ikwk/23aHvRYBd5rvqfxuwraXPB
 A40l57WyHtkwWv4Y1OSyN+PNgajIY6vBFaYV4/2hfaKTDFEudxNAobrHaH171PYDfZZm
 y7FRsK94Z8hGSaecQY2hzqRlD2sGTiE1DrFQywnZLWA8ZOPL+IJAmm1WitS5Mf/ZdI8D
 MRLA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20210112;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=IW5AdrwJFJkTCOddg+sOCkT4UMYNnOvVEDncLamUJ+k=;
 b=sdZaVbKo81PP/Cv5Udd16LMBb+zzQ+HYSSi8BrnH6JA9RcHeA3kcW3TAC9RiuRsGEO
 t8TKP47Xe6LzJh5yhFsX7Y89PrP2hND0rBEdx7EOlZGM+9BCy1uLmSZPcs2JU63oc6Mp
 +H6X7islIfezJQoi/MHIkfe6y6at4Lw10leCPRu1sGhQeB5SHtQGcJUq/HAPx8V/S7rj
 f/u6mYcN4ttMb8WtQ1edGbIWWypTvRIW+q8wLDjMJZwXc+RQ665CNylpT3OxW8H1vO3c
 83eb+DAb6ES1+/qn+F5ssQrQLKOQ6R++qgbQ+iBYQLV8kWocwMEhWL++Qq3UbkgCNzMy
 BnxQ==
X-Gm-Message-State: AOAM530GIu9IA5yFTFWteHjuE2veqttfrV09ww2g51xd5pGUz8GPX+Vq
 FZU8Vu0EfjC3jZ7v3jQBzT0=
X-Google-Smtp-Source: ABdhPJw3hZQq5xlio+Ee/gpORWUgEkuXj+atg5RHJ+4lghnbnUtvkjjdU2NHXVcynsjdNjYe/TY1rQ==
X-Received: by 2002:a05:600c:3d99:b0:39c:55ba:ecc3 with SMTP id
 bi25-20020a05600c3d9900b0039c55baecc3mr15497535wmb.42.1655131113214; 
 Mon, 13 Jun 2022 07:38:33 -0700 (PDT)
Received: from amir-ThinkPad-T480.ctera.local
 (bzq-166-168-31-246.red.bezeqint.net. [31.168.166.246])
 by smtp.gmail.com with ESMTPSA id
 o19-20020a05600c4fd300b0039c55bc2c97sm14833072wmq.16.2022.06.13.07.38.31
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 13 Jun 2022 07:38:32 -0700 (PDT)
From: Amir Goldstein <amir73il@gmail.com>
To: Petr Vorel <pvorel@suse.cz>
Date: Mon, 13 Jun 2022 17:38:22 +0300
Message-Id: <20220613143826.1328830-2-amir73il@gmail.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20220613143826.1328830-1-amir73il@gmail.com>
References: <20220613143826.1328830-1-amir73il@gmail.com>
MIME-Version: 1.0
X-Virus-Scanned: clamav-milter 0.102.4 at in-2.smtp.seeweb.it
X-Virus-Status: Clean
Subject: [LTP] [PATCH 1/5] syscalls/inotify12: Introduce test for inotify
 mask flags
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
Cc: Matthew Bobrowski <repnop@google.com>, Jan Kara <jack@suse.cz>,
 ltp@lists.linux.it
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: ltp-bounces+ltp=archiver.kernel.org@lists.linux.it
Sender: "ltp" <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>

Test behavior of IN_ONESHOT and IN_EXCL_UNLINK.

Signed-off-by: Amir Goldstein <amir73il@gmail.com>
---
 runtest/syscalls                              |   1 +
 testcases/kernel/syscalls/inotify/.gitignore  |   1 +
 testcases/kernel/syscalls/inotify/inotify12.c | 168 ++++++++++++++++++
 3 files changed, 170 insertions(+)
 create mode 100644 testcases/kernel/syscalls/inotify/inotify12.c

diff --git a/runtest/syscalls b/runtest/syscalls
index 3b26d19e6..1259e41f1 100644
--- a/runtest/syscalls
+++ b/runtest/syscalls
@@ -588,6 +588,7 @@ inotify08 inotify08
 inotify09 inotify09
 inotify10 inotify10
 inotify11 inotify11
+inotify12 inotify12
 
 fanotify01 fanotify01
 fanotify02 fanotify02
diff --git a/testcases/kernel/syscalls/inotify/.gitignore b/testcases/kernel/syscalls/inotify/.gitignore
index 593cf6c04..f6e5c546a 100644
--- a/testcases/kernel/syscalls/inotify/.gitignore
+++ b/testcases/kernel/syscalls/inotify/.gitignore
@@ -9,3 +9,4 @@
 /inotify09
 /inotify10
 /inotify11
+/inotify12
diff --git a/testcases/kernel/syscalls/inotify/inotify12.c b/testcases/kernel/syscalls/inotify/inotify12.c
new file mode 100644
index 000000000..fe72771c5
--- /dev/null
+++ b/testcases/kernel/syscalls/inotify/inotify12.c
@@ -0,0 +1,168 @@
+// SPDX-License-Identifier: GPL-2.0-or-later
+/*
+ * Copyright (c) 2022 CTERA Networks. All Rights Reserved.
+ *
+ * Author: Amir Goldstein <amir73il@gmail.com>
+ */
+
+/*\
+ * [Description]
+ * Test special inotify mask flags.
+ *
+ * Regression test for kernel commit a32e697cda27:
+ *
+ *     inotify: show inotify mask flags in proc fdinfo
+ */
+
+#include "config.h"
+
+#include <stdio.h>
+#include <unistd.h>
+#include <fcntl.h>
+#include <signal.h>
+#include <sys/wait.h>
+
+#include "tst_test.h"
+#include "tst_safe_macros.h"
+#include "inotify.h"
+
+#if defined(HAVE_SYS_INOTIFY_H)
+#include <sys/inotify.h>
+
+#define EVENT_MAX 32
+/* Size of the event structure, not including the name */
+#define EVENT_SIZE	(sizeof(struct inotify_event))
+#define EVENT_BUF_LEN	(EVENT_MAX * (EVENT_SIZE + 16))
+
+#define	TEST_FILE	"test_file"
+
+static char event_buf[EVENT_BUF_LEN];
+
+static struct tcase {
+	const char *tname;
+	unsigned int mask;
+	int expect_events;
+} tcases[] = {
+	{
+		"Watch for multi events",
+		IN_MODIFY,
+		2,
+	},
+	{
+		"Watch for single event",
+		IN_MODIFY | IN_ONESHOT,
+		1,
+	},
+	{
+		"Watch for events on linked file",
+		IN_MODIFY | IN_EXCL_UNLINK,
+		1,
+	},
+};
+
+int fd_notify;
+
+static void verify_inotify(unsigned int n)
+{
+	struct tcase *tc = &tcases[n];
+	int fd, len;
+	unsigned int tmpmask;
+	char procfdinfo[100];
+	struct inotify_event *event = (struct inotify_event *)event_buf;
+
+	tst_res(TINFO, "Test #%d: %s", n, tc->tname);
+
+	fd_notify = SAFE_MYINOTIFY_INIT1(O_NONBLOCK);
+
+	SAFE_FILE_PRINTF(TEST_FILE, "1");
+
+	SAFE_MYINOTIFY_ADD_WATCH(fd_notify, ".", tc->mask);
+
+	sprintf(procfdinfo, "/proc/%d/fdinfo/%d", (int)getpid(), fd_notify);
+	if (FILE_LINES_SCANF(procfdinfo, "inotify wd:%*d ino:%*x sdev:%*x mask:%x",
+			     &tmpmask)) {
+		tst_res(TFAIL, "Could not parse inotify fdinfo");
+	} else if (tmpmask != tc->mask) {
+		tst_res(TFAIL, "Incorrect mask %x in inotify fdinfo (expected %x)",
+			tmpmask, tc->mask);
+	} else {
+		tst_res(TPASS, "Correct mask in inotify fdinfo");
+	}
+
+	fd = SAFE_OPEN(TEST_FILE, O_RDWR);
+	SAFE_WRITE(1, fd, "2", 1);
+
+	/*
+	 * Read the 1st IN_MODIFY event
+	 */
+	len = SAFE_READ(0, fd_notify, event_buf, EVENT_BUF_LEN);
+
+	if (len < (int)sizeof(*event)) {
+		tst_res(TFAIL, "Got no events");
+	} else if (event->mask == IN_MODIFY) {
+		tst_res(TPASS, "Got 1st event as expected");
+	} else {
+		tst_res(TFAIL, "Got event 0x%x (expected 0x%x)",
+				event->mask, IN_MODIFY);
+	}
+
+	/*
+	 * Unlink file so IN_EXCL_UNLINK won't get IN_ACCESS event.
+	 * IN_ONESHOT won't get IN_ACCESS event because IN_MODIFY
+	 * was already generated.
+	 */
+	SAFE_UNLINK(TEST_FILE);
+	SAFE_WRITE(1, fd, "3", 1);
+	SAFE_CLOSE(fd);
+
+	/*
+	 * Possibly read the 2nd IN_MODIFY event
+	 */
+	errno = 0;
+	len = read(fd_notify, event_buf, EVENT_BUF_LEN);
+	SAFE_CLOSE(fd_notify);
+	if (len < 0 && errno == EAGAIN) {
+		/* Treat no event same as we treat IN_IGNORED */
+		event->mask = IN_IGNORED;
+	} else if (len < (int)sizeof(*event)) {
+		tst_res(TFAIL | TERRNO, "Failed to read events");
+		return;
+	}
+
+	if (event->mask == IN_MODIFY) {
+		if (tc->expect_events > 1)
+			tst_res(TPASS, "Got 2nd event as expected");
+		else
+			tst_res(TFAIL, "Got unexpected 2nd event");
+	} else if (event->mask == IN_IGNORED) {
+		if (tc->expect_events == 1)
+			tst_res(TPASS, "Got no more events as expected");
+		else
+			tst_res(TFAIL, "Got only one event (expected %d)",
+					tc->expect_events);
+	} else {
+		tst_res(TFAIL, "Got unexpected event 0x%x",
+				event->mask);
+	}
+}
+
+static void cleanup(void)
+{
+	if (fd_notify > 0)
+		SAFE_CLOSE(fd_notify);
+}
+
+static struct tst_test test = {
+	.timeout = 10,
+	.needs_tmpdir = 1,
+	.cleanup = cleanup,
+	.test = verify_inotify,
+	.tcnt = ARRAY_SIZE(tcases),
+	.tags = (const struct tst_tag[]) {
+		{"linux-git", "a32e697cda27"},
+		{}
+};
+
+#else
+	TST_TEST_TCONF("system doesn't have required inotify support");
+#endif
-- 
2.25.1


-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
