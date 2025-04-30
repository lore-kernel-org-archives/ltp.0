Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6F0AEC369D9
	for <ltp@archiver.kernel.org>; Wed, 30 Apr 2025 07:22:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=lists.linux.it;
 i=@lists.linux.it; q=dns/txt; s=picard; t=1745997765; h=to : date :
 message-id : mime-version : subject : list-id : list-unsubscribe :
 list-archive : list-post : list-help : list-subscribe : from :
 reply-to : content-type : content-transfer-encoding : sender : from;
 bh=A4eu5wVI6zh4YZoMhn5EM9xugE0gIkJo4mu+kUIWHgA=;
 b=eRIqcEjEZHypaME9mM6D91b1dsqCkJLBr/ZksxQe6bweGb4x3cap8ldCDdzSxXIAhKOMo
 cZLLsh6sMqFTkzTQqBP3BJukPMyzSk7nw6IFJ3YkeW5J6fSqmVIFYHsJ5z8SKylHOIZg4mQ
 AyEerisMjJ651kqh8FvieXr00sdLisw=
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 8EE2F3CBC5E
	for <ltp@archiver.kernel.org>; Wed, 30 Apr 2025 09:22:45 +0200 (CEST)
Received: from in-7.smtp.seeweb.it (in-7.smtp.seeweb.it
 [IPv6:2001:4b78:1:20::7])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 15F383CBB40
 for <ltp@lists.linux.it>; Wed, 30 Apr 2025 09:22:23 +0200 (CEST)
Received: from mail-wr1-x431.google.com (mail-wr1-x431.google.com
 [IPv6:2a00:1450:4864:20::431])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-7.smtp.seeweb.it (Postfix) with ESMTPS id DC294200921
 for <ltp@lists.linux.it>; Wed, 30 Apr 2025 09:22:22 +0200 (CEST)
Received: by mail-wr1-x431.google.com with SMTP id
 ffacd0b85a97d-39c1efc457bso5037170f8f.2
 for <ltp@lists.linux.it>; Wed, 30 Apr 2025 00:22:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=suse.com; s=google; t=1745997742; x=1746602542; darn=lists.linux.it;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to;
 bh=CErKNAdMkw53uS15obd84nSCFhx/ivCaC74W4128vR8=;
 b=a5WV6asCKTy6I/b5JiPGZFEi88lZFXLzbShcqWKNxHuA+OWm259JkwGdQopUV0A7YN
 34lX43rsdWsuBryLtW8CYHmARH14xDIfLYIaTKetVoJBWkpXp+Sh/aMpCot9znS74Lhu
 jJoFkLCb4z4/AadBHiwwKyBiEfl5fQg08A7jzaZUgBNZR1UexiQYNCmPOlaNNjVtlesi
 DQDxBZAKu/oFxhh/j8Dmawc6C5DSRRFQauIQ3hkUdVckVVWUtAEAHAHe6dHtl6aVwA//
 L0bEmVa/BGq0AX+9AEKZTP/jIuI+6Z0/6Yw7wmIGKygwiz2JXw0lt1Y/Bvj/1d09PvZ7
 zncg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1745997742; x=1746602542;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=CErKNAdMkw53uS15obd84nSCFhx/ivCaC74W4128vR8=;
 b=iV1WNNUg7hKWAkTCs1GhR9jBmat6BuTnB0AEg+9I2JDy2OWVHws1iGGo8+SvQImaU4
 2nx2IGm+YsTbu4RDArjcRFO6eu1j+ev3tKbCZE5KDQPlFK162+y9k4Q0rsB/GGk5LBK0
 woBhVOR+NFvGeywFr73OxNxf2RxAeWPgT4XylehX0r8RmYZUObTkBK4juQbpbHKgrdCR
 GfIjqQ+RpQfrBlbVXllcmKu5SHKhMpH9wlVJ/hZ9axaWE5//pq6/RUyMzzgw5Iyu5uMY
 LUmv3JaMB5ypzLlMoHFrnGeBbZMaA9FrDNYQUdLP2kim9lf8pgVmliWgPAvN62VTsT8q
 w0OQ==
X-Gm-Message-State: AOJu0Yy3pb+cn4RLJ4WGnBNEkWG8ouc0RiTtI53v/ZLEfwNhSi183i7c
 n3//uK1Q1KX8Ff2GK06sHLs8vMhahTBIoErh8xGe7skkPFFsP8gRWur7m03FLj+efflFpsFbx5l
 xBA==
