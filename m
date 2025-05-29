Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7C05DC5AD49
	for <ltp@archiver.kernel.org>; Wed, 28 May 2025 22:52:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=lists.linux.it;
 i=@lists.linux.it; q=dns/txt; s=picard; t=1748472754; h=to : date :
 message-id : mime-version : subject : list-id : list-unsubscribe :
 list-archive : list-post : list-help : list-subscribe : from :
 reply-to : content-type : content-transfer-encoding : sender : from;
 bh=cGUe4YJSuqTdytpJdh4wL6nE2r2CGDE1THFvb8kexU8=;
 b=ARGJGyzxrT15nDdhckBOcrJH/iaBMauPRUUXXtPeOE1kwVrM7XRW7RdHU2fpiZgAXTc2S
 hwITSa7/pp5ElvCgGzJZkD+66Zxe54FI554k7jtw8hlVHqrm377/l4S4OggDRh/TeE5mc4U
 7+NPzTeBEr4Qk2hBeevc30DFmeij27M=
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id B245B3C7A6B
	for <ltp@archiver.kernel.org>; Thu, 29 May 2025 00:52:34 +0200 (CEST)
Received: from in-5.smtp.seeweb.it (in-5.smtp.seeweb.it
 [IPv6:2001:4b78:1:20::5])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 3ABEE3C69D4
 for <ltp@lists.linux.it>; Thu, 29 May 2025 00:52:13 +0200 (CEST)
Received: from mail-wr1-x42c.google.com (mail-wr1-x42c.google.com
 [IPv6:2a00:1450:4864:20::42c])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-5.smtp.seeweb.it (Postfix) with ESMTPS id AF64E60057D
 for <ltp@lists.linux.it>; Thu, 29 May 2025 00:52:11 +0200 (CEST)
Received: by mail-wr1-x42c.google.com with SMTP id
 ffacd0b85a97d-3a376ba6f08so184879f8f.1
 for <ltp@lists.linux.it>; Wed, 28 May 2025 15:52:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=suse.com; s=google; t=1748472731; x=1749077531; darn=lists.linux.it;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to;
 bh=ATvCl9AjONIDPTPKW/pYVj0SZdVtTnadd4/Y9lkzc3k=;
 b=dFu3UtWXSc6XXhD28+f2nC/jss9V0KXZlzqiKXfs6IjTWjF31vQx7GDLyJ2hcLXolo
 iHRRdgX7DGZfMkBOKhHSjMxF1/MI6ofpt78GB/MvE37884Wvfwij6O3bPrW+0D8Su6jq
 JQG8Ul95U8Sfr/L2glxikcw8WhLAbKyXtr+oOK/3/CvDlPs5TXFFc/UBHkx4xR2+0eFk
 8A5LAFSkLQ7FTtSQLAHWMWADvNgsjEjfFcQZ0ZAWDCjldKQKgEI8wq8Y+BsCWjydE8v+
 fA1e/zULpHLnMVaZa4SG4qCz1wNZyHYEYCfMgZx2UTIYXdExO5qI4zE747sCJAEhSwlb
 KEgA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1748472731; x=1749077531;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=ATvCl9AjONIDPTPKW/pYVj0SZdVtTnadd4/Y9lkzc3k=;
 b=EtdVCKMkgS5zB/nnFhY1ZMot+JliZ5NhEvSrkfmgQEdPu658lCp+FzQstJfwvd2B2n
 10JoRZHP5Z/a9jG41zIdELauVvbxJfoqo80VHTJBpbdmlPXC6DLfzUEvY29z8Ll6Q5FD
 bC8sFNLQrtI+aaOvOtY/WpYM/iMA4CzMGi3eZ8oUNsmIQD3tPRSgQJtz35cKI90bG4Yx
 dT85L2+jAQxOUe8uwms9WnppPl/V2lflLnbW6Hyt5jK0h5DjePtA9ljz4eNccTz9/enr
 W5S5xcLKwnqUdVdkwmUtlouxImrP9nKPDofiL0GmJSpMzJu1xrix6lIRDOuDnxHjYGHt
 E63w==
X-Gm-Message-State: AOJu0YyQBOXYx5T+mULtOVasirFPxVMicK4KKKrpprSI5Ue9a0EE60P8
 ybjCcaOeI8XmAgq+Fwtw/l1XjVD8ZFKYWWogrIJrJSt2SKngqAsfJ38SRpLzCZXs1HJiDE24658
 P4jI=
X-Gm-Gg: ASbGncvmB4cUWnHuFm8qNkhdDBSH7Ec7D6Vb1MJMktDe7suzR/7rNeWzdjiVsbGOfr+
 Hc4USrYwEJ2skbJMBRupM22Y6NuZLfW/rKWZkMEtEC5dOGctcytX5AxoJ4T6GWJUr+8qFN36NiU
 ZHWgoU4FKLFXU8bO3c4gw/c61mv0wpzXfcBz/k/Nq2z9YF+JHj+NizqFOPC/0hOIT8qe/rHWdE5
 Lz6i4DYGK1MGCc6nJYQmvEHRHdXnL+hNf7efjqaFc1u2j+J86nCsAaxyetvvGUdg1zLFvYR1K+K
 EnACnNkrRI7mU16DVzJd2E2j9an+aWZrz76FYqdi
X-Google-Smtp-Source: AGHT+IE7YgyZJ87rNDv3Ze3EuTBehp9yCM8EqKQUwpoeP6zjAZFvfgnCvPCCGAqr7pZ2oyOF6UStsw==
X-Received: by 2002:a05:6000:4305:b0:3a4:d02e:84af with SMTP id
 ffacd0b85a97d-3a4d02e87f5mr14857659f8f.58.1748472730910; 
 Wed, 28 May 2025 15:52:10 -0700 (PDT)
