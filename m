Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7E355D6CFB1
	for <ltp@archiver.kernel.org>; Fri, 23 Jan 2026 02:37:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=lists.linux.it;
 i=@lists.linux.it; q=dns/txt; s=picard; t=1769135853; h=to : date :
 message-id : in-reply-to : references : mime-version : subject :
 list-id : list-unsubscribe : list-archive : list-post : list-help :
 list-subscribe : from : reply-to : content-type :
 content-transfer-encoding : sender : from;
 bh=+qYlVi/lU175ASo2Wd0lGoB6wzXW2+liMvsJRHoklPM=;
 b=ivQmvPaLpKIWWFgcQAyn4VfRQNb6jH9tfirEW8dox/vgt9OeLz6Ubgn/lvVdcGFem9o8+
 SNXm72N97HYroe8Nc0npo0jnTL4CmDudN5kjb1+9423Y4CFdf2Ur6gAwX4vaSf3jUmt19Vp
 y5haVQkMFeTNUSRe5WTRSrMs77jqYu4=
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 21F893CB3C9
	for <ltp@archiver.kernel.org>; Fri, 23 Jan 2026 03:37:33 +0100 (CET)
Received: from in-2.smtp.seeweb.it (in-2.smtp.seeweb.it
 [IPv6:2001:4b78:1:20::2])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 37D5A3CB0C4
 for <ltp@lists.linux.it>; Fri, 23 Jan 2026 03:36:42 +0100 (CET)
Received: from mail-wm1-x32b.google.com (mail-wm1-x32b.google.com
 [IPv6:2a00:1450:4864:20::32b])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-2.smtp.seeweb.it (Postfix) with ESMTPS id 9AC0E600B12
 for <ltp@lists.linux.it>; Fri, 23 Jan 2026 03:36:41 +0100 (CET)
Received: by mail-wm1-x32b.google.com with SMTP id
 5b1f17b1804b1-47ee937ecf2so14620915e9.0
 for <ltp@lists.linux.it>; Thu, 22 Jan 2026 18:36:41 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=suse.com; s=google; t=1769135801; x=1769740601; darn=lists.linux.it;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=nulWAq7hHYVJeGd5mFejx4LXbmMR6AexZFo/0q8ZBNI=;
 b=LnFrH6EgnD75/hliyWaJeQykna6jMQj/R1vhouylpi7BHOU4ILDjifbJoyQearHxKL
 eTReFpvaA+NxBWyuvbcQVS6p5zPfx49jkNLVhRw78mwU65Vi8HngGBOrQXC/Gsw/mt+C
 EW3nUmPAPYIQwpkXZirhPzg/zzJvCe6pItbe7Z2ViBDciNJbwh+EsvZERc6dHq+xXO2P
 YujD3S7UbwZIJ4aiwzrxPWCA+YppYLjugQF+yAjlGxdmw4yN2tcD25ntMUndFnFDNcko
 Y1a8zwBeYhuqglZ7Mv6ox01KlseheXMvXtH6G5Fjhi8wtRuDSU3/AyB6mluLJ7w4CVeM
 Ieog==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1769135801; x=1769740601;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=nulWAq7hHYVJeGd5mFejx4LXbmMR6AexZFo/0q8ZBNI=;
 b=f4iZp++ZcUmryVDKJXZM/NLmsNI4Z/RBlQG1Q0tdA7laJNCMe/9K5oexLGmSf8m2hg
 JCwuQ78UkRHepKsEwjEZGtu80hUHhHSiusi0D0QlC+6Alz5do8ruS+fSA34i9wBttJsa
 +pC/LXYZSXq3r57p9bedRLXg9SyrBogJ8pKMu1MTE+X5ns5yGti9+T3ktagVefY+GTpa
 Oj/P9/agslg8tZMaUntO+xjS4Ed/qMeJ+sdvzY5Nf/gREFeon0VAOtRTw/oWlDPhJKMu
 ID+7gsYRhfmMVMEFbrXueE3BVMYkKXOiUAFQjjkaeihncDUI6Nr8QccBmQ/nlJRSJ/gx
 GI2A==
X-Gm-Message-State: AOJu0YxezJzgV/9/Ffqp3/J1AGSrvMbZ4xOAAWNuNBiPgE5hIhIen+Tp
 2FlZHxz+CVx0Syfk5qStrjWIm0uNtERR8HhcamY3RhGUoSTrhD6TiFfS6QLrevNyU6z0w/0hBH6
 GEkw=
X-Gm-Gg: AZuq6aJEz2m7cuehnInQYhaJQv+lch2r9mTwqSiF+MxbZ+iupu00nNy5h5YnoseQaLN
 sM79yFkqhI3iJ9U1wo8lhvI80bI0QWY8/71xigHwDQdmP7hxjdUdHt56RGr2ZWBlfiK/45ypP/S
 di4eklneoY2+6cuuvSCfu6YmdOgdwsUtllW5BT1GvGS8MTuSktr/U4ObOxBYdDhr0KRsOwzEm7I
 IouXrxDCt5sJK1tGWxc+czPL3cEqyWWZ12JJ1b3xr9+BQ2oBJ26jeUf+vi6IaA25VTyBYa33WNE
 xOQJtyVwboCD20KsO7uCO2kqnf5AaqK8Nu1KVPJELQeL1AomQaDKYpOk81XoMhoO9STY42hpk2e
 CnjL4thgLawctO7YHehvRSBaYhsM0d2LpYcKo+ESIUFw5cP3kEMObs/JFIbjqKKz/6GipTev1WY
 s=
