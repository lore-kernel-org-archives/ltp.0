Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D24B4C53200
	for <ltp@archiver.kernel.org>; Wed, 29 Jul 2026 14:34:04 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 6118E3E7293
	for <ltp@archiver.kernel.org>; Wed, 29 Jul 2026 16:34:03 +0200 (CEST)
Received: from in-2.smtp.seeweb.it (in-2.smtp.seeweb.it [217.194.8.2])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id E70823E4B5C
 for <ltp@lists.linux.it>; Wed, 29 Jul 2026 16:33:16 +0200 (CEST)
Received: from mail-pz2-x00.google.com (mail-pz2-x00.google.com
 [IPv6:2607:f8b0:4864:3b::])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-2.smtp.seeweb.it (Postfix) with ESMTPS id 4ECAC60082D
 for <ltp@lists.linux.it>; Wed, 29 Jul 2026 16:33:16 +0200 (CEST)
Received: by mail-pz2-x00.google.com with SMTP id
 41be03b00d2f7-c96739a46acso484791a12.1
 for <ltp@lists.linux.it>; Wed, 29 Jul 2026 07:33:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1785335595; x=1785940395; darn=lists.linux.it;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
 :reply-to:content-type;
 bh=jiXGYGCXO7h7EeCM2MuTzzyRyTf1MJJh0ciC6MGz7N0=;
 b=DCqpb+s551aUmvm5SodSlUwVtWW5tZQYg61j9xDasnUQ2c/7dkFowFt40arOFzWU2H
 80DPeEH42x6SfDzSM9tc2d55xFoDaHR+Ui9+p7O5R4ZBlAEoSkjfeZ7XxQprRRti3lqX
 C7rXNbYjxtlyQrwc4eDGLCVXKgmqzPSHg/mBg9EHiixhpagOyQNbvLJwo0jPJut6x31I
 rO9sek+Z+pO7rgS37Lu1diDq/Xl/cS56Y4qzifqYKlcz6Y3/7oDo5n1mG27NT99UhEka
 tmRhtksk7pMtAm5jI2bcn6j0Me378GQTNxvF3iyE12GwwkwYj5l6rPs5/jR5H62pHyLY
 sm8w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1785335595; x=1785940395;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:x-gm-gg:x-gm-message-state:from:to
 :cc:subject:date:message-id:reply-to:content-type;
 bh=jiXGYGCXO7h7EeCM2MuTzzyRyTf1MJJh0ciC6MGz7N0=;
 b=c3AZEwqmec6nlaN54za4i15RmDBDHwkpSZm4nySYrFgGUlB2CzctX6rUclwa1RX2yd
 wk71un3UKagjPbgUdSV4iJv0BKG1FXi5uzZohJQTVCqhy5NhQD/kpxXkFn7mRXu72c8Y
 c6Kxz0i7YQJ7+vqamgBEJ+R6GSMgO2F7UJPe/4EpOUT8bccans6LozgV3pP2ExHV5VdN
 vafgXC3tq1WgTRaC3JfRszKyacaD9Zy9HlNDoQeCe+/ITNsh3CS6XWNbgKr8OZc9/uvc
 wRiNkRl3GdwP2VfJ/NAQcWMLy0UMyK34Re8LaK3a2gF3D/6eka1hgL8+GKEfT46JfZOu
 gQag==
X-Gm-Message-State: AOJu0YwlZmBmCy8BpL9Oobsf2+0WOfBhgHRzupSUULoM4FfL1Udw7EGx
 VfZe1lsOZrOQEirvK8zqg2GymvJjYBJDpsgtNuMBrzNItIzsVEkMcaDk3s2nwN+EMOZR
