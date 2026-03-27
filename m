Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E69E110F2842
	for <ltp@archiver.kernel.org>; Fri, 27 Mar 2026 15:28:38 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 8C7113D00CB
	for <ltp@archiver.kernel.org>; Fri, 27 Mar 2026 16:28:37 +0100 (CET)
Received: from in-5.smtp.seeweb.it (in-5.smtp.seeweb.it [217.194.8.5])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 5DA493C9D7D
 for <ltp@lists.linux.it>; Fri, 27 Mar 2026 16:28:18 +0100 (CET)
Received: from mail-pl1-x641.google.com (mail-pl1-x641.google.com
 [IPv6:2607:f8b0:4864:20::641])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-5.smtp.seeweb.it (Postfix) with ESMTPS id E5C2A600D76
 for <ltp@lists.linux.it>; Fri, 27 Mar 2026 16:28:17 +0100 (CET)
Received: by mail-pl1-x641.google.com with SMTP id
 d9443c01a7336-2aecefc7503so15971875ad.1
 for <ltp@lists.linux.it>; Fri, 27 Mar 2026 08:28:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1774625296; x=1775230096; darn=lists.linux.it;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=iTbAdyc9DzFmAEM9DnZCVqRXnRZRZWoyjDS9NNP2DcE=;
 b=sX5Acsaz50c+/f6VSqP+RaerePvBNbx0eBlUku3tQ87z6WrybQQOywLc+CYfxr25D2
 QYB6oOeKRVdIiV/g9I7K0MJvr3zNp4AhRktqlc0Z8Rngk/ypTmUOSSQE5h2E9tONdoCC
 hjBJU31lcLVodT9Tc/pJEGvMfmDzY5JIeQqE2UVWda6YeMHiufMBNoO09skjLH9rS7D3
 QdUT52z6oj/TkI4E5AILBmyCLRjLfQdQZI87Nf8QSMDzPzW0ARsyu0bZ+//2w/R8ios+
 b+B6URpdMJO6kLQOJ+8XD87rHw8yVWl3yBPLnpzUOQp/Rt1czuvyU1GXYoQf/+A3KqFJ
 wWvw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1774625296; x=1775230096;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=iTbAdyc9DzFmAEM9DnZCVqRXnRZRZWoyjDS9NNP2DcE=;
 b=PPrv/Z33n9u5/aCy0+naxgJ8G7Mo7mzWc3dSiHLbOHodmV92RPCJqKAh2huhZh5Hg7
 lfggh5GQFnXlBFWNhp4o41+Gf+8WlC2iEl+iViU7FRatzMVBl1hyVnlBQKjvnp5REbqc
 92lwV7nH0z9DxbcGcDypQ1OrIfGm5beGks2Ryk7nLrarMOZFF9iznGE3aVeoMDrXFN2V
 ohrIDOP2iUv24TgNjWVHYH3zWA5BYNRM9qVWmu+/2gB2gVuC+8+RCDtCI7kQDksoVWM4
 V++yJgAZURzdIfk3Ohb5xrChiwn2jQhfTOQLtFA0mTI1j9Y4/kwTaz/yeoYnj5N7qjcc
 usyg==
X-Gm-Message-State: AOJu0YwB3UFCdBXx+DmajQ1yvTpRBjV9wYXYgpAhFzAa02EQGXqCX64F
 Tlb56reoE37ek/6i/F+gqVD6mGPQ0HNspp4Gu942qX9TDA/xq5a8etmSLAzshT3KUQ==
X-Gm-Gg: ATEYQzwtZGNYfAb/1+9YrjHWg2PaUqORnsAbcVRMJ2lCCZUILFdfZAufBHyXZy0T/Ly
 +jE1oH7B0BnsG+XZRQ9TOasZHGewTdiY0Yj6ML9C0o793huX0BSZPDzJVejAT3Rb/GP4jPqgcYl
 K83Tlz86puXWWxg2VFWqeoX6TWn+I3AWJmtmdAUrx9NAibhmKNkHy2Q2frVLFygpp2BaKPokNwW
 7Cn5Xo7Pv1yOM/WPCf60VdoKI2wQ9v4O095W+ICYarUMFHw8a3PeUtV5bkMfY+JxBxZVMMvtkbh
 Lq28zK2yfThKIGYEwS8izV8rwupOrrmzz+v15vY3mw5c3IaJ2MiMDu8sKDjTOBaEUyjYLmgtCK4
 pGKr1XSlF2AdIcp4tF42T4aIzdRB1SVj6/yXbyM1FwxBwuVy5phUUg22cJbeyoszvwSycJzszLf
 fGAtGgbWxr2e7azplkMtxLYJq7gZADj1hxp/bAB6/CUQ==
X-Received: by 2002:a17:902:db0b:b0:2ae:ac0c:5a2a with SMTP id
 d9443c01a7336-2b0cdc02bdbmr32928465ad.6.1774625296149; 
 Fri, 27 Mar 2026 08:28:16 -0700 (PDT)
Received: from localhost.localdomain ([59.16.109.172])
 by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-2b0bc90c44esm66225935ad.76.2026.03.27.08.28.14
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 27 Mar 2026 08:28:15 -0700 (PDT)
From: Jinseok Kim <always.starving0@gmail.com>
To: andrea.cervesato@suse.com
Date: Sat, 28 Mar 2026 00:27:49 +0900
Message-ID: <20260327152751.3637-1-always.starving0@gmail.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <69c280f0.050a0220.2e1b4b.e591@mx.google.com>
References: <69c280f0.050a0220.2e1b4b.e591@mx.google.com>
MIME-Version: 1.0
X-Virus-Scanned: clamav-milter 1.0.9 at in-5.smtp.seeweb.it
X-Virus-Status: Clean
Subject: [LTP] [PATCH v7] fstat: add test for multiple file types using fstat
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
 testcases/kernel/syscalls/fstat/fstat04.c  | 103 +++++++++++++++++++++
 3 files changed, 107 insertions(+)
 create mode 100644 testcases/kernel/syscalls/fstat/fstat04.c

diff --git a/runtest/syscalls b/runtest/syscalls
index 6ba0227a8..5a2e8f048 100644
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
index 000000000..8a52de06a
--- /dev/null
+++ b/testcases/kernel/syscalls/fstat/fstat04.c
@@ -0,0 +1,103 @@
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
+#define MOUNT_PATH	"test_mnt"
+#define REG_FILE	"regfile"
+#define DIR_FILE	"dirfile"
+#define FIFO_FILE	"fifofile"
+#define CHR_DEV	MOUNT_PATH"/chrdev"
+#define BLK_DEV	MOUNT_PATH"/blkdev"
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
+	int fd = SAFE_OPEN(tc->path, flags);
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
+	.mntpoint = MOUNT_PATH,
+	.needs_devfs = 1,
+	.needs_tmpdir = 1,
+	.needs_root = 1,
+};
--
2.43.0

-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
