Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5319AC35FFF
	for <ltp@archiver.kernel.org>; Wed, 19 Mar 2025 11:42:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=lists.linux.it;
 i=@lists.linux.it; q=dns/txt; s=picard; t=1742384537; h=to : date :
 message-id : in-reply-to : references : mime-version : subject :
 list-id : list-unsubscribe : list-archive : list-post : list-help :
 list-subscribe : from : reply-to : content-type :
 content-transfer-encoding : sender : from;
 bh=+ej4xoWAy82Xc/R19nbJ2S4/KzLVJepN0TxCiM15QzE=;
 b=Wy1ri8TURfUyuiBKDT8z2RcH/P7zk9QVnto6bg29aUVI40qxW+qfu7ovNlIBk/kp+9srw
 GW2EdHQFiv8uySJjAdhm5xTkKsHRxjK0peGge6OvhbD8McELgkeWDeBoy4bqBF7hCErP3fO
 LDEGifq+urI7vWRSgctLS9yK3D7T0Tg=
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 2F2613CACD4
	for <ltp@archiver.kernel.org>; Wed, 19 Mar 2025 12:42:17 +0100 (CET)
Received: from in-5.smtp.seeweb.it (in-5.smtp.seeweb.it [217.194.8.5])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 9D5B43CACAA
 for <ltp@lists.linux.it>; Wed, 19 Mar 2025 12:41:54 +0100 (CET)
Received: from mail-wr1-x42c.google.com (mail-wr1-x42c.google.com
 [IPv6:2a00:1450:4864:20::42c])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-5.smtp.seeweb.it (Postfix) with ESMTPS id 8C75A600B49
 for <ltp@lists.linux.it>; Wed, 19 Mar 2025 12:41:53 +0100 (CET)
Received: by mail-wr1-x42c.google.com with SMTP id
 ffacd0b85a97d-39129fc51f8so6006532f8f.0
 for <ltp@lists.linux.it>; Wed, 19 Mar 2025 04:41:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=suse.com; s=google; t=1742384513; x=1742989313; darn=lists.linux.it;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=dwg2wsMjhzUieTJiPDmwEbwX3GGk8pyrYY5aAV3A0cI=;
 b=JVSDRE0lc6s7sn4e2kytIo9OaZP+R8SjHVZAOIVRkbXoUx5MaKsDULO/oA+Cw4RvMG
 Akr+NKOimUFV8a9SExBN3hE4Unoorua2Habg/ml8cK0QAW8xfAyWo+pLNj6ag2nwHg+l
 fHDf6aZ0q4hHIsVzn8Gp314/0ZnqmX7ZNuPjZYxEQ8+hO5hqkHh/saHDU7RfXhnBHVDb
 0F1R3PSmL2kw5r8Ys21r0C0CuC9ZoMzVxP5FQIOKqZwEm/0720YGASoiTv+rACVTF20a
 gnk9UT23XX02sEXU8uQHwxh9c72tjEW7qe6EO2ngHdneVA+ucV74a7rL43AMb0IzSxP0
 rHfQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1742384513; x=1742989313;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=dwg2wsMjhzUieTJiPDmwEbwX3GGk8pyrYY5aAV3A0cI=;
 b=KU2wf+0H6KmkhDf6dpnhz2YQQxKJta8XoYnKIiW66+u7YQfzuLj5tnCNCx7IOGPaJE
 7UCY4PHq6WGV3besx8g4YvwQfQ9KyXhw1bUirAsvXY1KG1hcWHi63ReCfRnwpQqUgvey
 Q4ZBfmUr9nB+FWjqd/DQ0tIt9kqLxUS5DfeIGBldZxDtgKTqVjlHTs84fQXaCVLI9okg
 AKmXli/6PFbzcJ4dWk2sHzlN18WTlOGU/m4ddHg2E3262K7JTNnjFd8eFw5F130yfmpP
 7trygm/2l6NpkgdZlHa9i6pd5WQQT7wvohCI81krur2yh4xGBXsVDErlzoa94ENvpu0C
 nKIw==