X-Gm-Gg: ASbGncsiyjkWM37hEwDv8xit3HiT4SqZnVaEOW3KVonJsJRzCun6jmBHPEAecpqlsIm
 EzkUM6DDdMhEV2EuxoqkO+ei8yZw1+dZweSVcuKPF+0MU8o8ptIm3HflXb12A9j1cegSEDXekn+
 sd9cPMzisjslNVjmP0y8P/Sur2/XVUJXZdR9z4CgJvy9XvbvS3bJU5Gk/RcqVSVsriuDdnJJ2Z+
 2TqrR1c77W7YlZFOF03vFk7NywCqswspVsCvOyYpzomn4WGCrLFR20ZxMWXuAmO0mNDRoXK+mlY
 fwhPUnGAHwzCk+VgCVHyZKgJBPQ0BZuO/IGnMLq7
X-Google-Smtp-Source: AGHT+IEOooN9GMa2wd7d7yISUO2c0iWj/lejaYgRSqqmS4SjUaBEHMjnyrounJ7DVOoumqVIiZV/bw==
X-Received: by 2002:a05:6000:2284:b0:39a:ca04:3dff with SMTP id
 ffacd0b85a97d-3a08ff50af2mr1092543f8f.40.1745997741575; 
 Wed, 30 Apr 2025 00:22:21 -0700 (PDT)
Received: from localhost ([202.127.77.110])
 by smtp.gmail.com with UTF8SMTPSA id
 d9443c01a7336-22db4d77e66sm115557005ad.20.2025.04.30.00.22.20
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 30 Apr 2025 00:22:21 -0700 (PDT)
To: ltp@lists.linux.it
Date: Wed, 30 Apr 2025 15:22:04 -0400
Message-ID: <20250430192207.1089900-1-wegao@suse.com>
X-Mailer: git-send-email 2.49.0
MIME-Version: 1.0
X-Virus-Scanned: clamav-milter 1.0.7 at in-7.smtp.seeweb.it
X-Virus-Status: Clean
Subject: [LTP] [PATCH v1] fsconfig04.c: Use FSCONFIG_SET_FD set overlayfs
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
 runtest/syscalls                              |   1 +
 testcases/kernel/syscalls/fsconfig/.gitignore |   1 +
 .../kernel/syscalls/fsconfig/fsconfig04.c     | 132 ++++++++++++++++++
 3 files changed, 134 insertions(+)
 create mode 100644 testcases/kernel/syscalls/fsconfig/fsconfig04.c

diff --git a/runtest/syscalls b/runtest/syscalls
index e369536ea..658ab24c4 100644
--- a/runtest/syscalls
+++ b/runtest/syscalls
@@ -410,6 +410,7 @@ fremovexattr02 fremovexattr02
 fsconfig01 fsconfig01
 fsconfig02 fsconfig02
 fsconfig03 fsconfig03
+fsconfig04 fsconfig04
 
 fsmount01 fsmount01
 fsmount02 fsmount02
diff --git a/testcases/kernel/syscalls/fsconfig/.gitignore b/testcases/kernel/syscalls/fsconfig/.gitignore
index cfedae5f7..bd3754c34 100644
--- a/testcases/kernel/syscalls/fsconfig/.gitignore
+++ b/testcases/kernel/syscalls/fsconfig/.gitignore
@@ -1,3 +1,4 @@
 /fsconfig01
 /fsconfig02
 /fsconfig03
