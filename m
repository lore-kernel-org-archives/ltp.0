Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 556B8C4345F
	for <ltp@archiver.kernel.org>; Mon, 15 Apr 2024 11:47:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=lists.linux.it;
 i=@lists.linux.it; q=dns/txt; s=picard; t=1713181642; h=to : date :
 message-id : in-reply-to : references : mime-version : subject :
 list-id : list-unsubscribe : list-archive : list-post : list-help :
 list-subscribe : from : reply-to : content-type :
 content-transfer-encoding : sender : from;
 bh=uePA90qwA55Tqq3l9ynFj+JYJOQtkixqosycTKzjLwY=;
 b=jTgv8AzkJtHFzn+WgV8Ykx/uGPsISUdlJnQ6YqkN9yG0uEZAs3MhmCbxi9j3FpWhUSemR
 bppuDQIzudzGqm2Pda4avjc5Ygwzv4Tlb4zHFZjlP2NFDw6xXfMn936gNrd/TZ9OlQrNIUG
 6wFGYkgtwDaLpL22ggMiadMZnenUBpM=
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 77EA53CF85D
	for <ltp@archiver.kernel.org>; Mon, 15 Apr 2024 13:47:22 +0200 (CEST)
Received: from in-7.smtp.seeweb.it (in-7.smtp.seeweb.it
 [IPv6:2001:4b78:1:20::7])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 16A913C0F50
 for <ltp@lists.linux.it>; Mon, 15 Apr 2024 13:46:59 +0200 (CEST)
Received: from mail-wr1-x436.google.com (mail-wr1-x436.google.com
 [IPv6:2a00:1450:4864:20::436])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-7.smtp.seeweb.it (Postfix) with ESMTPS id E1A1C200078
 for <ltp@lists.linux.it>; Mon, 15 Apr 2024 13:46:58 +0200 (CEST)
Received: by mail-wr1-x436.google.com with SMTP id
 ffacd0b85a97d-347aa00e3c8so539580f8f.1
 for <ltp@lists.linux.it>; Mon, 15 Apr 2024 04:46:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=suse.com; s=google; t=1713181618; x=1713786418; darn=lists.linux.it;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=I4cHY2MgGxQeeuKIVGIA5+kiQOnxg7UbLeogdmqhvKQ=;
 b=NxoafYNxbu2+6uWg+O4nLGBMwCCADRxw58GwivwSmSdc5Y41zH+4vD6B/3InOPitko
 aiyXOXr/SIBJwUCWat+Ye0UytqJNH/mlcyGtZw+TgjVKIaK6Gnz2SQVctR8wsYy3kWCH
 K2ymCLQVeVnibjVObnQxGQ8SWZ4s2j9ddlYoB4rmvDS/q+yuLZHR6uL4khbVFQzEgEmB
 dNqLEmzzQs6laPyiFg41Vd+FFW1CEblPruxlsYBvAbbZX2cobZlPuUDkZFjPoi6zBzdR
 v9h3G64Fboy2rznUQFD8mxUASgNng46JCc3tVqQYm47ZNhJ3Zq4B5a5obFMWbEf5BHZp
 u7tQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1713181618; x=1713786418;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=I4cHY2MgGxQeeuKIVGIA5+kiQOnxg7UbLeogdmqhvKQ=;
 b=Z3F/3Yh7ypL4On8yT8plC+ylqBjfimAzkV/zMLSQMNk0aQCxeg0Cp9xwTiopLGZ63w
 s04qSSbwC7kSOPGL4Q+junok1kWImb75dHWAghG2Fj4JtgFOtwtnxlsJmjesHq+AyQuD
 /qrCQyGXeCmU6QBStk0447hvl8NcIFJj56Xhnc6r20TyKdtpDGbuyZfQa4Nq5rWwbAtF
 D1bsMoAU8lSxSlonyGRobZdmDsyLZ51bO4gEbS1poER9zIPAz4ccwGZVToWf65dtdhjr
 llqIjdtEmIf6w1zA3qyRZst5fQMedaMlgNDi1t5Kx4CO0LxwBUlmXJnA5gtseCsglq73
 FpLQ==
X-Gm-Message-State: AOJu0Yxp4dQJV7GdnoqtiXK0ksF1ujpFPB8pfAlk7PGjs40Q2M+ji7Gj
 1xVsA/RG8EA9yKFc9kVTlxoa/ORu+ocg0EQ5C1h4cwJX/eCK7aBdyIxKtFXiE9+cBgVpwbGfja0
 =
X-Google-Smtp-Source: AGHT+IF3uzYBrM+eJjMDuSyZHc/zwaw3YwtUs1OnjitgAzPgd9L65+O775fBMtWWd0Gt2GA+0yh5cQ==
X-Received: by 2002:a05:6000:1952:b0:347:2b13:bb8 with SMTP id
 e18-20020a056000195200b003472b130bb8mr7356746wry.0.1713181617668; 
 Mon, 15 Apr 2024 04:46:57 -0700 (PDT)
Received: from localhost ([2a07:de40:b240:0:dc1a:df90:dc1a:df90])
 by smtp.gmail.com with ESMTPSA id
 j23-20020a05600c1c1700b0041880a0e8ecsm200111wms.43.2024.04.15.04.46.56
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 15 Apr 2024 04:46:57 -0700 (PDT)
To: ltp@lists.linux.it
Date: Mon, 15 Apr 2024 07:46:52 -0400
Message-Id: <20240415114652.22687-1-wegao@suse.com>
X-Mailer: git-send-email 2.35.3
In-Reply-To: <20240331021720.9527-1-wegao@suse.com>
References: <20240331021720.9527-1-wegao@suse.com>
MIME-Version: 1.0
X-Virus-Scanned: clamav-milter 1.0.3 at in-7.smtp.seeweb.it
X-Virus-Status: Clean
Subject: [LTP] [PATCH v4] ioctl_fiemap01: New test for fiemap ioctl()
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
index 000000000..1b3f80ed9
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
+#define MNTPOINT "mntpoint"
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
+	SAFE_CHDIR(MNTPOINT);
+	fd = SAFE_OPEN(TESTFILE, O_RDWR | O_CREAT, 0644);
+
+	if (statvfs(".", &fs_info) != 0)
+		tst_brk(TBROK, "statvfs failed");
+
+	blk_size = fs_info.f_bsize;
+
+	fiemap = SAFE_MALLOC(sizeof(struct fiemap) + sizeof(struct fiemap_extent) * NUM_EXTENT);
+	fiemap->fm_start = 0;
+	fiemap->fm_length = ~0ULL;
+	fiemap->fm_extent_count = 1;
+
+	fiemap->fm_flags = -1;
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
+	SAFE_UNLINK(TESTFILE);
+}
+
+static struct tst_test test = {
+	.mount_device = 1,
+	.mntpoint = MNTPOINT,
+	.all_filesystems = 1,
+	.skip_filesystems = (const char *const[]) {
+		"exfat", "vfat", "ntfs", "tmpfs", NULL
+	},
+	.test_all = verify_ioctl,
+	.needs_root = 1,
+};
-- 
2.35.3


-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