X-Gm-Message-State: AOJu0Yx1VzaFoV5tGlXlYxfHGgLjk+DNC0cAD+8Zbnh70FS4zJtz5Fc0
 3CsEB2VATcCfQd+gv6/WC93FmVFN1F/of9J/1i4A+IkikSy5nkW1IMQTkDpy7/HnORI5T/QjA8Z
 VRe8+
X-Gm-Gg: ASbGncsMBRKP/LKuwMcVq+mWnoKly0b2agr5mWAS82iuggKUU7UuY4w4dkq7VtADfuz
 CgCK1+w8RkKrYzkwAflDdtPk84Zj9VeB2JzoycfOQPs5eloNa0xF+yjllVErj1LcGOSob75c7Wa
 Vzt/BMRXE7IdZ/JHEpfetK4CxpfUJ2bxqoUu23yBLR2dtv6yA5CZag3T9LmYfVJI5W/Vfoepse/
 mvSLWWYOwz/T0vrzrwp39Rm4Ko8w6Yt365iyBYb25H0AlDF5DrzEKFl3/DJADL+ZFsIues1CE1S
 CDJ7bOnYgHKhVacRjoMmTzr2y8fh3Lz8p5TbEKDpr0qo
X-Google-Smtp-Source: AGHT+IF+He+IxwgV7OCes13TbcKniAB+tWiGHWoLRuHjGty7yyFTaoPD+eq/weoYNio5ky9DUvfjxg==
X-Received: by 2002:adf:a39c:0:b0:391:4889:5045 with SMTP id
 ffacd0b85a97d-39973afa548mr1334951f8f.36.1742384512683; 
 Wed, 19 Mar 2025 04:41:52 -0700 (PDT)
Received: from localhost ([202.127.77.110]) by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-225c6bbe595sm112104575ad.171.2025.03.19.04.41.51
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 19 Mar 2025 04:41:52 -0700 (PDT)
To: ltp@lists.linux.it
Date: Wed, 19 Mar 2025 07:41:44 -0400
Message-Id: <20250319114144.24349-1-wegao@suse.com>
X-Mailer: git-send-email 2.35.3
In-Reply-To: <20250219082954.23552-1-wegao@suse.com>
References: <20250219082954.23552-1-wegao@suse.com>
MIME-Version: 1.0
X-Virus-Scanned: clamav-milter 1.0.3 at in-5.smtp.seeweb.it
X-Virus-Status: Clean
Subject: [LTP] [PATCH v3] mount_setattr02.c: Check mount_setattr attr
 propagation
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

Signed-off-by: Wei Gao <wegao@suse.com>
---
 runtest/syscalls                              |  1 +
 .../kernel/syscalls/mount_setattr/.gitignore  |  1 +
 .../syscalls/mount_setattr/mount_setattr02.c  | 99 +++++++++++++++++++
 3 files changed, 101 insertions(+)
 create mode 100644 testcases/kernel/syscalls/mount_setattr/mount_setattr02.c

diff --git a/runtest/syscalls b/runtest/syscalls
index 839c23d0a..60cbb66b7 100644
--- a/runtest/syscalls
+++ b/runtest/syscalls
@@ -858,6 +858,7 @@ mount06 mount06
 mount07 mount07
 
 mount_setattr01 mount_setattr01
+mount_setattr02 mount_setattr02
 
 move_mount01 move_mount01
 move_mount02 move_mount02
diff --git a/testcases/kernel/syscalls/mount_setattr/.gitignore b/testcases/kernel/syscalls/mount_setattr/.gitignore
index 52a77b9ca..1654f27de 100644
--- a/testcases/kernel/syscalls/mount_setattr/.gitignore
+++ b/testcases/kernel/syscalls/mount_setattr/.gitignore
@@ -1 +1,2 @@
 /mount_setattr01
