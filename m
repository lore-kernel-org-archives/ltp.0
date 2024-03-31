Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0E875C6FD1F
	for <ltp@archiver.kernel.org>; Sun, 31 Mar 2024 02:17:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=lists.linux.it;
 i=@lists.linux.it; q=dns/txt; s=picard; t=1711851474; h=to : date :
 message-id : in-reply-to : references : mime-version : subject :
 list-id : list-unsubscribe : list-archive : list-post : list-help :
 list-subscribe : from : reply-to : content-type :
 content-transfer-encoding : sender : from;
 bh=Xb8Wets/F9sz8ocsK6wds4y5hHV1UmtRhmV24XuzzoQ=;
 b=rCGDX6O2/Ym6ILT+pxt2NFHwXokwihySAuIT0FdlmhBkQA402ePnhxMGNmBkyL0WfF+kV
 a1iVtSJLium7L8+gt6YKrmQlP8dMMxRk0RrTkFJSsOdPXZMVZ1psc6ettqBUM1Rhnx2Ntzk
 9ItSAZ66YaiOJwsWrwyv1LWhC60Su5Q=
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 48B473C7612
	for <ltp@archiver.kernel.org>; Sun, 31 Mar 2024 04:17:54 +0200 (CEST)
Received: from in-6.smtp.seeweb.it (in-6.smtp.seeweb.it [217.194.8.6])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1) server-digest SHA384)
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 59F573C0185
 for <ltp@lists.linux.it>; Sun, 31 Mar 2024 04:17:30 +0200 (CEST)
Received: from mail-lj1-x235.google.com (mail-lj1-x235.google.com
 [IPv6:2a00:1450:4864:20::235])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-6.smtp.seeweb.it (Postfix) with ESMTPS id 379E31400FA3
 for <ltp@lists.linux.it>; Sun, 31 Mar 2024 04:17:30 +0200 (CEST)
Received: by mail-lj1-x235.google.com with SMTP id
 38308e7fff4ca-2d6fc3adaacso43944081fa.2
 for <ltp@lists.linux.it>; Sat, 30 Mar 2024 19:17:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=suse.com; s=google; t=1711851449; x=1712456249; darn=lists.linux.it;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=OsBGagSls3QtqUJ5Ug3i2mimZAyJA3slmybc43arygc=;
 b=aKNiqqvEeIWUeJ83kWl8cxc+sZ0u9Ik5UaxSrI8YXbBXJzv2A+fjhwETSpCKgxl82e
 4pfJ1G7zB4VjKkj7Yas/2ObtkZoCZGGo8+QB7Thr117wx+WZbWalPkqf34fou0+WgTPs
 a6tX3bKg9dKQA5IBTvCpFm5ApKJHzORbOonHQJt6tJX079E+4T9hMwmu3bZGrPNASma7
 0jbVj/DKTBfubt8fsPpprGA0mJdhIuDNtNPJ8F/gY2gN4JtNOZWZuQytWJrTB52b0DE1
 Y5YHLwV6KWkG+z4eZbHt9I20gCsvTggQEvOwKPpTdxHokrV3FSB/5VWyCtWIEYRwLNwY
 UUMw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1711851449; x=1712456249;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=OsBGagSls3QtqUJ5Ug3i2mimZAyJA3slmybc43arygc=;
 b=jvBJkfRB8YlPNzhaP5L/iwhWeLjwQXuN52tt1AO9UqKLAJANCLowCQcHcm+dIInuzj
 8+S16+zdnnbPk+9nwBMpcTRwfWhz36YpHf0QzK5opLm1fJJ/bXMyUXcOh4ZItnAkDgtb
 +CUIDa6h7s1VLaKOfjvQNwoCHn6bGp1EWUKNgUKswvivhand4w914yr4un5HRVCFPoYi
 J5dNF9bNqlI4G6YY4jmgiZbHIMMnBZc3TalUBHTvJG+qGhjDoocBCNC63hYDmiHcrsK7
 a5XaMhWZLW3NCiIlGHPHp1DM6ynWk0CajLdNyZtxgtwhYtMko4i/MQvt5TK8OEh9fZEA
 gdQQ==
