Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 31C01FD375E
	for <ltp@archiver.kernel.org>; Wed, 25 Feb 2026 13:20:27 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id C0BC83C7F9F
	for <ltp@archiver.kernel.org>; Wed, 25 Feb 2026 14:20:25 +0100 (CET)
Received: from in-6.smtp.seeweb.it (in-6.smtp.seeweb.it [217.194.8.6])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 8386C3C5398
 for <ltp@lists.linux.it>; Wed, 25 Feb 2026 14:19:48 +0100 (CET)
Received: from mail-pl1-x642.google.com (mail-pl1-x642.google.com
 [IPv6:2607:f8b0:4864:20::642])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-6.smtp.seeweb.it (Postfix) with ESMTPS id 22C4314004E5
 for <ltp@lists.linux.it>; Wed, 25 Feb 2026 14:19:48 +0100 (CET)
Received: by mail-pl1-x642.google.com with SMTP id
 d9443c01a7336-2aaed195901so31558715ad.0
 for <ltp@lists.linux.it>; Wed, 25 Feb 2026 05:19:48 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1772025586; x=1772630386; darn=lists.linux.it;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=/N5xBLtZ+SJYb66fuR/8Y4rjsU3jqfQKf83mLM2rc2Q=;
 b=HWBZI3GkB5CAIKmR55TfAlGMGTwmyzxbu6oEBt9MOnTCJYs/LlV3VsR2VQBF3l4+AZ
 og3QbMP+GSO6ml6n/nU/byClhNxaN03wJIXBxc2qVIhZagLa/AyJ4uDSySQFk8EKe57I
 siXlT7YUe+x979WSH8G2gHdbgHr5vK42SCMMygYd6k+U7dOptSsIN7zSFBDkE2WFWGBp
 B1d0Kob4RCgKNRMmbgkd64NqjTRYXu0pQkAw6tH8IPRiAkbipj+Hh0nBi/pXreOxrBw1
 2BU7W27L4gOqWCfFGlCBQ6MbNZqw7vQ3g6XTYas3snuBlqOkrcmd+hKqLP1VzNP3Fn70
 pheA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1772025586; x=1772630386;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=/N5xBLtZ+SJYb66fuR/8Y4rjsU3jqfQKf83mLM2rc2Q=;
 b=dhKPp2ECC17AnfsuFbADq8zH2LrcNPuKa6dTCGuDPHTxl0X2zb/uCIYr3SH5SDow7w
 VDRT2xbu0Ro2JtTCrk/CjsaKVWDzQS1eRVS/jHYvpwNiCGj8uajeU+71Ls9zuVSH302B
 VuKGjtJrMkIbgZsfMElsBiJIq8B7JXAGDzc3oyV77TCGxT+wGdclRNcY+d3xb9f9VbBv
 Wj0nlMVBmWUTW84l4sP3fwF2GCdvX4L2bB7LQjgTFvprbiulPmXEEpVWY8cSSwE7aO6M
 68sEdKtZFNrYUuoDOouISK5K9zDPg8/JeixyOlYyCtmzCGfaWLqeJg5pI51zjzmpKyDd
 Iqmw==
X-Gm-Message-State: AOJu0YyMwHALHEFsSCVQgGRX5rTTsUGSiJKO28Uq18xg4n0QsCo1ETw6
 mKoh57DoFYfd3ntO07sQ7/fj5ALZ6nf5QNNn5bJ6z5ii2ftBlNVfmAGsq+Vp6FVp+Q==
X-Gm-Gg: ATEYQzxHdYyDNhQGvlfrpgddYtS+fXsPQgxrJXijLSX8HOwV9byPmreaouL7fdbGrIn
 qYpETFVNpbuEvU80V5GS2FesQtTQLTVUmMQ7ujdUjTSXDRukWg00OFC3p3c1fDoa/SPGowkNe+F
 QlfW1lsMfCUjB9GaInZn1quFmOqXM22hGnBmhXv3aOkzrBvIFc1fgt9oH6OOYrtvSg71NooMLcn
 o3p3pOUU4oMjVhxuCDplg2wpisha3oEpe482dwJqIc76DVmFJ+c8kq2GqOF18UKYe0eVZ2abmtN
 w0Sqj3z/nr7dYE9/GPk8PWowLDyoKZRsunkskGivqeF2ZEfOtqIYYsuY/ogpwGn6TXb167sbfNm
 iIbBpYAVF+/KOR+qKDbRfhOxa5df0jsPbbSdPlCZw3VOpWVcZ+L7YbkTtcoM/0xAEkXG5ZcYA5a
 lkLwBuTcvpEHWGei3Wa0xRu/imO1Zl193UrTohASbi4HhQwyc9bwjh
