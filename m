Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C5430E7717F
	for <ltp@archiver.kernel.org>; Thu, 12 Dec 2024 08:52:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=lists.linux.it;
 i=@lists.linux.it; q=dns/txt; s=picard; t=1733993536; h=to : date :
 message-id : in-reply-to : references : mime-version : subject :
 list-id : list-unsubscribe : list-archive : list-post : list-help :
 list-subscribe : from : reply-to : content-type :
 content-transfer-encoding : sender : from;
 bh=k9Exv1JgzLMLvhjFn/81QhbZunWaLCcBK5ofgILM2Uw=;
 b=OI9ZSYe6eYRkrqch2IVYXiW9FbUDaZ9y3MtCuNZ7jSeKOypXwI/7H7npkP29TdbApcn+O
 ev9UT1GPcu4aFxrLpw/AJDWWXFIJeJv10Df4fijJYJNlWhTAPQ9g7KsAFS55DaZQlsVZkBK
 PBeD3LYRr59mpf9vSL4BMwwqP4cTZGY=
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 36F163E7ADE
	for <ltp@archiver.kernel.org>; Thu, 12 Dec 2024 09:52:16 +0100 (CET)
Received: from in-7.smtp.seeweb.it (in-7.smtp.seeweb.it [217.194.8.7])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 158D63E7AE1
 for <ltp@lists.linux.it>; Thu, 12 Dec 2024 09:51:19 +0100 (CET)
Received: from mail-ed1-x52c.google.com (mail-ed1-x52c.google.com
 [IPv6:2a00:1450:4864:20::52c])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-7.smtp.seeweb.it (Postfix) with ESMTPS id 96AEA2451B3
 for <ltp@lists.linux.it>; Thu, 12 Dec 2024 09:51:18 +0100 (CET)
Received: by mail-ed1-x52c.google.com with SMTP id
 4fb4d7f45d1cf-5d3e8f64d5dso567341a12.3
 for <ltp@lists.linux.it>; Thu, 12 Dec 2024 00:51:18 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=suse.com; s=google; t=1733993478; x=1734598278; darn=lists.linux.it;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=PmaGe23MNy1Sy0Y/Ll65+K393EQATG3ZJcd6nAhY+ms=;
 b=RwQP4Y5zR624KpAeWX3GrvsHR7Z5ad58tz8pB3HIBfbZb13O5zlE4CZN3yjQ6r+EMA
 8pwIl09qn0D3w9tUbl9D6JE7IUzPRGwvrvcRe/Tf5PF6x1omK2OQ4n+CDK94VCAIIbm/
 6SKXEK/gKwJd7CQ3i2pUqXvjfxarMDsU6LzJQhwaOgO5PPqzDF5E1Rit2GUvxW0TDBNL
 iS1pOLlQF0YaQE6ZCigMpsGnguggSgM9WUfUud6PR88/rYFIZvNyT43mrEr2Z1TGV/7C
 eCwEHD6XKQIV5ZEnJqBtJTVFyE5qvVpFM8pgdu+mymtkAi2CVhP4boTZNdkMnTqaREBf
 f/eA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1733993478; x=1734598278;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=PmaGe23MNy1Sy0Y/Ll65+K393EQATG3ZJcd6nAhY+ms=;
 b=r+sdu/IleJNrRw8+5imL0B0DtsrIv7395fsfM0OSLNvngRiaIpyZAhda1mkytU5vH6
 4hCzHeof7hEzNdfHRHE9hivQ369Rq5J+yKqN+W0fwQTRScuuB6hl47aq+C8zfsRP8SKc
 nGNjH7FTz7Y9JvyzxO0qTRAIXmexqxzEcrHDXRLKIa6egXb1CNea3PPM65TiipPZbPI6
 ru2Ut9UjmD1dCdtSmxIpRhK8hjYl65M5HLOnAF1Ni+y3V/iTD1XrdU6tn09rFf7IuMFK
 t9mUNkmEe2lnxtFFqtdC3Cgvm5Tx6GnwU65wNUbBXbOVbeOn/V7FbvB7sxpwkFO6PqbO
 u0Gw==