X-Gm-Message-State: AOJu0YxpH5qcFU+kAy791kGly14PVj5ohuVi9ZTLda31uGsIjmMyybpM
 e8Tq/Oy0bo/ilW9gmEQ/JPA/WBZqWR4Xl2xGaT1Yw8WfNHo8p8EaLnrh9LGb8G8MQuDEw7Z8O+U
 =
X-Google-Smtp-Source: AGHT+IGBdalmTM6DEhD/43E6thxZm7ZCTUOz7w+Fn3XTuIY71URsVdrgmeTNWhpfkBdJ9ztuGo1DgQ==
X-Received: by 2002:a2e:9c82:0:b0:2d3:ba98:473 with SMTP id
 x2-20020a2e9c82000000b002d3ba980473mr3421813lji.19.1711851448730; 
 Sat, 30 Mar 2024 19:17:28 -0700 (PDT)
Received: from localhost ([223.72.39.109]) by smtp.gmail.com with ESMTPSA id
 h5-20020a056a00230500b006ead792b6f2sm5192551pfh.1.2024.03.30.19.17.27
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sat, 30 Mar 2024 19:17:28 -0700 (PDT)
To: ltp@lists.linux.it
Date: Sat, 30 Mar 2024 22:17:20 -0400
Message-Id: <20240331021720.9527-1-wegao@suse.com>
X-Mailer: git-send-email 2.35.3
In-Reply-To: <20240118073215.10026-1-wegao@suse.com>
References: <20240118073215.10026-1-wegao@suse.com>
MIME-Version: 1.0
X-Virus-Scanned: clamav-milter 1.0.3 at in-6.smtp.seeweb.it
X-Virus-Status: Clean
Subject: [LTP] [PATCH v3] ioctl_fiemap01: New test for fiemap ioctl()
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

Fixes: #535

Signed-off-by: Wei Gao <wegao@suse.com>
---
 runtest/syscalls                              |   2 +
 testcases/kernel/syscalls/ioctl/.gitignore    |   1 +
 .../kernel/syscalls/ioctl/ioctl_fiemap01.c    | 110 ++++++++++++++++++
 3 files changed, 113 insertions(+)
 create mode 100644 testcases/kernel/syscalls/ioctl/ioctl_fiemap01.c

diff --git a/runtest/syscalls b/runtest/syscalls
index 6e2407879..4e6ce5aef 100644
--- a/runtest/syscalls
+++ b/runtest/syscalls
@@ -589,6 +589,8 @@ ioctl_ns07 ioctl_ns07
 
 ioctl_sg01 ioctl_sg01
 
+ioctl_fiemap01 ioctl_fiemap01
+
 inotify_init1_01 inotify_init1_01
 inotify_init1_02 inotify_init1_02
 
diff --git a/testcases/kernel/syscalls/ioctl/.gitignore b/testcases/kernel/syscalls/ioctl/.gitignore
index 5fff7a61d..64adcdfe6 100644
--- a/testcases/kernel/syscalls/ioctl/.gitignore
+++ b/testcases/kernel/syscalls/ioctl/.gitignore
@@ -22,3 +22,4 @@
 /ioctl_ns06
 /ioctl_ns07
 /ioctl_sg01
