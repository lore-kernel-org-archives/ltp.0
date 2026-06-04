Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 70267CD6E4A
	for <ltp@archiver.kernel.org>; Thu,  4 Jun 2026 14:21:27 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id AC17F3E605B
	for <ltp@archiver.kernel.org>; Thu,  4 Jun 2026 16:21:25 +0200 (CEST)
Received: from in-5.smtp.seeweb.it (in-5.smtp.seeweb.it
 [IPv6:2001:4b78:1:20::5])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1) server-digest SHA384)
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 1C1B43E6195
 for <ltp@lists.linux.it>; Thu,  4 Jun 2026 16:20:58 +0200 (CEST)
Received: from mail-pf1-x442.google.com (mail-pf1-x442.google.com
 [IPv6:2607:f8b0:4864:20::442])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-5.smtp.seeweb.it (Postfix) with ESMTPS id 0451D60056E
 for <ltp@lists.linux.it>; Thu,  4 Jun 2026 16:20:56 +0200 (CEST)
Received: by mail-pf1-x442.google.com with SMTP id
 d2e1a72fcca58-8421f0e9c5bso346866b3a.3
 for <ltp@lists.linux.it>; Thu, 04 Jun 2026 07:20:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1780582854; x=1781187654; darn=lists.linux.it;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
 :reply-to; bh=8wn52FT8P6TBqqwuGJvtnyN1hqDHh0yh794B2f8GLAU=;
 b=EZHkCbt8OCc+Qjbi6EzULndcSGQ+PGtR/m6N6Nwa+vQbo5UYApe/ZCuu1774QSGO0N
 Wualm8L2r7bY6ylUnsYlVQ9BHJvrf2QS9OUgN7Zrb2SG6j2XDvuEKww7LI/WeDzNyvS4
 oRAQdD0t07DAvON2DbT/mG4wwTbw7D6VNhj/YVKGLzjkcOkimIozs6CQNuqSwr6kjR7s
 fhg0sDRRPipDeVlD/K0C6wQPqZyU44mszzKYMrrxh8fxDsz5Dj49gSeRbYy3Kr6EA4GW
 zLuF8qSuSC6oGaUjuyZrDzGm0GyRqh/YpCfYpY7oBbAIPqMt9plzWRQ3zlO3j2HLxmZ8
 0BzQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1780582854; x=1781187654;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:x-gm-gg:x-gm-message-state:from:to
 :cc:subject:date:message-id:reply-to;
 bh=8wn52FT8P6TBqqwuGJvtnyN1hqDHh0yh794B2f8GLAU=;
 b=RB4PpvVJVvV/llnrtqrRN90lBfok0YHFEbjsw6Y0t2+p/xuuNF0VC16oxl++AjEn+G
 ANWO7yOuaLRzM2yvCXtBj5FJ7+7xZSU5qkwQdM1X791m6lmeATy87G5Ec6kIVuS3E3/5
 9t8dkvT+5Un+QHNDVkKuZQSNWhpRHThQKhvQDclkxqKYpeWzivGrutMrtGdBCuZOdnnr
 FJihiViBfG5YUk4jCBsvxoZAaYut5blwjlboEQ+GotCzAJNlA0/+N86+EKI3zUDwJ5xA
 q0BYxyKG+AuvdIOBYn4lM6IMhrJc9+vuS0TVojGsm7ifzuTjDZIKWL1UaFGYvFjuMw2V
 WBMA==
X-Gm-Message-State: AOJu0Yz7fsqWww6L1mVh4Sojk6CPoEnr4buKDiu1GgsuRecAu7FUiMWD
 PN4igGyvLoEI478es8T5grAHDBgFOOjrq7NKB0TAvZad63flzuDSfIoWWa5AhucJhg==
X-Gm-Gg: Acq92OEuDItoU1JgAdj33YB72DHKNZw//jNKUSXUfhJH+pVfH1sBqA/FPuQklTaBtnm
 vr6KPmudLeaX1ych2AWJgy7GtdvWQAdnRmumpO5uWYMCJ4deJ0zhLl8ooLBCJ9yBMNtM7luKyFo
 uEyVCyvUNAIoie9HbyAx8610vVpB221SIB33Scn2emH0sRaVphW3A8wpVY6Lr0sSf0gW9QdCKhC
 We53mf7S0vnqIGfmeLskg13lxQ4BdTdEbhi0VAc6fRTwJi8vvuaNmm7m1U3J01XoBKNxdPJcmtY
 maUn2JbWwD6jq61fwl/LYipB6KyKaBkg0QUi0ikSotn7MgIqadf+KUBrT1Islrb7TOYCz9zqdbb
 lii2OY98icRXJYN1jB7A+J8p5/sech4uJ4t04+VFv/9auMNsRNbtfPFS1K6nS4g1Mz0WUusfXQc
 dEZdF2AFQ7hlXtdvvNaf+b7ZqiWYOjxvXBbZ01e8g20k4vCbYVV/MAATo=
X-Received: by 2002:a05:6a00:94d5:b0:842:5a8d:302c with SMTP id
 d2e1a72fcca58-84284fd2f60mr8340510b3a.38.1780582854247; 
 Thu, 04 Jun 2026 07:20:54 -0700 (PDT)
Received: from localhost.localdomain ([211.196.223.197])
 by smtp.gmail.com with ESMTPSA id
 d2e1a72fcca58-84282916b10sm6464018b3a.58.2026.06.04.07.20.53
 for <ltp@lists.linux.it>
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 04 Jun 2026 07:20:53 -0700 (PDT)
From: Jinseok Kim <always.starving0@gmail.com>
To: ltp@lists.linux.it
Date: Thu,  4 Jun 2026 23:20:27 +0900
Message-ID: <20260604142029.2077-2-always.starving0@gmail.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260604142029.2077-1-always.starving0@gmail.com>
References: <20260604142029.2077-1-always.starving0@gmail.com>
MIME-Version: 1.0
X-Virus-Scanned: clamav-milter 1.0.9 at in-5.smtp.seeweb.it
X-Virus-Status: Clean
Subject: [LTP] [PATCH v8 2/2] fstat: add test for multiple file types using
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
Changes in v8:
- Link to the man page
- Remove desc from tcase and TST_EXP_EXPR
- Link to v7: https://lore.kernel.org/ltp/20260327152751.3637-1-always.starving0@gmail.com
---
 runtest/syscalls                           |   2 +
 testcases/kernel/syscalls/fstat/.gitignore |   2 +
 testcases/kernel/syscalls/fstat/fstat04.c  | 103 +++++++++++++++++++++
 3 files changed, 107 insertions(+)
 create mode 100644 testcases/kernel/syscalls/fstat/fstat04.c

diff --git a/runtest/syscalls b/runtest/syscalls
index f790e8f84..d420df905 100644
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
index 000000000..b7af04002
--- /dev/null
+++ b/testcases/kernel/syscalls/fstat/fstat04.c
@@ -0,0 +1,103 @@
+// SPDX-License-Identifier: GPL-2.0-or-later
+/*
+ * Copyright (C) 2026 Jinseok Kim <always.starving0@gmail.com>
+ */
+/*\
+ * Verify that :manpage:`fstat(2)` correctly identifies various
+ * file types.
+ */
+#include <sys/types.h>
+#include <sys/stat.h>
+#include <sys/sysmacros.h>
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
+	int flags = O_RDONLY | O_NONBLOCK;
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