X-Received: by 2002:a17:903:1b6f:b0:2aa:d672:3be with SMTP id
 d9443c01a7336-2ad74595c07mr166592325ad.52.1772025586188; 
 Wed, 25 Feb 2026 05:19:46 -0800 (PST)
Received: from localhost.localdomain ([59.16.109.172])
 by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-2ad75029f11sm136682645ad.69.2026.02.25.05.19.45
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 25 Feb 2026 05:19:45 -0800 (PST)
From: Jinseok Kim <always.starving0@gmail.com>
To: ltp@lists.linux.it
Date: Wed, 25 Feb 2026 22:19:19 +0900
Message-ID: <20260225131922.5723-2-always.starving0@gmail.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260225131922.5723-1-always.starving0@gmail.com>
References: <DGN98XP7WAZD.310XXFFOA9X2R@suse.com>
 <20260225131922.5723-1-always.starving0@gmail.com>
MIME-Version: 1.0
X-Virus-Scanned: clamav-milter 1.0.9 at in-6.smtp.seeweb.it
X-Virus-Status: Clean
Subject: [LTP] [PATCH v3 2/2] fstat: add test for multiple file types using
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
 testcases/kernel/syscalls/fstat/fstat04.c  | 121 +++++++++++++++++++++
 3 files changed, 125 insertions(+)
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
index 000000000..97d0d6f50
--- /dev/null
+++ b/testcases/kernel/syscalls/fstat/fstat04.c
@@ -0,0 +1,121 @@
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
+static int fd = -1;
+
+static struct tcase {
+	const char *desc;
+	const char *path;
+	const char *macro_name;
+	mode_t exp_type;
+} tcases[] = {
+	{ "regular file",   REG_FILE,  "S_IFREG", S_IFREG },
+	{ "directory",      DIR_FILE,  "S_IFDIR", S_IFDIR },
+	{ "FIFO (pipe)",    FIFO_FILE, "S_IFIFO", S_IFIFO },
+	{ "symbolic link",  SYMLINK,   "S_IFLNK", S_IFLNK },
+	{ "character dev",  CHR_DEV,   "S_IFCHR", S_IFCHR },
+	{ "block dev",      BLK_DEV,   "S_IFBLK", S_IFBLK },
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
+	fd = SAFE_OPEN(tc->path, flags);
+
+	SAFE_FSTAT(fd, &buf);
+	SAFE_CLOSE(fd);
+
+	int is_correct = 0;
+
+	switch (tc->exp_type) {
+	case S_IFREG:
+		is_correct = S_ISREG(buf.st_mode);
+		break;
+	case S_IFDIR:
+		is_correct = S_ISDIR(buf.st_mode);
+		break;
+	case S_IFIFO:
+		is_correct = S_ISFIFO(buf.st_mode);
+		break;
+	case S_IFLNK:
+		is_correct = S_ISLNK(buf.st_mode);
+		break;
+	case S_IFCHR:
+		is_correct = S_ISCHR(buf.st_mode);
+		break;
+	case S_IFBLK:
+		is_correct = S_ISBLK(buf.st_mode);
+		break;
+	}
+
+	if (is_correct)
+		tst_res(TPASS, "%s: %s() macro matches", tc->desc, tc->macro_name);
+	else
+		tst_res(TFAIL, "%s: %s() macro does NOT match", tc->desc, tc->macro_name);
+}
+
+static void setup(void)
+{
+	fd = SAFE_OPEN(REG_FILE, O_WRONLY | O_CREAT | O_TRUNC, 0644);
+	SAFE_CLOSE(fd);
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
--
2.43.0

-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