+/ioctl_fiemap01
diff --git a/testcases/kernel/syscalls/ioctl/ioctl_fiemap01.c b/testcases/kernel/syscalls/ioctl/ioctl_fiemap01.c
new file mode 100644
index 000000000..b81842c6a
--- /dev/null
+++ b/testcases/kernel/syscalls/ioctl/ioctl_fiemap01.c
@@ -0,0 +1,110 @@
+// SPDX-License-Identifier: GPL-2.0-only
+/*
+ * Copyright (c) 2023 Wei Gao <wegao@suse.com>
+ */
+
+/*\
+ * [Description]
+ *
+ * Verify basic fiemap ioctl.
+ */
+
+#include <linux/fs.h>
+#include <linux/fiemap.h>
+#include <stdlib.h>
+#include <sys/statvfs.h>
+
+#include "tst_test.h"
+
+#define TMPDIR "mntdir"
+#define TESTFILE "testfile"
+#define NUM_EXTENT 3
+
+static void print_extens(struct fiemap *fiemap)
+{
+	tst_res(TDEBUG, "File extent count: %u", fiemap->fm_mapped_extents);
+
+	for (unsigned int i = 0; i < fiemap->fm_mapped_extents; ++i) {
+		tst_res(TDEBUG, "Extent %u: Logical offset: %llu, Physical offset: %llu, flags: %u, Length: %llu",
+				i + 1,
+				fiemap->fm_extents[i].fe_logical,
+				fiemap->fm_extents[i].fe_physical,
+				fiemap->fm_extents[i].fe_flags,
+				fiemap->fm_extents[i].fe_length);
+	}
+}
+
+static void check_extent(struct fiemap *fiemap, unsigned int fm_mapped_extents, int index_extents, int fe_flags, unsigned int min_fe_physical, unsigned int fe_length)
+{
+	TST_EXP_EXPR(fiemap->fm_mapped_extents == fm_mapped_extents,
+		"Check extent fm_mapped_extents is %d", fm_mapped_extents);
+	TST_EXP_EXPR(fiemap->fm_extents[index_extents].fe_flags & fe_flags,
+		"Check fe_flags is %d", fe_flags);
+	TST_EXP_EXPR(fiemap->fm_extents[index_extents].fe_physical >= min_fe_physical,
+		"Check fe_physical > %d", min_fe_physical);
+	TST_EXP_EXPR(fiemap->fm_extents[index_extents].fe_length == fe_length,
+		"Check fe_length is %d", fe_length);
+}
+
+static void verify_ioctl(void)
+{
+	int fd;
+	struct fiemap *fiemap;
+	struct statvfs fs_info;
+	unsigned long blk_size;
+
+	SAFE_CHDIR(TMPDIR);
+	fd = SAFE_OPEN(TESTFILE, O_RDWR | O_CREAT, 0644);
+
+	TST_EXP_PASS(statvfs(".", &fs_info));
+
+	blk_size = fs_info.f_bsize;
+
+	fiemap = SAFE_MALLOC(sizeof(struct fiemap) + sizeof(struct fiemap_extent) * NUM_EXTENT);
+	fiemap->fm_start = 0;
+	fiemap->fm_length = ~0ULL;
+	fiemap->fm_extent_count = 1;
+
+	fiemap->fm_flags =  -1;
+	TST_EXP_FAIL(ioctl(fd, FS_IOC_FIEMAP, fiemap), EBADR);
+
+	fiemap->fm_flags =  0;
+	TST_EXP_PASS(ioctl(fd, FS_IOC_FIEMAP, fiemap));
+	print_extens(fiemap);
+	TST_EXP_EXPR(fiemap->fm_mapped_extents == 0,
+		"Check extent fm_mapped_extents is 0");
+
+	char *buf = SAFE_MALLOC(blk_size);
+
+	SAFE_WRITE(SAFE_WRITE_ANY, fd, buf, blk_size);
+	fiemap->fm_flags = FIEMAP_FLAG_SYNC;
+	TST_EXP_PASS(ioctl(fd, FS_IOC_FIEMAP, fiemap));
+	print_extens(fiemap);
+	check_extent(fiemap, 1, 0, FIEMAP_EXTENT_LAST, 1, blk_size);
+
+	fiemap->fm_extent_count = NUM_EXTENT;
+	SAFE_LSEEK(fd, 2 * blk_size, SEEK_SET);
+	SAFE_WRITE(SAFE_WRITE_ALL, fd, buf, blk_size);
+	SAFE_LSEEK(fd, 4 * blk_size, SEEK_SET);
+	SAFE_WRITE(SAFE_WRITE_ALL, fd, buf, blk_size);
+	TST_EXP_PASS(ioctl(fd, FS_IOC_FIEMAP, fiemap));
+	print_extens(fiemap);
+	check_extent(fiemap, NUM_EXTENT, NUM_EXTENT - 1, FIEMAP_EXTENT_LAST, 1, blk_size);
+
+	free(buf);
+	free(fiemap);
+	SAFE_CLOSE(fd);
+	unlink(TESTFILE);
+}
+
+static struct tst_test test = {
+	.mount_device = 1,
+	.mntpoint = TMPDIR,
+	.all_filesystems = 1,
+	.skip_filesystems = (const char *const[]) {
+		"exfat", "vfat", "fuse", "ntfs", "tmpfs", NULL
+	},
+	.test_all = verify_ioctl,
+	.needs_root = 1,
+	.needs_tmpdir = 1,
+};
-- 
2.35.3


-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
