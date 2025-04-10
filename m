Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 26D77C3601E
	for <ltp@archiver.kernel.org>; Thu, 10 Apr 2025 05:51:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=lists.linux.it;
 i=@lists.linux.it; q=dns/txt; s=picard; t=1744264281; h=to : date :
 message-id : in-reply-to : references : mime-version : subject :
 list-id : list-unsubscribe : list-archive : list-post : list-help :
 list-subscribe : from : reply-to : content-type :
 content-transfer-encoding : sender : from;
 bh=70cyJYrLqJPJQZAOX4eqX4DnORs1GqvUOBd0u1vu6fI=;
 b=P9x26Xn9pq2GyOV2yN+tKLakufKHzDBWE+YlDKhtdSXyOinl4EJQg4jhTeWysrgxiD8Q/
 fL5ABlwvL88x4vVpJ2M/o+mdpnM5PpUHYy2YmIbK/d5YhCLUXXZDZU0CewJxm17NGrLIrb9
 Z+XlcWjLiSPJENWe0nv6B/5tBnY6k+4=
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 91DA83CB44B
	for <ltp@archiver.kernel.org>; Thu, 10 Apr 2025 07:51:21 +0200 (CEST)
Received: from in-4.smtp.seeweb.it (in-4.smtp.seeweb.it
 [IPv6:2001:4b78:1:20::4])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id B4F563CB454
 for <ltp@lists.linux.it>; Thu, 10 Apr 2025 07:50:20 +0200 (CEST)
Received: from mail-wr1-x435.google.com (mail-wr1-x435.google.com
 [IPv6:2a00:1450:4864:20::435])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-4.smtp.seeweb.it (Postfix) with ESMTPS id EEA6110007C5
 for <ltp@lists.linux.it>; Thu, 10 Apr 2025 07:50:19 +0200 (CEST)
Received: by mail-wr1-x435.google.com with SMTP id
 ffacd0b85a97d-3914bc3e01aso130760f8f.2
 for <ltp@lists.linux.it>; Wed, 09 Apr 2025 22:50:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=suse.com; s=google; t=1744264219; x=1744869019; darn=lists.linux.it;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=uFY2mgdIn+dsrJNnlfTPyt/zoQxhghXZLHNkUswDRYU=;
 b=VYIVx4fc/qMOp1E/UsOop0wuFBhy4312c138RnZnekdILtaY9koyk1QcfzJCuvxPu6
 LBphedN3ukIYhAetMAnWyAKBZI7pmUCm+Wx4o2TnMOYu524oJ17DFadStn8gM7ytkseT
 VhBC3A7js8lMOCCor0YG96iyqIxuHa8O7cn9xPQnhON7Bq9606fgPthSmkOmh4BUy35W
 KEvKmVef/zZv6w5rFGr309/P/wGnQSfW+2FoAbEJVdwFPHMPv1FfET40cPEXEiHB0B9q
 6Gx+liSMg/6d2G3WA1j3MGf3LXOkwn/OHn2tgNCFKGgfpJmMds/4OevUDGcUYEnDf6/u
 XbmQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1744264219; x=1744869019;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=uFY2mgdIn+dsrJNnlfTPyt/zoQxhghXZLHNkUswDRYU=;
 b=Knp70Ckox0b8ZOFMozzgBNt4hi9VT9C8mQnGdb5/2XTxZ2rd+5sHA+lppS671Grw7h
 W4xs7s7CyV9VOhAkwRuEosXPHd4GhLTLyU1BtSuLxF+7RoJ7S8I+HfiMcCJ6ZNUn0StJ
 fP2400ZOaSg61J7Dsv62YYubddvakqeGiQA3Pbnf2qb6ju8q/uXDBwbSYrnuSllNpVTG
 rd/WQLHXutbhdpkxmtcwIXimmxVYWosepGJDJIf9l8WiypsXci8g3998hWOdpe21orkj
 mpyLWUFb4h5tCe4rBsuQRnkE6qMMvkXDkiEq2PX0PfMu9yfBLGd4jFr7IBuCBpVb1l/Q
 JbVw==
X-Gm-Message-State: AOJu0YysWJfB5tS5snZnt2+tiMTzTKItNgUVmK44VW+SxwmT6wJq1yeV
 74+ymcN3UgOwcyXB/H7vKCl0n1Z7QqgdHrytNwfZLtfKeqigxfschcPWLByPDTSgm2DeXRNKCim
 l5A==
X-Gm-Gg: ASbGncv0XaSFDLSav+IprXFhe6b6F6SQSlv2grTeRxsMJWTH1JPt2t1LCUu3eAxV22X
 xjsabwz05YimYnywx+YtPi7t2p+6RuQf5/RwjuJuuvU39RYSdxAiicOSSvmkyArnLf0wrKjDRnq
 pknvzL7vWbqFHp/f+gCUlUvEP4i6Ts/TYBEH41hXFDnkO3+IUlyZN7/ojZDXTGelAIjPvCcSnWo
 E4FB6xUTKzAZGIowQHkS7vMXXHqkMT5YLlNkY/UfFwGq0KvkokQqYQWkjMp+Qmq/LblB1pzNQFW
 8Iga8xPLrq6X+fwmfqx2Bw9kr6xWTA==