X-Gm-Gg: AR+sD12psXNPyGeWxe9xwW+KJ1bXhaMeIpSM2Yif1OheAwtO3AmBcDXnCYld7kAZMA4
 TjFAioeLyUEUDoJz+UDqzhP8/2KQMs+Qg+pWSSBYOWH+DBlRiB7wl5iTqi8JWFZZhJh+G8ivtbf
 9cQ+lP5X5k1NkpHi+Kh+puulw9NGmIzsYQZZ9kS2tpzIqf0WcyfuPf9yX3oN0oKcVpGOztjmpiW
 Dn70zE70I0eYFzz+rfMRBgt/3AtfQvVXebQ7nxTZEcpxA6kRw5qoaeatceGPHpPmd/yZbEHnPQH
 7Yheb+fxXXZSF/g7Uyr37vWR9ww6HYLfgg9/ER9BYXhmn/ej2XUokpaMtEvrLoVWfq6WB2X285G
 6JDELWstO8PcEgXdbSiqjrr2Ynl1Rqawtz4mSSup3v/b4h5MGlliNCwcpIbhqJkEnJ1vRmKhGen
 /CeUXq1khIPmKMPCW+7eCmQTKXtxjCSt4G43j7Ru6oeCsNRnoAZVCNZLPi9QU4m+00NO9a0dgFn
 OGbRN8=
X-Received: by 2002:a05:6a00:21cb:b0:848:4fd9:9a8f with SMTP id
 d2e1a72fcca58-84e9330a6f8mr6939186b3a.77.1785335594413; 
 Wed, 29 Jul 2026 07:33:14 -0700 (PDT)
Received: from localhost.localdomain ([59.16.109.172])
 by smtp.gmail.com with ESMTPSA id
 41be03b00d2f7-cbdba63c743sm1008323a12.26.2026.07.29.07.33.13
 for <ltp@lists.linux.it>
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 29 Jul 2026 07:33:13 -0700 (PDT)
From: Jinseok Kim <always.starving0@gmail.com>
To: ltp@lists.linux.it
Date: Wed, 29 Jul 2026 23:32:03 +0900
Message-ID: <20260729143243.8433-3-always.starving0@gmail.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260729143243.8433-1-always.starving0@gmail.com>
References: <20260729143243.8433-1-always.starving0@gmail.com>
MIME-Version: 1.0
X-Virus-Scanned: clamav-milter 1.0.9 at in-2.smtp.seeweb.it
X-Virus-Status: Clean
Subject: [LTP] [PATCH v10 3/3] fstat: add test for multiple file types using
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
that fstat() correctly identifies regular files, directories, FIFOs,
character devices, and block devices.

Signed-off-by: Jinseok Kim <always.starving0@gmail.com>
---
Changes in v10:
- Document why root privileges are required.
- Replace the S_IS*() switch with a single S_IFMT comparison.
- Link to v9: https://lore.kernel.org/ltp/20260621090403.2236-2-always.starving0@gmail.com

Changes in v9:
- Open test files with O_PATH to avoid unnecessary device access
- Link to v8: https://lore.kernel.org/ltp/20260604142029.2077-2-always.starving0@gmail.com

Changes in v8:
- Link to the man page
- Remove desc from tcase and TST_EXP_EXPR
- Link to v7: https://lore.kernel.org/ltp/20260327152751.3637-1-always.starving0@gmail.com
---
 runtest/syscalls                           |  2 +
 testcases/kernel/syscalls/fstat/.gitignore |  2 +
 testcases/kernel/syscalls/fstat/fstat04.c  | 94 ++++++++++++++++++++++
 3 files changed, 98 insertions(+)
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
index 000000000..c9a83989b
--- /dev/null
+++ b/testcases/kernel/syscalls/fstat/fstat04.c
@@ -0,0 +1,94 @@
+// SPDX-License-Identifier: GPL-2.0-or-later
+/*
+ * Copyright (C) 2026 Jinseok Kim <always.starving0@gmail.com>
+ */
+/*\
+ * Verify that :manpage:`fstat(2)` correctly identifies various
+ * file types.
+ *
+ * Root privileges are required to create character and block device nodes.
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
+	int fd;
+
+	if (tc->exp_type == S_IFDIR)
+		flags |= O_DIRECTORY;
+
+	fd = SAFE_OPEN(tc->path, flags);
+
+	SAFE_FSTAT(fd, &buf);
+	SAFE_CLOSE(fd);
+
+	TST_EXP_EXPR((buf.st_mode & S_IFMT) == tc->exp_type, "checking %s", tc->path);
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
