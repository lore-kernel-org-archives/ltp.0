Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 01EEFE9B24A
	for <ltp@archiver.kernel.org>; Tue, 24 Feb 2026 10:08:32 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 99AF63D0F84
	for <ltp@archiver.kernel.org>; Tue, 24 Feb 2026 11:08:31 +0100 (CET)
Received: from in-3.smtp.seeweb.it (in-3.smtp.seeweb.it
 [IPv6:2001:4b78:1:20::3])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 784473CA177
 for <ltp@lists.linux.it>; Tue, 24 Feb 2026 11:07:53 +0100 (CET)
Received: from mail-pf1-x443.google.com (mail-pf1-x443.google.com
 [IPv6:2607:f8b0:4864:20::443])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-3.smtp.seeweb.it (Postfix) with ESMTPS id 0F2261A00812
 for <ltp@lists.linux.it>; Tue, 24 Feb 2026 11:07:53 +0100 (CET)
Received: by mail-pf1-x443.google.com with SMTP id
 d2e1a72fcca58-824c9da9928so2673935b3a.3
 for <ltp@lists.linux.it>; Tue, 24 Feb 2026 02:07:52 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1771927671; x=1772532471; darn=lists.linux.it;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=6dNzs1p4CGJu9OvEAlyp8FGjoCIMXUHgFDm3d0fVmHA=;
 b=bYUyiJWia/SFbnOdfl4YHqg+m5IlthnTuRL0MYDOjmRJAXuGzYkRq2JfXxVTdzSDd6
 qBZThMBhVMPI5NFWBkvoYQooFRB1CNtey4TGNX80ZpcmHwnVxrBc9Gxh/1ARq7VgPzJV
 gX8rwmioyuUtar97NamTC3y2XEfG0cexcX8yfb6doLtpZgt0NrS28SAIxc1qwIWR/tzu
 BNFbkzuczDCj9E+ifpFqOcrvhurpvlnvDd6MRI4U2jrZb/8hz0UwE+XeqedWkJL/TlFB
 0RFDw6+hZ2nt//Vqu5BrH2Ub+lQuO9Eyo7nRW0AeQN6l5yv/oJ2k6iZx29ptBg7T1aQV
 /Eyg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1771927671; x=1772532471;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=6dNzs1p4CGJu9OvEAlyp8FGjoCIMXUHgFDm3d0fVmHA=;
 b=JLUPelp+Pye5bf2bIf/Q8mnhbEtwSKQXrRUj8AKt8CF4SXjAQbTM/TyufUpuskSO9D
 jOb1noFcPcRaggPx6H3ygCnixDRMoLKl4TrwLmhig8ESK53LKTREixa0nYvEgyVZCrxm
 7Ua7Rl+l+DBRrkWcMzIsBhNLw8z/Q0vBejakAzGGsDsUAQmKcBrbi1WQiiZ8pC/Ccqz4
 WvxuWvKbEJbCjSalYA2Rl0BtM8NQmDF9mIGoMgo78/lhcly1+snpHicqjlaOhRVlh+Pb
 qVfXDQ5oh0eTAtS5tJnJVI5PzfPfeGEPJCrnauEhOGakX5O3xpBkzt/ts8tHmFfAb60a
 8tew==
X-Gm-Message-State: AOJu0Yx9hKE98oxf+V0XfM1ehaiTAIgGD9A0YHaTmtrhEqhQU80jgBv2
 kz3E1nWZgb9RLCY15Iaores/cggIdHxOnSL05F4DR9QRSkcJgDQdKf30vRQgYuKimQ==
X-Gm-Gg: AZuq6aJ9xNfeof2Nay+YByDU4+xzF1wr5G1wdx40iZ9iYpkR57k+PQOEHp4/l84CYQt
 RLl7NfFj2AbILt6SzgR8uIqMEjCQTODiUa+AqWmcF+5loJxC37aW32+FQG9qjlqxkbVgVSGohiO
 oUYh8cxDyML1gzaFjMN5M3YrhtitPRFe618DiZa8myCF9bwVh7rqJdBMVDaNszLJWyDngIVOp0P
 /ZzMdle7EcIGiCLlMVCzC/pwYhUb1PFKX0ZTpJYB+kS8FbT7+JHGNEhQ14sUPmEYiSDb3oZB/xO
 P7x2izvm7pnsRlsL6v9aZJnEV3nhyot9xWE5ob8NSN5rMImEIeefsSFeEDmTd00+XLz3N0Yn1SC
 umxz6b3XM8TDtn/e0/wSEx7tr2fwrZyMY1RIrWra6Aj0qQhxNVTfh2r3NuUAPZn50jD2DmpAko9
 mYD+/vg3Omam9Z53DfAdEDd0H79sgcHp7bLJXCAdjOMw==
X-Received: by 2002:a05:6a00:22c4:b0:820:f4fb:e914 with SMTP id
 d2e1a72fcca58-826daa0cd68mr9100189b3a.42.1771927671118; 
 Tue, 24 Feb 2026 02:07:51 -0800 (PST)
Received: from localhost.localdomain ([59.16.109.172])
 by smtp.gmail.com with ESMTPSA id
 d2e1a72fcca58-826dd8bc6e8sm9922472b3a.49.2026.02.24.02.07.49
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 24 Feb 2026 02:07:50 -0800 (PST)
From: Jinseok Kim <always.starving0@gmail.com>
To: ltp@lists.linux.it
Date: Tue, 24 Feb 2026 19:07:18 +0900
Message-ID: <20260224100723.42877-2-always.starving0@gmail.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260224100723.42877-1-always.starving0@gmail.com>
References: <DGN1LFH0ULK0.3D30H8MFVV9GM@suse.com>
 <20260224100723.42877-1-always.starving0@gmail.com>
MIME-Version: 1.0
X-Virus-Scanned: clamav-milter 1.0.9 at in-3.smtp.seeweb.it
X-Virus-Status: Clean
Subject: [LTP] [PATCH v2 2/2] fstat: add test for multiple file types using
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