X-Received: by 2002:a05:600c:1d20:b0:477:a289:d854 with SMTP id
 5b1f17b1804b1-4804d2be737mr22353965e9.5.1769135800774; 
 Thu, 22 Jan 2026 18:36:40 -0800 (PST)
Received: from localhost ([2a07:de40:b240:0:2ad6:ed42:2ad6:ed42])
 by smtp.gmail.com with UTF8SMTPSA id
 5b1f17b1804b1-4804d8b4fc3sm21425635e9.13.2026.01.22.18.36.40
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 22 Jan 2026 18:36:40 -0800 (PST)
To: ltp@lists.linux.it
Date: Fri, 23 Jan 2026 02:36:26 +0000
Message-ID: <20260123023635.29692-2-wegao@suse.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260123023635.29692-1-wegao@suse.com>
References: <20251113015242.799-1-wegao@suse.com>
 <20260123023635.29692-1-wegao@suse.com>
MIME-Version: 1.0
X-Virus-Scanned: clamav-milter 1.0.9 at in-2.smtp.seeweb.it
X-Virus-Status: Clean
Subject: [LTP] [PATCH v5 1/3] tst_filesystems01.c: Add test for .filesystems
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
Reviewed-by: Petr Vorel <pvorel@suse.cz>
Reviewed-by: Li Wang <liwang@redhat.com>
---
 lib/newlib_tests/runtest.sh          |   1 +
 lib/newlib_tests/tst_filesystems01.c | 108 +++++++++++++++++++++++++++
 2 files changed, 109 insertions(+)
 create mode 100644 lib/newlib_tests/tst_filesystems01.c

diff --git a/lib/newlib_tests/runtest.sh b/lib/newlib_tests/runtest.sh
index d87751c2f..71808ef8b 100755
--- a/lib/newlib_tests/runtest.sh
+++ b/lib/newlib_tests/runtest.sh
@@ -24,6 +24,7 @@ tst_checkpoint_wait_timeout
 tst_checkpoint_wake_timeout
 tst_device
 tst_expiration_timer
+tst_filesystems01
 tst_fuzzy_sync0[1-3]
 tst_needs_cmds0[1-36-8]
 tst_res_hexd
diff --git a/lib/newlib_tests/tst_filesystems01.c b/lib/newlib_tests/tst_filesystems01.c
new file mode 100644
index 000000000..177ce1e33
--- /dev/null
+++ b/lib/newlib_tests/tst_filesystems01.c
@@ -0,0 +1,108 @@
+// SPDX-License-Identifier: GPL-2.0-or-later
+/*
+ * Copyright (c) 2025 Wei Gao <wegao@suse.com>
+ */
+
+#include "tst_test.h"
+#include "tst_safe_stdio.h"
+
+#define INODE_SIZE 128
+#define BLOCK_SIZE 1024
+#define MKFS_SIZE_VAL 10240
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
+
+	while (fgets(line, PATH_MAX, tune2fs) != NULL) {
+		if (strstr(line, "Inode size:") && strstr(line, str_size))
+			return 0;
+	}
+
+	pclose(tune2fs);
+	return -1;
+}
+
+static int check_mnt_data(char *opt)
+{
+	FILE *fp;
+	char line[PATH_MAX];
+
+	fp = SAFE_FOPEN("/proc/mounts", "r");
+
+	while (fgets(line, PATH_MAX, fp) != NULL) {
+		if (strstr(line, tst_device->dev) && strstr(line, opt))
+			return 0;
+	}
+	SAFE_FCLOSE(fp);
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
+
+	while (fgets(line, PATH_MAX, dumpe2fs) != NULL) {
+		if (strstr(line, "Block count:") && strstr(line, str_size))
+			return 0;
+	}
+
+	pclose(dumpe2fs);
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
+		TST_EXP_PASS((check_inode_size(INODE_SIZE)));
+		TST_EXP_PASS((check_mkfs_size_opt(MKFS_SIZE_VAL)));
+	}
+
+	if (fs_type == TST_XFS_MAGIC)
+		TST_EXP_PASS((check_mnt_data("usrquota")));
+}
+
+static struct tst_test test = {
+	.test_all = do_test,
+	.needs_root = 1,
+	.mntpoint = MOUNT_POINT,
+	.mount_device = 1,
+	.needs_cmds = (struct tst_cmd[]) {
+		{.cmd = "tune2fs"},
+		{.cmd = "dumpe2fs"},
+		{}
+	},
+	.filesystems = (struct tst_fs []) {
+		{
+			.type = "ext3",
+			.mkfs_opts = (const char *const []){"-I", TST_TO_STR(INODE_SIZE), "-b", TST_TO_STR(BLOCK_SIZE), NULL},
+			.mkfs_size_opt = TST_TO_STR(MKFS_SIZE_VAL),
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
2.52.0


-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
