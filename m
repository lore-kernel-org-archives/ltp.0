Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A9005EFB810
	for <ltp@archiver.kernel.org>; Tue, 24 Feb 2026 07:38:48 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 227DC3D0F86
	for <ltp@archiver.kernel.org>; Tue, 24 Feb 2026 08:38:47 +0100 (CET)
Received: from in-6.smtp.seeweb.it (in-6.smtp.seeweb.it
 [IPv6:2001:4b78:1:20::6])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 427573D0F71
 for <ltp@lists.linux.it>; Tue, 24 Feb 2026 08:38:09 +0100 (CET)
Received: from mail-pl1-x643.google.com (mail-pl1-x643.google.com
 [IPv6:2607:f8b0:4864:20::643])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-6.smtp.seeweb.it (Postfix) with ESMTPS id CC71D1400141
 for <ltp@lists.linux.it>; Tue, 24 Feb 2026 08:38:08 +0100 (CET)
Received: by mail-pl1-x643.google.com with SMTP id
 d9443c01a7336-2aaf9191da3so33671475ad.2
 for <ltp@lists.linux.it>; Mon, 23 Feb 2026 23:38:08 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1771918687; x=1772523487; darn=lists.linux.it;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
 :reply-to; bh=6dNzs1p4CGJu9OvEAlyp8FGjoCIMXUHgFDm3d0fVmHA=;
 b=lTl3AHzubMwk6GKJX6UaHVArx4dnD53afoEPG0/IqXpnoTh5a9Lp3Lw6BNwJJOXisE
 YgYrppncsxH69jMvvngA6E+bnqtjMv9gBiKSAT/NNgLJB+dtLKqUlyX2+JcRho4wOWA3
 bLp5tX8inWxNI7Zgam1sFYl/3bK8BQZYLHseXmOEypLEfHEEfs27kWgqoDWTSZHhmeH1
 r/AadlF5woxClPkBbHU3SdyIdJ7aZ59ldKQkRo2q0hGL6CZxKiUa+yMHrNrv2WywCBZn
 l6Q+hTfcJ3y6xSihNxFPfeBQ9k/3WGjheuT6TiIKYZ3pqzYPN+Ddg9a61803i6koP+NH
 SsZg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1771918687; x=1772523487;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:x-gm-gg:x-gm-message-state:from:to
 :cc:subject:date:message-id:reply-to;
 bh=6dNzs1p4CGJu9OvEAlyp8FGjoCIMXUHgFDm3d0fVmHA=;
 b=CdN6uW0agJmyskCYh2kxEJReya2hcomrREZKTxzb1IhJ4Ixf+/gPLki5urR5fznaZM
 sdwfD1SY3NdWJAwlm5YXz83RLUD2TAkgVV1CNUbFM8Um0AGTOH6DUgos1samYGRFORUW
 OSd19tSJS54pzoOAr8fs8zigVgVPr3Wl24u6tVIgPNuygoZDRLQNP7uS2PydHw8sD5S7
 5AVOkoa1MDNUw/jdC2miJpPR3N+xCrCIPiMgrbb8z4TdHr0frinN6XcODTXrFyZgJoHP
 qUgO5BwWcFBx9xyNY2WDuJF1VeXC/Zcz60OY/5exxn4dLEhWwLcUhfSBU9kYi0IUEWPo
 TIaw==
X-Forwarded-Encrypted: i=1;
 AJvYcCVp3siG76Qp6XoDKv4BDVdwXWY4xCZeEKCSajJaiYECkae5AW+hDVrwvn++KHw0COYiVaY=@lists.linux.it
X-Gm-Message-State: AOJu0YzuZVbjDj8t+B+FQ8PwiH31IcrYMhgwtvGqE5VP84EycDS//e6e
 /V/wXSwaiDIh07W0WWNWYzzbfwaZhJ3duWhkZl2j7/gGwJS+yAoWhhmfevN99aC7OQ==
X-Gm-Gg: ATEYQzxKAoOp2sjusQM7gGXIw3WxOj6eCQ9nGASi0+UVqTIckPtmu6m4v9QQdMZBLY8
 LEMBUvPDWs74VbMgndctXRZRk1pcikkVlW8ME3MIe7kdRbAG+DJ0+OpzoIxOudfOmuZqVS57i3r
 wEV5oS5oNLgLRFGU0ioD0OU5fTAgcIKZtxadOBH1MeAwtrP1jl2AWtnn35zHXvFYZPJdJRAyBDK
 WmYAA8C+u3TUOS6MRuft/dmp+OlxKgBW9dpPSiuOBL/cAWRhksZhQU0Gxf6XWtWjyxp7TG+KiOc
 EcfKcyvpBTcOSctiKVD77Cu2i7MvkUQVda5nxU19hkphwxC1yoZ7heRe/seavmMsJEcTiT3lX3F
 QesEzM7104+PQuekSZ1D8RMLWhfwmeoI5JkZug+u45kxTK+ETZqO0BxJlf14PEOz9qupZUec8ZJ
 ovJDyo6FRDUwWg6ay7kPZfKjcZABPUYgpds8rE8oXcRA==