+/fsconfig04
diff --git a/testcases/kernel/syscalls/fsconfig/fsconfig04.c b/testcases/kernel/syscalls/fsconfig/fsconfig04.c
new file mode 100644
index 000000000..c77dc9e3a
--- /dev/null
+++ b/testcases/kernel/syscalls/fsconfig/fsconfig04.c
@@ -0,0 +1,132 @@
+// SPDX-License-Identifier: GPL-2.0-or-later
+/*
+ * Copyright (c) 2025 Wei Gao <wegao@suse.com>
+ *
+ * Basic fsconfig() test include use FSCONFIG_SET_FD set overlayfs
+ * Refer to selftests/filesystems/overlayfs/set_layers_via_fds.c
+ */
+
+#include "tst_test.h"
+#include "lapi/fsmount.h"
+#include "tst_safe_file_at.h"
+#include "tst_safe_stdio.h"
+
+#define MNTPOINT	"mntpoint"
+#define OVERLAYMNT	"set_layers_via_fds"
+
+static int fd, fd_context, fd_overlay;
+
+static void cleanup(void)
+{
+	if (fd != -1)
+		SAFE_CLOSE(fd);
+
+	if (fd_context != -1)
+		SAFE_CLOSE(fd_context);
+
+	if (fd_overlay != -1)
+		SAFE_CLOSE(fd_overlay);
+}
+
+static void run(void)
+{
+	int fsmfd;
+
+	fd = TST_EXP_FD(fsopen(tst_device->fs_type, 0));
+
+	TST_EXP_PASS(fsconfig(fd, FSCONFIG_SET_STRING, "source", tst_device->dev, 0));
+
+	TST_EXP_PASS(fsconfig(fd, FSCONFIG_CMD_CREATE, NULL, NULL, 0));
+
+	fsmfd = TST_EXP_FD(fsmount(fd, 0, 0));
+
+	TST_EXP_PASS(mkdirat(fsmfd, "w", 0755));
+	TST_EXP_PASS(mkdirat(fsmfd, "u", 0755));
+	TST_EXP_PASS(mkdirat(fsmfd, "l1", 0755));
+	TST_EXP_PASS(mkdirat(fsmfd, "l2", 0755));
+
+	int layer_fds[] = { [0 ... 3] = -EBADF };
+
+	layer_fds[0] = SAFE_OPENAT(fsmfd, "w", O_DIRECTORY);
+	layer_fds[1] = SAFE_OPENAT(fsmfd, "u", O_DIRECTORY);
+	layer_fds[2] = SAFE_OPENAT(fsmfd, "l1", O_DIRECTORY);
+	layer_fds[3] = SAFE_OPENAT(fsmfd, "l2", O_DIRECTORY);
+
+	TST_EXP_PASS(move_mount(fsmfd, "", AT_FDCWD, MNTPOINT,
+			MOVE_MOUNT_F_EMPTY_PATH));
+
+	SAFE_CLOSE(fsmfd);
+
+	fd_context = TST_EXP_FD(fsopen("overlay", 0));
+
+	TST_EXP_PASS(fsconfig(fd_context, FSCONFIG_SET_FD, "workdir", NULL, layer_fds[0]));
+	TST_EXP_PASS(fsconfig(fd_context, FSCONFIG_SET_FD, "upperdir", NULL, layer_fds[1]));
+	TST_EXP_PASS(fsconfig(fd_context, FSCONFIG_SET_FD, "lowerdir+", NULL, layer_fds[2]));
+	TST_EXP_PASS(fsconfig(fd_context, FSCONFIG_SET_FD, "lowerdir+", NULL, layer_fds[3]));
+
+	TST_EXP_PASS(fsconfig(fd_context, FSCONFIG_CMD_CREATE, NULL, NULL, 0));
+
+	SAFE_MKDIR(OVERLAYMNT, 0555);
+
+	fd_overlay = TST_EXP_FD(fsmount(fd_context, 0, 0));
+	SAFE_CLOSE(fd_context);
+
+	TST_EXP_PASS(move_mount(fd_overlay, "", AT_FDCWD, OVERLAYMNT,
+			MOVE_MOUNT_F_EMPTY_PATH));
+
+	char line[PATH_MAX];
+	FILE *file;
+	int ret = 0;
+	char workdir[PATH_MAX], upperdir[PATH_MAX], lowerdir1[PATH_MAX], lowerdir2[PATH_MAX];
+	char *tmpdir_path = tst_tmpdir_path();
+
+	sprintf(workdir, "workdir=%s/%s/w", tmpdir_path, MNTPOINT);
+	sprintf(upperdir, "upperdir=%s/%s/u", tmpdir_path, MNTPOINT);
+	sprintf(lowerdir1, "lowerdir+=%s/%s/l1", tmpdir_path, MNTPOINT);
+	sprintf(lowerdir2, "lowerdir+=%s/%s/l2", tmpdir_path, MNTPOINT);
+
+	file = SAFE_FOPEN("/proc/mounts", "r");
+	while (fgets(line, sizeof(line), file)) {
+		if (strstr(line, workdir) && strstr(line, upperdir)
+				&& strstr(line, lowerdir1) && strstr(line, lowerdir2)) {
+			ret = 1;
+			break;
+		}
+	}
+
+	if (ret == 1)
+		tst_res(TPASS, "overlay mount check pass");
+	else
+		tst_res(TFAIL, "overlay mount check failed");
+
+	TST_EXP_PASS_SILENT(system("ls -l"));
+
+	char rmcmd[PATH_MAX];
+
+	sprintf(rmcmd, "rm -r ./%s/*", MNTPOINT);
+	TST_EXP_PASS_SILENT(system(rmcmd));
+
+	SAFE_CLOSE(fd_overlay);
+	SAFE_UMOUNT(OVERLAYMNT);
+	SAFE_RMDIR(OVERLAYMNT);
+
+	SAFE_CLOSE(fd);
+
+	for (int i = 0; i < 4; i++)
+		SAFE_CLOSE(layer_fds[i]);
+
+	if (tst_is_mounted_at_tmpdir(MNTPOINT)) {
+		SAFE_UMOUNT(MNTPOINT);
+	}
+}
+
+static struct tst_test test = {
+	.test_all = run,
+	.setup = fsopen_supported_by_kernel,
+	.cleanup = cleanup,
+	.needs_root = 1,
+	.format_device = 1,
+	.mntpoint = MNTPOINT,
+	.all_filesystems = 1,
+	.skip_filesystems = (const char *const []){"ntfs", "vfat", "exfat", NULL},
+};
-- 
2.49.0


-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