Received: from localhost ([202.127.77.110])
 by smtp.gmail.com with UTF8SMTPSA id
 98e67ed59e1d1-3121b71c6ccsm161941a91.11.2025.05.28.15.52.09
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 28 May 2025 15:52:10 -0700 (PDT)
To: ltp@lists.linux.it
Date: Thu, 29 May 2025 06:51:53 -0400
Message-ID: <20250529105156.2564268-1-wegao@suse.com>
X-Mailer: git-send-email 2.49.0
MIME-Version: 1.0
X-Virus-Scanned: clamav-milter 1.0.7 at in-5.smtp.seeweb.it
X-Virus-Status: Clean
Subject: [LTP] [PATCH v1] tst_filesystems01.c: Add test for .filesystems
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
From: Wei Gao via ltp <ltp@lists.linux.it>
Reply-To: Wei Gao <wegao@suse.com>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: ltp-bounces+ltp=archiver.kernel.org@lists.linux.it
Sender: "ltp" <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>

Fixes: https://github.com/linux-test-project/ltp/issues/1243
Signed-off-by: Wei Gao <wegao@suse.com>
---
 lib/newlib_tests/tst_filesystems01.c | 118 +++++++++++++++++++++++++++
 1 file changed, 118 insertions(+)
 create mode 100644 lib/newlib_tests/tst_filesystems01.c

diff --git a/lib/newlib_tests/tst_filesystems01.c b/lib/newlib_tests/tst_filesystems01.c
new file mode 100644
index 000000000..96f4b2d93
--- /dev/null
+++ b/lib/newlib_tests/tst_filesystems01.c
@@ -0,0 +1,118 @@
+// SPDX-License-Identifier: GPL-2.0-or-later
+/*
+ * Copyright (c) 2025 Wei Gao <wegao@suse.com>
+ */
+
+#include "tst_test.h"
+#include "tst_safe_stdio.h"
+
+#define MOUNT_POINT "mount_test_filesystems"
+
+static int check_inode_size(unsigned int size)
+{
+	char path[PATH_MAX];
+	char line[PATH_MAX];
+	FILE *tune2fs;
+	char str_size[NAME_MAX];
+
+	snprintf(str_size, sizeof(str_size), "%u", size);
+	snprintf(path, sizeof(path), "tune2fs -l %s 2>&1", tst_device->dev);
+	tune2fs = SAFE_POPEN(path, "r");
+	if (tune2fs == NULL)
+		tst_brk(TBROK, "Can not popen %s", path);
+
+	while (fgets(line, PATH_MAX, tune2fs)) {
+		if (*line && strstr(line, "Inode size:") && strstr(line, str_size)) {
+			tst_res(TPASS, "check inode size pass");
+			return 0;
+		}
+	}
+
+	pclose(tune2fs);
+	tst_res(TFAIL, "check inode size failed");
+	return -1;
+}
+
+static int check_mnt_data(char *opt)
+{
+	FILE *fp;
+	char line[PATH_MAX];
+
+	fp = SAFE_FOPEN("/proc/mounts", "r");
+	if (fp == NULL)
+		tst_brk(TBROK, "Can not open /proc/mounts");
+	while (fgets(line, PATH_MAX, fp)) {
+		if (*line && strstr(line, tst_device->dev) && strstr(line, opt)) {
+			tst_res(TPASS, "check mnt data pass");
+			return 0;
+		}
+	}
+	SAFE_FCLOSE(fp);
+	tst_res(TFAIL, "check mnt data failed");
+	return -1;
+}
+
+static int check_mkfs_size_opt(unsigned int size)
+{
+	char path[PATH_MAX];
+	char line[PATH_MAX];
+	FILE *dumpe2fs;
+	char str_size[NAME_MAX];
+
+	snprintf(str_size, sizeof(str_size), "%u", size);
+	snprintf(path, sizeof(path), "dumpe2fs -h %s 2>&1", tst_device->dev);
+	dumpe2fs = SAFE_POPEN(path, "r");
+	if (dumpe2fs == NULL)
+		tst_brk(TBROK, "Can not popen %s", path);
+
+	while (fgets(line, PATH_MAX, dumpe2fs)) {
+		if (*line && strstr(line, "Block count:") && strstr(line, str_size)) {
+			tst_res(TPASS, "check mkfs size opt pass");
+			return 0;
+		}
+	}
+
+	pclose(dumpe2fs);
+	tst_res(TFAIL, "check mkfs size opt failed");
+	return -1;
+}
+
+static void do_test(void)
+{
+	long fs_type;
+
+	fs_type = tst_fs_type(MOUNT_POINT);
+
+	if (fs_type == TST_EXT234_MAGIC) {
+		check_inode_size(128);
+		check_mkfs_size_opt(10240);
+	}
+
+	if (fs_type == TST_XFS_MAGIC)
+		check_mnt_data("usrquota");
+}
+
+static struct tst_test test = {
+	.test_all = do_test,
+	.needs_root = 1,
+	.mntpoint = MOUNT_POINT,
+	.mount_device = 1,
+	.needs_cmds = (const char *[]) {
+		"tune2fs",
+		"dumpe2fs",
+		NULL
+	},
+	.filesystems = (struct tst_fs []) {
+		{
+			.type = "ext3",
+			.mkfs_opts = (const char *const []){"-I", "128", NULL},
+			.mkfs_size_opt = "10240",
+		},
+		{
+			.type = "xfs",
+			.mnt_data = "usrquota",
+		},
+		{}
+	},
+
+};
-- 
2.49.0


-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
