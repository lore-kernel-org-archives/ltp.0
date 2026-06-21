Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id F13E3CDB466
	for <ltp@archiver.kernel.org>; Sun, 21 Jun 2026 09:05:09 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 0BBA93E4B69
	for <ltp@archiver.kernel.org>; Sun, 21 Jun 2026 11:05:08 +0200 (CEST)
Received: from in-3.smtp.seeweb.it (in-3.smtp.seeweb.it
 [IPv6:2001:4b78:1:20::3])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1) server-digest SHA384)
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 7DE5F3E2F49
 for <ltp@lists.linux.it>; Sun, 21 Jun 2026 11:04:40 +0200 (CEST)
Received: from mail-pl1-x644.google.com (mail-pl1-x644.google.com
 [IPv6:2607:f8b0:4864:20::644])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-3.smtp.seeweb.it (Postfix) with ESMTPS id AA47A1A003D1
 for <ltp@lists.linux.it>; Sun, 21 Jun 2026 11:04:39 +0200 (CEST)
Received: by mail-pl1-x644.google.com with SMTP id
 d9443c01a7336-2c6dadfbaafso31499695ad.3
 for <ltp@lists.linux.it>; Sun, 21 Jun 2026 02:04:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1782032678; x=1782637478; darn=lists.linux.it;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
 :reply-to; bh=nMJ0ZQr1Kukzv7A0KuDJcPyWGWGxAAcDewNQNnUwW3c=;
 b=mZJ4K2soGAMX+VuG+1eAvrw3MWhiVDU2zR9EuEI75583c0IJp383ffkO+P7msaVO+s
 IGzgXN4hK3AMu9UBqe64XQaazw1pHY/AXaNSvpOKkYNU4MGnVN/o4laftiBYwr8ymWns
 CWpns8zS8MBj2Maod6PnEMNrdjqjaXFD6kz6hFF0VFIDwl9xXDqmY6TAaPhAmN23nkDN
 nFgxjiGThCK53UvmQA9cVyfGYPiY2I5fVN3hcEwAlnV+HOs7YRGZnmxMFAkCGD3bx3SL
 GiKbUnK+RY0yMq0tO9q7e5Q/kXpHOs1Inri0x6ovg5+QtOITJDU0RFF60veblhNQSAAN
 Tmmw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1782032678; x=1782637478;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:x-gm-gg:x-gm-message-state:from:to
 :cc:subject:date:message-id:reply-to;
 bh=nMJ0ZQr1Kukzv7A0KuDJcPyWGWGxAAcDewNQNnUwW3c=;
 b=HW5xCKCnXS4Bir/uRlRyhZpVs8dFanQHfqJlXcoJRzSJrBHU9UkORoAggKNU/ZtWPg
 6CKoYsH9nv4GNbWpMaHpjkha7mzQ5rEb/NQT0UkpK/6ZIo1L7/q1KJ3WDXtFBS9vDVX9
 y0rVjYI5/cAjiu3pVwpdOuy5GbEcC2DzWiXUOFOizIE+sI/5U2T7VE2pQIAWLjzvnZM3
 luwyarj7Hs/+ifiFUZturRgKDzwGHGiqDhEE0kXxXBuKH2Y+BBQdT4JuS4bUg03ZE7eB
 1x/k1+LQZn2jst7Kang2SL1PppWau/7JkdhUPhJTNtzR0Ol7em1PacuZoNXyE3Wc3ycb
 KlUw==
X-Gm-Message-State: AOJu0Yw9e3u/SFKaq8fT9GCV0+yvZx2aU579r472AAZphBKSBHVV4q2R
 Tqu+3ICtqL2zUJ8amJNGQeVHm7Nus0NMPFI8iVmcDE4rQ5HyDFc66l57T9zd0rYuh28S
