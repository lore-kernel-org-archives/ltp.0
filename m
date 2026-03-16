Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id AA424F53D67
	for <ltp@archiver.kernel.org>; Mon, 16 Mar 2026 15:06:59 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 508483E5D02
	for <ltp@archiver.kernel.org>; Mon, 16 Mar 2026 16:06:58 +0100 (CET)
Received: from in-7.smtp.seeweb.it (in-7.smtp.seeweb.it [217.194.8.7])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1) server-digest SHA384)
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id DA1223E2B7D
 for <ltp@lists.linux.it>; Mon, 16 Mar 2026 16:06:17 +0100 (CET)
Received: from mail-pf1-x441.google.com (mail-pf1-x441.google.com
 [IPv6:2607:f8b0:4864:20::441])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-7.smtp.seeweb.it (Postfix) with ESMTPS id 87DE72009EC
 for <ltp@lists.linux.it>; Mon, 16 Mar 2026 16:06:17 +0100 (CET)
Received: by mail-pf1-x441.google.com with SMTP id
 d2e1a72fcca58-82418b0178cso2763524b3a.1
 for <ltp@lists.linux.it>; Mon, 16 Mar 2026 08:06:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1773673576; x=1774278376; darn=lists.linux.it;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=nvb7pVgKCDgB+qHZhgac0T3zHXaYVSpU0CfhWXeSdRQ=;
 b=G5eAl4H2t9zzPVpRdbFuARaXka+LxxmplrXhipSTqBebSBF4Hs4njt8puMMMTPCHD1
 sZ0QtPObnzvAGttT+hxjiTnu48wPPth09bvm6LGWC81p8OCm3xACCVd7Sn6geE+kPl2c
 z5NAsjDyIWqRdzG+zxhIWpzyVrOqCTdCYGRB/tWTmRpefMEtaZjZ4Iz5s3IF3j7hlpSY
 GuoeCySH7apf1RxD7yjxyrFjB+humt0Y9PR8unPiDK6rHqLzHAR4EDePIe4nPwsPbNgJ
 ZmLLWT7IusVJi27Wiz8jNk0AnclO8q3wOnhF1sQvruVpo9e2Gw7U6MHFfTyyingN4QwX
 qcwQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1773673576; x=1774278376;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=nvb7pVgKCDgB+qHZhgac0T3zHXaYVSpU0CfhWXeSdRQ=;
 b=GrpzGF4uj/Mq6VegMsJnD4chPthUGzQ5y9AH66cclGCT0C6GMk+1cWxrDtrV0sgtV7
 KOtamt8/e+djjSUSsbK1eguSIwsaVXrKr1R1p2vxlSeZlm+zMVZx3fN5ipMYys9xjamT
 eUeZ3u1DveViqrGecTnwAQRHem+Wx68NwmnoieO++fBbWJ3na14Gm/YX+On4YNypUcrh
 sQ+WZdkHwzk4nsHtphjM68KB0ykJOT9ue1+hdNfjve3PgVcZhmzDcOaYBZM6Sl/w3rK0
 ytfM7HJXylWdBsezY6ukCIiM8/12YOHeOlyHYlFJra5VDR7bQyfrTcO4Va+IvQcM3wcI
 kqgA==
X-Gm-Message-State: AOJu0YwoJIreWfZ1CBpDrF8NvXCqAUBGz2RNDTSCvmvwYKCcPHWLY1As
 vr5S3bUyeRG7lTnQmW3asSC9/iHupcv3P+xtJlGO7jI6kMQLuttS2vKKzpFk+N8=
X-Gm-Gg: ATEYQzyiICetM3eoFthSAx+wqak14YBzswgDcxrOvp9xaEnsvPha7Z9rw46+0bQ0QqS
 Vc8utAuospb1afDyWFGHnMcP6AaXSzC5aPAP07f0t63uf+HASSFStPOzk8cOlfBXax/GjlXqYiY
 l5xTiyZQMqsMQwboqNzRtZHIzvayz3ov8tn5fw7zSSX6fL4yrSbl9O1eLDh3RYZGw/D/SdPHTyu
 5n8eXpm8kzdo9UWQwZfEkIntxcS/bv+4dUHR9z+WDYmS3aWqKJXWSjZb+sg4RHpor1VgTTSoXkR
 6N9bDkBlrVmnRbvex0uXzlQXfBlZuTDLpAZiYojxqABp8TDGr6Sqg4Tl8glVvYZXASJZcr6oahd
 Rb955PYZP5E8qXoU0l3zMEtqfXUGCx32GfTTPM8asKqfRYa59RcrhKeoL3vydJte1awesjlvqsF
 Uo44Fix3km17pRbdjWY5t2JhLSVcCBwnnx8lwzQPyuulxu1nAiyIJ7
X-Received: by 2002:a05:6a00:21d3:b0:81e:5d52:53b8 with SMTP id
 d2e1a72fcca58-82a198e2deamr11821666b3a.50.1773673575774; 
 Mon, 16 Mar 2026 08:06:15 -0700 (PDT)
Received: from localhost.localdomain ([59.16.109.172])
 by smtp.gmail.com with ESMTPSA id
 d2e1a72fcca58-82a0724407csm13435477b3a.8.2026.03.16.08.06.14
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 16 Mar 2026 08:06:15 -0700 (PDT)
From: Jinseok Kim <always.starving0@gmail.com>
To: andrea.cervesato@suse.com
Date: Tue, 17 Mar 2026 00:00:52 +0900
Message-ID: <20260316150404.116279-2-always.starving0@gmail.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260316150404.116279-1-always.starving0@gmail.com>
References: <69b7b380.050a0220.2e2929.0639@mx.google.com>
 <20260316150404.116279-1-always.starving0@gmail.com>
MIME-Version: 1.0
X-Virus-Scanned: clamav-milter 1.0.9 at in-7.smtp.seeweb.it
X-Virus-Status: Clean
Subject: [LTP] [PATCH v6 2/2] fstat: add test for multiple file types using
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
 testcases/kernel/syscalls/fstat/fstat04.c  | 105 +++++++++++++++++++++
 3 files changed, 109 insertions(+)
 create mode 100644 testcases/kernel/syscalls/fstat/fstat04.c

diff --git a/runtest/syscalls b/runtest/syscalls
index 2179e007c..eadd921b8 100644
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
index 000000000..8723ac2bd
--- /dev/null
+++ b/testcases/kernel/syscalls/fstat/fstat04.c
@@ -0,0 +1,105 @@
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
+#define REG_FILE	"regfile"
+#define DIR_FILE	"dirfile"
+#define FIFO_FILE	"fifofile"
+#define CHR_DEV	"chrdev"
+#define BLK_DEV	"blkdev"
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
--
2.43.0

-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