X-Google-Smtp-Source: AGHT+IFCdbyLdOufebihspygbXxwqwVNYsSM1VJy0jDwwn7sOYMyQKEDCmxbKX47c+HdI5/FRQvbTg==
X-Received: by 2002:a5d:5f47:0:b0:391:253b:405d with SMTP id
 ffacd0b85a97d-39d8fd8c45dmr830898f8f.41.1744264218712; 
 Wed, 09 Apr 2025 22:50:18 -0700 (PDT)
Received: from localhost ([202.127.77.110]) by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-22ac7cb52d8sm22053685ad.178.2025.04.09.22.50.17
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 09 Apr 2025 22:50:18 -0700 (PDT)
To: ltp@lists.linux.it
Date: Thu, 10 Apr 2025 01:49:56 -0400
Message-Id: <20250410054956.5071-3-wegao@suse.com>
X-Mailer: git-send-email 2.35.3
In-Reply-To: <20250410054956.5071-1-wegao@suse.com>
References: <20241212085058.29551-1-wegao@suse.com>
 <20250410054956.5071-1-wegao@suse.com>
MIME-Version: 1.0
X-Virus-Scanned: clamav-milter 1.0.3 at in-4.smtp.seeweb.it
X-Virus-Status: Clean
Subject: [LTP] [PATCH v6 2/2] ioctl_fiemap01: New test for fiemap ioctl()
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
Local test show EOPNOTSUPP on exfat/vfat/ntfs/tmpfs,
so descope related file system currently.

Signed-off-by: Wei Gao <wegao@suse.com>
---
 runtest/syscalls                              |   1 +
 testcases/kernel/syscalls/ioctl/.gitignore    |   1 +
 .../kernel/syscalls/ioctl/ioctl_fiemap01.c    | 119 ++++++++++++++++++
 3 files changed, 121 insertions(+)
 create mode 100644 testcases/kernel/syscalls/ioctl/ioctl_fiemap01.c

diff --git a/runtest/syscalls b/runtest/syscalls
index 77e3c942f..932b7030c 100644
--- a/runtest/syscalls
+++ b/runtest/syscalls
@@ -609,6 +609,7 @@ ioctl_ficlone02 ioctl_ficlone02
 ioctl_ficlone03 ioctl_ficlone03
 ioctl_ficlonerange01 ioctl_ficlonerange01
 ioctl_ficlonerange02 ioctl_ficlonerange02
+ioctl_fiemap01 ioctl_fiemap01
 
 inotify_init1_01 inotify_init1_01
 inotify_init1_02 inotify_init1_02
diff --git a/testcases/kernel/syscalls/ioctl/.gitignore b/testcases/kernel/syscalls/ioctl/.gitignore
index 1f099ff95..53a82bb57 100644
--- a/testcases/kernel/syscalls/ioctl/.gitignore
+++ b/testcases/kernel/syscalls/ioctl/.gitignore
@@ -28,3 +28,4 @@
 /ioctl_ficlone04
 /ioctl_ficlonerange01
 /ioctl_ficlonerange02
+/ioctl_fiemap01
diff --git a/testcases/kernel/syscalls/ioctl/ioctl_fiemap01.c b/testcases/kernel/syscalls/ioctl/ioctl_fiemap01.c
new file mode 100644
index 000000000..82f67adcf
--- /dev/null
+++ b/testcases/kernel/syscalls/ioctl/ioctl_fiemap01.c
@@ -0,0 +1,119 @@
+// SPDX-License-Identifier: GPL-2.0-or-later
+/*
+ * Copyright (c) 2023 Wei Gao <wegao@suse.com>
+ */
+
+/*\
+ * Verify basic fiemap ioctl functionality, including:
+ *
+ * - The ioctl returns EBADR if it receives invalid fm_flags.
+ * - 0 extents are reported for an empty file.
+ * - The ioctl correctly retrieves single and multiple extent mappings after writing to the file.
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
+static void check_extent(struct fiemap *fiemap, unsigned int fm_mapped_extents,
+						int index_extents, int fe_flags,
+						unsigned int min_fe_physical,
+						unsigned int fe_length)
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
+	fd = SAFE_OPEN(TESTFILE, O_RDWR | O_CREAT, 0644);
+
+	SAFE_STATVFS(".", &fs_info);
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
+		"Empty file should have 0 extends mapped");
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
+static void setup(void)
+{
+	SAFE_CHDIR(MNTPOINT);
+}
+
+static struct tst_test test = {
+	.setup = setup,
+	.mount_device = 1,
+	.mntpoint = MNTPOINT,
+	.all_filesystems = 1,
+	.skip_filesystems = (const char *const[]) {
+		"exfat", "vfat", "fuse", "ntfs", "tmpfs", NULL
+	},
+	.test_all = verify_ioctl,
+	.needs_root = 1,
+};
-- 
2.35.3


-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