X-Gm-Gg: AfdE7ck3bwszYK+4iE2FCCcjf4Spg3dCRVmg7RslXKt8sv8mWeWfvyNF8rBJRgx5ilc
 5VthtzY0A4KA4fx0LQDAGratgmZBO8ab16AfvgTECqNWUkwV/dVi5rWKFq9I/1zR4tBTCLZMk7H
 ya9k0GFwmcObXGjDXUe2H5quuE8I6o28DOI52VN/9JnniY6vsJuCrCkgyh28MjrmsaA+oYo9PtE
 08hRg1ERqogakOsumu7WfjBKr5iEgi84T7zZ74X5/L/RIXHCDSoLk9pBEd122aTav40ch1OVkxq
 SHcmlhVrI8+sOHCm/ZGkeJup1iVDoxmej/0IqwKQdjEeDxDNOVItVbf1w4SvaEJ/tj5eh2Ktf2Z
 CTxRvDtkoKQuBZ3+ltdEY3oEfozuZp/sLwAkE2IvrPt3kvjIsnCJZTgQy4p+7+JiVezbJauqpwc
 aLRe1FGns+yVLckFN0t/043lr3pBtGCTMjoGs4jCto0A==
X-Received: by 2002:a17:902:cf03:b0:2c1:f262:4962 with SMTP id
 d9443c01a7336-2c718f03795mr115116055ad.20.1782032677926; 
 Sun, 21 Jun 2026 02:04:37 -0700 (PDT)
Received: from localhost.localdomain ([59.16.109.172])
 by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-2c7436ff3b1sm42632675ad.36.2026.06.21.02.04.36
 for <ltp@lists.linux.it>
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sun, 21 Jun 2026 02:04:37 -0700 (PDT)
From: Jinseok Kim <always.starving0@gmail.com>
To: ltp@lists.linux.it
Date: Sun, 21 Jun 2026 18:04:00 +0900
Message-ID: <20260621090403.2236-2-always.starving0@gmail.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260621090403.2236-1-always.starving0@gmail.com>
References: <20260621090403.2236-1-always.starving0@gmail.com>
MIME-Version: 1.0
X-Virus-Scanned: clamav-milter 1.0.9 at in-3.smtp.seeweb.it
X-Virus-Status: Clean
Subject: [LTP] [PATCH v9 2/2] fstat: add test for multiple file types using
 fstat
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

Following review feedback, create a dedicated fstat test that verifies
S_ISREG(), S_ISDIR(), S_ISFIFO(), S_ISCHR(), S_ISBLK() on different file
types.

Signed-off-by: Jinseok Kim <always.starving0@gmail.com>
---
Changes in v9:
- Open test files with O_PATH to avoid unnecessary device access
- Link to v8: https://lore.kernel.org/ltp/20260604142029.2077-2-always.starving0@gmail.com

Changes in v8:
- Link to the man page
- Remove desc from tcase and TST_EXP_EXPR
- Link to v7: https://lore.kernel.org/ltp/20260327152751.3637-1-always.starving0@gmail.com
---
 runtest/syscalls                           |   2 +
 testcases/kernel/syscalls/fstat/.gitignore |   2 +
 testcases/kernel/syscalls/fstat/fstat04.c  | 107 +++++++++++++++++++++
 3 files changed, 111 insertions(+)
 create mode 100644 testcases/kernel/syscalls/fstat/fstat04.c

diff --git a/runtest/syscalls b/runtest/syscalls
index 43951df2a..a38743ded 100644
--- a/runtest/syscalls
+++ b/runtest/syscalls
@@ -436,6 +436,8 @@ fstat02 fstat02
 fstat02_64 fstat02_64
 fstat03 fstat03
 fstat03_64 fstat03_64
+fstat04 fstat04
+fstat04_64 fstat04_64

 #fstatat64/newfstatat test cases
 fstatat01 fstatat01
diff --git a/testcases/kernel/syscalls/fstat/.gitignore b/testcases/kernel/syscalls/fstat/.gitignore
index 9b1089438..a1f538f7e 100644
--- a/testcases/kernel/syscalls/fstat/.gitignore
+++ b/testcases/kernel/syscalls/fstat/.gitignore
@@ -2,3 +2,5 @@
 /fstat02_64
 /fstat03
 /fstat03_64