X-Gm-Message-State: AOJu0YwmtC36incP6nmJS/k8eZ4H/hrfeQNKYyqCCIvx+VcQvmL/02PV
 W18sYk5/8q+0cOeFPC4kOCf+2haV6Kgw2bECYFjurI/kyf16tiubl96rslrZ+hLCosPv6lIee2Q
 =
X-Gm-Gg: ASbGnctRX4rbMmB4Af+Jg1d9LIKOt+K5QwAEwtaWmy5Ei1wks9K6fQIT7as1yRkOwmW
 rhq4RSv4zhcmbfzaHUdTYFDAaGbM1kyICAWZr92Lc8L/lEL0Hek89xDoS2MLG6x2D6W/gV+e6ps
 BKOxW78zxSc+NsYX3gv5WFHeNX0UylaB844TYXOcrd4QoVbgfAuIYnPEftBKVE7XlTKQ0OHeOpL
 fvup6tfIrDIkGkDV36Vuh+/3W4w3xTwRVY/M0nOPLzxjw==
X-Google-Smtp-Source: AGHT+IG726wpSDwYG/d8ytrsPevd/ixSs1bpgILOpmyPDu4pFrSrpfUfYQIo+blNVhaMGhnHOGB+jw==
X-Received: by 2002:a05:6402:3205:b0:5d3:bc56:3b24 with SMTP id
 4fb4d7f45d1cf-5d4e8f65494mr299940a12.4.1733993477807; 
 Thu, 12 Dec 2024 00:51:17 -0800 (PST)
Received: from localhost ([202.127.77.110]) by smtp.gmail.com with ESMTPSA id
 4fb4d7f45d1cf-5d3d2e95b3csm8125741a12.21.2024.12.12.00.51.16
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 12 Dec 2024 00:51:17 -0800 (PST)
To: ltp@lists.linux.it
Date: Thu, 12 Dec 2024 03:50:58 -0500
Message-Id: <20241212085058.29551-3-wegao@suse.com>
X-Mailer: git-send-email 2.35.3
In-Reply-To: <20241212085058.29551-1-wegao@suse.com>
References: <20240415114652.22687-1-wegao@suse.com>
 <20241212085058.29551-1-wegao@suse.com>
MIME-Version: 1.0
X-Virus-Scanned: clamav-milter 1.0.3 at in-7.smtp.seeweb.it
X-Virus-Status: Clean
Subject: [LTP] [PATCH v5 2/2] ioctl_fiemap01: New test for fiemap ioctl()
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
 .../kernel/syscalls/ioctl/ioctl_fiemap01.c    | 122 ++++++++++++++++++
 3 files changed, 125 insertions(+)
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
index 000000000..61b3f1062
--- /dev/null
+++ b/testcases/kernel/syscalls/ioctl/ioctl_fiemap01.c
@@ -0,0 +1,122 @@
+// SPDX-License-Identifier: GPL-2.0-only
+/*
+ * Copyright (c) 2023 Wei Gao <wegao@suse.com>
+ */
+
+/*\
+ * [Description]
+ *
+ * Verify basic fiemap ioctl functionality, including:
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
+	int fd, ret;
+	struct fiemap *fiemap;
+	struct statvfs fs_info;
+	unsigned long blk_size;
+
+	SAFE_CHDIR(MNTPOINT);
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
+	fiemap->fm_flags = FIEMAP_FLAG_XATTR;
+
+	ret = ioctl(fd, FS_IOC_FIEMAP, fiemap);
+	if (ret == -1) {
+		if (errno == ENOTTY)
+			tst_res(TCONF, "ioctl(FS_IOC_FIEMAP) not implemented");
+	}
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
