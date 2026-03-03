Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 981B0EC1447
	for <ltp@archiver.kernel.org>; Tue,  3 Mar 2026 13:33:30 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 471153DA1BD
	for <ltp@archiver.kernel.org>; Tue,  3 Mar 2026 14:33:29 +0100 (CET)
Received: from in-5.smtp.seeweb.it (in-5.smtp.seeweb.it [217.194.8.5])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 1D00E3DA363
 for <ltp@lists.linux.it>; Tue,  3 Mar 2026 14:32:54 +0100 (CET)
Received: from mail-pl1-x642.google.com (mail-pl1-x642.google.com
 [IPv6:2607:f8b0:4864:20::642])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-5.smtp.seeweb.it (Postfix) with ESMTPS id 830A5600902
 for <ltp@lists.linux.it>; Tue,  3 Mar 2026 14:32:54 +0100 (CET)
Received: by mail-pl1-x642.google.com with SMTP id
 d9443c01a7336-2ab077e3f32so24860435ad.3
 for <ltp@lists.linux.it>; Tue, 03 Mar 2026 05:32:54 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1772544773; x=1773149573; darn=lists.linux.it;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
 :reply-to; bh=GR4NLaeKTTO3kA+1PyEuftDX9rO8loLhABPurzHOECo=;
 b=ZcLqj/raaUHRQ39j5mHhLKfV29AgO2XZ+0AgZe9ZRrSa2320b1i8vOvQzQoK0YZNAg
 SCkSYnig5LYz3m8ZqWYwU4UDg8nKdCiTVTVUWHXee0koJn5fu8+CbqIQIW5zui6UVOjN
 vO6LfIo2dF3LYEKJry6PIrOjfuqlZ1JTjF+M0wvvoMCKGH9VclIKxQtrlspXzPHrG4c5
 zhefP7DqOMS94tEH+m0crb6xGrk8Ip4C4fqCEUH2nELAiaDg75MSbO7lMk58h/wQKDS4
 rHJ8VeBFzNw6ABny/ZChWA/gzrkEhx+itfEKGeNzfLA90PZU/cPgbRsG7r46qqVQnJoY
 tbQw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1772544773; x=1773149573;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:x-gm-gg:x-gm-message-state:from:to
 :cc:subject:date:message-id:reply-to;
 bh=GR4NLaeKTTO3kA+1PyEuftDX9rO8loLhABPurzHOECo=;
 b=cp+1MEDj3/iK1vjhD6Lq/YWNPn6VG4Z7psfbWqvQlhhJStYzQj+cUVySgm68SGWhG6
 RdNE5r6kVV22bo++0OjQl8DktbZSl7WRx59kyNdLhyQok12PjeEBNZdjweKeJGAVGS7y
 uJTNEy3qW69+XtjI+JPebHaoqQbc2HXC3LD/1x+DAfyCRoIVXSjsUe9T6QnTDcDEZpY5
 Qa+Qo8fBx+fuSNyg71iHfSN7OjdzY3taCW6vJXFP8HM99MlKkAQCswBHP2atR2t/FJI9
 OS7n8NPGpIgyhKXb3jJW0GBSyl0E4G7yAgo5jlbvZCQFNiPF3GOAMmOQa7J9TfWo9s8z
 IO6Q==
X-Gm-Message-State: AOJu0YwJiytFAuUz6z3m4O4Lh5J3b7CKl5ixqda+EOAkpocEdQIpd9d+
 nWoq9/iHmDCRVAn3x2doBEOkMnfFn+W/8BFO/hCF82wSddEHmkHUeZzfUSfciVs=
X-Gm-Gg: ATEYQzymBLmNxhT03Pm6Ecwt40yVvBOigYEWRHuuPtIp3WZLAgBCJMfKDy9CLdWbQz+
 e9RsoxsDntvKaAfzeN2uuozvDcNT+alX3M2RQNe4XKGc2cTBY7LKv7rzqcmisNjsyCmhos4BV+r
 qVGV1DuCOMtc61RKo75NqkvLDrs2qrxbC1maIGLBf2dHqKDlqWLKfM9z7VYvMFOtLm6BMAw+1Y9
 crkQlxX570oTS20xDuCRg471ap1vKHCTDxcYfhyGi2e2Pztao8VvpYbihqLhLsrhyGXadvlV911
 DNN7CZIt0P6H1NLkGPpyDdeltzu0ps0yj/GjRNJioIftfoQVLoqzTxR3mG4CPBRgAcCXpDKJgBr
 BULNJ1IMMTOFxve66dc2Z1oeA1dsZV0xFU4RbeAxZ0FSz1ItcHq/+PDcwBzOqEt+hGYEznKkTKP
 AS6OPm8Ddu2DuIgMjUvA==
X-Received: by 2002:a17:903:1a4d:b0:2ae:5e23:1fa6 with SMTP id
 d9443c01a7336-2ae5e2320dcmr32480805ad.27.1772544772634; 
 Tue, 03 Mar 2026 05:32:52 -0800 (PST)