+/fstat04
+/fstat04_64
diff --git a/testcases/kernel/syscalls/fstat/fstat04.c b/testcases/kernel/syscalls/fstat/fstat04.c
new file mode 100644
index 000000000..7147aa61f
--- /dev/null
+++ b/testcases/kernel/syscalls/fstat/fstat04.c
@@ -0,0 +1,107 @@
+// SPDX-License-Identifier: GPL-2.0-or-later
+/*
+ * Copyright (C) 2026 Jinseok Kim <always.starving0@gmail.com>
+ */
+/*\
+ * Verify that :manpage:`fstat(2)` correctly identifies various
+ * file types.
+ */
+#define _GNU_SOURCE
+
+#include <sys/types.h>
+#include <sys/stat.h>
+#include <sys/sysmacros.h>
+#include <fcntl.h>
+
+#include "tst_test.h"
+
+#define MOUNT_PATH	"test_mnt"
+#define REG_FILE	"regfile"
+#define DIR_FILE	"dirfile"
+#define FIFO_FILE	"fifofile"
+#define CHR_DEV	MOUNT_PATH "/chrdev"
+#define BLK_DEV	MOUNT_PATH "/blkdev"
+
+static struct tcase {
+	const char *path;
+	mode_t exp_type;
+} tcases[] = {
+	{ REG_FILE,	S_IFREG },
+	{ DIR_FILE,	S_IFDIR },
+	{ FIFO_FILE,	S_IFIFO },
+	{ CHR_DEV,	S_IFCHR },
+	{ BLK_DEV,	S_IFBLK },
+};
+
+static void verify_fstat(unsigned int i)
+{
+	struct tcase *tc = &tcases[i];
+	struct stat buf;
+
+	int flags = O_PATH;
+
+	if (tc->exp_type == S_IFDIR)
+		flags |= O_DIRECTORY;
+
+	int fd = SAFE_OPEN(tc->path, flags);
+
+	SAFE_FSTAT(fd, &buf);
+	SAFE_CLOSE(fd);
+
+	switch (tc->exp_type) {
+	case S_IFREG:
+		TST_EXP_EXPR(S_ISREG(buf.st_mode));
+		break;
+	case S_IFDIR:
+		TST_EXP_EXPR(S_ISDIR(buf.st_mode));
+		break;
+	case S_IFIFO:
+		TST_EXP_EXPR(S_ISFIFO(buf.st_mode));
+		break;
+	case S_IFCHR:
+		TST_EXP_EXPR(S_ISCHR(buf.st_mode));
+		break;
+	case S_IFBLK:
+		TST_EXP_EXPR(S_ISBLK(buf.st_mode));
+		break;
+	}
+}
+
+static void setup(void)
+{
+	SAFE_TOUCH(REG_FILE, 0644, NULL);
+	SAFE_MKDIR(DIR_FILE, 0755);
+
+	SAFE_MKNOD(FIFO_FILE, S_IFIFO | 0777, 0);
+	SAFE_MKNOD(CHR_DEV, S_IFCHR | 0777, makedev(1, 3));
+	SAFE_MKNOD(BLK_DEV, S_IFBLK | 0777, makedev(7, 3));
+}
+
+static void cleanup(void)
+{
+	if (!access(REG_FILE, F_OK))
+		SAFE_UNLINK(REG_FILE);
+
+	if (!access(DIR_FILE,  F_OK))
+		SAFE_RMDIR(DIR_FILE);
+
+	if (!access(FIFO_FILE, F_OK))
+		SAFE_UNLINK(FIFO_FILE);
+
+	if (!access(CHR_DEV, F_OK))
+		SAFE_UNLINK(CHR_DEV);
+
+	if (!access(BLK_DEV, F_OK))
+		SAFE_UNLINK(BLK_DEV);
+}
+
+static struct tst_test test = {
+	.tcnt = ARRAY_SIZE(tcases),
+	.setup = setup,
+	.cleanup = cleanup,
+	.test = verify_fstat,
+	.mntpoint = MOUNT_PATH,
+	.needs_devfs = 1,
+	.needs_tmpdir = 1,
+	.needs_root = 1,
+};
--
2.43.0

-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
