Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9F3D8D58B11
	for <ltp@archiver.kernel.org>; Sun, 15 Mar 2026 07:28:26 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 2A4BB3E1B38
	for <ltp@archiver.kernel.org>; Sun, 15 Mar 2026 08:28:24 +0100 (CET)
Received: from in-7.smtp.seeweb.it (in-7.smtp.seeweb.it
 [IPv6:2001:4b78:1:20::7])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1) server-digest SHA384)
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 398DC3C054A
 for <ltp@lists.linux.it>; Sun, 15 Mar 2026 08:27:47 +0100 (CET)
Received: from mail-pj1-x1044.google.com (mail-pj1-x1044.google.com
 [IPv6:2607:f8b0:4864:20::1044])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-7.smtp.seeweb.it (Postfix) with ESMTPS id B4FEF2001C6
 for <ltp@lists.linux.it>; Sun, 15 Mar 2026 08:27:46 +0100 (CET)
Received: by mail-pj1-x1044.google.com with SMTP id
 98e67ed59e1d1-35b95a7444bso233805a91.1
 for <ltp@lists.linux.it>; Sun, 15 Mar 2026 00:27:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1773559665; x=1774164465; darn=lists.linux.it;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=hXVV4zNViC1GCye8sNKjIAnDgbK7OMx5S0Xrcpj/iO0=;
 b=AWDoga/ORAYfl7I2rXdj9c5uC8EZ7OeAzTa6/+d3E7lWgqtdMnRSCWtF7QAGUicySW
 TDjWWYtkbodNn9wrNGDWSrL6eKOyab9ZuG28YRKVeZtYgY3FTIgxrm1gceAJDnmDj9q7
 KPd/UBbkG2Ow7f/hsWs1fvz3ThYBVwVrzIdzFP48HsQY5Ws5zzYL0bwBgQC82g+GgrQN
 qEA4+xTujvIbVkLtc+P5Sj++ThTXeTnt2XpTc9iian64XCASNgLlpLja5MzQl53o9e/6
 hMrGGwU6MjnZs5or0oieJ417EQXmLfpmzxrMolb0cJwxktoAUf+WuryFVIoYgj1LSsbj
 vxPw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1773559665; x=1774164465;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=hXVV4zNViC1GCye8sNKjIAnDgbK7OMx5S0Xrcpj/iO0=;
 b=jGvfklbSd+9a+5P4obc8hAyuqhkR2ntKWpd4oVVjcwEDkOB8Wjyx18JKjGTMMA8V5U
 B9/c8QZrtFMDB7PgMzEGAnVbna59bSucNhx8T5Z6bXp4fZH8hzVh+lZ+jWhcaC0VTbqR
 FPNFEkAlCOfwy+y8HnXuCRtsL7MGjR/iubFjEqIPTwL+/PkQOA2rxKdWGVqm1KUzoa6h
 ctX02+fhBHHtHQ4y06ZY8S5dm5GJta0G7v+HkPGqXfoiqFP/eSa3uHgMsdI5WulGYeiL
 mIGerad0yemGfPGOw0yYwAV2BHzCbJ1AYnMSt5sDlmtNlZYZyZ06Jw4jLrI1MtiELMjS
 jEDA==
X-Gm-Message-State: AOJu0YwtzmtcTRixW/AayjNAy7rNtivxlLC1sAc67eRKv7TKzX3n4c/V
 deCMASNexe8RDFB2KWAiYaHtsMz0FFOuMxy3piBtwOf96+J51daoBR8=
X-Gm-Gg: ATEYQzwn7l+Iy7eqmcJKUnG84bJBY906R/7WDm8mw1Uyoj4EF5LDBTyiS/lPJoeps24
 9HHBZ76jvzDJMGuPIvYz++7itC0g5wDrypMNVKk9RrAuAAkzba9B0J7QyE1xKfxLRosgvtfHSSE
 wDllztiWgR8m9RyB7IarI+aJXX1oNL9SzPPNOSABOt7xrLMvPMSeZJIHe/eTgu7MNdJ5i4ShmW5
 uG0klzf7bT+GI+Jvz4i9I80+3VrgD0Q9S10vWuX4MwcokpavSUPog2N2BevGRTzoWxIMEO/FgGV
 pLbWcKleMmkrjOS+aLHC6/pVYlO+P9dcfU0sQoJM88IKtVwklJg8ksmltgspyrPRjveGBccI5R2
 AYEn1nVv81D0P6XjQnauIqPR8tYIejVmhcfxwOMBArtLK/ZmFI8LIP5gI/Ay5QNdKe5vF63JLhw
 UxuJHDCLsjcdzDyWameUwLWq39hkRopr8N/OGnEIstDA==
X-Received: by 2002:a17:90b:394f:b0:340:25f0:a9b with SMTP id
 98e67ed59e1d1-35a220aae41mr7171826a91.33.1773559664958; 
 Sun, 15 Mar 2026 00:27:44 -0700 (PDT)
Received: from localhost.localdomain ([59.16.109.172])
 by smtp.gmail.com with ESMTPSA id
 41be03b00d2f7-c73eb8ade35sm5755970a12.0.2026.03.15.00.27.43
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sun, 15 Mar 2026 00:27:44 -0700 (PDT)
From: Jinseok Kim <always.starving0@gmail.com>
To: andrea.cervesato@suse.com
Date: Sun, 15 Mar 2026 16:27:16 +0900
Message-ID: <20260315072721.2083-2-always.starving0@gmail.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260315072721.2083-1-always.starving0@gmail.com>
References: <69b42eee.050a0220.281abf.2706@mx.google.com>
 <20260315072721.2083-1-always.starving0@gmail.com>
MIME-Version: 1.0
X-Virus-Scanned: clamav-milter 1.0.9 at in-7.smtp.seeweb.it
X-Virus-Status: Clean
Subject: [LTP] [PATCH v5 2/2] fstat: add test for multiple file types using
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
Cc: ltp@lists.linux.it
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: ltp-bounces+ltp=archiver.kernel.org@lists.linux.it
Sender: "ltp" <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>

Following review feedback, create a dedicated fstat test that verifies
S_ISREG(), S_ISDIR(), S_ISFIFO(), S_ISCHR(), S_ISBLK() on different file
types.

Signed-off-by: Jinseok Kim <always.starving0@gmail.com>
---
 runtest/syscalls                           |   2 +
 testcases/kernel/syscalls/fstat/.gitignore |   2 +
 testcases/kernel/syscalls/fstat/fstat04.c  | 106 +++++++++++++++++++++
 3 files changed, 110 insertions(+)
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
index 000000000..80e14fa7f
--- /dev/null
+++ b/testcases/kernel/syscalls/fstat/fstat04.c
@@ -0,0 +1,106 @@
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
+	case S_IFCHR:
+		TST_EXP_EXPR(S_ISCHR(buf.st_mode), "%s macro matches", tc->desc);
+		break;
+	case S_IFBLK:
+		TST_EXP_EXPR(S_ISBLK(buf.st_mode), "%s macro matches", tc->desc);
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
+	.needs_tmpdir = 1,
+	.needs_root = 1,
+};
+
--
2.43.0

-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