X-Received: by 2002:a17:902:dacf:b0:2a9:322e:1964 with SMTP id
 d9443c01a7336-2ad744e0adfmr115572725ad.31.1771918687126; 
 Mon, 23 Feb 2026 23:38:07 -0800 (PST)
Received: from localhost.localdomain ([112.172.52.51])
 by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-2ad75054aa3sm97967655ad.89.2026.02.23.23.38.06
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 23 Feb 2026 23:38:06 -0800 (PST)
From: Jinseok Kim <always.starving0@gmail.com>
To: chrubis@suse.cz,
	ltp@lists.linux.it
Date: Tue, 24 Feb 2026 16:37:25 +0900
Message-ID: <20260224073734.34802-2-always.starving0@gmail.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260224073734.34802-1-always.starving0@gmail.com>
References: <aZg8NDoUFezK-WTE@yuki.lan>
 <20260224073734.34802-1-always.starving0@gmail.com>
MIME-Version: 1.0
X-Virus-Scanned: clamav-milter 1.0.9 at in-6.smtp.seeweb.it
X-Virus-Status: Clean
Subject: [LTP] [PATCH 2/2] Add test for multiple file types using fstat
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
 testcases/kernel/syscalls/fstat/fstat04.c | 103 ++++++++++++++++++++++
 1 file changed, 103 insertions(+)
 create mode 100644 testcases/kernel/syscalls/fstat/fstat04.c

diff --git a/testcases/kernel/syscalls/fstat/fstat04.c b/testcases/kernel/syscalls/fstat/fstat04.c
new file mode 100644
index 000000000..6aa9a8e79
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
+
+#define _GNU_SOURCE
+#include <sys/types.h>
+#include <sys/stat.h>
+#include <sys/sysmacros.h>
+#include <fcntl.h>
+#include <unistd.h>
+#include <errno.h>
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
+    const char *desc;
+    const char *path;
+    const char *macro_name;
+    mode_t exp_type;
+} tcases[] = {
+    { "regular file",   REG_FILE,  "S_IFREG", S_IFREG },
+    { "directory",      DIR_FILE,  "S_IFDIR", S_IFDIR },
+    { "FIFO (pipe)",    FIFO_FILE, "S_IFIFO", S_IFIFO },
+    { "symbolic link",  SYMLINK,   "S_IFLNK", S_IFLNK },
+    { "character dev",  CHR_DEV,   "S_IFCHR", S_IFCHR },
+    { "block dev",      BLK_DEV,   "S_IFBLK", S_IFBLK },
+};
+
+static void verify_fstat(unsigned int i)
+{
+    struct tcase *tc = &tcases[i];
+    struct stat buf;
+
+    int flags = O_RDONLY | O_NONBLOCK;
+
+    if (tc->exp_type == S_IFDIR)
+        flags |= O_DIRECTORY;
+
+    fd = SAFE_OPEN(tc->path, flags);
+
+    SAFE_FSTAT(fd, &buf);
+    SAFE_CLOSE(fd);
+
+    int is_correct = 0;
+    switch (tc->exp_type) {
+    case S_IFREG: is_correct = S_ISREG(buf.st_mode); break;
+    case S_IFDIR: is_correct = S_ISDIR(buf.st_mode); break;
+    case S_IFIFO: is_correct = S_ISFIFO(buf.st_mode); break;
+    case S_IFLNK: is_correct = S_ISLNK(buf.st_mode); break;
+    case S_IFCHR: is_correct = S_ISCHR(buf.st_mode); break;
+    case S_IFBLK: is_correct = S_ISBLK(buf.st_mode); break;
+    }
+
+    if (is_correct)
+        tst_res(TPASS, "%s: %s() macro matches", tc->desc, tc->macro_name);
+    else
+        tst_res(TFAIL, "%s: %s() macro does NOT match", tc->desc, tc->macro_name);
+}
+
+static void setup(void)
+{
+    fd = SAFE_OPEN(REG_FILE, O_WRONLY | O_CREAT | O_TRUNC, 0644);
+    SAFE_CLOSE(fd);
+
+    SAFE_MKDIR(DIR_FILE, 0755);
+    SAFE_SYMLINK(REG_FILE, SYMLINK);
+
+    SAFE_MKNOD(FIFO_FILE, S_IFIFO | 0777, 0);
+    SAFE_MKNOD(CHR_DEV, S_IFCHR | 0777, makedev(1, 3));
+    SAFE_MKNOD(BLK_DEV, S_IFBLK | 0777, makedev(7, 3));
+}
+
+static void cleanup(void)
+{
+    SAFE_UNLINK(SYMLINK);
+    SAFE_UNLINK(REG_FILE);
+    SAFE_RMDIR(DIR_FILE);
+
+    SAFE_UNLINK(FIFO_FILE);
+    SAFE_UNLINK(CHR_DEV);
+    SAFE_UNLINK(BLK_DEV);
+}
+
+static struct tst_test test = {
+    .tcnt = ARRAY_SIZE(tcases),
+    .setup = setup,
+    .cleanup = cleanup,
+    .test = verify_fstat,
+    .needs_tmpdir = 1,
+    .needs_root = 1,
+};
--
2.43.0

-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