Received: from JS.lan ([171.3.84.26]) by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-2adfb69f9c2sm174400575ad.51.2026.03.03.05.32.51
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 03 Mar 2026 05:32:52 -0800 (PST)
From: Jinseok Kim <always.starving0@gmail.com>
To: ltp@lists.linux.it,
	andrea.cervesato@suse.com
Date: Tue,  3 Mar 2026 22:32:37 +0900
Message-ID: <20260303133243.66845-2-always.starving0@gmail.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260303133243.66845-1-always.starving0@gmail.com>
References: <DGP0CG3J3QK9.1M9KCELAS054F@suse.com>
 <20260303133243.66845-1-always.starving0@gmail.com>
MIME-Version: 1.0
X-Virus-Scanned: clamav-milter 1.0.9 at in-5.smtp.seeweb.it
X-Virus-Status: Clean
Subject: [LTP] [PATCH v4 2/2] fstat: add test for multiple file types using
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
S_ISREG(), S_ISDIR(), S_ISFIFO(), S_ISLNK(), S_ISCHR(), S_ISBLK()
on different file types.

Signed-off-by: Jinseok Kim <always.starving0@gmail.com>
---
 runtest/syscalls                           |   2 +
 testcases/kernel/syscalls/fstat/.gitignore |   2 +
 testcases/kernel/syscalls/fstat/fstat04.c  | 119 +++++++++++++++++++++
 3 files changed, 123 insertions(+)
 create mode 100644 testcases/kernel/syscalls/fstat/fstat04.c

diff --git a/runtest/syscalls b/runtest/syscalls
index 05bb3ceb1..5b34e6bdc 100644
--- a/runtest/syscalls
+++ b/runtest/syscalls
@@ -435,6 +435,8 @@ fstat02 fstat02
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
index 000000000..a7f2302f6
--- /dev/null
+++ b/testcases/kernel/syscalls/fstat/fstat04.c
@@ -0,0 +1,119 @@
+// SPDX-License-Identifier: GPL-2.0-or-later
+/*
+ * Copyright (C) 2026 Jinseok Kim <always.starving0@gmail.com>
+ */
+/*\
+ * Verify that fstat correctly identifies various file types
+ */
+#include <sys/types.h>
+#include <sys/stat.h>
+#include <sys/sysmacros.h>
+#include "tst_test.h"
+
+#define REG_FILE    "regfile"
+#define DIR_FILE    "dirfile"
+#define FIFO_FILE   "fifofile"
+#define SYMLINK     "symlink"
+#define CHR_DEV     "chrdev"
+#define BLK_DEV     "blkdev"
+
+static struct tcase {
+	const char *desc;
+	const char *path;
+	mode_t exp_type;
+} tcases[] = {
+	{ "S_IFREG",	REG_FILE,	S_IFREG },
+	{ "S_IFDIR",	DIR_FILE,	S_IFDIR },
+	{ "S_IFIFO",	FIFO_FILE,	S_IFIFO },
+	{ "S_IFLNK",	SYMLINK,	S_IFLNK },
+	{ "S_IFCHR",	CHR_DEV,	S_IFCHR },
+	{ "S_IFBLK",	BLK_DEV,	S_IFBLK },
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
+	int fd = open(tc->path, flags);
+
+	if (fd < 0) {
+		tst_res(TCONF | TERRNO, "cannot open %s, skipping", tc->desc);
+		return;
+	}
+
+	SAFE_FSTAT(fd, &buf);
+	SAFE_CLOSE(fd);
+
+	switch (tc->exp_type) {
+	case S_IFREG:
+		TST_EXP_EXPR(S_ISREG(buf.st_mode), "%s macro matches", tc->desc);
+		break;
+	case S_IFDIR:
+		TST_EXP_EXPR(S_ISDIR(buf.st_mode), "%s macro matches", tc->desc);
+		break;
+	case S_IFIFO:
+		TST_EXP_EXPR(S_ISFIFO(buf.st_mode), "%s macro matches", tc->desc);
+		break;
+	case S_IFLNK:
+		tst_res(TCONF, "Symbolic Link not available in this environment");
+		break;
+	case S_IFCHR:
+		TST_EXP_EXPR(S_ISCHR(buf.st_mode), "%s macro matches", tc->desc);
+		break;
+	case S_IFBLK:
+		if (S_ISBLK(buf.st_mode))
+			tst_res(TPASS, "%s macro matches", tc->desc);
+		else
+			tst_res(TCONF, "Block device not available in this environment");
+		break;
+	}
+}
+
+static void setup(void)
+{
+	SAFE_TOUCH(REG_FILE, 0644, NULL);
+
+	SAFE_MKDIR(DIR_FILE, 0755);
+	SAFE_SYMLINK(REG_FILE, SYMLINK);
+
+	SAFE_MKNOD(FIFO_FILE, S_IFIFO | 0777, 0);
+	SAFE_MKNOD(CHR_DEV, S_IFCHR | 0777, makedev(1, 3));
+	SAFE_MKNOD(BLK_DEV, S_IFBLK | 0777, makedev(7, 3));
+}
+
+static void cleanup(void)
+{
+	if (!access(SYMLINK, F_OK))
+		SAFE_UNLINK(SYMLINK);
+
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
+	.needs_tmpdir = 1,
+	.needs_root = 1,
+};
+
--
2.43.0

-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