+/mount_setattr02
diff --git a/testcases/kernel/syscalls/mount_setattr/mount_setattr02.c b/testcases/kernel/syscalls/mount_setattr/mount_setattr02.c
new file mode 100644
index 000000000..fcc088e3b
--- /dev/null
+++ b/testcases/kernel/syscalls/mount_setattr/mount_setattr02.c
@@ -0,0 +1,99 @@
+// SPDX-License-Identifier: GPL-2.0-or-later
+/*
+ * Copyright (C) 2025 SUSE LLC Wei Gao <wegao@suse.com>
+ */
+
+/*\
+ * Basic mount_setattr() test.
+ *
+ * Test basic propagation mount attributes are set correctly.
+ */
+
+#define _GNU_SOURCE
+
+#include <sys/statvfs.h>
+#include "tst_test.h"
+#include "lapi/fsmount.h"
+#include "tst_safe_stdio.h"
+
+static char *tmpdir;
+
+static int mounted;
+
+static bool is_shared_mount(const char *path)
+{
+	FILE *file = SAFE_FOPEN("/proc/self/mountinfo", "r");
+
+	char line[PATH_MAX];
+	bool found = false;
+
+	while (fgets(line, sizeof(line), file)) {
+		char mntpoint[PATH_MAX];
+		char opts[256];
+
+		if (sscanf(line, "%*d %*d %*d:%*d %*s %255s %*s %255s",
+					mntpoint, opts) != 2)
+			continue;
+
+		if (strcmp(mntpoint, path) != 0)
+			continue;
+
+		if (strstr(opts, "shared:") != NULL) {
+			found = true;
+			break;
+		}
+	}
+
+	fclose(file);
+	return found;
+}
+
+static void cleanup(void)
+{
+	if (mounted)
+		SAFE_UMOUNT(tmpdir);
+}
+
+static void setup(void)
+{
+	tmpdir = tst_tmpdir_path();
+	SAFE_UNSHARE(CLONE_NEWNS);
+	SAFE_MOUNT(NULL, "/", NULL, MS_REC | MS_PRIVATE, 0);
+	SAFE_MOUNT("testing", tmpdir, "tmpfs", MS_NOATIME | MS_NODEV, "");
+	mounted = 1;
+}
+
+static void run(void)
+{
+	struct mount_attr attr = {
+		.attr_set       = MOUNT_ATTR_RDONLY | MOUNT_ATTR_NOEXEC | MOUNT_ATTR_RELATIME,
+		.attr_clr       = MOUNT_ATTR__ATIME,
+	};
+
+	TST_EXP_PASS_SILENT(mount_setattr(-1, tmpdir, 0, &attr, sizeof(attr)));
+	TST_EXP_EQ_LI(is_shared_mount(tmpdir), 0);
+
+	attr.propagation = -1;
+	TST_EXP_FAIL_SILENT(mount_setattr(-1, tmpdir, 0, &attr, sizeof(attr)), EINVAL);
+	TST_EXP_EQ_LI(is_shared_mount(tmpdir), 0);
+
+	attr.propagation = MS_SHARED;
+	TST_EXP_PASS_SILENT(mount_setattr(-1, tmpdir, 0, &attr, sizeof(attr)));
+	TST_EXP_EQ_LI(is_shared_mount(tmpdir), 1);
+
+	attr.propagation = MS_PRIVATE;
+	TST_EXP_PASS_SILENT(mount_setattr(-1, tmpdir, 0, &attr, sizeof(attr)));
+	TST_EXP_EQ_LI(is_shared_mount(tmpdir), 0);
+
+	attr.propagation = MS_SLAVE;
+	TST_EXP_PASS_SILENT(mount_setattr(-1, tmpdir, 0, &attr, sizeof(attr)));
+	TST_EXP_EQ_LI(is_shared_mount(tmpdir), 0);
+}
+
+static struct tst_test test = {
+	.test_all = run,
+	.setup = setup,
+	.cleanup = cleanup,
+	.needs_root = 1,
+	.needs_tmpdir = 1,
+};
-- 
2.35.3


-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
